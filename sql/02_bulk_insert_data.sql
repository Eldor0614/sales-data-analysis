--1
BULK INSERT Bike_Store.Sales.orders
FROM 'D:\Sql bike store project\orders.csv'
WITH (
    FIELDTERMINATOR = ',',  -- Separator between columns
    ROWTERMINATOR = '\n',   -- Separator between rows (newline character)
    FIRSTROW = 2            -- Start inserting from the second row (skips header)
);

SELECT 
CASE 
	WHEN shipped_date IS NULL
		OR shipped_date = ''
		OR shipped_date = 'NULL'
	THEN NULL
	ELSE TRY_CONVERT(DATE, shipped_date)
END
FROM Sales.orders 

--2
BULK INSERT Bike_Store.Sales.customers
FROM 'D:\Sql bike store project\customers.csv'
WITH (
    FIELDTERMINATOR = ',',  -- Separator between columns
    ROWTERMINATOR = '\n',   -- Separator between rows (newline character)
    FIRSTROW = 2            -- Start inserting from the second row (skips header)
);

---3

BULK INSERT Bike_Store.Sales.staffs
FROM 'D:\Sql bike store project\staffs.csv'
WITH (
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2
);

SELECT 
CASE 
	WHEN manager_id IS NULL
		OR manager_id = ''
		OR manager_id = 'NULL'
	THEN NULL
	ELSE TRY_CONVERT(int, manager_id)  
END AS manager_id
FROM Sales.staffs

----4
BULK INSERT Bike_Store.Sales.stores
FROM 'D:\Sql bike store project\stores.csv'
WITH 
(FIELDTERMINATOR = ',', 
ROWTERMINATOR = '\n', 
FIRSTROW = 2
);


---5
BULK INSERT Bike_Store.Sales.order_items
FROM 'D:\Sql bike store project\order_items.csv'
WITH 
(FIELDTERMINATOR = ',', 
ROWTERMINATOR = '\n', 
FIRSTROW = 2
);


--6
BULK INSERT Bike_Store.Product.products
FROM 'D:\Sql bike store project\products (1).csv'
WITH 
(FIELDTERMINATOR = ',', 
ROWTERMINATOR = '\n', 
FIRSTROW = 2
);

--7
BULK INSERT Bike_Store.Product.categories
FROM 'D:\Sql bike store project\categories.csv'
WITH 
(FIELDTERMINATOR = ',', 
ROWTERMINATOR = '\n', 
FIRSTROW = 2
);

---8
BULK INSERT Bike_Store.Product.brands
FROM 'D:\Sql bike store project\brands.csv'
WITH 
(FIELDTERMINATOR = ',', 
ROWTERMINATOR = '\n', 
FIRSTROW = 2
);


--9

BULK INSERT Bike_Store.Product.stocks
FROM 'D:\Sql bike store project\stocks.csv'
WITH 
(FIELDTERMINATOR = ',', 
ROWTERMINATOR = '\n', 
FIRSTROW = 2
);

