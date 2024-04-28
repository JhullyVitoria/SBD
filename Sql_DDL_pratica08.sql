/*
Nomes: Jhully vitoriaNunes Leite - 12011BCC058
	   Laura de barros Moreira   - 12111BCC042
	   Gleison dos Santos Pinto  – 11721BCC002
*/

CREATE SCHEMA Locadora
SET search_path TO Locadora
 
CREATE TABLE Cliente (
	num_cliente SMALLINT NOT NULL,
	nome VARCHAR(25) NOT NULL,
	endereco VARCHAR(20),
	foneres INT,
	fonecel INT,
	CONSTRAINT chaveCliente PRIMARY KEY (num_cliente)
);


CREATE TABLE Ator(
	cod SMALLINT   NOT NULL,
	data_nasc date NOT NULL,
	nacionalidade VARCHAR(20),
	nomereal VARCHAR(25),
	nomeArtistico VARCHAR(20),
	CONSTRAINT chaveAtor PRIMARY KEY (cod)
);
 
CREATE TABLE Classificacao (
	code  SMALLINT NOT NULL,
	nome  VARCHAR(25) NOT NULL,
	preco numeric(7,2),
	CONSTRAINT codepk PRIMARY KEY (code)
);
 
CREATE TABLE Filme (
	num_filme  SMALLINT NOT NULL,
	titulo_Ori VARCHAR(25) NOT NULL,
	titulo_PT  VARCHAR(20),
	duracao    TIME,
	data_lancamento DATE,
	direcao    VARCHAR(25),
	categoria  VARCHAR(15),
	classificacaoF SMALLINT,
	CONSTRAINT chaveFilme PRIMARY KEY (num_filme),
	CONSTRAINT Estrangeiraclass FOREIGN KEY (classificacaoF) 
	REFERENCES Classificacao(code)
);
 
CREATE TABLE Midia (
	num_filmeM SMALLINT NOT NULL,
	numero 	   INT NOT NULL,
	tipo 	   VARCHAR(15) NOT NULL,
	CONSTRAINT MidiaPK  PRIMARY KEY (num_filmeM, numero, tipo),
	CONSTRAINT MidiaFK  FOREIGN KEY (num_filmeM)  
	REFERENCES Filme(num_filme)
);
 
CREATE TABLE Estrela (
	num_filmeE SMALLINT NOT NULL,
	Codator    SMALLINT NOT NULL,
	CONSTRAINT EstrelaPK  PRIMARY KEY (num_filmeE, Codator),
	CONSTRAINT EstrelaFK  FOREIGN KEY (num_filmeE)  
	REFERENCES Filme(num_filme),
	CONSTRAINT Estrela2FK  FOREIGN KEY (Codator)  
	REFERENCES Ator(cod)
);
 
CREATE TABLE Emprestimo (
	num_filmeEm SMALLINT NOT NULL,
	numero    	INT NOT NULL,
	tipo        VARCHAR(11) NOT NULL,
	cliente     SMALLINT 	NOT NULL,
	data_ret    DATE,
	data_dev    DATE,
	valor_pg    numeric(7,2),
	CONSTRAINT EmprestimoPK  PRIMARY KEY (num_filmeEm, numero, tipo, cliente),
	CONSTRAINT NumFK 		 FOREIGN KEY (numero, num_filmeEm, tipo)  
	REFERENCES Midia(numero, num_filmeM, tipo),
	CONSTRAINT ClienteFK     FOREIGN KEY (cliente)  
	REFERENCES Cliente(num_cliente)
);


/* (2) Faça um script para remover todas as restrições de 
	integridade (PK e FK). É PROIBIDO USAR CASCADE. */
	
ALTER TABLE Emprestimo DROP CONSTRAINT ClienteFK /* chave estrangeira Cliente em Empreendorismo */
ALTER TABLE Cliente    DROP CONSTRAINT chaveCliente /* chave primária de Cliente */

ALTER TABLE Estrela DROP CONSTRAINT Estrela2FK /* chave estrangeira que referencia chave de ator */
ALTER TABLE Ator 	DROP CONSTRAINT chaveAtor /* chave primaria de Ator */

