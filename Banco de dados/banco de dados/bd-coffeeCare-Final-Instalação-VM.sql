CREATE DATABASE coffeCare;
USE coffeCare;


CREATE USER 'root_coffecareI'@'%'
IDENTIFIED BY 'Urubu100&';

GRANT ALL PRIVILEGES ON coffeCare.*
TO 'root_coffecareI'@'%';

CREATE USER 'coffeecare_api_insert'@'%'
IDENTIFIED BY '123456';

GRANT INSERT ON coffeCare.medicao
TO 'coffeecare_api_insert'@'%';


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
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    ativo TINYINT,
    fk_empresa INT NOT NULL,
    cpf CHAR(11) NOT NULL,
    CONSTRAINT fk_usuario_empresa
        FOREIGN KEY (fk_empresa) REFERENCES empresa(id_empresa)
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
        FOREIGN KEY (fk_empresa) REFERENCES empresa(id_empresa)
);

CREATE TABLE talhao (
    id_talhao INT PRIMARY KEY AUTO_INCREMENT,
    nome_talhao VARCHAR(45) NOT NULL,
    area DECIMAL(10,2) NOT NULL,
    cultivo VARCHAR(50) NOT NULL,
    fk_fazenda INT NOT NULL,
    CONSTRAINT fk_talhao_fazenda
        FOREIGN KEY (fk_fazenda) REFERENCES fazenda(id_fazenda),
    CONSTRAINT chk_cultivo
        CHECK (cultivo = 'Café Arábica')
);

CREATE TABLE sensor (
    id_sensor INT PRIMARY KEY AUTO_INCREMENT,
    status_sensor BOOLEAN NOT NULL DEFAULT TRUE,
    fk_talhao INT NOT NULL,
    CONSTRAINT fk_sensor_talhao
        FOREIGN KEY (fk_talhao) REFERENCES talhao(id_talhao)
);

CREATE TABLE medicao (
    id_medicao INT PRIMARY KEY AUTO_INCREMENT,
    data_hora DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    sensor_umidade INT NOT NULL,
    fk_sensor INT NULL,
    CONSTRAINT fk_medicao_sensor
        FOREIGN KEY (fk_sensor) REFERENCES sensor(id_sensor),
    CONSTRAINT chk_umidade_solo
        CHECK (sensor_umidade >= 0 AND sensor_umidade <= 100)
);

CREATE TABLE alerta (
    id_alerta INT PRIMARY KEY AUTO_INCREMENT,
    tipo_alerta VARCHAR(50) NOT NULL,
    data_hora DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fk_medicao INT NOT NULL,
    CONSTRAINT fk_alerta_medicao
        FOREIGN KEY (fk_medicao) REFERENCES medicao(id_medicao)
);


INSERT INTO empresa (nome_empresa, cnpj) VALUES
('CoffeeCare Tecnologia', '12345678000190'),
('Agro Café Brasil', '98765432000110'),
('Sojas Ltda.', '11222333000181');

INSERT INTO usuario
(nome_usuario, senha, email, tipo_usuario, telefone, ativo, fk_empresa, cpf)
VALUES
('Carlos Silva', 'senha123', 'carlos@coffeCare.com', 'Administrador', '11987654321', 1, 1, '12345678901'),
('Mariana Souza', 'senha456', 'mariana@agrocafe.com', 'Produtor', '11912345678', 1, 2, '98765432100'),
('admin', 'admin', 'admin@admin', 'Administrador', NULL, 1, 3, '11122233344');

INSERT INTO fazenda
(nome_fazenda, area_total, endereco, cidade, estado, fk_empresa)
VALUES
('Fazenda Esperança', 200.00, 'Estrada Rural, km 10', 'Patrocínio', 'Minas Gerais', 1),
('Fazenda Primavera', 150.50, 'Estrada do Café, km 5', 'Varginha', 'Minas Gerais', 2);

INSERT INTO talhao
(nome_talhao, area, cultivo, fk_fazenda)
VALUES
('Talhão Norte', 50.00, 'Café Arábica', 1),
('Talhão Sul', 75.00, 'Café Arábica', 1),
('Talhão Central', 60.00, 'Café Arábica', 2);

INSERT INTO sensor
(status_sensor, fk_talhao)
VALUES
(1, 1),
(0, 2),
(1, 3);

INSERT INTO alerta (tipo_alerta, data_hora, fk_medicao)
VALUES
('Umidade baixa', '2026-10-27 09:00:00', 2),
('Umidade crítica', '2026-10-27 11:00:00', 4);


-- Exibe os sensores, seus status, os alertas, os talhões e as medições,
-- classificando a umidade do solo como Normal, Atenção ou Crítico.
SELECT
    s.id_sensor AS Sensor,
    s.status_sensor AS Status,
    a.tipo_alerta AS Aviso,
    t.id_talhao AS Talhao,
    m.sensor_umidade,
    a.data_hora AS 'Historico Recente',
    CASE
        WHEN m.sensor_umidade > 50 THEN 'Normal'
        WHEN m.sensor_umidade >= 30 THEN 'Atenção'
        ELSE 'Crítico'
    END AS classificacao
FROM talhao AS t
LEFT JOIN sensor AS s
    ON t.id_talhao = s.fk_talhao
LEFT JOIN medicao AS m
    ON s.id_sensor = m.fk_sensor
LEFT JOIN alerta AS a
    ON m.id_medicao = a.fk_medicao;


-- Exibe as medições do sensor de ID 1, mostrando sua umidade,
-- data, status e classificação, da mais recente para a mais antiga.
SELECT
    s.id_sensor AS Sensor,
    s.status_sensor AS Status,
    m.id_medicao AS Medicao,
    m.sensor_umidade AS Umidade,
    m.data_hora AS Data_Hora,
    CASE
        WHEN m.sensor_umidade > 50 THEN 'Normal'
        WHEN m.sensor_umidade >= 30 THEN 'Atenção'
        ELSE 'Crítico'
    END AS Classificacao
FROM sensor AS s
LEFT JOIN medicao AS m
    ON s.id_sensor = m.fk_sensor
WHERE s.id_sensor = 1
ORDER BY m.data_hora DESC;


SELECT *
FROM coffeCare.medicao
ORDER BY id_medicao DESC;

SELECT * FROM empresa;

SELECT * FROM usuario;

SELECT * FROM fazenda;

SELECT * FROM talhao;

SELECT * FROM sensor;

SHOW TABLES;

SHOW GRANTS FOR 'root_coffecareI'@'%';

SHOW GRANTS FOR 'coffeecare_api_insert'@'%';
