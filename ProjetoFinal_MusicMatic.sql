CREATE SCHEMA MUSICMAT;
SET SEARCH_PATH TO MUSICMAT;

-- TABELA ARTISTA --
CREATE TABLE Artista(
	Nome VARCHAR(25) NOT NULL,
	DataNasc DATE,
	Idade INT,
	URL VARCHAR(100),
	CONSTRAINT PK_Artista PRIMARY KEY (Nome)
);

-- TABELA USUARIO --
CREATE TABLE Usuario(
	ID_user  NUMERIC NOT NULL,
	Email 	 VARCHAR(60),
	NomeUser VARCHAR(25) NOT NULL,
	Endereco VARCHAR(30),
	Cidade   VARCHAR(30),
	CONSTRAINT PK_Usuario PRIMARY KEY (ID_user)
);

-- TABELA USERNEGOCIO --
CREATE TABLE UserNegocio(
	IDNegocio NUMERIC NOT NULL,
	CNPJ      NUMERIC NOT NULL,
	
	CONSTRAINT PK_UserNegocio PRIMARY KEY (CNPJ, IDNegocio),
	CONSTRAINT FK_UserNegocio FOREIGN KEY (IDNegocio)  REFERENCES Usuario(ID_user),
        CONSTRAINT UK_UserNegocio_IDNegocio UNIQUE (IDNegocio)												
);


-- TABELA MUSICA --
CREATE TABLE Musica(
	Titulo    VARCHAR NOT NULL,
	Nome      VARCHAR NOT NULL,
	Ano       DATE,
	Duracao   TIME,
	Genero    VARCHAR(10),
	Upload    NUMERIC NOT NULL,
	
	CONSTRAINT PK_Musica PRIMARY KEY (Titulo, Nome),
	CONSTRAINT FK_Musica FOREIGN KEY (Nome)   REFERENCES Artista(Nome),
	CONSTRAINT FK_upload FOREIGN KEY (Upload) REFERENCES UserNegocio(IDNegocio)
);

-- TABELA FACULDADE --
CREATE TABLE Faculdade (
    ID_faculdade  NUMERIC PRIMARY KEY,
    NomeFaculdade VARCHAR(100),
    NumMatricula  VARCHAR(20)
);

-- TABELA ESTUDANTE --
CREATE TABLE Estudante(
	IDEstudante NUMERIC PRIMARY KEY,
	Desconto    REAL,
	ID_faculdade NUMERIC,
	
    CONSTRAINT PK_Estudante FOREIGN KEY (ID_faculdade) REFERENCES Faculdade (ID_faculdade),
    CONSTRAINT FK_Estudante FOREIGN KEY (IDEstudante) REFERENCES Usuario (ID_user)
);

-- TABELA USERPADRAO --
CREATE TABLE UserPadrao(
	IDPadrao         NUMERIC NOT NULL,
	GrauSimilaridade CHAR(10),
	IDEstudante 	 NUMERIC,

	CONSTRAINT PK_UserPadrao PRIMARY KEY (IDPadrao),
	CONSTRAINT FK_UserPadraoU FOREIGN KEY (IDPadrao) 
		REFERENCES Usuario(ID_user),
	CONSTRAINT FK_UserPadraoE FOREIGN KEY (IDEstudante) 
		REFERENCES Estudante(IDEstudante)								
);

-- TABELA COMPRA --
CREATE TABLE Compra(
	IDPadrao NUMERIC NOT NULL,
	Titulo 	 VARCHAR(30) NOT NULL,
	Nome 	 VARCHAR NOT NULL,

	CONSTRAINT PK_Compra PRIMARY KEY (IDPadrao, Titulo, Nome),
	CONSTRAINT FK_CompraU FOREIGN KEY (IDPadrao) 
		REFERENCES UserPadrao(IDPadrao),
	CONSTRAINT FK_CompraM FOREIGN KEY (Nome, Titulo) 
		REFERENCES Musica(Nome, Titulo)
);

-- TABELA ALBUM --
CREATE TABLE Album(
	NomeAlbum VARCHAR(30) NOT NULL,
	IDPadrao  NUMERIC NOT NULL,
	
	CONSTRAINT PK_Album PRIMARY KEY (NomeAlbum),
	CONSTRAINT FK_Album FOREIGN KEY (IDPadrao) 
		REFERENCES UserPadrao(IDPadrao)
); 

-- TABELA CONTEM --
CREATE TABLE Contem(
	Titulo    VARCHAR(30) NOT NULL,
	Nome      VARCHAR(25) NOT NULL,
	IDPadrao  NUMERIC 	  NOT NULL,
	NomeAlbum VARCHAR(30) NOT NULL,
	
	CONSTRAINT PK_Contem  PRIMARY KEY (Titulo, Nome, IDPadrao, NomeAlbum),
	CONSTRAINT FK_ContemM FOREIGN KEY (Titulo, Nome) 
		REFERENCES Musica(Titulo, Nome),
	CONSTRAINT FK_ContemP FOREIGN KEY (IDPadrao) 
		REFERENCES UserPadrao(IDPadrao),
	CONSTRAINT FK_ContemAB FOREIGN KEY (NomeAlbum) 
		REFERENCES Album(NomeAlbum)
);

-- TABELA HITS_SINGLES --
CREATE TABLE Hits(
	Titulo    VARCHAR(30) NOT NULL,
	Nome      VARCHAR(25) NOT NULL,
	TipoMusic VARCHAR NOT NULL,
	
	CONSTRAINT PK_Hits  PRIMARY KEY (Titulo, Nome, TipoMusic),
	CONSTRAINT FK_Hits  FOREIGN KEY (Titulo, Nome) 
		REFERENCES Musica(Titulo, Nome)
);

-- TABELA OPCOES --
CREATE TABLE Opcoes(
	IDOption NUMERIC NOT NULL,
	Tipo     VARCHAR(25) NOT NULL,
	ID_user	 NUMERIC NOT NULL,
	
	CONSTRAINT PK_Opcoes PRIMARY KEY (IDOption),
	CONSTRAINT FK_Opcoes FOREIGN KEY (ID_user) 
		REFERENCES Usuario(ID_user)
);

