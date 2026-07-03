-- ==========================================
-- PROJETO: Sistema de Controle de Estoque
-- Disciplina: Experiência Profissional
-- Banco de Dados Relacional
-- Autor: Victor Gustavo Prochnow
-- ==========================================

CREATE DATABASE controle_estoque;
USE controle_estoque;

-- ==========================================
-- TABELA CATEGORIA
-- ==========================================
CREATE TABLE categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(255)
);

-- ==========================================
-- TABELA FORNECEDOR
-- ==========================================
CREATE TABLE fornecedor (
    id_fornecedor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100)
);

-- ==========================================
-- TABELA PRODUTO
-- ==========================================
CREATE TABLE produto (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(255),
    preco DECIMAL(10,2) NOT NULL,
    estoque INT NOT NULL,
    id_categoria INT NOT NULL,
    id_fornecedor INT NOT NULL,

    CONSTRAINT fk_categoria
        FOREIGN KEY (id_categoria)
        REFERENCES categoria(id_categoria),

    CONSTRAINT fk_fornecedor
        FOREIGN KEY (id_fornecedor)
        REFERENCES fornecedor(id_fornecedor)
);

-- ==========================================
-- TABELA CLIENTE
-- ==========================================
CREATE TABLE cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE,
    telefone VARCHAR(20),
    email VARCHAR(100)
);

-- ==========================================
-- TABELA PEDIDO
-- ==========================================
CREATE TABLE pedido (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    data_pedido DATE NOT NULL,
    valor_total DECIMAL(10,2),

    id_cliente INT NOT NULL,

    CONSTRAINT fk_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES cliente(id_cliente)
);

-- ==========================================
-- TABELA ITEM_PEDIDO
-- ==========================================
CREATE TABLE item_pedido (
    id_item INT AUTO_INCREMENT PRIMARY KEY,

    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,

    quantidade INT NOT NULL,
    valor_unitario DECIMAL(10,2),

    CONSTRAINT fk_pedido
        FOREIGN KEY (id_pedido)
        REFERENCES pedido(id_pedido),

    CONSTRAINT fk_produto
        FOREIGN KEY (id_produto)
        REFERENCES produto(id_produto)
);

-- ==========================================
-- INSERINDO DADOS
-- ==========================================

INSERT INTO categoria(nome, descricao)
VALUES
('Informática','Produtos de informática'),
('Periféricos','Equipamentos periféricos'),
('Escritório','Materiais de escritório');

INSERT INTO fornecedor(nome, telefone, email)
VALUES
('Tech Distribuidora','(47)99999-1111','contato@tech.com'),
('Mega Informática','(47)98888-2222','vendas@mega.com'),
('Office Center','(47)97777-3333','office@center.com');

INSERT INTO produto
(nome, descricao, preco, estoque, id_categoria, id_fornecedor)
VALUES
('Notebook Lenovo','Notebook Ryzen 7',4200.00,15,1,1),
('Mouse Gamer','Mouse RGB',180.00,40,2,2),
('Teclado Mecânico','Switch Blue',350.00,25,2,2),
('Monitor 24','Full HD IPS',980.00,18,1,1),
('Cadeira Escritório','Ergonômica',890.00,10,3,3);

INSERT INTO cliente
(nome, cpf, telefone, email)
VALUES
('João Silva','111.111.111-11','(47)99999-0001','joao@email.com'),
('Maria Souza','222.222.222-22','(47)99999-0002','maria@email.com'),
('Carlos Oliveira','333.333.333-33','(47)99999-0003','carlos@email.com');

INSERT INTO pedido
(data_pedido, valor_total, id_cliente)
VALUES
('2026-07-03',4380.00,1),
('2026-07-04',530.00,2);

INSERT INTO item_pedido
(id_pedido,id_produto,quantidade,valor_unitario)
VALUES
(1,1,1,4200.00),
(1,2,1,180.00),
(2,2,1,180.00),
(2,3,1,350.00);

-- ==========================================
-- CONSULTAS SQL
-- ==========================================

-- Listar todos os produtos
SELECT * FROM produto;

-- Produtos com suas categorias
SELECT
p.nome AS Produto,
c.nome AS Categoria,
p.preco,
p.estoque
FROM produto p
INNER JOIN categoria c
ON p.id_categoria = c.id_categoria;

-- Produtos com fornecedores
SELECT
p.nome,
f.nome AS Fornecedor
FROM produto p
INNER JOIN fornecedor f
ON p.id_fornecedor = f.id_fornecedor;

-- Pedidos realizados
SELECT
pedido.id_pedido,
cliente.nome,
pedido.data_pedido,
pedido.valor_total
FROM pedido
INNER JOIN cliente
ON pedido.id_cliente = cliente.id_cliente;

-- Itens dos pedidos
SELECT
pedido.id_pedido,
produto.nome,
item_pedido.quantidade,
item_pedido.valor_unitario
FROM item_pedido
INNER JOIN pedido
ON item_pedido.id_pedido = pedido.id_pedido
INNER JOIN produto
ON item_pedido.id_produto = produto.id_produto;

-- ==========================================
-- UPDATE
-- ==========================================

UPDATE produto
SET estoque = estoque - 1
WHERE id_produto = 1;

UPDATE cliente
SET telefone='(47)99999-9999'
WHERE id_cliente=2;

-- ==========================================
-- DELETE
-- ==========================================

DELETE FROM item_pedido
WHERE id_item=4;

-- ==========================================
-- ALTER TABLE
-- ==========================================

ALTER TABLE fornecedor
ADD cidade VARCHAR(80);

-- ==========================================
-- DROP (apenas exemplo)
-- Não executar caso deseje manter o banco.
-- ==========================================

-- DROP DATABASE controle_estoque;
