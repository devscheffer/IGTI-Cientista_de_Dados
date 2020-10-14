-- Qual jogo possui a maior venda global (“Global_Sales”) para a plataforma PS2?
SELECT
    platform
,*
FROM
    game
WHERE global_sales = (
    SELECT
    max(global_sales)
FROM
    game
WHERE platform = 'PS2'
GROUP BY platform
)
;
-- Qual a posição no Rank global (“Rank”) está o segundo jogo mais vendido na Europa? Ordenar pelo atributo "EU_Sales".
SELECT
    rank
    ,name
    ,eu_sales
FROM
    game
ORDER BY eu_sales DESC
-- Qual o nome do jogo que possui a menor venda global (“Global_Sales”) no ano de 2010?
SELECT
    name
    ,global_sales
    ,year
FROM
    game
WHERE year = '2010'
ORDER BY global_sales ASC
-- Qual a plataforma (“Platform”) do jogo mais vendido considerando as vendas globais ("Global_Sales ") no ano de 2008?
SELECT
    name
    ,global_sales
    ,platform
FROM
    game
WHERE year = '2008'
ORDER BY global_sales DESC

-- Qual o nome do jogo que é exibido ao executar o comando para retornar o primeiro documento da coleção onde a condição seja a plataforma (“Platform”) igual a PS4?
SELECT
    *
FROM
    game
WHERE platform = 'PS4'
-- Quantos documentos existem na base de dados referentes à plataforma (“Platform”) “X360”?
SELECT
    platform
    ,count(*)
FROM
    game
WHERE platform = 'X360'
GROUP BY game.platform
-- Qual a plataforma (“Platform”) do jogo mais vendido no Japão ("JP_Sales") no ano de 2015?
SELECT
    jp_sales
    ,platform
    ,*
FROM
    game
WHERE year = '2015'
ORDER BY jp_sales DESC
-- Em que posição do “Rank” o jogo “The Witcher 3: Wild Hunt” está considerando a plataforma “XOne”?
SELECT
    *
FROM
    game
WHERE name LIKE '%Witcher 3%'
    AND platform = 'XOne'

-- Quantos documentos são retornados ao executar uma consulta em que o atributo “Global_Sales” seja maior ou igual a 2?
SELECT
    count(*)
FROM
    game
WHERE global_sales >= 2





