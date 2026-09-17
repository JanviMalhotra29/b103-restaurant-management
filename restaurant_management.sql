
show databases;
create schema b103_restaurant_management;
use b103_restaurant_management;

#creating tables
create table customers (
customer_id int auto_increment primary key,
first_name varchar(50)not null,
last_name varchar(50) not null,
email varchar(100) not null,
phone_number varchar(20) not null
);
show tables;

create table restaurant(
restaurant_id int auto_increment primary key,
restaurant_name varchar(100) not null,
address varchar(200) not null,
phone_number varchar(20) not null,
email varchar(100) not null
);
show tables;

create table employees(
employee_id int auto_increment primary key,
restaurant_id int not null,
first_name varchar(50) not null,
last_name varchar(50) not null,
job_title varchar(50) not null, 
phone_number varchar(20) not null,
email varchar(100) not null,
foreign key (restaurant_id) references restaurant(restaurant_id)
);
show tables;

create table restaurant_tables(
table_id int auto_increment primary key,
restaurant_id int not null,
table_number int not null,
capacity int not null,
table_status varchar(20) not null default 'Available',
foreign key (restaurant_id) references restaurant(restaurant_id), 
unique (restaurant_id, table_number)
);
show tables;

create table menu_items(
menu_item_id int auto_increment primary key,
restaurant_id int not null,
category varchar(50) not null,
item_name varchar(50) not null,
price decimal(10,2) not null,
description varchar(255),
foreign key (restaurant_id) references restaurant(restaurant_id)
);
show tables;

create table reservations(
reservation_id int auto_increment primary key,
customer_id int not null,
table_id int not null,
reservation_date date not null,
reservation_time time not null,
number_of_guests int not null,
reservation_status varchar(20) not null default 'Reserved',
foreign key (customer_id) references customers(customer_id),
foreign key (table_id) references restaurant_tables(table_id)
);
show tables;

create table orders(
order_id int auto_increment primary key,
customer_id int not null,
restaurant_id int not null,
reservation_id int,
order_date date not null,
order_time time not null,
order_status varchar(20) not null default 'Pending',
foreign key (customer_id) references customers(customer_id),
foreign key (restaurant_id) references restaurant(restaurant_id),
foreign key (reservation_id) references reservations(reservation_id)
);
show tables;

create table order_items(
order_item_id int auto_increment primary key,
order_id int not null,
menu_item_id int not null,
quantity int not null,
price decimal(10,2) not null,
foreign key (order_id) references orders(order_id),
foreign key (menu_item_id) references menu_items(menu_item_id)
);
show tables;

create table payments(
payment_id int auto_increment primary key,
order_id int not null,
payment_date date not null,
payment_time time not null,
payment_method varchar(20) not null,
amount decimal(10,2) not null,
payment_status varchar(20) not null default 'Completed',
foreign key (order_id) references orders(order_id)
);
show tables;

#constraints 
alter table menu_items
add constraint chk_menu_price
check (price > 0);

alter table order_items
add constraint chk_order_item_quantity
check (quantity > 0);

alter table order_items
add constraint chk_order_item_price
check (price > 0);

alter table payments
add constraint chk_payment_amount
check (amount > 0);

alter table customers
add constraint uq_customer_email
unique (email);

#inserting data values 
insert into restaurant (restaurant_name , address , phone_number , email)
values ('Ristorante Firenze' , 'Florastrasse 27 , Berlin' , '0145269873' , 'stefano_2019@icloud.com'),
('El Pasto' , 'Maximilianstrasse 1 , Berlin' , '0478965632' , 'pasto@gmail.com'),
('Amrit' , 'Oranienburg strasse 34, Berlin' , '0145987652' , 'amritinberlin@gmail.com');

insert into customers (first_name , last_name , email , phone_number)
values ('Muskan' , 'Sharma' , 'muskan123@gmail.com' , '0145789632'),
('Karan' , 'Sandhu' , 'karansandhu3@gmail.com' , '0456978725'),
('Vansh' , 'Sehdev' , 'vansh@gmail.com' , '0124578965'),
('Aish' , 'Kapoor' , 'aish123@gmail.com' , '0145897652'),
('Gaurish' , 'Sharma' , 'gaurish123@gmail.com' , '0121212526');

