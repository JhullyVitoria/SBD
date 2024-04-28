CREATE SCHEMA LOJA;

SET SEARCH_PATH TO LOJA;

CREATE TABLE CLIENTE (
  codcliente SMALLINT PRIMARY KEY,
  nome VARCHAR(50),
  endereco VARCHAR(100),
  cidade VARCHAR(20),
  telefone VARCHAR(15),
  cgccliente VARCHAR(20),
  contato VARCHAR(50));

CREATE TABLE LOJA (
  codloja SMALLINT PRIMARY KEY,
  nome VARCHAR(50),
  endereco VARCHAR(100),
  cidade VARCHAR(20),
  cgccliente VARCHAR(20));

CREATE TABLE FATURA (
  numfatura INT PRIMARY KEY,
  datavenc DATE,
  datapg DATE,
  codcliente SMALLINT,
  valortotal NUMERIC(9,2),
  CONSTRAINT faturafk FOREIGN KEY (codcliente) REFERENCES CLIENTE);

CREATE TABLE NOTAFISCAL (    
  numnfiscal SMALLINT PRIMARY KEY,
  data DATE,
  codcliente SMALLINT,
  codloja SMALLINT,
  numfatura INT,
  valortotal NUMERIC(9,2),
  CONSTRAINT faturafk1 FOREIGN KEY (codcliente) REFERENCES CLIENTE,
  CONSTRAINT faturafk2 FOREIGN KEY (codloja) REFERENCES LOJA,
  CONSTRAINT faturafk3 FOREIGN KEY (numfatura) REFERENCES FATURA);

CREATE TABLE PRODUTO (    
  codproduto INT PRIMARY KEY,
  descricao VARCHAR(100),
  valorvenda NUMERIC(9,2),
  valorcompra NUMERIC(9,2),
  unidade VARCHAR(10),
  qtdestoque SMALLINT);

CREATE TABLE ITEMNOTAFISCAL (
  numnfiscal SMALLINT,
  codproduto INT,
  quantidade SMALLINT,
  valorunidcusto NUMERIC(9,2),
  valorunidvenda NUMERIC (9,2),
  CONSTRAINT faturaPK PRIMARY KEY (numnfiscal,codproduto),
  CONSTRAINT inffk1 FOREIGN KEY (numnfiscal) REFERENCES NOTAFISCAL,
  CONSTRAINT inffk2 FOREIGN KEY (codproduto) REFERENCES PRODUTO);

  INSERT INTO CLIENTE VALUES (111,'Computec Ltda', 'Av.São Carlos, 186', 'São Carlos - SP', '(017) 276-9999', '123.689.157/0001-89', 'José da Silva'),
(112, 'MicroMédia SA', 'R.José Bonifácio, 70', 'São Carlos - SP', '(017) 273-8974', '154.586.524/0001-55', 'João da Silva'),
(113, 'TecnoCom Ltda', 'R.Luiz Camões, 120', 'Ibaté - SP', '(017) 278-8568', '875.684.458/0001-99', 'Antonio Benedito'),
(114, 'C&P', 'Av. São Carlos, 176', 'São Carlos - SP', '(017) 274-9874', '352.476.777/0001-43', 'Lucas Jorge'),
(115, 'ProvTecno', 'R.Raul Junior, 180', 'São Carlos - SP', '(017) 273-9865', '278.852.468/0001-58', 'Carlos Antonio');

INSERT INTO LOJA  VALUES (1, 'Papelândia 1', 'Av.São Carlos, 870', 'São Carlos - SP', '232.456.666/0001-89'),
(2, 'Papelândia 2', 'R. XV Novembro, 121', 'São Carlos - SP', '232.456.666/0002-34'),
(3, 'Papelândia 3', 'R. 7 Setembro, 1823', 'São Carlos - SP', '232.456.666/0003-92'),
(4, 'Papelândia 4', 'Av. Independência, 567', 'São Carlos - SP', '232.456.666/0004-22'),
(5, 'Papelândia 5', 'R. Tiradentes 432', 'São Carlos - SP', '232.456.666/0005-19');


INSERT INTO FATURA (numfatura, datavenc, codcliente, valortotal) VALUES 
(045675, '10/04/1999', 111, 101.50),
(045690,'10/05/1999', 111, 108.90),
(045691, '10/05/1999', 112, 120.50),
(045692, '10/05/1999', 113, 14.90),
(045693, '10/05/1999', 115, 31.50);

