
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
    

