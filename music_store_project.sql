-- Basic Observation

-- 1. Who is the senior most employee based on job title?

select * from employee 
where employee.levels='L7';

-- 2. Which countries have the most Invoices?

select count(invoice_id),billing_country
from invoice
group by billing_country order by count(invoice_id) desc limit 3;


-- Ques:3.. What are top 3 values of total invoice?

select
total
from invoice 
order by total desc limit 3;


/* Quest:4. Which city has the best customers? We would like to throw a promotional Music 
Festival in the city we made the most money. Write a query that returns one city that 
has the highest sum of invoice totals. Return both the city name & sum of all invoice 
totals  */

select billing_city,round(sum(total))
from invoice
group by billing_city
order by sum(total) desc limit 1;

/* Ques:5. Who is the best customer? The customer who has spent the most money will be 
declared the best customer. Write a query that returns the person who has spent the 
most money */

select invoice.customer_id,
customer.first_name,
customer.last_name,
sum(invoice.total)
from 
invoice join customer
on invoice.customer_id=customer.customer_id
group by invoice.customer_id,customer.first_name,customer.last_name
order by sum(total) desc limit 1;




                             /*Question Set 2 – Moderate
							 
							 
1. Write query to return the email, first name, last name, & Genre of all Rock Music 
listeners. Return your list ordered alphabetically by email starting with A.*/


select 
distinct 
Customer.first_name,
Customer.last_name,
Customer.email,
genre.name
from Customer  join invoice on Customer.customer_id=invoice.customer_id
join invoice_line on invoice.invoice_id=invoice_line.invoice_id 
join track on invoice_line.track_id=track.track_id 
join genre on track.genre_id=genre.genre_id
where genre.name='Rock'
order by email asc;



/* Ques: 2. Let's invite the artists who have written the most rock music in our dataset. Write a 
query that returns the Artist name and total track count of the top 10 rock bands*/

select 
artist.name as "artist_name",
count(genre.name) as "number_of_songs"
from artist
join album on artist.artist_id=album.artist_id
join track on album.album_id=track.album_id
join genre on track.genre_id=genre.genre_id
where genre.name='Rock'
group by artist_name 
order by number_of_songs desc limit 10;


/* Ques: 3. Return all the track names that have a song length longer than the average song length. 
Return the Name and Milliseconds for each track. Order by the song length with the 
longest songs listed first */

select
name,
milliseconds
from track
where milliseconds > (select
					 avg(milliseconds)  as avg_song_length
					 from track)
order by milliseconds desc;







--                                       Question Set 3 – Advance

/* Ques:1. Find how much amount spent by each customer on artists? Write a query to return
customer name, artist name and total spent */

select 
customer.first_name as "customer_name",
round(sum(invoice.total)) as "total_spent",
artist.name as "artist_name"
from customer
join invoice on customer.customer_id=invoice.invoice_id
join invoice_line on invoice.invoice_id=invoice_line.invoice_id
join track on track.track_id=invoice_line.track_id
join album on album.album_id=track.album_id
join artist on artist.artist_id=album.artist_id
group by customer_name,artist_name
order by total_spent desc



select 
artist_name,
customer_name,
round(sum((quantity*unit_price))) as "total_spent"
from(select 
customer.first_name as "customer_name",
	 artist.name as "artist_name",
	 invoice_line.quantity as "quantity",
	 invoice_line.unit_price as "unit_price"
from customer
join invoice on customer.customer_id=invoice.invoice_id
join invoice_line on invoice.invoice_id=invoice_line.invoice_id
join track on track.track_id=invoice_line.track_id
join album on album.album_id=track.album_id
join artist on artist.artist_id=album.artist_id)
group by customer_name,artist_name order by total_spent desc;


/* Ques: 2. We want to find out the most popular music Genre for each country. We determine the 
most popular genre as the genre with the highest amount of purchases. Write a query 
that returns each country along with the top Genre. For countries where the maximum 
number of purchases is shared return all Genres  */

select 
distinct
customer.country as "country",
genre.name as "genre_name",
round(sum(invoice.total)) as "purchase_amount"
from Customer  join invoice on Customer.customer_id=invoice.customer_id
join invoice_line on invoice.invoice_id=invoice_line.invoice_id 
join track on invoice_line.track_id=track.track_id 
join genre on track.genre_id=genre.genre_id
group by country,genre_name  order by purchase_amount desc;





/* Ques: 3. Write a query that determines the customer that has spent the most on music for each 
country. Write a query that returns the country along with the top customer and how
much they spent. For countries where the top amount spent is shared, provide all 
customers who spent this amount   */

select 
customer.country as "country",
customer.first_name as "first_name",
customer.last_name as "last_name",
sum(invoice.total) as "total_spent"
from  customer
join invoice on customer.customer_id=invoice.customer_id
group by country,first_name,last_name order by country asc;





























