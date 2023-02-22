--I) Câu lệnh SELECT sử dụng các hàm thống kê với các mệnh đề Group by và Having

/* 1. Liệt kê danh sách các hóa đơn (SalesOrderID) lặp trong tháng 6 năm 2008 có
tổng tiền >70000, thông tin gồm SalesOrderID, Orderdate, SubTotal, trong đó
SubTotal =sum(OrderQty*UnitPrice). */
select d.SalesOrderID, OrderDate, SubTotal=sum(OrderQty * UnitPrice)
	from sales.SalesOrderDetail d join Sales.SalesOrderHeader h on d.SalesOrderID = h.SalesOrderID
	where  MONTH(OrderDate) = 6 and YEAR(OrderDate) = 2008  
	group by d.SalesOrderID, OrderDate
	having SUM(OrderQty * UnitPrice) > 70000

/* 2. Đếm tổng số khách hàng và tổng tiền của những khách hàng thuộc các quốc gia
có mã vùng là US (lấy thông tin từ các bảng SalesTerritory, Sales.Customer,
Sales.SalesOrderHeader, Sales.SalesOrderDetail). Thông tin bao gồm
TerritoryID, tổng số khách hàng (countofCus), tổng tiền (Subtotal) với Subtotal
= SUM(OrderQty*UnitPrice) */
select t.TerritoryID, CountofCus= COUNT(c.CustomerID) , Subtotal=SUM(d.OrderQty * d.UnitPrice)  
	from Sales.SalesTerritory t join Sales.Customer  c on t.TerritoryID=c.TerritoryID
								join Sales.SalesOrderHeader h on h.CustomerID=h.CustomerID
								join Sales.SalesOrderDetail d on h.SalesOrderID=d.SalesOrderID
	where CountryRegionCode = 'US' 
	group by t.TerritoryID

/* 3. Tính tổng trị giá của những hóa đơn với Mã theo dõi giao hàng
(CarrierTrackingNumber) có 3 ký tự đầu là 4BD, thông tin bao gồm
SalesOrderID, CarrierTrackingNumber, SubTotal=sum(OrderQty*UnitPrice) */
select SalesOrderID, CarrierTrackingNumber, Subtotal=SUM(OrderQty * UnitPrice) 
	from Sales.SalesOrderDetail
	where CarrierTrackingNumber like '4BD%'
	group by SalesOrderID, CarrierTrackingNumber

/* 4. Liệt kê các sản phẩm (product) có đơn giá (unitPrice)<25 và số lượng bán trung
bình >5, thông tin gồm ProductID, name, AverageofQty */
select pro.ProductID, pro.Name, AverageofQty=AVG(det.OrderQty) 
	from Sales.SalesOrderDetail det join Production.Product pro on det.ProductID = pro.ProductID
	where det.UnitPrice < 25
	group by pro.ProductID, pro.Name
	having AVG(det.OrderQty) > 5

/* 5. Liệt kê các công việc (JobTitle) có tổng số nhân viên >20 người, thông tin gồm
JobTitle, countofPerson=count(*) */
select JobTitle, CountofEmployee=count(BusinessEntityID) 
	from HumanResources.Employee 
	group by JobTitle
	having COUNT(BusinessEntityID) > 20

/* 6. Tính tổng số lượng và tổng trị giá của các sản phẩm do các nhà cung cấp có tên
kết thúc bằng ‘Bicycles’ và tổng trị giá >800000, thông tin gồm
BusinessEntityID, Vendor_name, ProductID, sumofQty, SubTotal */
select v.BusinessEntityID, v.Name, ProductID, sumofQty = SUM(OrderQty), SubTotal = SUM(OrderQty * UnitPrice)
	from Purchasing.Vendor v join Purchasing.PurchaseOrderHeader h on h.VendorID = v.BusinessEntityID
							 join Purchasing.PurchaseOrderDetail d on h.PurchaseOrderID = d.PurchaseOrderID
	where v.Name like '%Bicycles'
	group by v.BusinessEntityID, v.Name, ProductID
	having SUM(OrderQty * UnitPrice) > 800000	

