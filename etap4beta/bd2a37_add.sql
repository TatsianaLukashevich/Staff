CREATE SEQUENCE BD2A37.dodaj1 START WITH 6 INCREMENT BY 1 MAXVALUE 99999 MINVALUE 1 CYCLE ;





CREATE OR REPLACE TRIGGER sprawdz_jedn_org 
    AFTER DELETE ON JEDNOSTKI_ORGANIZACYJNE 
    FOR EACH ROW 
begin
  if :OLD.NAZWA='Kierowanie' or :OLD.NAZWA='Finansy' then
    RAISE_APPLICATION_ERROR(-20999,'Nie mozna usunac!');
  end if;
end; 
/



CREATE OR REPLACE TRIGGER BD2A37.sprawdz_stanowiska 
    AFTER DELETE ON STANOWISKA 
    FOR EACH ROW 
begin
  if :OLD.NAZWA='Kierownik' or :OLD.NAZWA='Ksiegowa' then
    RAISE_APPLICATION_ERROR(-20999,'Nie mozna usunac!');
  end if;
end; 
/