-- TABELA RADIO --
CREATE TABLE Radio(
	IDOptionRadio NUMERIC NOT NULL,
	Estacao       VARCHAR(20) NOT NULL,
	
	CONSTRAINT PK_Radio PRIMARY KEY (IDOptionRadio),
	CONSTRAINT FK_Radio FOREIGN KEY (IDOptionRadio) 
		REFERENCES Opcoes(IDOptIon)
);

-- TABELA PODCAST --
CREATE TABLE PodCast(
	IDPodCast NUMERIC NOT NULL,
	Temas     VARCHAR(50) NOT NULL,
	
	CONSTRAINT PK_PodCast PRIMARY KEY (IDPodCast),
	CONSTRAINT FK_PodCasT FOREIGN KEY (IDPodCast) 
		REFERENCES Opcoes(IDOptIon)
);

CREATE TABLE HistoricoReproducao (
    IDReproducao SERIAL PRIMARY KEY,
    ID_user             INT NOT NULL,
    Titulo 		VARCHAR(100) NOT NULL,
    NomeArtista 	VARCHAR(100) NOT NULL,
    DataReproducao 	DATE NOT NULL,
    
    CONSTRAINT FK_HistoricoReproducao_User FOREIGN KEY (ID_user) REFERENCES Usuario(ID_user),
    CONSTRAINT FK_FK_HistoricoReproducao_nomeA FOREIN KEY(Titulo,NomeArtista) REFERENCES Musica(Titulo,NomeArtista)
);
);


-- Insercoes --


-- Artistas --

-- A função EXTRACT(YEAR FROM NOW()) retorna o ano atual e EXTRACT(YEAR FROM 'YYYY-MM-DD') extrai o ano da data de nascimento.

INSERT INTO Artista (Nome, DataNasc, Idade, URL)
VALUES
('Adele', 	         '1988-05-05', EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM CAST('1988-05-05' AS DATE)),  'https://pt.wikipedia.org/wiki/Adele'),
('Aline Barros',         '1976-10-07', EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM CAST('1976-10-07'AS DATE)),  'https://pt.wikipedia.org/wiki/Aline_Barros'),
('Gabriela Rocha',       '1994-08-13', EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM CAST('1994-08-13'AS DATE)),  'https://gabrielarocha.com.br/sobre/'),
('Alok', 	         '1991-08-26', EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM CAST('1991-08-26'AS DATE)),  'https://pt.wikipedia.org/wiki/Alok'),
('Péricles',             '1969-07-22', EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM CAST('1969-07-22'AS DATE)),  'https://pt.wikipedia.org/wiki/P%C3%A9ricles_(cantor)'),
('MC Pedrinho',          '2002-05-03', EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM CAST('2002-05-03'AS DATE)),  'https://www.letras.mus.br/blog/quem-e-mc-pedrinho/'),
('Billie Eilish',        '2001-12-18', EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM CAST('2001-12-18'AS DATE)),  'https://www.ebiografia.com/billie_eilish/'),
('Freddie Mercury',      '1946-09-05', EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM CAST('1946-09-05'AS DATE)),  'https://pt.wikipedia.org/wiki/Freddie_Mercury'),
('Gusttavo Lima',        '1989-09-03', EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM CAST('1989-09-03'AS DATE)),  'https://www.ebiografia.com/gusttavo_lima/'),
('Rihanna',   		 '1990-02-20', EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM CAST('1990-02-20'AS DATE)),  'https://revistaquem.globo.com/famoso/rihanna/'),
('Lana Del Rey',         '1985-06-21', EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM CAST('1985-06-21'AS DATE)),  'https://pt.wikipedia.org/wiki/Lana_Del_Rey'),
('Ana castela',          '2002-05-08', EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM CAST('1989-09-03'AS DATE)),  'https://www.breaktudo.com/biografia/ana-castela/'),
('Marilia mendonça',     '1997-07-26', EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM CAST('1989-09-03'AS DATE)),  'https://pt.wikipedia.org/wiki/Mar%C3%ADlia_Mendon%C3%A7a'),
('Mari Fernandez', 	 '2001-01-19', EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM CAST('2001-01-19'AS DATE)),  'https://pt.wikipedia.org/wiki/Mari_Fernandez'),
('Marina Sena',          '1996-09-26', EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM CAST('1996-09-26'AS DATE)),  'https://pt.wikipedia.org/wiki/Marina_Sena'),
('Ed Sheeran',           '1991-02-17', EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM CAST('1991-02-17'AS DATE)),  'https://www.antena1.com.br/artistas/ed-sheeran'),
('Joao Gomes',           '2002-07-31', EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM CAST('2002-07-31'AS DATE)),  'https://pt.wikipedia.org/wiki/Jo%C3%A3o_Gomes'),
('Elvis Presley',        '1935-01-08', EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM CAST('1935-01-08'AS DATE)),  'https://www.ebiografia.com/elvis_presley/'),
('Michael Jackson',      '1958-08-29', EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM CAST('1958-08-29'AS DATE)),  'https://brasilescola.uol.com.br/biografia/michael-jackson.htm'),
('DJ Rennan',            '1994-07-15', EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM CAST('1994-07-15'AS DATE)),  'https://pt.wikipedia.org/wiki/Rennan_da_Penha'),
('Bruno Mars',           '1985-10-08', EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM CAST('1985-10-08'AS DATE)),  'https://pt.wikipedia.org/wiki/Bruno_Mars'),
('Ariana grande', 	 '1990-07-05', EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM CAST('1988-05-05'AS DATE)),  'https://pt.wikipedia.org/wiki/Ariana_Grande'),
('Bob Marley', 	         '1945-02-06', EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM CAST('1945-02-06'AS DATE)),  'https://brasilescola.uol.com.br/biografia/bob-marley.htm'),
('Tina Turner', 	 '1939-11-26', EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM CAST('1939-11-26'AS DATE)),  'https://pt.wikipedia.org/wiki/Tina_Turner'),
('Eminem', 		 '1972-10-17', EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM CAST( '1972-10-17'AS DATE)), 'https://www.ebiografia.com/eminem/'),
('Bob Dylan',  		 '1941-05-24', EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM CAST('1941-05-24'AS DATE)),  'https://www.ebiografia.com/bob_dylan/'),
('Armandinho',           '1974-01-22', EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM CAST('1987-07-09'AS DATE)),  'https://pt.wikipedia.org/wiki/Armandinho_(cantor_brasileiro)'),
('Céline Dion',          '1968-03-30', EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM CAST('1968-03-30'AS DATE)),  'https://pt.wikipedia.org/wiki/C%C3%A9line_Dion'),
('Isadora Pompeo',       '1999-05-30', EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM CAST('1999-05-30'AS DATE)),  'https://pt.wikipedia.org/wiki/Isadora_Pompeo'),
('Roberto carlos',       '1958-08-29', EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM CAST('1958-08-29'AS DATE)),  'https://pt.wikipedia.org/wiki/Roberto_Carlos'),
('Alcione',              '1947-11-21', EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM CAST('1947-11-21'AS DATE)),  'https://pt.wikipedia.org/wiki/Alcione_(cantora)');

