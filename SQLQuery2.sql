--View order IDs, product names, and revenue of orders delivered to the city of Hammond with revenues greater than or equal to $500.
SELECT [Sales ID],
	[Product Name],
	[Net Sales]
  FROM Sales
  Where [Customer City] = 'Hammond '
	and [Net Sales] >= '500'
Order by 
	[Net Sales] DESC 

-- Create reports that see the highest spend a customer has ever spent for 1 order. Sort by decreasing peak spending.
Select 
	[Customer ID],
	[Customer Name],
	Max ([Net Sales]) as [Max Net Sales]
From Sales
Group by 
	[Customer ID], [Customer Name] 
Order by 
	[Max Net Sales] DESC 
-- How many orders have sales between $250 and $750?
Select 
	count([Sales Id])
From Sales 
Where [Net Sales] >= '250' 
	and [Net Sales] <= '750'
-- REQUEST The company is in need of product grouping to do some product analysis.You need to group products by material as required below: - Metal: product names containing the words Aluminum, Copper, Steel, Bronze, Iron - Cloth: product names containing the words Wool, Leather, Silk, Linen, Cotton - Others: left
SELECT 
    *
    , CASE
        WHEN [Product Name] LIKE '%Aluminum%' THEN 'Metal'
        WHEN [Product Name] LIKE '%Copper%' THEN 'Metal'
        WHEN [Product Name] LIKE '%Steel%' THEN 'Metal'
        WHEN [Product Name] LIKE '%Bronze%' THEN 'Metal'
        WHEN [Product Name] LIKE '%Iron%' THEN 'Metal'
        WHEN [Product Name] LIKE '%Wool%' THEN 'Cloth'
        WHEN [Product Name] LIKE '%Leather%' THEN 'Cloth'
        WHEN [Product Name] LIKE '%Silk%' THEN 'Cloth'
        WHEN [Product Name] LIKE '%Linen%' THEN 'Cloth'
        WHEN [Product Name] LIKE '%Cotton%' THEN 'Cloth'
        ELSE 'Others' END
    AS [Product Material Category]
FROM product
--REQUEST The company is looking to increase revenue in new markets. To do that, the company wants to understand the purchasing behavior of states with good revenue, and differences with the rest of the states. Based on that plan, you first need to group states by revenue: - Big 10: top 10 highest-grossing states ever - Others: The remaining states
WITH [Top 100 customers 2019] AS (
    SELECT 
        [Customer ID] 
        , SUM([Net Sales]) AS [Spent Amount]
    FROM Sales 
    WHERE 
        EXTRACT(YEAR FROM [Created At]) = 2019
    GROUP BY [Customer ID] 
    ORDER BY [Spent Amount] DESC 
    LIMIT 100
)

SELECT *
FROM Customers 
WHERE 
    [Customer State] = 'TX'
    AND [Customer ID] IN (
        SELECT [Customer ID] 
        FROM [Top 100 Customers 2019]
    )