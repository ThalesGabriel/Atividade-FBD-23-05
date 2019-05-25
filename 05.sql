CREATE DATABASE ESTUDOS;

USE ESTUDOS;

CREATE TABLE Cliente(
	CodCli INTEGER PRIMARY KEY,
    nome VARCHAR(20),
    idade Integer
);

CREATE TABLE Produto(
	CodProd INTEGER PRIMARY KEY,
    descricao VARCHAR(60)
);

CREATE TABLE Pedido(
	CodCli INTEGER,
    NumPedido INTEGER PRIMARY KEY,
    Dta DATE,
    
    FOREIGN KEY (CodCli)
      REFERENCES Cliente(CodCli)
);

CREATE TABLE Cliente(
	CodCli INTEGER PRIMARY KEY,
    nome VARCHAR(20),
    idade Integer
);

CREATE TABLE Produto(
	CodProd INTEGER PRIMARY KEY,
    descricao VARCHAR(60)
);

CREATE TABLE ItemPedido(
	numPedido INTEGER,
    numItem INTEGER,
    CodProd INTEGER,
    quant INTEGER NOT NULL,
    precoUnit DOUBLE,
    CONSTRAINT ItemPedido_pk PRIMARY KEY(numPedido, numItem),
    CONSTRAINT ItemPedido_numPedido_fk FOREIGN KEY(numPedido) REFERENCES Pedido(numPedido) ON DELETE CASCADE,
    CONSTRAINT ItemPedido_CodProd_fk FOREIGN KEY (CodProd) REFERENCES Produto(codProd) ON UPDATE CASCADE
);

use ESTUDOS;
/*POPULANDO BANCO*/

INSERT INTO Cliente (CodCli, nome, idade) VALUES (3,"Ricardo",21);
INSERT INTO Cliente (CodCli, nome, idade) VALUES (4,"Henrique",33);
INSERT INTO Cliente (CodCli, nome, idade) VALUES (5,"Beatriz",25);
INSERT INTO Cliente (CodCli, nome, idade) VALUES (6,"Maria",37);

INSERT INTO Produto (CodProd, descricao) VALUES (1,"Notebook");
INSERT INTO Produto (CodProd, descricao) VALUES (2,"Smartphone");
INSERT INTO Produto (CodProd, descricao) VALUES (3,"TV Smart 4k (Novidade)");
INSERT INTO Produto (CodProd, descricao) VALUES (4,"Aparelho de Som");
INSERT INTO Produto (CodProd, descricao) VALUES (5,"Mesa Digital (Novidade)");
INSERT INTO Produto (CodProd, descricao) VALUES (6,"Playstation 4");
INSERT INTO Produto (CodProd, descricao) VALUES (7,"XBOX One");


/*INSERINDO PEDIDOS E ITENS PEDIDOS*/

INSERT INTO Pedido (CodCli, numPedido, Dta) VALUES (2,3,"2017-07-07");
INSERT INTO ItemPedido (numPedido, numItem, CodProd, quant, precoUnit) VALUES (3,1,5,1,990.00);
INSERT INTO ItemPedido (numPedido, numItem, CodProd, quant, precoUnit) VALUES (3,2,1,1,2500.00);
INSERT INTO ItemPedido (numPedido, numItem, CodProd, quant, precoUnit) VALUES (3,3,7,11,1799.00);

INSERT INTO Pedido (CodCli, numPedido, Dta) VALUES (1,1,"2018-05-03");
INSERT INTO ItemPedido (numPedido, numItem, CodProd, quant, precoUnit) VALUES (1,1,1,1,2500.00);
INSERT INTO ItemPedido (numPedido, numItem, CodProd, quant, precoUnit) VALUES (1,2,2,1,1800.00);

INSERT INTO Pedido (CodCli, numPedido, Dta) VALUES (6,2,"2016-05-17");
INSERT INTO ItemPedido (numPedido, numItem, CodProd, quant, precoUnit) VALUES (2,1,3,2,2999.00);

INSERT INTO Pedido (CodCli, numPedido, Dta) VALUES (5,5,"2016-05-17");
INSERT INTO ItemPedido (numPedido, numItem, CodProd, quant, precoUnit) VALUES (5,1,3,15,2999.00);
INSERT INTO ItemPedido (numPedido, numItem, CodProd, quant, precoUnit) VALUES (5,2,6,15,1899.00);

INSERT INTO Pedido (CodCli, numPedido, Dta) VALUES (4,4,"2008-05-17");
INSERT INTO ItemPedido (numPedido, numItem, CodProd, quant, precoUnit) VALUES (4,1,4,1,799.00);

/**/

/* Comandos para testar restrições de integridade de A) */

DELETE FROM Pedido WHERE numPedido = 1; /*Deleta registros de itens pedidos do Pedido de código 1*/
UPDATE Produto SET CodProd=10 WHERE CodProd = 4; /*Atualiza registros de itens pedidos do produto 4 para 10*/
/*DELETE FROM Produto WHERE codProduto = 6;*/ /*Não permite a exclusão do produto de codigo 6 porque há pedidos*/ 


/*

b) Escreva comandos SQL para incluir um novo pedido no banco de dados, com os seguintes
dados: Pedido número 123, do cliente 02 (assuma que o cliente já está cadastrado). Os itens do
pedido são: 2 unidades do produto de código 02, custando 1,00 cada unidade; 3 unidades do
produto de código 03, custando 2,30 cada unidade.

*/

INSERT INTO Pedido (CodCli, numPedido, Dta) VALUES (2,123,"2016-08-27");
INSERT INTO ItemPedido (numPedido, numItem, CodProd, quant, precoUnit) VALUES (123,1,2,2,1.00);
INSERT INTO ItemPedido (numPedido, numItem, CodProd, quant, precoUnit) VALUES (123,2,3,3,2.30);


/*

c) Faça uma consulta que seleciona os nomes dos clientes com mais de 30 anos que fizeram
algum pedido entre 01/01/2010 e 01/01/2018.

*/

SELECT nome 
FROM Cliente, Pedido
WHERE idade > 30 AND Dta BETWEEN "2010-01-01" AND "2018-01-01" AND Cliente.CodCli = Pedido.CodCli; 

/*

d) Faça uma consulta que retorna o nome do cliente e a descrição de produtos que o cliente
pediu em quantidade superior a 10 unidades.
 
*/


SELECT nome, descricao
FROM Cliente, Pedido, ItemPedido, Produto
WHERE quant > 10 AND ItemPedido.CodProd = Produto.CodProd 
AND ItemPedido.numPedido = Pedido.numPedido AND Pedido.CodCli = Cliente.CodCli;

/*

e) Faça uma consulta que mostre o número do pedido, o código do produto e a quantidade
solicitada de produtos cuja descrição contenha a palavra “novidade”.

*/

SELECT Pedido.numPedido, Produto.CodProd, ItemPedido.quant
FROM ItemPedido, Produto, Pedido 
WHERE descricao LIKE "%novidade%" AND Produto.CodProd = ItemPedido.CodProd AND itemPedido.numPedido = Pedido.numPedido;