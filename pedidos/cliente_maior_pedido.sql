SELECT c.nome
FROM clientes c
JOIN pedidos p ON c.id_cliente = p.id_cliente
WHERE p.total = (SELECT MAX(total) FROM pedidos)
FETCH FIRST 1 ROW ONLY; 
