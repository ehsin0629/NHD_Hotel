--List the total sales for each dealer over a month’s time frame. 

select DealerName,Month(SaleDate) as SalesMonth, sum(SaleAmount) as TotalSales 
from SaleHeader sh inner join DealerBooths db
on sh.DealerBoothID=db.DealerBoothID inner join Dealer d
on db.DealerID=d.DealerID
group by DealerName,Month(SaleDate);


--List the amount due from NHD to each dealer after all deductions are considered in a particular month.
 
select d.DealerName,month(Date) as DueMonth, sum(PaymentAmount) as DueAmount
from Rent r inner join DealerBooths db
on r.DealerBoothID=db.DealerBoothID inner join Dealer d
on db.DealerID=d.DealerID
group by d.DealerName,month(Date);


--List the dealers and their corresponding booth(s) lease details. 

select d.DealerName,b.BoothName,IsRent,Rent 
from DealerBooths db inner join Dealer d
on db.DealerID=d.DealerID inner join Booth b
on db.BoothID=b.BoothID;


--List the revenues for NHD in a particular month. 

select	month(Date) as Month,
	sum(RentAmount+Commisson) as TotalRevenue
from Rent
Group by month(Date);


--List the booths that have not been leased.

select * 
from Booth
where IsRent=0;