-- Usuarios --

INSERT INTO Usuario (ID_user, Email, NomeUser, Endereco, Cidade)
VALUES (1, 'jacob2024@gmail.com',    'Jacob Silva',      'Rua Manga 264',                'Pirapora - MG'),
       (2, 'jhully123@gmail.com',    'Jhully Vitória',   'Rua José  232',                'Niterói - RJ'),
       (3, 'Amanda456@gmail.com',    'Amanda Pereira',   'Rua Goiabeira 121',            'Salvador - BA' ),
       (4, 'Maria789@gmail.com',     'Maria Nunes',      'Rua Europa 257',               'Porto Alegre - RS'),
       (5, 'Romilto912@gmail.com',   'Romilto Pereira',  'Rua Europa 257',               'Porto Alegre - RS'),
       (6, 'Jayne834@gmail.com',     'Jayne Francielle', 'Rua Amora 786',                'Florianópolis - SC'),    
       (7, 'Joicy756@gmail.com',     'Joicy Alves',      'Rua Manga 457',                'Pirapora - MG'),
       (8, 'Gabriel612@gmail.com',   'Gabriel Lucas',    'Av. Segismundo Pereira 1001',  'Uberlândia - MG'),
       (9, 'Heitor534@gmail.com',    'Heitor Alexandre', 'Av. Rondon Pacheco 3030',      'Uberlândia - MG'),
       (10, 'AnaCast498@gmail.com',  'Ana Castro',       'Av. Cesário Alvim 5123',       'Uberlândia - MG'), 
       (11, 'Eduardo789@gmail.com',  'Eduardo Silva',    'Rua Mangueira 124',            'Pirapora - MG'),
       (12, 'Lucas123@gmail.com',    'Lucas Almeida',    'Rua Pioneiros 785',            'Curitiba - PR'),
       (13, 'Fernanda567@gmail.com', 'Fernanda Costa',   'Rua das Flores 66',            'Recife - PE' ),
       (14, 'Bruna654@gmail.com',    'Bruna Oliveira',   'Rua das Oliveiras 333',        'São Paulo - SP'),
       (15, 'Vinicius234@gmail.com', 'Vinicius Santos',  'Av. dos Girassóis 888',        'Brasília - DF'),
       (16, 'Thiago876@gmail.com',   'Thiago Rodrigues', 'Rua Primavera 121',            'Belo Horizonte - MG'),
       (17, 'Patricia345@gmail.com', 'Patrícia Lima',    'Rua das Acácias 789',          'Porto Alegre - RS'),
       (18, 'Carla890@gmail.com',    'Carla Pereira',    'Av. das Hortênsias 456',       'Gramado - RS'),
       (19, 'Rafael567@gmail.com',   'Rafael Souza',     'Rua das Rosas 112',            'Goiânia - GO'),
       (20, 'Renata987@gmail.com',   'Renata Oliveira',  'Av. dos Ipês 332',             'Campo Grande - MS'),
       (21, 'Luciana321@gmail.com',  'Luciana Alves',    'Rua das Orquídeas 99',         'Vitória - ES'),
       (22, 'Pedro789@gmail.com',    'Pedro Barbosa',    'Av. das Dálias 212',           'Fortaleza - CE'),
       (23, 'Mariana654@gmail.com',  'Mariana Santos',   'Rua das Bromélias 45',         'Curitiba - PR'),
       (24, 'Diego321@gmail.com',    'Diego Silva',      'Av. dos Lírios 777',           'Salvador - BA'),
       (25, 'Tatiane543@gmail.com',  'Tatiane Oliveira', 'Rua das Tulipas 313',          'Manaus - AM'),
       (26, 'Jessica123@gmail.com',  'Jéssica Lima',     'Av. das Margaridas 555',       'Recife - PE'),
       (27, 'Ricardo987@gmail.com',  'Ricardo Pereira',  'Rua das Margaridas 99',        'Porto Alegre - RS'),
       (28, 'Camila765@gmail.com',   'Camila Almeida',   'Av. dos Lírios 321',           'Belo Horizonte - MG'),
       (29, 'Carlos654@gmail.com',   'Carlos Oliveira',  'Rua das Orquídeas 777',        'Goiânia - GO'),
       (30, 'Juliana234@gmail.com',  'Juliana Santos',   'Rua das Bromélias 212',        'Campo Grande - MS'),
       (31, 'Fábio876@gmail.com',    'Fábio Souza',      'Av. das Tulipas 143',          'Vitória - ES'),
       (32, 'Lucas321@gmail.com',    'Lucas Barbosa',    'Rua das Margaridas 512',       'Fortaleza - CE');

