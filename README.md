# warehouse_db
A basic database with a stored procedure and a trigger to update values

![wholesale_system - public](https://user-images.githubusercontent.com/56858811/211830899-66389c05-1580-430a-9408-63eaf5ab8fe3.png)

Products table has a composite primary key, with ID and expiry_date. Supplier_ID is a foreign key that links it to the user table. <br>
Transaction table references products table using product_id foreign key, and references users table with user_id foreign key.
