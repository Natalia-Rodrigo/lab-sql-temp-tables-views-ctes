/*Step 1: Create a View
First, create a view that summarizes rental information for each customer. The view should include the customer's ID, name, email address, and total number of rentals (rental_count).
*/
-- by mistake I deleted the previous code, sorry :S 
SELECT * FROM sakila.summary_rental_info;
/* Step 2: Create a Temporary Table
Next, create a Temporary Table that calculates the total amount paid by each customer (total_paid). The Temporary Table should use the rental summary view created in Step 1 to join with the payment table and calculate the total amount paid by each customer.
*/
CREATE VIEW total_paid_customer AS 
(SELECT SUM(amount) as total_paid, customer_id FROM payment
GROUP BY customer_id);

CREATE TEMPORARY TABLE total_paid AS 
(SELECT sri.*, p.total_paid FROM sakila.summary_rental_info as sri
JOIN total_paid_customer as p
ON sri.customer_id = p.customer_id
GROUP BY p.customer_id);

SELECT * FROM total_paid;

/*Create a CTE that joins the rental summary View with the customer payment summary Temporary Table created in Step 2. The CTE should include the customer's name, email address, rental count, and total amount paid.

Next, using the CTE, create the query to generate the final customer summary report, which should include: customer name, email, rental_count, total_paid and average_payment_per_rental, this last column is a derived column from total_paid and rental_count.
*/

WITH final_summary AS
(SELECT first_name AS customer_name, 
email AS email_address,
rental_count,
total_paid 
FROM total_paid)

SELECT final_summary.*, total_paid*1/rental_count AS avg_payment_per_rental
FROM final_summary;
