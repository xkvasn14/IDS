DROP TABLE Material CASCADE CONSTRAINTS;
DROP TABLE Furniture CASCADE CONSTRAINTS;
DROP TABLE TheOrder CASCADE CONSTRAINTS;
DROP TABLE Bill CASCADE CONSTRAINTS;
DROP TABLE Person CASCADE CONSTRAINTS;
DROP TABLE Material_Furniture CASCADE CONSTRAINTS;
DROP TABLE Bill_Order_Customer CASCADE CONSTRAINTS;
DROP TABLE Order_Furniture CASCADE CONSTRAINTS;
DROP TABLE Order_Worker CASCADE CONSTRAINTS;

DROP SEQUENCE Bill_ID_seq;



------------------ TABLES ------------------------
CREATE TABLE Material(
    Material_ID     int not null PRIMARY KEY check (MATERIAL_ID between 0 and 99),
    MaterialName    varchar(100),
    Cost            int check(Cost >= 0),
    Amount          int check (Amount between 0 and 1000),
    Supplier        varchar(100)
);

CREATE TABLE Furniture(
    Furniture_ID    int not null PRIMARY KEY check (FURNITURE_ID between 100 and 999),
    Color           varchar(50),
    FurnitureSize   varchar(100),
    Components      varchar(255)
);

CREATE TABLE Person(
    Person_ID       int not null PRIMARY KEY check (Person_ID between 1000 and 9999),
    PersonName      varchar(50) not null,
    Email           varchar(50) unique,
    Specialization  varchar(50),
    WagePerHour     int check(WagePerHour >= 0),    
    IsExtWorker     int check (IsExtWorker between 0 and 1),
    IsCustomer      int check (IsCustomer between 0 and 1)
);

CREATE TABLE TheOrder(
    Order_ID        int not null PRIMARY KEY check (Order_ID between 10000 and 99999),
    OrderCost       float check(OrderCost >= 0),
    Amount          int check(Amount >= 0),
    OrderFinished   int check (OrderFinished between 0 and 1)
);

CREATE TABLE Bill(
    Bill_ID         int not null PRIMARY KEY check (Bill_ID between 100000 and 999999),
    FinalCost       float check(FinalCost >= 0),
    WorkedHours     int check(WorkedHours >= 0)
);

--------------- CONNECTIONS -------------------------

CREATE TABLE Material_Furniture(
Material_Furniture_PK int not null PRIMARY KEY,
Material_ID         int check (MATERIAL_ID between 0 and 99),
Furniture_ID        int check (FURNITURE_ID between 100 and 999),
FOREIGN KEY (Material_ID) REFERENCES Material (Material_ID),
FOREIGN KEY (Furniture_ID) REFERENCES Furniture (Furniture_ID)
);


CREATE TABLE Bill_Order_Customer(
Bill_Order_Customer_PK int not null PRIMARY KEY,
Bill_ID             int check (Bill_ID between 100000 and 999999),
Order_ID            int check (Order_ID between 10000 and 99999),
Customer_ID         int check (Customer_ID between 1000 and 9999),
FOREIGN KEY (Bill_ID) REFERENCES Bill (Bill_ID),
FOREIGN KEY (Order_ID) REFERENCES TheOrder (Order_ID),
FOREIGN KEY (Customer_ID) REFERENCES Person (Person_ID)
);

CREATE TABLE Order_Furniture(
    Order_Furniture_PK int not null PRIMARY KEY,
    ORDER_ID        int check (ORDER_ID between 10000 and 99999),
    Furniture_ID    int check (Furniture_ID between 100 and 999),
    FOREIGN KEY (Furniture_ID) REFERENCES Furniture (Furniture_ID),
    FOREIGN KEY (Order_ID) REFERENCES TheOrder (Order_ID)
);

CREATE TABLE Order_Worker(
    Order_Worker_PK int not null PRIMARY KEY,
    Order_ID        int check (Order_ID between 10000 and 99999),  
    Worker_ID       int check (Worker_ID between 1000 and 9999),
    IsMainWorker    int check (IsMainWorker between 0 and 1),
    FOREIGN KEY (Order_ID) REFERENCES TheOrder (Order_ID),
    FOREIGN KEY (Worker_ID) REFERENCES Person (Person_ID)
);




------------------- DATA -----------------------------

