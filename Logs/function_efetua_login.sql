CREATE OR REPLACE
FUNCTION EFETUA_LOGIN(P_EMAIL IN USUARIO.EMAIL%TYPE,
                    P_SENHA IN USUARIO.SENHA%TYPE)
 
RETURN VARCHAR2
 
IS
 
V_EMAIL_EXISTE NUMBER(1);
V_RET VARCHAR2(50);
V_SQLERRM VARCHAR2(240);
V_SENHA USUARIO.SENHA%TYPE;
SENHA_CRYPTO USUARIO.SENHA%TYPE;
 
BEGIN
 
        SELECT COUNT(*) INTO V_EMAIL_EXISTE
        FROM USUARIO WHERE EMAIL = P_EMAIL;
 
                IF V_EMAIL_EXISTE = 1 THEN -- verifica existencia do email
 
                SELECT SENHA INTO V_SENHA
                FROM USUARIO WHERE EMAIL = P_EMAIL;
 
                SENHA_CRYPTO :=
                RAWTOHEX(DBMS_OBFUSCATION_TOOLKIT.MD5(INPUT => UTL_I18N.STRING_TO_RAW(P_SENHA, 'AL32UTF8')));
 
                        IF V_SENHA = SENHA_CRYPTO THEN
                        V_RET := 'Acesso efetuado';
 
                        ELSE
                        V_RET := 'Não foi possível efetuar o login';
                        END IF;
 
                ELSE
                V_RET := -999;
                END IF;
 
 
 
RETURN V_RET;
 
EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.put_line ('Função: '|| $$plsql_unit);
        DBMS_OUTPUT.PUT_LINE('CODIGO ERRO: ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('DESCRICAO ERRO: ' || SQLERRM);    
        DBMS_OUTPUT.put_line (DBMS_UTILITY.format_error_backtrace);
 
        V_RET := SQLCODE;
        V_SQLERRM := SQLERRM;
 
        INSERT INTO LOG_LOGIN(
                LOG_ID,
                NOME_CODIGO,
                PARAMETROS_ENTRADA,
                CODIGO_ERRO,
                DESCRICAO_ERRO,
                LINHA_ERRO,
                DTH_REGISTRO,
                USUARIO,
                STATUS,
                DESCRICAO_RESOLVIDO
            )
            VALUES
            (
                SQ_ID_LOG_LOGIN.NEXTVAL,
                'EFETUA_CADASTRO',
                'P_EMAIL = ' ||  P_EMAIL,
                V_RET,
                V_SQLERRM,
                DBMS_UTILITY.format_error_backtrace,
                SYSDATE,
                USER,
                'E',
                NULL
            );
 
COMMIT;
END;
