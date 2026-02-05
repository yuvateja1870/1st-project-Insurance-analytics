use Branchdata;

select *
from Brokerage;


/* 1. Target FY from individual target sheet.
caluculate total target value for the FY for each Branch/individual. */

select *
from budget;

select 
	sum(New_Budget)  as Total_New_Budget,
	sum(Cross_sell_bugdet) as Total_Cross_Sell_Budget,
	sum(Renewal_Budget) as Total_Renewal_Budget
from budget;




/* 2. Placed achievement from brokerage and fees.
calculate total placed achievement using brokerage and fees tables. */

select *
from fees;

select *
from Brokerage;

select 
	branch_name,
	sum(Amount) as Total_Brokerage_Amount
	from Brokerage
	group by branch_name;

select 
	branch_name,
	sum(Amount) as Total_Fees_Amount
from fees
group by branch_name;







/* 3. Invoice achievement from invoice table.
calculate total invoiced achievement for new business, 
cross sell and renewal */

select *
from invoice;


select
	Income_class,
	sum(Amount) as Total_Invoice_Achievement
from invoice
group by income_class;





/* 4. No of Meeting for current year.
find total meetings conducted in the current year. */

select *
from meeting;

select
	Branch_name,
	count(Account_Exe_ID) as Total_Meetings
from meeting
group by branch_name;



/* 5. open opportunity report.
count total open opportunies at proposal/solution/qualification stage. */


select *
from opportunity;

select 
	count(stage) as total_open_Opportunity
from opportunity
where stage in('Qualify Opportunity','Propose Solution');





/* 6. closed won opportunity report.
count opportunities tha are successfully won. */

select *
from opportunity;

select 
	count(stage) as Won_opportunities
from opportunity
where stage in ('Negotiate');




/* 7. conversion ratio
calculate conersion ratio b/w closed won opportunities and total opportunities. */

select * 
from opportunity;

select 
	(
	count
		(
		case when stage = 'Negotiate' then 1 end
		)*1.0 /
		count(stage)) as conersion_Ratio
from opportunity;





/* 8. drill down top 10 open opportunities.
display top 10 opportunities based on values. */

select *
from opportunity;

select Top 10 *
from opportunity
where stage <> 'Propose Solution'
	or stage <> 'Qualify Opportunity'
order by revenue_amount desc;




/* 9. no of invoices by account executive. */

select * 
from invoice;


select 
	Account_Executive,
	count(account_exe_Id) as accounts_count
from invoice
group by Account_Executive;




/* 10. year meeting count. */

select * 
from meeting;


select 
	year(meeting_date)  as year,
	count(Account_Exe_id)
from meeting
group by year(meeting_date);






/* 11. stage funnel by revenue. */

select *
from opportunity;

select 
	stage,
	sum(revenue_amount) as Total_Revenue_each_stage
from opportunity
group by stage;




/* 12. meetings by account executive. */

select *
from meeting;

select
	account_executive,
	count(account_exe_ID) as No_of_Meetings
from meeting
group by Account_Executive;
	
