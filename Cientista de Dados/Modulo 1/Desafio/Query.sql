-- Q8
-- Qual a média salarial nessa empresa?
SELECT
    avg(salario)
FROM
    empregado
;

-- Q9
-- Quantos empregados do departamento 5 trabalham mais de 10h por semana no projeto chamado "ProductX"
SELECT
    empregado.pnome
    ,empregado.ssn
    ,empregado.dno
    ,projeto.dnum
    ,projeto.pjnome
    ,projeto.pnumero
    ,trabalha_em.essn
    ,trabalha_em.pno
    ,trabalha_em.horas
FROM
    empregado
    JOIN departamento ON departamento.dnumero = empregado.dno
    JOIN projeto ON projeto.dnum = departamento.dnumero
    JOIN trabalha_em ON trabalha_em.essn = empregado.ssn
        AND trabalha_em.pno = projeto.pnumero
WHERE
    departamento.dnumero = 5
    AND projeto.pjnome = 'ProductX'
    AND trabalha_em.horas > 10
;

-- Q10
--  Quantos empregados possuem um dependente com o mesmo primeiro nome que o deles?
SELECT
    empregado.pnome
    ,dependente.nome_dependente
FROM
    empregado
    JOIN dependente ON dependente.essn = empregado.ssn
WHERE
    empregado.pnome = dependente.nome_dependente
;

-- Q11
-- Quais os nomes de todos os empregados que são diretamente supervisionados por Franklin Wong
SELECT
    t1.*
    ,t2.*
FROM
    empregado t1
    JOIN empregado t2 ON t1.superssn = t2.ssn
WHERE
    t2.pnome = 'Franklin'
    AND t2.unome = 'Wong'
;

-- Q12
-- Quem é a pessoa que possui mais tempo de alocação no projeto 'Newbenefits'?
SELECT
    empregado.pnome
    ,trabalha_em.horas
FROM
    empregado
    JOIN departamento ON departamento.dnumero = empregado.dno
    JOIN projeto ON projeto.dnum = departamento.dnumero
    JOIN trabalha_em ON trabalha_em.essn = empregado.ssn
        AND trabalha_em.pno = projeto.pnumero
WHERE
    projeto.pjnome = 'Newbenefits'
ORDER BY
    horas DESC
;

-- Q13
-- Qual é a soma dos salários de todos os empregados do departamento chamado 'Research'?
SELECT
    sum(empregado.salario)
FROM
    empregado
    JOIN departamento ON departamento.dnumero = empregado.dno
WHERE
    departamento.dnome = 'Research'
;

-- Q14
-- Qual seria o custo do projeto com folha salarial (soma de todos os salários) caso a empresa desse 10% de aumento para todos os empregados que trabalham no projeto 'ProductX'?
SELECT
    sum(empregado.salario) * 1.1
FROM
    empregado
    JOIN trabalha_em ON trabalha_em.essn = empregado.ssn
    JOIN projeto ON projeto.pnumero = trabalha_em.pno
WHERE
    projeto.pjnome = 'ProductX'
;

-- Q15
-- Qual o nome do departamento com a menor média de salário entre seus funcionários?
SELECT
    departamento.dnome
    ,round(avg(empregado.salario), 2)
FROM
    empregado
    JOIN departamento ON departamento.dnumero = empregado.dno
GROUP BY
    departamento.dnome
ORDER BY
    avg(empregado.salario) ASC
;
