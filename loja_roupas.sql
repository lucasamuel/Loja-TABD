---ENTREGA III - 25/03/2021
---ALUNO: Lucas Samuel Araújo Silva

SET SCHEMA 'loja_roupas';

---TABLES

CREATE TABLE caixa (
    id_caixa INT PRIMARY KEY,
    saldo NUMERIC (7,2)
);

CREATE TABLE funcionario (
    id_funcionario INT PRIMARY KEY,
    id_caixa INT,
    nome_funcionario VARCHAR (40),
    cpf_funcionario VARCHAR (14),
    rg_funcionario VARCHAR (13),
    FOREIGN KEY (id_caixa) REFERENCES caixa(id_caixa)
);

CREATE TABLE forma_pagamento (
    id_forma_pagamento INT PRIMARY KEY,
    descricao_fpagamento VARCHAR (40)
);

CREATE TABLE fornecedor (
    id_fornecedor INT PRIMARY KEY,
    razao_social VARCHAR (40),
    cnpj VARCHAR (20)
);

CREATE TABLE compra (
    id_compra INT PRIMARY KEY,
    id_funcionario INT,
    id_fornecedor INT,
    nota_cfiscal VARCHAR (30),
    valor_ctotal NUMERIC (10,2),
    data_compra DATE,
    hora_venda TIME, 
    FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario),
    FOREIGN KEY (id_fornecedor) REFERENCES fornecedor(id_fornecedor)
);

CREATE TABLE produto (
    id_produto INT PRIMARY KEY,
    tamanho VARCHAR (3),
    cor VARCHAR (10),
    valor_produto NUMERIC (5,2),
    preco_medio NUMERIC (7,2),
    quantidade_produto INT,
    tipo_produto VARCHAR (20),
    marca VARCHAR (30)
);

CREATE TABLE item_compra (
    id_item_compra INT PRIMARY KEY,
    preco_icunitario NUMERIC (10,2),
    quantidade_icompra INT,
    imposto NUMERIC (10,2),
    frete NUMERIC (7,2),
	id_produto INT,
    id_compra INT,
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto),
    FOREIGN KEY (id_compra) REFERENCES compra(id_compra)
);

CREATE TABLE cliente (
    id_cliente INT PRIMARY KEY,
    nome VARCHAR (40),
    cpf_cliente VARCHAR (14)
);

CREATE TABLE venda (
    id_venda INT PRIMARY KEY,
    id_caixa INT,
    id_cliente INT,
    valor_vtotal NUMERIC (10,2),
    valor_vpago NUMERIC (10,2),
    valor_vtroco NUMERIC (10,2),
    desconto_venda NUMERIC (10,2),
    nota_vfiscal VARCHAR (30),
    data_venda DATE,
    hora_venda TIME, 
    FOREIGN KEY (id_caixa) REFERENCES caixa(id_caixa),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE item_venda (
    id_item_venda INT PRIMARY KEY,
    id_produto INT,
    id_venda INT,
    quantidade_ivenda INT,
    preco_ivunitario NUMERIC (10,2),
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto),
    FOREIGN KEY (id_venda) REFERENCES venda(id_venda)
);

CREATE TABLE endereco (
    id_endereco INT PRIMARY KEY,
    id_funcionario INT,
    id_fornecedor INT,
    descricao_endereco VARCHAR (50),
    FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario),
    FOREIGN KEY (id_fornecedor) REFERENCES fornecedor(id_fornecedor)
);

CREATE TABLE telefone (
    id_telefone INT PRIMARY KEY,
    id_cliente INT,
    id_funcionario INT,
    id_fornecedor INT,
    numero VARCHAR (15),
    descricao_telefone VARCHAR (40),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario),
    FOREIGN KEY (id_fornecedor) REFERENCES fornecedor(id_fornecedor)
);

CREATE TABLE item_devolucao (
 	id_devolucao INT PRIMARY KEY,
	descricao_devolucao VARCHAR(100),
 	quantidade_idevolucao INT,
	id_compra INT,
    id_venda INT,
 	FOREIGN KEY (id_compra) REFERENCES compra (id_compra),
    FOREIGN KEY (id_venda) REFERENCES venda (id_venda)
);


