-- Rename the columns after you have selected them
SELECT firstName, lastName, phone FROM employees
SELECT customerName AS 'Customer Name', contactFirstName AS 'First Name', contactLastName AS 'Last Name', phone AS 'Phone' FROM customers;


-- Rename the columns after you have selected them
SELECT customerName, contactFirstName, contactLastName, phone FROM customers
SELECT customerName AS 'Customer Name', contactFirstName AS 'First Name', contactLastName AS 'Last Name', phone AS 'Phone' FROM customers;

SELECT firstName, lastName, email FROM employees WHERE officeCode=1;

-- Show the customerName and phone number for all customers from France
SELECT customerName, phone, country FROM customers WHERE country="France";

-- Search by a string pattern, we use LIKE and a % to represent the wildcard (LIKE)

-- Select any rows where job title begins with "sales"
SELECT * FROM employees WHERE jobTitle LIKE "%sales%"

-- Select any rows where job titles end with "sales"

SELECT * FROM employees WHERE jobTitle LIKE "%sales";

-- Select any rows where job titles contains "sales"

SELECT * FROM employees WHERE jobTitle LIKE "%sales%";

-- Find all the orders where the word "DHL" is mentioned
SELECT orderNumber, comments FROM orders WHERE comments LIKE "%dhl%";

-- get employees from officeCode 1 or 2
SELECT * FROM employees WHERE officeCode = 1 OR officeCode = 2;

-- find all the customers in USA where their credit limit is more than 10k
SELECT * FROM customers WHERE creditLimit > 10000 AND country="USA";

-- when mixing AND/OR together, use parenthesis to state precedence
-- find all the customers in USA or Singapore and at the same time where their credit limit is less than 10k
SELECT * FROM customers WHERE creditLimit < 10000 AND (country="USA" OR country="Singapore");

-- For each employee, display their first name, last name, email, office city and office address
SELECT * FROM employees JOIN offices
    ON employees.officeCode = offices.officeCode


-- For each employee display their first name, last name, email, office city and office address
SELECT firstName, lastName, email, city, addressLine1, addressLine2 FROM employees 
	JOIN offices
    ON employees.officeCode = offices.officeCode
	WHERE employees.officeCode = 1;

-- For each customer, display the customer name, and the name and email of the sales rep 
SELECT customerName, firstName, lastName, email FROM customers  
    JOIN employees
    ON customers.salesRepEmployeeNumber = employees.employeeNumber


-- For each customer, display the customer name, and the name and email of the sales rep 
-- but only for customers which credit limit is more than 100k
SELECT customerName, firstName, lastName, email FROM customers 
	JOIN employees
    ON customers.salesRepEmployeeNumber = employees.employeeNumber
	WHERE customers.creditLimit > 100000;

-- SORT BY ASCENDING ORDER
-- Display customers and sort them from lowest credit limit to highest
SELECT * FROM customers ORDER BY creditLimit DESC;

--
SELECT customerName, creditLimit FROM customers 
WHERE country="USA"
ORDER BY creditLimit DESC;

-- Limit means the first 10 results
SELECT customerName, creditLimit FROM customers 
WHERE country="USA"
ORDER BY creditLimit DESC -- ORDER BY always second last
LIMIT 10; -- LIMIT always last


SELECT customerName, creditLimit, firstName, lastName FROM customers JOIN employees
ON customers.salesRepEmployeeNumber = employees.employeeNumber
WHERE country="USA"
ORDER BY creditLimit DESC -- ORDER BY always second last
LIMIT 10; -- LIMIT always last

-- AGGREGATE FUNCTIONS
-- Count how many employees there are
SELECT COUNT(*) FROM employees WHERE officeCode = 1;

-- Find the average credit limit among all the customers
SELECT AVG(creditLimit) FROM customers;

-- Find the max credit limit among all the customers
SELECT MAX(creditLimit) FROM customers;

-- Find the min credit limit among all the customers
SELECT MIN(creditLimit) FROM customers;

-- Find the sum of all credit limits among all the customers
SELECT SUM(creditLimit) FROM customers;


-- how many employees are there in each office code
SELECT officeCode, COUNT(*) FROM employees
GROUP BY officeCode

-- For each country, show how many customers there are
SELECT ??? FROM customers 
GROUP BY country

-- For each product, show how many times they are ordered
SELECT productCode, COUNT(*) FROM orderdetails 
GROUP BY productCode

