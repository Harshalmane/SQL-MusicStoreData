/* Q1: Who is the senior most employee based on job title? */
Select  Top 1 (first_name),last_name 
from employee 
order by levels desc  ;

/* Q2: Which countries have the most Invoices? */
Select Top 5(count(*)),billing_country 
from invoice 
group by billing_country 
order by count(*) desc;

/* Q3: What are top 3 values of total invoice? */
Select top 3 (total) from invoice
order by total desc;

/* Q4: Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. 
Write a query that returns one city that has the highest sum of invoice totals. 
Return both the city name & sum of all invoice totals */
Select  top 1 (billing_city), Sum(total) AS InvoiceTotal
from invoice 
group by billing_city
order by  InvoiceTotal desc;

/* Q5: Who is the best customer? The customer who has spent the most money will be declared the best customer. 
Write a query that returns the person who has spent the most money.*/
Select Top 1 (C.customer_id),C.first_name, C.last_name, Sum(I.total)  as Total_Spending
from customer as C
join invoice as I on C.customer_id = I.customer_id
group by C.customer_id, C.first_name, C.last_name
order by Total_Spending desc;

/* Q6: Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
Return your list ordered alphabetically by email starting with A.*/ 

Select distinct C.email, C.first_name, C.last_name, G.name 
from customer  C 
join invoice I on C.customer_id = I.customer_id
join invoice_line IL on I.invoice_id = IL.invoice_id
join track T on T.track_id = IL.track_id
join genere G on T.genre_id = G.genre_id
Where G.name = 'Rock' and C.email like 'A%'
order by C.email;

/* Q7: Let's invite the artists who have written the most rock music in our dataset. 
Write a query that returns the Artist name and total track count of the top 10 rock bands. */
Select Top 10 A.artist_id, A.name Artist_Name,COUNT(T.name) Track_Count ,G.name Genere_Name
from artist A 
join album AB on A.artist_id =AB.artist_id
join track T  on AB.album_id = T.album_id
join genere G on G.genre_id = T.genre_id
Where G.name = 'Rock'
GROUP BY A.name,G.name,A.artist_id
order by T.name desc;

 /*Return all the track names that have a song length longer than the average song length. 
Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first. */
Select name,milliseconds from track
where milliseconds > (Select AVG(milliseconds) from track) 
order by milliseconds desc;