insert into employees (restaurant_id , first_name , last_name ,job_title , phone_number , email)
values (1 , 'John' , 'Surve' , 'Chef' , '0147896321' , 'johnss@gmail.com'),
(1 , 'Arjun' , 'Muller' , 'Manager' , '0121236598' , 'arjunn@gmail.com'),
(2 , 'Mehak' , 'Surve' , 'Chef' , '0147896321' , 'johnss@gmail.com'),
(3 , 'Nadia' , 'Ali' , 'Cleaner' , '0128957462' , 'nadia@gmail.com'),
(2 , 'Shehnaz' , 'Gill' , 'Manager' , '0258976431' , 'shehnazz@gmail.com');

insert into restaurant_tables (restaurant_id , table_number , capacity , table_status)
values ('1' , '1' , '2' , 'Available'),
('1' , '3' , '6' , 'Available'),
('2' , '1' , '2' , 'Available'),
('2' , '2' , '4' , 'Available'),
('3' , '2' , '4' , 'Available'),
('3' , '3' , '6' , 'Available');

insert into menu_items (restaurant_id , category , item_name , price , description)
values (1, 'Pasta' , 'Alfredo' , 9.50 , 'noodles with butter and parmesan cheese'),
(1, 'Pizza' , 'Margherita' , 12.50 , 'classic tomato and mozarella cheese'),
(2, 'Main Course' , 'Paneer Jalfrezi' , 13.50 , 'paneer cheese cubes and bell peppers,onions and tomatoes tossed in spicy tomato-onion masala'),
(2, 'Dessert' , 'Tiramisu' , 6.50 , 'classic Italian dessert'),
(2, 'Main Course' , 'Chicken biryani' , 12.50 , 'Fragrant rice with spiced chicken'),
(3, 'Starter' , 'Samosa' , 6.00 , 'Crispy pastry with spices boiled potato and masala filling'),
(3, 'Salad' , 'Green salad' , 5.50 , 'mixed green salad'),
(3 , 'Main Course' , 'Grilled Vegetables' , 12.50 , 'seasonal grilled veggies');

insert into reservations (customer_id , table_id , reservation_date , reservation_time , number_of_guests , reservation_status)
values ('1' , '1' , '2026-08-20' , '14:30:00' , '2' , 'Reserved'),
('2' , '2' , '2026-08-21' , '20:00:00' , '4' , 'Reserved'),
('3' , '3' , '2026-08-22' , '22:30:00' , '2' , 'Reserved'),
('4' , '4' , '2026-08-23' , '23:00:00' , '4' , 'Reserved'),
('5' , '5' , '2026-08-24' , '17:30:00' , '2' , 'Reserved');

insert into orders (customer_id , restaurant_id ,reservation_id , order_date , order_time , order_status)
values (1 , 1 , 1 , '2026-08-20' , '14:45:00' , 'Completed'),
(2 , 1 , 2 , '2026-08-21' , '15:55:00' , 'Pending'),
(3 ,2 , 3 , '2026-08-22' , '22:30:00' , 'Completed'),
(4 , 2 , 4 , '2026-08-23' , '23:10:00' , 'Completed'),
(5 , 3 , 5 , '2026-08-24' , '17:30:00' , 'Pending'),
(2 , 1 , 2 , '2026-08-25' , '22:30:00' , 'Completed');

insert into order_items (order_id , menu_item_id , quantity , price)
values(1 , 1 , 2 , 9.50),
(1, 2, 1, 12.50),
(2, 3, 2, 13.50),
(2, 4, 1, 6.50),
(3, 5, 2, 12.50),
(3, 6, 2, 6.00),
(4, 3, 1, 13.50),
(4, 4, 2, 6.50),
(5, 7, 2, 5.50),
(6, 8, 1, 12.50);