--INSERTS


INSERT INTO caixa (id_caixa, saldo)
VALUES (1, 500);

INSERT INTO funcionario (id_funcionario, id_caixa, nome_funcionario, cpf_funcionario, rg_funcionario)
VALUES (1, 1, 'Natasha Dias', '111.111.111-11', '22.222.121-11'),
       (2, 1, 'Roberto Mendes', '222.112.121-22', '11.122.221-31');

INSERT INTO forma_pagamento (id_forma_pagamento, descricao_fpagamento)
VALUES (1, 'Crédito'),
       (2, 'Dédito'),
       (3, 'Dinheiro');

INSERT INTO fornecedor (id_fornecedor, razao_social, cnpj)
VALUES (1, 'Simonitti LTDA.', '11. 222. 121/1111-22'),
       (2, 'Aroldo S.A.', '22. 111. 131/1311-12'),
       (3, 'La Belle de Jour', '11. 222. 121/1111-22');

INSERT INTO compra (id_compra, id_funcionario, id_fornecedor, nota_cfiscal, valor_ctotal, data_compra, hora_venda)
VALUES (1, 1, 1, '999999', 1000, '2021/02/12', '09:00:00'),
       (2, 1, 2, '111111', 800, '2021/02/13', '08:30:00'),
       (3, 2, 3, '222222', 750, '2021/02/17', '16:15:00'),
       (4, 2, 1, '111311', 400, '2021/03/04', '09:30:00'),
       (5, 2, 2, '111141', 600, '2021/03/04', '15:30:00'),
       (6, 1, 3, '121111', 700, '2021/03/05', '10:30:00');

INSERT INTO produto
VALUES (1, 'P', 'Cinza', 40, 70, 30, 'Camiseta', 'Air Force'),
       (2, 'M', 'Vermelho', 45, 80, 35, 'Camiseta', 'Air Force'),
       (3, 'G', 'Preto', 40, 70, 30, 'Camisa', 'Air Force'),
       (4, 'GG', 'Laranja', 35, 60, 30, 'Camiseta', 'Mediterrâneo'),
       (5, 'G', 'Laranja', 30, 55, 40, 'Camiseta', 'Mediterrâneo'),
       (6, 'M', 'Vermelho', 45, 70, 250, 'Camiseta', 'Mediterrâneo');

INSERT INTO item_compra
VALUES (1, 40, 20, 100, 100, 1, 1),
       (2, 45, 25, 25, 0, 2, 1),
       (3, 35, 20, 50, 50, 3, 1),
       (4, 50, 35, 60, 40, 3, 2),
       (5, 30, 35, 40, 30, 4, 2),
       (6, 25, 45, 50, 40, 4, 3),
       (7, 55, 33, 35, 0, 5, 4),
       (8, 30, 15, 25, 30, 5, 4);

INSERT INTO cliente
VALUES (1, 'Uélio Lopes', '111.111.222-22'),
       (2, 'Rodrigo Sodak', '222.111.333-12'),
       (3, 'Jéssica Lula da Silva', '222.111.444-11');

INSERT INTO venda (id_venda, id_caixa, id_cliente, valor_vtotal, valor_vpago, valor_vtroco, desconto_venda, nota_vfiscal, data_venda, hora_venda)
VALUES (1, 1, 1, 80, 80, 0, 0, '123212', '2021/02/28', '09:00:00'),
       (2, 1, 2, 140, 140, 0, 0, '123312', '2021/03/11', '10:30:00'),
       (3, 1, 3, 110, 110, 0, 0, '123222', '2021/03/11', '13:00:00'),
       (4, 1, 3, 110, 110, 0, 0, '123222', '2021/03/11', '13:00:00'),
       (5, 1, 3, 110, 110, 0, 0, '123222', '2021/03/11', '13:00:00');


