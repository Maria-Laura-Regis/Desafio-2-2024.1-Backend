USE detran_final;

--  Apresentar todos os dados dos veículos de um determinado proprietário (informado pelo usuário através do CPF);
-- (Usando o CPF '11122233344' como exemplo)
SELECT v.*
FROM VEICULO v
WHERE v.cpf_proprietario = '11122233344';


--  Consultar proprietário(s) por qualquer parte do nome;

SELECT *
FROM PROPRIETARIO
WHERE nome LIKE '%Silva%';


-- Mostrar os dados da infração e do veículo que tiveram infrações cadastradas no Detran em um período
-- *** JOIN FEITO COM CHASSI ***
SELECT 
    i.id_infracao,
    i.data_hora,
    v.placa,
    v.chassi,
    v.ano_fabricacao,
    m.nome AS modelo,
    c.nome AS categoria
FROM INFRACAO i
JOIN VEICULO v ON i.chassi_veiculo = v.chassi -- JOIN agora é pelo chassi
JOIN MODELO m ON v.cod_modelo = m.cod_modelo
JOIN CATEGORIA c ON v.cod_categoria = c.cod_categoria
WHERE i.data_hora BETWEEN '2024-10-01 00:00:00' AND '2024-10-03 23:59:59';


-- Pesquisar o número de veículos que foram cadastrados em cada modelo, ordenando pelo número de veículos em ordem decrescente;
SELECT 
    m.nome AS nome_modelo,
    COUNT(v.chassi) AS total_veiculos -- Contando pela PK (chassi)
FROM MODELO m
LEFT JOIN VEICULO v ON m.cod_modelo = v.cod_modelo
GROUP BY m.nome
ORDER BY total_veiculos DESC;
