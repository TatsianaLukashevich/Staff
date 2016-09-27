
CREATE USER BD2A37_APP IDENTIFIED BY ACCOUNT UNLOCK ;

CREATE TABLE JEDNOSTKI_ORGANIZACYJNE
  (
    KOD_ORGANIZACJI VARCHAR2 (10 CHAR) NOT NULL ,
    NAZWA           VARCHAR2 (10 CHAR) NOT NULL ,
    KOD_ORG_NADRZ   VARCHAR2 (10 CHAR)
  )
  LOGGING ;
COMMENT ON TABLE JEDNOSTKI_ORGANIZACYJNE
IS
  'Opisuje kazda jednostke organizacyjna,ktora istnieje.
Jednostka organizacyjna powinna byc opisana przez kod organizacji i nazwe' ;
  COMMENT ON COLUMN JEDNOSTKI_ORGANIZACYJNE.KOD_ORGANIZACJI
IS
  'Kazda jednostka organizacyjna ma kod organizacji, ktory odroznia je od siebie.
Wprowadzac duzymi literami (jesli zawiera litery), bez spacji' ;
  COMMENT ON COLUMN JEDNOSTKI_ORGANIZACYJNE.NAZWA
IS
  'Kazda jednostka organizacyjna posiada wlasna nazwe.
Wprowadzac z duzej litery(pierwsza duza litera,pozostale- male)' ;
  COMMENT ON COLUMN JEDNOSTKI_ORGANIZACYJNE.KOD_ORG_NADRZ
IS
  'Jednostka organizacyjna ma kod organizacji nadrzednej( jesli posiada ja), ktory odroznia je od siebie.
Wprowadzac duzymi literami (jesli zawiera litery), bez spacji' ;
  CREATE INDEX JOJO_FK_IDX ON JEDNOSTKI_ORGANIZACYJNE
    (
      KOD_ORG_NADRZ ASC
    )
    LOGGING ;
  GRANT
  SELECT,
  INSERT,
  UPDATE,
  DELETE ON JEDNOSTKI_ORGANIZACYJNE TO BD2A37_APP ;
ALTER TABLE JEDNOSTKI_ORGANIZACYJNE ADD CONSTRAINT JO_PK PRIMARY KEY ( KOD_ORGANIZACJI ) ;
ALTER TABLE JEDNOSTKI_ORGANIZACYJNE ADD CONSTRAINT JO_UK UNIQUE ( NAZWA ) ;


CREATE TABLE PRACOWNICY
  (
    ID_PRACOWNIKA NUMBER (5) NOT NULL ,
    NAZWISKO      VARCHAR2 (20 CHAR) NOT NULL ,
    IMIE          VARCHAR2 (15 CHAR) NOT NULL ,
    PESEL         CHAR (11 CHAR) NOT NULL
  )
  LOGGING ;
COMMENT ON TABLE PRACOWNICY
IS
  'Opisuje kazdego pracownika zatrudnionego do pracy.
Kazdy pracownik powinien miec swoj id, nazwisko, imie, pesel' ;
  COMMENT ON COLUMN PRACOWNICY.ID_PRACOWNIKA
IS
  'Indentyfikuje kazdego pracownika.
Wprowadzic tylko cyfry, bez zadnych innych znakow' ;
  COMMENT ON COLUMN PRACOWNICY.NAZWISKO
IS
  'Nazwisko pracownika.
Wprowadzac duzymi literami' ;
  COMMENT ON COLUMN PRACOWNICY.IMIE
IS
  'Imie pracownika
Wprowadzac z duzej litery(pierwsza duza litera,pozostale- male)' ;
  COMMENT ON COLUMN PRACOWNICY.PESEL
IS
  'Powszechny Elektroniczny System Ewidencji Ludnoœci w Polsce,  sluzy do gromadzenia podstawowych informacji identyfikujacych tozsamosc i status administracyjno-prawny obywateli polskich.
Wprowadzic tylko cyfry, bez zadnych innych znakow' ;
  GRANT
  SELECT,
  INSERT,
  UPDATE,
  DELETE ON PRACOWNICY TO BD2A37_APP ;
ALTER TABLE PRACOWNICY ADD CONSTRAINT P_PK PRIMARY KEY ( ID_PRACOWNIKA ) ;
ALTER TABLE PRACOWNICY ADD CONSTRAINT P_UK UNIQUE ( PESEL ) ;


CREATE TABLE STANOWISKA
  (
    KOD_STANOWISKA VARCHAR2 (8 CHAR) NOT NULL ,
    NAZWA          VARCHAR2 (30 CHAR) NOT NULL ,
    STATUS         VARCHAR2 (10 CHAR) NOT NULL
  )
  LOGGING ;
COMMENT ON TABLE STANOWISKA
IS
  'Opisuje ka¿de stanowisko.
Kazde stanowisko opisuje jego kod, nazwa, status(Tak lub Nie)' ;
  COMMENT ON COLUMN STANOWISKA.KOD_STANOWISKA
IS
  'Wykorzystuje sie do odroznienia miedzy soba kazde stanowisko.
Wprowadzac duzymi literami (jesli zawiera litery), bez spacji' ;
  COMMENT ON COLUMN STANOWISKA.NAZWA
IS
  'Stanowisko powinno posiadac wlasna nazwe.