insert into payments (order_id, payment_date, payment_time, payment_method, amount, payment_status)
values(1, '2026-08-20', '14:55:00', 'Card', 31.50, 'Completed'),
(2, '2026-08-21', '16:55:00', 'Cash', 33.50, 'Pending'),
(3, '2026-08-22', '22:50:00', 'Card', 37.00, 'Completed'),
(4, '2026-08-23', '23:50:00', 'Card', 26.50, 'Completed'),
(5, '2026-08-24', '17:30:00', 'Cash', 11.00, 'Pending'),
(6, '2026-08-25', '22:30:00', 'Card', 12.50, 'Completed');

#to check inserted data
select * 
from customers;

select * 
from restaurant;

select * 
from employees;

select * 
from restaurant_tables;

select * 
from menu_items;

select * 
from reservations;

select * 
from orders;

select * 
from order_items;

select * 
from payments;

#1-CRUD operations 
#Create - insert a customer for CRUD operation test
insert into customers (first_name , last_name , email , phone_number)
values ('Christina' , 'Lovis' , 'chrislove@gmail.com' , '0147741474');

#Read
select *
from customers 
where email = 'chrislove@gmail.com';

#Update customer's phone number
update customers set phone_number = '0258522585'
where email = 'chrislove@gmail.com';

select *
from customers 
where email = 'chrislove@gmail.com';

#deleting a customer
delete from customers
where email = 'chrislove@gmail.com';

select *
from customers
where email = 'chrislove@gmail.com';

#update menu item
update menu_items
set price = 12.50
where menu_item_id = 1;

select *
from menu_items
where menu_item_id = 1;

#update order status
update orders
set order_status = 'completed'
where order_id = 2;

select *
from orders
where order_id = 2;

#Data retrieval and filtering
#find menu items with price above 10
select *
from menu_items
where price >10;

#find main course items above 10
select *
from menu_items
where price >10 and category = 'Main Course';

select *
from menu_items
where category= 'Pizza' or category = 'Main Course';

#displaying menu from highest to lowest price and vice versa 
select *
from menu_items
order by price desc; 

select *
from menu_items
order by price asc; 

select distinct category
from menu_items;

#aggregate functions
select count(*) as no_of_employees
from employees;

select sum(amount) as total_completed_payments
from payments 
where payment_status ='Completed';

select avg(amount) as avg_amount
from payments;

select item_name , price
from menu_items
where price = (select min(price) as cheapest_item from menu_items)
or price = (select max(price) as expensive_item from menu_items);

#count completed orders received by each restaurant
select restaurant_id,
count(*) as number_of_orders
from orders
where order_status ='Completed'
group by restaurant_id;

select *
from menu_items
where category in ('Main Course','Dessert');

#finding customers with name starting with V
select *
from customers 
where first_name like 'V%';

#finding restautant whose name has 'i' in it 
select *
from restaurant 
where restaurant_name like '%i%';

select *
from orders 
where reservation_id is not null;

#displaying customers with full names 
select concat (first_name, ' ' , last_name) as full_name,
email
from customers;

#display restaurant names in uppercase
select restaurant_name,
upper (restaurant_name)
from restaurant;

#classify menu items according to their price
select item_name , price,
case 
	when price <7 then 'In Budget'
	when price >=7 and price <12 then 'Standard'
	else 'Out of budget'
end as price_category
from menu_items;

# total orders in August 2026
select count (*) 
from orders 
where year(order_date)= 2026 and month(order_date)=8;

#Group by
#count total orders according to order status
select order_status,
count (*) as number_of_orders
from orders 
group by order_status;

#calculating average payment amount for each payment method
select payment_method,
avg(amount) as average_payment
from payments
group by payment_method;

# see payments for each payment method
select payment_method,
count(*) as number_of_payments,
max(amount) as maximum_payment,
min(amount) as minimum_payment,
avg(amount) as average_amount,
sum(amount) as total_payment
from payments 
group by payment_method;

#inner join: customers and orders 
select 
  c.customer_id,
  c.first_name,
  c.last_name,
  o.order_id,
  o.order_date,
  o.order_status
from customers c
inner join orders o 
on c.customer_id = o.customer_id;

#join orders, order items and menu_items 
select 
 o.order_id,
 o.order_date,
 m.item_name,
 m.category,
 oi.quantity,
 oi.price