-- user negocio --
INSERT INTO UserNegocio (IDNegocio, CNPJ) VALUES (16, 12345678901234);
INSERT INTO UserNegocio (IDNegocio, CNPJ) VALUES (17, 23456789012345);
INSERT INTO UserNegocio (IDNegocio, CNPJ) VALUES (18, 34567890123456);
INSERT INTO UserNegocio (IDNegocio, CNPJ) VALUES (19, 45678901234567);
INSERT INTO UserNegocio (IDNegocio, CNPJ) VALUES (20, 56789012345678);
INSERT INTO UserNegocio (IDNegocio, CNPJ) VALUES (21, 67890123456789);
INSERT INTO UserNegocio (IDNegocio, CNPJ) VALUES (22, 78901234567890);
INSERT INTO UserNegocio (IDNegocio, CNPJ) VALUES (23, 89012345678901);
INSERT INTO UserNegocio (IDNegocio, CNPJ) VALUES (24, 90123456789012);
INSERT INTO UserNegocio (IDNegocio, CNPJ) VALUES (25, 12345678901230);
INSERT INTO UserNegocio (IDNegocio, CNPJ) VALUES (26, 32345678901230);
INSERT INTO UserNegocio (IDNegocio, CNPJ) VALUES (27, 22345678901230);
INSERT INTO UserNegocio (IDNegocio, CNPJ) VALUES (28, 42345678901230);
INSERT INTO UserNegocio (IDNegocio, CNPJ) VALUES (29, 52345678901230);
INSERT INTO UserNegocio (IDNegocio, CNPJ) VALUES (30, 62345678901230);
INSERT INTO UserNegocio (IDNegocio, CNPJ) VALUES (31, 72345678901230);
       
-- Musicas --

INSERT INTO Musica (Titulo, Nome, Ano, Duracao, Genero, Upload) VALUES
('Someone Like You',      'Adele',           '2024-02-03', '0:04:45', 'Pop', 16),
('Ressuscita-me',         'Aline Barros',    '2011-10-05', '0:05:34', 'Gospel', 17),
('Me atraiu',             'Gabriela Rocha',  '2023-01-01', '0:05:15', 'Gospel', 18),
('Hear Me Now',           'Alok',            '2016-01-01', '0:03:12', 'Eletrônica', 19),
('Depois da Briga',       'Péricles',        '2020-09-01', '0:04:29', 'Samba', 20),
('Solta o Grave',         'MC Pedrinho',     '2016-01-01', '0:02:38', 'Funk', 21),
('Bad Guy',               'Billie Eilish',   '2019-02-24', '0:03:14', 'Pop', 22),
('Bohemian Rhapsody',     'Freddie Mercury', '1975-07-12', '0:05:55', 'Rock', 23),
('Zé da Recaída',         'Gusttavo Lima',   '2018-01-01', '0:03:03', 'Sertanejo', 24),
('Diamonds',              'Rihanna',         '2012-03-01', '0:03:45', 'Pop', 25),
('Summertime Sadness',    'Lana Del Rey',    '2012-01-01', '0:04:25', 'Pop', 26),
('Boiadera',              'Ana castela',     '2017-05-12', '0:04:38', 'Sertanejo', 27),
('Supera',                'Marilia mendonça','2019-06-30', '0:02:51', 'Sertanejo', 28),
('Vai Viver',             'Mari Fernandez',  '2022-09-22', '0:03:45', 'Pop', 29),
('Por Supuesto',          'Marina Sena',     '2019-12-01', '0:05:06', 'MPB', 30),
('Shape of You',          'Ed Sheeran',      '2017-07-08', '0:03:54', 'Pop', 31),
('Deixa',                 'Joao Gomes',      '2021-05-12', '0:02:22', 'Sertanejo', 16),
('Can’t Help Falling in Love','Elvis Presley','1961-06-17','0:03:00', 'Rock', 17),
('Billie Jean',           'Michael Jackson', '1982-01-01', '0:04:54', 'Pop', 18),
('Baile da Penha',        'DJ Rennan',       '2019-01-01', '0:02:56', 'Funk', 19),
('Locked Out of Heaven',  'Bruno Mars',      '2012-01-01', '0:03:53', 'Pop', 20),
('7 rings',               'Ariana grande',   '2019-04-23', '0:02:58', 'Pop', 21),
('No Woman, No Cry',      'Bob Marley',      '1974-01-01', '0:07:07', 'Reggae', 22),
('Simply the Best',       'Tina Turner',     '1991-01-01', '0:04:11', 'Pop', 23),
('Lose Yourself',         'Eminem',          '2002-11-16', '0:05:26', 'Hip Hop', 24),
('Like a Rolling Stone',  'Bob Dylan',       '1965-07-31', '0:06:13', 'Rock', 25),
('Semente',               'Armandinho',      '2003-01-01', '0:03:11', 'Reggae', 26),
('My Heart Will Go On',   'Céline Dion',     '1997-01-01', '0:04:41', 'Pop', 27),
('Detalhes',              'Roberto carlos',  '1971-05-09', '0:04:00', 'MPB', 28),
('Meu Ébano',             'Alcione',         '1974-01-01', '0:03:51', 'Samba', 29),
('Tetelestai',            'Isadora Pompeo',  '2024-03-28', '0:08:38', 'Gospel', 30);

 -- Faculdade --

INSERT INTO Faculdade (ID_faculdade, NomeFaculdade, NumMatricula) VALUES
(1,  'Universidade Federal de Minas Gerais', 	  'UFMG123456'),
(2,  'Universidade Federal Fluminense', 	  'UFF654321'),
(3,  'Universidade Federal da Bahia', 		  'UFBA987654'),
(4,  'Universidade Federal do Rio Grande do Sul', 'UFRGS456789'),
(5,  'Universidade Federal do Rio de Janeiro', 	  'UFRJ321654'),
(6,  'Universidade Federal de Santa Catarina', 	  'UFSC987321'),
(7,  'Universidade Federal de Brasília', 	  'UnB123987'),
(8,  'Universidade Federal de Uberlândia', 	  'UFU456123'),
(9,  'Universidade Federal de Uberaba', 	  'UNIUBE321456'),
(10, 'Universidade de Uberaba', 		  'UNIUB789123');

-- Estudantes --
INSERT INTO Estudante (IDEstudante, Desconto, ID_faculdade) VALUES
(1,   0.15, 1),
(2,   0.15, 2),
(3,   0.15, 3),
(4,   0.15, 1),
(5,   0.15, 3),
(6,   0.15, 2),
(7,   0.15, 10),
(8,   0.15, 8),
(9,   0.15, 4),
(10,  0.15, 4);

