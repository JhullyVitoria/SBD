create schema universidadee
set search_path to universidadee
SET datestyle TO postgres, dmy;

CREATE TABLE CURSO(
       NumCurso DECIMAL(9) NOT NULL,
       Nome CHAR(30) NOT NULL,
       TotalCreditos DECIMAL(4) NOT NULL,
       CONSTRAINT CHAVECURSO 
         PRIMARY KEY (NumCurso)
);

CREATE TABLE ALUNO(
       NumAluno DECIMAL(9) NOT NULL,
       Nome CHAR(70) NOT NULL,
       Endereco CHAR(70) NOT NULL,
       Cidade CHAR(25) NOT NULL,
       Telefone CHAR(25),
       NumCurso DECIMAL(9) NOT NULL,
       CONSTRAINT CHAVEALUNO 
         PRIMARY KEY (NumAluno),
       CONSTRAINT ESTRANGEIRACURSO
         FOREIGN KEY (NumCurso) REFERENCES CURSO
);

CREATE TABLE DISCIPLINA(
       NumDisp DECIMAL(9) NOT NULL,
       Nome CHAR(30) NOT NULL,
       QuantCreditos DECIMAL(9) NOT NULL,
       CONSTRAINT CHAVEDISCIPLINA 
         PRIMARY KEY (NumDisp)
);

CREATE TABLE PROFESSOR(
       NumFunc DECIMAL(9) NOT NULL,
       Nome CHAR(70) NOT NULL,
       Admissao DATE NOT NULL,
       AreaPesquisa CHAR(30),
       CONSTRAINT CHAVEPROFESSOR 
         PRIMARY KEY (NumFunc)
);

CREATE TABLE AULA(
       NumAluno DECIMAL(9) NOT NULL,
       NumDisp DECIMAL(9) NOT NULL,
       NumFunc DECIMAL(9) NOT NULL,
       Semestre CHAR(10) NOT NULL,
       Nota DECIMAL(5,2) NOT NULL,       
       CONSTRAINT CHAVEAULA 
         PRIMARY KEY (NumAluno, NumDisp, NumFunc, Semestre),
       CONSTRAINT ESTRANGEIRAALUNO
         FOREIGN KEY (NumAluno) REFERENCES ALUNO,
       CONSTRAINT ESTRANGEIRADISCIPLINA
         FOREIGN KEY (NumDisp) REFERENCES DISCIPLINA,
       CONSTRAINT ESTRANGEIRAPROFESSOR
         FOREIGN KEY (NumFunc) REFERENCES PROFESSOR
);

CREATE TABLE DISCIPLINACURSO(
       NumDisp DECIMAL(9) NOT NULL,
       NumCurso DECIMAL(9) NOT NULL,
       CONSTRAINT CHAVEDISPCURSO 
         PRIMARY KEY (NumDisp, NumCurso),
       CONSTRAINT ESTRANGEIRADISP
         FOREIGN KEY (NumDisp) REFERENCES DISCIPLINA,
       CONSTRAINT ESTRANGEIRACURSO
         FOREIGN KEY (NumCurso) REFERENCES CURSO
);

INSERT INTO CURSO VALUES (2142, 'ENGENHARIA CIVIL', 1500);
INSERT INTO CURSO VALUES (2143, 'CIENCIA DA COMPUTACAO', 2000);
INSERT INTO CURSO VALUES (2144, 'DIREITO', 1750);
INSERT INTO CURSO VALUES (2145, 'PEDAGOGIA', 1500);
INSERT INTO CURSO VALUES (2146, 'ODONTOLOGIA', 1600);

INSERT INTO ALUNO VALUES (111, 'EDVALDO CARLOS SILVA', 'AV. SAO CARLOS, 186', 'SAO CARLOS - SP', '(017)276-9999', 2143);
INSERT INTO ALUNO VALUES (112, 'JOAO BENEDITO SCAPIN', 'R. JOSE BONIFACIO, 70', 'SAO CARLOS - SP', '(017)273-8974', 2142);
INSERT INTO ALUNO VALUES (113, 'CAROL ANTONIA SILVEIRA', 'R. LUIZ CAMOES, 120', 'IBATE - SP', '(017)278-8568', 2145);
INSERT INTO ALUNO VALUES (114, 'MARCOS JOAO CASANOVA', 'AV. SAO CARLOS, 176', 'SAO CARLOS - SP', '(017)274-9874', 2143);
INSERT INTO ALUNO VALUES (115, 'SIMONE CRISTINA LIMA', 'R. RAUL JUNIOR, 180', 'SAO CARLOS - SP', '(017)273-9865', 2144);
INSERT INTO ALUNO VALUES (116, 'AILTON CASTRO', 'R. ANTONIO CARLOS, 120', 'IBATE - SP', '(017)278-8563', 2142);
INSERT INTO ALUNO VALUES (117, 'JOSE PAULO FIGUEIRA', 'R. XV DE NOVEMBRO, 871', 'SAO CARLOS - SP', '(017)274-9873', 2145);

