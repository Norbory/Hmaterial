IF OBJECT_ID('dbo.SALE_DETAIL', 'U') IS NOT NULL   
  DROP TABLE dbo.SALE_DETAIL 
GO
IF OBJECT_ID('dbo.STORE_PRODUCT', 'U') IS NOT NULL 
  DROP TABLE dbo.STORE_PRODUCT 
GO  
IF OBJECT_ID('dbo.SALE', 'U') IS NOT NULL
	DROP TABLE dbo.SALE
GO
IF OBJECT_ID('dbo.SALESMAN', 'U') IS NOT NULL
	DROP TABLE dbo.SALESMAN
GO
IF OBJECT_ID('dbo.STORE', 'U') IS NOT NULL
	DROP TABLE dbo.STORE
GO
IF OBJECT_ID('dbo.CUSTOMER', 'U') IS NOT NULL
	DROP TABLE dbo.CUSTOMER
GO
IF OBJECT_ID('dbo.BOOK_PRODUCT', 'U') IS NOT NULL
	DROP TABLE dbo.BOOK_PRODUCT
GO
IF OBJECT_ID('dbo.ELECTRONIC_PRODUCT', 'U') IS NOT NULL
	DROP TABLE dbo.ELECTRONIC_PRODUCT
GO
IF OBJECT_ID('dbo.PRODUCT', 'U') IS NOT NULL
	DROP TABLE dbo.PRODUCT
GO
IF OBJECT_ID('dbo.ADMINISTRATOR', 'U') IS NOT NULL
	DROP TABLE dbo.ADMINISTRATOR
GO
IF OBJECT_ID('dbo.SALES_USER', 'U') IS NOT NULL
	DROP TABLE dbo.SALES_USER
