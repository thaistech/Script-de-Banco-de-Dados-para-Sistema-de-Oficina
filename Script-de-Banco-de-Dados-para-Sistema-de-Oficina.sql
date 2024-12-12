-- Criação do Banco de Dados
CREATE DATABASE oficina_mecanica;
USE oficina_mecanica;

-- Tabela Clientes
CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY, -- PK, auto incremento
    nome VARCHAR(255) NOT NULL,                -- NOT NULL
    endereco VARCHAR(255),
    telefone VARCHAR(20),
    email VARCHAR(255) UNIQUE                  -- UNIQUE
);

-- Tabela Veículos
CREATE TABLE veiculos (
    id_veiculo INT AUTO_INCREMENT PRIMARY KEY,  -- PK, auto incremento
    placa VARCHAR(10) NOT NULL UNIQUE,          -- UNIQUE e NOT NULL
    modelo VARCHAR(100),
    marca VARCHAR(100),
    ano INT,
    id_cliente INT,                             -- FK
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente) ON DELETE CASCADE  -- FK, ON DELETE CASCADE
);

-- Tabela Mecânicos
CREATE TABLE mecanicos (
    id_mecanico INT AUTO_INCREMENT PRIMARY KEY,  -- PK, auto incremento
    nome VARCHAR(255) NOT NULL,                  -- NOT NULL
    endereco VARCHAR(255),
    especialidade VARCHAR(100)
);

-- Tabela Equipes
CREATE TABLE equipes (
    id_equipe INT AUTO_INCREMENT PRIMARY KEY,    -- PK, auto incremento
    nome VARCHAR(100) NOT NULL                   -- NOT NULL
);

-- Tabela Ordens de Serviço
CREATE TABLE ordens_servico (
    id_os INT AUTO_INCREMENT PRIMARY KEY,        -- PK, auto incremento
    numero_os VARCHAR(20) NOT NULL UNIQUE,        -- UNIQUE e NOT NULL
    data_emissao DATE NOT NULL,                   -- NOT NULL
    valor_total DECIMAL(10,2),
    status_serviços ENUM('Aberta', 'Concluída', 'Cancelada') NOT NULL,  -- NOT NULL com valores possíveis
    data_conclusao DATE,
    id_cliente INT,                               -- FK
    id_veiculo INT,                               -- FK
    id_equipe INT,                                -- FK
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente) ON DELETE CASCADE, -- FK
    FOREIGN KEY (id_veiculo) REFERENCES veiculos(id_veiculo) ON DELETE CASCADE, -- FK
    FOREIGN KEY (id_equipe) REFERENCES equipes(id_equipe) ON DELETE SET NULL -- FK
);

-- Tabela Serviços
CREATE TABLE servicos (
    id_servico INT AUTO_INCREMENT PRIMARY KEY,    -- PK, auto incremento
    descricao VARCHAR(255) NOT NULL,               -- NOT NULL
    valor_unitario DECIMAL(10,2) NOT NULL          -- NOT NULL
);

-- Tabela Peças
CREATE TABLE pecas (
    id_peca INT AUTO_INCREMENT PRIMARY KEY,       -- PK, auto incremento
    descricao VARCHAR(255) NOT NULL,               -- NOT NULL
    valor_unitario DECIMAL(10,2) NOT NULL          -- NOT NULL
);

-- Tabela ordem_servico_servicos (Relacionamento N:M entre Ordens de Serviço e Serviços)
CREATE TABLE ordem_servico_servicos (
    id_os INT,                                    -- FK
    id_servico INT,                               -- FK
    quantidade INT NOT NULL DEFAULT 1,             -- NOT NULL, valor default 1
    valor_total DECIMAL(10,2),                    -- Cálculo do valor total
    PRIMARY KEY (id_os, id_servico),              -- PK composta
    FOREIGN KEY (id_os) REFERENCES ordens_servico(id_os) ON DELETE CASCADE, -- FK
    FOREIGN KEY (id_servico) REFERENCES servicos(id_servico) ON DELETE CASCADE  -- FK
);

