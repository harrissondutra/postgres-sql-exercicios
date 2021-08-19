CREATE TABLE tb_cliente(
	cd_cliente number(10),
	nome varchar2(100),
	sobrenome varchar2(100),
	email varchar2(100),
	CONSTRAINT pk_cd_cliente PRIMARY KEY (cd_cliente)
);

CREATE TABLE tb_produto(
	cd_produto number(10),
	nome_produto varchar2(100),
	valor_produto number(10,4),
	CONSTRAINT pk_cd_produto PRIMARY KEY (cd_produto)
);

CREATE TABLE tb_venda(
	cd_venda number(10),
	cd_cliente number(10),
	data_venda DATE,
	CONSTRAINT pk_cd_venda PRIMARY KEY (cd_venda),
	
	CONSTRAINT fk_cod_cliente FOREIGN KEY (cd_cliente)
		REFERENCES tb_cliente (cd_cliente)
);

CREATE TABLE tb_item_venda(
	cd_item_venda number(10),
	cd_cliente_venda number(10),
	cd_item_produto number(10),
	qtd_item number(10),
	valor_item number(10,4),
	CONSTRAINT PK_item_venda PRIMARY KEY (cd_item_venda),
	
	CONSTRAINT FK_ITEM_CLIENTE_VENDA FOREIGN KEY (CD_CLIENTE_VENDA)
	REFERENCES TB_CLIENTE(CD_CLIENTE),
		
	CONSTRAINT FK_ITEM_PRODUTO_VENDA FOREIGN KEY(CD_ITEM_PRODUTO)
	REFERENCES TB_PRODUTO(CD_PRODUTO)
);

INSERT INTO TB_CLIENTE (CD_CLIENTE, nome, SOBRENOME, email) VALUES (1, 'Harrisson', 'Dutra', 'harrissondutra@gmail.com');
INSERT INTO TB_CLIENTE c (CD_CLIENTE, nome, SOBRENOME, email) VALUES (2, 'Pedro', 'Miguel', 'pedro@gmail.com');
INSERT INTO TB_CLIENTE c (CD_CLIENTE, nome, SOBRENOME, email) VALUES (3, 'João', 'Alberto', 'joao@hotmail.com');

INSERT INTO TB_PRODUTO p (p.CD_PRODUTO, p.nome_produto, p.valor_produto) VALUES (1, 'Máquina de lavar', 1200);
INSERT INTO TB_PRODUTO p (p.CD_PRODUTO, p.NOME_PRODUTO, p.valor_produto) VALUES (2, 'Geladeira', 1400);
INSERT INTO TB_PRODUTO p (p.CD_PRODUTO, p.NOME_PRODUTO, p.valor_produto) VALUES (3, 'Televisão', 800);

INSERT INTO TB_VENDA v (cd_venda, cd_cliente, data_venda ) VALUES (1, 1, '23-05-2021');
INSERT INTO TB_VENDA v (cd_venda, cd_cliente, data_venda ) VALUES (2, 1, '11-04-2021');
INSERT INTO TB_VENDA v (cd_venda, cd_cliente, data_venda ) VALUES (3, 2, '12-05-2021');
INSERT INTO TB_VENDA v (cd_venda, cd_cliente, data_venda ) VALUES (4, 3, '11-06-2021');

INSERT INTO TB_ITEM_VENDA (cd_item_venda, cd_cliente_venda, cd_item_produto, qtd_item, valor_item) VALUES (1, 1, 1, 1, 1200);
INSERT INTO TB_ITEM_VENDA (cd_item_venda, cd_cliente_venda, cd_item_produto, qtd_item, valor_item) VALUES (2, 1, 1, 1, 1200);
INSERT INTO TB_ITEM_VENDA (cd_item_venda, cd_cliente_venda, cd_item_produto, qtd_item, valor_item) VALUES (3, 1, 1, 1, 1200);
INSERT INTO TB_ITEM_VENDA (cd_item_venda, cd_cliente_venda, cd_item_produto, qtd_item, valor_item) VALUES (4, 2, 2, 1, 1400);