INSERT INTO Material (MATERIAL_ID, MaterialName, Cost, Amount, Supplier) VALUES (1,'cobbalt',1000,20,'CCF');
INSERT INTO Material (MATERIAL_ID, MaterialName, Cost, Amount, Supplier) VALUES (2,'copper',600,40,'CCF');
INSERT INTO Material (MATERIAL_ID, MaterialName, Cost, Amount, Supplier) VALUES (3,'coal',200,10,'OKD');
INSERT INTO Material (MATERIAL_ID, MaterialName, Cost, Amount, Supplier) VALUES (4,'oak',800,60,'LesyCR');
INSERT INTO Material (MATERIAL_ID, MaterialName, Cost, Amount, Supplier) VALUES (5,'pine',500,80,'LesyCR');
INSERT INTO Material (MATERIAL_ID, MaterialName, Cost, Amount, Supplier) VALUES (6,'birke',100,70,'EKO');


INSERT INTO Furniture (Furniture_ID, Color, FurnitureSize, Components) VALUES (100,'red','10x10x30','copper screws, oak plates, coal');
INSERT INTO Furniture (Furniture_ID, Color, FurnitureSize, Components) VALUES (101,'green','50x200x50','copper screws, birke box');
INSERT INTO Furniture (Furniture_ID, Color, FurnitureSize, Components) VALUES (102,'yellow','5x2x100','cobbalt rod');
INSERT INTO Furniture (Furniture_ID, Color, FurnitureSize, Components) VALUES (103,'aplle-green','600x800x1500','pine plates, pine curves, copper screws, stabilization rod');
INSERT INTO Furniture (Furniture_ID, Color, FurnitureSize, Components) VALUES (104,'blue','900x1500x3000','4 oak sticks, 1 birke plate, cobbalt screws');


INSERT INTO Person(Person_ID, PersonName, Email, Specialization, WAGEPERHOUR, ISEXTWORKER, ISCUSTOMER) VALUES (1000,'Otto Balgoz',null,'Constructor',null,0,0);
INSERT INTO Person(Person_ID, PersonName, Email, Specialization, WAGEPERHOUR, ISEXTWORKER, ISCUSTOMER) VALUES (1001,'Klára Podřízková',null,'Constructor',150,1,0);
INSERT INTO Person(Person_ID, PersonName, Email, Specialization, WAGEPERHOUR, ISEXTWORKER, ISCUSTOMER) VALUES (1002,'Ronaldo L Gabonso',null,'Constructor',null,0,0);
INSERT INTO Person(Person_ID, PersonName, Email, Specialization, WAGEPERHOUR, ISEXTWORKER, ISCUSTOMER) VALUES (1003,'Honza Vaverik',null,'Machiner',null,0,0);
INSERT INTO Person(Person_ID, PersonName, Email, Specialization, WAGEPERHOUR, ISEXTWORKER, ISCUSTOMER) VALUES (1004,'Bella Karasievna','Ballana@rsn.ru',null,null,0,1);
INSERT INTO Person(Person_ID, PersonName, Email, Specialization, WAGEPERHOUR, ISEXTWORKER, ISCUSTOMER) VALUES (1005,'Otto Balgos','otto@rsn.ru',null,null,0,1);


INSERT INTO TheOrder (Order_ID, OrderCost, Amount,OrderFinished) VALUES (10000,100.99,2,0);
INSERT INTO TheOrder (Order_ID, OrderCost, Amount,OrderFinished) VALUES (10001,3500,1,0);
INSERT INTO TheOrder (Order_ID, OrderCost, Amount,OrderFinished) VALUES (10002,1550,3,0);
INSERT INTO TheOrder (Order_ID, OrderCost, Amount,OrderFinished) VALUES (10003,27000,6,0);


INSERT INTO Bill (Bill_ID, FinalCost, WorkedHours) VALUES (100000,5150.99,20);
INSERT INTO Bill (Bill_ID, FinalCost, WorkedHours) VALUES (100001,271550,90);



