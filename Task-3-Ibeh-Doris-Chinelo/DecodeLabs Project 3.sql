SELECT * FROM dbo.[DecodeLabs Task 3]

--Identify the best selling products by total revenue and total number of orders

SELECT
	[Product],
	SUM([Quantity] * [Unit Price]) AS TotalRevenue,
	SUM([Quantity]) AS TotalUnitSold,
	COUNT([Order ID]) AS TotalOrders
FROM 
	dbo.[DecodeLabs Task 3]
WHERE 
	[Order Status] = 'Shipped'
GROUP BY 
	Product
ORDER BY
	TotalRevenue DESC,
	TotalUnitSold DESC,
	TotalOrders DESC

	--Key Insight: This shows that "Printer" category is the top performer across all metrics having the highest revenue $44,397.41,
	--				with the most unit sold of 124 units and drover the highest number of individual customer orders (42).
	--				Phones shows the most underperforming product with the least revenue and unit sold.


-- Which products are being cancelled or returned the most?
SELECT
	[Product],
	SUM([Quantity] * [Unit Price]) AS LostRevenue,
	COUNT([Order ID]) AS FailedOrders
FROM 
	dbo.[DecodeLabs Task 3]
WHERE 
	[Order Status] IN ('Shipped', 'Returned')
GROUP BY 
	Product
ORDER BY
	LostRevenue DESC

	--Key Insight: This indicate  that Printer, Laptop and  Tablets are the top three slots for lost revenue, with printer having
	--             the highest failure orders of 80. This is because high ticket electronic products often get higher
	--             return rates due to the technical defects, user errors.


--	Which Customers have succesfully spent more than $1000 in total?
SELECT
	[Customer ID],
	SUM([Quantity] * [Unit Price]) AS TotalSpent,
	COUNT([Order ID]) AS SuccessfulOrders
FROM 
	dbo.[DecodeLabs Task 3]
WHERE 
	[Order Status] = 'Shipped'
GROUP BY 
	[Customer ID]
HAVING 
	SUM([Quantity] * [Unit Price]) >1000
ORDER BY
	TotalSpent DESC

	-- Key Insight: This shows that every single top spending customers listed on the results $1000-$3353 has done 1 successful order.
	--              and Customer with the customer ID C16775 spent thr most money in a single order.


-- What are the most popular Payment methods for successful orders?

SELECT
	[Payment Method],
	SUM([Quantity] * [Unit Price]) AS TotalRevenue,
	COUNT([Order ID]) AS NumberOfTransactions
FROM 
	dbo.[DecodeLabs Task 3]
WHERE 
	[Order Status] = 'Shipped'
GROUP BY 
	[Payment Method]
ORDER BY
	NumberOfTransactions DESC

-- Key Insight: "Online and Gift Card" are the leading payment method used, generating revenue over $55,000 and top spot
--               in both transaction volume(56 and 56).


--which promotions based on coupon code are actually driving the most revenue?


SELECT
	[Coupon Code],
	SUM([Quantity] * [Unit Price]) AS RevenueGenerated,
	COUNT([Order ID]) AS TimesUsed
FROM 
	dbo.[DecodeLabs Task 3]
WHERE 
	[Order Status] = 'Shipped'
	AND [Coupon Code] != 'N/A' --- Filter for string placeholder for missing values
GROUP BY 
	[Coupon Code]
ORDER BY
	RevenueGenerated DESC

	--Key Insight: The Coupon code SAVE10 generated the highest revenue (62231.95) even though it is not the most used coupon
	--              the FREESHIP was the most popular promotion used 61 times. And WINTER15 is the least used and generated the lowest revenue.



--Which customers are consistently coming back to shop?


SELECT
	[Customer ID],
	SUM([Quantity] * [Unit Price]) AS TotalLifetimeValue,
	COUNT([Order ID]) AS NumberOfSuccessfulOrders
FROM 
	dbo.[DecodeLabs Task 3]
WHERE 
	[Order Status] = 'Shipped'
GROUP BY 
	[Customer ID]
HAVING
	COUNT([Order ID]) >= 1
ORDER BY
	NumberofSuccessfulOrders DESC
	
	--Key Insight: The highest number of successful orders any customer has is 1, this means 
	--             that there is no customer coming back to purchase goods from the company. This is as a result of 
	--             the company is spending all its marketing budget on acquiring new customers but failing to keep them.
	




-- Which of the referral Sources brings the most order and their overall percentage shares?

SELECT
	[Referral Source],
	COUNT([Order ID] ) AS TotalOrders,
	ROUND(SUM([Total Price]), 2) AS RevenueGenerated,
	ROUND((COUNT([Order ID]) * 100.0) / (SELECT COUNT(*) FROM dbo.[DecodeLabs Task 3]), 2)AS OrderPercentage
FROM 
	[DecodeLabs Task 3]
GROUP BY
	[Referral Source]
ORDER BY
	RevenueGenerated DESC

	--Key Insight:	"Instagram" is the leading referral source, as it is the company most profitable and 
	--               highest converting channel generating the total orders of 256, the highest share of 21.58% and gave the most 
	--               revenue of $275,285.45, then follows by Email and "Referral" generating the least. However, this means the business 
	--              would not crash because sales are well balanced accross all channels
	
	











	 
