
CREATE OR REPLACE TYPE tp_endereco AS OBJECT (

    cep VARCHAR2(9),
    rua VARCHAR2(30),
    numero INTEGER,
    complemento VARCHAR2(30)
);
/

CREATE OR REPLACE TYPE tp_telefone_pessoa AS OBJECT (

    fone VARCHAR2(15)
);
/

CREATE OR REPLACE TYPE tp_array_telefone AS VARRAY(5) OF tp_telefone_pessoa;
/

CREATE OR REPLACE TYPE tp_pessoa AS OBJECT (

    cpf VARCHAR2(12),
    nome VARCHAR2(30),
    data_nascimento DATE,
    fone tp_array_telefone,
    endereco tp_endereco
)NOT FINAL NOT INSTANTIABLE;
/

CREATE OR REPLACE TYPE tp_cliente UNDER tp_pessoa (

    n_atendimentos NUMBER
);
/

CREATE OR REPLACE TYPE tp_cargo AS OBJECT (

    cargo_funcionario VARCHAR2(15),
    salario NUMBER
);
/

CREATE OR REPLACE TYPE tp_funcionario UNDER tp_pessoa (

    cargo REF tp_cargo,
    cpf_supervisor REF tp_funcionario
);
/

CREATE OR REPLACE TYPE tp_tel_empresa AS OBJECT (

    tel_empresa VARCHAR(15)
);
/

CREATE OR REPLACE TYPE array_tel_empresa AS VARRAY(5) OF tp_tel_empresa;
/

CREATE OR REPLACE TYPE tp_fornecedor AS OBJECT(

    cnpj VARCHAR2(18),
    nome_empresa VARCHAR2(30),
    telefone_empresa array_tel_empresa
);
/

CREATE OR REPLACE TYPE tp_maquina AS OBJECT (

    fabricante VARCHAR2(30),
    codigo NUMBER(30),
    nome_maquina VARCHAR2(30)
);
/

CREATE OR REPLACE TYPE tp_produto AS OBJECT (

    fornecedor_produto REF tp_fornecedor,
    nome_produto VARCHAR2 (30),
    preco NUMBER
);
/

CREATE OR REPLACE TYPE tp_varios_produtos AS TABLE OF tp_produto;
/ 

CREATE OR REPLACE TYPE tp_servico AS OBJECT (

    codigo NUMBER,
    nome_servico VARCHAR2(30),
    valor_servico NUMBER,
    produtos tp_varios_produtos
);
/

CREATE OR REPLACE TYPE tp_carro AS OBJECT (

    cor VARCHAR2(10),
    modelo VARCHAR2(30),
    marca VARCHAR2(30),
    placa VARCHAR2(7),
    proprietario REF tp_cliente
);
/

CREATE OR REPLACE TYPE tp_atendimento AS OBJECT (

    maquina_atendimento REF tp_maquina,
    funcionario_atendente REF tp_funcionario,
    servico_atendimento REF tp_servico,
    carro_atendimento REF tp_carro,
    custo NUMBER,
    data_atendimento DATE
);
/
    


CREATE TABLE tb_cliente OF tp_cliente (

    cpf PRIMARY KEY
);
/

CREATE TABLE tb_cargo OF tp_cargo (

    cargo_funcionario PRIMARY KEY,
    salario NOT NULL
);
/

CREATE TABLE tb_funcionario OF tp_funcionario (

    cpf PRIMARY KEY,
    cargo WITH ROWID REFERENCES tb_cargo,
    cpf_supervisor WITH ROWID REFERENCES tb_funcionario
);
/

CREATE TABLE tb_fornecedor OF tp_fornecedor (

    cnpj PRIMARY KEY,
    nome_empresa NOT NULL
);
/

CREATE TABLE tb_maquina OF tp_maquina (

    codigo PRIMARY KEY,
    fabricante NOT NULL,
    nome_maquina NOT NULL
);
/

CREATE TABLE tb_servico OF tp_servico (

    codigo PRIMARY KEY,
    nome_servico NOT NULL,
    valor_servico NOT NULL
) NESTED TABLE produtos STORE AS nt_prdutos;
/

