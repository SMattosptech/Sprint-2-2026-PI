CREATE DATABASE aula_10;

USE aula_10;

CREATE TABLE categoria (
id INT PRIMARY KEY AUTO_INCREMENT,
descricao VARCHAR (45)
);

CREATE TABLE funcionario (
id INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR (100),
cpf CHAR (11),
salario DECIMAL (8,2)
);

CREATE TABLE produto (
id INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR (45),
preco DECIMAL (8,2),
fk_categoria INT,
CONSTRAINT ct_fk_categoria
FOREIGN KEY (fk_categoria) REFERENCES categoria (id)
);

CREATE TABLE venda (
id INT PRIMARY KEY AUTO_INCREMENT,
dt_hora DATETIME,
fk_vendedor INT,
CONSTRAINT ct_fk_vendedor foreign key (fk_vendedor) REFERENCES funcionario(id)
);

CREATE TABLE item_venda (
fk_venda INT,
fk_produto INT,
qtd INT,
desconto decimal (5,2),
primary key (fk_venda, fk_produto),
FOREIGN KEY (fk_venda) REFERENCES venda (id),
FOREIGN KEY (fk_produto) REFERENCES produto (id)
);

INSERT INTO categoria (descricao) VALUES
('Hortifruti'),
('Mercearia'),
('Eletrônicos'),
('Eletrodomésticos'),
('Higiene e Beleza');

INSERT INTO funcionario (nome, cpf, salario) VALUES 
('Clara', '11111111111', 2000),
('Isa', '11111111112', 10000),
('Mirela', '11111111113', 8500),
('Matheus', '11111111114', 1000.99),
('Samuela', '11111111115', 25000),
('Mathuesa', '11111111116', 11642),
('Mirello', '11111111117', 500.01);

INSERT INTO produto (nome, preco, fk_categoria) VALUES 
('TV', 800, 3),
('Smartfone', 4000.50, 3),
('Geladeira', 900, 4),
('Sabonete', 2, 5),
('Goiaba', 5.55, 1);

INSERT INTO venda (dt_hora,fk_vendedor) VALUES 
(NOW(), 7),
(NOW(), 7),
(NOW(), 1),
(NOW(), 5),
(NOW(), 6),
(NOW(), 5),
(NOW(), 7);

INSERT INTO item_venda (fk_produto,fk_venda,qtd, desconto) VALUES 
(5 , 1 , 1000, 15),
(2 , 4 , 7, 33),
(3 , 4 , 8, 33),
(5 , 4 , 11, 33),
(1 , 4 , 5, 33),
(4 , 4 , 9, 33),
(3 , 5 , 14, 33),
(2 , 1 , 1, 0),
(3 , 1 , 2, 10);


SELECT * 
FROM 
	produto 
    JOIN item_venda
		ON produto.id = item_venda.fk_produto
        JOIN venda
        ON venda.id = item_venda.fk_venda;
        

SELECT 
produto.nome,
produto.preco,
item_venda.qtd, 
venda.dt_hora,
funcionario.nome AS 'Vendedor'
FROM 
	produto 
    JOIN item_venda
		ON produto.id = item_venda.fk_produto
        JOIN venda
        ON venda.id = item_venda.fk_venda 
        JOIN funcionario 
        ON venda.fk_vendedor = funcionario.id;
        
        /*SUM-FUNÇÃO DE SOMA*/
 -- QUANTO DINHEIRO EU CONSEGUI A PARTIR DAS VENDAS DE TV, SEM O DESCONTO
 SELECT SUM(produto.preco * item_venda.qtd) 
	AS total_venda_tv_Sem_desc
    FROM produto
    JOIN item_venda 
		ON produto.id = item_venda.fk_produto
        WHERE produto.nome ='TV';
       
-- Média do preço de todos os meus produtos
/*AVG - FUNÇÃO DE MÉDIA*/
SELECT AVG(preco) 
FROM produto;

-- TRATANDO O VALOR DA MÉDIA DO PREÇO DE TODOS OS MEUS PRODUTOS,
-- PARA QUE TENHA APENAS 2 CASAS DECIMAIS
-- TEM MAIS DE UMA FORMA DE FAZER ISSO. ALGUMAS ABAIXO:

/* JEITO 1: ROUND - FUNÇÃO DE ARREDONDAR*/
SELECT ROUND(AVG(preco)) FROM produto;

SELECT ROUND(AVG(preco),2) FROM produto;

/* JEITO 2: TRUNCATE - FUNÇÃO DE REMOVER CASAS DECIMAIS*/
-- OBS:  TRUNCAR = ELIMINAR
SELECT TRUNCATE(AVG(preco),2) FROM produto;

/* JEITO 3: CEILING - FUNÇÃO DE ARREDONDAR PARA MAIS */
SELECT CEILING(AVG(preco)) FROM produto;
SELECT CEIL(AVG(preco)) FROM produto;

/* JEITO 4: FLOOR - FUNÇÃO DE ARREDONDAR PARA BAIXO */
SELECT FLOOR(AVG(preco)) FROM produto;

-- VALOR MÍNIMO DENTRE OS PRECOS DOS MEUS PRODUTOS 
/* MIN - FUNÇÃOL QUE TRAZ O VALOR MÍNIMO*/
SELECT MIN(preco) FROM produto;

/* MAX - FUNÇÃO QUE TRAZ O VALOR MAXIMO*/
SELECT MAX(preco) FROM produto;

-- QUANTIDADE DE PRODUTOS DIFERENTES QUE TENHO 
/* COUNT - FUNÇÃO QUE CONTA A QUANTIDADE*/
SELECT COUNT(distinct nome) FROM produto;

-- COUNT * CONTA VALORES NULOS TBM
-- COUNT SEM O * NÃO CONTA VALORES NULOS
SELECT COUNT(*) FROM produto;

-- DEMONSTRAÇÃO DE POTÊNCIA
/* POW - FUNÇÃO DE POTÊNCIA */
SELECT POW(10,2);


-- MUDANDO DE ASSUNTO 
-- Posso agregar valores, sem depender de uma função





        
        
        
        
-- QUANTO DINHEIRO EU CONSWGUI A PARTIR DAS VENDAS DE TV
SELECT SUM(preco) 

        




