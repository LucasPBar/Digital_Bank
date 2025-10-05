use digital_bank;

-- =========================================
-- 1. Recuperar todos os clientes ativos
-- Pergunta: Quem são os clientes com contas ativas no banco?
-- =========================================
SELECT id_cliente, nome, cpf, email, status
FROM Cliente
WHERE status = 'ativo';

-- =========================================
-- 2. Calcular idade dos clientes
-- Pergunta: Qual a idade atual de cada cliente?
-- =========================================
SELECT 
    nome,
    YEAR(CURDATE()) - YEAR(data_nascimento) 
        - (DATE_FORMAT(CURDATE(),'%m%d') < DATE_FORMAT(data_nascimento,'%m%d')) 
        AS idade
FROM Cliente
ORDER BY idade DESC;

-- =========================================
-- 3. Contas com saldo acima da média
-- Pergunta: Quais clientes possuem saldo maior que a média geral?
-- =========================================
SELECT c.id_conta, cli.nome, c.saldo_atual
FROM Conta c
JOIN Cliente cli ON c.id_cliente = cli.id_cliente
WHERE c.saldo_atual > (SELECT AVG(saldo_atual) FROM Conta)
ORDER BY c.saldo_atual DESC;

-- =========================================
-- 4. Top clientes por movimentação
-- Pergunta: Quais clientes mais enviaram dinheiro em transações?
-- =========================================
SELECT cli.nome, SUM(t.valor) AS total_enviado
FROM Transacao t
JOIN Conta c ON t.id_conta_origem = c.id_conta
JOIN Cliente cli ON c.id_cliente = cli.id_cliente
GROUP BY cli.nome
HAVING SUM(t.valor) > 300 -- exemplo: apenas quem movimentou mais de 300
ORDER BY total_enviado DESC;

-- =========================================
-- 5. Clientes inadimplentes em empréstimos
-- Pergunta: Quem são os clientes com empréstimos em status 'inadimplente'?
-- =========================================
SELECT cli.nome, e.valor_emprestimo, e.quantidade_parcelas, e.status
FROM Emprestimo e
JOIN Cliente cli ON e.id_cliente = cli.id_cliente
WHERE e.status = 'inadimplente';

-- =========================================
-- 6. Clientes com faturas atrasadas
-- Pergunta: Quais clientes possuem faturas atrasadas ou não pagas integralmente?
-- =========================================
SELECT cli.nome, f.mes_referencia, f.ano_referencia, f.valor_total, f.valor_pago, f.status_pagamento
FROM Fatura f
JOIN Cartao ca ON f.id_cartao = ca.id_cartao
JOIN Cliente cli ON ca.id_cliente = cli.id_cliente
WHERE f.status_pagamento IN ('atrasada','parcial');

-- =========================================
-- 7. Receita do banco com tarifas
-- Pergunta: Quanto o banco arrecadou em tarifas por tipo?
-- =========================================
SELECT tipo_tarifa, SUM(valor) AS total_receita
FROM Tarifa
GROUP BY tipo_tarifa
ORDER BY total_receita DESC;

-- =========================================
-- 8. Clientes com melhor score de crédito
-- Pergunta: Quais são os top 5 clientes com melhor score?
-- =========================================
SELECT cli.nome, r.score_credito
FROM Risco_Cliente r
JOIN Cliente cli ON r.id_cliente = cli.id_cliente
ORDER BY r.score_credito DESC
LIMIT 5;

-- =========================================
-- 9. Investimentos ativos por cliente
-- Pergunta: Quanto cada cliente tem investido em produtos ativos?
-- =========================================
SELECT cli.nome, SUM(i.valor_investido) AS total_investido
FROM Investimento i
JOIN Cliente cli ON i.id_cliente = cli.id_cliente
WHERE i.status = 'ativo'
GROUP BY cli.nome
ORDER BY total_investido DESC;

-- =========================================
-- Hipótese 01: Clientes com limite de cartão mais alto tendem a gastar mais.
-- Pergunta: Existe relação entre limite do cartão e o valor total gasto?
-- =========================================
SELECT 
    cli.nome,
    MAX(ca.limite_credito) AS limite_credito,  -- Assume o maior limite entre os cartões do cliente
    SUM(t.valor) AS total_gasto
FROM Transacao t
JOIN Conta c ON t.id_conta_origem = c.id_conta
JOIN Cliente cli ON c.id_cliente = cli.id_cliente
JOIN Cartao ca ON cli.id_cliente = ca.id_cliente
GROUP BY cli.id_cliente, cli.nome
ORDER BY total_gasto DESC;


