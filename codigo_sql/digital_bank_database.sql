CREATE DATABASE IF NOT EXISTS digital_bank;

-- drop database digital_bank;

use digital_bank;

-- =========================================
-- TABELA CLIENTE
-- Cadastro completo de clientes da fintech
-- =========================================
CREATE TABLE Cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Identificador único do cliente',
    nome VARCHAR(100) NOT NULL COMMENT 'Nome completo do cliente',
    cpf CHAR(11) UNIQUE NOT NULL COMMENT 'CPF único do cliente',
    data_nascimento DATE NOT NULL COMMENT 'Data de nascimento do cliente',
    email VARCHAR(100) UNIQUE NOT NULL COMMENT 'E-mail único do cliente',
    telefone VARCHAR(15) COMMENT 'Telefone do cliente',
    endereco VARCHAR(200) COMMENT 'Endereço completo do cliente',
    data_criacao_conta TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Data de criação da conta',
    status ENUM('ativo','inativo','bloqueado') DEFAULT 'ativo' COMMENT 'Status da conta do cliente',
    CONSTRAINT chk_nome CHECK (nome <> '')  -- Nome não pode ser vazio
);

alter table Cliente auto_increment=1;

desc Cliente;

-- =========================================
-- TABELA CONTA
-- Conta bancária do cliente
-- =========================================
CREATE TABLE Conta (
    id_conta INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Identificador único da conta',
    id_cliente INT NOT NULL COMMENT 'FK do cliente proprietário da conta',
    tipo_conta ENUM('corrente','poupanca','pagamento') NOT NULL COMMENT 'Tipo de conta',
    saldo_atual DECIMAL(15,2) DEFAULT 0.00 CHECK (saldo_atual >= 0) COMMENT 'Saldo atual da conta',
    data_abertura TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Data de abertura da conta',
    status ENUM('ativa','bloqueada','encerrada') DEFAULT 'ativa' COMMENT 'Status da conta',
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

alter table Conta auto_increment=1;

desc Conta;

-- =========================================
-- TABELA TRANSACAO
-- Movimentações financeiras
-- =========================================
CREATE TABLE Transacao (
    id_transacao INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Identificador da transação',
    id_conta_origem INT NOT NULL COMMENT 'Conta de origem da transação',
    id_conta_destino INT COMMENT 'Conta destino da transação',
    modelo_transacao ENUM('PIX','TED','DOC','boleto','saque','deposito','pagamento') NOT NULL COMMENT 'modelo_transação',
    tipo_transacao ENUM('entrada','saida') NOT NULL COMMENT 'Tipo de transação',
    valor DECIMAL(15,2) NOT NULL CHECK (valor > 0) COMMENT 'Valor da transação',
    data_transacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Data e hora da transação',
    descricao VARCHAR(255) COMMENT 'Descrição opcional da transação',
    FOREIGN KEY (id_conta_origem) REFERENCES Conta(id_conta)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    FOREIGN KEY (id_conta_destino) REFERENCES Conta(id_conta)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

alter table Transacao auto_increment=1;

desc Transacao;

-- =========================================
-- TABELA CARTAO
-- Cartões de débito e crédito vinculados ao cliente
-- =========================================
CREATE TABLE Cartao (
    id_cartao INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Identificador do cartão',
    id_cliente INT NOT NULL COMMENT 'FK do cliente proprietário do cartão',
    numero_cartao CHAR(16) UNIQUE NOT NULL COMMENT 'Número do cartão único',
    tipo_cartao ENUM('credito','debito') NOT NULL COMMENT 'Tipo do cartão',
    limite_credito DECIMAL(15,2) DEFAULT 0.00 CHECK (limite_credito >= 0) COMMENT 'Limite do cartão (para crédito)',
    saldo_disponivel DECIMAL(15,2) DEFAULT 0.00 CHECK (saldo_disponivel >= 0) COMMENT 'Saldo disponível',
    validade DATE NOT NULL COMMENT 'Data de validade do cartão',
    status ENUM('ativo','bloqueado','cancelado') DEFAULT 'ativo' COMMENT 'Status do cartão',
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

alter table Cartao auto_increment=1;

desc Cartao;

-- =========================================
-- TABELA FATURA
-- Faturas mensais de cartões de crédito (Controle da fatura de cada cliente)
-- =========================================
CREATE TABLE Fatura (
    id_fatura INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Identificador da fatura',
    id_cartao INT NOT NULL COMMENT 'FK do cartão',
    mes_referencia INT NOT NULL CHECK (mes_referencia BETWEEN 1 AND 12) COMMENT 'Mês de referência da fatura',
    ano_referencia INT NOT NULL CHECK (ano_referencia >= 2000) COMMENT 'Ano de referência da fatura',
    valor_total DECIMAL(15,2) DEFAULT 0.00 CHECK (valor_total >= 0) COMMENT 'Valor total da fatura',
    valor_pago DECIMAL(15,2) DEFAULT 0.00 CHECK (valor_pago >= 0) COMMENT 'Valor pago da fatura',
    data_vencimento DATE NOT NULL COMMENT 'Data de vencimento',
    status_pagamento ENUM('aberta','paga','atrasada','parcial') DEFAULT 'aberta' COMMENT 'Status do pagamento',
    FOREIGN KEY (id_cartao) REFERENCES Cartao(id_cartao)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

alter table Fatura auto_increment=1;

desc Fatura;

-- =========================================
-- TABELA EMPRESTIMO
-- Empréstimos concedidos aos clientes
-- =========================================
CREATE TABLE Emprestimo (
    id_emprestimo INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Identificador do empréstimo',
    id_cliente INT NOT NULL COMMENT 'FK do cliente',
    valor_emprestimo DECIMAL(15,2) NOT NULL CHECK (valor_emprestimo > 0) COMMENT 'Valor total do empréstimo',
    taxa_juros DECIMAL(5,2) NOT NULL CHECK (taxa_juros >= 0) COMMENT 'Taxa de juros do empréstimo',
    quantidade_parcelas INT NOT NULL CHECK (quantidade_parcelas > 0) COMMENT 'Número de parcelas',
    valor_parcela DECIMAL(15,2) NOT NULL CHECK (valor_parcela > 0) COMMENT 'Valor de cada parcela',
    data_inicio DATE NOT NULL COMMENT 'Data de início do empréstimo',
    data_fim DATE COMMENT 'Data final do empréstimo',
    status ENUM('ativo','quitado','inadimplente') DEFAULT 'ativo' COMMENT 'Status do empréstimo',
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

alter table Emprestimo auto_increment=1;

desc Emprestimo;

-- =========================================
-- TABELA PAGAMENTO_EMPRESSTIMO
-- Cada parcela paga pelo cliente
-- =========================================
CREATE TABLE PagamentoEmprestimo (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Identificador do pagamento',
    id_emprestimo INT NOT NULL COMMENT 'FK do empréstimo',
    parcela_numero INT NOT NULL CHECK (parcela_numero > 0) COMMENT 'Número da parcela',
    valor_pago DECIMAL(15,2) NOT NULL CHECK (valor_pago >= 0) COMMENT 'Valor pago da parcela',
    data_pagamento DATE COMMENT 'Data de pagamento',
    status ENUM('pago','atrasado','pendente') DEFAULT 'pendente' COMMENT 'Status da parcela',
    FOREIGN KEY (id_emprestimo) REFERENCES Emprestimo(id_emprestimo)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

alter table PagamentoEmprestimo auto_increment=1;

desc PagamentoEmprestimo;

-- =========================================
-- TABELA LOGIN_CLIENTE
-- Histórico de logins e tentativas falhas
-- =========================================
CREATE TABLE Login_Cliente (
    id_login INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Identificador do login',
    id_cliente INT NOT NULL COMMENT 'FK do cliente',
    ultima_entrada TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Última entrada registrada',
    tentativas_falhas INT DEFAULT 0 CHECK(tentativas_falhas >= 0) COMMENT 'Número de tentativas falhas de login',
    status ENUM('ativo','bloqueado') DEFAULT 'ativo' COMMENT 'Status de acesso do cliente',
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

alter table Login_Cliente auto_increment=1;

desc Login_Cliente;

-- =========================================
-- TABELA LIMITE_HISTORICO
-- Histórico de alterações de limite de cartão ou conta
-- =========================================
CREATE TABLE Limite_Historico (
    id_limite INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Identificador do histórico de limite',
    id_cartao INT NOT NULL COMMENT 'FK do cartão',
    limite_anterior DECIMAL(15,2) NOT NULL CHECK (limite_anterior >= 0) COMMENT 'Limite anterior',
    limite_novo DECIMAL(15,2) NOT NULL CHECK (limite_novo >= 0) COMMENT 'Novo limite',
    data_alteracao TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Data da alteração',
    motivo VARCHAR(255) COMMENT 'Motivo da alteração',
    FOREIGN KEY (id_cartao) REFERENCES Cartao(id_cartao)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

alter table Limite_Historico auto_increment=1;

desc Limite_Historico;

-- =========================================
-- TABELA RISCO_CLIENTE
-- Score de crédito e análise de risco
-- =========================================
CREATE TABLE Risco_Cliente (
    id_risco INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Identificador do risco',
    id_cliente INT NOT NULL COMMENT 'FK do cliente',
    score_credito INT NOT NULL CHECK(score_credito BETWEEN 0 AND 1000) COMMENT 'Score de crédito do cliente',
    data_avaliacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Data da avaliação',
    observacoes VARCHAR(255) COMMENT 'Observações sobre risco do cliente',
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

alter table Risco_Cliente auto_increment=1;

desc Risco_Cliente;

-- =========================================
-- TABELA TARIFA
-- Registro de tarifas cobradas aos clientes (manutenção, saques, transferências, boletos)
-- =========================================
CREATE TABLE Tarifa (
    id_tarifa INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Identificador da tarifa',
    id_conta INT NOT NULL COMMENT 'FK da conta que foi cobrada',
    tipo_tarifa ENUM('manutencao','saque','transferencia','boleto') NOT NULL COMMENT 'Tipo de tarifa',
    valor DECIMAL(15,2) NOT NULL CHECK(valor >= 0) COMMENT 'Valor da tarifa cobrada',
    data_cobranca TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Data da cobrança',
    FOREIGN KEY (id_conta) REFERENCES Conta(id_conta)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

alter table Tarifa auto_increment=1;

desc Tarifa;

-- =========================================
-- TABELA INVESTIMENTO
-- Produtos de investimento vinculados ao cliente (CDB, Tesouro, FII, Ações)
-- =========================================
CREATE TABLE Investimento (
    id_investimento INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Identificador do investimento',
    id_cliente INT NOT NULL COMMENT 'FK do cliente proprietário',
    tipo_investimento ENUM('CDB','Tesouro','FII','Acoes') NOT NULL COMMENT 'Tipo de investimento',
    valor_investido DECIMAL(15,2) NOT NULL CHECK(valor_investido >= 0) COMMENT 'Valor aplicado no investimento',
    data_inicio TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Data de início do investimento',
    status ENUM('ativo','resgatado','cancelado') DEFAULT 'ativo' COMMENT 'Status do investimento',
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

alter table Investimento auto_increment=1;

desc Investimento;

-- =========================================
-- TABELA MOVIMENTO_INVESTIMENTO
-- Movimentações financeiras em investimentos (compra, resgate, rendimento)
-- =========================================
CREATE TABLE Movimento_Investimento (
    id_movimento INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Identificador do movimento do investimento',
    id_investimento INT NOT NULL COMMENT 'FK do investimento',
    tipo_movimento ENUM('compra','resgate','rendimento') NOT NULL COMMENT 'Tipo de movimentação',
    valor DECIMAL(15,2) NOT NULL CHECK(valor >= 0) COMMENT 'Valor da movimentação',
    data_movimento TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Data e hora da movimentação',
    FOREIGN KEY (id_investimento) REFERENCES Investimento(id_investimento)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

alter table Movimento_Investimento auto_increment=1;

-- =========================================
-- TABELA SEGUROS
-- Apólices contratadas pelo cliente (vida, residencial, automóvel, saúde)
-- =========================================
CREATE TABLE Seguros (
    id_seguro INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Identificador do seguro',
    id_cliente INT NOT NULL COMMENT 'FK do cliente',
    tipo_seguro ENUM('vida','residencial','automovel','saude') NOT NULL COMMENT 'Tipo de seguro',
    valor_seguro DECIMAL(15,2) NOT NULL CHECK(valor_seguro >= 0) COMMENT 'Valor da apólice',
    data_inicio TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Data de início do seguro',
    data_fim DATE COMMENT 'Data final da apólice',
    status ENUM('ativo','cancelado','expirado') DEFAULT 'ativo' COMMENT 'Status da apólice',
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

alter table Seguros auto_increment=1;

-- =========================================
-- TABELA AUDITORIA
-- Registro de alterações críticas em contas, cartões e empréstimos
-- =========================================
CREATE TABLE Auditoria (
    id_auditoria INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Identificador da auditoria',
    tabela_afetada VARCHAR(50) NOT NULL COMMENT 'Nome da tabela afetada',
    id_registro_afetado INT NOT NULL COMMENT 'ID do registro alterado',
    tipo_acao ENUM('insert','update','delete') NOT NULL COMMENT 'Tipo de ação realizada',
    usuario_responsavel VARCHAR(100) COMMENT 'Usuário que realizou a ação',
    data_acao TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Data e hora da ação',
    descricao VARCHAR(255) COMMENT 'Descrição detalhada da alteração'
);

alter table Auditoria auto_increment=1;
