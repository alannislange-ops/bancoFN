CREATE USER 'Alannis'@'localhost' IDENTIFIED BY'senha123';
select * from mysql.user;
CREATE USER 'teste2'@'localhost' IDENTIFIED BY'';
SELECT host,user
FROM mysql.user;
DROP USER'teste2'@'localhost';

flush PRIVILEGES;

--entrei no meu user

CREATE table amodb (
    id_amor int PRIMARY KEY AUTO_INCREMENT
);

insert into amodb (id_amor) VALUES
(7),
(314);
SELECT * FROM amodb;

UPDATE amodb 
set id_amor = 67
where id_amor = 7;

delete from amodb
where id_amor = 1;

show GRANTs;

GRANT DELETE, DROP, RELOAD, SHUTDOWN, PROCESS, FILE, REFERENCES,
INDEX, ALTER, SHOW DATABASES, SUPER,
CREATE TEMPORARY TABLES, LOCK TABLES,
EXECUTE, REPLICATION SLAVE, REPLICATION CLIENT,
CREATE VIEW, SHOW VIEW, CREATE ROUTINE,
ALTER ROUTINE, CREATE USER, EVENT,
TRIGGER, CREATE TABLESPACE
ON *.* TO 'Alannis'@'localhost';

CREATE DATABASE industria;
use industria;
CREATE TABLE FUNCIONARIO (
    id_funcionario INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cargo VARCHAR(50) NOT NULL,
    setor VARCHAR(50) NOT NULL,
    data_admissao DATE NOT NULL,
    salario DECIMAL(10, 2) NOT NULL,
    email VARCHAR(100) UNIQUE,
    telefone VARCHAR(15),
    cidade VARCHAR(50),
    estado CHAR(2),
    status_funcionario VARCHAR(15) DEFAULT 'Ativo',
    CONSTRAINT pk_funcionario PRIMARY KEY (id_funcionario)
);

INSERT INTO FUNCIONARIO (nome, cargo, setor, data_admissao, salario, email, telefone, cidade, estado, status_funcionario)
VALUES 
('Carlos', 'Operador de Máquinas', 'Produção', '2023-03-15', 2800.00, 'carlos.silva@industria.com', '(11) 99999-1111', 'Sorocaba', 'SP', 'Ativo'),
('Ana', 'Gerente de Qualidade', 'Qualidade', '2021-06-10', 7500.00, 'ana.souza@industria.com', '(11) 99999-2222', 'Indaiatuba', 'SP', 'Ativo'),
('Marcos', 'Analista de Logística', 'Logística', '2024-01-20', 4200.00, 'marcos.lima@industria.com', '(21) 98888-3333', 'Resende', 'RJ', 'Ativo'),
('Juliana', 'Engenheira de Automação', 'Manutenção', '2020-11-05', 8900.00, 'juliana.costa@industria.com', '(31) 97777-4444', 'Contagem', 'MG', 'Ativo'),
('Roberto', 'Auxiliar de Produção', 'Produção', '2022-05-12', 2100.00, 'roberto.alves@industria.com', '(11) 99999-5555', 'Sorocaba', 'SP', 'Inativo');

create view view_resumo as
select nome, cargo, setor
from funcionario;

select * FROM view_resumo;

select * FROM view_resumo where setor like "%Pro%";

select * FROM view_resumo where cargo like "%gerente%";


--CodigoOS	   DataOS	    Cliente	        TelefoneCliente	    CidadeCliente	Equipamento         	CategoriaEquipamento	Tecnico	        CargoTecnico	            TelefoneTecnico	    FornecedorPeca	    CidadeFornecedor	PecaUtilizada	QuantidadePeca	ValorPeca
--1001	    10/03/2025	    MetalSul	    (51)99999-1111	    Porto Alegre	Prensa Hidráulica	    Prensas	                João Silva	    Técnico Mecânico	        (51)98888-1111	    Industrial Parts	Caxias do Sul	    Rolamento A	     2	            150,00
--1001     	10/03/2025  	MetalSul	    (51)99999-1111	    Porto Alegre	Prensa Hidráulica	    Prensas	                João Silva	    Técnico Mecânico	        (51)98888-1111	    Industrial Parts	Caxias do Sul	    Correia B	     1	            80,00
--1002  	12/03/2025	    AutoMec         (41)97777-2222	    Curitiba	    Esteira Transportadora	Transporte Interno	    Maria Souza	    Técnica Industrial	        (41)96666-2222	    MecParts	        Curitiba	        Sensor X	     3	            250,00
--1003	    13/03/2025  	MetalSul	    (51)99999-1111	    Porto Alegre	Prensa Hidráulica	    Prensas	                Carlos Lima	    Engenheiro de Manutenção	(51)95555-3333	    Industrial Parts	Caxias do Sul	    Válvula Z	     1	            420,00
--1004  	15/03/2025	    Alfa Máquinas	(11)94444-4444	    São Paulo	    Centro de Usinagem	    CNC	                    João Silva	    Técnico Mecânico	        (51)98888-1111	    TecIndustrial	    Campinas	        Motor Y	         1	            980,00

