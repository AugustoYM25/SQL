SELECT c.nome
FROM clientes c
INNER JOIN pedidos p ON c.id_cliente = p.id_cliente 
WHERE p.id_pedido IN (SELECT p.id_pedido
                      FROM pedidos p
                      INNER JOIN itenspedido i ON p.id_pedido = c.id_pedido
                      WHERE i.id_produto = 1 --Insira aqui o id do produto
)
