

-- Harjutus 1 
select ProductID, Name, ListPrice, Weight
from SalesLT.Product
where ListPrice > 500 and Weight > 500;


-- Harjutus 2 
select Product.ProductID, Product.Name
from SalesLT.Product
join SalesLT.ProductCategory on
Product.ProductCategoryID = ProductCategory.ProductCategoryID
where ProductCategory.Name in ('Mountain Bikes', 'Road Bikes')


-- Harjutus 3 
select Name, ListPrice,
ListPrice * 0.85 AS DiscountPrice
from SalesLT.Product where ListPrice > 0;


-- Harjutus 4 
select Name, ListPrice,
ListPrice * 1.22 AS PriceWithVAT
from SalesLT.Product where ListPrice > 0;

-- Harjutus 5
create procedure GetProduct @ID int
as
select * from SalesLT.Product where ProductID = @ID;
exec GetProduct 680;


-- Harjutus 6
create procedure GetByCategory @Category nvarchar(100)
as
select Product.Name, Product.ListPrice from SalesLT.Product
join SalesLT.ProductCategory 
on Product.ProductCategoryID = ProductCategory.ProductCategoryID
where ProductCategory.Name = @Category;
exec GetByCategory 'Road Bikes';


-- Harjutus 7
create procedure AddCustomer 
@FirstName nvarchar(50), 
@LastName nvarchar(50), 
@Email nvarchar(100) as
insert into SalesLT.Customer (FirstName, LastName, EmailAddress)
values (@FirstName, @LastName, @Email);
exec AddCustomer 'Billi', 'Butcher', 'billi@email.ee';

-- Harjutus 8
create table NewProductLog 
(
    LogId int identity primary key,
    ProductId int,
    ProductName nvarchar(100),
    InsertDate DateTime default GETDATE()
);

create trigger trNewProduct
on SalesLT.Product
after insert
as begin
    insert into NewProductLog (ProductId, ProductName)
    select ProductID, Name from inserted
end;


-- Harjutus 9 
create table NewCustomerLog 
(
    LogId int identity primary key,
    CustomerId int,
    LogDate DateTime default GETDATE()
);

create trigger NewCustomer
on SalesLT.Customer
after insert
as begin
    insert into NewCustomerLog (CustomerId)
    select CustomerID from inserted
end;