INSERT INTO NOTAFISCAL VALUES 
(2142, '01/04/1999', 111, 1, 045675, 17.50),
(2143, '10/04/1999', 111, 2, 045675, 84.00),
(2144, '17/05/1999', 111, 1, 045675, 13.00),
(2145, '05/05/1999', 111, 1, 045690, 36.00),
(2146, '22/05/1999', 111, 2, 045690, 59.90),
(2147, '18/05/1999', 112, 2, 045691, 66.00),
(2148, '27/05/1999', 112, 5, 045691, 54.50),
(2149, '01/05/1999', 113, 4, 045692, 14.10),
(2150, '30/05/1999', 113, 4, 045692, 0.80),
(2151, '26/05/1999', 115, 5, 045693, 31.50);

INSERT INTO PRODUTO VALUES 
(86477, 'Resma papel sufite', 8.00, 4.55, 'pacote', 571),
(86478, 'Clips nº 5', 3.00, 1.76, 'caixa', 424),
(86479, 'Clips nº 10', 5.00, 2.52, 'caixa', 454),
(86480, 'Grampo para Grampeador', 4.00, 1.43, 'caixa', 357),
(86481, 'Grampeador', 18.00, 10.50, 'unidade', 54),
(86482, 'Lapis preto nº 5', 0.20, 0.05, 'unidade', 86),
(86483, 'Caderno 10 matérias 150 fls', 5.50, 2.30, 'unidade', 98),
(86484, 'Caderno 12 matérias 150 fls', 7.00, 3.81, 'unidade', 75),
(86485, 'Caneta azul bic', 0.50, 0.20, 'unidade', 86),
(86486, 'Caneta vermelha bic', 0.50, 0.20, 'unidade', 67);

INSERT INTO ITEMNOTAFISCAL VALUES
(2142, 86477, 2, 4.55, 8.00),
(2142, 86486, 3, 0.20, 0.50),
(2143, 86479, 12, 2.52, 5.00),
(2143, 86480, 6, 1.43, 4.00),
(2144, 86484, 1, 3.81, 7.00),
(2144, 86478, 2, 1.76, 3.00),
(2145, 86480, 9, 1.43, 4.00),
(2146, 86483, 1, 2.30, 5.50),
(2146, 86481, 3, 10.50, 18.00),
(2146, 86482, 2, 0.05, 0.20),
(2147, 86485, 4, 0.20, 0.50),
(2147, 86477, 8, 4.55, 8.00),
(2148, 86483, 9, 2.30, 5.50),
(2148, 86479, 1, 2.52, 5.00),
(2149, 86480, 2, 1.43, 4.00),
(2149, 86482, 3, 0.05, 0.20),
(2149, 86483, 1, 2.30, 5.50),
(2150, 86482, 4, 0.05, 0.20),
(2151, 86480, 7, 1.43, 4.00),
(2151, 86486, 7, 0.20, 0.50);

select * from ITEMNOTAFISCAL;
/*
2142;86477;2;4.55;8.00
2142;86486;3;0.20;0.50
2143;86479;12;2.52;5.00
2143;86480;6;1.43;4.00
2144;86484;1;3.81;7.00
2144;86478;2;1.76;3.00
2145;86480;9;1.43;4.00
2146;86483;1;2.30;5.50
2146;86481;3;10.50;18.00
2146;86482;2;0.05;0.20
2147;86485;4;0.20;0.50
2147;86477;8;4.55;8.00
2148;86483;9;2.30;5.50
2148;86479;1;2.52;5.00
2149;86480;2;1.43;4.00
2149;86482;3;0.05;0.20
2149;86483;1;2.30;5.50
2150;86482;4;0.05;0.20
2151;86480;7;1.43;4.00
2151;86486;7;0.20;0.50
*/

select cl.nome
from cliente cl
/*
"Computec Ltda"
"MicroMédia SA"
"TecnoCom Ltda"
"C&P"
"ProvTecno"
*/

/* === Exercícios de Visões === */

/*
As faturas, indicadas por seu numfatura, com as suas respectivas notas fiscais, 
também indicadas por seu numnfiscal além de valor total das notas fiscais. 
Fazer uma consulta na visão que contenha um agrupamento;
*/

drop view Fatura_NF
create view Fatura_NF as 
select f.numfatura, nf.numnfiscal, SUM(nf.valortotal) as VLT
from FATURA f, NOTAFISCAL nf
where f.numfatura = nf.numfatura
group by f.numfatura, nf.numnfiscal;

select numfatura, SUM(VLT) valorTotal_NF
from Fatura_NF
group by numfatura;