CREATE TABLE tb_carro OF tp_carro (

    placa PRIMARY KEY,
    cor NOT NULL,
    modelo NOT NULL,
    marca NOT NULL,
    proprietario WITH ROWID REFERENCES tb_cliente
);
/

CREATE TABLE tb_atendimento OF tp_atendimento (

    maquina_atendimento WITH ROWID REFERENCES tb_maquina,
    funcionario_atendente WITH ROWID REFERENCES tb_funcionario,
    servico_atendimento WITH ROWID REFERENCES tb_servico,
    carro_atendimento WITH ROWID REFERENCES tb_carro,
    custo NOT NULL,
    data_atendimento NOT NULL
);
/


INSERT INTO tb_cargo VALUES (
    'Mecânico', 
    2500
);

INSERT INTO tb_cargo VALUES (
    'Gerente',
    5000
);

INSERT INTO tb_cliente VALUES (
    '123456789012',
    'João Silva',
    TO_DATE('15/05/1985', 'DD/MM/YYYY'),
    tp_array_telefone(tp_telefone_pessoa('11999999999'), tp_telefone_pessoa('11988888888')),
    tp_endereco('01234567', 'Rua A', 100, 'Apto 1'),
    5
);

INSERT INTO tb_cliente VALUES (
    '987654321098',
    'Maria Souza',
    TO_DATE('22/11/1990', 'DD/MM/YYYY'),
    tp_array_telefone(tp_telefone_pessoa('21977777777')),
    tp_endereco('87654321', 'Avenida B', 200, 'Casa'),
    2
);

-- Primeiro, insira o funcionário supervisor:
INSERT INTO tb_funcionario VALUES (
    '654321098765', 
    'Carlos Gerente', 
    TO_DATE('01/01/1980', 'DD/MM/YYYY'), 
    tp_array_telefone(tp_telefone_pessoa('31955555555')),
    tp_endereco('55555555', 'Rua C', 50, 'Sala 1'),
    (SELECT REF(c) FROM tb_cargo c WHERE c.cargo_funcionario = 'Gerente'),
    NULL -- Sem supervisor, já que é o gerente
);

-- Agora, insira o funcionário que é supervisionado:
INSERT INTO tb_funcionario VALUES (
    '00011122234', 
    'Ana Mecânica', 
    TO_DATE('12/06/1995', 'DD/MM/YYYY'), 
    tp_array_telefone(tp_telefone_pessoa('31966666666')),
    tp_endereco('66666666', 'Rua D', 70, 'Casa 2'),
    (SELECT REF(c) FROM tb_cargo c WHERE c.cargo_funcionario = 'Mecânico'),
    (SELECT REF(f) FROM tb_funcionario f WHERE f.cpf = '654321098765') -- Supervisor é Carlos
);

INSERT INTO tb_fornecedor VALUES (
    '12345678000199',
    'Fornecedor A',
    array_tel_empresa(tp_tel_empresa('1133333333'))
);

INSERT INTO tb_fornecedor VALUES (
    '98765432000188',
    'Fornecedor B',
    array_tel_empresa(tp_tel_empresa('1144444444'), tp_tel_empresa('1155555555'))
);


INSERT INTO tb_maquina VALUES ('Máquinas ABC', 1, 'Máquina X');
/


INSERT INTO tb_maquina VALUES ('Equipamentos XYZ', 2, 'Máquina Y');
/

-- Primeiro, insira dois fornecedores de produtos para os serviços:
DECLARE
    v_fornecedor1 REF tp_fornecedor;
    v_fornecedor2 REF tp_fornecedor;