/* 7. Liệt kê các sản phẩm có trên 500 đơn đặt hàng trong quí 1 năm 2008 và có tổng
trị giá >10000, thông tin gồm ProductID, Product_name, countofOrderID và
Subtotal */
select p.ProductID, p.Name, countofOrderID = COUNT(o.SalesOrderID), Subtotal = sum(OrderQty * UnitPrice) 
	from Production.Product p join Sales.SalesOrderDetail o on p.ProductID = o.ProductID
							  join sales.SalesOrderHeader h on h.SalesOrderID = o.SalesOrderID
	where Datepart(q, OrderDate) =1 and YEAR(OrderDate) = 2008
	group by p.ProductID, p.Name
	having sum(OrderQty * UnitPrice) > 10000 and COUNT(o.SalesOrderID) > 500

/* 8. Liệt kê danh sách các khách hàng có trên 25 hóa đơn đặt hàng từ năm 2007 đến
2008, thông tin gồm mã khách (PersonID) , họ tên (FirstName +' '+ LastName
as fullname), Số hóa đơn (CountOfOrders). */
select PersonID, FirstName +' '+ LastName as fullname, CountOfOrders=count(*)
from [Person].[Person] p join [Sales].[Customer] c on p.BusinessEntityID=c.CustomerID
						 join [Sales].[SalesOrderHeader] h on h.CustomerID= c.CustomerID
where YEAR([OrderDate])>=2007 and YEAR([OrderDate])<=2008
group by PersonID, FirstName +' '+ LastName
having count(*)>25

/* 9. Liệt kê những sản phẩm có tên bắt đầu với ‘Bike’ và ‘Sport’ có tổng số lượng
bán trong mỗi mỗi năm trên 500 sản phẩm, thông tin gồm ProductID, Name,
CountofOrderQty, year. (dữ liệu lấy từ các bảng Sales.SalesOrderHeader,
Sales.SalesOrderDetail, and Production.Product) */
select p.ProductID, Name, CountofOrderQty=sum([OrderQty]), yearofSale=year([OrderDate])
from [Production].[Product] p join [Sales].[SalesOrderDetail] d on p.ProductID=d.ProductID
							  join [Sales].[SalesOrderHeader] h on d.SalesOrderID=d.SalesOrderID
where name like 'Bike%' or name like 'Sport%'
group by p.ProductID, Name, year([OrderDate])
having sum([OrderQty])>500

/* 10. Liệt kê những phòng ban có lương (Rate: lương theo giờ) trung bình >30, thông
tin gồm Mã phòng ban (DepartmentID), tên phòng ban (name), Lương trung bình
(AvgofRate). Dữ liệu từ các bảng [HumanResources].[Department],
[HumanResources].[EmployeeDepartmentHistory],
[HumanResources].[EmployeePayHistory]. */
select d.DepartmentID, d.name, AvgofRate=avg([Rate])
from [HumanResources].[Department] d join [HumanResources].[EmployeeDepartmentHistory] h on d.DepartmentID=h.DepartmentID
									 join [HumanResources].[EmployeePayHistory] e on h.BusinessEntityID=e.BusinessEntityID
group by d.DepartmentID, d.name
having avg([Rate])>30

-- II) Subquery

/* 1. Liệt kê các sản phẩm gồm các thông tin product names và product ID có trên
100 đơn đặt hàng trong tháng 7 năm 2008 */
select ProductID, Name
from Production.Product
where ProductID in (select ProductID
					from  Sales.SalesOrderDetail d join Sales.SalesOrderHeader h on d.SalesOrderID=h.SalesOrderID
					where MONTH(OrderDate)=7 and YEAR(OrderDate)=2008
					group by  ProductID
					having COUNT(*)>100)
---
select ProductID, Name
from Production.Product p 
where  exists (select ProductID
					from  Sales.SalesOrderDetail d join Sales.SalesOrderHeader h on d.SalesOrderID=h.SalesOrderID
					where MONTH(OrderDate)=7 and YEAR(OrderDate)=2008 and ProductID=p.ProductID
					group by  ProductID
					having COUNT(*)>100)

/* 2. Liệt kê các sản phẩm (ProductID, name) có số hóa đơn đặt hàng nhiều nhất trong
tháng 7/2008 */
select p.ProductID, Name
from Production.Product p join Sales.SalesOrderDetail d on p.ProductID=d.ProductID
	                      join Sales.SalesOrderHeader h on d.SalesOrderID=h.SalesOrderID
