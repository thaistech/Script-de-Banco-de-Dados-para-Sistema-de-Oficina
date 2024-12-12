## 📚 Banco de Dados para Oficina Mecânica

Este repositório contém um script SQL para a criação de um banco de dados de uma **oficina mecânica**. O banco de dados foi projetado para gerenciar clientes, veículos, ordens de serviço, mecânicos, equipes e serviços, com a finalidade de facilitar a gestão da oficina.

## 🔑 Entidades Principais

O diagrama de relacionamento abrange as seguintes entidades:

- **Cliente**: Representa os clientes da oficina, contendo informações como nome, endereço, telefone e email.
- **Veículo**: Contém os veículos dos clientes, com dados como placa, modelo, marca, ano e o cliente ao qual o veículo pertence.
- **Mecânico**: Representa os mecânicos que trabalham na oficina, com dados como nome, endereço e especialidade.
- **Equipe**: Define as equipes de mecânicos responsáveis pela execução dos serviços nas ordens de serviço.
- **Ordem de Serviço (OS)**: Contém as ordens de serviço abertas para consertos ou revisões dos veículos dos clientes.
- **Serviço**: Representa os serviços realizados na oficina, como troca de óleo, alinhamento, entre outros.
- **Peça**: Contém as peças utilizadas nos serviços executados nas ordens de serviço.

## 🔄 Relacionamentos no Banco de Dados

O modelo de dados define os seguintes relacionamentos:

### Relacionamentos N:M (Muitos para Muitos):

- **Ordens de Serviço (OS) → Serviços**: Uma ordem de serviço pode ter vários serviços e um serviço pode ser parte de várias ordens de serviço. Esse relacionamento é mediado pela tabela de junção `ordem_servico_servicos`.
- **Ordens de Serviço (OS) → Peças**: Uma ordem de serviço pode ter várias peças e uma peça pode ser usada em várias ordens de serviço. Esse relacionamento é mediado pela tabela de junção `ordem_servico_pecas`.
- **Mecânicos → Equipes**: Um mecânico pode fazer parte de várias equipes, e uma equipe pode ter vários mecânicos. Esse relacionamento é mediado pela tabela de junção `mecanicos_equipes`.

### Relacionamentos 1:N (Um para Muitos):

- **Clientes → Veículos**: Um cliente pode ter vários veículos.
- **Ordens de Serviço (OS) → Equipes**: Cada ordem de serviço é associada a uma equipe responsável pela execução dos serviços.
- **Veículos → Ordens de Serviço (OS)**: Um veículo pode ter várias ordens de serviço associadas.

## 📊 Estrutura do Banco de Dados

Cada tabela foi projetada para representar uma entidade do sistema, com as seguintes características:

- **Chaves Primárias (PK)**: Cada tabela contém uma chave primária para garantir a unicidade dos registros.
- **Chaves Estrangeiras (FK)**: As chaves estrangeiras são usadas para garantir a integridade referencial entre as tabelas.
- **Tabelas de Junção**: Foram criadas tabelas de junção para os relacionamentos muitos-para-muitos, como `ordem_servico_servicos`, `ordem_servico_pecas` e `mecanicos_equipes`.

### Tabelas Criadas:

- **Cliente**: Representa os dados dos clientes da oficina (PF ou PJ).
- **Veículo**: Contém os dados dos veículos dos clientes.
- **Mecânico**: Representa os dados dos mecânicos da oficina.
- **Equipe**: Representa as equipes de mecânicos.
- **Ordem de Serviço (OS)**: Registra as ordens de serviço para os veículos dos clientes.
- **Serviço**: Contém os serviços realizados pela oficina, como troca de óleo, alinhamento, etc.
- **Peça**: Representa as peças utilizadas para os serviços.
- **ordem_servico_servicos**: Tabela de junção entre ordens de serviço e serviços.
- **ordem_servico_pecas**: Tabela de junção entre ordens de serviço e peças.
- **mecanicos_equipes**: Tabela de junção entre mecânicos e equipes.

## 📈 Diagrama de Entidade-Relacionamento (ER)

O diagrama ER foi criado no **MySQL Workbench** e ilustra todos os relacionamentos e a estrutura do banco de dados. Você pode visualizar e editar o diagrama diretamente no MySQL Workbench após importar o arquivo.

## ⚙️ Tecnologias Utilizadas

- **MySQL**: Para o banco de dados relacional.
- **MySQL Workbench**: Para a modelagem do banco de dados e criação do diagrama ER.

## 📥 Como Usar

### 1. Clonar o Repositório

Clone o repositório para o seu ambiente local:
git clone https://github.com/usuario/repositorio.git
