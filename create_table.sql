CREATE TABLE IF NOT EXISTS products
(
    id integer,
    name character varying(50),
    supplier_id integer,
    quantity integer,
    price integer,
    expiry_date date,
    status character varying(10) COLLATE pg_catalog."default" DEFAULT 'Fresh'::character varying,
    PRIMARY KEY (id, expiry_date)
);

CREATE TABLE IF NOT EXISTS users
(
    id integer,
    usertype character varying(10),
    name character varying(50),
    phone character(10),
    address character varying(100),
    password_hash character varying(50),
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS transactions
(
    id integer,
    user_id integer,
    product_id integer,
    order_type character varying(4),
    quantity integer,
    unit_price integer,
    net_amount integer,
    order_date date,
    PRIMARY KEY (id)
);

ALTER TABLE IF EXISTS products
ADD FOREIGN KEY (supplier_id)
REFERENCES public.users (id) MATCH SIMPLE;


ALTER TABLE IF EXISTS public.transactions
ADD FOREIGN KEY (user_id)
REFERENCES public.users (id) MATCH SIMPLE;


ALTER TABLE IF EXISTS public.transactions
ADD FOREIGN KEY (product_id)
REFERENCES public.products (id) MATCH SIMPLE;