from orders o 
inner join order_items oi 
on o.order_id = oi.order_id 
inner join menu_items m 
on oi.menu_item_id  = m.menu_item_id;

#multi table inner join 
#connecting customers, orders, order_items and menu_items.
select 
c.first_name,
c.last_name,
o.order_id,
o.order_date,
o.order_status,
oi.menu_item_id,
oi.quantity,
oi.price,
m.category,
m.item_name
from customers c 
inner join orders o
on c.customer_id = o.customer_id
inner join order_items oi
on o.order_id = oi.order_id 
inner join menu_items m 
on oi.menu_item_id = m.menu_item_id;

#show all customers and their orders
select 
c.customer_id,
c.first_name,
c.last_name,
o.order_id,
o.order_date,
o.order_status
from customers c
left join orders o
on c.customer_id = o.customer_id;

#find payments of orders above the average payment amount.
select 
payment_id,
order_id,
payment_method,
payment_date,
amount,
payment_status
from payments 
where amount > (select avg(amount)
from payments
);

#find customers who have placed an order
select 
c.customer_id,
c.first_name,
c.last_name,
c.email,
c.phone_number
from customers c
where exists (
select 1 
from orders o
where o.customer_id = c.customer_id
);

#find customers who have not placed an order
select 
c.customer_id,
c.first_name,
c.last_name,
c.email,
c.phone_number
from customers c
where not exists (
select 1 
from orders o
where o.customer_id = c.customer_id
);

#calculate the total payment made by each customer
select 
c.customer_id,
c.first_name,
c.last_name,
sum(p.amount) as total_amount_paid
from customers c
inner join orders o
on c.customer_id =o.customer_id 
inner join payments p
on o.order_id = p.order_id 
group by 
c.customer_id,
c.first_name,
c.last_name;

#Find customers whose first name starts with A and their orders
select 
c.customer_id,
c.first_name,
c.last_name,
o.order_id,
o.order_date,
o.order_status
from customers c
inner join orders o 
on c.customer_id = o.customer_id
where c.first_name LIKE 'A%';

#Count the number of orders for each customer.
select 
c.customer_id,
c.first_name,
c.last_name,
count (o.order_id) as total_orders
from customers c
left join orders o 
on c.customer_id = o.customer_id
group by 
c.customer_id,
c.first_name,
c.last_name;

#SET OPERATIONS - combine customer and employee names using
#A. union
select first_name , last_name
from customers
union
select first_name , last_name
from employees;

#B. union all
select first_name , last_name
from customers
union all
select first_name , last_name
from employees;

#Show all menu items and their restaurants using right join
select
r.restaurant_id,
r.restaurant_name,
m.menu_item_id,
m.item_name,
m.price
from restaurant r
right join menu_items m
on r.restaurant_id = m.restaurant_id;

#combine left and right join to show all restaurants and menu items
select
r.restaurant_id,
r.restaurant_name,
m.menu_item_id,
m.item_name
from restaurant r
left join menu_items m
on r.restaurant_id = m.restaurant_id
union  
select
r.restaurant_id,
r.restaurant_name,
m.menu_item_id,
m.item_name
from restaurant r
right join menu_items m
on r.restaurant_id = m.restaurant_id;

#Combine restaurant names and customer names
select restaurant_name 
from restaurant
union
select concat (first_name , ' ' , last_name)
from customers;

#find names appearing in both customers and employees
select first_name , last_name
from customers 
intersect
select first_name , last_name
from employees;

#find customers whose names are not employees
select first_name , last_name
from customers 
except
select first_name , last_name
from employees;

#find restaurants that received more than one order
select 
restaurant_id,
count(*) as number_of_orders
from orders
group by restaurant_id 
having count(*) > 1;

#find payment methods with total payments above 50
select 
payment_method,
sum(amount) as total_payment
from payments 
group by payment_method
having sum(amount)>50;

#show menu items together with their restaurant names
select 
r.restaurant_name,
m.item_name,
m.category,
m.price
from restaurant r
join  menu_items m
on r.restaurant_id = m.restaurant_id;



