select * from final_data

--Modifying columns 
ALTER Table final_data ALTER column "reviewTime" type DATE using to_date("reviewTime",'YYYY-MM-DD');
ALTER TABLE final_data ALTER column overall type numeric;
ALTER TABLE final_data ALTER column vote type numeric;
ALTER TABLE final_data ALTER column price type numeric;
ALTER table final_data rename column "reviewTime" to review_time;
ALTER table final_data rename column "reviewerName" to reviewer_name;
ALTER table final_data rename column "reviewText" to review_text;
ALTER table final_data rename column "reviewerID" to reviewer_id;


                                  --KPIs--

--total_reviews
select count(*) 
from final_data
--99,963 reviews

--total_reviewers
select count(distinct(reviewer_id))
from final_data
--76,741 reviewers

--total_products reviewed
select count(distinct(asin))
from final_data
--1,937 products

--total categories reviewed
select count(distinct(main_cat))
from final_data
--28 categories


                                  --Queries--

--num of reviews per product
select asin,title,count(reviewer_id) as num_of_reviews
from final_data
group by asin,title
order by count(reviewer_id) desc
--"Tiffen 62mm& 58mm UV Protection Filter" have maximum num of reviews i.e,4525
--whereas there are many products with only 1 review



--top 10 categories with max reviews
select main_cat,count(reviewer_id) as num_of_reviews
from final_data
group by main_cat
order by count(reviewer_id) asc
limit 10
--All Electronics cat has the max reviews 24940



--Avg rating of products on amazon
select avg_of_rating, count(asin)
from(select asin,title,main_cat, round(avg(overall)) as avg_of_rating
from final_data
group by asin,title,main_cat
order by avg(overall) desc)
group by avg_of_rating
order by avg_of_rating desc
-- there are around 788 products with an avg rating of 5 and 14 products with avg rating of 1



--Avg rating of product category on amazon
select main_cat, round(avg(overall)) as avg_of_rating
from final_data
group by main_cat
order by avg(overall) asc
--toys and games have the least avg_rating 2



--reviewer with most reviews
select reviewer_name,count(asin) as num_of_product_reviewed
from final_data
group by reviewer_name
order by count(asin) desc
--Amazon customer has reviewed the most products i.e, 2917 followed by
--kindle customer and mike with 365 and 190 products reviewed respectively 



--monthly trend of reviews
select extract(month from review_time) as month_num_of_review,
to_char(review_time,'Mon') as review_month,
count(asin) as num_of_reviews
from final_data 
group by extract(month from review_time),to_char(review_time,'Mon') 
order by extract(month from review_time) 
--jan has the max reviews of 10432 followed by dec with 9677 reviews.



--yearly trend of reviews
select extract(year from review_time) as year_of_review,
count(asin) as num_of_reviews
from final_data 
group by extract(year from review_time) 
order by extract(year from review_time) asc
--2015 had the most reviews followed by 2014 whereas 1999 had the least num of reviews



--product with lower price and high rating
select title, round(avg(overall)) as avg_rating, round(avg(price)) as avg_price
from final_data 
group by title
having round(avg(overall)) in (4,5) and round(avg(price)) in (1,2)
order by avg(price),avg(overall) desc
--



--Products with high rating but less reviews
select title, round(avg(overall)) as avg_rating,
count(reviewer_id) as num_of_reviews
from final_data
group by title
having round(avg(overall))=5 and count(reviewer_id)<10
order by round(avg(overall)),count(reviewer_id) asc
-- there are around 400+ such products



--Products with most helpful votes
select title, round(avg(vote)) as avg_vote
from final_data 
group by title
order by avg(vote) desc
--"Panasonic PVDV52 MiniDV Digital Camcorder w/ 2.5&quot; Color LCD (Discontinued by Manufacturer)" 
--has most helpful votes 327