-- Usuario Padrao --
INSERT INTO UserPadrao (IDPadrao, GrauSimilaridade, IDEstudante)
VALUES
(1,  'Baixo',   1),
(2,  'Médio',   2),
(3,  'Alto',    3),
(4,  'Baixo', NULL),
(5,  'Médio',   4),
(6,  'Alto',    5),
(7,  'Baixo',   6),
(8,  'Médio',   7),
(9,  'Alto',    8),
(10, 'Baixo', NULL),
(11, 'Médio',   9),
(12, 'Alto',    10),
(13, 'Baixo', NULL),
(14, 'Baixo', NULL),
(15, 'Baixo', NULL);

-- Compras --

INSERT INTO Compra (IDPadrao, Titulo, Nome) 
VALUES 
    (1, 'Someone Like You',          'Adele'),
    (1, 'Ressuscita-me',             'Aline Barros'),
    (2, 'Me atraiu',                 'Gabriela Rocha'),
    (1, 'Hear Me Now',               'Alok'),
    (2, 'Depois da Briga',           'Péricles'),
    (3, 'Solta o Grave',             'MC Pedrinho'),
    (3, 'Bad Guy',                   'Billie Eilish'),
    (3, 'Bohemian Rhapsody',         'Freddie Mercury'),
    (4, 'Zé da Recaída',             'Gusttavo Lima'),
    (4, 'Diamonds',                  'Rihanna'),
    (4, 'Summertime Sadness',        'Lana Del Rey'),
    (5, 'Boiadera',                  'Ana castela'),
    (5, 'Supera',                    'Marilia mendonça'),
    (6, 'Vai Viver',                 'Mari Fernandez'),
    (7, 'Por Supuesto',             'Marina Sena'),
    (8, 'Shape of You',             'Ed Sheeran'),
    (8, 'Deixa',                    'Joao Gomes'),
    (8, 'Can’t Help Falling in Love', 'Elvis Presley'),
    (8, 'Billie Jean',              'Michael Jackson'),
    (8, 'Baile da Penha',           'DJ Rennan'),
    (9, 'Locked Out of Heaven',     'Bruno Mars'),
    (10, '7 rings',                  'Ariana grande'),
    (10, 'No Woman, No Cry',         'Bob Marley'),
    (10, 'Simply the Best',          'Tina Turner'),
    (11, 'Lose Yourself', 	     'Eminem'),
    (11, 'Like a Rolling Stone',     'Bob Dylan'),
    (12, 'Semente',                  'Armandinho'),
    (12, 'My Heart Will Go On',	     'Céline Dion'),
    (12, 'Detalhes', 		     'Roberto carlos'),
    (13, 'Meu Ébano',                'Alcione'),
    (13, 'Tetelestai',               'Isadora Pompeo');


-- album --
INSERT INTO Album (NomeAlbum, IDPadrao) VALUES ('Álbum 1', 1);
INSERT INTO Album (NomeAlbum, IDPadrao) VALUES ('Álbum 2', 2);
INSERT INTO Album (NomeAlbum, IDPadrao) VALUES ('Álbum 3', 3);
INSERT INTO Album (NomeAlbum, IDPadrao) VALUES ('Álbum 4', 4);
INSERT INTO Album (NomeAlbum, IDPadrao) VALUES ('Álbum 5', 5);
INSERT INTO Album (NomeAlbum, IDPadrao) VALUES ('Álbum 6', 6);
INSERT INTO Album (NomeAlbum, IDPadrao) VALUES ('Álbum 7', 7);
INSERT INTO Album (NomeAlbum, IDPadrao) VALUES ('Álbum 8', 8);
INSERT INTO Album (NomeAlbum, IDPadrao) VALUES ('Álbum 9', 9);
INSERT INTO Album (NomeAlbum, IDPadrao) VALUES ('Álbum 10', 10);


-- contem --

INSERT INTO Contem (Titulo, Nome, IDPadrao, NomeAlbum)
VALUES ('Someone Like You', 'Adele',                    1,   'Álbum 1'),
       ('Ressuscita-me',    'Aline Barros',             1,   'Álbum 2'),
       ('Me atraiu',        'Gabriela Rocha',           2,   'Álbum 3'),
       ('Hear Me Now',      'Alok',                     1,   'Álbum 4'),
       ('Solta o Grave',    'MC Pedrinho',              3,   'Álbum 5'),
       ('Diamonds',         'Rihanna',        		4,   'Álbum 6'),
       ('Vai Viver',        'Mari Fernandez',           6,   'Álbum 7'),
       ('Bad Guy',          'Billie Eilish',   		3,   'Álbum 8'),
       ('Detalhes',  	    'Roberto carlos', 		12,  'Álbum 9'),
       ('Zé da Recaída',    'Gusttavo Lima',   		4,   'Álbum 10');


-- hits --

ALTER TABLE Hits RENAME TO HitsSingles;

INSERT INTO HitsSingles (Titulo, Nome, TipoMusic)
VALUES
('Me atraiu',                  'Gabriela Rocha',  'Hits'),
('Hear Me Now',                'Alok',            'Single'),
('Depois da Briga',            'Péricles',        'Hits'),
('Solta o Grave',              'MC Pedrinho',     'Single'),
('Bad Guy',                    'Billie Eilish',   'Hits'),
('Bohemian Rhapsody',          'Freddie Mercury', 'Single'),
('Zé da Recaída',              'Gusttavo Lima',   'Hits'),
('Diamonds',                   'Rihanna',         'Single'),
('Summertime Sadness',         'Lana Del Rey',    'Hits'),
('Boiadera',                   'Ana castela',     'Single'),
('Supera', 	               'Marilia mendonça', 'Hits'),
('Vai Viver',                  'Mari Fernandez',   'Single'),
('Por Supuesto',               'Marina Sena',      'Hits'),
('Shape of You',               'Ed Sheeran',       'Single'),
('Deixa',                      'Joao Gomes',       'Hits'),
('Can’t Help Falling in Love', 'Elvis Presley',    'Single'),
('Billie Jean',                'Michael Jackson',  'Hits'),
('Baile da Penha',             'DJ Rennan',        'Single'),
('Locked Out of Heaven',       'Bruno Mars',       'Hits'),
('7 rings',                    'Ariana grande',    'Single'),
('No Woman, No Cry',           'Bob Marley',       'Hits'),
('Simply the Best',            'Tina Turner',      'Single'),
('Lose Yourself',              'Eminem',           'Hits'),
('Like a Rolling Stone',       'Bob Dylan',        'Single'),
('Semente',                    'Armandinho',       'Hits'),
('My Heart Will Go On',        'Céline Dion',      'Single'),
('Detalhes',                   'Roberto carlos',   'Hits'),
('Meu Ébano',                  'Alcione',          'Single'),
('Tetelestai',                 'Isadora Pompeo',   'Hits');


