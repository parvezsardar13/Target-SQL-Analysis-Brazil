with final as (
Select extract(year from order_purchase_timestamp) as year_dt,
round(sum(payment_value),2) as total_cost
from
`
scaler-488208.Target.orders
`
inner join
`
scaler-488208.Target.payments
`
using(order_id)
where extract(year from order_purchase_timestamp) in (2017,2018)
and extract(month from order_purchase_timestamp) between 1 and 8
group by 1)
Select year_dt, total_cost,
round(100* (lead(total_cost) over(order by year_dt) -
total_cost)/total_cost,2) as Perc_cost_inc
from final