GO
CREATE TABLE SALES_USER (
	id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	username VARCHAR(100) UNIQUE NOT NULL,
	password VARCHAR(100) NOT NULL,
	first_name VARCHAR(100) NOT NULL,
	last_name VARCHAR(100) NOT NULL,
	gender CHAR(1) NULL
)
GO
CREATE TABLE CUSTOMER (
	id INT NOT NULL PRIMARY KEY,
	address VARCHAR(150) NULL,
	phone_number VARCHAR(50) NULL,
	email VARCHAR(150) NOT NULL UNIQUE,
	document_type CHAR(1) NOT NULL,
	document_number VARCHAR(11) NOT NULL UNIQUE,
	legal_department VARCHAR(100) NULL,
	web_page VARCHAR(250) NULL,
	company_name VARCHAR(250) NULL,
	birthday DATE NULL,
	status CHAR(1) NULL
)
GO
ALTER TABLE CUSTOMER
ADD CONSTRAINT FK_CUSTOMER_USER_ID FOREIGN KEY (id)
REFERENCES SALES_USER(id)
ON DELETE CASCADE
GO
CREATE TABLE ADMINISTRATOR (
	id INT NOT NULL PRIMARY KEY,
	employees_number INT NULL,
	department VARCHAR(150) NULL,
	status CHAR(1) NULL
)
GO
ALTER TABLE ADMINISTRATOR
ADD CONSTRAINT FK_ADMINISTRATOR_USER_ID FOREIGN KEY (id)
REFERENCES SALES_USER(id)
ON DELETE CASCADE
GO
CREATE TABLE STORE (
	id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	name VARCHAR(150) NULL,
	address VARCHAR (150) NULL,
	postal_code VARCHAR(50) NULL,
	status CHAR(1) NULL
)
GO
CREATE TABLE SALESMAN (
	id INT NOT NULL PRIMARY KEY,
	salary DECIMAL(10, 2) NOT NULL,
	quota DECIMAL(10, 2) NOT NULL,
	status CHAR(1) NULL,
	store_id INT NULL
)
GO
ALTER TABLE SALESMAN
ADD CONSTRAINT FK_SALESMAN_USER_ID FOREIGN KEY (id)
REFERENCES SALES_USER(id)
ON DELETE CASCADE
GO
ALTER TABLE SALESMAN
ADD CONSTRAINT FK_SALESMAN_STORE_ID FOREIGN KEY (store_id)
REFERENCES STORE(id)
ON DELETE CASCADE
GO
CREATE TABLE PRODUCT(
	id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	name VARCHAR(250) NOT NULL,
	description VARCHAR(500) NOT NULL,
	price DECIMAL(10, 2) NOT NULL,
	stock INT NOT NULL,
	status CHAR(1) NULL,
	photo IMAGE NULL
)
GO
CREATE TABLE BOOK_PRODUCT(
	id INT NOT NULL PRIMARY KEY,
	author VARCHAR(250) NULL,
	title VARCHAR(250) NOT NULL,
	edition VARCHAR(50) NULL,
	editorial VARCHAR(150) NULL,
	year VARCHAR(4) NULL
)
GO
CREATE TABLE ELECTRONIC_PRODUCT(
	id INT NOT NULL PRIMARY KEY,
	brand VARCHAR(250) NULL,
	family VARCHAR(250) NOT NULL,
	model VARCHAR(50) NULL,
	warranty INT NULL
)
GO
ALTER TABLE BOOK_PRODUCT
ADD CONSTRAINT FK_BOOK_PRODUCT_ID FOREIGN KEY (id)
REFERENCES PRODUCT(id)
ON DELETE CASCADE
GO
ALTER TABLE ELECTRONIC_PRODUCT
ADD CONSTRAINT FK_ELECTRONIC_PRODUCT_ID FOREIGN KEY (id)
REFERENCES PRODUCT(id)
ON DELETE CASCADE
GO
CREATE TABLE STORE_PRODUCT(
	id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	stock INT NOT NULL,
	min_stock INT NOT NULL,
	discount DECIMAL(10,2) NULL,
	store_id INT NOT NULL,
	product_id INT NOT NULL
)
GO
ALTER TABLE STORE_PRODUCT
ADD CONSTRAINT FK_STORE_PRODUCT_STORE_ID FOREIGN KEY (store_id)
REFERENCES STORE(id)
ON DELETE CASCADE
GO
ALTER TABLE STORE_PRODUCT
ADD CONSTRAINT FK_STORE_PRODUCT_PRODUCT_ID FOREIGN KEY (product_id)
REFERENCES PRODUCT(id)
ON DELETE CASCADE
GO
CREATE TABLE SALE(
	id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	total DECIMAL(10, 2) NOT NULL,
	status CHAR(1) NULL,
	transaction_date DATE NOT NULL,
	customer_id INT NOT NULL,
	salesman_id INT NULL,
	store_id INT NULL
)
GO
ALTER TABLE SALE
ADD CONSTRAINT FK_SALE_CUSTOMER_ID FOREIGN KEY (customer_id)
REFERENCES CUSTOMER(id)
ON DELETE CASCADE
GO
ALTER TABLE SALE
ADD CONSTRAINT FK_SALE_SALESMAN_ID FOREIGN KEY (salesman_id)
REFERENCES SALESMAN(id)
ON DELETE NO ACTION
GO
ALTER TABLE SALE
ADD CONSTRAINT FK_SALE_STORE_ID FOREIGN KEY (store_id)
REFERENCES STORE(id)
ON DELETE CASCADE
GO
CREATE TABLE SALE_DETAIL (
	id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	sale_id INT NOT NULL,
	store_product_id INT NOT NULL,
	quantity INT NULL,
	subtotal DECIMAL(10,2) NULL
)
GO
ALTER TABLE SALE_DETAIL
ADD CONSTRAINT FK_SALE_DETAIL_SALE_ID FOREIGN KEY (sale_id)
REFERENCES SALE(id)
ON DELETE CASCADE
GO
ALTER TABLE SALE_DETAIL
ADD CONSTRAINT FK_SALE_DETAIL_STORE_PRODUCT_ID FOREIGN KEY (store_product_id)
REFERENCES STORE_PRODUCT(id)
GO
INSERT INTO SALES_USER
(username, password, first_name, last_name, gender)
VALUES ('jbaldeon', 'password', 'Johan', 'Baldeon', 'M')
GO
INSERT INTO SALES_USER
(username, password, first_name, last_name, gender)
VALUES ('gpalacios', 'password', 'Gian', 'Palacios', 'M')
GO
INSERT INTO SALES_USER
(username, password, first_name, last_name, gender)
VALUES ('equino', 'password', 'Edu', 'Quino', 'M')
GO
INSERT INTO SALESMAN
(id, salary, quota, status)
VALUES (1, 4500, 50000, 'A')
GO
INSERT INTO SALESMAN
(id, salary, quota, status)
VALUES (2, 5500, 70000, 'A')
GO
INSERT INTO SALESMAN
(id, salary, quota, status)
VALUES (3, 6500, 100000, 'A')
GO
INSERT INTO SALES_USER
(username, password, first_name, last_name, gender)
VALUES ('zoilabaca', 'password', 'Zoila', 'Baca', 'F')
GO
INSERT INTO CUSTOMER(id, address, phone_number, email, document_type,
document_number, birthday)
VALUES (4, 'Calle Los Maestros 123, San Borja', '123456789', 'zoila.baca@gmail.com', '1', '12345678', '1980-06-03')
GO
INSERT INTO SALES_USER
(username, password, first_name, last_name, gender)
VALUES ('armandoparedes', 'password', 'Armando', 'Paredes', 'M')
GO
INSERT INTO CUSTOMER(id, address, phone_number, email, document_type,
document_number, birthday)
VALUES (5, 'Elm Street 666, Villa Salvaje', '666666666', 'armando.paredes@gmail.com', '1', '66666666', '1966-06-06')
GO
INSERT INTO SALES_USER
(username, password, first_name, last_name, gender)
VALUES ('fkrugger', 'password', 'Freddy', 'Krugger', 'M')
GO
INSERT INTO CUSTOMER(id, company_name, address, phone_number, email, document_type,
document_number, legal_department, web_page, status)
VALUES (6, 'ABC', 'Los Mecatr�nicos 999, San Miguel', '01666666', 'contact@abc.com', '2', '32132132132', 'Jose P�rez', 'www.abc.com', 'A')
GO
--UPDATE CUSTOMER
--SET legal_department='Domingo P�rez'
--WHERE id=3
--GO
--DELETE FROM CUSTOMER
--WHERE id=3
GO
INSERT INTO STORE(name, address, postal_code)
VALUES ('San Miguel', 'Av. La Marina 1230', '51203')
GO
INSERT INTO STORE(name, address, postal_code)
VALUES ('Puruchuco', 'Av. Carretera Central', '51205')
GO
IF EXISTS ( SELECT * 
            FROM   sysobjects 
            WHERE  id = object_id(N'[dbo].[usp_QueryAllStores]') 
                   and OBJECTPROPERTY(id, N'IsProcedure') = 1 )
