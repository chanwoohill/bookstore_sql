#Exercise 1 

SELECT e.isbn
  FROM editions AS e
    JOIN publishers 
    ON e.publisher_id = publishers.id 
  WHERE publishers.name = 'Random House';

#Exercise 2 

SELECT e.isbn, title
  FROM editions AS e
    JOIN publishers 
    ON e.publisher_id = publishers.id 
    JOIN books 
    ON e.book_id = books.id
  WHERE publishers.name = 'Random House';

#Exercise 3

SELECT e.isbn, title, stock, retail
  FROM editions AS e
    JOIN publishers 
    ON e.publisher_id = publishers.id 
    JOIN books 
    ON e.book_id = books.id
    JOIN stock 
    ON e.isbn = stock.isbn
  WHERE publishers.name = 'Random House';

#Exercise 4

SELECT e.isbn, title, stock, retail
  FROM editions AS e
    JOIN publishers 
    ON e.publisher_id = publishers.id 
    JOIN books 
    ON e.book_id = books.id
    JOIN stock 
    ON e.isbn = stock.isbn
  WHERE publishers.name = 'Random House' AND stock != 0;

#Exercise 5

SELECT e.isbn, title, stock, retail, 
  CASE WHEN type = 'h' THEN 'hardcover'
       WHEN type = 'p' THEN 'paperback' 
  END AS type 
  FROM editions AS e 
    JOIN publishers 
    ON e.publisher_id = publishers.id 
    JOIN books 
    ON e.book_id = books.id
    JOIN stock 
    ON e.isbn = stock.isbn
  WHERE publishers.name = 'Random House' AND stock != 0;

#Exercise 6 

SELECT title, publication 
  FROM books 
    LEFT JOIN editions 
  ON books.id = editions.book_id;

#Exercise 7 

SELECT sum(s.stock) AS "number of books"
  FROM stock AS s;

#Exercise 8

SELECT Round(sum(s.cost*s.stock)/sum(s.stock),2) AS "Average Cost", 
  ROUND(sum(s.retail*s.stock)/sum(s.stock),2) AS "Average Retail",
  (ROUND(sum(s.retail*s.stock)/sum(s.stock),2) - Round(sum(s.cost*s.stock)/sum(s.stock),2))
  AS "Average Profit"
  FROM stock AS s;

#Exercise 9

SELECT book_id 
  FROM editions
    JOIN stock 
    ON editions.isbn = stock.isbn 
  ORDER BY stock DESC
  LIMIT 1; 

#Exercise 10

SELECT authors.id AS ID, 
  concat(first_name, ' ', last_name) AS "Full Name", 
  count(books.id) as "Number of Books"
  FROM authors as a 
    JOIN books 
    ON a.id = books.author_id
  GROUP BY a.id;

#Exercise 11

SELECT authors.id AS ID, 
  concat(first_name, ' ', last_name) AS "Full Name", 
  count(books.id) as "Number of Books"
  FROM authors
    JOIN books 
    ON authors.id = books.author_id
  GROUP BY authors.id
  ORDER BY "Number of Books" DESC;

#Exercise 12

SELECT b.title 
  From books as b
    JOIN editions as e
    ON b.id = e.book_id
  GROUP BY title
  HAVING count(DISTINCT type) > 1; 

 #Exercise 13 

SELECT p.name, ROUND((SUM(s.stock*s.retail))/SUM(s.stock),2) AS "Average book sale price", 
SUM(e.edition) AS "Number of editions published"
FROM publishers AS p
  JOIN editions AS e 
  ON p.id = e.publisher_id
  JOIN stock as s 
  ON s.isbn = e.isbn
WHERE s.stock > 0
GROUP BY p.name; 