# QUERY 3
SELECT COUNT(CUS_GENDER) AS TotalNoOfCustomers,CUS_GENDER
FROM
(
SELECT CUS_GENDER,CUS_NAME FROM customer AS CUS
INNER JOIN
(
SELECT ORD_ID,CUS_ID FROM orders WHERE ORD_AMOUNT >=3000
)
AS O
ON CUS.CUS_ID = O.CUS_ID
GROUP BY CUS.CUS_ID
)
AS T
GROUP BY CUS_GENDER;

# QUERY 4
SELECT product.PRO_NAME, orders.* 
FROM orders, product_details, product
WHERE orders.CUS_ID=2 
AND orders.PROD_ID=product_details.PROD_ID
AND product_details.PRO_ID=product.PRO_ID;

# QUERY 5
SELECT supplier.* 
FROM supplier 
WHERE supplier.SUPP_ID in
( SELECT SUPP_ID
   FROM product_details
   GROUP BY SUPP_ID
   having count(SUPP_ID)>1)
GROUP BY supplier.SUPP_ID;

# QUERY 6
SELECT category.CAT_ID,category.CAT_NAME, MIN(t3.min_price) as Min_Price
 FROM category 
 INNER JOIN
   (SELECT product.CAT_ID, PRO_NAME, t2.*
    FROM  product 
     INNER JOIN
       (SELECT PRO_ID, MIN(PROD_PRICE) as Min_Price
        FROM  product_details GROUP BY PRO_ID)
        as t2 WHERE t2.PRO_ID = product.PRO_ID)
        as t3 WHERE t3.CAT_ID = category.CAT_ID GROUP BY t3.CAT_ID;
        
# QUERY 7
SELECT product.PRO_ID,product.PRO_NAME
FROM orders
  INNER JOIN
	product_details ON product_details.PROD_PRICE = orders.PROD_ID
	 INNER JOIN
	  product on product.PRO_ID = product_details.PRO_ID
	  WHERE orders.ORD_DATE>"2021-10-05";
      
# QUERY 8
select s.SUPP_NAME, c.CUS_NAME, r.RAT_RATSTARS 
from rating r LEFT JOIN supplier s ON s.SUPP_ID = r.SUPP_ID 
LEFT JOIN customer c ON c.CUS_ID = r.CUS_ID ORDER BY r.RAT_RATSTARS DESC limit 3;

# QUERY 9
SELECT customer.CUS_NAME,customer.CUS_GENDER
  FROM customer 
  WHERE customer.CUS_NAME LIKE 'A%' OR customer.CUS_NAME LIKE '%A';

# QUERY 10 
 select SUM(ORD_Amount) As TotalAmt from orders o LEFT JOIN customer c ON c.cus_id = o.cus_id where c.CUS_GENDER = 'M';
 
# QUERY 11
  select * from customer C LEFT JOIN orders o ON c.cus_id = o.cus_id;