BEGIN
    DROP PROCEDURE [dbo].[usp_QueryAllStores]
END
GO
CREATE PROCEDURE dbo.usp_QueryAllStores
AS
	SELECT *
	FROM STORE
	ORDER BY name
GO
IF EXISTS ( SELECT * 
            FROM   sysobjects 
            WHERE  id = object_id(N'[dbo].[usp_AddBook]') 
                   and OBJECTPROPERTY(id, N'IsProcedure') = 1 )
BEGIN
    DROP PROCEDURE [dbo].[usp_AddBook]
END
GO
CREATE PROCEDURE dbo.usp_AddBook(
	@name VARCHAR(250),
	@title VARCHAR(250),
	@author VARCHAR(250),
	@description VARCHAR(500),
	@price DECIMAL(10,2),
	@stock INT,
	@edition VARCHAR(50),
	@editorial VARCHAR(150),
	@year VARCHAR(4),
	@photo IMAGE,
	@id INT OUT
 ) AS 
	BEGIN
		INSERT INTO PRODUCT(name, description, price, stock, status, photo)
		SELECT @name, @description, @price, @stock, 'A', @photo
		SET @id = SCOPE_IDENTITY()	
	
		INSERT INTO BOOK_PRODUCT(id, author, title, edition, editorial, year)
		SELECT @id, @author, @title, @edition, @editorial, @year
	END
GO
IF EXISTS ( SELECT * 
            FROM   sysobjects 
            WHERE  id = object_id(N'[dbo].[usp_UpdateBook]') 
                   and OBJECTPROPERTY(id, N'IsProcedure') = 1 )
BEGIN
    DROP PROCEDURE [dbo].[usp_UpdateBook]
END
GO
CREATE PROCEDURE dbo.usp_UpdateBook(
	@name VARCHAR(250),
	@title VARCHAR(250),
	@author VARCHAR(250),
	@description VARCHAR(500),
	@price DECIMAL(10,2),
	@stock INT,
	@edition VARCHAR(50),
	@editorial VARCHAR(150),
	@year VARCHAR(4),
	@status CHAR(1),
	@photo IMAGE,
	@id INT
 ) AS 
	BEGIN
		UPDATE PRODUCT
		SET name=@name, description=@description, price=@price, stock=@stock, status=@status, photo=@photo
		WHERE id = @id	
	
		UPDATE BOOK_PRODUCT
		SET author=@author, title=@title, edition=@edition, editorial=@editorial, year=@year
		WHERE id=@id 
	END
GO
IF EXISTS ( SELECT * 
            FROM   sysobjects 
            WHERE  id = object_id(N'[dbo].[usp_DeleteProduct]') 
                   and OBJECTPROPERTY(id, N'IsProcedure') = 1 )
BEGIN
    DROP PROCEDURE [dbo].[usp_DeleteProduct]
END
GO
CREATE PROCEDURE dbo.usp_DeleteProduct(
	@id INT
 ) AS 
	BEGIN
		UPDATE PRODUCT
		SET status='I'
		WHERE id = @id	
	END
GO

IF EXISTS ( SELECT * 
            FROM   sysobjects 
            WHERE  id = object_id(N'[dbo].[usp_AddElectronic]') 
                   and OBJECTPROPERTY(id, N'IsProcedure') = 1 )
BEGIN
    DROP PROCEDURE [dbo].[usp_AddElectronic]
