use AdventureWorksLT2019

--Left Join 
select Customer.CustomerID, Customer.FirstName, Customer.LastName, SalesOrderHeader.SalesOrderID, SalesOrderHeader.OrderDate
from SalesLT.Customer
left join SalesLT.SalesOrderHeader
on Customer.CustomerID = SalesOrderHeader.CustomerID

--right Join 
select SalesOrderDetail.SalesOrderID, SalesOrderDetail.OrderQty, Product.Name as [Product Name], Product.ListPrice
from SalesLT.SalesOrderDetail
right join SalesLT.Product
on SalesOrderDetail.ProductID = Product.ProductID

--Inner join
select Product.Name as [Product Name], ProductNumber,  ListPrice,ProductModel.Name as [Product Model Name]
from SalesLT.Product
inner join SalesLT.ProductModel
on Product.ProductModelId = ProductModel.ProductModelId

--full outer join
select Customer.CustomerID, Customer.FirstName, Customer.LastName, CustomerAddress.AddressID
from SalesLT.Customer
full outer join SalesLT.CustomerAddress
on Customer.CustomerID = CustomerAddress.CustomerID

--cross join 
select top 50
ProductCategory.Name as [Category Name], Product.Name as [Product Name], Product.ListPrice
from SalesLT.ProductCategory
cross join SalesLT.Product
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
-- GetAllCustomers
create proc spGetAllCustomers
as begin
select * from SalesLT.Customer
end
exec spGetAllCustomers


-- GetCustomerByID
create proc spGetCustomerByID
@CustomerID int
as begin
select FirstName, LastName, EmailAddress
from SalesLT.Customer
where CustomerID = @CustomerID
end
exec spGetCustomerByID @CustomerID = 1


--------------------------------------
sp_helptext spGetAllCustomers
sp_help spGetAllCustomers
sp_depends spGetAllCustomers
--------------------------------------
-- 1
create proc spGetAllCustomers
as begin
select * from SalesLT.Customer
end
exec spGetAllCustomers

-- 2
create proc spGetCustomerByID
@CustomerID int
as begin
select FirstName, LastName, EmailAddress
from SalesLT.Customer
where CustomerID = @CustomerID
end
exec spGetCustomerByID @CustomerID = 1

-- 3
create proc spGetOrdersByDateRange
@StartDate date, @EndDate date
as begin
select * from SalesLT.SalesOrderHeader
where OrderDate between @StartDate and @EndDate
end
exec spGetOrdersByDateRange @StartDate = '2008-01-01', @EndDate = '2008-12-31'

-- 4
create proc spAddNewProduct
@Name nvarchar(50), @ProductNumber nvarchar(25), @ListPrice money
as begin
insert into SalesLT.Product(Name, ProductNumber, ListPrice, StandardCost, SellStartDate)
values(@Name, @ProductNumber, @ListPrice, 0, GETDATE())
end
exec spAddNewProduct @Name = 'Uus toode', @ProductNumber = 'UT-001', @ListPrice = 150.00

-- 5
create proc spUpdateProductPrice
@ProductID int, @NewPrice money
as begin
update SalesLT.Product set ListPrice = @NewPrice where ProductID = @ProductID
end
exec spUpdateProductPrice @ProductID = 680, @NewPrice = 400.00

-- 6
create proc spDeleteCustomer
@CustomerID int
as begin
if exists(select 1 from SalesLT.SalesOrderHeader where CustomerID = @CustomerID)
    print 'on tellimused'
else
    delete from SalesLT.Customer where CustomerID = @CustomerID
end

-- 7
create proc spGetOrderCountByCustomer
@CustomerID int, @OrderCount int output
as begin
select @OrderCount = count(SalesOrderID)
from SalesLT.SalesOrderHeader where CustomerID = @CustomerID
end

-- 8
create proc spCheckProductPriceLevel
@ProductID int
as begin
declare @Price money
select @Price = ListPrice from SalesLT.Product where ProductID = @ProductID
if @Price > 1000 print 'Kallis'
else if @Price >= 100 print 'Keskmine'
else print 'Odav'
end