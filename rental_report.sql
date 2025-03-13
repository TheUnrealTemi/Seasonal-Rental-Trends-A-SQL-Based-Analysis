-- Extracting the month from the Date data type, to create a new table with a 'Season' column

CREATE TABLE rental_with_season AS
SELECT r.rental_id, r.rental_date, r.inventory_id, i.film_id,
		CASE
		    WHEN EXTRACT (MONTH FROM r.rental_date) IN (12, 1, 2) THEN ‘Winter’
		    WHEN EXTRACT (MONTH FROM r.rental_date) IN (3, 4, 5) THEN ‘Spring’
        WHEN EXTRACT (MONTH FROM r.rental_date) IN (6, 7, 8) THEN ‘Summer’
        WHEN EXTRACT (MONTH FROM r.rental_date) IN (9, 10, 11) THEN ‘Fall’
        ELSE  ‘Unknown’
	  END AS rental_season
FROM rental AS r
LEFT JOIN inventory AS i ON r.inventory_id = i. inventory_id;

-- Creating two new tables to hold the Summary and Detailed rental reports

CREATE TABLE summary_rental_report (
    rental_season VARCHAR(10),
    total_rental INTEGER
);
CREATE TABLE detailed_rental_report (
		rental_season VARCHAR(10),
		category_name VARCHAR(50),
		total_rental INTEGER
);

-- Extracting the raw data needed from the Rental datasets into the Detailed report table

INSERT INTO detailed_rental_report (
    rental_season,
    category_name,
    total_rental
)
SELECT rental_season, c.name AS category_name, COUNT(rental_id) AS total_rental
FROM rental_with_season AS rws
LEFT JOIN film_category AS fc ON rws.film_id = fc.film_id
LEFT  JOIN category AS c ON c.category_id = fc.category_id
GROUP BY rental_season, category_name
ORDER BY total_rental DESC;

-- Creating a trigger on the Detailed report table that will continually update the Summary report table, as data is added to the Detailed report Table 

CREATE OR REPLACE FUNCTION insert_ summary_rental_report ()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
	  DELETE FROM summary_rental_report;
	  INSERT INTO summary_rental_report
	  SELECT rental_season, SUM(total_rental) AS total_rental
    FROM detailed_rental_report
    GROUP BY rental_season
    ORDER BY total_rental DESC;
    RETURN NEW;
END;
$$

CREATE TRIGGER update_ summary_rental_report
AFTER INSERT
ON detailed_rental_report
FOR EACH STATEMENT
		EXECUTE PROCEDURE insert_ summary_rental_report ();

-- Creating a procedure to refresh the data in both Detailed and Summary reports, using pgAgent to automate this task on a monthly bases

CREATE OR REPLACE PROCEDURE refresh _reports ()
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM detailed_rental_report;
    INSERT INTO detailed_rental_report
    SELECT rental_season, c.name AS category_name, COUNT(rental_id) AS total_rental
		FROM  rental_with_season AS rws
		LEFT JOIN film_category AS fc ON fc.film_id = rws.film_id
		LEFT  JOIN category AS c ON c.category_id = fc.category_id
		GROUP BY rental_season, category_name
		ORDER BY total_rental DESC;
	  RETURN;
END;
$$
