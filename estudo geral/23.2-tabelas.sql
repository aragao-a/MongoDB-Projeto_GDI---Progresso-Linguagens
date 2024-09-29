
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

SELECT DEREF(p.fornecedor_produto).nome_empresa AS fornecedor, p.nome_produto AS produto
, DEREF(p.fornecedor_produto).telefone_empresa
FROM tb_servico s, TABLE(s.produtos) p, TABLE (p.fornecedor_produto)
WHERE p.nome_produto = 'Óleo A';