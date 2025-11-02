-- Criação do banco de dados
CREATE DATABASE IF NOT EXISTS detran_final;
USE detran_final;

-- 1. Tabelas independentes (sem FKs)
CREATE TABLE CATEGORIA (
    cod_categoria INT(2) PRIMARY KEY,
    nome VARCHAR(50) NOT NULL
);

CREATE TABLE MODELO (
    cod_modelo INT(6) PRIMARY KEY,
    nome VARCHAR(50) NOT NULL
);

CREATE TABLE PROPRIETARIO (
    cpf VARCHAR(11) PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    endereco VARCHAR(200),
    bairro VARCHAR(100),
    cidade VARCHAR(100),
    estado CHAR(2),
    sexo CHAR(1),
    data_nascimento DATE,
    idade INT,
    telefone VARCHAR(15)
);

CREATE TABLE AGENTE (
    matricula INT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    data_contratacao DATE,
    tempo_servico INT -- em meses
);

CREATE TABLE LOCAL (
    latitude DECIMAL(10, 8) NOT NULL,
    longitude DECIMAL(11, 8) NOT NULL,
    velocidade_permitida INT,
    PRIMARY KEY (latitude, longitude)
);

CREATE TABLE TIPO_INFRACAO (
    cod_tipo_infracao INT PRIMARY KEY,
    descricao VARCHAR(255) NOT NULL,
    valor DECIMAL(10, 2) NOT NULL
);

-- 7. Tabela VEICULO (depende de CATEGORIA, MODELO, PROPRIETARIO)
-- *** CHAVE PRIMÁRIA = CHASSI ***
CREATE TABLE VEICULO (
    chassi VARCHAR(17) PRIMARY KEY,
    placa VARCHAR(7) NOT NULL UNIQUE, -- Placa é um atributo obrigatório e único
    cor_predominante VARCHAR(50),
    ano_fabricacao INT(4),
    cod_categoria INT(2),
    cod_modelo INT(6),
    cpf_proprietario VARCHAR(11),
    
    FOREIGN KEY (cod_categoria) REFERENCES CATEGORIA(cod_categoria),
    FOREIGN KEY (cod_modelo) REFERENCES MODELO(cod_modelo),
    FOREIGN KEY (cpf_proprietario) REFERENCES PROPRIETARIO(cpf)
);

-- 8. Tabela INFRACAO (depende de VEICULO, TIPO_INFRACAO, AGENTE, LOCAL)
-- *** CHAVE PRIMÁRIA = ID_INFRACAO ***
-- *** CHAVE ESTRANGEIRA = CHASSI_VEICULO ***
CREATE TABLE INFRACAO (
    id_infracao INT PRIMARY KEY AUTO_INCREMENT,
    data_hora DATETIME NOT NULL,
    velocidade_aferida INT,
    
    -- Chaves Estrangeiras
    chassi_veiculo VARCHAR(17), -- Referencia a PK de VEICULO
    cod_tipo_infracao INT,
    matricula_agente INT,
    latitude_local DECIMAL(10, 8),
    longitude_local DECIMAL(11, 8),
    
    FOREIGN KEY (chassi_veiculo) REFERENCES VEICULO(chassi),
    FOREIGN KEY (cod_tipo_infracao) REFERENCES TIPO_INFRACAO(cod_tipo_infracao),
    FOREIGN KEY (matricula_agente) REFERENCES AGENTE(matricula),
    FOREIGN KEY (latitude_local, longitude_local) REFERENCES LOCAL(latitude, longitude)
);