BEGIN
    -- Referenciando os fornecedores previamente inseridos
    SELECT REF(f) INTO v_fornecedor1 FROM tb_fornecedor f WHERE f.cnpj = '12345678000199';
    SELECT REF(f) INTO v_fornecedor2 FROM tb_fornecedor f WHERE f.cnpj = '98765432000188';

    -- Inserindo serviços com produtos
    INSERT INTO tb_servico VALUES (
        1,
        'Troca de Óleo',
        150,
        tp_varios_produtos(tp_produto(v_fornecedor1, 'Óleo A', 50))
    );
    
    INSERT INTO tb_servico VALUES (
        2,
        'Revisão Completa',
        500,
        tp_varios_produtos(tp_produto(v_fornecedor2, 'Peça B', 200), tp_produto(v_fornecedor1, 'Lubrificante C', 100))
    );
END;
/

-- Referenciando clientes
DECLARE
    v_cliente1 REF tp_cliente;
    v_cliente2 REF tp_cliente;
BEGIN
    -- Obter referências dos clientes
    SELECT REF(c) INTO v_cliente1 FROM tb_cliente c WHERE c.cpf = '123456789012';
    SELECT REF(c) INTO v_cliente2 FROM tb_cliente c WHERE c.cpf = '987654321098';

    -- Inserindo carros
    INSERT INTO tb_carro VALUES (
        'PRETO', 
        'ABC1234', 
        'Civic', 
        'Honda', 
        v_cliente1
    );

    INSERT INTO tb_carro VALUES (
        'BRANCO', 
        'XYZ5678', 
        'Corolla', 
        'Toyota', 
        v_cliente2
    );

    INSERT INTO tb_carro VALUES (
        'VERMELHO', 
        'meupai', 
        'minhame', 
        'meurimo', 
        v_cliente2
    );

END;
/

-- Referenciando máquinas, funcionários, serviços e carros
DECLARE
    v_maquina1 REF tp_maquina;
    v_maquina2 REF tp_maquina;
    v_funcionario1 REF tp_funcionario;
    v_funcionario2 REF tp_funcionario;
    v_servico1 REF tp_servico;
    v_servico2 REF tp_servico;
    v_carro1 REF tp_carro;
    v_carro2 REF tp_carro;
BEGIN
    -- Obter referências
    SELECT REF(m) INTO v_maquina1 FROM tb_maquina m WHERE m.codigo = 1;
    SELECT REF(m) INTO v_maquina2 FROM tb_maquina m WHERE m.codigo = 2;
    SELECT REF(f) INTO v_funcionario1 FROM tb_funcionario f WHERE f.cpf = '654321098765';
    SELECT REF(f) INTO v_funcionario2 FROM tb_funcionario f WHERE f.cpf = '112233445566';
    SELECT REF(s) INTO v_servico1 FROM tb_servico s WHERE s.codigo = 1;
    SELECT REF(s) INTO v_servico2 FROM tb_servico s WHERE s.codigo = 2;
    SELECT REF(c) INTO v_carro1 FROM tb_carro c WHERE c.placa = 'ABC1234';
    SELECT REF(c) INTO v_carro2 FROM tb_carro c WHERE c.placa = 'XYZ5678';

    -- Inserindo atendimentos
    INSERT INTO tb_atendimento VALUES (
        v_maquina1,
        v_funcionario1,
        v_servico1,
        v_carro1,
        150,
        TO_DATE('10/09/2024', 'DD/MM/YYYY')
    );

    INSERT INTO tb_atendimento VALUES (
        v_maquina2,
        v_funcionario2,
        v_servico2,
        v_carro2,
        600,
        TO_DATE('15/09/2024', 'DD/MM/YYYY')
    );
END;
/

INSERT INTO tb_atendimento (maquina_atendimento, funcionario_atendente, servico_atendimento, carro_atendimento, custo, data_atendimento)
VALUES (
    (SELECT REF(m) FROM tb_maquina m WHERE m.codigo = 2), -- outra máquina
    (SELECT REF(f) FROM tb_funcionario f WHERE f.cpf = '00011122234'), -- outro funcionário
    (SELECT REF(s) FROM tb_servico s WHERE s.codigo = 1), -- mesmo serviço
    (SELECT REF(c) FROM tb_carro c WHERE c.placa = 'DEF5678'), -- outro carro
    600, -- custo
    TO_DATE('2023-09-26', 'YYYY-MM-DD') -- data do atendimento
);


