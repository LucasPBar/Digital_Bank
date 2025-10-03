
USE digital_bank;

-- =========================================
-- POPULANDO CLIENTES 
-- =========================================
INSERT INTO Cliente (nome, cpf, data_nascimento, email, telefone, endereco, status)
VALUES
('Lucas Pimenta','12345678901','1998-05-18','lucas.pimenta@gmail.com','(11)99999-0001','Rua A, 123, SP','ativo'),
('Maria Souza','23456789012','1985-08-22','maria.souza@gmail.com','(21)98888-1111','Rua B, 456, RJ','ativo'),
('João Silva','34567890123','1992-11-10','joao.silva@gmail.com','(31)97777-2222','Rua C, 789, MG','ativo'),
('Ana Oliveira','45678901234','1975-02-05','ana.oliveira@gmail.com','(41)96666-3333','Rua D, 101, PR','ativo'),
('Carlos Pereira','56789012345','1988-07-15','carlos.pereira@gmail.com','(51)95555-4444','Rua E, 202, RS','ativo'),
('Beatriz Costa','67890123456','2000-03-30','beatriz.costa@gmail.com','(61)94444-5555','Rua F, 303, DF','ativo'),
('Rafael Almeida','78901234567','1995-12-20','rafael.almeida@gmail.com','(71)93333-6666','Rua G, 404, BA','ativo'),
('Juliana Martins','89012345678','1982-09-12','juliana.martins@gmail.com','(81)92222-7777','Rua H, 505, PE','ativo'),
('Pedro Santos','90123456789','1990-06-25','pedro.santos@gmail.com','(91)91111-8888','Rua I, 606, PA','ativo'),
('Carla Fernandes','01234567890','1978-01-10','carla.fernandes@gmail.com','(11)90000-9999','Rua J, 707, SP','ativo'),
('Fernanda Lima','11223344556','1993-04-12','fernanda.lima@example.com','(85)98765-4321','Rua K, 111, CE','ativo'),
('Bruno Gomes','22334455667','1980-09-25','bruno.gomes@example.com','(92)91234-5678','Rua L, 222, AM','inativo'),
('Sandra Rocha','33445566778','2001-01-20','sandra.rocha@example.com','(48)95555-8765','Rua M, 333, SC','ativo'),
('Ricardo Nunes','44556677889','1979-11-30','ricardo.nunes@example.com','(27)99988-7766','Rua N, 444, ES','bloqueado'),
('Patricia Melo','55667788990','1996-07-07','patricia.melo@example.com','(62)98877-6655','Rua O, 555, GO','ativo');

-- =========================================
-- POPULANDO CONTAS 
-- =========================================
INSERT INTO Conta (id_cliente, tipo_conta, saldo_atual, status)
VALUES
(1,'corrente',5000.00,'ativa'),
(2,'corrente',1200.00,'ativa'),
(3,'poupanca',3000.00,'ativa'),
(4,'corrente',2500.00,'ativa'),
(5,'pagamento',800.00,'ativa'),
(6,'corrente',1500.00,'ativa'),
(7,'corrente',6000.00,'ativa'),
(8,'poupanca',4000.00,'ativa'),
(9,'corrente',700.00,'ativa'),
(10,'pagamento',1000.00,'ativa'),
(11,'corrente',3250.75,'ativa'),
(12,'poupanca',15000.00,'bloqueada'),
(13,'pagamento',450.50,'ativa'),
(14,'corrente',0.00,'encerrada'),
(15,'corrente',7800.25,'ativa'),
(1,'poupanca',10000.00,'ativa'), -- Cliente 1 com segunda conta
(7,'poupanca',25000.00,'ativa'); -- Cliente 7 com segunda conta

-- =========================================
-- POPULANDO CARTOES 
-- =========================================
INSERT INTO Cartao (id_cliente, numero_cartao, tipo_cartao, limite_credito, saldo_disponivel, validade, status)
VALUES
(1,'1111222233334444','credito',2000.00,2000.00,'2026-12-31','ativo'),
(2,'2222333344445555','credito',1500.00,1500.00,'2025-11-30','ativo'),
(3,'3333444455556666','debito',0.00,3000.00,'2027-01-31','ativo'),
(4,'4444555566667777','credito',2500.00,2500.00,'2026-10-30','ativo'),
(5,'5555666677778888','debito',0.00,800.00,'2025-09-30','ativo'),
(6,'6666777788889999','credito',1000.00,1000.00,'2027-03-31','ativo'),
(7,'7777888899990000','credito',5000.00,5000.00,'2026-07-31','ativo'),
(8,'8888999900001111','debito',0.00,4000.00,'2027-05-31','ativo'),
(9,'9999000011112222','credito',1200.00,1200.00,'2025-08-31','ativo'),
(10,'0000111122223333','debito',0.00,1000.00,'2026-04-30','ativo'),
(11,'1212343456567878','credito',3000.00,2500.00,'2028-01-31','ativo'),
(12,'2323454567678989','debito',0.00,15000.00,'2027-06-30','bloqueado'),
(13,'3434565678789090','credito',1800.00,1800.00,'2026-05-31','ativo'),
(15,'4545676789890101','credito',7500.00,7000.00,'2028-08-31','ativo'),
(1,'5656787890901212','debito',0.00,5000.00,'2027-11-30','ativo'), -- Segundo cartão para cliente 1
(4,'6767898901012323','debito',0.00,2500.00,'2026-02-28','cancelado'); -- Cartão cancelado

