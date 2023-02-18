
---to check if the there multiple tenants assigned to single unit

create or replace trigger check_property 
before insert on unit for each row  
declare
rowcount int;
begin
select count(*) into rowcount from unit where tenant_id = :NEW.tenant_id;
if rowcount<>0 then
   raise_application_error(-20001, 'Tenant_id already registered');
end if;
end;


---to check the differencein main amount

create or replace trigger display_main_difference 
before delete or insert or update on maintenance 
for each row
when(NEW.UNIT_ID > 0)
DECLARE Main_diff number;
begin
Main_diff := :NEW.MAIN_AMOUNT - :OLD.MAIN_AMOUNT;
DBMS_OUTPUT.put_line('OLD MAIN_AMOUNT: ' || :OLD.MAIN_AMOUNT);
DBMS_OUTPUT.put_line('NEW MAIN_AMOUNT: ' || :NEW.MAIN_AMOUNT);
DBMS_OUTPUT.put_line('Maintenance difference: ' || main_diff);
end;

---while updating/inserting/deleting maintenance table

create or replace trigger updating_maintenance 
before delete or insert or update of main_id,unit_id, Tenant_contact, main_type, main_amount, main_start_date, main_end_date on maintenance
begin
case
when inserting then
dbms_output.put_line('Inserting into maintenance table');
when updating('unit_id') then
dbms_output.put_line('updating unit_id into maintenance table');
when updating('main_id') then
dbms_output.put_line('updating main_id into maintenance table');
when updating('tenant_contact') then
dbms_output.put_line('updating unit_contact into maintenance table');
when updating('main_type') then
dbms_output.put_line('updating main_type into maintenance table');
when updating('main_amount') then
dbms_output.put_line('updating main_amount into maintenance table');
when updating('main_start_date') then
dbms_output.put_line('updating main_start_date into maintenance table');
when updating('main_end_date') then
dbms_output.put_line('updating main_end_date into maintenance table');
when deleting then
dbms_output.put_line('Deleting');
end case;
end;