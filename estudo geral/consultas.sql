
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
    '112233445566', 
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
        'ABC1234', 
        'Preto', 
        'Civic', 
        'Honda', 
        v_cliente1
    );

    INSERT INTO tb_carro VALUES (
        'XYZ5678', 
        'Branco', 
        'Corolla', 
        'Toyota', 
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





INSERT INTO tb_cargo VALUES (
    'Desenvolvedor', 5000
);

INSERT INTO tb_cargo VALUES (
    'Gerente', 8000
);

INSERT INTO tb_funcionario VALUES (
    '123456789012', 'João Silva', TO_DATE('15/05/1985', 'DD/MM/YYYY'), -- Data de nascimento
    tp_array_telefone(tp_telefone_pessoa('123456789')),
    tp_endereco('12345678', 'Rua dos Devs', 101, 'Apto 10'),
    (SELECT REF(c) FROM tb_cargo c WHERE c.cargo_funcionario = 'Desenvolvedor'),
    NULL -- Sem supervisor
);

INSERT INTO tb_funcionario VALUES (
    '987654321098', 'Maria Oliveira', TO_DATE('22/11/1990', 'DD/MM/YYYY'), -- Data de nascimento
    tp_array_telefone(tp_telefone_pessoa('987654321')),
    tp_endereco('87654321', 'Avenida dos Programadores', 303, 'Bloco B'),
    (SELECT REF(c) FROM tb_cargo c WHERE c.cargo_funcionario = 'Desenvolvedor'), -- Cargo
    (SELECT REF(f) FROM tb_funcionario f WHERE f.cpf = '123456789012') -- Supervisor (João Silva)
);

SELECT f.nome, DEREF(f.cargo).cargo_funcionario, DEREF(f.cargo).salario
FROM tb_funcionario f;
INSERT INTO tb_cliente VALUES ('123456789012', 'João Silva', TO_DATE('15/05/1985', 'DD/MM/YYYY'),tp_array_telefone(tp_telefone_pessoa('123456789'),tp_telefone_pessoa('987654321')), 
    tp_endereco('12345678','Rua dos Programadores',123,'Apto 101'),5);
/

SELECT c.nome, c.endereco.cep
FROM tb_cliente c;
