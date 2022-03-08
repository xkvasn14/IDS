DROP TABLE Material CASCADE CONSTRAINTS;
DROP TABLE Furniture CASCADE CONSTRAINTS;
DROP TABLE TheOrder CASCADE CONSTRAINTS;
DROP TABLE Bill CASCADE CONSTRAINTS;
DROP TABLE Person CASCADE CONSTRAINTS;
DROP TABLE Material_Furniture CASCADE CONSTRAINTS;
DROP TABLE Bill_Order_Customer CASCADE CONSTRAINTS;
DROP TABLE Order_Furniture CASCADE CONSTRAINTS;
DROP TABLE Order_Worker CASCADE CONSTRAINTS;


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
Material_ID         int check (MATERIAL_ID between 0 and 99),
Furniture_ID        int check (FURNITURE_ID between 100 and 999),
FOREIGN KEY (Material_ID) REFERENCES Material (Material_ID),
FOREIGN KEY (Furniture_ID) REFERENCES Furniture (Furniture_ID)
);


CREATE TABLE Bill_Order_Customer(
Bill_ID             int check (Bill_ID between 100000 and 999999),
Order_ID            int check (Order_ID between 10000 and 99999),
Customer_ID         int check (Customer_ID between 1000 and 9999),
FOREIGN KEY (Bill_ID) REFERENCES Bill (Bill_ID),
FOREIGN KEY (Order_ID) REFERENCES TheOrder (Order_ID),
FOREIGN KEY (Customer_ID) REFERENCES Person (Person_ID)
);

CREATE TABLE Order_Furniture(
    ORDER_ID        int check (ORDER_ID between 10000 and 99999),
    Furniture_ID    int check (Furniture_ID between 100 and 999),
    FOREIGN KEY (Furniture_ID) REFERENCES Furniture (Furniture_ID),
    FOREIGN KEY (Order_ID) REFERENCES TheOrder (Order_ID)
);

CREATE TABLE Order_Worker(
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


INSERT INTO MATERIAL_FURNITURE (Material_ID, Furniture_ID) VALUES (2,100);
INSERT INTO MATERIAL_FURNITURE (Material_ID, Furniture_ID) VALUES (4,100);
INSERT INTO MATERIAL_FURNITURE (Material_ID, Furniture_ID) VALUES (3,100);
INSERT INTO MATERIAL_FURNITURE (Material_ID, Furniture_ID) VALUES (2,101);
INSERT INTO MATERIAL_FURNITURE (Material_ID, Furniture_ID) VALUES (6,101);
INSERT INTO MATERIAL_FURNITURE (Material_ID, Furniture_ID) VALUES (1,102);
INSERT INTO MATERIAL_FURNITURE (Material_ID, Furniture_ID) VALUES (5,103);
INSERT INTO MATERIAL_FURNITURE (Material_ID, Furniture_ID) VALUES (5,103);
INSERT INTO MATERIAL_FURNITURE (Material_ID, Furniture_ID) VALUES (2,103);
INSERT INTO MATERIAL_FURNITURE (Material_ID, Furniture_ID) VALUES (4,104);
INSERT INTO MATERIAL_FURNITURE (Material_ID, Furniture_ID) VALUES (6,104);
INSERT INTO MATERIAL_FURNITURE (Material_ID, Furniture_ID) VALUES (1,104);


INSERT INTO Bill_Order_Customer (Bill_id, Order_ID, Customer_ID) VALUES (100000,10000,1005);
INSERT INTO Bill_Order_Customer (Bill_id, Order_ID, Customer_ID) VALUES (100000,10001,1005);
INSERT INTO Bill_Order_Customer (Bill_id, Order_ID, Customer_ID) VALUES (100001,10002,1004);
INSERT INTO Bill_Order_Customer (Bill_id, Order_ID, Customer_ID) VALUES (100001,10003,1004);


INSERT INTO Order_Furniture (Order_ID, Furniture_ID) VALUES (10000, 100);
INSERT INTO Order_Furniture (Order_ID, Furniture_ID) VALUES (10000, 101);
INSERT INTO Order_Furniture (Order_ID, Furniture_ID) VALUES (10001, 102);
INSERT INTO Order_Furniture (Order_ID, Furniture_ID) VALUES (10001, 103);
INSERT INTO Order_Furniture (Order_ID, Furniture_ID) VALUES (10001, 104);


INSERT INTO Order_Worker(Order_ID, Worker_ID, ISMAINWORKER) VALUES (10000,1000,0);
INSERT INTO Order_Worker(Order_ID, Worker_ID, ISMAINWORKER) VALUES (10000,1002,1);
INSERT INTO Order_Worker(Order_ID, Worker_ID, ISMAINWORKER) VALUES (10001,1000,0);
INSERT INTO Order_Worker(Order_ID, Worker_ID, ISMAINWORKER) VALUES (10001,1001,0);
INSERT INTO Order_Worker(Order_ID, Worker_ID, ISMAINWORKER) VALUES (10001,1003,1);