INSERT INTO MATERIAL_FURNITURE (Material_Furniture_PK, Material_ID, Furniture_ID) VALUES (1,2,100);
INSERT INTO MATERIAL_FURNITURE (Material_Furniture_PK, Material_ID, Furniture_ID) VALUES (2,4,100);
INSERT INTO MATERIAL_FURNITURE (Material_Furniture_PK, Material_ID, Furniture_ID) VALUES (3,3,100);
INSERT INTO MATERIAL_FURNITURE (Material_Furniture_PK, Material_ID, Furniture_ID) VALUES (4,2,101);
INSERT INTO MATERIAL_FURNITURE (Material_Furniture_PK, Material_ID, Furniture_ID) VALUES (5,6,101);
INSERT INTO MATERIAL_FURNITURE (Material_Furniture_PK, Material_ID, Furniture_ID) VALUES (6,1,102);
INSERT INTO MATERIAL_FURNITURE (Material_Furniture_PK, Material_ID, Furniture_ID) VALUES (7,5,103);
INSERT INTO MATERIAL_FURNITURE (Material_Furniture_PK, Material_ID, Furniture_ID) VALUES (8,5,103);
INSERT INTO MATERIAL_FURNITURE (Material_Furniture_PK, Material_ID, Furniture_ID) VALUES (9,2,103);
INSERT INTO MATERIAL_FURNITURE (Material_Furniture_PK, Material_ID, Furniture_ID) VALUES (10,4,104);
INSERT INTO MATERIAL_FURNITURE (Material_Furniture_PK, Material_ID, Furniture_ID) VALUES (11,6,104);
INSERT INTO MATERIAL_FURNITURE (Material_Furniture_PK, Material_ID, Furniture_ID) VALUES (12,1,104);


INSERT INTO Bill_Order_Customer (Bill_Order_Customer_PK, Bill_id, Order_ID, Customer_ID) VALUES (1,100000,10000,1005);
INSERT INTO Bill_Order_Customer (Bill_Order_Customer_PK, Bill_id, Order_ID, Customer_ID) VALUES (2,100000,10001,1005);
INSERT INTO Bill_Order_Customer (Bill_Order_Customer_PK, Bill_id, Order_ID, Customer_ID) VALUES (3,100001,10002,1004);
INSERT INTO Bill_Order_Customer (Bill_Order_Customer_PK, Bill_id, Order_ID, Customer_ID) VALUES (4,100001,10003,1004);


INSERT INTO Order_Furniture (Order_Furniture_PK, Order_ID, Furniture_ID) VALUES (1,10000, 100);
INSERT INTO Order_Furniture (Order_Furniture_PK, Order_ID, Furniture_ID) VALUES (2,10000, 101);
INSERT INTO Order_Furniture (Order_Furniture_PK, Order_ID, Furniture_ID) VALUES (3,10001, 102);
INSERT INTO Order_Furniture (Order_Furniture_PK, Order_ID, Furniture_ID) VALUES (4,10001, 103);
INSERT INTO Order_Furniture (Order_Furniture_PK, Order_ID, Furniture_ID) VALUES (5,10001, 104);


INSERT INTO Order_Worker(Order_Worker_PK,Order_ID, Worker_ID, ISMAINWORKER) VALUES (1,10000,1000,0);
INSERT INTO Order_Worker(Order_Worker_PK,Order_ID, Worker_ID, ISMAINWORKER) VALUES (2,10000,1002,1);
INSERT INTO Order_Worker(Order_Worker_PK,Order_ID, Worker_ID, ISMAINWORKER) VALUES (3,10001,1000,0);
INSERT INTO Order_Worker(Order_Worker_PK,Order_ID, Worker_ID, ISMAINWORKER) VALUES (4,10001,1001,0);
INSERT INTO Order_Worker(Order_Worker_PK,Order_ID, Worker_ID, ISMAINWORKER) VALUES (5,10001,1003,1);


------------------- SELECT SQL -----------------------------

--1)
-- kolik kusu nabytku (id zakazky: 10000) bylo vyrobeno/objednano
SELECT COUNT(*)
FROM ORDER_FURNITURE
WHERE ORDER_ID = 10000;

--2)
--which constructors/Machiners are also the main ones
--slouzi k vyhledani hlavnich pracovniku. Vypisem je jmeno hlavniho pracovnika a cislo dane zakazky, ktere veli
SELECT DISTINCT Person.PersonName, ORDER_WORKER.ORDER_ID
FROM Person NATURAL JOIN Order_Worker
WHERE Person_ID = Worker_ID AND ISMAINWORKER = 1;

--3)
--kolik druhu materialu bylo použito na nábytek(id 100)
--slouzi pro rychlou orientaci mezi objednavkami
SELECT COUNT(*)
FROM Order_Furniture NATURAL JOIN Material_Furniture
WHERE Furniture_ID = 100;

--4)
--pocet kusu materialu pouzity na zakazku s id:10000
SELECT COUNT(*)
FROM Order_Furniture NATURAL JOIN MATERIAL_FURNITURE
WHERE ORDER_ID = 10000;