INSERT INTO DISCIPLINA VALUES (1, 'BANCO DE DADOS', 30);
INSERT INTO DISCIPLINA VALUES (2, 'ESTRUTURA DE DADOS', 30);
INSERT INTO DISCIPLINA VALUES (3, 'DIREITO PENAL', 25);
INSERT INTO DISCIPLINA VALUES (4, 'CALCULO NUMERICO', 30);
INSERT INTO DISCIPLINA VALUES (5, 'PSICOLOGIA INFANTIL', 25);
INSERT INTO DISCIPLINA VALUES (6, 'DIREITO TRIBUTARIO', 33);
INSERT INTO DISCIPLINA VALUES (7, 'ENGENHARIA DE SOFTWARE', 27);

INSERT INTO PROFESSOR VALUES (45675, 'ABGAIR SIMON FERREIRA', '10/04/1992','BANCO DE DADOS');
INSERT INTO PROFESSOR VALUES (45690, 'RAMON TRAVANTI', '20/05/1993','DIREITO ROMANO');
INSERT INTO PROFESSOR VALUES (45691, 'GUSTAVO GOLVEIA NETTO', '05/04/1993','SOCIOLOGIA');
INSERT INTO PROFESSOR VALUES (45692, 'MARCOS SALVADOR', '31/03/1993','MATEMATICA FINANCEIRA');
INSERT INTO PROFESSOR VALUES (45693, 'CINTIA FALCAO', '15/02/1993','ENGENHARIA DE SOFTWARE');

INSERT INTO AULA VALUES (111, 1, 45675, '01/1998', 8.5);
INSERT INTO AULA VALUES (111, 2, 45675, '01/1998', 6.0);
INSERT INTO AULA VALUES (111, 2, 45675, '02/1998', 7.0);
INSERT INTO AULA VALUES (115, 3, 45690, '01/1998', 4.5);
INSERT INTO AULA VALUES (115, 3, 45690, '02/1998', 7.5);
INSERT INTO AULA VALUES (111, 4, 45692, '01/1998', 8.0);
INSERT INTO AULA VALUES (112, 4, 45692, '01/1998', 7.0);
INSERT INTO AULA VALUES (113, 5, 45691, '01/1998', 7.5);
INSERT INTO AULA VALUES (115, 6, 45690, '01/1998', 9.0);
INSERT INTO AULA VALUES (111, 7, 45693, '01/1998', 10.0);
INSERT INTO AULA VALUES (112, 7, 45693, '01/1998', 5.5);
INSERT INTO AULA VALUES (112, 7, 45693, '02/1998', 10.0);
INSERT INTO AULA VALUES (114, 1, 45675, '01/1998', 7.0);
INSERT INTO AULA VALUES (114, 2, 45675, '01/1998', 8.0);
INSERT INTO AULA VALUES (114, 4, 45692, '01/1998', 6.5);
INSERT INTO AULA VALUES (114, 4, 45692, '02/1998', 8.5);
INSERT INTO AULA VALUES (116, 4, 45692, '01/1998', 3.5);
INSERT INTO AULA VALUES (116, 4, 45692, '02/1998', 9.5);
INSERT INTO AULA VALUES (114, 7, 45693, '01/1998', 9.5);
INSERT INTO AULA VALUES (116, 7, 45693, '01/1998', 8.5);

INSERT INTO DISCIPLINACURSO VALUES (1, 2143);
INSERT INTO DISCIPLINACURSO VALUES (2, 2143);
INSERT INTO DISCIPLINACURSO VALUES (3, 2144);
INSERT INTO DISCIPLINACURSO VALUES (4, 2143);
INSERT INTO DISCIPLINACURSO VALUES (4, 2142);
INSERT INTO DISCIPLINACURSO VALUES (5, 2145);
INSERT INTO DISCIPLINACURSO VALUES (6, 2144);
INSERT INTO DISCIPLINACURSO VALUES (7, 2143);
INSERT INTO DISCIPLINACURSO VALUES (7, 2142);

/* CONSULTA 1- Todos os cursos da universidade */

select *
from curso;

/*
2142	"ENGENHARIA CIVIL              "	1500
2143	"CIENCIA DA COMPUTACAO         "	2000
2144	"DIREITO                       "	1750
2145	"PEDAGOGIA                     "	1500
2146	"ODONTOLOGIA                   "	1600

*/

