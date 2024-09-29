
CREATE OR REPLACE TYPE tp_pessoa AS OBJECT (
    cpf VARCHAR2(14), 
    nome VARCHAR2(30), 
    data_nascimento DATE, 
    MEMBER PROCEDURE 
    exibirInformacoes(SELF tp_pessoa)
) NOT FINAL NOT INSTANTIABLE;
/

CREATE OR REPLACE TYPE tp_cliente UNDER tp_pessoa ( 
    quantidade_de_compras INTEGER, 
    OVERRIDING MEMBER PROCEDURE 
    exibirInformacoes(SELF tp_cliente)
);
/

CREATE OR REPLACE TYPE tp_fornecedor AS OBJECT (
    cnpj VARCHAR2(18), 
    nome_empresa VARCHAR2(30)
);
/

CREATE OR REPLACE TYPE tp_ingrediente AS OBJECT (
    nome VARCHAR2(30), 
    empresa REF tp_fornecedor, 
    quantia_estoque VARCHAR2(20)
);
/

CREATE OR REPLACE TYPE tp_nt_ingredientes AS TABLE OF tp_ingrediente;
/ 

CREATE OR REPLACE TYPE tp_doce AS OBJECT (
    codigo_doce VARCHAR2(7), 
    nome VARCHAR2(30), 
    categoria VARCHAR2(20), 
    preco_unidade NUMBER, 
    ingredientes tp_nt_ingredientes
);
/

CREATE OR REPLACE TYPE tp_pedido AS OBJECT (
    codigo_pedido VARCHAR2(10), 
    valor NUMBER(5,2), 
    numero_itens INTEGER
);
/

CREATE OR REPLACE TYPE tp_contem AS OBJECT (
    pedido REF tp_pedido, 
    doce REF tp_doce, 
    quantidade_doces INTEGER
);
/

CREATE OR REPLACE TYPE tp_compra AS OBJECT (
    pedido REF tp_pedido, 
    data_compra DATE, 
    cliente REF tp_cliente
);
/

CREATE TABLE tb_cliente OF tp_cliente (
    cpf PRIMARY KEY
);
/

CREATE TABLE tb_fornecedor OF tp_fornecedor (
    cnpj PRIMARY KEY, 
    nome_empresa NOT NULL
);
/

CREATE TABLE tb_doce OF tp_doce (
    codigo_doce PRIMARY KEY, 
    nome NOT NULL, 
    categoria NOT NULL, 
    preco_unidade NOT NULL
) NESTED TABLE ingredientes STORE AS nt_ingredientes;
/

CREATE TABLE tb_pedido OF tp_pedido (
    codigo_pedido PRIMARY KEY, 
    valor NOT NULL, 
    numero_itens NOT NULL
);
/

CREATE TABLE tb_contem OF tp_contem (
    pedido WITH ROWID REFERENCES tb_pedido, 
    doce WITH ROWID REFERENCES tb_doce, 
    quantidade_doces NOT NULL
);
/

CREATE TABLE tb_compra OF tp_compra (
    pedido WITH ROWID REFERENCES tb_pedido, 
    data_compra NOT NULL, 
    cliente WITH ROWID REFERENCES tb_cliente
);
/

INSERT INTO tb_cliente VALUES (
    '12345678901234', 'Maria Silva', TO_DATE('1980-05-12', 'YYYY-MM-DD'), 5
);

INSERT INTO tb_cliente VALUES (
    '23456789012345', 'João Oliveira', TO_DATE('1990-11-21', 'YYYY-MM-DD'), 10
);

INSERT INTO tb_cliente VALUES (
    '34567890123456', 'Ana Souza', TO_DATE('1985-03-08', 'YYYY-MM-DD'), 3
);

INSERT INTO tb_fornecedor VALUES (
    '01.234.567/0001-89', 'Açúcar União'
);

INSERT INTO tb_fornecedor VALUES (
    '98.765.432/0001-12', 'Cacau Show'
);

INSERT INTO tb_fornecedor VALUES (
    '11.223.344/0001-55', 'Nestlé'
);

-- Ingredientes para Doce 1
INSERT INTO tb_doce VALUES (
    'DOC001', 'Bolo de Chocolate', 'Bolos', 25.50, 
    tp_nt_ingredientes(
        tp_ingrediente('Açúcar', (SELECT REF(f) FROM tb_fornecedor f WHERE f.nome_empresa = 'Açúcar União'), '10kg'),
        tp_ingrediente('Chocolate', (SELECT REF(f) FROM tb_fornecedor f WHERE f.nome_empresa = 'Cacau Show'), '5kg')
    )
);

