/*
  Name: MySQL Sample Database classicmodels
  Link: http://www.mysqltutorial.org/mysql-sample-database.aspx
*/


/* Create the database */
CREATE DATABASE  IF NOT EXISTS classicmodels;

use classicmodels;


select * from customers;
select * from employees;
select * from offices;
select * from orderdetails;
select * from orders;
select * from payments order by amount asc;
select * from productlines;
select * from products;

-- 1)Get all names of peoples whos office is at Boston
select o.city,c.customerName  from offices o 
join employees e on o.officeCode=e.officeCode
join customers c on c.salesRepEmployeeNumber=e.employeeNumber
where o.city ="Boston";

-- 2)Select all customer details from the customers table.
select customerName from customers;

-- 3)List all products along with their product line from the products, product vendor, product qty. order and productlines tables.
select p.productName, p.productLine, p.productvendor, o.quantityOrdered from products p
join orderdetails o on p.productCode= o.productCode order by quantityOrdered asc;

-- 4)Get the total number of orders placed by each customer.
select c.customerName as Customer_Name, sum(od.quantityOrdered) as Orders_Quantity from customers c
join orders o on c.customerNumber=o.customerNumber
join orderdetails od on o.orderNumber=od.orderNumber group by c.customerName;

-- 5)Find the total amount (sum of all orders) for each customer.
select c.customerName as Customer_Name, sum(p.amount) as Total_Amount from customers c
join payments p on c.customerNumber=p.customerNumber group by c.customerName;

-- 6)Show the employees who report to a specific Office city adress, state, Phone, Country.
select o.city, o.phone, o.addressLine1, o.state, o.country as Country,
concat(e.firstname," ", e.lastName) as Names,e.jobTitle as Designation from offices o
join employees e on e.officeCode=o.officeCode;

-- 7)Get the Top 3 most product ordered customers name, its total amount spend from city NYC and San Fransisco.
select c.customerName, c.city as City,sum(o.quantityOrdered) as Quantity, sum(p.amount) as Total_Amount from customers c
join payments p on p.customerNumber= c.customerNumber
join orders od on c.customerNumber= od.customerNumber
join orderdetails o on o.orderNumber= od.orderNumber where c.city in ("NYC","San Fransisco") 
group by c.customerName, c.city order by sum(o.quantityOrdered) desc limit 3;

-- 8)List all the products that were ordered along with their quantities and prices.
select p.productName, o.quantityOrdered, py.amount from products p
join orderdetails o on p.productCode= o.productCode
join orders od on od.orderNumber=o.orderNumber
join payments py on py.customerNumber= od.customerNumber;

-- 9)Show all employees working in the same office as a specific employee.
select concat(e.firstName," ", e.lastName) as Names, o.city as Office from offices o
join employees e on e.officeCode=o.officeCode group by concat(e.firstName," ", e.lastName), o.city order by o.city asc;

-- 10)Find all customers who made payments greater than a specified amount (e.g., $1000).
select c.customerName as Names, p.amount as Total_Spents,
case
when p.amount >30000 && p.amount<40000 then "Important Customers"
when p.amount >40000 && p.amount<80000 then "Important Customers"
when p.amount >80000 then "Prime Customers"
else "Normal Cutsomers"
end as "Customer IMP"
 from customers c
join payments p on c.customerNumber= p.customerNumber
where p.amount >29999 order by c.customerName asc;

-- 11)Get the top 5 best-selling products based on order quantity
select p.productName as Products, o.quantityOrdered as Quantity from products p
join orderdetails o on o.productCode=p.productCode order by o.quantityOrdered desc limit 5;