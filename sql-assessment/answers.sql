-- q1
select date as day, sum(impressions) as impressions
from marketing_data
group by day;

-- q2
select state, sum(revenue) as total_revenue
from website_revenue
group by state
order by total_revenue desc; -- OH: 37577

-- q3
select campaign_info.name as campaign, 
	sum(marketing_data.cost) as cost, 
	sum(website_revenue.revenue) as revenue, 
	sum(marketing_data.impressions) as impressions, 
	sum(marketing_data.clicks) as clicks
from pmg.campaign_info
inner join pmg.marketing_data on campaign_info.id = marketing_data.campaign_id
inner join pmg.website_revenue on campaign_info.id = website_revenue.campaign_id
group by campaign_info.name;

-- q4
select campaign_info.id from pmg.campaign_info where campaign_info.name = 'Campaign5' 

select website_revenue.state as state, sum(marketing_data.clicks - marketing_data.impressions) as conversions
from pmg.website_revenue
inner join pmg.marketing_data on website_revenue.campaign_id = marketing_data.campaign_id
where website_revenue.campaign_id = 99058240
group by state

-- q5
select campaign_info.name as campaign, 
  sum(marketing_data.cost) as cost, 
  sum(website_revenue.revenue) as revenue, 
  sum(website_revenue.revenue) - sum(marketing_data.cost) as profit,
  (sum(website_revenue.revenue) - sum(marketing_data.cost)) / (sum(marketing_data.cost)) * 100 as ROI,
  sum(marketing_data.impressions - marketing_data.clicks) as conversions,
  sum(marketing_data.impressions - marketing_data.clicks) / sum(marketing_data.cost) as conversions_per_dollar
from pmg.campaign_info
inner join pmg.marketing_data on campaign_info.id = marketing_data.campaign_id
inner join pmg.website_revenue on campaign_info.id = website_revenue.campaign_id
group by campaign_info.name;


-- For efficiency, I looked at everything relative to how much it cost to achieve certain metrics. The two main metrics I
-- thought might be relevant were conversions and campaign profit, or ROI [ (profit/cost) * 100 ]. With this in mind, we see that
-- Campaign4 had the highest ROI % while also getting the most conversions per dollar spent. 

-- Campaign3 had the highest raw numbers (profit and # conversions), but because of its higher cost, failed to achieve similar ROI % and
-- conversions per dollar as Campaign4.