ALTER TABLE Filme DROP CONSTRAINT Estrangeiraclass /* chave estrangeira que referencia chave de Classficação */
ALTER TABLE Classificacao DROP CONSTRAINT codepk  /* chave primária de classificação */

ALTER TABLE Midia 	DROP CONSTRAINT MidiaFK /* chave estrangera de Midia q referencia Filme */
ALTER TABLE Estrela DROP CONSTRAINT EstrelaFK /* chave estrangeira de Estrela q refencia filme */
ALTER TABLE Filme 	DROP CONSTRAINT chaveFilme /* chave primária de filme */

ALTER TABLE Emprestimo DROP CONSTRAINT NumFK /* chafe estrangeira de Emp. q referencia Mídia */
ALTER TABLE Midia DROP CONSTRAINT MidiaPK /* chave primária de Midia*/

ALTER TABLE Estrela DROP CONSTRAINT EstrelaPK /* chave primária de Estrela */

ALTER TABLE Emprestimo DROP CONSTRAINT EmprestimoPK /* chave primária de empréstimo */


/* (3) Faça um script para ativar todas as restrições de integridade (PK e FK). */ 

ALTER TABLE Cliente  ADD CONSTRAINT chaveCliente PRIMARY KEY(num_cliente)

ALTER TABLE Ator ADD CONSTRAINT chaveAtor PRIMARY KEY(Cod)

ALTER TABLE Classificacao ADD CONSTRAINT codepk PRIMARY KEY (code) 

ALTER TABLE Midia ADD CONSTRAINT MidiaFK FOREIGN KEY(num_filmeM)  
	REFERENCES Filme(num_filme)
ALTER TABLE Midia ADD CONSTRAINT MidiaPK PRIMARY KEY(num_filmeM, numero, tipo)

ALTER TABLE Filme ADD CONSTRAINT chaveFilme PRIMARY KEY(num_filme)
ALTER TABLE Filme ADD CONSTRAINT Estrangeiraclass FOREIGN KEY(classificacaoF) REFERENCES Classificacao(code)/* chave estrangeira que referencia chave de Classficação */

ALTER TABLE Estrela ADD CONSTRAINT EstrelaPK PRIMARY KEY(num_filmeE, Codator)
ALTER TABLE Estrela ADD CONSTRAINT Estrela2FK FOREIGN KEY(Codator) REFERENCES Ator(cod)
ALTER TABLE Estrela ADD CONSTRAINT EstrelaFK FOREIGN KEY(num_filmeE) REFERENCES Filme(num_filme)

ALTER TABLE Emprestimo ADD CONSTRAINT EmprestimoPK PRIMARY KEY(num_filmeEm, numero, tipo, cliente)
ALTER TABLE Emprestimo ADD CONSTRAINT NumFK FOREIGN KEY (numero, num_filmeEm, tipo)  
	REFERENCES Midia(numero, num_filmeM, tipo)
ALTER TABLE Emprestimo ADD CONSTRAINT ClienteFK FOREIGN KEY (cliente) 
	REFERENCES Cliente(num_cliente)

/*(4) Rode os scripts (1) e (2), viole uma restrição de integridade, e rode o script (3). Relate o que ocorreu.

Solução:
Na etapa 2 nós tentamos criar o Filme antes do Classificação, mas deu erro porque Classificacao
era referenciado  em Filme, então tivemos que criar Classificacao primeiro, rodar e depois 
criarmos o Filme.
	Além disso, também tivemos outro erro porque possui uma chave primária composta de 3 atributos
	e quando ela foi referenciada em Emprestimo nós só colocamos um atributo. Depois que percebemos
	o erro colocamos o Empretismo referenciando os três atributos que compõem a chave primária de Mídia.
	
Na etapa 03 tivemos um problema ao tentar remover a restrição de chave primária de Cliente, pois
ele estava sendo referenciado por outras tabelas. Logo, removemos a restrição de chave estrangeira 
das tabelas que referenciavam a chave primária de Cliente e depois disso que removemos a restrição
de chave primária de Cliente.
*/





