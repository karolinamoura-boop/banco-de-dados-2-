
CREATE TABLE Produtos (
    produto_id INT PRIMARY KEY AUTO_INCREMENT,
    nome_produto VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10, 2) NOT NULL,
    estoque INT DEFAULT 0
);

CREATE TABLE Pedidos (
    pedido_id INT PRIMARY KEY AUTO_INCREMENT,
    data_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    cliente_nome VARCHAR(100),
    status_pedido VARCHAR(50) DEFAULT 'Pendente'
);

CREATE TABLE ItensPedido (
    item_pedido_id INT PRIMARY KEY AUTO_INCREMENT,
    pedido_id INT,
    produto_id INT,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES Pedidos(pedido_id) ON DELETE CASCADE,
    FOREIGN KEY (produto_id) REFERENCES Produtos(produto_id)
);


INSERT INTO Produtos (nome_produto, descricao, preco, estoque) VALUES
('Livro: Cemiterio Maldito', 'Clássico do terror', 35.50, 15),
('Café Expresso', 'Café forte e aromático', 5.00, 50),
('Caderno Universitário', '10 matérias, capa dura', 15.75, 30);


INSERT INTO Pedidos (cliente_nome, status_pedido) VALUES
('Ana karolina', 'Concluído'),
('Isis', 'Pendente'),
('Mirela', 'Em Processamento');

INSERT INTO ItensPedido (pedido_id, produto_id, quantidade, preco_unitario) VALUES
(1, 1, 1, 35.50), -- Ana Karolina comprou 1 livro 'Cemiterio Maldito'
(2, 2, 2, 5.00), -- Isis comprou 2 cafés
(3, 3, 5, 15.75); -- Mirela comprou 5 cadernos

UPDATE Pedidos
SET status_pedido = 'Concluído'
WHERE cliente_nome = 'Isis';

DELETE FROM ItensPedido
WHERE pedido_id = 3 AND produto_id = 3;


SELECT * FROM Produtos;
SELECT cliente_nome, data_pedido FROM Pedidos WHERE status_pedido = 'Concluído';
SELECT P.nome_produto, IP.quantidade, IP.preco_unitario
FROM ItensPedido AS IP
JOIN Produtos AS P ON IP.produto_id = P.produto_id
WHERE IP.pedido_id = 1;
