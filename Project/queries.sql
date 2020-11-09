-- 1. output all of the restaurants in the US
select restaurant.name
from restaurant, location, country
where restaurant.locationkey = country.locationkey
    and country.name = "USA";

-- 2. output the restaurant and its avg costs of its menu 
-- where that restaurant has the highest average costs in its menu out of all the restaurants
select restaurant.name, avg(menu.cost)
from restaurant, menu
group by restaurant.name
order by avg(menu.cost) limit 1;

-- 3.