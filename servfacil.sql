CREATE DATABASE IF NOT EXISTS servfacil;
USE servfacil;

CREATE TABLE IF NOT EXISTS clientes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    telefone VARCHAR(15) NOT NULL,
    endereco VARCHAR(255) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    estado VARCHAR(50) NOT NULL,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS produtos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    estoque INT NOT NULL,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS servicos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    duracao INT NOT NULL,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS orcamentos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT NOT NULL,
    valor_total DECIMAL(10, 2) NOT NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'Pendente',
    observacoes TEXT,
    forma_pagamento TEXT NOT NULL,
    data_orcamento TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

CREATE TABLE IF NOT EXISTS orcamentos_produtos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    orcamento_id INT NOT NULL,
    produto_id INT NOT NULL,
    valor_unitario DECIMAL(10, 2),
    quantidade INT NOT NULL,
    valor_total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (orcamento_id) REFERENCES orcamentos(id),
    FOREIGN KEY (produto_id) REFERENCES produtos(id)
);

CREATE TABLE IF NOT EXISTS orcamentos_servicos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    orcamento_id INT NOT NULL,
    servico_id INT NOT NULL,
    valor_unitario DECIMAL(10, 2),
    quantidade INT NOT NULL,
    valor_total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (orcamento_id) REFERENCES orcamentos(id),
    FOREIGN KEY (servico_id) REFERENCES servicos(id)
);

CREATE TABLE IF NOT EXISTS ordem_servicos_produtos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    ordem_id INT NOT NULL,
    produto_id INT NOT NULL,
    valor_unitario DECIMAL(10, 2),
    quantidade INT NOT NULL,
    valor_total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (orcamento_id) REFERENCES orcamentosem(id),
    FOREIGN KEY (produto_id) REFERENCES produtos(id)
);

CREATE TABLE IF NOT EXISTS ordem_servicos_servicos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    ordem_id INT NOT NULL,
    servico_id INT NOT NULL,
    valor_unitario DECIMAL(10, 2),
    quantidade INT NOT NULL,
    valor_total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (orcamento_id) REFERENCES orcamentos(id),
    FOREIGN KEY (servico_id) REFERENCES servicos(id)
);

CREATE TABLE IF NOT EXISTS ordem_servico (
    id INT PRIMARY KEY AUTO_INCREMENT,
    orcamento_id INT NOT NULL,
    cliente_id INT NOT NULL,
    valor_total DECIMAL(10, 2) NOT NULL,
    forma_pagamento_id INT NOT NULL,
    data_inicio TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    status VARCHAR(50) NOT NULL DEFAULT 'Pendente',
    observacoes TEXT,
    data_fim TIMESTAMP,
    FOREIGN KEY (orcamento_id) REFERENCES orcamentos(id)
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);