/* Consulta 2 - Quais os nomes e telefones de alunos da cidade de São Carlos - SP em ordem DESC de nome.*/
 
select nome, telefone
from aluno
where cidade = 'SAO CARLOS - SP'
order by nome desc
/* 
"SIMONE CRISTINA LIMA                                                  "	"(017)273-9865            "
"MARCOS JOAO CASANOVA                                                  "	"(017)274-9874            "
"JOSE PAULO FIGUEIRA                                                   "	"(017)274-9873            "
"JOAO BENEDITO SCAPIN                                                  "	"(017)273-8974            "
"EDVALDO CARLOS SILVA                                                  "	"(017)276-9999            "
*/

/* Consulta 3 - Quais os nomes de professores que foram contratados antes de 01/jan/1993. */

select nome 
from professor 
where admissao < '01/01/1993'

/*"ABGAIR SIMON FERREIRA                                                 "*/

/* Consulta 4 - Quais os nomes de alunos que iniciam com a letra 'J'.  */

select nome
from aluno
where nome = 'j'

/* consulta 5 - Quais os nomes das disciplinas do curso de Ciência da Computação. */

select disciplina.nome
from disciplinacurso d, curso, disciplina
where d.NumDisp = disciplina.NumDisp and 
curso.NumCurso = d.NumCurso
/*"BANCO DE DADOS                "
"ESTRUTURA DE DADOS            "
"DIREITO PENAL                 "
"CALCULO NUMERICO              "
"CALCULO NUMERICO              "
"PSICOLOGIA INFANTIL           "
"DIREITO TRIBUTARIO            "
"ENGENHARIA DE SOFTWARE        "
"ENGENHARIA DE SOFTWARE        "*/

/* consulta 6 - Quais os nomes dos cursos que possuem no curriculum a disciplina Cálculo Numérico.  */

select curso.nome
from curso, disciplinacurso d, disciplina di
where di.NumDisp = d.NumDisp and curso.NumCurso = d.NumCurso 
and di.nome = 'CALCULO NUMERICO'

/*"CIENCIA DA COMPUTACAO         "
"ENGENHARIA CIVIL              "*/

/* consulta 7 - Quais os nomes das disciplina que o aluno Marcos João Casanova cursou no 1º semestre de 1998.  */
select d.nome
from disciplina d, aluno al, aula
where aula.NumAluno = al.NumAluno 
and al.nome = 'MARCOS JOAO CASANOVA' and aula.semestre = '01/1998'
/*"BANCO DE DADOS                "
"ESTRUTURA DE DADOS            "
"DIREITO PENAL                 "
"CALCULO NUMERICO              "
"PSICOLOGIA INFANTIL           "
"DIREITO TRIBUTARIO            "
"ENGENHARIA DE SOFTWARE        "
"BANCO DE DADOS                "
"ESTRUTURA DE DADOS            "
"DIREITO PENAL                 "
"CALCULO NUMERICO              "
"PSICOLOGIA INFANTIL           "
"DIREITO TRIBUTARIO            "
"ENGENHARIA DE SOFTWARE        "
"BANCO DE DADOS                "
"ESTRUTURA DE DADOS            "
"DIREITO PENAL                 "
"CALCULO NUMERICO              "
"PSICOLOGIA INFANTIL           "
"DIREITO TRIBUTARIO            "
"ENGENHARIA DE SOFTWARE        "
"BANCO DE DADOS                "
"ESTRUTURA DE DADOS            "
"DIREITO PENAL                 "
"CALCULO NUMERICO              "
"PSICOLOGIA INFANTIL           "
"DIREITO TRIBUTARIO            "
"ENGENHARIA DE SOFTWARE        "*/

/* consulta 8 - Quais os nomes das disciplinas que o aluno Ailton Castro foi reprovado.  */
select d.nome
from disciplina d,aluno al, aula au
where al.NumAluno = au.NumAluno and au.NumDisp = d.NumDisp 
and au.nota <6
/*"DIREITO PENAL                 "
"ENGENHARIA DE SOFTWARE        "
"CALCULO NUMERICO              "*/

/* consulta 9 - Quais os nomes de alunos reprovados na disciplina de Cálculo Numérico no 1º semestre de 1998.  */
select al.nome
from aluno al, disciplina d,aula au
where al.NumAluno = au.NumAluno and d.nome = 'CALCULO NUMERICO' 
and au.semestre = '01/1998'
/*"EDVALDO CARLOS SILVA                                                  "
"EDVALDO CARLOS SILVA                                                  "
"EDVALDO CARLOS SILVA                                                  "
"EDVALDO CARLOS SILVA                                                  "
"JOAO BENEDITO SCAPIN                                                  "
"JOAO BENEDITO SCAPIN                                                  "
"CAROL ANTONIA SILVEIRA                                                "
"MARCOS JOAO CASANOVA                                                  "
"MARCOS JOAO CASANOVA                                                  "
"MARCOS JOAO CASANOVA                                                  "
"MARCOS JOAO CASANOVA                                                  "
"SIMONE CRISTINA LIMA                                                  "
"SIMONE CRISTINA LIMA                                                  "
"AILTON CASTRO                                                         "
"AILTON CASTRO                                                         "*/