-- For each product, show the quantity ordered
SELECT productCode, SUM(productCode) from orderdetails
GROUP BY productCode 

SELECT country, AVG(creditLimit) FROM customers
WHERE creditLimit > 0
GROUP BY country

-- show the number of employees per office 
-- and only show those with at least 3 employees
SELECT officeCode, COUNT(*) FROM employees
GROUP BY officeCode

-- for each sales rep whose office is in the USA, show all the sales rep who have at least five customers
-- showing them in descending order and only the top 5
SELECT employeeNumber, COUNT(*) AS 'Customer Count' FROM employees JOIN customers
    ON employees.employeeNumber = customers.salesRepEmployeeNumber
    JOIN offices
    ON employees.officeCode = offices.officeCode
    WHERE offices.country = "USA"
    GROUP BY employeeNumber
    HAVING `Customer Count` >= 5
    ORDER BY `Customer Count` DESC
    LIMIT 10;




Sequence
1. JOIN
2. WHERE
3. GROUP BY
4. SELECT
5. HAVING
6. ORDER by
7. LIMIT


-- Hands on 4.1
-- 1 - Find all the offices and display only their city, phone and country
SELECT city,phone,country FROM offices

-- 2 - Find all rows in the orders table that mentions FedEx in the comments.
SELECT * FROM orders WHERE comments LIKE "%fedex%";

-- 3 - Show the contact first name and contact last name of all customers in descending order by the customer's name
SELECT contactFirstName, contactLastName FROM customers 
ORDER BY customerName DESC

-- 4 - Find all sales rep who are in office code 1, 2 or 3 and their first name or last name contains the substring 'son'
SELECT * FROM employees WHERE (officeCode = 1 OR officeCode = 2 OR officeCode = 3) AND (firstName="%son%" OR lasttName="%son%");

-- 5 - Display all the orders bought by the customer with the customer number 124, along with the customer name, the contact's first name and contact's last name.
SELECT customerName, contactFirstName, contactLastName FROM customers 
    JOIN orders 
    ON orders.customerNumber = customers.customerNumber
    WHERE orders.customerNumber = 124

-- 6 - Show the name of the product, together with the order details, for each order line from the orderdetails table
SELECT * FROM products
    JOIN orderdetails
    ON products.productCode = orderdetails.productCode

-- 7 - Display sum of all the payments made by each company from the USA. 
SELECT SUM(amount) FROM payments
    JOIN customers
    ON payments.customerNumber = customers.customerNumber
    WHERE country="USA";

-- 8 - Display all orders made by customers from the USA and UK
SELECT * FROM orders
    JOIN customers
    ON orders.customerNumber = customers.customerNumber
    WHERE country="USA" OR country="UK"

-- 9 - Show how many employees are there for each state in the USA		
SELECT city, COUNT(*) FROM offices 
    JOIN employees
    ON offices.officeCode = employees.officeCode
	GROUP BY city
    ORDER BY offices.officeCode

-- 10 - Display the number of orders made, per month, between Jan 2003 and Dec 2003
SELECT DATE_FORMAT(orderDate, '%Y-%m') AS month, COUNT(*) AS num_orders
    FROM orders
    WHERE orderDate >= '2003-01-01' AND orderDate <= '2003-12-31'
    GROUP BY month
    ORDER BY month ASC;

-- 11 - From the payments table, display the average amount spent by each customer. Display the name of the customer as well.
SELECT customerName, AVG(amount) FROM payments
    JOIN customers
    ON payments.customerNumber = customers.customerNumber
    GROUP BY customerName
    ORDER BY customerName

-- 12  - How many products are there in each product line?
SELECT productlines.productLine, COUNT(*) FROM productlines
    JOIN products
    ON productlines.productLine = products.productLine
	GROUP BY productlines.productLine
    ORDER BY products.productline

-- 13 - From the payments table, display the average amount spent by each customer but only if the customer has spent a minimum of average 10,000 dollars.
SELECT customers.customerName, AVG(amount) FROM customers
    JOIN payments
    ON customers.customerNumber = payments.customerNumber
    GROUP BY customers.customerName
    HAVING AVG(amount) >= 10000
    ORDER BY customers.customerName

-- 14  - For each product, display how many times it was ordered, and display the results with the most orders first and only show the top ten.
SELECT productName, COUNT(*) AS 'Order Count' FROM products
    JOIN orderdetails
    ON products.productCode = orderdetails.productCode
    GROUP BY productName
    ORDER BY `Order Count` DESC
    LIMIT 10