-- opcoes --
INSERT INTO Opcoes (IDOption, Tipo, ID_user) VALUES (1,  'musica',   1);
INSERT INTO Opcoes (IDOption, Tipo, ID_user) VALUES (2,  'radio',    2);
INSERT INTO Opcoes (IDOption, Tipo, ID_user) VALUES (3,  'musica',   3);
INSERT INTO Opcoes (IDOption, Tipo, ID_user) VALUES (4,  'radio',    4);
INSERT INTO Opcoes (IDOption, Tipo, ID_user) VALUES (5,  'musica',   5);
INSERT INTO Opcoes (IDOption, Tipo, ID_user) VALUES (6,  'podcast',  6);
INSERT INTO Opcoes (IDOption, Tipo, ID_user) VALUES (7,  'musica',   7);
INSERT INTO Opcoes (IDOption, Tipo, ID_user) VALUES (8,  'radio',    8);
INSERT INTO Opcoes (IDOption, Tipo, ID_user) VALUES (9,  'musica',   9);
INSERT INTO Opcoes (IDOption, Tipo, ID_user) VALUES (10, 'podcast', 10);
 
 
-- radio --
INSERT INTO Radio (IDOptionRadio, Estacao) VALUES (1, 'BBC Radio 1');
INSERT INTO Radio (IDOptionRadio, Estacao) VALUES (2, 'NPR News');
INSERT INTO Radio (IDOptionRadio, Estacao) VALUES (3, 'Nacional Brasil');
INSERT INTO Radio (IDOptionRadio, Estacao) VALUES (4, 'KEXP');
INSERT INTO Radio (IDOptionRadio, Estacao) VALUES (5, 'Radio 538');
INSERT INTO Radio (IDOptionRadio, Estacao) VALUES (6, 'Radio Nova');
INSERT INTO Radio (IDOptionRadio, Estacao) VALUES (7, 'NPR Music');
INSERT INTO Radio (IDOptionRadio, Estacao) VALUES (8, 'KCRW Music');
INSERT INTO Radio (IDOptionRadio, Estacao) VALUES (9, 'WNYC Studios');
INSERT INTO Radio (IDOptionRadio, Estacao) VALUES (10, 'Podcast Radio');


-- podcast --
INSERT INTO PodCast (IDPodCast, Temas) VALUES (1, 'Crime e Mistério');
INSERT INTO PodCast (IDPodCast, Temas) VALUES (2, 'Comédia');
INSERT INTO PodCast (IDPodCast, Temas) VALUES (3, 'Entrevistas');
INSERT INTO PodCast (IDPodCast, Temas) VALUES (4, 'Cultura e Sociedade');
INSERT INTO PodCast (IDPodCast, Temas) VALUES (5, 'Negócios e Empreendedorismo');
INSERT INTO PodCast (IDPodCast, Temas) VALUES (6, 'Saúde e Bem-Estar');
INSERT INTO PodCast (IDPodCast, Temas) VALUES (7, 'Tecnologia e Inovação');
INSERT INTO PodCast (IDPodCast, Temas) VALUES (8, 'Política e Atualidades');
INSERT INTO PodCast (IDPodCast, Temas) VALUES (9, 'Educação e Aprendizado');
INSERT INTO PodCast (IDPodCast, Temas) VALUES (10, 'Culinária e Gastronomia');

--  historico reproduçao--

