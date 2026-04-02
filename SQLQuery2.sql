use AdventureWorksLT2019

--1
create function fn_GetAllCustomers()
returns table as
return (select * from SalesLT.Customer)

select * from fn_GetAllCustomers()

--2
create function fn_GetCustomerByID(@CustomerID int)
returns table as
return (select FirstName, LastName
        from SalesLT.Customer
        where CustomerID = @CustomerID)

select * from fn_GetCustomerByID(1)

--3
create function fn_GetOrdersByCustomer(@CustomerID int)
returns table as
return (select * from SalesLT.SalesOrderHeader
        where CustomerID = @CustomerID)

select * from fn_GetOrdersByCustomer(29847)

--4

create function fn_GetProductsByPrice(@MinPrice money, @MaxPrice money)
returns table as
return (select * from SalesLT.Product
        where ListPrice between @MinPrice and @MaxPrice)

select * from fn_GetProductsByPrice(100, 500)

--5
create function fn_GetTopExpensiveProducts()
returns table as
return (select top 10 * from SalesLT.Product
        order by ListPrice desc)

select * from fn_GetTopExpensiveProducts()

--6
create function fn_GetCustomerFullInfo(@CustomerID int)
returns @Table table (FullName nvarchar(50), Email nvarchar(50), Phone nvarchar(25))
as begin
insert into @Table
select FirstName + ' ' + LastName, EmailAddress, Phone
from SalesLT.Customer where CustomerID = @CustomerID
return
end

select * from dbo.fn_GetCustomerFullInfo(1)

--7
create function fn_GetCustomerOrderSummary_MSTVF(@CustomerID int)
returns @Table Table (OrderCount int, TotalAmount money)
as begin
    insert into @Table
    select count(SalesOrderID), sum(TotalDue)
    from SalesLT.SalesOrderHeader where CustomerID = @CustomerID
    return
end

select * from dbo.fn_GetCustomerOrderSummary_MSTVF(29847)

--8
create function fn_GetProductPriceCategory_MSTVF()
returns @Table Table (Name nvarchar(50), ListPrice money, Klass nvarchar(20))
as begin
insert into @Table
select Name, ListPrice,
case when ListPrice > 1000 then 'Kallis'
       when ListPrice >= 100 then 'Keskmine'
       else 'Odav' end
from SalesLT.Product
    return
end

select * from dbo.fn_GetProductPriceCategory_MSTVF()

--9
create function fn_GetCustomersWithOrders_MSTVF()
returns @Table Table (CustomerID int, FirstName nvarchar(50), LastName nvarchar(50))
as begin
    insert into @Table
    select c.CustomerID, c.FirstName, c.LastName
    from SalesLT.Customer c
    where exists (select 1 from SalesLT.SalesOrderHeader where CustomerID = c.CustomerID)
    return
end

select * from dbo.fn_GetCustomersWithOrders_MSTVF()

--10
create function fn_GetTopCustomersBySpending_MSTVF()
returns @Table table (FullName nvarchar(50), TotalSpent money)
as begin 
    insert into @Table
select top 5 c.FirstName + ' ' + c.LastName, sum(h.TotalDue)
    from SalesLT.Customer c
    join SalesLT.SalesOrderHeader h on c.CustomerID = h.CustomerID
    group by c.FirstName, c.LastName
    order by sum(h.TotalDue) desc
    return
end

select * from dbo.fn_GetTopCustomersBySpending_MSTVF()

