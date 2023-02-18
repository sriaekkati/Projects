-- ADD_UNITS PROCEDURE IS CREATED UNDER MANAGE_UNITS PACKAGE
create or replace PROCEDURE ADD_UNITS (IN_UNIT_ID NUMBER, 
                    
                    IN_OWNER_ID NUMBER,
                    IN_MANAGER_ID NUMBER,
                    IN_UNIT_RENT NUMBER,
                    IN_UNIT_OWNER VARCHAR2,
                    IN_UNIT_ADDRESS VARCHAR2
                    ) 
IS 
 INVALID_INPUTS EXCEPTION;

BEGIN 
    IF (IN_UNIT_ID IS NULL 
      
        OR IN_OWNER_ID IS NULL 
        OR IN_MANAGER_ID IS NULL 
        OR IN_UNIT_RENT IS NULL 
        OR IN_UNIT_OWNER IS NULL 
        OR IN_UNIT_ADDRESS IS NULL )
    THEN 
     RAISE INVALID_INPUTS;
    END IF;

INSERT INTO UNIT (
                UNIT_ID,
               
                OWNER_ID,
                MANAGER_ID,
                UNIT_RENT,
                UNIT_OWNER,
                UNIT_ADDRESS
            ) VALUES ( 
            IN_UNIT_ID,
            
            IN_OWNER_ID,
            IN_MANAGER_ID,
            IN_UNIT_RENT,
            IN_UNIT_OWNER,
            IN_UNIT_ADDRESS
            );


EXCEPTION
WHEN INVALID_INPUTS
THEN 
 --RAISE INVALID_INPUTS;
 raise_application_error (-20091,'VALUES CANNNOT BE NULL');
--THEN DBMS_OUTPUT.PUT_LINE ('INPUTS ARE NOT VALID');
-- END;
END ADD_UNITS;