/*
Criar uma visão materializada com a opção WITH NO DATA para recuperar os nomes
dos clientes juntamente com o número de lojas que eles efetuaram compras. 
Mostrar uma consulta à visão; 
*/

drop materialized view recupera_dados
create materialized view recupera_dados AS
select cl.nome, lj.codloja
from notafiscal nf
inner join cliente cl on cl.codcliente = nf.codcliente
inner join loja lj on lj.codloja = nf.codloja
group by cl.nome, lj.codloja
with no data;

REFRESH MATERIALIZED VIEW recupera_dados;

SELECT * FROM recupera_dados;
/*
"Computec Ltda";1
"ProvTecno";5
"MicroMédia SA";5
"TecnoCom Ltda";4
"Computec Ltda";2
"MicroMédia SA";2
*/

/*
Criar uma visão para recuperar os nomes dos clientes juntamente com os nomes
das lojas  que  eles  efetuaram  compras.  Mostrar uma  consulta à  visão 
que  contenha  um agrupamento;
*/

SELECT nome
FROM recupera_dados
GROUP BY nome
HAVING COUNT(codloja) > 1;

/*
"MicroMédia SA"
"Computec Ltda"
*/

/*
Criar  a  visão  'produtosmaisvendidos'  contendo  a  descrição  dos  três
produtos  mais vendidos. Mostrar uma consulta à visão;
*/

create view produtos_mais_vendidos as
select p.descricao, itnf.quantidade
from produto p
inner join itemnotafiscal itnf on itnf.codProduto = p.codProduto
group by p.descricao, itnf.quantidade
order by itnf.quantidade Desc
limit 3

select * FROM produtos_mais_vendidos

/*
"Clips nº 10";12
"Grampo para Grampeador";9
"Caderno 10 matérias 150 fls";9
*/

/*
Criar a visão 'notafiscaldetalhada' contendo para cada nota fiscal seu número, 
data, código do cliente, código da loja, valor total e a descrição dos produtos
contidos nela. Mostrar uma consulta à visão;
*/

drop view nota_fiscal_detalhada
create view nota_fiscal_detalhada as
select nf.numnfiscal, nf.data, nf.codcliente, nf.codloja, nf.valortotal, p.descricao
from produto p, notafiscal nf, itemnotafiscal inf, loja lj, cliente cl
where nf.codloja = lj.codloja 
and nf.codcliente = cl.codcliente
and inf.numnfiscal = nf.numnfiscal
and inf.codproduto = p.codproduto

select * from nota_fiscal_detalhada
/*
2142;"1999-04-01";111;1;17.50;"Resma papel sufite"
2142;"1999-04-01";111;1;17.50;"Caneta vermelha bic"
2143;"1999-04-10";111;2;84.00;"Clips nº 10"
2143;"1999-04-10";111;2;84.00;"Grampo para Grampeador"
2144;"1999-05-17";111;1;13.00;"Caderno 12 matérias 150 fls"
2144;"1999-05-17";111;1;13.00;"Clips nº 5"
2145;"1999-05-05";111;1;36.00;"Grampo para Grampeador"
2146;"1999-05-22";111;2;59.90;"Caderno 10 matérias 150 fls"
2146;"1999-05-22";111;2;59.90;"Grampeador"
2146;"1999-05-22";111;2;59.90;"Lapis preto nº 5"
2147;"1999-05-18";112;2;66.00;"Caneta azul bic"
2147;"1999-05-18";112;2;66.00;"Resma papel sufite"
2148;"1999-05-27";112;5;54.50;"Caderno 10 matérias 150 fls"
2148;"1999-05-27";112;5;54.50;"Clips nº 10"
2149;"1999-05-01";113;4;14.10;"Grampo para Grampeador"
2149;"1999-05-01";113;4;14.10;"Lapis preto nº 5"
2149;"1999-05-01";113;4;14.10;"Caderno 10 matérias 150 fls"
2150;"1999-05-30";113;4;0.80;"Lapis preto nº 5"
2151;"1999-05-26";115;5;31.50;"Grampo para Grampeador"
2151;"1999-05-26";115;5;31.50;"Caneta vermelha bic"
*/

/*
Escolha quantas tabelas achar necessário e realize inserções para exemplificar
a diferença na execução de consultas empregando LEFT OUTER JOIN, RIGHT OUTER 
JOIN e FULL OUTER JOIN. Devem ser apresentados na resolução as inserções, 
as consultas e os resultados das consultas.
*/