END
GO
CREATE PROCEDURE dbo.usp_AddElectronic(
	@name VARCHAR(250),
	@description VARCHAR(500),
	@price DECIMAL(10,2),
	@stock INT,
	@brand VARCHAR(250),
	@family VARCHAR(250),
	@model VARCHAR(50),
	@warranty INT,
	@photo IMAGE,
	@id INT OUT
 ) AS 
	BEGIN
		INSERT INTO PRODUCT(name, description, price, stock, status, photo)
		SELECT @name, @description, @price, @stock, 'A', @photo
		SET @id = SCOPE_IDENTITY()	
	
		INSERT INTO ELECTRONIC_PRODUCT(id, brand, family, model, warranty)
		SELECT @id, @brand, @family, @model, @warranty
	END
GO
DECLARE @new_identity INT
EXEC dbo.usp_AddBook @name = 'Best Seller', @title='La Magia del Orden', @author='Marie Kondo', @description='Libro de autoayuda', @price=50, @stock=100, @edition='First Edition', @editorial='Planeta', @year='2015', @photo=NULL, @id= @new_identity OUTPUT
EXEC dbo.usp_AddBook @name = 'Best Seller', @title='Historia de los Incas', @author='Blas Valera', @description='Libro escrito entre 1620 a 1630', @price=100, @stock=50, @edition='First Edition', @editorial='Planeta', @year='1991', @photo=NULL, @id = @new_identity OUTPUT	
EXEC dbo.usp_AddBook @name = 'Best Seller', @title='Star Wars', @author='George Lucas',@description='Adventure book', @price=60, @stock=70, @edition='Second Edition', @editorial='Planeta', @year='1990',@photo=NULL, @id= @new_identity OUTPUT
EXEC dbo.usp_AddElectronic @name = 'TV 60', @description='TV de 60 pulgadas', @price=3000, @stock=30, @brand='PHILLIPS', @family='LED', @model='LVC123456', @warranty= 12, @photo=NULL, @id= @new_identity OUTPUT
EXEC dbo.usp_AddElectronic @name = 'TV 50', @description='TV de 50 pulgadas', @price=2000, @stock=38, @brand='SOPY', @family='LED', @model='SOP345712', @warranty= 12, @photo=NULL, @id= @new_identity OUTPUT
EXEC dbo.usp_AddElectronic @name = 'PONYSTATION 5', @description='Consola de videojuegos', @price=2000, @stock=28, @brand='SOPY', @family='Entertainment', @model='PS324234', @warranty= 12, @photo=NULL, @id= @new_identity OUTPUT	
GO
IF EXISTS ( SELECT * 
            FROM   sysobjects 
            WHERE  id = object_id(N'[dbo].[usp_UpdateElectronic]') 
                   and OBJECTPROPERTY(id, N'IsProcedure') = 1 )
BEGIN
    DROP PROCEDURE [dbo].[usp_UpdateElectronic]
END
GO
CREATE PROCEDURE dbo.usp_UpdateElectronic(
	@id INT,
	@name VARCHAR(250),
	@description VARCHAR(500),
	@price DECIMAL(10,2),
	@stock INT,
	@brand VARCHAR(250),
	@family VARCHAR(250),	
	@model VARCHAR(50),
	@warranty INT,
	@status CHAR(1),
	@photo IMAGE
 ) AS 
	BEGIN
		UPDATE PRODUCT
		SET name=@name, description=@description, price=@price, stock=@stock, status='A', photo=@photo
		WHERE id = @id	
	
		UPDATE ELECTRONIC_PRODUCT
		SET brand=@brand, family=@family, model=@model, warranty=@warranty
		WHERE id=@id 
	END
GO
IF EXISTS ( SELECT * 
            FROM   sysobjects 
            WHERE  id = object_id(N'[dbo].[usp_QueryAllBooks]') 
                   and OBJECTPROPERTY(id, N'IsProcedure') = 1 )
BEGIN
    DROP PROCEDURE [dbo].[usp_QueryAllBooks]
END
GO
CREATE PROCEDURE dbo.usp_QueryAllBooks
AS
	SELECT * 
	FROM PRODUCT p, BOOK_PRODUCT bp
	WHERE p.id = bp.id AND p.status='A'
	ORDER BY title
GO
IF EXISTS ( SELECT * 
            FROM   sysobjects 
            WHERE  id = object_id(N'[dbo].[usp_QueryBookById]') 
                   and OBJECTPROPERTY(id, N'IsProcedure') = 1 )
BEGIN
    DROP PROCEDURE [dbo].[usp_QueryBookById]
END
GO
CREATE PROCEDURE dbo.usp_QueryBookById(@id INT)
AS
	SELECT * 
	FROM PRODUCT p, BOOK_PRODUCT bp
	WHERE p.id= @id AND p.id = bp.id
GO				
IF EXISTS ( SELECT * 
            FROM   sysobjects 
            WHERE  id = object_id(N'[dbo].[usp_QueryAllElectronics]') 
                   and OBJECTPROPERTY(id, N'IsProcedure') = 1 )
BEGIN
    DROP PROCEDURE [dbo].[usp_QueryAllElectronics]
