CREATE OR REPLACE 
FUNCTION FUNC_CALCULA_PEDIDO(p_id_pedido IN itenspedido.id_pedido)
RETURN NUMBER
IS
    V_calculo NUMBER(10,2) := 0; 
    V_ID_EXISTE NUMBER(1); 
BEGIN

    SELECT COUNT(*) INTO V_ID_EXISTE
    FROM itenspedido
    WHERE id_pedido = p_id_pedido;


    IF V_ID_EXISTE = 0 THEN
        RETURN 0;
    END IF;


    FOR i IN (SELECT i.quantidade, p.preco
              FROM itenspedido i
              JOIN produtos p ON i.id_produto = p.id_produto
              WHERE i.id_pedido = p_id_pedido) LOOP
        V_calculo := V_calculo + (i.quantidade * i.preco);
    END LOOP;

    RETURN V_calculo;
END FUNC_CALCULA_PEDIDO;