INSERT INTO tb_atendimento (maquina_atendimento, funcionario_atendente, servico_atendimento, carro_atendimento, custo, data_atendimento)
VALUES (
    (SELECT REF(m) FROM tb_maquina m WHERE m.codigo = 1), -- referência a uma máquina existente
    (SELECT REF(f) FROM tb_funcionario f WHERE f.cpf = '00011122234'), -- referência a outro funcionário existente
    (SELECT REF(s) FROM tb_servico s WHERE s.codigo = 1), -- referência ao mesmo serviço anterior (código 1)
    (SELECT REF(c) FROM tb_carro c WHERE c.placa = 'DEF5678'), -- referência a um carro
    700, -- custo do atendimento
    TO_DATE('2023-09-27', 'YYYY-MM-DD') -- data do atendimento
);

INSERT INTO tb_atendimento (maquina_atendimento, funcionario_atendente, servico_atendimento, carro_atendimento, custo, data_atendimento)
VALUES (
    (SELECT REF(m) FROM tb_maquina m WHERE m.codigo = 2), -- referência a uma máquina existente
    (SELECT REF(f) FROM tb_funcionario f WHERE f.cpf = '654321098765'), -- referência a outro funcionário existente
    (SELECT REF(s) FROM tb_servico s WHERE s.codigo = 2), -- referência ao mesmo serviço anterior (código 1)
    (SELECT REF(c) FROM tb_carro c WHERE c.placa = 'DEF5678'), -- referência a um carro
    700, -- custo do atendimento
    TO_DATE('2023-08-27', 'YYYY-MM-DD') -- data do atendimento
);

INSERT INTO tb_atendimento (maquina_atendimento, funcionario_atendente, servico_atendimento, carro_atendimento, custo, data_atendimento)
VALUES (
    (SELECT REF(m) FROM tb_maquina m WHERE m.codigo = 1), -- referência a uma máquina existente
    (SELECT REF(f) FROM tb_funcionario f WHERE f.cpf = '00011122234'), -- referência a outro funcionário existente
    (SELECT REF(s) FROM tb_servico s WHERE s.codigo = 1), -- referência ao mesmo serviço anterior (código 1)
    (SELECT REF(c) FROM tb_carro c WHERE c.placa = 'meurimo'), -- referência a um carro
    700, -- custo do atendimento
    TO_DATE('2023-09-27', 'YYYY-MM-DD') -- data do atendimento
);

INSERT INTO tb_atendimento (maquina_atendimento, funcionario_atendente, servico_atendimento, carro_atendimento, custo, data_atendimento)
VALUES (
    (SELECT REF(m) FROM tb_maquina m WHERE m.codigo = 1), -- referência a uma máquina existente
    (SELECT REF(f) FROM tb_funcionario f WHERE f.cpf = '00011122234'), -- referência a outro funcionário existente
    (SELECT REF(s) FROM tb_servico s WHERE s.codigo = 1), -- referência ao mesmo serviço anterior (código 1)
    (SELECT REF(c) FROM tb_carro c WHERE c.placa = 'meurimo'), -- referência a um carro
    700, -- custo do atendimento
    TO_DATE('2023-09-27', 'YYYY-MM-DD') -- data do atendimento
);

INSERT INTO tb_atendimento (maquina_atendimento, funcionario_atendente, servico_atendimento, carro_atendimento, custo, data_atendimento)
VALUES (
    (SELECT REF(m) FROM tb_maquina m WHERE m.codigo = 1), -- referência a uma máquina existente
    (SELECT REF(f) FROM tb_funcionario f WHERE f.cpf = '00011122234'), -- referência a outro funcionário existente
    (SELECT REF(s) FROM tb_servico s WHERE s.codigo = 1), -- referência ao mesmo serviço anterior (código 1)
    (SELECT REF(c) FROM tb_carro c WHERE c.placa = 'Toyota'), -- referência a um carro
    700, -- custo do atendimento
    TO_DATE('2023-09-27', 'YYYY-MM-DD') -- data do atendimento
);