--avg rating by each reviewer
select reviewer_name, round(avg(overall)) as avg_rating
from final_data 
group by reviewer_name
order by avg(overall) desc
-- there are many reviewers whose avg rating is 5 but there are reviewers as well whose avg rating is 1.



--top 10 Products with increasing reviews year by year  
WITH yearly_counts AS (
SELECT asin,
EXTRACT(YEAR FROM review_time) AS review_year,
COUNT(*) AS review_count
FROM final_data
GROUP BY asin, EXTRACT(YEAR FROM review_time)
order by asin
),
with_diff AS (
SELECT
asin,
review_year,
review_count,
LAG(review_count) OVER (PARTITION BY asin ORDER BY review_year) AS prev_count
FROM yearly_counts
),
only_increasing AS (
SELECT asin
FROM with_diff
WHERE prev_count IS NOT NULL AND review_count > prev_count
GROUP BY asin
HAVING COUNT(*) = (SELECT COUNT(*) FROM yearly_counts yc WHERE yc.asin = with_diff.asin) - 1
),
top_10 AS (
SELECT title
asin,
COUNT(*) AS total_reviews
FROM final_data 
WHERE asin IN (SELECT asin FROM only_increasing)
GROUP BY asin,title
ORDER BY total_reviews DESC
LIMIT 10
)
SELECT * FROM top_10;




--distribution of price in diff category
select main_cat, round(avg(price),2) as avg_price
from final_data
where price is not null
group by main_cat
order by avg(price) desc
--video game is the most expensive and health and personal care category is the cheapest


--Price distribution of diff products
select title, round(avg(price)) as avg_price
from final_data
where price is not null
group by title
order by avg(price) desc
--PS One &amp; LCD Screen Combo is most expensive product and
--"Hosa GMD-108 5-Pin DIN to 5-Pin DIN MIDI Coupler" is the cheapest product
--Price range of products is from 2000-1


-- Effect of price on num_of_reviews and avg_rating
select title,price, count(*) as num_of_reviews,avg(overall) as avg_rating
from final_data
where price is not null
group by title,price
order by price asc
--there is no such effect of price on avg_rating its widely distributed whereas
--price does have effect on num_of_reviews



--top 10 products with high range of price
with price_detail as(
select main_cat,
max(price) over(partition by main_cat) as max_price,
min(price) over(partition by main_cat) as min_price
from final_data
where price is not null)
select *,
max_price - min_price as price_range
from price_detail 
group by main_cat,max_price,min_price
order by max_price - min_price desc
limit 10
--All Electronics cat has the most wide price range



              --Insights from sql query--
/*
total reviews =99,963 reviews
total reviewers =76,741 reviewers
total products reviewed=1,937 products
total categories reviewed=28 categories

-"Tiffen 62mm& 58mm UV Protection Filter" have maximum num of reviews i.e,4525 
  whereas there are many products with only 1 review

-All Electronics cat has the max reviews 24940

-there are around 788 products with an avg rating of 5 and 14 products with avg rating of 1

-toys and games cat have the least avg_rating 2

-Amazon customer has reviewed the most i.e, 2917 followed by
 kindle customer and mike with 365 and 190 reviews respectively 

-jan has the max reviews of 10432 followed by dec with 9677 reviews.

-2015 had the most reviews followed by 2014 whereas 1999 had the least num of reviews

-there are around 70+ products with lower price and high rating

-there are around 400+ products with high rating but less reviews

-there are many reviewers whose avg rating is 5 but there are reviewers as well whose avg rating is 1.So
 nothing can be figured as such from this data

-there are some products whose reviews are increasing year over year

-video game is the most expensive and health and personal care category is the cheapest category

-PS One &amp; LCD Screen Combo is most expensive product and
  "Hosa GMD-108 5-Pin DIN to 5-Pin DIN MIDI Coupler" is the cheapest product
   Price range of products is from $1-$2000

-there is no such effect of price on avg_rating its widely distributed whereas
  price does have effect on num_of_reviews

-All Electronics cat has the most wide price range.
*/