-- =========================================
-- Hipótese 02: Clientes que têm investimentos ativos também concentram maiores saldos em conta.
-- Pergunta: Existe correlação entre valor investido e saldo em conta?
-- =========================================
SELECT 
    cli.nome,
    SUM(i.valor_investido) AS total_investido,
    SUM(c.saldo_atual) AS saldo_total
FROM Cliente cli
JOIN Conta c ON cli.id_cliente = c.id_cliente
LEFT JOIN Investimento i ON cli.id_cliente = i.id_cliente AND i.status = 'ativo'
GROUP BY cli.id_cliente, cli.nome
ORDER BY total_investido DESC, saldo_total DESC;

-- =========================================
-- Hipótese 03: Clientes que atrasam faturas de cartão são os mesmos que atrasam empréstimos.
-- Pergunta: Quantos clientes estão inadimplentes em ambos os produtos?
-- =========================================
SELECT cli.nome
FROM Cliente cli
JOIN Cartao ca ON cli.id_cliente = ca.id_cliente
JOIN Fatura f ON ca.id_cartao = f.id_cartao
JOIN Emprestimo e ON cli.id_cliente = e.id_cliente
WHERE f.status_pagamento = 'atrasada' AND e.status = 'inadimplente';

-- =========================================
-- Hipótese 04: A maior parte da receita de tarifas vem de clientes com baixo saldo.
-- Pergunta: Clientes com baixo saldo contribuem mais com tarifas?
-- =========================================
SELECT 
    CASE 
        WHEN c.saldo_atual < 1000 THEN 'Baixo saldo (< R$1.000)'
        WHEN c.saldo_atual BETWEEN 1000 AND 5000 THEN 'Médio saldo (R$1.000 - R$5.000)'
        ELSE 'Alto saldo (> R$5.000)'
    END AS faixa_saldo,
    COUNT(DISTINCT cli.id_cliente) AS qtd_clientes,
    SUM(tar.valor) AS total_tarifas
FROM Tarifa tar
JOIN Conta c ON tar.id_conta = c.id_conta
JOIN Cliente cli ON c.id_cliente = cli.id_cliente
GROUP BY faixa_saldo
ORDER BY total_tarifas DESC;

-- =========================================
-- Hipótese 05: Clientes com múltiplos produtos geram mais receita para o banco.
-- Pergunta: Existe relação entre diversificação de produtos e receita total de tarifas?
-- =========================================
SELECT cli.nome,
       (COUNT(DISTINCT c.id_conta) + COUNT(DISTINCT ca.id_cartao) + 
        COUNT(DISTINCT s.id_seguro) + COUNT(DISTINCT i.id_investimento)) AS total_produtos,
       SUM(tar.valor) AS receita_tarifas
FROM Cliente cli
LEFT JOIN Conta c ON cli.id_cliente = c.id_cliente
LEFT JOIN Cartao ca ON cli.id_cliente = ca.id_cliente
LEFT JOIN Seguros s ON cli.id_cliente = s.id_cliente
LEFT JOIN Investimento i ON cli.id_cliente = i.id_cliente
LEFT JOIN Tarifa tar ON c.id_conta = tar.id_conta
GROUP BY cli.nome
ORDER BY receita_tarifas DESC;

-- =========================================
-- Hipótese 06: Clientes com múltiplos produtos (investimentos, seguros, empréstimos) possuem um score de crédito maior e são menos propensos à inadimplência.
-- Pergunta: Clientes mais engajados com o banco (com mais produtos) representam um risco de crédito menor?
-- =========================================
SELECT
    c.id_cliente,
    c.nome,
    rc.score_credito,
    -- Contagem de produtos distintos por cliente
    (SELECT COUNT(DISTINCT tipo_investimento) FROM Investimento WHERE id_cliente = c.id_cliente AND status = 'ativo') AS qtd_investimentos_ativos,
    (SELECT COUNT(*) FROM Seguros WHERE id_cliente = c.id_cliente AND status = 'ativo') AS qtd_seguros_ativos,
    (SELECT COUNT(*) FROM Emprestimo WHERE id_cliente = c.id_cliente AND status = 'ativo') AS qtd_emprestimos_ativos,
    -- Verificação de inadimplência
    CASE
        WHEN EXISTS (SELECT 1 FROM Emprestimo WHERE id_cliente = c.id_cliente AND status = 'inadimplente')
        OR EXISTS (SELECT 1 FROM Fatura f JOIN Cartao ca ON f.id_cartao = ca.id_cartao WHERE ca.id_cliente = c.id_cliente AND f.status_pagamento = 'atrasada')
        THEN 'Sim'
        ELSE 'Não'
    END AS possui_inadimplencia
