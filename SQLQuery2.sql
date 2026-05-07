--0
use AdventureWorksLT2019
select * from SalesLT.Product

-- 1
select count(*) as [Total Customers]
from SalesLT.Customer

-- 2
select count_big(*) as [Total Orders]
from SalesLT.SalesOrderHeader

-- 3
select max(TotalDue) as [Order]
from SalesLT.SalesOrderHeader

-- 4
select min(TotalDue) as [Order]
from SalesLT.SalesOrderHeader

-- 5
select sum(TotalDue) as [Total Sum]
from SalesLT.SalesOrderHeader

-- 6
select count(*) as [100] from SalesLT.Product
where ListPrice > 100

-- 7
select max(ListPrice) as [1000]
from SalesLT.Product
where ListPrice < 1000

-- 8
select min(ListPrice) as [Chiapest Product]
from SalesLT.Product
where ListPrice > 0

-- 9

select sum(ListPrice) as [Total Price]
from SalesLT.Product
where Color is not null

-- 10
select count(*) as [2010] from SalesLT.Customer
where ModifiedDate > '2010-01-01'

-- 11
select min(ModifiedDate) as [Before 2009] from SalesLT.SalesOrderDetail
where ModifiedDate < '2009-01-01'

-- 12
select CustomerID, sum(TotalDue) as [Total Orders Sum] from SalesLT.SalesOrderHeader
group by CustomerID
order by CustomerID

-- 13
select Customer.CustomerID, Customer.FirstName, Customer.LastName,
count(SalesOrderHeader.SalesOrderID) as [Total Orders]
    from SalesLT.Customer
join SalesLT.SalesOrderHeader on Customer.CustomerID = SalesOrderHeader.CustomerID
group by Customer.CustomerID, Customer.FirstName, Customer.LastName
order by Customer.CustomerID


-- 15
select Customer.CustomerID, Customer.FirstName, Customer.LastName,
sum(SalesOrderHeader.TotalDue) as [Total Sum]
    from SalesLT.Customer
join SalesLT.SalesOrderHeader on Customer.CustomerID = SalesOrderHeader.CustomerID
group by Customer.CustomerID, Customer.FirstName, Customer.LastName
having sum(SalesOrderHeader.TotalDue) > 10000
order by Customer.CustomerID