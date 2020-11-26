create table regioes (
	codigo int primary key auto_increment,
	nome varchar(50) not null,
	coordenada_x decimal(10,5) not null,
	coordenada_y decimal(10,5) not null,

	unique (coordenada_x, coordenada_y)
);

create table corridas (
	origem int not null,
	destino int not null,
	distancia int not null,
	valor decimal(8,2) not null,

	primary key (origem, destino, distancia, valor),

	foreign key (origem) references regioes (codigo),
	foreign key (destino) references regioes (codigo)
);

create table clientes (
	codigo int primary key auto_increment,
	nome varchar(50) not null,
	endereco varchar(50) not null,
	fone numeric(13) not null
);

create table solicitacaoes_corridas (
	cliente_cod int not null,
	corrida_origem int not null,
	corrida_destino int not null,
	corrida_distancia int not null,
	corrida_valor decimal(8,2) not null,
	data_hora datetime not null,
	qtd_passageiros int not null,

	primary key (
		cliente_cod,
		corrida_origem,
		corrida_destino,
		corrida_distancia,
		corrida_valor,
		data_hora
	),

	foreign key (cliente_cod) references clientes (codigo),

	foreign key (
		corrida_origem,
		corrida_destino,
		corrida_distancia,
		corrida_valor
	) references corridas (
		origem,
		destino,
		distancia,
		valor
	)
);

create table taxis (
	chassi varchar(17) primary key,
	placa varchar(7) not null unique,
	marca varchar(30) not null,
	modelo varchar(30) not null,
	cor varchar(30) not null,
	ano int not null,
	capacidade int not null,
	localizacao decimal(10,5) not null,
	corrida_cliente int not null,
	corrida_origem int not null,
	corrida_destino int not null,
	corrida_distancia int not null,
	corrida_valor decimal(8,2) not null,
	corrida_data datetime not null,

	foreign key (
		corrida_cliente,
		corrida_origem,
		corrida_destino,
		corrida_distancia,
		corrida_valor,
		corrida_data
	) references solicitacaoes_corridas (
		cliente_cod,
		corrida_origem,
		corrida_destino,
		corrida_distancia,
		corrida_valor,
		data_hora
	)
);

create table funcionarios (
	cpf numeric(11) primary key,
	nome varchar(30) not null,
	endereco varchar(50) not null,
	fone numeric(13) not null,
	cargo varchar(30) not null,
	salario_base decimal(8,2) not null
);

create table motoristas (
	funcionario_cpf numeric(11) primary key,
	cnh numeric(11) not null unique,
	cnh_data_vencimento date not null,

	foreign key (funcionario_cpf) references funcionarios (cpf)
);

create table motoristas_dirigindo (
	motorista_cpf numeric(11) not null,
	taxi_chassi varchar(17) not null,
	data_hora_inicio datetime not null,
	data_hora_devolucao datetime not null,

	primary key (motorista_cpf, taxi_chassi, data_hora_inicio, data_hora_devolucao),

	foreign key (motorista_cpf) references motoristas (funcionario_cpf),
	foreign key (taxi_chassi) references taxis (chassi)
);