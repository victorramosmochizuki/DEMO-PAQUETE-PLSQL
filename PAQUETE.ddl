--SALIDA DE MENSAJE POR CONSOLA
SET SERVEROUTPUT ON;

-------------------------------------------------------------------------------------------------------------------------
--CREAMOS LA TABLA PRODUCTO
CREATE TABLE PRODUCTO (
	IDPRO INTEGER NOT NULL,
	NOMPRO VARCHAR2(50) NOT NULL,	
	PREPRO DECIMAL(10,2) NOT NULL,
	CONSTRAINT PRODUCTO_pk PRIMARY KEY(IDPRO)
);

CREATE SEQUENCE ID_PRODUCTO START WITH 1 INCREMENT BY 1 ORDER;

CREATE OR REPLACE TRIGGER ID_PRODUCTO BEFORE INSERT ON PRODUCTO FOR EACH ROW BEGIN SELECT ID_PRODUCTO.NEXTVAL INTO :NEW.IDPRO FROM DUAL;
END;

-- INSERTAMOS REGISTROS A LA TABLA PRODUCTO
INSERT INTO PRODUCTO (NOMPRO,PREPRO) VALUES ('Atun','5,50');
INSERT INTO PRODUCTO (NOMPRO,PREPRO) VALUES ('Aceite','9,50');
INSERT INTO PRODUCTO (NOMPRO,PREPRO) VALUES ('Arroz','4,50');

SELECT * FROM PRODUCTO;

----------------------------------------------------------------------------

--CREACION DE ESPECIFICACION DEL PAQUETE
CREATE OR REPLACE PACKAGE DEMO AS
PROCEDURE CARACTERISTICAS (V_IDPRO PRODUCTO.IDPRO%TYPE );
END DEMO;


----------------------------------------------------------------------------

--CREACION DE BODY DEL PAQUETE
CREATE OR REPLACE PACKAGE BODY DEMO AS
PROCEDURE CARACTERISTICAS (V_IDPRO PRODUCTO.IDPRO%TYPE )IS
    V_NOMPRO PRODUCTO.NOMPRO%TYPE;
    V_PREPRO PRODUCTO.PREPRO%TYPE;
BEGIN
    SELECT NOMPRO, PREPRO INTO V_NOMPRO, V_PREPRO
    FROM PRODUCTO WHERE IDPRO = V_IDPRO;
    DBMS_OUTPUT.PUT_LINE('NOMBRE DEL PRODUCTO:' || ' ' ||V_NOMPRO );
    DBMS_OUTPUT.PUT_LINE('PRECIO:' || ' ' || V_PREPRO );
    END CARACTERISTICAS;
END DEMO;

----------------------------------------------------------------------------
--Seleccionamos el paquete con su respectivo procedimiento
BEGIN 
    DEMO.CARACTERISTICAS(1);
END;


----------------------------------------------------------------------------
--AGREGAMOS LA FUNCION AL PAQUETE
create or replace PACKAGE DEMO AS
PROCEDURE CARACTERISTICAS (V_IDPRO PRODUCTO.IDPRO%TYPE );
FUNCTION F_PRECIO (V_IDPRO INT)
RETURN NUMBER;

END DEMO;

----------------------------------------------------------------------------

--AGREGAMOS LA FUNCION AL CUERPO DEL PAQUETE
create or replace PACKAGE BODY DEMO AS
PROCEDURE CARACTERISTICAS (V_IDPRO PRODUCTO.IDPRO%TYPE )IS
    V_NOMPRO PRODUCTO.NOMPRO%TYPE;
    V_PREPRO PRODUCTO.PREPRO%TYPE;
BEGIN
    SELECT NOMPRO, PREPRO INTO V_NOMPRO, V_PREPRO
    FROM PRODUCTO WHERE IDPRO = V_IDPRO;
    DBMS_OUTPUT.PUT_LINE('NOMBRE DEL PRODUCTO:' || ' ' ||V_NOMPRO );
    DBMS_OUTPUT.PUT_LINE('PRECIO:' || ' ' || V_PREPRO );
    END CARACTERISTICAS;
-----------------------------------------------------------------------------    
FUNCTION F_PRECIO (V_IDPRO INT)
    RETURN NUMBER
    AS
    V_PREPRO NUMBER;
    BEGIN 
    SELECT PREPRO INTO V_PREPRO
    FROM PRODUCTO WHERE IDPRO = V_IDPRO;
    RETURN V_PREPRO;
    
END F_PRECIO;   
    
END DEMO; 



----------------------------------------------------------------------------

--Seleccionamos el paquete con su respectiva funcion
SELECT DEMO.f_precio(1) AS PRECIO FROM DUAL;

----------------------------------------------------------------------------

--Caracteristicas del paquete
DESCRIBE DEMO

----------------------------------------------------------------------------

--Elimina el cuerpo del paquete
DROP PACKAGE BODY DEMO;

----------------------------------------------------------------------------

--Elimina el paquete
DROP PACKAGE DEMO;


