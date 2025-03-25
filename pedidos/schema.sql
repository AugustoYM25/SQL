-- Tabela CLIENTES
CREATE TABLE clientes (
    id_cliente NUMBER PRIMARY KEY,
    nome VARCHAR2(100),
    email VARCHAR2(100),
    telefone VARCHAR2(20)
);

-- Tabela PRODUTOS
CREATE TABLE produtos (
    id_produto NUMBER PRIMARY KEY,
    nome VARCHAR2(100),
    preco NUMBER(10, 2)
);

-- Tabela PEDIDOS
CREATE TABLE pedidos (
    id_pedido NUMBER PRIMARY KEY,
    id_cliente NUMBER,
    data_pedido DATE,
    total NUMBER(10, 2),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

-- Tabela ITENSPEDIDO
CREATE TABLE itenspedido (
    id_item NUMBER PRIMARY KEY,
    id_pedido NUMBER,
    id_produto NUMBER,
    quantidade NUMBER(10),
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);