END
GO
CREATE PROCEDURE dbo.usp_QueryAllElectronics
AS
	SELECT * FROM PRODUCT p, ELECTRONIC_PRODUCT bp
	WHERE p.id = bp.id AND p.status='A'
	ORDER BY name
GO		
IF EXISTS ( SELECT * 
            FROM   sysobjects 
            WHERE  id = object_id(N'[dbo].[usp_QueryElectronicById]') 
                   and OBJECTPROPERTY(id, N'IsProcedure') = 1 )
BEGIN
    DROP PROCEDURE [dbo].[usp_QueryElectronicById]
END
GO
CREATE PROCEDURE dbo.usp_QueryElectronicById(@id INT)
AS
	SELECT * FROM PRODUCT p, ELECTRONIC_PRODUCT bp
	WHERE p.id = @id AND p.id = bp.id
GO	
IF EXISTS ( SELECT * 
            FROM   sysobjects 
            WHERE  id = object_id(N'[dbo].[usp_AddStoreProduct]') 
                   and OBJECTPROPERTY(id, N'IsProcedure') = 1 )
BEGIN
    DROP PROCEDURE [dbo].[usp_AddStoreProduct]
END
GO
CREATE PROCEDURE dbo.usp_AddStoreProduct(
	@product_id INT,
	@store_id INT,
	@stock INT,
	@min_stock INT,
	@discount DECIMAL(10,2),
	@id INT OUT
) AS
	BEGIN
		INSERT INTO STORE_PRODUCT(stock, min_stock, discount, store_id, product_id)
		SELECT @stock, @min_stock, @discount, @store_id, @product_id
		
		SET @id = SCOPE_IDENTITY()
	END
GO
DECLARE @new_identity INT
EXEC dbo.usp_AddStoreProduct @product_id=1, @store_id=1, @stock=60, @min_stock=5, @discount=0, @id=@new_identity OUTPUT 
EXEC dbo.usp_AddStoreProduct @product_id=1, @store_id=2, @stock=40, @min_stock=5, @discount=0, @id=@new_identity OUTPUT 
EXEC dbo.usp_AddStoreProduct @product_id=2, @store_id=1, @stock=30, @min_stock=5, @discount=0.1, @id=@new_identity OUTPUT
EXEC dbo.usp_AddStoreProduct @product_id=2, @store_id=2, @stock=20, @min_stock=5, @discount=0.2, @id=@new_identity OUTPUT 	
EXEC dbo.usp_AddStoreProduct @product_id=3, @store_id=1, @stock=35, @min_stock=5, @discount=0.1, @id=@new_identity OUTPUT
EXEC dbo.usp_AddStoreProduct @product_id=3, @store_id=2, @stock=35, @min_stock=5, @discount=0.1, @id=@new_identity OUTPUT 	
EXEC dbo.usp_AddStoreProduct @product_id=4, @store_id=1, @stock=15, @min_stock=4, @discount=0.5, @id=@new_identity OUTPUT 	
EXEC dbo.usp_AddStoreProduct @product_id=4, @store_id=2, @stock=15, @min_stock=4, @discount=0, @id=@new_identity OUTPUT 	
EXEC dbo.usp_AddStoreProduct @product_id=5, @store_id=1, @stock=19, @min_stock=4, @discount=0.1, @id=@new_identity OUTPUT 	
EXEC dbo.usp_AddStoreProduct @product_id=5, @store_id=2, @stock=19, @min_stock=4, @discount=0, @id=@new_identity OUTPUT 	
EXEC dbo.usp_AddStoreProduct @product_id=6, @store_id=1, @stock=10, @min_stock=5, @discount=0, @id=@new_identity OUTPUT 	
EXEC dbo.usp_AddStoreProduct @product_id=6, @store_id=2, @stock=18, @min_stock=5, @discount=0.20, @id=@new_identity OUTPUT 	

GO

IF EXISTS ( SELECT * 
            FROM   sysobjects 
            WHERE  id = object_id(N'[dbo].[usp_QueryAllBooksFromStore]') 
                   and OBJECTPROPERTY(id, N'IsProcedure') = 1 )
BEGIN
    DROP PROCEDURE [dbo].[usp_QueryAllBooksFromStore]
END
GO
--Stored procedure para consultar los libros de una tienda:
CREATE PROCEDURE dbo.usp_QueryAllBooksFromStore (
	@store_id INT
)
AS
	SELECT sp.id AS ID, s.id AS STORE_ID, s.name AS STORE_NAME, s.address AS ADDRESS, s.postal_code AS POSTAL_CODE, p.id AS PRODUCT_ID, p.name AS NAME, p.description AS DESCRIPTION, p.stock AS STOCK_TOTAL, p.price AS PRICE, bp.title AS TITLE, bp.author AS AUTHOR, bp.edition AS EDITION, bp.editorial AS EDITORIAL, bp.year AS YEAR, sp.discount AS DISCOUNT, sp.stock AS STOCK, sp.min_stock AS MIN_STOCK
	FROM STORE s, PRODUCT p, STORE_PRODUCT sp, BOOK_PRODUCT bp
	WHERE 	s.id=@store_id AND
		s.id = sp.store_id AND
		sp.product_id = p.id AND
		p.id = bp.id