INSERT INTO item_venda
VALUES (1, 2, 1, 1, 80),
       (2, 1, 2, 2, 70),
       (3, 4, 3, 1, 70),
       (4, 3, 3, 1, 60),
       (5, 4, 4, 1, 70),
       (6, 5, 5, 2, 110),
       (7, 4, 4, 1, 70),
       (8, 4, 3, 1, 70),
       (9, 4, 3, 1, 70);

INSERT INTO endereco (id_endereco, id_funcionario, id_fornecedor, descricao_endereco)
VALUES (1, 1, NULL, 'Rua 5, 55, Setor J'),
       (2, NULL, 1, 'Rua A, 41, Setor Azul');

INSERT INTO telefone
VALUES (1, 1, NULL, NULL, '77 99999-9999', 'Celular'),
       (2, NULL, 1, NULL, '77 99999-8888', 'Celular'),
       (3, NULL, NULL, 1, '77 99999-8877', 'Telefone');

INSERT INTO item_devolucao
VALUES (1, 'Produto muito grande', 1, NULL, 1);

---FUNCTIONS

---PRODUTO

CREATE FUNCTION insert_produto() RETURNS TRIGGER AS $$
BEGIN
UPDATE produto SET quantidade_produto = quantidade_produto + NEW.quantidade_produto WHERE id_produto = NEW.id_produto;
RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_insertproduto
AFTER INSERT ON produto
FOR EACH ROW
EXECUTE PROCEDURE insert_produto();

CREATE FUNCTION update_produto() RETURNS TRIGGER AS $$
BEGIN
UPDATE produto SET quantidade_produto = quantidade_produto - OLD.quantidade_produto WHERE id_produto = OLD.id_produto;
RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_updateproduto
AFTER DELETE ON produto
FOR EACH ROW
EXECUTE PROCEDURE update_produto();

CREATE FUNCTION delete_produto() RETURNS TRIGGER AS $$
BEGIN
UPDATE produto SET quantidade_produto = quantidade_produto + OLD.quantidade_produto WHERE id_produto = OLD.id_produto;
update compra SET valor_ctotal = OLD.preco_ivunitario * OLD.quatidade_produto WHERE id_compra = OLD.id_compra;
RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_deleteproduto
AFTER DELETE ON produto
FOR EACH ROW
EXECUTE PROCEDURE delete_produto();

---COMPRA

CREATE FUNCTION insert_compraproduto() RETURNS TRIGGER AS $$
BEGIN
UPDATE produto SET quantidade_produto = quantidade_produto - NEW.quantidade_produto WHERE id_produto = NEW.id_produto;
UPDATE venda SET valor_ctotal = NEW.quantidade_icompra * NEW.preco_icunitario WHERE id_compra = NEW.id_compra;
RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_insert_compraproduto
AFTER INSERT ON item_compra
FOR EACH ROW
EXECUTE PROCEDURE insert_compraproduto();

CREATE FUNCTION update_compraproduto() RETURNS TRIGGER AS $$
BEGIN
UPDATE produto SET quantidade_produto = quantidade_produto + OLD.quantidade_produto WHERE id_produto = OLD.id_produto;
RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_update_compraproduto
AFTER UPDATE ON item_compra
FOR EACH ROW
EXECUTE PROCEDURE update_compraproduto();


CREATE FUNCTION delete_compraproduto() RETURNS TRIGGER AS $$
BEGIN
UPDATE produto SET quantidade_produto = quantidade_produto + OLD.quantidade_produto WHERE id_produto = OLD.id_produto;
update venda SET valor_vtotal = OLD.preco_icunitario * OLD.quatidade_produto WHERE id_compra = OLD.id_compra;
RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_delete_compraproduto
AFTER DELETE ON item_compra
FOR EACH ROW
EXECUTE PROCEDURE delete_compraproduto();


---VENDA



CREATE FUNCTION insert_vendaproduto() RETURNS TRIGGER AS $$
BEGIN
UPDATE produto SET quantidade_produto = quantidade_produto - NEW.quantidade_produto WHERE id_produto = NEW.id_produto;
UPDATE venda SET valor_vtotal = NEW.quantidade_ivenda * NEW.preco_venda WHERE id_venda = NEW.id_venda;
RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_insert_vendaproduto
AFTER INSERT ON item_venda
FOR EACH ROW
EXECUTE PROCEDURE insert_vendaproduto();

