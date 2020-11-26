create table pacientes (
	crh numeric(7) primary key,
	nome varchar(30) not null,
	endereco varchar(50) not null,
	cidade varchar(50) not null,
	data_nascimento date not null,
	sexo char(1) not null,
	fone numeric(13) not null,
	responsavel varchar(50) not null
);

create table medicos (
	crm numeric(7) primary key,
	nome varchar(30) not null,
	endereco varchar(50) not null,
	cidade varchar(50) not null,
	especialidade varchar(30) not null
);

create table fones (
	medico_crm numeric(7) not null,
	fone numeric(13) not null,

	primary key (medico_crm, fone),

	foreign key (medico_crm) references medicos (crm)
);

create table consultas (
	medico_crm numeric(7) not null,
	paciente_crh numeric(7) not null,
	data_hora datetime not null,

	primary key (medico_crm, paciente_crh, data_hora),

	foreign key (medico_crm) references medicos (crm),
	foreign key (paciente_crh) references pacientes (crh)
);

create table exames (
	consulta_medico numeric(7) not null,
	consulta_paciente numeric(7) not null,
	consulta_data_hora datetime not null,
	tipo varchar(30) not null,
	descricao varchar(256) not null,
	data_realizacao datetime not null,
	resultado varchar(128) not null,

	primary key (
		consulta_medico,
		consulta_paciente,
		consulta_data_hora,
		tipo,
		descricao,
		data_realizacao,
		resultado
	),

	foreign key (
		consulta_medico,
		consulta_paciente,
		consulta_data_hora
	) references consultas (
		medico_crm,
		paciente_crh,
		data_hora
	)
);

create table leitos (
	ala varchar(30) not null,
	quarto int not null,
	leito int not null,
	tipo varchar(30) not null,

	primary key (ala, quarto, leito)
);

create table internacoes (
	leito_ala varchar(30) not null,
	leito_quarto int not null,
	leito_leito int not null,
	entrada datetime not null,
	saida datetime not null,

	primary key (
		leito_ala,
		leito_quarto,
		leito_leito,
		entrada,
		saida
	),

	foreign key (
		leito_ala,
		leito_quarto,
		leito_leito
	) references leitos (
		ala,
		quarto,
		leito
	)
);

create table prontuarios (
	paciente_crh numeric(7) not null,
	constatacao datetime not null,
	problema varchar(50) not null,
	receita varchar(256) not null,
	cuidados_especiais varchar(256) not null,

	primary key (
		paciente_crh,
		constatacao,
		problema,
		receita,
		cuidados_especiais
	),

	foreign key (paciente_crh) references pacientes (crh)
);
