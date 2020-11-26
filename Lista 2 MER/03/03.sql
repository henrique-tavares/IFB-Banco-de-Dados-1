create table fazendas (
	codigo int primary key auto_increment,
	nome varchar(50) not null,
	tamanho int not null,
	localizacao varchar(50) not null
);

create table proprietarios (
	codigo int primary key auto_increment,
	nome varchar(50) not null,
	endereco varchar(50) not null,
	fone numeric(13) not null
);

create table proprietario_posse_fazenda (
	proprietario_cod int not null,
	fazenda_cod int not null,

	primary key (proprietario_cod, fazenda_cod),

	foreign key (proprietario_cod) references proprietarios (codigo),
	foreign key (fazenda_cod) references fazendas (codigo)
);

create table produtos (
	codigo int primary key auto_increment,
	nome varchar(50) not null,
	descricao text not null,
	tempo_vida int not null
);

create table cultivos (
	fazenda_cod int not null,
	produto_cod int not null,
	mes int not null,
	ano int not null,

	primary key (fazenda_cod, produto_cod, mes, ano),

	foreign key (fazenda_cod) references fazendas (codigo),
	foreign key (produto_cod) references produtos (codigo)
);

create table pragas (
	codigo int primary key auto_increment,
	nome_popular varchar(50) not null,
	nome_cientifico varchar(50) not null unique,
	tempo_vida int not null
);

create table ataque_praga (
	praga_cod int not null,
	cultivo_fazenda int not null,
	cultivo_produto int not null,
	cultivo_mes int not null,
	cultivo_ano int not null,
	data_ataque date not null,

	primary key (
		praga_cod,
		cultivo_fazenda,
		cultivo_produto,
		cultivo_mes,
		cultivo_ano,
		data_ataque
	),

	foreign key (praga_cod) references pragas (codigo),

	foreign key (
		cultivo_fazenda,
		cultivo_produto,
		cultivo_mes,
		cultivo_ano
	) references cultivos (
		fazenda_cod,
		produto_cod,
		mes,
		ano
	)
);

create table defensivos (
	codigo int primary key auto_increment,
	nome varchar(50) not null
);

create table defensivos_quimicos (
	defensivo_cod int primary key,
	volume int not null,
	prazo_validade date not null,
	prazo_contaminacao date not null,
	descricao_componentes text not null,
	efeitos_colaterais text not null,

	foreign key (defensivo_cod) references defensivos (codigo)
);

create table defensivos_biologicos (
	defensivo_cod int primary key,
	nome_cientifico varchar(50) not null,

	foreign key (defensivo_cod) references defensivos (codigo)
);

create table combate_praga (
	ataque_praga_cod int not null,
	ataque_cultivo_fazenda int not null,
	ataque_cultivo_produto int not null,
	ataque_cultivo_mes int not null,
	ataque_cultivo_ano int not null,
	ataque_data_ataque date not null,
	defensivo_cod int not null,
	data_aplicacao date not null,
	qtd_aplicacoes int not null,

	primary key (
		ataque_praga_cod,
		ataque_cultivo_fazenda,
		ataque_cultivo_produto,
		ataque_cultivo_mes,
		ataque_cultivo_ano,
		ataque_data_ataque,
		defensivo_cod,
		data_aplicacao,
		qtd_aplicacoes
	),

	foreign key (
		ataque_praga_cod,
		ataque_cultivo_fazenda,
		ataque_cultivo_produto,
		ataque_cultivo_mes,
		ataque_cultivo_ano,
		ataque_data_ataque
	) references ataque_praga (
		praga_cod,
		cultivo_fazenda,
		cultivo_produto,
		cultivo_mes,
		cultivo_ano,
		data_ataque
	),

	foreign key (defensivo_cod) references defensivos (codigo)
);