FROM
    Cliente c
JOIN
    Risco_Cliente rc ON c.id_cliente = rc.id_cliente
ORDER BY
    rc.score_credito DESC,
    qtd_investimentos_ativos DESC;

-- =========================================
-- Hipótese 07: O aumento do limite de crédito está diretamente relacionado a um bom histórico de pagamento de faturas, e não apenas ao tempo de conta.
-- Pergunta: A política de aumento de limite do banco está recompensando os bons pagadores ou se baseia em outros critérios menos seguros?
-- =========================================
WITH FaturaStats AS (
    -- Calcula o percentual de faturas pagas em dia por cartão
    SELECT
        id_cartao,
        COUNT(*) AS total_faturas,
        SUM(CASE WHEN status_pagamento = 'paga' THEN 1 ELSE 0 END) AS faturas_pagas_em_dia,
        -- Evita divisão por zero se um cartão não tiver faturas
        CASE
            WHEN COUNT(*) > 0 THEN (SUM(CASE WHEN status_pagamento = 'paga' THEN 1 ELSE 0 END) * 100.0 / COUNT(*))
            ELSE 0
        END AS perc_pago_em_dia
    FROM
        Fatura
    GROUP BY
        id_cartao
)
SELECT
    c.nome,
    ca.numero_cartao,
    lh.limite_anterior,
    lh.limite_novo,
    (lh.limite_novo - lh.limite_anterior) AS aumento,
    lh.motivo,
    COALESCE(fs.perc_pago_em_dia, 0) AS perc_pago_em_dia, -- Usa COALESCE para mostrar 0 se não houver faturas
    -- Corrigido o cálculo para usar a data de criação do cliente
    TIMESTAMPDIFF(MONTH, c.data_criacao_conta, lh.data_alteracao) AS meses_como_cliente
FROM
    Limite_Historico lh
JOIN
    Cartao ca ON lh.id_cartao = ca.id_cartao
JOIN
    Cliente c ON ca.id_cliente = c.id_cliente -- Apenas um JOIN em Cliente é necessário
LEFT JOIN
    FaturaStats fs ON lh.id_cartao = fs.id_cartao
WHERE
    lh.limite_novo > lh.limite_anterior -- Filtra apenas aumentos de limite
ORDER BY
    c.nome,
    lh.data_alteracao; -- Ordena por nome e data da alteração para ver a progressão

-- =========================================
-- Hipótese 08: Clientes que utilizam a conta para transações de maior valor (PIX, TED) são os que mais investem em produtos de maior risco, como Ações e FIIs.
-- Pergunta: O volume de transações de um cliente pode prever seu perfil de investidor (conservador vs. arrojado)?
-- =========================================
WITH TransacaoMedia AS (
    -- Calcula o valor médio das transações de saída por conta
    SELECT
        id_conta_origem,
        AVG(valor) AS valor_medio_transacao
    FROM
        Transacao
    WHERE
        tipo_transacao IN ('PIX', 'TED', 'DOC')
    GROUP BY
        id_conta_origem
)
SELECT
    c.nome,
    tm.valor_medio_transacao,
    i.tipo_investimento,
    i.valor_investido
FROM
    Cliente c
JOIN
    Conta co ON c.id_cliente = co.id_cliente
JOIN
    TransacaoMedia tm ON co.id_conta = tm.id_conta_origem
JOIN
    Investimento i ON c.id_cliente = i.id_cliente
WHERE
    i.tipo_investimento IN ('Acoes', 'FII') AND i.status = 'ativo'
ORDER BY
    tm.valor_medio_transacao DESC,
    i.valor_investido DESC;

-- =========================================
-- Hipótese 09: A taxa de cancelamento de seguros é maior em clientes com score de crédito mais baixo, que podem estar cortando custos.
-- Pergunta: Existe uma correlação entre a saúde financeira do cliente (score de crédito) e a retenção de produtos de seguro?
-- =========================================
SELECT
    'Cancelados' AS grupo,
    AVG(rc.score_credito) AS media_score_credito,
    COUNT(s.id_seguro) AS total_seguros
FROM
    Seguros s
JOIN
    Risco_Cliente rc ON s.id_cliente = rc.id_cliente
WHERE
    s.status IN ('cancelado', 'expirado')

UNION ALL

SELECT
    'Ativos' AS grupo,
    AVG(rc.score_credito) AS media_score_credito,
    COUNT(s.id_seguro) AS total_seguros
FROM
    Seguros s
JOIN
    Risco_Cliente rc ON s.id_cliente = rc.id_cliente
WHERE
    s.status = 'ativo';