-- =========================================
-- POPULANDO FATURAS 
-- =========================================
INSERT INTO Fatura (id_cartao, mes_referencia, ano_referencia, valor_total, valor_pago, data_vencimento, status_pagamento)
VALUES
(1,9,2025,1500.00,1500.00,'2025-09-15','paga'),
(2,9,2025,800.00,400.00,'2025-09-20','parcial'),
(4,9,2025,2200.00,0.00,'2025-09-10','atrasada'),
(6,9,2025,900.00,900.00,'2025-09-22','paga'),
(7,9,2025,4000.00,2000.00,'2025-09-28','parcial'),
(9,9,2025,1200.00,1200.00,'2025-09-14','paga'),
(1,10,2025,550.75,0.00,'2025-10-15','aberta'),
(2,10,2025,400.00,0.00,'2025-10-20','aberta'),
(4,10,2025,1800.50,1800.50,'2025-10-10','paga'),
(7,10,2025,2000.00,0.00,'2025-10-28','aberta'),
(11,9,2025,500.00,500.00,'2025-09-25','paga'),
(11,10,2025,1250.00,0.00,'2025-10-25','aberta'),
(13,10,2025,345.80,0.00,'2025-10-18','aberta'),
(14,10,2025,500.00,0.00,'2025-10-21','atrasada');

-- =========================================
-- POPULANDO EMPRESTIMOS (DADOS ORIGINAIS + NOVOS)
-- =========================================
INSERT INTO Emprestimo (id_cliente, valor_emprestimo, taxa_juros, quantidade_parcelas, valor_parcela, data_inicio, data_fim, status)
VALUES
(1,10000.00,2.5,12,875.00,'2025-01-01','2025-12-01','ativo'),
(2,5000.00,3.0,6,875.00,'2025-03-01','2025-08-01','inadimplente'),
(3,15000.00,1.8,10,1600.00,'2025-02-15','2025-12-15','ativo'),
(4,2000.00,2.0,4,520.00,'2025-04-01','2025-07-01','quitado'),
(5,8000.00,2.2,8,1025.00,'2025-01-20','2025-09-20','ativo'),
(6,12000.00,2.5,12,1085.00,'2025-05-01','2026-04-01','ativo'),
(7,3000.00,3.1,6,535.00,'2025-06-01','2025-11-01','inadimplente'),
(8,10000.00,2.7,10,1300.00,'2025-07-01','2026-04-01','ativo'),
(9,4000.00,2.9,5,850.00,'2025-02-01','2025-06-01','quitado'),
(10,6000.00,2.4,6,1050.00,'2025-03-10','2025-09-10','ativo'),
(11,25000.00,1.9,24,1255.00,'2025-08-15','2027-07-15','ativo'),
(13,5000.00,2.8,12,480.00,'2025-09-01','2026-08-01','ativo'),
(15,50000.00,1.5,36,1735.00,'2025-07-20','2028-06-20','ativo'),
(1,15000.00,2.1,18,975.00,'2025-10-01','2027-03-01','ativo'); -- Segundo empréstimo para cliente 1

-- =========================================
-- PAGAMENTOS DE EMPRESTIMOS 
-- =========================================
INSERT INTO PagamentoEmprestimo (id_emprestimo, parcela_numero, valor_pago, data_pagamento, status)
VALUES
-- Dados Originais
(1,1,875.00,'2025-02-01','pago'),
(1,2,875.00,'2025-03-01','pago'),
(2,1,875.00,'2025-04-01','atrasado'),
(2,2,875.00,NULL,'pendente'),
(3,1,1600.00,'2025-03-15','pago'),
(4,1,520.00,'2025-05-01','pago'),
(7,1,535.00,NULL,'pendente'),
(1,3,875.00,'2025-04-01','pago'),
(1,4,875.00,'2025-05-01','pago'),
(1,5,875.00,'2025-06-01','pago'),
(1,6,875.00,'2025-07-01','pago'),
(1,7,875.00,'2025-08-01','pago'),
(1,8,875.00,'2025-09-01','pago'),
(3,2,1600.00,'2025-04-15','pago'),
(3,3,1600.00,'2025-05-15','pago'),
(5,1,1025.00,'2025-02-20','pago'),
(5,2,1025.00,'2025-03-20','pago'),
(5,3,1025.00,'2025-04-20','atrasado'),
(11,1,1255.00,'2025-09-15','pago'),
(12,1,480.00,NULL,'pendente');