--1- Identifique possíveis problemas de redundância existentes nos dados.
--R: clientes, equipamentos, OS, tudo misturado em uma tabela só, sendo repetido inúmera vezes dados no qual não precisava, se uma os precisa de mais materiais todos os dados são repetidos e so muda o material.

--2- Identifique exemplos de:

-- anomalia de inserção: não da pra cadastrar dados sem que tenha todos os dados "em mão" ex: não da pra cadastrar um tecnico sem ter associado um cliente, uma os, peças....
-- anomalia de atualização: Se um dado for mudado será necessario mudar todas as linhas que esse dado aparece ex telefone do tecnico 
-- anomalia de exclusão: se tiver que apagar um dado tipo a OS 1001, todos os dados de tecnico cliente e etc também serão apagados.

--3- Analise as dependências funcionais existentes na estrutura.
--codigoOS, dataOS, cliente, equipamento e tecnico

--4- Verifique a necessidade de aplicação da:
-- Primeira Forma Normal (1FN): telefone do cliente e tecnico e peçaUtilizada
-- Segunda Forma Normal (2FN): teria que criar uma tabela separada para as peças e outra tabela para as OS (com os dados do cliente, telefones e equipamentos), unindo as duas com uma tabela associativa
-- Terceira Forma Normal (3FN): 
--Tabela Clientes = IdCliente, Nome, Telefone, Cidade.
--Tabela Técnicos = IdTecnico, Nome, Telefone.
--Tabela Fornecedores = IdFornecedor, Nome, Cidade.
--Tabela Peças = CodigoPeca, NomePeca, Categoria, IdFornecedor.
--Tabela Ordens de Serviço = CodigoOS, DataOS, IdCliente, IdTecnico, Equipamento.
--Tabela Associativa = CodigoOS, CodigoPeca, Quantidade.

--5.Realize o processo de normalização até o nível considerado necessário para a situação apresentada.
CREATE table cliente (
    id_cliente int PRIMARY key AUTO_INCREMENT,
    telefone_cliente char(14),
    nome_cliente varchar(100),
    cidade_cliente varchar(100)
);
CREATE TABLE tecnico (
    id_tecnico int PRIMARY key AUTO_INCREMENT,
    telefone_tecnico char(14),
    nome_tecnico varchar(100)
);
CREATE TABLE fornecedores (
    id_fornecedores int PRIMARY key AUTO_INCREMENT,
    cidade_fornecedores varchar(100),
    nome_fornecedores varchar(100)
);
CREATE TABLE pecas (
    id_pecas int PRIMARY key AUTO_INCREMENT,
    categoria_pecas varchar(100),
    nome_pecas varchar(100),
    id_fonecedores int,
    Foreign Key (id_fornecedores) REFERENCES fornecedores(id_fornecedores)
);
create table ordensServico (
    id_ordensServico int PRIMARY key AUTO_INCREMENT,
    data_ordensServico date,
    equipamento_ordensServico varchar(100),
    id_tecnico int,
    id_cliente int,
    Foreign Key (id_tecnico) REFERENCES tecnico(id_tecnico),
    Foreign Key (id_cliente) REFERENCES tecnico(id_cliente)
);
CREATE TABLE os_associativa (
    id_ordensServico int,
    id_pecas int,
    quantidade int,
    Foreign Key (id_ordensServico) REFERENCES ordensServico(id_ordensServico),
    Foreign Key (id_pecas) REFERENCES pecas(id_pecas)
);

--6.Apresente as entidades resultantes da normalização contendo:-
-- atributos;
-- chave primária;
-- chaves estrangeiras (quando aplicável).
-- constraints 
--R: ta no der

--7.Descreva os relacionamentos existentes entre as entidades geradas.(aplique o modelo conceitual e lógico)
--R: Ta no gitHub

--8.Justifique tecnicamente cada alteração realizada durante o processo de normalização.
--R: Ao seguir as normas as alterações foram essenciais, criação de novas tabelas para não houver mais dependências erroneas e dados desnecessários e em alta quantidade de forma errada

--9.Explique quais problemas foram eliminados após a reestruturação do banco de dados.
--R: Foram eliminados os problemas ressaltados na questão 2.