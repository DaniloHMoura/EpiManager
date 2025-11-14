-- =============================================
-- BANCO DE DADOS: epi1
-- SISTEMA: Gerenciamento Avançado de EPI
-- PIT II - 2025
-- =============================================

CREATE DATABASE IF NOT EXISTS epi1 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE epi1;

-- ------------------------------------------------
-- Tabela: empresas
-- ------------------------------------------------
CREATE TABLE IF NOT EXISTS empresas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    cnpj CHAR(18) NOT NULL UNIQUE,
    endereco TEXT,
    telefone VARCHAR(20),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- ------------------------------------------------
-- Tabela: usuarios
-- ------------------------------------------------
CREATE TABLE IF NOT EXISTS usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    empresa_id INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    login VARCHAR(50) NOT NULL UNIQUE,
    senha_hash VARCHAR(64) NOT NULL,
    nivel ENUM('admin', 'gestor', 'colaborador') DEFAULT 'colaborador',
    ativo BOOLEAN DEFAULT TRUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (empresa_id) REFERENCES empresas(id) ON DELETE CASCADE
);

-- ------------------------------------------------
-- Tabela: colaboradores
-- ------------------------------------------------
CREATE TABLE IF NOT EXISTS colaboradores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    empresa_id INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    matricula VARCHAR(20) NOT NULL UNIQUE,
    setor VARCHAR(50),
    funcao VARCHAR(50),
    senha_hash VARCHAR(64) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (empresa_id) REFERENCES empresas(id) ON DELETE CASCADE
);

-- ------------------------------------------------
-- Tabela: categorias
-- ------------------------------------------------
CREATE TABLE IF NOT EXISTS categorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    empresa_id INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    norma VARCHAR(50),
    FOREIGN KEY (empresa_id) REFERENCES empresas(id) ON DELETE CASCADE
);

-- ------------------------------------------------
-- Tabela: itens (EPI)
-- ------------------------------------------------
CREATE TABLE IF NOT EXISTS itens (
    id INT AUTO_INCREMENT PRIMARY KEY,
    categoria_id INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    ca VARCHAR(20) NOT NULL UNIQUE,
    estoque_min INT DEFAULT 5,
    estoque_atual INT DEFAULT 0,
    validade_ca DATE,
    fabricante VARCHAR(100),
    FOREIGN KEY (categoria_id) REFERENCES categorias(id) ON DELETE CASCADE
);

-- ------------------------------------------------
-- Tabela: movimentacoes
-- ------------------------------------------------
CREATE TABLE IF NOT EXISTS movimentacoes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    colaborador_id INT NOT NULL,
    item_id INT NOT NULL,
    tipo ENUM('retirada', 'devolucao') NOT NULL,
    quantidade INT NOT NULL,
    data_hora DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('pendente', 'confirmada', 'devolvida') DEFAULT 'pendente',
    observacao TEXT,
    FOREIGN KEY (colaborador_id) REFERENCES colaboradores(id) ON DELETE RESTRICT,
    FOREIGN KEY (item_id) REFERENCES itens(id) ON DELETE RESTRICT
);

-- ------------------------------------------------
-- Tabela: audit_logs
-- ------------------------------------------------
CREATE TABLE IF NOT EXISTS audit_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT,
    acao VARCHAR(50) NOT NULL,
    tabela_afetada VARCHAR(50),
    registro_id INT,
    detalhes TEXT,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE SET NULL
);

-- ------------------------------------------------
-- Índices para performance
-- ------------------------------------------------
CREATE INDEX idx_mov_colaborador ON movimentacoes(colaborador_id);
CREATE INDEX idx_mov_item ON movimentacoes(item_id);
CREATE INDEX idx_mov_data ON movimentacoes(data_hora);
CREATE INDEX idx_audit_acao ON audit_logs(acao);