-- Ingredientes para Doce 2
INSERT INTO tb_doce VALUES (
    'DOC002', 'Brigadeiro', 'Doces', 1.50, 
    tp_nt_ingredientes(
        tp_ingrediente('Leite Condensado', (SELECT REF(f) FROM tb_fornecedor f WHERE f.nome_empresa = 'Nestlé'), '5kg'),
        tp_ingrediente('Chocolate', (SELECT REF(f) FROM tb_fornecedor f WHERE f.nome_empresa = 'Cacau Show'), '2kg')
    )
);

-- Ingredientes para Doce 3
INSERT INTO tb_doce VALUES (
    'DOC003', 'Pudim', 'Sobremesas', 15.00, 
    tp_nt_ingredientes(
        tp_ingrediente('Açúcar', (SELECT REF(f) FROM tb_fornecedor f WHERE f.nome_empresa = 'Açúcar União'), '2kg'),
        tp_ingrediente('Leite Condensado', (SELECT REF(f) FROM tb_fornecedor f WHERE f.nome_empresa = 'Nestlé'), '3kg')
    )
);

INSERT INTO tb_pedido VALUES ('PED001', 50.00, 2);
INSERT INTO tb_pedido VALUES ('PED002', 4.50, 3);
INSERT INTO tb_pedido VALUES ('PED003', 15.00, 1);

-- Pedido 1 contém 2 doces: Bolo de Chocolate e Brigadeiro
INSERT INTO tb_contem VALUES (
    (SELECT REF(p) FROM tb_pedido p WHERE p.codigo_pedido = 'PED001'),
    (SELECT REF(d) FROM tb_doce d WHERE d.codigo_doce = 'DOC001'),
    1
);
INSERT INTO tb_contem VALUES (
    (SELECT REF(p) FROM tb_pedido p WHERE p.codigo_pedido = 'PED001'),
    (SELECT REF(d) FROM tb_doce d WHERE d.codigo_doce = 'DOC002'),
    2
);

-- Pedido 2 contém 3 brigadeiros
INSERT INTO tb_contem VALUES (
    (SELECT REF(p) FROM tb_pedido p WHERE p.codigo_pedido = 'PED002'),
    (SELECT REF(d) FROM tb_doce d WHERE d.codigo_doce = 'DOC002'),
    3
);

-- Pedido 3 contém 1 pudim
INSERT INTO tb_contem VALUES (
    (SELECT REF(p) FROM tb_pedido p WHERE p.codigo_pedido = 'PED003'),
    (SELECT REF(d) FROM tb_doce d WHERE d.codigo_doce = 'DOC003'),
    1
);

-- Cliente Maria Silva compra o Pedido 1
INSERT INTO tb_compra VALUES (
    (SELECT REF(p) FROM tb_pedido p WHERE p.codigo_pedido = 'PED001'),
    TO_DATE('2024-09-01', 'YYYY-MM-DD'),
    (SELECT REF(c) FROM tb_cliente c WHERE c.nome = 'Maria Silva')
);

-- Cliente João Oliveira compra o Pedido 2
INSERT INTO tb_compra VALUES (
    (SELECT REF(p) FROM tb_pedido p WHERE p.codigo_pedido = 'PED002'),
    TO_DATE('2024-09-02', 'YYYY-MM-DD'),
    (SELECT REF(c) FROM tb_cliente c WHERE c.nome = 'João Oliveira')
);

-- Cliente Ana Souza compra o Pedido 3
INSERT INTO tb_compra VALUES (
    (SELECT REF(p) FROM tb_pedido p WHERE p.codigo_pedido = 'PED003'),
    TO_DATE('2024-09-03', 'YYYY-MM-DD'),
    (SELECT REF(c) FROM tb_cliente c WHERE c.nome = 'Ana Souza')
);

-- LETRA A)

SELECT d.nome AS nome, d.categoria AS categoria, d.preco_unidade AS preco
FROM tb_doce d
WHERE d.preco_unidade = (SELECT MAX(preco_unidade) FROM tb_doce);

-- LETRA B)


SELECT DEREF(c.pedido).codigo_pedido AS codigo_produto_vendido, DEREF(c.pedido).valor AS valor, 
DEREF(c.pedido).numero_itens AS qtd
FROM tb_compra c
ORDER BY qtd DESC
FETCH FIRST 1 ROW ONLY;

-- LETRA C)

SELECT i.nome AS nome_ingrediente, DEREF(i.empresa).nome_empresa AS empresa
FROM tb_doce d, TABLE(d.ingredientes) i
WHERE d.nome = 'Brigadeiro';

-- LETRA D)

SELECT DEREF(c.cliente).nome AS cliente, DEREF(c.pedido).valor AS valor
FROM tb_compra c
ORDER BY valor DESC
FETCH FIRST 1 ROW ONLY;

