-- Quantas pessoas possuem idade maior ou igual a 50 anos?
SELECT
    count(*)
FROM
    pessoa
WHERE idade >= 50
;
-- Qual a média de idade das pessoas que moram em Mato Grosso?
SELECT
    round(avg(idade),1)
FROM
    pessoa
WHERE estado = 'MT'
;
-- Quantas pessoas nasceram nos anos de 1968 a 1978 (incluindo 1968 e 1978)?
SELECT
    count(*)
FROM
    pessoa
WHERE
	extract(year FROM cast(data_nasc AS date)) <= 1978
    AND extract(year FROM cast(data_nasc AS date)) >= 1968
;
-- Ao executar o seguinte comando SQL no banco de dados criado, qual é o valor retornado?
SELECT
    count(*)
FROM
    pessoa
WHERE
tipo_sanguineo  LIKE 'AB-'
    AND (estado LIKE 'AP' OR estado LIKE 'PE')
;
-- Qual o nome da pessoa mais velha na base de dados?
SELECT
    *
FROM
    pessoa
WHERE data_nasc = (
	SELECT
    min(data_nasc)
FROM
    pessoa
	)
;
-- Qual o nome da pessoa mais nova da base de dados?
SELECT
    *
FROM
    pessoa
WHERE data_nasc = (
	SELECT
    max(data_nasc)
FROM
    pessoa
	)
;