CREATE FUNCTION update_vendaproduto() RETURNS TRIGGER AS $$
BEGIN
UPDATE produto SET quantidade_produto = quantidade_produto - OLD.quantidade_produto WHERE id_produto = OLD.id_produto;
RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_update_vendaproduto
AFTER UPDATE ON item_venda
FOR EACH ROW
EXECUTE PROCEDURE update_vendaproduto();

CREATE FUNCTION delete_vendaproduto() RETURNS TRIGGER AS $$
BEGIN
UPDATE produto SET quantidade_produto = quantidade_produto + OLD.quantidade_produto WHERE id_produto = OLD.id_produto;
update venda SET valor_vtotal = OLD.preco_ivunitario * OLD.quatidade_produto WHERE id_compra = OLD.id_compra;
RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_delete_vendaproduto
AFTER DELETE ON item_venda
FOR EACH ROW
EXECUTE PROCEDURE delete_vendaproduto();

---------------

CREATE OR REPLACE FUNCTION vendadodia(data_venda DATE)
RETURNS TABLE ( nome VARCHAR, data_venda DATE) AS
$$
BEGIN
RETURN QUERY SELECT cliente.nome, venda.data_venda FROM cliente, venda WHERE
cliente.id_cliente = venda.id_cliente;
END
$$ LANGUAGE plpgsql;

SELECT * FROM vendadodia();



CREATE OR REPLACE FUNCTION produtosabaixoestoque()
RETURNS TABLE (tipo_produto VARCHAR, marca VARCHAR, quantidade_produto INT) AS
$$
BEGIN
RETURN QUERY SELECT produto.tipo_produto, produto.marca, produto.quantidade_produto
FROM produto
WHERE produto.quantidade_produto <= 10;
END
$$ LANGUAGE plpgsql;

SELECT * FROM produtosabaixoestoque();



CREATE FUNCTION clientesquedevem(nome VARCHAR)
$$ 
BEGIN
RETURN QUERY SELECT cliente.nome, venda.valor_vtotal, venda.valor_vpago
FROM cliente, venda
WHERE cliente.id_cliente = venda.id_cliente
AND venda.valor_vpago > venda.valor_vtotal 
OR (venda.valor_vpago + venda.desconto_venda) < venda.valor_vtotal;
END
$$ LANGUAGE plpgsql;

SELECT * FROM clientesquedevem();



CREATE FUNCTION produtosmaisvendidos()

$$ 
BEGIN
RETURN QUERY SELECT produto.tipo_produto, item_venda.id_produto, COUNT(item_venda.id_produto)
FROM item_venda, produto
WHERE produto.id_produto = item_venda.id_produto
GROUP BY item_venda.id_produto
ORDER BY item_venda.id_produto DESC;
END
$$ LANGUAGE plpgsql;

SELECT * FROM produtosmaisvendidos();



CREATE FUNCTION MostrarTotalVenda(data_venda DATE)
RETURNS TABLE (valor_vtotal NUMERIC(10,2))
$$ 
BEGIN
RETURN QUERY SELECT EXTRACT(MONTH FROM data_venda) AS Mes
SUM(venda.valor_vtotal) AS Total
FROM venda
WHERE EXTRACT(YEAR FROM data_venda) = CURRENT_DATE
GROUP BY Mes
ORDER BY Mes;
END
$$ LANGUAGE plpgsql;

SELECT * FROM MostrarTotalVenda();


CREATE FUNCTION ProdMaisLucro(data_venda DATE)
RETURNS TABLE (id_produto INT, valor_vtotal NUMERIC(10,2))
$$ 
BEGIN
RETURN QUERY SELECT EXTRACT(MONTH FROM data_venda) AS Mes, venda.valor_vtotal, venda.id_produto, produto.tipo_produto
FROM venda, produto
WHERE produto.id_produto = venda.id_produto
AND EXTRACT(YEAR FROM data_venda) = CURRENT_DATE
GROUP BY Mes
ORDER BY venda.valor_vtotal DESC;