GO
--EXEC dbo.usp_QueryAllBooksFromStore @store_id=1
--GO	
IF EXISTS ( SELECT * 
            FROM   sysobjects 
            WHERE  id = object_id(N'[dbo].[usp_QueryBookFromStoreByStoreId]') 
                   and OBJECTPROPERTY(id, N'IsProcedure') = 1 )
BEGIN
    DROP PROCEDURE [dbo].[usp_QueryBookFromStoreByStoreId]
END
GO
--Stored procedure para obtener los datos de un libro de una tienda
CREATE PROCEDURE dbo.usp_QueryBookFromStoreByStoreId (
	@store_id INT,
	@product_id INT
)
AS
	SELECT s.name AS STORE_NAME, sp.id AS STORE_PRODUCT_ID, bp.title AS TITLE, bp.author AS AUTHOR, p.description AS DESCRIPTION, p.price AS PRICE, p.price*(1-sp.discount) AS PRICE_AFTER_DISCOUNT, sp.stock AS STOCK
	FROM STORE s, PRODUCT p, STORE_PRODUCT sp, BOOK_PRODUCT bp
	WHERE s.id = @store_id AND
		p.id = @product_id AND
		s.id = sp.store_id AND
		sp.product_id = p.id AND
		p.id = bp.id
GO
--EXEC dbo.usp_QueryBookFromStoreByStoreId @store_id=1, @product_id=1
IF EXISTS ( SELECT * 
            FROM   sysobjects 
            WHERE  id = object_id(N'[dbo].[usp_QueryAllElectronicsFromStore]') 
                   and OBJECTPROPERTY(id, N'IsProcedure') = 1 )
BEGIN
    DROP PROCEDURE [dbo].[usp_QueryAllElectronicsFromStore]
END
GO
--Stored procedure para consultar los productos electr�nicos de una tienda:
CREATE PROCEDURE dbo.usp_QueryAllElectronicsFromStore (
	@store_id INT
)
AS
	SELECT sp.id AS ID, s.id AS STORE_ID, s.name AS STORE_NAME, s.address AS ADDRESS, s.postal_code AS POSTAL_CODE, p.id AS PRODUCT_ID, p.name AS NAME, p.description AS DESCRIPTION, p.stock AS STOCK_TOTAL, ep.brand AS BRAND, ep.family AS FAMILY, ep.model AS MODEL, p.price AS PRICE, sp.discount AS DISCOUNT, sp.stock AS STOCK, sp.min_stock AS MIN_STOCK
	FROM STORE s, PRODUCT p, STORE_PRODUCT sp, ELECTRONIC_PRODUCT ep
	WHERE 	s.id=@store_id AND
		s.id = sp.store_id AND
		sp.product_id = p.id AND
		p.id = ep.id
GO
--EXEC dbo.usp_QueryAllElectronicsFromStore @store_id=1
IF EXISTS ( SELECT * 
            FROM   sysobjects 
            WHERE  id = object_id(N'[dbo].[usp_QueryElectronicFromStoreByStoreId]') 
                   and OBJECTPROPERTY(id, N'IsProcedure') = 1 )
BEGIN
    DROP PROCEDURE [dbo].[usp_QueryElectronicFromStoreByStoreId]
END
GO
--Stored procedure para obtener los datos de un producto electr�nico de una tienda
CREATE PROCEDURE dbo.usp_QueryElectronicFromStoreByStoreId (
	@store_id INT,
	@product_id INT
)
AS
	SELECT s.name AS STORE_NAME, p.id AS PRODUCT_ID, p.name AS NAME, ep.family AS FAMILY, ep.model AS MODEL, p.description AS DESCRIPTION, p.price AS PRICE, p.price*(1-sp.discount) AS PRICE_AFTER_DISCOUNT, sp.stock AS STOCK
	FROM STORE s, PRODUCT p, STORE_PRODUCT sp, ELECTRONIC_PRODUCT ep
	WHERE s.id = @store_id AND
		p.id = @product_id AND
		s.id = sp.store_id AND
		p.id = sp.product_id AND
		p.id = ep.id
GO
--EXEC dbo.usp_QueryElectronicFromStoreByStoreId @store_id=2, @product_id=4
IF EXISTS ( SELECT * 
            FROM   sysobjects 
            WHERE  id = object_id(N'[dbo].[usp_AddSalesman]') 
                   and OBJECTPROPERTY(id, N'IsProcedure') = 1 )
