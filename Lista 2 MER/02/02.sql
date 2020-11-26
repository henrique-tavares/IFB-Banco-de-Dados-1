create table enderecos (
	cep numeric(8) primary key,
	rua varchar(30),
	bairro varchar(30),
	numero int,
	complemento varchar(50)
);

create table faculdades (
	codigo int primary key auto_increment,
	nome varchar(50) not null,
	localizacao varchar(50) not null,
	fone numeric(13) not null
);

create table funcionarios (
	codigo int primary key auto_increment,
	nome varchar(30) not null,
	cpf numeric(11) not null,
	endereco_cep numeric(8) not null,
	cidade varchar(30) not null,
	data_nascimento date not null,
	data_admissao date not null,
	sexo char(1) not null,
	faculdade_cod int not null,

	foreign key (endereco_cep) references enderecos (cep),
	foreign key (faculdade_cod) references faculdades (codigo)
);

create table fones (
	funcionario_cod int not null,
	fone numeric(13) not null,

	primary key (funcionario_cod, fone),

	foreign key (funcionario_cod) references funcionarios (codigo)
);

create table dependentes (
	funcionario_cod int not null,
	nome varchar(30) not null,
	data_nascimento date not null,
	parentesco varchar(30) not null,
	sexo char(1) not null,

	primary key (
		funcionario_cod,
		nome,
		data_nascimento,
		parentesco,
		sexo
	),

	foreign key (funcionario_cod) references funcionarios (codigo)
);

create table administrativo (
	funcionario_cod int primary key,
	cargo varchar(30) not null,
	salario decimal(8,2) not null,

	foreign key (funcionario_cod) references funcionarios (codigo)
);

create table professores (
	funcionario_cod int primary key,
	titulacao varchar(30) not null,
	salario_por_hora decimal(8,2) not null,
	area varchar(30) not null,
	administrativo_cod int not null,

	foreign key (funcionario_cod) references funcionarios (codigo),
	foreign key (administrativo_cod) references administrativo (funcionario_cod)
);

create table disciplinas (
	codigo int primary key auto_increment,
	nome varchar(50) not null unique,
	ementa text not null,
	conteudo_programatico text not null,
	carga_horaria int not null
);

create table turmas (
	professor_cod int not null,
	disciplina_cod int not null,
	semestre int not null,
	ano int not null,
	horario varchar(256) not null,

	primary key (
		professor_cod,
		disciplina_cod,
		semestre,
		ano,
		horario
	),

	foreign key (professor_cod) references professores (funcionario_cod),
	foreign key (disciplina_cod) references disciplinas (codigo)
);

create table diretores (
	professor_cod int not null,
	faculdade_cod int not null,
	data_posse date not null,
	data_termino date not null,

	primary key (professor_cod, faculdade_cod, data_posse, data_termino),

	foreign key (professor_cod) references professores (funcionario_cod),
	foreign key (faculdade_cod) references faculdades (codigo)
);

create table cursos (
	codigo int primary key auto_increment,
	nome varchar(30) not null,
	ano_criacao int not null,
	duracao int not null,
	ano_reconhecimento int not null,
	faculdade_cod int not null,

	foreign key (faculdade_cod) references faculdades (codigo)
);

create table coordenador (
	professor_cod int not null,
	faculdade_cod int not null,
	data_posse date not null,
	data_termino date not null,

	primary key (professor_cod, faculdade_cod, data_posse, data_termino),

	foreign key (professor_cod) references professores (funcionario_cod),
	foreign key (faculdade_cod) references faculdades (codigo)
);

create table curriculos (
	curso_cod int not null,
	disciplina_cod int not null,
	ano int not null,

	primary key (curso_cod, disciplina_cod, ano),

	foreign key (curso_cod) references cursos (codigo),
	foreign key (disciplina_cod) references disciplinas (codigo)
);

create table alunos (
	ra numeric(15) primary key,
	nome varchar(30) not null,
	endereco varchar(50) not null,
	data_nascimento date not null,
	sexo char(1) not null,
	fone numeric(13) not null,
	curso_cod int not null,

	foreign key (curso_cod) references cursos (codigo)
);

create table matriculas (
	aluno_ra numeric(15) not null,
	turma_professor int not null,
	turma_disciplina int not null,
	turma_semestre int not null,
	turma_ano int not null,
	turma_horario varchar(256) not null,
	nota int,
	frequencia int,

	primary key (
		aluno_ra,
		turma_professor,
		turma_disciplina,
		turma_semestre,
		turma_ano,
		turma_horario
	),

	foreign key (aluno_ra) references alunos (ra),

	foreign key (
		turma_professor,
		turma_disciplina,
		turma_semestre,
		turma_ano,
		turma_horario
	) references turmas (
		professor_cod,
		disciplina_cod,
		semestre,
		ano,
		horario
	)
);
