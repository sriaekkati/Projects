-- TO CREATE A FUNCTION GET VACANT UNITS 

CREATE FUNCTION GET_VACANT_UNITS 
    RETURN NUMBER  
    IS
        V_VACANT_UNITS NUMBER;
        BEGIN 
        SELECT COUNT(UNIT_ID) 
        INTO V_VACANT_UNITS
        FROM UNIT 
        WHERE TENANT_ID IS NULL;
    RETURN V_VACANT_UNITS;
END;
/

-- TO CALL THE GET_VACANT_UNITS IN A PL/SQL BLOCK 


SET SERVEROUTPUT ON;
    DECLARE
        P_VC NUMBER;
        BEGIN 
            P_VC := ADMIN123.GET_VACANT_UNITS;
        DBMS_OUTPUT.PUT_LINE('P_VC ' || P_VC);
END;
/

--TO CREATE A FUNCTION TO GET THE AVERAGE UNIT PRICE

CREATE FUNCTION GET_AVG_UNIT_PRICE 
RETURN NUMBER 
IS 
	V_AVG_UNIT_PRICE NUMBER;
	BEGIN
	SELECT AVG(UNIT_RENT)
	INTO V_AVG_UNIT_PRICE
	FROM UNIT;
	RETURN V_AVG_UNIT_PRICE;
END;
/

DROP FUNCTION GET_AVG_UNIT_PRICE;

-- TO CALL THE GET_AVG_UNIT_PRICE IN A PL/SQL BLOCK 

SET SERVEROUTPUT ON;
DECLARE 
P_AVG NUMBER;
BEGIN
P_AVG := ADMIN123.GET_AVG_UNIT_PRICE;
DBMS_OUTPUT.PUT_LINE ('P_AVG     ' || P_AVG );
END; 
/

--TO CREATE A FUNCTION TO GET_UNRESOLVED_ISSUES

CREATE FUNCTION GET_UNRESOLVED_ISSUES
RETURN NUMBER 
IS 
    V_UNRESOLVED_ISSUES NUMBER;
    
    BEGIN
    SELECT COUNT(MAIN_END_DATE)
    INTO V_UNRESOLVED_ISSUES
    FROM MAINTENANCE
    WHERE MAIN_TYPE IS NOT NULL AND MAIN_END_DATE > CURRENT_DATE;
    RETURN V_UNRESOLVED_ISSUES;
    EXCEPTION WHEN OTHERS THEN 
    DBMS_OUTPUT.PUT_LINE(SQLCODE);
    DBMS_OUTPUT.PUT_LINE('DATA NOT IN TABLE');
END;
/

-- TO CALL THE GET_UNREVOLVED_ISSUES FUNCTION IN A PL/SQL BLOCK 

SET SERVEROUTPUT ON;
DECLARE 
P_UNRES NUMBER;
BEGIN
P_UNRES := ADMIN123.GET_UNRESOLVED_ISSUES;
DBMS_OUTPUT.PUT_LINE ('P_UNRES      ' || P_UNRES );
END; 
/




