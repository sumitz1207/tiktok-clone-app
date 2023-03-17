DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS related CASCADE;
DROP TABLE IF EXISTS features CASCADE;
DROP TABLE IF EXISTS styles CASCADE;
DROP TABLE IF EXISTS photos CASCADE;
DROP TABLE IF EXISTS skus CASCADE;

CREATE TABLE products (
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(255),
  slogan VARCHAR(500),
  description VARCHAR(500),
  category VARCHAR(255),
  defauLt_price VARCHAR(255),
  PRIMARY KEY (id)
);

COPY products(id, name, slogan, description, category, default_price)
FROM '/Users/Sumit/Products/data/short/product.csv'
DELIMITER ',' CSV HEADER;

CREATE TABLE features (
  id INT GENERATED ALWAYS AS IDENTITY,
  product_id INT,
  feature VARCHAR(255),
  value VARCHAR(255),
  PRIMARY KEY(id),
  FOREIGN KEY(product_id) REFERENCES products(id)
);

\copy features(id, product_id, feature, value)
FROM '/Users/Sumit/Products/data/short/features.csv'
DELIMITER ',' CSV HEADER;

CREATE TABLE related (
  id INT GENERATED ALWAYS AS IDENTITY,
  current_product_id INT,
  related_product_id INT,
  PRIMARY KEY(id),
  FOREIGN KEY (current_product_id) REFERENCES products(id),
  FOREIGN KEY (related_product_id) REFERENCES products(id)
);

\copy related(id, current_product_id, related_product_id)
FROM '/Users/Sumit/Products/data/short/related.csv'
DELIMITER ',' CSV HEADER;

CREATE TABLE styles (
  id INT GENERATED ALWAYS AS IDENTITY,
  product_id INT,
  name VARCHAR(255),
  sale_price VARCHAR(255),
  original_price INT,
  default_style BOOLEAN,
  PRIMARY KEY(id),
  FOREIGN KEY (product_id) REFERENCES products(id)
);

\copy styles(id, product_id, name, sale_price, original_price, default_style)
FROM '/Users/Sumit/Products/data/short/styles.csv'
DELIMITER ',' CSV HEADER;

CREATE TABLE photos (
  id INT GENERATED ALWAYS AS IDENTITY,
  style_id INT,
  url VARCHAR,
  thumbnail_url VARCHAR,
  PRIMARY KEY(id),
  FOREIGN KEY (style_id) REFERENCES styles(id)
);

\copy photos(id, style_id, url, thumbnail_url)
FROM '/Users/Sumit/Products/data/short/photos.csv'
DELIMITER ',' NULL AS 'NULL' CSV HEADER;

CREATE TABLE skus (
  id INT GENERATED ALWAYS AS IDENTITY,
  style_id INT,
  size VARCHAR(50),
  quantity INT,
  PRIMARY KEY(id),
  FOREIGN KEY (style_id) REFERENCES styles(id)
);

\copy skus(id, style_id, size, quantity)
FROM '/Users/Sumit/Products/data/short/skus.csv'
DELIMITER ',' CSV HEADER;