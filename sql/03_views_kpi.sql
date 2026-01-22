---vw_StoreSalesSummary: Revenue, #Orders, AOV per store

CREATE VIEW vw_StoreSalesSummary AS
WITH AOV AS (
	SELECT 
		order_id,
		SUM(list_price*(1-discount)* quantitiy) AS Total_per_order
	FROM Sales.order_items
	GROUP BY order_id)

SELECT 
	O.Store_id,
	SS.store_name,
	SUM(AOV.Total_per_order) AS Revenue_for_per_store,
	COUNT(O.order_id) AS Total_Order_PerStore,
	SUM(AOV.Total_per_order)/ COUNT(O.order_id) AS Avg_O_V
	FROM AOV AS AOV
JOIN Sales.orders AS O
ON AOV.order_id = O.order_id
JOIN Sales.Stores AS SS
ON O.Store_id = SS.store_id
GROUP BY O.Store_id, SS.store_name

----vw_TopSellingProducts: Rank products by total sales

CREATE VIEW vw_TopSellingProducts AS 
with cte as(
SELECT 
	OI.product_id, 
	SUM(OI.list_price*(1-discount)*quantitiy) AS Total_Sale_Per_Product
FROM  Sales.order_items AS OI
GROUP BY OI.product_id
)

select 
	OI.product_id, 
	P.product_name,
	OI.Total_Sale_Per_Product,
	DENSE_RANK() OVER(ORDER BY oi.Total_Sale_Per_Product DESC) AS Sales_Rank
from cte as OI
JOIN  Product.products AS P
ON OI.product_id = P.product_id;


-----vw_InventoryStatus: Items running low on stock

CREATE VIEW vw_InventoryStatus AS 
WITH LowStock AS (
SELECT 
	stock.product_id, 
	SUM(stock.quantity) AS Low_running_products
FROM Product.stocks as stock
GROUP BY stock.product_id
HAVING SUM(stock.quantity) < 20   -- I MARK THE PRODUCTS THAT ARE LEFT LESS THAN 20 IN TOTAL AS A LOW RUNNING PRODUCTS 
) 

SELECT 
	LS.product_id, 
	P.product_name, 
	LS.Low_running_products 
FROM LowStock AS LS
LEFT JOIN Product.products AS P
ON LS.product_id = P.product_id;


--- vw_StaffPerformance: Orders and revenue handled per staff

CREATE VIEW vw_StaffPerformance AS
with cte as (
SELECT 
	o.staff_id,
	COUNT(o.order_id) as OrderCount,
	sum(list_price*(1-discount)*quantitiy) AS Total_Revenue_per_order
FROM Sales.order_items AS oi
LEFT JOIN Sales.orders as o
ON oi.order_id = o.order_id
GROUP BY  o.staff_id
	)

SELECT
	s.staff_id, 
	s.first_name, 
	s.last_name, 
	COALESCE(cte.OrderCount, 0) AS OrderCount, 
	COALESCE(cte.Total_Revenue_per_Staff, 0) AS Total_Revenue_per_Staff
FROM Sales.staffs as s
LEFT JOIN cte as cte
	on s.staff_id = cte.staff_id;


----- vw_RegionalTrends: Revenue by city or region
CREATE VIEW vw_RegionalTrends AS
WITH cte AS (
    SELECT 
        city,
        SUM(list_price * (1 - discount) * quantitiy) AS Total_Revenue_per_city
    FROM Sales.order_items AS oi
    JOIN Sales.orders AS o
        ON oi.order_id = o.order_id
    JOIN Sales.customers AS c
        ON o.Customer_id = c.customer_id
    GROUP BY city
)

---- vw_SalesByCategory: Sales volume and margin by product category

CREATE VIEW vw_SalesByCategory AS 
SELECT 
	c.category_name,
	SUM(quantitiy) as Toatl_quantity, 
	SUM(oi.list_price*(1-discount)*quantitiy) as Margin_per_category
FROM Sales.order_items as oi
JOIN Product.products as p
	on p.product_id = oi.product_id
JOIN Product.categories as c
	on c.category_id = p.category_id
GROUP BY c.category_name

SELECT * FROM vw_SalesByCategory