INSERT INTO HistoricoReproducao (ID_user, Titulo, NomeArtista, DataReproducao) VALUES
(1, 'Someone Like You',            'Adele',           '2024-05-12'),
(1, 'Diamons',                     'Rihanna',         '2024-03-23'),
(2,'Ressuscita-me',                'Aline Barros',    '2024-02-11'),
(3, 'Me atraiu', 		   'Gabriela Rocha',  '2024-02-28'),
(4, 'Hear Me Now', 		   'Alok',            '2024-03-28'),
(4, 'Solta o Grave', 		   'MC Pedrinho',     '2023-05-18'),
(4, 'Boiadera', 		   'Ana castela',     '2024-03-28'),
(4, 'Bohemian Rhapsody', 	   'Freddie Mercury', '2020-03-28'),
(5, 'Depois da Briga', 		   'Péricles',        '2024-01-28'),
(6, 'Solta o Grave', 		   'MC Pedrinho',     '2022-07-09'),
(7, 'Bad Guy', 			   'Billie Eilish',   '2024-02-08'),
(8, 'Bohemian Rhapsody', 	   'Freddie Mercury', '2024-01-06'),
(9, 'Zé da Recaída',               'Gusttavo Lima',   '2024-03-28'),
(10, 'Diamonds',                   'Rihanna',         '2024-03-28'),
(11, 'Summertime Sadness', 	   'Lana Del Rey',    '2024-03-28'),
(12, 'Boiadera', 		   'Ana castela',     '2024-03-28'),
(13, 'Supera', 			   'Marilia mendonça','2024-03-28'),
(14, 'Vai Viver', 		   'Mari Fernandez',  '2024-03-28'),
(15, 'Por Supuesto', 		   'Marina Sena',     '2024-03-28'),
(15, 'Zé da Recaída',              'Gusttavo Lima',   '2024-03-28'),
(15, 'Tetelestai', 		   'Isadora Pompeo',  '2024-03-06'),
(15, 'Me atraiu', 		   'Gabriela Rocha',  '2024-01-10'),
(15, 'Simply the Best', 	   'Tina Turner',     '2021-11-09'),
(15, 'Someone Like You',            'Adele',          '2023-09-12'),
(16, 'Shape of You', 		   'Ed Sheeran',      '2024-03-28'),
(16, 'Billie Jean', 		   'Michael Jackson', '2022-04-18'),
(16, 'Locked Out of Heaven', 	   'Bruno Mars',      '2024-03-28'),
(16, 'Baile da Penha', 		   'DJ Rennan',       '2024-03-28'),
(16, '7 rings', 		   'Ariana grande',   '2024-03-28'),
(17, 'Deixa', 			   'Joao Gomes',      '2024-03-28'),
(18, 'Can’t Help Falling in Love', 'Elvis Presley',   '2024-02-20'),
(19, 'Billie Jean', 		   'Michael Jackson', '2024-01-01'),
(20, 'Baile da Penha', 		   'DJ Rennan',       '2024-02-18'),
(21, 'Locked Out of Heaven', 	   'Bruno Mars',      '2024-02-28'),
(22, '7 rings', 		   'Ariana grande',   '2024-02-28'),
(23, 'No Woman, No Cry', 	   'Bob Marley',      '2024-01-07'),
(24, 'Simply the Best', 	   'Tina Turner',     '2024-03-23'),
(25, 'Lose Yourself', 		   'Eminem',          '2024-02-25'),
(26, 'Like a Rolling Stone', 	   'Bob Dylan',       '2024-02-15'),
(27, 'Semente', 		   'Armandinho',      '2024-02-12'),
(28, 'My Heart Will Go On', 	   'Céline Dion',     '2024-02-27'),
(28,'No Woman, No Cry', 	   'Bob Marley',      '2021-06-07'),
(28, 'Meu Ébano', 		   'Alcione',         '2024-02-27'),
(29, 'Detalhes', 		   'Roberto carlos',  '2024-01-04'),
(30, 'Meu Ébano', 		   'Alcione',         '2024-02-23'),
(31, 'Tetelestai', 		   'Isadora Pompeo',  '2024-03-06');


-- Consultas --

-- Lista os usuários que utilizam rádio --
SELECT op.ID_user, usu.NomeUser 
FROM Opcoes op, Usuario usu
Where  op.ID_user = usu.ID_user and Tipo = 'radio';
/*
   2;"Jhully Vitória"
   4;"Maria Nunes"
   8;"Gabriel Lucas"
*/


-- Selecionar todos os artistas que estão no MusicMat em ordem Crescente --
SELECT Nome
FROM Artista
ORDER BY Nome ASC;
/*
"Adele"
"Alcione"
"Aline Barros"
"Alok"
"Ana castela"
"Ariana grande"
"Armandinho"
"Billie Eilish"
"Bob Dylan"
"Bob Marley"
"Bruno Mars"
"Céline Dion"
"DJ Rennan"
"Ed Sheeran"
"Elvis Presley"
"Eminem"
"Freddie Mercury"
"Gabriela Rocha"
"Gusttavo Lima"
"Isadora Pompeo"
"Joao Gomes"
"Lana Del Rey"
"Mari Fernandez"
"Marilia mendonça"
"Marina Sena"
"MC Pedrinho"
"Michael Jackson"
"Péricles"
"Rihanna"
"Roberto carlos"
"Tina Turner"
*/

-- Listar a quantidade de usuários que o app possui --

SELECT COUNT(ID_user)
FROM Usuario
/*
  32
*/

-- Visualizar as musicas mais ouvidas e os seus artistas --
SELECT m.titulo, A.Nome
FROM HitsSingles h
JOIN Musica m ON h.Titulo = m.Titulo
JOIN Artista A ON A.Nome = h.Nome
AND h.TipoMusic = 'Hits'
GROUP BY m.titulo, A.Nome
ORDER BY m.titulo ASC;
/*
"Bad Guy";		"Billie Eilish"
"Billie Jean";		"Michael Jackson"
"Deixa";		"Joao Gomes"
"Depois da Briga";	"Péricles"
"Detalhes";		"Roberto carlos"
"Locked Out of Heaven";	"Bruno Mars"
"Lose Yourself";	"Eminem"
"Me atraiu";		"Gabriela Rocha"
"No Woman, No Cry";	"Bob Marley"
"Por Supuesto";		"Marina Sena"
"Semente";		"Armandinho"
"Summertime Sadness";	"Lana Del Rey"
"Supera";		"Marilia mendonça"
"Tetelestai";		"Isadora Pompeo"
"Zé da Recaída";	"Gusttavo Lima"
*/

-- Agrupar todas as músicas por gênero e contar quantas músicas há em cada gênero --
SELECT Genero, COUNT(*) AS Total_Musicas
FROM Musica
GROUP BY Genero
ORDER BY Genero;
/*
"Eletrônica";   1
"Funk";		2
"Gospel";	3
"Hip Hop";	1
"MPB";		2
"Pop";		11
"Reggae";	2
"Rock";		3
"Samba";	2
"Sertanejo";	4
*/

-- Calcula a média das idades dos artistas --
SELECT ROUND(AVG(EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM DataNasc))) AS Media_Idades
FROM Artista;
/*
46
*/

-- lista os usuários que não têm entradas no histórico de reprodução nos últimos 2 meses. --
SELECT u.NomeUser
FROM Usuario u
WHERE NOT EXISTS(
    SELECT 1
    FROM HistoricoReproducao hr
    WHERE hr.ID_user = u.ID_user
    AND hr.DataReproducao >= CURRENT_DATE - INTERVAL '2 month'
);
/*
"Romilto Pereira"
"Jayne Francielle"
"Gabriel Lucas"
"Rafael Souza"
"Mariana Santos"
"Carlos Oliveira"
"Lucas Barbosa"
*/

-- Lista o id dos usuários que mais reproduzem músicas
SELECT ID_user, COUNT(*) AS Total_Reproducoes
FROM HistoricoReproducao
GROUP BY ID_user
ORDER BY Total_Reproducoes DESC
LIMIT 5;
/*
15;6
16;5
4; 4
28;3
1; 2
*/

