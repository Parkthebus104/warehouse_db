--Invoke a trigger whenever a new row is inserted in 'transactions' table
CREATE TRIGGER purchase_trigger
AFTER INSERT
ON transactions
FOR EACH ROW
EXECUTE FUNCTION update_quantity();

-- Function to update stock in the 'products' table according to the buy/sell order made
CREATE OR REPLACE FUNCTION update_quantity()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS $$
BEGIN
IF NEW.order_type = 'Buy' THEN
	UPDATE products 
	SET quantity = quantity - NEW.quantity
	WHERE id = NEW.product_id;
ELSIF NEW.order_type = 'Sell' THEN
	UPDATE products 
	SET quantity = quantity + NEW.quantity 
	WHERE id = NEW.product_id;
END IF;
RETURN NEW;
END;
$$

-- Add a discount to the products about to expire, and set price to zero for the ones already expired. 
-- This procedure can be called using a cron job schedule on the server
CREATE OR REPLACE PROCEDURE check_expiry()
LANGUAGE plpgsql
AS $$
BEGIN
UPDATE products
SET price = price/2, status = 'Discounted'
WHERE expiry_date < CURRENT_DATE + INTERVAL '31 days' AND (STATUS <> 'Discounted' OR STATUS <> 'Expired');

UPDATE products
SET price = 0, status = 'Expired'
WHERE expiry_date < CURRENT_DATE;

END;
$$