-- Tabela ordem_servico_pecas (Relacionamento N:M entre Ordens de Serviço e Peças)
CREATE TABLE ordem_servico_pecas (
    id_os INT,                                    -- FK
    id_peca INT,                                  -- FK
    quantidade INT NOT NULL DEFAULT 1,             -- NOT NULL, valor default 1
    valor_total DECIMAL(10,2),                    -- Cálculo do valor total
    PRIMARY KEY (id_os, id_peca),                 -- PK composta
    FOREIGN KEY (id_os) REFERENCES ordens_servico(id_os) ON DELETE CASCADE, -- FK
    FOREIGN KEY (id_peca) REFERENCES pecas(id_peca) ON DELETE CASCADE  -- FK
);

-- Tabela mecânicos_equipes (Relacionamento N:M entre Mecânicos e Equipes)
CREATE TABLE mecanicos_equipes (
    id_mecanico INT,                              -- FK
    id_equipe INT,                                -- FK
    PRIMARY KEY (id_mecanico, id_equipe),         -- PK composta
    FOREIGN KEY (id_mecanico) REFERENCES mecanicos(id_mecanico) ON DELETE CASCADE, -- FK
    FOREIGN KEY (id_equipe) REFERENCES equipes(id_equipe) ON DELETE CASCADE  -- FK
);

-- fim do script


-- Inserir dados na tabela Clientes
INSERT INTO clientes (nome, endereco, telefone, email) VALUES
('João Silva', 'Rua A, 123', '(11) 98765-4321', 'joao.silva@email.com'),
('Maria Oliveira', 'Av. B, 456', '(21) 91234-5678', 'maria.oliveira@email.com'),
('Carlos Pereira', 'Rua C, 789', '(31) 94567-8901', 'carlos.pereira@email.com');

-- Inserir dados na tabela Veículos
INSERT INTO veiculos (placa, modelo, marca, ano, id_cliente) VALUES
('ABC1234', 'Fusca', 'Volkswagen', 1978, 1),
('DEF5678', 'Civic', 'Honda', 2020, 2),
('GHI9876', 'Corolla', 'Toyota', 2018, 3);

-- Inserir dados na tabela Mecânicos
INSERT INTO mecanicos (nome, endereco, especialidade) VALUES
('José Almeida', 'Rua D, 101', 'Motorista'),
('Ana Costa', 'Av. E, 202', 'Suspensão'),
('Luiz Souza', 'Rua F, 303', 'Elétrica');

-- Inserir dados na tabela Equipes
INSERT INTO equipes (nome) VALUES
('Equipe 1 - Motorista'),
('Equipe 2 - Suspensão'),
('Equipe 3 - Elétrica');

-- Inserir dados na tabela Ordens de Serviço (OS)
INSERT INTO ordens_servico (numero_os, data_emissao, valor_total, status_servicos, data_conclusao, id_cliente, id_veiculo, id_equipe) VALUES
('OS1001', '2024-12-01', 350.75, 'Aberta', NULL, 1, 1, 1),
('OS1002', '2024-12-02', 500.20, 'Aberta', NULL, 2, 2, 2),
('OS1003', '2024-12-03', 1200.40, 'Aberta', NULL, 3, 3, 3);

-- Inserir dados na tabela Serviços
INSERT INTO servicos (descricao, valor_unitario) VALUES
('Troca de óleo', 50.00),
('Alinhamento de direção', 120.00),
('Troca de bateria', 200.00);

-- Inserir dados na tabela Peças
INSERT INTO pecas (descricao, valor_unitario) VALUES
('Óleo 5W30', 35.00),
('Pneu Aro 15', 150.00),
('Bateria 60Ah', 180.00);

-- Inserir dados na tabela ordem_servico_servicos (Relacionamento entre Ordens de Serviço e Serviços)
INSERT INTO ordem_servico_servicos (id_os, id_servico, quantidade, valor_total) VALUES
(1, 1, 1, 50.00),  -- OS1001 com serviço Troca de óleo
(2, 2, 1, 120.00), -- OS1002 com serviço Alinhamento de direção
(3, 3, 1, 200.00); -- OS1003 com serviço Troca de bateria