Wprowadzac z duzej litery(pierwsza duza litera,pozostale- male)' ;
  COMMENT ON COLUMN STANOWISKA.STATUS
IS
  'Jesli stanowsko zajete, to nalezy wprowadzic z duzej litery - Tak, jesli jeszcze nie zajete - Nie ' ;
  GRANT
  SELECT,
  INSERT,
  UPDATE,
  DELETE ON STANOWISKA TO BD2A37_APP ;
ALTER TABLE STANOWISKA ADD CONSTRAINT S_PK PRIMARY KEY ( KOD_STANOWISKA ) ;


CREATE TABLE STANOWISKA_PRACOWNIKOW
  (
    KOD_ORGANIZACJI  VARCHAR2 (10 CHAR) NOT NULL ,
    KOD_STANOWISKA   VARCHAR2 (8 CHAR) NOT NULL ,
    ID_PRACOWNIKA    NUMBER (5) NOT NULL ,
    DATA_ROZPOCZECIA DATE NOT NULL ,
    DATA_ZAKONCZENIA DATE
  )
  LOGGING ;
COMMENT ON TABLE STANOWISKA_PRACOWNIKOW
IS
  'Opisuje na jaki czas lub od jakiej daty jest zajete stanowisko.
Kazde stanowisko pracownika powinno zawierac date rozpoczecia pracy i date zakonczenia, jesli pracownik nie zajmuje dane stanowisko' ;
  COMMENT ON COLUMN STANOWISKA_PRACOWNIKOW.KOD_ORGANIZACJI
IS
  'Kazda jednostka organizacyjna ma kod organizacji, ktory odroznia je od siebie.
Wprowadzac duzymi literami (jesli zawiera litery), bez spacji' ;
  COMMENT ON COLUMN STANOWISKA_PRACOWNIKOW.KOD_STANOWISKA
IS
  'Wykorzystuje sie do odroznienia miedzy soba kazde stanowisko.
Wprowadzac duzymi literami (jesli zawiera litery), bez spacji' ;
  COMMENT ON COLUMN STANOWISKA_PRACOWNIKOW.ID_PRACOWNIKA
IS
  'Indentyfikuje kazdego pracownika.
Wprowadzic tylko cyfry, bez zadnych innych znakow' ;
  COMMENT ON COLUMN STANOWISKA_PRACOWNIKOW.DATA_ROZPOCZECIA
IS
  'Data rozpoczecia pracy.Wpisuje sie odrazu, kiedy pracownik zostal przyjete na dane stanowsko' ;
  COMMENT ON COLUMN STANOWISKA_PRACOWNIKOW.DATA_ZAKONCZENIA
IS
  'Data zakonczenia pracy.Wpisuje sie odrazu,przywidywana data zwolnienia z danego stanowska' ;
  CREATE INDEX SPP_FK_IDX ON STANOWISKA_PRACOWNIKOW
    (
      ID_PRACOWNIKA ASC
    )
    LOGGING ;
  CREATE INDEX SPJO_FK_IDX ON STANOWISKA_PRACOWNIKOW
    (
      KOD_ORGANIZACJI ASC
    )
    LOGGING ;
  CREATE INDEX SPS_FK_IDX ON STANOWISKA_PRACOWNIKOW
    (
      KOD_STANOWISKA ASC
    )
    LOGGING ;
  GRANT
  SELECT,
  INSERT,
  UPDATE,
  DELETE ON STANOWISKA_PRACOWNIKOW TO BD2A37_APP ;
ALTER TABLE STANOWISKA_PRACOWNIKOW ADD CONSTRAINT SP_PK PRIMARY KEY ( DATA_ROZPOCZECIA, ID_PRACOWNIKA ) ;


ALTER TABLE JEDNOSTKI_ORGANIZACYJNE ADD CONSTRAINT JOJO_FK FOREIGN KEY ( KOD_ORG_NADRZ ) REFERENCES JEDNOSTKI_ORGANIZACYJNE ( KOD_ORGANIZACJI ) DEFERRABLE ;

ALTER TABLE STANOWISKA_PRACOWNIKOW ADD CONSTRAINT SPJO_FK FOREIGN KEY ( KOD_ORGANIZACJI ) REFERENCES JEDNOSTKI_ORGANIZACYJNE ( KOD_ORGANIZACJI ) DEFERRABLE ;

ALTER TABLE STANOWISKA_PRACOWNIKOW ADD CONSTRAINT SPP_FK FOREIGN KEY ( ID_PRACOWNIKA ) REFERENCES PRACOWNICY ( ID_PRACOWNIKA ) ON
DELETE CASCADE DEFERRABLE ;

ALTER TABLE STANOWISKA_PRACOWNIKOW ADD CONSTRAINT SPS_FK FOREIGN KEY ( KOD_STANOWISKA ) REFERENCES STANOWISKA ( KOD_STANOWISKA ) DEFERRABLE ;

CREATE OR REPLACE TRIGGER FKNTM_STANOWISKA_PRACOWNIKOW BEFORE
  UPDATE OF KOD_ORGANIZACJI,
    KOD_STANOWISKA,
    ID_PRACOWNIKA ON STANOWISKA_PRACOWNIKOW BEGIN raise_application_error(-20225,'Non Transferable FK constraint  on table STANOWISKA_PRACOWNIKOW is violated');
END;
/