--5)
-- počet jednotlivých barev v zakázkách
--slouzi jako statistika nejpouzivanejsich barev
SELECT Furniture.COLOR, COUNT(Furniture.color)
FROM Furniture NATURAL JOIN MATERIAL_FURNITURE
GROUP BY FURNITURE.COLOR;

--6)
--JAKY MATERIAL JE NEJVICE ZASTOUPEN podle ceny
--jedna se o vypis materialu jeho pouziti v jednotlivych komponentach a take vypis jeho ceny
--uzivatel muze porovna ceny a vyuziti jednotlivych prvku
SELECT MATERIAL.MATERIALNAME, MATERIAL.COST, FURNITURE.COMPONENTS
FROM MATERIAL NATURAL JOIN FURNITURE, MATERIAL_FURNITURE
WHERE MATERIAL.MATERIAL_ID = MATERIAL_FURNITURE.MATERIAL_ID AND FURNITURE.FURNITURE_ID = MATERIAL_FURNITURE.FURNITURE_ID
GROUP BY MATERIAL.MATERIALNAME, MATERIAL.COST, FURNITURE.COMPONENTS
ORDER BY MATERIAL.COST DESC;

--7) Vypis jmen zakazniku, kteri si u teto spolecnosti uz vystavili objednavku
--v aplikaci toto bude slouzit pro rychly pristup k teto informaci
SELECT PERSON.PERSONNAME
FROM PERSON
WHERE EXISTS(
    SELECT ORDERCOST
    FROM THEORDER
    WHERE OrderCost > 0
)
AND EXISTS(
    SELECT *
    FROM BILL_ORDER_CUSTOMER
    WHERE ORDER_ID = ORDER_ID AND PERSON_ID = CUSTOMER_ID
);

--vypis zamestnancu
--Prikaz vypise tabulku zamestnancu v teto firme -> slozi pro rychlou orientaci mezi zamestnanci
SELECT *
FROM PERSON
WHERE PERSON_ID IN (
    SELECT WORKER_ID
    FROM ORDER_WORKER
    WHERE WORKER_ID is not null
);





--------------------- TRIGGERY ----------------


CREATE SEQUENCE Bill_ID_seq INCREMENT BY 1 START WITH 100002; -- musíme začít od 100002 protože v tabulce jsou již vytvořené prvky s ID's 100000 a 100001


CREATE OR REPLACE TRIGGER Bill_ID_trig
    BEFORE INSERT ON Bill
    FOR EACH ROW
    BEGIN
        :NEW.Bill_ID := Bill_ID_seq.NEXTVAL;
    END;
/

CREATE OR REPLACE TRIGGER MATERIAL_FURNITURE_TRIG
    AFTER INSERT OR UPDATE ON MATERIAL_FURNITURE
    FOR EACH ROW
    DECLARE ID INT;
    BEGIN
        SELECT MATERIAL_ID
        INTO ID
        FROM MATERIAL
        WHERE MATERIAL_ID = :NEW.MATERIAL_ID;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
        INSERT INTO Material (MATERIAL_ID, MaterialName, Cost, Amount, Supplier) VALUES (:NEW.MATERIAL_ID,'unknown',0,0,'unknown');
    END;
/
CREATE OR REPLACE TRIGGER MATERIAL_FURNITURE_TRIG2
    AFTER INSERT OR UPDATE ON MATERIAL_FURNITURE
    FOR EACH ROW
    DECLARE ID INT;
    BEGIN
        SELECT FURNITURE_ID
        INTO ID
        FROM FURNITURE
        WHERE FURNITURE_ID = :NEW.FURNITURE_ID;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
        INSERT INTO Furniture (Furniture_ID, Color, FurnitureSize, Components) VALUES (:NEW.FURNITURE_ID,'unknown','unknown','unknown');
    END;
/

--show errors; lze použík k zištění errorů když něco spadne.. pretty handy
-------------------------------------------


-- DEMONSTRATION
INSERT INTO MATERIAL_FURNITURE (Material_Furniture_PK, Material_ID, Furniture_ID) VALUES (15,15,150);



select * from MATERIAL_FURNITURE; -- měla by obsahovat nový prvek s ID:15 MATERIAL_ID:15 a Furniture_ID:150
select * from material; -- Měl být založen nový Material s ID: 15
select * from furniture; -- Měl být založen nový Furniture s ID: 150


INSERT INTO Bill (FinalCost, WorkedHours) VALUES (100,2);
INSERT INTO Bill (FinalCost, WorkedHours) VALUES (999999,666);

