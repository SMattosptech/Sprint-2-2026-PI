CREATE USER 'coffeecare_api_insert'@'localhost'
IDENTIFIED BY '123456';

GRANT INSERT ON coffeCare.medicao
TO 'coffeecare_api_insert'@'localhost';

FLUSH PRIVILEGES;



CREATE DATABASE coffeCare;
USE coffeCare;


CREATE TABLE empresa (
    id_empresa INT PRIMARY KEY AUTO_INCREMENT,
    nome_empresa VARCHAR(55) NOT NULL,
    cnpj CHAR(14) NOT NULL UNIQUE
);

CREATE TABLE usuario (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nome_usuario VARCHAR(60) NOT NULL,
    senha VARCHAR(45) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    tipo_usuario VARCHAR(30) NOT NULL,
    telefone CHAR(11),
    data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ativo TINYINT,
    fk_empresa INT NOT NULL,

    CONSTRAINT fk_usuario_empresa
        FOREIGN KEY (fk_empresa)
        REFERENCES empresa(id_empresa)
);

CREATE TABLE fazenda (
    id_fazenda INT PRIMARY KEY AUTO_INCREMENT,
    nome_fazenda VARCHAR(45) NOT NULL,
    area_total DECIMAL(10,2) NOT NULL,
    endereco VARCHAR(255) NOT NULL,
    cidade VARCHAR(20) NOT NULL,
    estado VARCHAR(20) NOT NULL,
    data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fk_empresa INT NOT NULL,

    CONSTRAINT fk_fazenda_empresa
        FOREIGN KEY (fk_empresa)
        REFERENCES empresa(id_empresa)
);

CREATE TABLE talhao (
    id_talhao INT PRIMARY KEY AUTO_INCREMENT,
    nome_talhao VARCHAR(45) NOT NULL,
    area DECIMAL(10,2) NOT NULL,
    cultivo VARCHAR(50) NOT NULL,
    fk_fazenda INT NOT NULL,

    CONSTRAINT fk_talhao_fazenda
        FOREIGN KEY (fk_fazenda)
        REFERENCES fazenda(id_fazenda),

    CONSTRAINT chk_cultivo
        CHECK (cultivo = 'Café Arábica')
);

CREATE TABLE sensor (
    id_sensor INT PRIMARY KEY AUTO_INCREMENT,
    status_sensor BOOLEAN NOT NULL DEFAULT TRUE,
    fk_talhao INT NOT NULL,

    CONSTRAINT fk_sensor_talhao
        FOREIGN KEY (fk_talhao)
        REFERENCES talhao(id_talhao)
);

CREATE TABLE medicao (
    id_medicao INT PRIMARY KEY AUTO_INCREMENT,
    data_hora DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    sensor_umidade INT NOT NULL,

    fk_sensor INT NULL,

    CONSTRAINT fk_medicao_sensor
        FOREIGN KEY (fk_sensor)
        REFERENCES sensor(id_sensor),

    CONSTRAINT chk_umidade_solo
        CHECK (sensor_umidade >= 0 AND sensor_umidade <= 100)
);

CREATE TABLE alerta (
    id_alerta INT PRIMARY KEY AUTO_INCREMENT,
    tipo_alerta VARCHAR(50) NOT NULL,
    data_hora DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fk_medicao INT NOT NULL,

    CONSTRAINT fk_alerta_medicao
        FOREIGN KEY (fk_medicao)
        REFERENCES medicao(id_medicao)
);