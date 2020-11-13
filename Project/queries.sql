-- 1. output all of the restaurants in the US
select distinct restaurant.name
from restaurant, location, country
where restaurant.locationkey = location.locationkey
    and location.countrykey = country.countrykey
    and country.name = "USA";

-- 2. find the restaurant w/ the highest average costs in its menu out of all the other restaurants
-- output the restaurant and its avg costs of its menu 
select restaurant.name, avg(menu.cost)
from restaurant, menu
group by restaurant.name
order by avg(menu.cost) limit 1;

-- 3. update the price of an item of Restaurant Anzu
update menu
set cost = 17
where item = "Garlic Chili Edamame"
    and menukey = 1;

-- 4. delete the tuple of an item of Restaurant Anzu
delete from menu
where item = "Garlic Chili Edamame"
    and menukey = 1;

-- 5. Count the number of distinct restaurants
-- that have menus containing items that have costs either in $14 or $16
select count(distinct restaurant.name)
from restaurant, menu
where restaurant.menukey = menu.menukey
    and menu.cost in (14, 16);

-- 6. Count the number of distinct restaurants
-- that have menus containing items that have costs of $14 and $16
select count(sq.name)
from
(
    select distinct restaurant.name
    from restaurant, menu
    where restaurant.menukey = menu.menukey
        and menu.cost in (14)
    intersect
    select distinct restaurant.name
    from restaurant, menu
    where restaurant.menukey = menu.menukey
        and menu.cost in (16)
) sq;

-- 7. Find the restaurants located in San Francisco, CA. 
-- Print the restaurant name and its address
select restaurant.name, location.address
from restaurant, location
where location.address like "%San Francisco, CA%"
    and restaurant.locationkey = location.locationkey
group by restaurant.name;

-- 8. compare the average menu cost of a restaurant in x location to a restaurant in y location
select res1.name, avg(m1.cost), res2.name, avg(m2.cost)
from restaurant res1, restaurant res2, menu m1, menu m2, location l1, location l2
-- menukeys of restaurant 1 and restaurant 2
where m1.menukey = res1.menukey
    and m2.menukey = res2.menukey
    -- locationkeys of restaurant 1 and restaurant 2
    and res1.locationkey = l1.locationkey
    and res2.locationkey = l2.locationkey
    -- addresses of restaurant 1 and restaurant 2
    and l1.address = "222 Mason St, San Francisco, CA 94102"
    and l2.address = "300 Grove St, San Francisco, CA 94102";

-- 9. For every restaurant, count the number of items in their menu
-- List the results in descending order
select restaurant.name, count(menu.item) as numItems
from restaurant, menu
where restaurant.menukey = menu.menukey
group by restaurant.name
order by count(menu.item) desc;

-- 10. Compare the number of restaurants in all countries.
-- Print 0 if there are none in the database
select c2.name, ifnull(sq.cnt, 0)
from country c2
left outer join
-- subquery to count # of restaurants in a country, not counting the ones with 0
(
    select country.name, count(restaurant.name) as cnt
    from country, restaurant, location
    where restaurant.locationkey = location.locationkey
        and location.countrykey = country.countrykey
    group by country.name
) sq on c2.name = sq.name;

-- 11. How many customers did not leave a review in x Restaurant?
select count(*)
from restaurant, customer
where restaurant.restaurantkey = customer.restaurantkey
    and restaurant.name != "Restaurant Anzu";

-- 12. What restaurants have restaurants in California and Texas
select restaurant.name
from restaurant, location
where restaurant.locationkey = location.locationkey
    and address like "%CA______"
intersect
select restaurant.name
from restaurant, location
where restaurant.locationkey = location.locationkey
    and address like "%TX______";

-- 13. What restaurants offer menus larger than x items?
select restaurant.name, count(menu.item) as menuSize
from restaurant, menu
where restaurant.menukey = menu.menukey
group by restaurant.name
having menuSize > 2;

-- 14. What are all the items offered for a restaurant in all their locations?
select distinct menu.item
from restaurant, menu
where restaurant.name = "BAIA"
    and restaurant.menukey = menu.menukey;

-- 15 to 20. insert queries

-- 21. to xx: additional queries

-- TEST QUERIES
-- count the restaurants in UK, currently 0 in the version i have

-- 10. test
-- select count(res1.name)
-- from restaurant res1, location l1, country c1
-- where res1.locationkey = l1.locationkey
-- and l1.countrykey = c1.countrykey
-- and c1.name = "UK"

-- select c1.name, count(distinct res1.name), c2.name, ifnull(count(distinct res2.name), 0)
-- from restaurant res1, restaurant res2, location l1, location l2, country c1, country c2
-- -- locationkeys of restaurant 1 and restaurant 2
-- where res1.locationkey = l1.locationkey
--     and res2.locationkey = l2.locationkey
-- -- countrykeys of restaurant 1 and restaurant 2
--     and l1.countrykey = c1.countrykey
--     and l2.countrykey = c2.countrykey
-- -- restaurants in the US and restaurants in the UK
--     and c1.name = "USA"
--     and c2.name = "UK"
-- group by c1.name, c2.name

-- 6. *** I think this is right b/c it doesn't count Restaurant Anzu anymore when I run query 3 b4 running this query
-- select restaurant.name, count(distinct restaurant.name)
-- from restaurant, menu,
-- (
--     -- select the restaurants with menu costs of 14
--     select distinct restaurant.name
--     from restaurant, menu
--     where restaurant.menukey = menu.menukey
--         and menu.cost in (14)
-- ) sq
-- where restaurant.menukey = menu.menukey
--     and menu.cost in (16);
