---1sp_CalculateStoreKPI: Input store ID, return full KPI breakdown
--Total Revenue
---Average Order Value (AOV)

--- Revenue by Store
--- Staff Revenue Contribution

CREATE PROCEDURE sp_CalculateStoreKPI @store_id int AS 
BEGIN
WITH Total AS (
    SELECT
        SUM(list_price * (1 - COALESCE(discount,0)) * COALESCE(quantitiy,0)) AS Total_Revenue,
        COUNT(DISTINCT order_id) AS Total_Orders
    FROM Sales.order_items
)
SELECT
    Total_Revenue,
    Total_Revenue / NULLIF(Total_Orders,0) AS AOV
FROM Total;



SELECT
    st.store_id,
    st.store_name,
    s.staff_id,
    s.first_name,
    s.last_name,
    SUM(oi.list_price * (1 - COALESCE(oi.discount,0)) * COALESCE(oi.quantitiy,0)) AS Staff_Revenue,
    SUM(SUM(oi.list_price * (1 - COALESCE(oi.discount,0)) * COALESCE(oi.quantitiy,0))) 
        OVER (PARTITION BY st.store_id) AS Store_Revenue,
    100.0 * SUM(oi.list_price * (1 - COALESCE(oi.discount,0)) * COALESCE(oi.quantitiy,0))
        / SUM(SUM(oi.list_price * (1 - COALESCE(oi.discount,0)) * COALESCE(oi.quantitiy,0))) 
          OVER (PARTITION BY st.store_id) AS Contribution_Percent
FROM Sales.order_items AS oi
JOIN Sales.orders AS o
    ON oi.order_id = o.order_id
JOIN Sales.staffs AS s
    ON o.staff_id = s.staff_id
JOIN Sales.Stores AS st
    ON o.store_id = st.store_id
GROUP BY st.store_id, st.store_name, s.staff_id, s.first_name, s.last_name
having st.store_id = @store_id
END



--2. sp_GenerateRestockList: Output low-stock items per store

CREATE PROCEDURE sp_GenerateRestockList @StoreID INT AS 
BEGIN 
SELECT
	S.store_id, 
	S.store_name,
    st.product_id,
    SUM(st.quantity) AS low_stock_quantity
FROM Product.stocks AS st
JOIN Sales.Stores AS s
    ON st.store_id = s.store_id
WHERE st.store_id = @StoreID
GROUP BY S.store_id,
    st.product_id,
    s.store_name
HAVING SUM(st.quantity) < 15;
END 

--3. sp_CompareSalesYearOverYear: Compare sales between two years
CREATE PROCEDURE sp_CompareSalesYearOverYear AS 
BEGIN
SELECT 
	order_year, 
	total_revenue_by_year,
	total_revenue_by_year - LAG(total_revenue_by_year) over ( order by order_year asc) as revenue_diff
FROM (
SELECT 
	 YEAR(order_date) as order_year,
	 SUM(oi.list_price * (1 - COALESCE(oi.discount,0)) * COALESCE(oi.quantitiy,0)) as total_revenue_by_year
FROM Sales.orders as o
JOIN Sales.order_items as oi
on o.order_id = oi.order_id
group by YEAR(order_date)) AS t
END


--4. --Returns total spend, orders, and most bought items

ALTER PROCEDURE sp_GetCustomerProfile @customerid INT AS 
BEGIN
Select 
	o.order_id, 
	c.customer_id, 
	c.first_name,
	c.last_name,
	COUNT(oi.order_id) AS Order_count_per_customer, 
	SUM(list_price*(1-discount)*quantitiy) AS Total_spending_per_customer
FROM Sales.order_items oi
JOIN Sales.orders AS o
on o.order_id = oi.order_id
JOIN Sales.customers as c
on c.customer_id = o.Customer_id
GROUP BY o.order_id, c.customer_id, c.first_name, c.last_name
Having c.customer_id = @customerid
ORDER BY o.order_id

DECLARE @MOST_BOUGHT_ITEM INT, @MOST_BOUGHT_ITEM_QUANTITY INT;

SELECT TOP 1
	@MOST_BOUGHT_ITEM = oi.item_id, 
	@MOST_BOUGHT_ITEM_QUANTITY = sum(oi.quantitiy)
FROM Sales.order_items AS oi
GROUP BY oi.item_id
ORDER BY sum(oi.quantitiy) DESC

PRINT 'The most bought item is:' + Cast(@MOST_BOUGHT_ITEM AS Varchar(50)) + ' and its quantity ' + CAST(@MOST_BOUGHT_ITEM_QUANTITY AS VARCHAR(50))

END