BEGIN
    DROP PROCEDURE [dbo].[usp_AddSalesman]
END
GO
CREATE PROCEDURE dbo.usp_AddSalesman(
	@username VARCHAR(100),
	@password VARCHAR(100),
	@first_name VARCHAR(100),
	@last_name VARCHAR(100),
	@gender CHAR(1),
	@salary DECIMAL(10,2),
	@quota DECIMAL(10,2),
	@store_id INT,
	@id INT OUT
) AS
	BEGIN
		INSERT INTO SALES_USER (username, password, first_name, last_name, gender)
		SELECT @username, @password, @first_name, @last_name, @gender

		SET @id = SCOPE_IDENTITY()

		INSERT INTO SALESMAN(id, salary, quota, store_id)
		SELECT @id, @salary, @quota, @store_id		
	END
GO
DECLARE @new_identity INT
EXEC dbo.usp_AddSalesman @username='lsuarez', @password='password', @first_name='LUIS', @last_name='SUAREZ', @gender='M', @salary=4800, @quota=35000, @store_id=1, @id=@new_identity OUTPUT 
EXEC dbo.usp_AddSalesman @username='lmezarina', @password='password', @first_name='LIONEL', @last_name='MEZARINA', @gender='M', @salary=5800, @quota=45000, @store_id=1, @id=@new_identity OUTPUT 
EXEC dbo.usp_AddSalesman @username='gpicon', @password='password', @first_name='GERARD', @last_name='PIC�N', @gender='M', @salary=6800, @quota=55000, @store_id=1, @id=@new_identity OUTPUT 
EXEC dbo.usp_AddSalesman @username='jlperales', @password='password', @first_name='JOSE LUIS', @last_name='PERALES', @gender='M', @salary=5600, @quota=49000, @store_id=2, @id=@new_identity OUTPUT 
EXEC dbo.usp_AddSalesman @username='csesto', @password='password', @first_name='CAMILO', @last_name='SESTO', @gender='M', @salary=4500, @quota=47000, @store_id=2, @id=@new_identity OUTPUT 
GO
IF EXISTS ( SELECT * 
            FROM   sysobjects 
            WHERE  id = object_id(N'[dbo].[usp_QueryAllSalesmen]') 
                   and OBJECTPROPERTY(id, N'IsProcedure') = 1 )
BEGIN
    DROP PROCEDURE [dbo].[usp_QueryAllSalesmen]
END
GO
CREATE PROCEDURE dbo.usp_QueryAllSalesmen
AS
	SELECT SU.username as username, SU.first_name as first_name, SU.last_name as last_name, SU.gender as gender, 
			S.salary as salary, S.quota as quota, ST.name
	FROM SALESMAN S
	INNER JOIN SALES_USER SU ON SU.id = S.id
	INNER JOIN STORE ST ON ST.id = S.store_id
	ORDER BY SU.last_name
GO
--EXEC dbo.usp_QueryAllSalesmen
IF EXISTS ( SELECT * 
            FROM   sysobjects 
            WHERE  id = object_id(N'[dbo].[usp_QueryAllSalesmenByStore]') 
                   and OBJECTPROPERTY(id, N'IsProcedure') = 1 )
BEGIN
    DROP PROCEDURE [dbo].[usp_QueryAllSalesmenByStore]
END
GO
CREATE PROCEDURE dbo.usp_QueryAllSalesmenByStore(
	@store_id INT
)
AS
	SELECT SU.username as username, SU.first_name as first_name, SU.last_name as last_name, SU.gender as gender, 
			S.salary as salary, S.quota as quota, ST.name
	FROM SALESMAN S
	INNER JOIN SALES_USER SU ON SU.id = S.id
	INNER JOIN STORE ST ON ST.id = S.store_id
	WHERE ST.id = @store_id
	ORDER BY SU.last_name
GO		
--EXEC dbo.usp_QueryAllSalesmenByStore @store_id=1
IF EXISTS ( SELECT * 
            FROM   sysobjects 
            WHERE  id = object_id(N'[dbo].[usp_AddSale]') 
                   and OBJECTPROPERTY(id, N'IsProcedure') = 1 )
BEGIN
    DROP PROCEDURE [dbo].[usp_AddSale]
END
GO
CREATE PROCEDURE dbo.usp_AddSale(
	@total DECIMAL(10,2),
	@status CHAR(1),
	@transaction_date DATE,
	@customer_id INT,
	@salesman_id INT,
	@id INT OUT
) AS
	BEGIN
		INSERT INTO SALE(total, status, transaction_date, customer_id, salesman_id)
		SELECT @total, @status, @transaction_date, @customer_id, @salesman_id
		
		SET @id = SCOPE_IDENTITY()
	END