where  MONTH(OrderDate)=7 and YEAR(OrderDate)=2008
group by p.ProductID, Name
having COUNT(*)>=all( select COUNT(*)
					  from Sales.SalesOrderDetail d join Sales.SalesOrderHeader h on d.SalesOrderID=h.SalesOrderID
	                  where MONTH(OrderDate)=7 and YEAR(OrderDate)=2008
					  group by ProductID

/* 3. Hiển thị thông tin của khách hàng có số đơn đặt hàng nhiều nhất, thông tin gồm:
CustomerID, Name, CountofOrder */
select 	c.CustomerID, CountofOrder=COUNT(*)
from Sales.Customer c join Sales.SalesOrderHeader h on c.CustomerID=h.CustomerID
group by c.CustomerID
having COUNT(*)>=all(select COUNT(*)
					 from Sales.Customer c join Sales.SalesOrderHeader h on c.CustomerID=h.CustomerID
					 group by c.CustomerID)	

/* 4. Liệt kê các sản phẩm (ProductID, Name) thuộc mô hình sản phẩm áo dài tay với
tên bắt đầu với “Long-Sleeve Logo Jersey”, dùng phép IN và EXISTS, (sử dụng
bảng Production.Product và Production.ProductModel */
select ProductID, Name
from Production.Product 
where ProductModelID in (select ProductModelID 
						 from Production.ProductModel
						 where Name like 'Long-Sleeve Logo Jersey%')

select ProductID, Name
from Production.Product p
where exists (select ProductModelID 
						 from Production.ProductModel
						 where Name like 'Long-Sleeve Logo Jersey%' and ProductModelID=p.ProductModelID)

/* 5. Tìm các mô hình sản phẩm (ProductModelID) mà giá niêm yết (list price) tối đa
cao hơn giá trung bình của tất cả các mô hình. */
select p.ProductModelID, m.Name, max(ListPrice)
from Production.ProductModel m join Production.Product p on m.ProductModelID=p.ProductModelID
group by p.ProductModelID, m.Name
having max(ListPrice)>=all(select AVG(ListPrice)
							from Production.ProductModel m join Production.Product p on m.ProductModelID=p.ProductModelID
							)

/* 6. Liệt kê các sản phẩm gồm các thông tin ProductID, Name, có tổng số lượng đặt
hàng >5000 (dùng In, exists) */
select ProductID, Name
from Production.Product 
where ProductID in (select ProductID 
					from Sales.SalesOrderDetail
					group by ProductID
					having SUM(OrderQty)>5000)
select ProductID, Name
from Production.Product p
where exists (select ProductID 
					from Sales.SalesOrderDetail
					where ProductID=p.ProductID
					group by ProductID
					having SUM(OrderQty)>5000)

/* 7. Liệt kê những sản phẩm (ProductID, UnitPrice) có đơn giá (UnitPrice) cao nhất
trong bảng Sales.SalesOrderDetail */
select distinct ProductID, UnitPrice
from Sales.SalesOrderDetail
where UnitPrice>=all (select distinct UnitPrice
					 from Sales.SalesOrderDetail)

/* 8. Liệt kê các sản phầm không có đơn đặt hàng nào thông tin gồm ProductID,
Name, dùng 3 cách Not in, not exists và left join. */
select P.productID, Name
from Production.Product p left join Sales.SalesOrderDetail d on p.ProductID=d.ProductID
where d.ProductID is null

select productID, Name
from Production.Product
where productID not in (select productID 
						from Sales.SalesOrderDetail)

select productID, Name
from Production.Product p
where not exists (select productID 
				  from Sales.SalesOrderDetail
				  where p.ProductID=ProductID)

/* 9. Liệt kê các nhân viên không lập hóa đơn từ sau ngày 1/5/2008, thông tin gồm
EmployeeID, FirstName, LastName (dữ liệu từ 2 bảng HR.Employees và
Sales.Orders) */
select [BusinessEntityID] as EmployeeID, FirstName, LastName
from [Person].[Person]
where [BusinessEntityID]  in (select [SalesPersonID]
								 from [Sales].[SalesOrderHeader]
								 where [OrderDate]>'2008-5-1'
								 )

/* 10. Liệt kê danh sách các khách hàng (customerID, name) có hóa đơn dặt hàng trong
năm 2007 nhưng có hóa đơn đặt hàng trong năm 2008. */
select [CustomerID]
from [Sales].[SalesOrderHeader]
where [CustomerID] in (select [CustomerID]
					   from [Sales].[SalesOrderHeader]
					   where year([OrderDate])=2007 )  
	and [CustomerID] not in (select [CustomerID]
					   from [Sales].[SalesOrderHeader]
					   where year([OrderDate])=2008)