-- Lista os nomes e emails dos usuários que utilizam o podcast
SELECT u.NomeUser, u.email
FROM Usuario u
INNER  JOIN Opcoes op ON u.id_user = op.id_user
AND Tipo = 'podcast'
/*
  "Jayne Francielle";"Jayne834@gmail.com"
  "Ana Castro";"AnaCast498@gmail.com"
*/

-- Lista informações sobre o usuário de negócio
SELECT u.NomeUser, u.Email, un.CNPJ
FROM Usuario u
INNER JOIN UserNegocio un ON un.idnegocio = u.id_user;
/*
"Thiago Rodrigues";"Thiago876@gmail.com";12345678901234
"Patrícia Lima";"Patricia345@gmail.com";23456789012345
"Carla Pereira";"Carla890@gmail.com";34567890123456
"Rafael Souza";"Rafael567@gmail.com";45678901234567
"Renata Oliveira";"Renata987@gmail.com";56789012345678
"Luciana Alves";"Luciana321@gmail.com";67890123456789
"Pedro Barbosa";"Pedro789@gmail.com";78901234567890
"Mariana Santos";"Mariana654@gmail.com";89012345678901
"Diego Silva";"Diego321@gmail.com";90123456789012
"Tatiane Oliveira";"Tatiane543@gmail.com";12345678901230
*/



-- Atualizações --

-- tabela radio --
UPDATE Radio
SET Estacao = 'Vibração Sonora FM'
WHERE IDOptionRadio = 10;

-- Consulta para verificar a atualização feita na tabela
select * from Radio where IDOptionRadio = 10;
/*
   10;"Vibração Sonora FM"
*/

-- tabela musica
UPDATE Musica
SET Duracao = '05:15:00'
WHERE Titulo = 'Someone Like You' and Nome = 'Adele';

-- Consulta para verificar a atualização feita na tabela Musica
select * from Musica where Nome = 'Adele'
/*
   "Someone Like You";"Adele";"2024-02-03";"05:15:00";"Pop"
*/


-- Álgebra Relacional --

/*

 -- 01) Selecionar todos os artistas que estão no MusicMat em ordem Crescente --
  Junção:
	temp1 <- Artista * ρ Artista2
  Seleção:  
       temp2 <- σ Artista.Nome < Artista2.Nome(temp1)
  Projeção:
       π Nome(temp2)
 
 -- 02) Agrupar todas as músicas por gênero e contar quantas músicas há em cada gênero --
 
 Produto Cartesiano: 
		        temp <- Musica  X  ρ Musica2
 Selecao: 
			temp1 <- σ Musica.Genero = Musica2.Genero(temp)
 Projeção:
			π Genero(temp1)

 -- 03) Visualizar as musicas mais ouvidas e os seus artistas --
 
 Seleção:
	  σ TipoMusic = 'Hits' (HitsSingles)
 Junção:
	  temp <- HitsSingles * Musica
 Junção:
	  temp1 <- temp * Artista
 Projeção:
	  π titulo, Nome (σ TipoMusic = 'Hits' (temp1))


 -- 04) -- Lista os nomes e emails dos usuários que utilizam o podcast --
Seleção:
	σ Tipo = 'podcast' (Opcoes)
Junção:
	temp <- Usuario * Opcoes
Projeção:
        π NomeUser, email (σ Tipo = 'podcast' (temp))



*/

-- STORED PROCEDURE: 
CREATE OR REPLACE FUNCTION UploadMusica(
    p_NomeArtista VARCHAR(25),
    p_Titulo VARCHAR(10),
    p_Ano DATE,
    p_Duracao TIME,
    p_Genero VARCHAR,
    p_IDNegocio NUMERIC,
    p_DataNasc DATE,
    p_URL VARCHAR(100)
)
RETURNS VOID
AS $$
DECLARE
    v_ArtistaIdade INT;
BEGIN
    -- Verifica se o usuário de negócio existe
    IF NOT EXISTS (SELECT 1 FROM UserNegocio WHERE IDNegocio = p_IDNegocio) THEN
        RAISE EXCEPTION 'O usuário de negócio especificado não existe.';
    END IF;

    -- Verifica se o usuário é do tipo de usuário de negócio
    IF NOT EXISTS (SELECT 1 FROM Usuario WHERE ID_user = p_IDNegocio) THEN
        RAISE EXCEPTION 'O usuário especificado não é um usuário de negócio.';
    END IF;

    -- Calcula a idade do artista com base na data de nascimento fornecida
    v_ArtistaIdade := EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM p_DataNasc);

    -- Insere o artista na tabela Artista, se ainda não existir
    INSERT INTO Artista (Nome, DataNasc, URL, Idade)
    SELECT p_NomeArtista, p_DataNasc, p_URL, v_ArtistaIdade
    WHERE NOT EXISTS (SELECT 1 FROM Artista WHERE Nome = p_NomeArtista);

    -- Insere a música na tabela Musica
    INSERT INTO Musica (Titulo, Nome, Ano, Duracao, Genero, Upload)
    VALUES (p_Titulo, p_NomeArtista, p_Ano, p_Duracao, p_Genero, p_IDNegocio);
END;
$$ LANGUAGE plpgsql;


select UploadMusica('Konai', 'Reino','2018-03-11','00:02:45', 'Soul', 25, '2000-06-19', 'https://pt.wikipedia.org/wiki/Konai_(cantor)');
 
-- TRIGGER:

CREATE OR REPLACE FUNCTION adicionar_reproducao_historico()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO HistoricoReproducao (ID_user, Titulo, NomeArtista, DataReproducao)
    VALUES (NEW.IDPadrao, NEW.Titulo, NEW.Nome, CURRENT_DATE);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_adicionar_reproducao_historico
AFTER INSERT ON Compra
FOR EACH ROW
EXECUTE PROCEDURE adicionar_reproducao_historico();

INSERT INTO Compra(IDPadrao, Titulo, Nome) VALUES (1, 'Reino', 'Konai')

select * from HistoricoReproducao;
/*
   48; 1; "Reino"; "Konai"; "2024-04-03"
*/