-- Inserir dados na tabela ordem_servico_pecas (Relacionamento entre Ordens de Serviço e Peças)
INSERT INTO ordem_servico_pecas (id_os, id_peca, quantidade, valor_total) VALUES
(1, 1, 2, 70.00),  -- OS1001 com peça Óleo 5W30
(2, 2, 4, 600.00), -- OS1002 com peça Pneu Aro 15
(3, 3, 1, 180.00); -- OS1003 com peça Bateria 60Ah

-- Inserir dados na tabela mecanicos_equipes (Relacionamento entre Mecânicos e Equipes)
INSERT INTO mecanicos_equipes (id_mecanico, id_equipe) VALUES
(1, 1),  -- José Almeida na Equipe 1 - Motor
(2, 2),  -- Ana Costa na Equipe 2 - Suspensão
(3, 3);  -- Luiz Souza na Equipe 3 - Elétrica

-- Recuperações simples com SELECT Statement
-- Recupera todos os dados da tabela clientes
SELECT * FROM clientes;


-- Filtros com WHERE Statement
-- Recupera os dados dos clientes cujo nome é "João Silva"
SELECT * FROM clientes WHERE nome = 'João Silva';

-- Recupera os dados dos veículos fabricados a partir do ano de 2018
SELECT * FROM veiculos WHERE ano >= 2018;


-- Criação de expressões para gerar atributos derivados
-- Calcula o valor total dos serviços por ordem de serviço
SELECT 
    oss.id_os,
    s.descricao AS servico,
    oss.quantidade,
    oss.valor_total,
    oss.quantidade * oss.valor_total AS total_servicos
FROM ordem_servico_servicos oss
JOIN servicos s ON oss.id_servico = s.id_servico;


-- Definir ordenações dos dados com ORDER BY
-- Recupera os dados dos clientes e ordena pelo nome de forma crescente
SELECT * FROM clientes
ORDER BY nome ASC;

-- Recupera as ordens de serviço e ordena pelo valor total de forma decrescente
SELECT * FROM ordens_servico
ORDER BY valor_total DESC;


-- Condições de filtros aos grupos – HAVING Statement
-- Agrupa as ordens de serviço por status_servicos e exibe apenas aqueles com valor total > 500
SELECT status_servicos, COUNT(id_os) AS quantidade_os, SUM(valor_total) AS total_valor
FROM ordens_servico
GROUP BY status_servicos
HAVING SUM(valor_total) > 500;

-- Criação de junções entre tabelas para fornecer uma perspectiva mais complexa dos dados
-- Recupera os clientes e os veículos associados a eles
SELECT c.nome AS cliente, v.modelo AS veiculo, v.placa
FROM clientes c
JOIN veiculos v ON c.id_cliente = v.id_cliente;

-- Recupera as ordens de serviço e os serviços realizados
SELECT o.numero_os, o.data_emissao, s.descricao AS servico, oss.quantidade, oss.valor_total
FROM ordens_servico o
JOIN ordem_servico_servicos oss ON o.id_os = oss.id_os
JOIN servicos s ON oss.id_servico = s.id_servico;

-- Recupera ordens de serviço, peças e os clientes associados
SELECT o.numero_os, o.data_emissao, p.descricao AS peca, osp.quantidade, osp.valor_total, c.nome AS cliente
FROM ordens_servico o
JOIN ordem_servico_pecas osp ON o.id_os = osp.id_os
JOIN pecas p ON osp.id_peca = p.id_peca
JOIN clientes c ON o.id_cliente = c.id_cliente;

-- Recupera os mecânicos e as equipes às quais pertencem
SELECT m.nome AS mecanico, e.nome AS equipe
FROM mecanicos m
JOIN mecanicos_equipes me ON m.id_mecanico = me.id_mecanico
JOIN equipes e ON me.id_equipe = e.id_equipe;

-- Recupera os clientes, seus veículos e as ordens de serviço associadas
SELECT c.nome AS cliente, v.modelo AS veiculo, o.numero_os, o.data_emissao, o.status_servicos
FROM clientes c
JOIN veiculos v ON c.id_cliente = v.id_cliente
JOIN ordens_servico o ON v.id_veiculo = o.id_veiculo
WHERE c.nome = 'João Silva';  -- Filtra pelo cliente João Silva