CREATE OR REPLACE
FUNCTION ALTERA_SALARIO(P_EMPLOYEE_ID IN FUNCIONARIOS_AYM.EMPLOYEE_ID%TYPE,
                        P_SALARY IN FUNCIONARIOS_AYM.EMPLOYEE_ID%TYPE)
RETURN NUMBER
IS
      V_ID_EXISTE NUMBER(1);
      V_OLD_SALARY NUMBER(8,2);
     
     
BEGIN
     
        IF P_SALARY > 0 AND P_SALARY <999999.99 THEN
           
        SELECT COUNT(*) INTO V_ID_EXISTE
        FROM FUNCIONARIOS_AYM WHERE EMPLOYEE_ID = P_EMPLOYEE_ID;
 
                IF V_ID_EXISTE = 1 THEN
 
                    SELECT SALARY INTO V_OLD_SALARY
                    FROM FUNCIONARIOS_AYM WHERE EMPLOYEE_ID = P_EMPLOYEE_ID;
                   
                    IF P_SALARY > V_OLD_SALARY THEN
 
                                INSERT INTO LOG_FUNCIONARIOS_AYM(ID_LOG, EMPLOYEE_ID, SALARY_OLD, SALARY_NEW,DTH_REGISTRO, USUARIO)
                                VALUES(SQ_ID_LOG_FUNC.NEXTVAL, P_EMPLOYEE_ID, V_OLD_SALARY, P_SALARY, SYSDATE, USER);
 
                                UPDATE FUNCIONARIOS_AYM
                                    SET SALARY = P_SALARY
                                    WHERE P_EMPLOYEE_ID = EMPLOYEE_ID;
                                    RETURN 0;
                                                   
                    ELSE
                    RETURN -998;
                    END IF;
                                       
                ELSE
                RETURN -999;
                END IF;
 
        ELSE
        RETURN -998;
        END IF;
   
   
END;
