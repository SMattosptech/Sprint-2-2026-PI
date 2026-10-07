grant insert on quercofe.* to 'apiArduino'@'coffeecare';
flush privileges;

use quercofe;
create table usuario(
id int primary key auto_increment,
nome varchar(45),
email varchar(100)
);

create table medida (
sensor_analogico decimal(10,2),
sensor_umidade int
);

create table empresa(
id int primary key,
nome varchar(150),
cnpj char(14)
);

Insert into empresa values
(1, 'CoffeeCare', '12345678914256');

create table cadastro (
id_usuario int primary key auto_increment,
nome varchar(45),
senha varchar(20),
email varchar(150),
tipo_usuario varchar (30),
telefone char(11),
data_cadastro datetime default current_timestamp,
ativo tinyint,
fk_empresa int,
constraint ckfkempresa foreign key (fk_empresa) references empresa (id) 
);

insert into cadastro (nome, senha, email, tipo_usuario, telefone, ativo, fk_empresa) values
('grupo 11', '123456', 'grupo11@gmail.com', 'padrão', '12345678914',1,1);

create table fazenda (
id_fazenda int primary key,
nome_fazenda varchar(45),
area_total decimal(10,2),
endereco varchar(250),
cidade varchar(20),
estado varchar(20),
data_cadastro datetime default current_timestamp,
fk_empresa int,
constraint checkfkempresa foreign key (fk_empresa) references empresa (id)
);

insert into fazenda (id_fazenda, nome_fazenda, area_total, endereco, cidade, estado, fk_empresa) values
(1,'Fazendinha', 5000, 'Rua Haddock Lobo,591 -Consolação', 'São Paulo','São Paulo',1 );

create table talhao (
id_talhao int primary key,
nome varchar(45),
area_talhao decimal(10,2),
cultivo varchar(50),
fk_fazenda int,
constraint chkfkfazenda foreign key (fk_fazenda) references fazenda(id_fazenda)
);

insert into talhao (id_talhao, nome, area_talhao, cultivo, fk_fazenda) values
(1,'area norte', 400, 'fim do mês', 1),
(2, 'area sul',300, 'inicio do mês', 1);

create table sensor (
id_sensor int primary key,
status_sensor tinyint,
fk_talhao int,
constraint ckfktalhao foreign key (fk_talhao) references talhao(id_talhao)
);

insert into sensor (id_sensor, status_sensor, fk_talhao)values
(1,1,1),
(2,1,1);

create table medicao(
id_medicao int primary key auto_increment,
data_hora datetime default current_timestamp,
sensor_analogico decimal(10,2),
sensor_umidade int,
fk_sensor int,
constraint ckfksensor foreign key (fk_sensor) references sensor(id_sensor)
);

insert into medicao (id_medicao, fk_sensor) values
(1,1);
insert into medicao (id_medicao, fk_sensor) values
(2,1);
insert into medicao (id_medicao, fk_sensor) values
(3,1);
create table alerta (
id_alerta int primary key,
tipo_alerta varchar(50),
data_hora datetime default current_timestamp,
fk_medicao int,
constraint ckalerta foreign key (fk_medicao) references medicao(id_medicao)
);

insert into alerta (id_alerta, tipo_alerta, fk_medicao) values
(1,'Umidade normal', 1),
(2,'Precisa de atenção', 1),
(3,'Estado Grave', 1);

    INSERT INTO medicao (fk_sensor)
VALUES (2);
INSERT INTO alerta (id_alerta, tipo_alerta, fk_medicao)
VALUES (4, 'Umidade normal', 3);

INSERT INTO sensor (id_sensor, status_sensor, fk_talhao) VALUES
(3, 1, 2);