select * from bill; -- Měla by obsahovat dva nové Bills s novými ID's



--------------------- EXPLAIN PLAN ----------------

EXPLAIN PLAN FOR
SELECT MATERIAL.MATERIALNAME, COUNT(*) AS material_Count, SUM(material.AMOUNT) AS final_Amount_Sum, SUM(MATERIAL.COST)
FROM MATERIAL_FURNITURE, MATERIAL, ORDER_FURNITURE
WHERE ORDER_FURNITURE.FURNITURE_ID = MATERIAL_FURNITURE.FURNITURE_ID AND  MATERIAL_FURNITURE.MATERIAL_ID = MATERIAL.MATERIAL_ID
GROUP BY MATERIAL.MATERIALNAME;

select * from table(dbms_xplan.display);

CREATE INDEX MATERIAL_idx
ON MATERIAL(COST, AMOUNT, MATERIALNAME, MATERIAL_ID);

--CREATE INDEX MATERIAL_FURNITURE_idx
--ON MATERIAL_FURNITURE(FURNITURE_ID, MATERIAL_ID);

EXPLAIN PLAN FOR
SELECT MATERIAL.MATERIALNAME, COUNT(*) AS material_Count, SUM(material.AMOUNT) AS final_Amount_Sum, SUM(MATERIAL.COST)
FROM MATERIAL_FURNITURE, MATERIAL, ORDER_FURNITURE
WHERE ORDER_FURNITURE.FURNITURE_ID = MATERIAL_FURNITURE.FURNITURE_ID AND  MATERIAL_FURNITURE.MATERIAL_ID = MATERIAL.MATERIAL_ID
GROUP BY MATERIAL.MATERIALNAME;

select * from table(dbms_xplan.display);


DROP INDEX MATERIAL_idx;
--DROP INDEX MATERIAL_FURNITURE_idx;

----- INNER + FULL OUTER JOIN ---- pro porovnani druhu spojení jakoze (použitých prostředků pro jeho urychlení)

--takze toto slouzi pro porovnani druhu spojeni == nas prostredek pro urychleni

EXPLAIN PLAN FOR
SELECT MATERIAL.MATERIALNAME, COUNT(*) AS material_Count, SUM(material.AMOUNT) AS final_Amount_Sum, SUM(MATERIAL.COST)
FROM ((MATERIAL_FURNITURE
INNER JOIN MATERIAL ON MATERIAL_FURNITURE.MATERIAL_ID = MATERIAL.MATERIAL_ID)
INNER JOIN ORDER_FURNITURE ON ORDER_FURNITURE.FURNITURE_ID = MATERIAL_FURNITURE.FURNITURE_ID)
GROUP BY MATERIAL.MATERIALNAME;


select * from table(dbms_xplan.display);


EXPLAIN PLAN FOR
SELECT MATERIAL.MATERIALNAME, COUNT(*) AS material_Count, SUM(material.AMOUNT) AS final_Amount_Sum, SUM(MATERIAL.COST)
FROM ((MATERIAL_FURNITURE
FULL OUTER JOIN MATERIAL ON MATERIAL_FURNITURE.MATERIAL_ID = MATERIAL.MATERIAL_ID)
FULL OUTER JOIN ORDER_FURNITURE ON ORDER_FURNITURE.FURNITURE_ID = MATERIAL_FURNITURE.FURNITURE_ID)
GROUP BY MATERIAL.MATERIALNAME;

select * from table(dbms_xplan.display);







---------------------  LE PROCEDURE -------------------
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE have_orders(ARBEITSNEHMER IN VARCHAR) AS
SPEC PERSON.SPECIALIZATION%TYPE;
ID PERSON.PERSON_ID%TYPE;
NAMEN PERSON.PERSONNAME%TYPE;
POCET NUMBER;

    CURSOR cursor_my IS
    SELECT PERSON_ID, PERSONNAME, SPECIALIZATION
    FROM PERSON
    JOIN ORDER_WORKER ON ORDER_WORKER.WORKER_ID = PERSON.PERSON_ID
    WHERE PERSONNAME = ARBEITSNEHMER;
    BEGIN
        POCET := 0;
        OPEN cursor_my;
        LOOP
        FETCH cursor_my INTO ID, NAMEN, SPEC;
        EXIT WHEN cursor_my%NOTFOUND;
        POCET := POCET + 1;
        END LOOP;
        CLOSE cursor_my;

        DBMS_OUTPUT.PUT_LINE(ARBEITSNEHMER || ' pracuje na ' || POCET || ' zakazek.');
        EXCEPTION WHEN NO_DATA_FOUND THEN 
        BEGIN
            DBMS_OUTPUT.PUT_LINE('NOTHING FOUND');
        END;
    END;
    /