-- =========================================
-- POPULANDO TRANSACOES 
-- =========================================
INSERT INTO Transacao (id_conta_origem, id_conta_destino, tipo_transacao, valor, descricao)
VALUES
-- Dados Originais
(1,2,'PIX',200.00,'Pagamento entre amigos'),
(2,3,'TED',500.00,'Transferência entre contas'),
(3,NULL,'saque',100.00,'Saque caixa eletrônico'),
(4,5,'deposito',300.00,'Depósito em dinheiro'),
(6,1,'PIX',450.00,'Pagamento de fatura'),
(7,8,'boleto',1200.00,'Pagamento de boleto'),
(9,10,'pagamento',200.00,'Pagamento cartão'),
(1,3,'DOC',150.00,'Transferência DOC'),
(5,2,'PIX',80.00,'Transferência entre contas'),
(8,7,'TED',500.00,'Transferência entre contas'),
(11,13,'PIX',150.25,'Presente de aniversário'),
(15,NULL,'saque',500.00,'Saque para despesas'),
(1,16,'TED',2000.00,'Aplicação em poupança'),
(17,7,'PIX',350.00,'Reembolso de jantar'),
(6,NULL,'deposito',1000.00,'Depósito de salário'),
(2,NULL,'saque',50.00,'Saque emergencial'),
(11,1,'boleto',750.00,'Pagamento aluguel'),
(15,17,'DOC',1200.00,'Transferência familiar');

-- =========================================
-- POPULANDO INVESTIMENTOS 
-- =========================================
INSERT INTO Investimento (id_cliente, tipo_investimento, valor_investido, status)
VALUES
-- Dados Originais
(1,'CDB',5000.00,'ativo'),
(2,'Tesouro',2000.00,'ativo'),
(3,'Acoes',3000.00,'resgatado'),
(4,'FII',4000.00,'ativo'),
(5,'CDB',1500.00,'ativo'),
(6,'Tesouro',2500.00,'ativo'),
(7,'Acoes',3500.00,'ativo'),
(8,'FII',4500.00,'resgatado'),
(9,'CDB',1000.00,'ativo'),
(10,'Tesouro',3000.00,'ativo'),
(11,'Acoes',10000.00,'ativo'),
(12,'CDB',25000.00,'cancelado'),
(13,'Tesouro',5000.00,'ativo'),
(15,'FII',50000.00,'ativo'),
(1,'Acoes',15000.00,'ativo'),
(4,'CDB',20000.00,'ativo'),
(7,'Tesouro',12000.00,'resgatado');

-- =========================================
-- POPULANDO MOVIMENTOS DE INVESTIMENTOS 
-- =========================================
INSERT INTO Movimento_Investimento (id_investimento, tipo_movimento, valor)
VALUES
-- Dados Originais
(1,'compra',5000.00),
(2,'compra',2000.00),
(3,'resgate',3000.00),
(4,'compra',4000.00),
(5,'compra',1500.00),
(6,'compra',2500.00),
(7,'compra',3500.00),
(8,'resgate',4500.00),
(9,'compra',1000.00),
(10,'compra',3000.00),
(1,'rendimento',50.25),
(2,'rendimento',25.10),
(4,'compra',1000.00),
(7,'resgate',500.00),
(11,'compra',10000.00),
(13,'compra',5000.00),
(14,'compra',50000.00),
(15,'compra',15000.00),
(16,'compra',20000.00),
(17,'resgate',12000.00),
(11,'rendimento',320.50);

-- =========================================
-- POPULANDO SEGUROS 
-- =========================================
INSERT INTO Seguros (id_cliente, tipo_seguro, valor_seguro, status)
VALUES
-- Dados Originais
(1,'vida',100000.00,'ativo'),
(2,'automovel',50000.00,'ativo'),
(3,'saude',20000.00,'cancelado'),
(4,'residencial',150000.00,'ativo'),
(5,'vida',120000.00,'ativo'),
(6,'automovel',70000.00,'ativo'),
(7,'saude',30000.00,'ativo'),
(8,'residencial',100000.00,'cancelado'),
(9,'vida',90000.00,'ativo'),
(10,'automovel',60000.00,'ativo'),
(11,'residencial',250000.00,'ativo'),
(13,'saude',45000.00,'ativo'),
(15,'vida',500000.00,'ativo'),
(15,'automovel',150000.00,'ativo'),
(2,'residencial',80000.00,'expirado'),
(1,'automovel',95000.00,'ativo');