GO
DECLARE @new_identity INT
EXEC dbo.usp_AddSale @total=2900, @status='A', @transaction_date='2020-12-02', @customer_id=4, @salesman_id=1, @id=@new_identity OUTPUT 
GO
IF EXISTS ( SELECT * 
            FROM   sysobjects 
            WHERE  id = object_id(N'[dbo].[usp_AddSaleDetail]') 
                   and OBJECTPROPERTY(id, N'IsProcedure') = 1 )
BEGIN
    DROP PROCEDURE [dbo].[usp_AddSaleDetail]
END    
GO
CREATE PROCEDURE dbo.usp_AddSaleDetail(
	@sale_id INT,
	@store_product_id INT,
	@quantity INT,
	@subtotal DECIMAL(10,2),
	@id INT OUT
) AS
	BEGIN
		INSERT INTO SALE_DETAIL(sale_id, store_product_id, quantity, subtotal)
		SELECT @sale_id, @store_product_id, @quantity, @subtotal
		
		SET @id = SCOPE_IDENTITY()
	END
GO	
DECLARE @new_identity INT
EXEC dbo.usp_AddSaleDetail @sale_id=1, @store_product_id=1, @quantity=1, @subtotal =50, @id=@new_identity OUTPUT 
EXEC dbo.usp_AddSaleDetail @sale_id=1, @store_product_id=7, @quantity=1, @subtotal =2850, @id=@new_identity OUTPUT 
GO
IF EXISTS ( SELECT * 
            FROM   sysobjects 
            WHERE  id = object_id(N'[dbo].[usp_QueryAllProductsByName]') 
                   and OBJECTPROPERTY(id, N'IsProcedure') = 1 )
BEGIN
    DROP PROCEDURE [dbo].[usp_QueryAllProductsByName]
END
GO
CREATE PROCEDURE dbo.usp_QueryAllProductsByName(
	@product_name VARCHAR(250)
)
AS
	SELECT * FROM PRODUCT
	WHERE name LIKE '%' + @product_name + '%'
	ORDER BY name
GO		
IF EXISTS ( SELECT * 
            FROM   sysobjects 
            WHERE  id = object_id(N'[dbo].[usp_QueryAllBooksByNameTitleAuthorDescription]') 
                   and OBJECTPROPERTY(id, N'IsProcedure') = 1 )
BEGIN
    DROP PROCEDURE [dbo].[usp_QueryAllBooksByNameTitleAuthorDescription]
END
GO
CREATE PROCEDURE dbo.usp_QueryAllBooksByNameTitleAuthorDescription(
	@data VARCHAR(250)
)
AS
	SELECT * FROM BOOK_PRODUCT bp, PRODUCT p
	WHERE	(bp.title LIKE '%' + @data + '%' OR
			bp.author LIKE '%' + @data + '%' OR
			p.name LIKE '%' + @data + '%' OR
			p.description LIKE '%' + @data + '%') AND
			bp.id = p.id			
	ORDER BY title
GO		
IF EXISTS ( SELECT * 
            FROM   sysobjects 
            WHERE  id = object_id(N'[dbo].[usp_QueryAllElectronicsByNameDescriptionBrandModel]') 
                   and OBJECTPROPERTY(id, N'IsProcedure') = 1 )
BEGIN
    DROP PROCEDURE [dbo].[usp_QueryAllElectronicsByNameDescriptionBrandModel]
END
GO
CREATE PROCEDURE dbo.usp_QueryAllElectronicsByNameDescriptionBrandModel(
	@data VARCHAR(250)
)
AS
	SELECT * FROM ELECTRONIC_PRODUCT ep, PRODUCT p
	WHERE	(ep.brand LIKE '%' + @data + '%' OR
			ep.model LIKE '%' + @data + '%' OR
			p.name LIKE '%' + @data + '%' OR
			p.description LIKE '%' + @data + '%') AND
			ep.id = p.id			
	ORDER BY name
GO		
IF EXISTS ( SELECT * 
            FROM   sysobjects 
            WHERE  id = object_id(N'[dbo].[usp_QueryAllElectronicsByNameDescriptionBrandModelInStore]') 
                   and OBJECTPROPERTY(id, N'IsProcedure') = 1 )
BEGIN
    DROP PROCEDURE [dbo].[usp_QueryAllElectronicsByNameDescriptionBrandModelInStore]
END
GO
CREATE PROCEDURE dbo.usp_QueryAllElectronicsByNameDescriptionBrandModelInStore(
	@data VARCHAR(250),
	@store_id INT
)
AS
	SELECT * FROM ELECTRONIC_PRODUCT ep, PRODUCT p, STORE_PRODUCT sp
	WHERE	sp.store_id = @store_id AND
			p.id = sp.product_id AND
			p.id = ep.id AND 
			(ep.brand LIKE '%' + @data + '%' OR
			ep.model LIKE '%' + @data + '%' OR
			p.name LIKE '%' + @data + '%' OR
			p.description LIKE '%' + @data + '%')
	ORDER BY name
GO	

