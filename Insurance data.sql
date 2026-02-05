use Insurancedata;

select *
from Policy;


/* 1. Total policy count.
find the total no of policies. */

select *
from Policy;

select
	count(Policy_ID) as TotalPolicyCount
from Policy;




/* 2. Total customers
Find the total no of cutomers who hold at least one policy. */

select *
from CustomerInformation;

select
	count(distinct Customer_ID) as TotalCustomerCount
from policy;




/* 3. age bucket wise policy count
show policy count grouped by age buckets(18-24,25-34,35-44,45-54,55-64,65+). */

select *
from CustomerInformation;

alter table customerInformation
drop column Age_Bucket;

alter table CustomerInformation
add Age_Bucket as
	case
		when Age between 18 and 24 then '18-24'
		when Age between 25 and 34 then '25-34'
		when Age between 35 and 44 then '35-44'
		when Age between 45 and 54 then '45-54'
		when Age between 55 and 64 then '55-64'
		else '65 and above'
		end;

select 	*
from CustomerInformation;

select 
	case
		when Age between 18 and 25 then '18-25'
		when Age between 26 and 35 then '26-35'
		when Age between 36 and 45 then '36-45'
		when Age between 46 and 55 then '46-55'
		when Age between 56 and 65 then '56-65'
		else '66 and above'
		end as Age_Bucket,
		count(Policy_ID) as PolicyCount
from Policy
LEFT JOIN CustomerInformation
ON policy.Customer_ID = customerInformation.Customer_ID
group by 
	case
		when Age between 18 and 25 then '18-25'
		when Age between 26 and 35 then '26-35'
		when Age between 36 and 45 then '36-45'
		when Age between 46 and 55 then '46-55'
		when Age between 56 and 65 then '56-65'
		else '66 and above'
		end
order by Age_Bucket;




/* 4. Gender wise policy count
find the no of policies by gender. */

select *
from CustomerInformation;

select 
	Gender,
	count(Policy_ID) as PolicyCount
from CustomerInformation
LEFT JOIN Policy
ON Policy.Customer_ID = CustomerInformation.Customer_ID
group by Gender;




/* 5. policy type wise policy count
Find no of policies for each policy type. */

select * 
from Policy;

select 
	Policy_Type,
	count(Policy_ID) as PolicyCount
from Policy
group by Policy_Type;




/* 6. policies expiring this year
Find how many policies are expiring in the current year. */

select *
from Policy;

select 
	count(Policy_ID) as PoliciesExpiringThisYear
from Policy
where YEAR(Policy_End_Date) = YEAR(GETDATE());





/* 7. claims status wise policy count
Find the no of policies grouped by claim status(Approved, Rejected, pending). */

select *
from Claims;

select 
	Claim_Status,
	count(distinct Policy.Policy_ID) as PolicyCount
from Claims
Left JOIN Policy
ON Claims.Policy_ID = Policy.Policy_ID
group by Claim_Status;




/* 8. payment status wsie policy count
Find the no of policies by payment status (paid,overdue,pending). */

select *
from PaymentHistory;

select 
	Payment_Status,
	count(distinct Policy.Policy_ID) as PolicyCount
from PaymentHistory
LEFT JOIN Policy
ON PaymentHistory.Policy_ID = Policy.Policy_ID
group by Payment_Status;




/* 9. Total claim Amount
calculate the total claims amount paid across all policies. */


select *
from Claims;

select 
	sum(Claim_Amount) as TotalClaimAmount
	from Claims
	where Claim_Status = 'Approved';