/* consulta 10 - Quais os nomes das disciplinas ministradas pelo prof. Ramon Travanti.  */
select d.nome
from disciplina d, professor pf, aula au
where pf.NumFunc = au.NumFunc 
and au.NumDisp = d.NumDisp and pf.nome = 'RAMON TRAVANTI'
/*"DIREITO PENAL                 "
"DIREITO PENAL                 "
"DIREITO TRIBUTARIO            "*/

/* consulta 11 - Quais os nomes dos professores que já ministraram aula de Banco de Dados.  */
select pf.nome
from disciplina d, professor pf, aula au
where pf.NumFunc = au.NumFunc 
and au.NumDisp = d.NumDisp and d.nome = 'BANCO DE DADOS'

/*"ABGAIR SIMON FERREIRA                                                 "
"ABGAIR SIMON FERREIRA                                                 "*/

/* consulta 12 - Quais os nomes de alunos que cursaram o 1º semestre de 1998 em ordem alfabética, em cada disciplina oferecida nesse semestre 
(listar também os nomes das disciplinas e os nomes dos professores que ministraram cada disciplina). */
select al.nome,d.nome,pf.nome
from disciplina d, professor pf, aluno al, aula au
where au.semestre = '01/1998' and d.NumDisp = au.NumDisp
and au.Numfunc = pf.NumFunc and al.NumAluno = au.NumAluno
order by al.nome 
/*"AILTON CASTRO                                                         "	"CALCULO NUMERICO              "	"MARCOS SALVADOR                                                       "
"AILTON CASTRO                                                         "	"ENGENHARIA DE SOFTWARE        "	"CINTIA FALCAO                                                         "
"CAROL ANTONIA SILVEIRA                                                "	"PSICOLOGIA INFANTIL           "	"GUSTAVO GOLVEIA NETTO                                                 "
"EDVALDO CARLOS SILVA                                                  "	"BANCO DE DADOS                "	"ABGAIR SIMON FERREIRA                                                 "
"EDVALDO CARLOS SILVA                                                  "	"ESTRUTURA DE DADOS            "	"ABGAIR SIMON FERREIRA                                                 "
"EDVALDO CARLOS SILVA                                                  "	"CALCULO NUMERICO              "	"MARCOS SALVADOR                                                       "
"EDVALDO CARLOS SILVA                                                  "	"ENGENHARIA DE SOFTWARE        "	"CINTIA FALCAO                                                         "
"JOAO BENEDITO SCAPIN                                                  "	"ENGENHARIA DE SOFTWARE        "	"CINTIA FALCAO                                                         "
"JOAO BENEDITO SCAPIN                                                  "	"CALCULO NUMERICO              "	"MARCOS SALVADOR                                                       "
"MARCOS JOAO CASANOVA                                                  "	"CALCULO NUMERICO              "	"MARCOS SALVADOR                                                       "
"MARCOS JOAO CASANOVA                                                  "	"BANCO DE DADOS                "	"ABGAIR SIMON FERREIRA                                                 "
"MARCOS JOAO CASANOVA                                                  "	"ESTRUTURA DE DADOS            "	"ABGAIR SIMON FERREIRA                                                 "
"MARCOS JOAO CASANOVA                                                  "	"ENGENHARIA DE SOFTWARE        "	"CINTIA FALCAO                                                         "
"SIMONE CRISTINA LIMA                                                  "	"DIREITO PENAL                 "	"RAMON TRAVANTI                                                        "
"SIMONE CRISTINA LIMA                                                  "	"DIREITO TRIBUTARIO            "	"RAMON TRAVANTI                                                        "*/
*/

/* consulta 13 - Quais nomes de alunos, nomes de disciplinas e notas do 1º semestre de 1998 no curso de Ciência da Computação. */

select al.nome, di.nome
from aluno al, disciplinacurso d, aula au, curso, disciplina di
where curso.NumCurso = d.NumCurso and d.NumDisp = di.NumDisp
and al.NumAluno = au.NumAluno and au.NumAluno = al.NumAluno 
and au.NumDisp = di.NumDisp and au.semestre =' 01/1998'
and curso.nome = 'CIENCIA DA COMPUTACAO'