insert into cliente values (232, 'Jhully Computer', 'Av. Jose Alfa Brito, 431', 'Pirapora - MG', '(38)9934-5678', '123.764.320/0001-73', 'Joana Alves')
insert into produto values (76831, 'Mochila de Rodinha', 130.00, 65.00, 'Unidade', 100)

select cl.nome, ft.numfatura
from cliente cl
left outer join fatura ft on ft.codcliente = cl.codcliente
/*
"Computec Ltda";	45675
"Computec Ltda";	45690
"MicroMédia SA";	45691
"TecnoCom Ltda";	45692
"ProvTecno";		45693
"Jhully Computer";
"C&P";

*/

select cl.nome, ft.numfatura
from cliente cl
right outer join fatura ft on ft.codcliente = cl.codcliente
/*
"Computec Ltda";45675
"Computec Ltda";45690
"MicroMédia SA";45691
"TecnoCom Ltda";45692
"ProvTecno";45693
*/

select cl.nome, ft.numfatura
from cliente cl
full outer join fatura ft on cl.codcliente = ft.codcliente

/*
"Computec Ltda";45675
"Computec Ltda";45690
"MicroMédia SA";45691
"TecnoCom Ltda";45692
"ProvTecno";45693
"Jhully Computer";
"C&P";
*/

select p.descricao, p.unidade
from produto p 
left outer join itemnotafiscal inf on inf.codproduto = p.codproduto
/*
"Resma papel sufite";"pacote"
"Caneta vermelha bic";"unidade"
"Clips nº 10";"caixa"
"Grampo para Grampeador";"caixa"
"Caderno 12 matérias 150 fls";"unidade"
"Clips nº 5";"caixa"
"Grampo para Grampeador";"caixa"
"Caderno 10 matérias 150 fls";"unidade"
"Grampeador";"unidade"
"Lapis preto nº 5";"unidade"
"Caneta azul bic";"unidade"
"Resma papel sufite";"pacote"
"Caderno 10 matérias 150 fls";"unidade"
"Clips nº 10";"caixa"
"Grampo para Grampeador";"caixa"
"Lapis preto nº 5";"unidade"
"Caderno 10 matérias 150 fls";"unidade"
"Lapis preto nº 5";"unidade"
"Grampo para Grampeador";"caixa"
"Caneta vermelha bic";"unidade"
"Mochila de Rodinha";"Unidade"
*/

select p.descricao, p.unidade
from produto p 
right outer join itemnotafiscal inf on inf.codproduto = p.codproduto
/*
"Resma papel sufite";"pacote"
"Caneta vermelha bic";"unidade"
"Clips nº 10";"caixa"
"Grampo para Grampeador";"caixa"
"Caderno 12 matérias 150 fls";"unidade"
"Clips nº 5";"caixa"
"Grampo para Grampeador";"caixa"
"Caderno 10 matérias 150 fls";"unidade"
"Grampeador";"unidade"
"Lapis preto nº 5";"unidade"
"Caneta azul bic";"unidade"
"Resma papel sufite";"pacote"
"Caderno 10 matérias 150 fls";"unidade"
"Clips nº 10";"caixa"
"Grampo para Grampeador";"caixa"
"Lapis preto nº 5";"unidade"
"Caderno 10 matérias 150 fls";"unidade"
"Lapis preto nº 5";"unidade"
"Grampo para Grampeador";"caixa"
"Caneta vermelha bic";"unidade"
*/

select p.descricao, p.unidade, inf.numnfiscal
from produto p 
full outer join itemnotafiscal inf on inf.codproduto = p.codproduto
/*
"Resma papel sufite";"pacote";2142
"Caneta vermelha bic";"unidade";2142
"Clips nº 10";"caixa";2143
"Grampo para Grampeador";"caixa";2143
"Caderno 12 matérias 150 fls";"unidade";2144
"Clips nº 5";"caixa";2144
"Grampo para Grampeador";"caixa";2145
"Caderno 10 matérias 150 fls";"unidade";2146
"Grampeador";"unidade";2146
"Lapis preto nº 5";"unidade";2146
"Caneta azul bic";"unidade";2147
"Resma papel sufite";"pacote";2147
"Caderno 10 matérias 150 fls";"unidade";2148
"Clips nº 10";"caixa";2148
"Grampo para Grampeador";"caixa";2149
"Lapis preto nº 5";"unidade";2149
"Caderno 10 matérias 150 fls";"unidade";2149
"Lapis preto nº 5";"unidade";2150
"Grampo para Grampeador";"caixa";2151
"Caneta vermelha bic";"unidade";2151
"Mochila de Rodinha";"Unidade";
*/