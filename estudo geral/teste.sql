
--LETRA A)

SELECT DEREF(a.servico_atendimento).nome_servico AS servicos, COUNT(a.servico_atendimento) AS total_atendimentos
FROM tb_atendimento a
GROUP BY DEREF(a.servico_atendimento).nome_servico
ORDER BY total_atendimentos DESC
FETCH FIRST 1 ROW ONLY;

SELECT DEREF(a.servico_atendimento).nome_servico AS servicos, COUNT(DEREF(a.servico_atendimento).nome_servico) AS total_servicos
FROM tb_atendimento A
GROUP BY DEREF(A.servico_atendimento).nome_servico
ORDER BY total_servicos DESC;

-- LETRA B)

SELECT AVG(DEREF(f.cargo).salario) AS media_salarial
FROM tb_funcionario f
WHERE DEREF(f.cargo).salario IS NOT NULL;

-- LETRA C)

SELECT DEREF(a.funcionario_atendente).nome AS funcionarios, COUNT(*) AS total_servicos_efetuados
FROM tb_atendimento a
GROUP BY DEREF(a.funcionario_atendente).nome
ORDER BY total_servicos_efetuados DESC
FETCH FIRST 1 ROW ONLY;

SELECT f.nome AS funcionarios, COUNT(a.servico_atendimento) AS total_servicos
FROM tb_funcionario f
INNER JOIN tb_atendimento a ON f.nome = DEREF(funcionario_atendente).nome
GROUP BY f.nome
ORDER BY total_servicos DESC
FETCH FIRST 1 ROW ONLY;

-- LETRA D)

SELECT f.nome AS funcionario, DEREF(f.cargo).cargo_funcionario AS cargo
FROM tb_funcionario f
WHERE f.cpf_supervisor IS NOT NULL;

-- LETRA E)

SELECT c.modelo AS modelo
FROM tb_carro c
WHERE c.cor = 'VERMELHO';

SELECT c.modelo AS modelo
FROM tb_carro c
WHERE c.cor LIKE 'VERMELHO';

-- LETRA F)

SELECT c.marca AS marca_mais_frequente, COUNT(*) AS total_incidencias
FROM tb_carro c
GROUP BY c.marca
ORDER BY total_incidencias DESC
FETCH FIRST 1 ROW ONLY;

SELECT c.cor AS cor, COUNT(*) AS total_ocorrencias 
FROM tb_carro c 
GROUP BY c.cor 
ORDER BY total_ocorrencias
FETCH FIRST 1 ROW ONLY;

-- LETRA G)

SELECT s.nome_servico AS servico, s.valor_servico AS preco
FROM tb_servico s
WHERE s.valor_servico = (SELECT MAX(s.valor_servico) FROM tb_servico s);

SELECT s.nome_servico AS servico, s.valor_servico AS preco
FROM tb_servico s
WHERE s.valor_servico = (SELECT MIN(valor_servico) FROM tb_servico);

-- LETRA H)

SELECT f.nome AS funcionarios, f.cpf AS cpf, t.fone AS telefone
FROM tb_funcionario f, TABLE(f.fone) t
WHERE DEREF(f.cargo).cargo_funcionario LIKE 'Mecânico';

-- LETRA I)

SELECT P.nome_produto, P.preco 
FROM tb_servico S, TABLE(S.produtos) P 
WHERE S.nome_servico = 'Revisão Completa';

-- LETRA J)

SELECT cl.nome AS cliente, SUM(a.custo) AS custo_total
FROM tb_cliente cl, tb_atendimento a
GROUP BY cl.nome
ORDER BY custo_total DESC;

SELECT DEREF(DEREF(a.carro_atendimento).proprietario).nome AS Clientes, SUM(a.custo) AS custo
FROM tb_atendimento a
GROUP BY DEREF(DEREF(a.carro_atendimento).proprietario).nome;


-- LETRA K)

SELECT DEREF(a.servico_atendimento).nome_servico AS servico, a.data_atendimento AS data
, DEREF(a.funcionario_atendente).nome AS funcionario, a.custo AS custo
, DEREF(a.carro_atendimento).placa AS placa_do_carro, DEREF(a.carro_atendimento).modelo AS modelo
FROM tb_atendimento a
WHERE a.custo = (SELECT MAX(custo) FROM tb_atendimento);

-- LETRA L)

SELECT f.nome_empresa AS empresa, t.*, p.nome_produto AS produto
FROM tb_fornecedor f, tb_servico s, TABLE (f.telefone_empresa) t, TABLE (s.produtos) p
WHERE p.nome_produto = 'Óleo A';

-- LETRA M)

SELECT DEREF(a.servico_atendimento).nome_servico AS servico, DEREF(a.maquina_atendimento).nome_maquina AS maquina
FROM tb_atendimento a
WHERE DEREF(a.maquina_atendimento).nome_maquina = 'Máquina Y';