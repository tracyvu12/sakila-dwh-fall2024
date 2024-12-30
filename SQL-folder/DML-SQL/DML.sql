-- fact_payment_rental_inventory
select
    p.payment_id,
    p.customer_id,
    p.staff_id as staff_payment,
    p.amount as payment_amount,
    p.payment_date,
    r.rental_date,
    r.return_date,
    r.staff_id as staff_rental,
    i.film_id,
    i.store_id
from payment p 
    left join rental r 
        using(rental_id) 
    left join inventory i
        using (inventory_id)
order by 1;

-- dim_staff
select 
    staff_id,
    concat(first_name, ' ', last_name) as employee_full_name,
    active,
    email
from staff;

-- dim store
select 
    s.store_id,
    concat(st.first_name, ' ', st.last_name) as manager_full_name,
    a.address,
    a.district,
    ci.city,
    co.country
from store s
    left join address a using(address_id)
    left join city ci using(city_id)
    left join country co using(country_id)
    left join staff st on s.manager_staff_id = st.staff_id;

-- dim customer
select 
    customer_id,
    concat(first_name, ' ', last_name) as customer_full_name,
    create_date,
    active
from customer;

-- film
select
    f.film_id,
    f.title,
    f.release_year,
    l.name as language_name,
    f.rental_duration,
    f.rental_rate,
    f.length,
    f.replacement_cost,
    f.rating,
    c.name as category_name,
    count(fa.actor_id) as number_of_actor
from film f
    left join language l using(language_id)
    left join film_category fc using(film_id)
    left join category c using(category_id)
    left join film_actor fa using(film_id)
group by 1, 2, 3, 4, 5, 6, 7, 8, 9, 10;