#calculate total value of each order 
select
    o.order_id,
    sum(oi.quantity * oi.price) as order_total
from orders o
inner join order_items oi
on o.order_id = oi.order_id
group by o.order_id;

#find best sellig menu item 
select
    m.item_name,
    sum(oi.quantity) as total_sold
from menu_items m
inner join order_items oi
on m.menu_item_id = oi.menu_item_id
group by m.menu_item_id, m.item_name
order by total_sold desc
limit 1 ;

#show reservation details
select
    c.first_name,
    c.last_name,
    r.reservation_date,
    r.reservation_time,
    t.table_number,
    t.capacity
from reservations r
inner join customers c
on r.customer_id = c.customer_id
inner join restaurant_tables t
on r.table_id = t.table_id
order by r.reservation_date;

#count employees by restaurant
select
    r.restaurant_name,
    count(e.employee_id) as total_employees
from restaurant r
left join employees e
on r.restaurant_id = e.restaurant_id
group by r.restaurant_id, r.restaurant_name;

#find menu items above average price
select
    item_name,
    price
from menu_items
where price > (
    select avg(price)
    from menu_items
)
order by price desc;

#create a procedure to find orders for a customer
create procedure getcustomersorders(in customer int)
select
    order_id,
    customer_id,
    restaurant_id,
    order_date,
    order_time,
    order_status
from orders
where customer_id = customer;
call getcustomersorders(1);

#create a view for customer orders
create view customer_orders_view as
select
    c.customer_id,
    c.first_name,
    c.last_name,
    o.order_id,
    o.order_date,
    o.order_time,
    o.order_status
from customers c
inner join orders o
on c.customer_id = o.customer_id;


select *
from customer_orders_view;

#set price automatically
create trigger set_order_item_price
before insert on order_items
for each row
set new.price = (
    select price
    from menu_items
    where menu_item_id = new.menu_item_id
);

#to test the trigger
insert into order_items (order_id, menu_item_id, quantity, price)
values (1, 1, 1, 0);

#price check 
select * from order_items
where order_item_id = last_insert_id();

#check order items
select * from order_items;

#order item price check
select
    oi.order_id,
    oi.menu_item_id,
    m.item_name,
    m.price as menu_price,
    oi.quantity,
    oi.price AS order_item_price,
    (oi.quantity * oi.price) as line_total
from order_items oi
join menu_items m
on oi.menu_item_id = m.menu_item_id
order by oi.order_id, oi.menu_item_id;

#duplicate check
select order_id, menu_item_id , quantity ,price,
count (*) as duplicate_count
from order_items
group by order_id, menu_item_id , quantity ,price
having count (*)>1
order by order_id, menu_item_id;



#INDEXING
create index idx_employee_restaurant
on employees(restaurant_id);

create index idx_menu_restaurant
on menu_items(restaurant_id);

create index idx_reservation_customer
on reservations(customer_id);

create index idx_reservation_table
on reservations(table_id);

create index idx_order_customer
on orders(customer_id);

create index idx_order_restaurant
on orders(restaurant_id);

create index idx_order_date
on orders(order_date);

create index idx_order_items_order
on order_items(order_id);

create index idx_order_items_menu
on order_items(menu_item_id);

create index idx_payment_order
on payments(order_id);


show indexes 
from customers;

show indexes
from employees;

show indexes 
from menu_items;

show indexes 
from reservations;

show indexes 
from orders;

show indexes 
from order_items;

show indexes 
from payments;

#FINAL DATABASE CHECK
use b103_restaurant_management;
show tables;

show triggers;

show procedure status
where db = 'b103_restaurant_management';

show full tables
where table_type = 'VIEW';

#check final data 
select *
from customers 
order by customer_id;

select *
from restaurant
order by restaurant_id;

select *
from employees
order by employee_id;

select *
from restaurant_tables
order by table_id;

select *
from menu_items
order by menu_item_id;

select *
from reservations 
order by reservation_id;

select *
from orders  
order by order_id;

select *
from order_items  
order by order_id , order_item_id;

select *
from payments 
order by payment_id;