CREATE OR REPLACE PROCEDURE average_all_bills AS
PRUMER_CENA NUMBER;
PRUMER_HODINA NUMBER;
POCET_HODINA NUMBER;
POCET_CENA NUMBER;
POCET NUMBER;
POCET_HODIN NUMBER;
POCET_CEN NUMBER;

    CURSOR count_bills IS
    SELECT FINALCOST, WORKEDHOURS
    FROM BILL;
    BEGIN
        PRUMER_CENA := 0;
        PRUMER_HODINA := 0;
        POCET_HODINA := 0;
        POCET_CENA := 0;
        POCET_CEN := 0;
        POCET_HODIN := 0;
        POCET := 0;
        OPEN count_bills;
        LOOP
        FETCH count_bills INTO POCET_CENA, POCET_HODINA;
        EXIT WHEN count_bills%NOTFOUND;
        POCET_CEN := POCET_CEN + POCET_CENA;
        POCET_HODIN := POCET_HODIN + POCET_HODINA;
        POCET := POCET + 1;
        END LOOP;
        CLOSE count_bills;

        PRUMER_CENA := POCET_CEN / POCET;
        PRUMER_HODINA := POCET_HODIN / POCET;
        DBMS_OUTPUT.PUT_LINE('PRUMERNA CENA ZAKAZEK: ' || PRUMER_CENA || ' PRUMERNY CAS NA ZAKAZKACH: ' || PRUMER_HODINA);

        EXCEPTION WHEN ZERO_DIVIDE THEN 
        BEGIN
            DBMS_OUTPUT.PUT_LINE('NOTHING FOUND');
        END;
    END;
    /

---------------------- PROCEDURE -------------------------------
----------------- PROCEDURE DEMO -------------------------------
CALL have_orders('Otto Balgoz'); -- mel by najit 2 zakazky 
CALL have_orders('Klára Podřízková'); -- mel by najit 1 zakazku
SELECT FINALCOST, WORKEDHOURS FROM BILL;
CALL average_all_bills(); -- prumer cen a hodin vsech zakazek

-------------------- PROCEDURE DEMO ----------------------------





--------------------- GRANTING PRIVILEGES TO XKUZEL08 ---------- musi byt na konci, ale pred materalized view
GRANT ALL ON MATERIAL TO XKUZEL08;
GRANT ALL ON FURNITURE TO XKUZEL08;
GRANT ALL ON THEORDER TO XKUZEL08;
GRANT ALL ON PERSON TO XKUZEL08;
GRANT ALL ON BILL TO XKUZEL08;
GRANT ALL ON MATERIAL_FURNITURE TO XKUZEL08;
GRANT ALL ON ORDER_FURNITURE TO XKUZEL08;
GRANT ALL ON ORDER_WORKER TO XKUZEL08;
GRANT ALL ON BILL_ORDER_CUSTOMER TO XKUZEL08;
GRANT ALL ON have_orders TO XKUZEL08;
GRANT ALL ON average_all_bills TO XKUZEL08;
-- GRAND materialized view
----------------------------------------------------------------

------------------------ MATERIALIZED VIEW ----------------------
DROP MATERIALIZED VIEW stable_person_view;

CREATE MATERIALIZED VIEW stable_person_view
BUILD IMMEDIATE
REFRESH ON COMMIT AS
SELECT XKVASN14.PERSON.PERSON_ID, XKVASN14.PERSON.PERSONNAME, XKVASN14.PERSON.SPECIALIZATION
FROM XKVASN14.PERSON 
JOIN XKVASN14.ORDER_WORKER ON XKVASN14.ORDER_WORKER.WORKER_ID = XKVASN14.PERSON.PERSON_ID
WHERE XKVASN14.ORDER_WORKER.ORDER_ID = 10000;

GRANT ALL ON stable_person_view TO XKUZEL08;
-----------------------------------------------------------------
------------------------ MATERIALIZED VIEW DEMO -----------------
SELECT * FROM stable_person_view;
UPDATE stable_person_view SET PERSONNAME = 'Blagagadanovich Zapalskijn' WHERE PERSON_ID = 1000; -- nebude provedena
SELECT * FROM stable_person_view;
-----------------------------------------------------------------