-- =========================================
-- POPULANDO TARIFAS 
-- =========================================
INSERT INTO Tarifa (id_conta, tipo_tarifa, valor)
VALUES
-- Dados Originais
(1,'manutencao',15.00),
(2,'saque',5.00),
(3,'transferencia',10.00),
(4,'boleto',8.00),
(5,'manutencao',12.00),
(6,'transferencia',7.00),
(7,'saque',20.00),
(8,'boleto',15.00),
(9,'manutencao',10.00),
(10,'transferencia',5.00),
(11,'manutencao',15.00),
(13,'saque',5.00),
(15,'transferencia',10.00),
(16,'boleto',8.00),
(17,'manutencao',15.00),
(1,'saque',5.00),
(2,'transferencia',10.00),
(7,'boleto',8.00);

-- =========================================
-- POPULANDO RISCO_CLIENTE 
-- =========================================
INSERT INTO Risco_Cliente (id_cliente, score_credito, observacoes)
VALUES
-- Dados Originais
(1,850,'Cliente com bom histórico de crédito'),
(2,600,'Cliente com histórico médio'),
(3,400,'Cliente com risco elevado'),
(4,900,'Cliente com excelente crédito'),
(5,700,'Cliente com histórico aceitável'),
(6,650,'Cliente com risco moderado'),
(7,300,'Cliente com risco alto'),
(8,750,'Cliente com bom histórico'),
(9,950,'Cliente com excelente crédito'),
(10,500,'Cliente com risco médio'),
(11,880,'Excelente pagador, baixo risco'),
(12,550,'Inativo, risco a ser reavaliado'),
(13,720,'Bom histórico, potencial de aumento de limite'),
(14,250,'Bloqueado por inadimplência, alto risco'),
(15,920,'Cliente premium, histórico impecável');

-- =========================================
-- POPULANDO LOGIN_CLIENTE 
-- =========================================
INSERT INTO Login_Cliente (id_cliente, tentativas_falhas, status)
VALUES
-- Dados Originais
(1,0,'ativo'),
(2,1,'ativo'),
(3,3,'bloqueado'),
(4,0,'ativo'),
(5,2,'ativo'),
(6,0,'ativo'),
(7,4,'bloqueado'),
(8,0,'ativo'),
(9,1,'ativo'),
(10,0,'ativo'),
(11,0,'ativo'),
(12,0,'ativo'),
(13,1,'ativo'),
(14,5,'bloqueado'),
(15,0,'ativo');

-- =========================================
-- POPULANDO LIMITE_HISTORICO 
-- =========================================
INSERT INTO Limite_Historico (id_cartao, limite_anterior, limite_novo, motivo)
VALUES
-- Dados Originais
(1,1500.00,2000.00,'Aumento de limite por bom histórico'),
(2,1200.00,1500.00,'Aumento de limite por tempo de conta'),
(4,2000.00,2500.00,'Aumento de limite solicitado pelo cliente'),
(6,800.00,1000.00,'Ajuste automático do limite'),
(7,4000.00,5000.00,'Revisão anual do limite'),
(11,2000.00,3000.00,'Aumento por solicitação do cliente'),
(14,5000.00,7500.00,'Aumento por excelente histórico de pagamentos'),
(1,2000.00,2500.00,'Ajuste de perfil de crédito'),
(9,1200.00,1500.00,'Revisão semestral de limite'),
(13,1500.00,1800.00,'Aumento por bom uso do cartão');

-- =========================================
-- POPULANDO AUDITORIA 
-- =========================================
INSERT INTO Auditoria (tabela_afetada, id_registro_afetado, tipo_acao, usuario_responsavel, descricao)
VALUES
-- Dados Originais
('Conta',1,'update','admin','Alteração de saldo'),
('Cartao',2,'update','admin','Atualização de limite do cartão'),
('Emprestimo',3,'insert','analista','Novo empréstimo aprovado'),
('Fatura',4,'delete','sistema','Fatura cancelada por pagamento incorreto'),
('Cliente',14,'update','sistema','Status alterado para bloqueado por risco'),
('Conta',12,'update','gerente','Conta bloqueada por inatividade'),
('Cartao',16,'update','cliente','Cartão cancelado a pedido do cliente'),
('Emprestimo',11,'insert','analista','Concessão de novo empréstimo de alto valor'),
('Login_Cliente',7,'update','sistema','Bloqueio de login por excesso de tentativas');

-- =========================================
-- Verificando se as tabelas foram geradas corretamente
-- =========================================

select * from Cliente;
select * from Conta;
select * from Cartao;
select * from Fatura;
select * from Emprestimo;
select * from PagamentoEmprestimo;
select * from Transacao;
select * from Investimento;
select * from Movimento_Investimento;
select * from Seguros;
select * from Tarifa;
select * from Risco_Cliente;
select* from Login_Cliente;
select * from Limite_Historico;
select * from Auditoria;