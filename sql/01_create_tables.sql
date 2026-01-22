CREATE DATABASE Bike_Store
USE Bike_Store

CREATE SCHEMA Sales 

-- SALES SCHEMA TABLES 
-- orders table 
CREATE TABLE Sales.orders (order_id int primary key, 
							Customer_id int, 
							order_status int, 
							order_date Date NULL, 
							required_date Date NULL, 
							shipped_date VARCHAR (50), 
							Store_id int, 
							staff_id int,
							CONSTRAINT FK_orders FOREIGN KEY (Customer_id) REFERENCES Sales.customers (Customer_id),
							CONSTRAINT FK_orders2 FOREIGN KEY (staff_id) REFERENCES Sales.staffs(staff_id), 
							CONSTRAINT FK_orders3 FOREIGN KEY (store_id) REFERENCES Sales.stores(store_id))
ALTER TABLE Sales.orders 
DROP CONSTRAINT FK_orders2

-- customers table 

CREATE TABLE Sales.customers (customer_id int primary key,
								first_name Varchar(59), 
								last_name VARCHAR(50), 
								phone VARCHAR(50), 
								email Varchar(50), 
								street Varchar(200), 
								city varchar (50), 
								state VARCHAR (50), 
								zip_code VARCHAR(50))

---staffs table 

CREATE TABLE Sales.staffs (staff_id int primary key, 
							first_name VARCHAR(50), 
							last_name VARCHAR(50), 
							email VARCHAR(50), 
							phone VARCHAR(50), 
							active int, 
							store_id int, 
							manager_id VARCHAR(50),
							CONSTRAINT FK_staffs FOREIGN KEY (store_id) REFERENCES Sales.stores(store_id))

----- stores table 
  
CREATE TABLE Sales.stores (store_id int primary key, 
							store_name VARCHAR(50), 
							phone VARCHAR(50), 
							email VARCHAR(50), 
							street VARCHAR(200), 
							city VARCHAR(50), 
							state VARCHAR(50), 
							zip_code VARCHAR(50))

---- order_items 
CREATE TABLE Sales.order_items(order_id int,
							item_id int,
							product_id int, 
							quantitiy int, 
							list_price DECIMAL(10,2),
							discount DECIMAL(10,2),
							constraint FK_order_items FOREIGN KEY(product_id) REFERENCES Product.products(product_id),
							constraint FK_order_items2 FOREIGN KEY(order_id) REFERENCES Sales.orders(order_id))

----- Products Schema 
---- products table 
CREATE SCHEMA Product 


CREATE TABLE Product.products (product_id int primary key, 
						product_name VARCHAR(50), 
						brand_id int, 
						category_id int,
						model_year int, 
						list_price DECIMAL(10,2), 
						CONSTRAINT FK_products FOREIGN KEY (category_id) REFERENCES Product.categories(category_id),
						CONSTRAINT FK_products2 FOREIGN KEY (brand_id) REFERENCES Product.brands(brand_id))
alter table Product.products
alter column product_name VARCHAR(100)


  ----- categories table 
CREATE TABLE Product.categories (category_id int primary key, 
						category_name VARCHAR(50))

---- brands table 
CREATE TABLE Product.brands(brand_id int primary key, 
					brand_name VARCHAR(50))


----- stocks table 
drop table Product.stocks 
CREATE TABLE Product.stocks (store_id int,
					product_id int, 
					quantity int,
					CONSTRAINT FK_stock FOREIGN KEY(product_id) REFERENCES Product.products(product_id),
					CONSTRAINT FK_stock2 FOREIGN KEY(store_id) REFERENCES Sales.stores(store_id)
					)
