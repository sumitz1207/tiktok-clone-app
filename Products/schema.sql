DROP DATABASE PRODUCTS IF EXISTS;
CREATE DATABASE PRODUCTS;
\c PRODUCTS;

DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS features CASCADE;
DROP TABLE IF EXISTS related CASCADE;
DROP TABLE IF EXISTS styles CASCADE;
DROP TABLE IF EXISTS photos CASCADE;
DROP TABLE IF EXISTS skus CASCADE;

CREATE TABLE products (
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(255) NOT NULL,
  slogan VARCHAR(500) NOT NULL,
  description VARCHAR(500) NOT NULL,
  category VARCHAR(255) NOT NULL,
  defauLt_price VARCHAR(255) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE related (
  id INT GENERATED ALWAYS AS IDENTITY,
  product_id INT,
  related_id INT,
  PRIMARY KEY(id),
  FOREIGN KEY (product_id) REFERENCES products(id),
  FOREIGN KEY (related_id) REFERENCES products(id)
);

CREATE TABLE features (
  feature_id INT GENERATED ALWAYS AS IDENTITY,
  feature VARCHAR(255),
  product_id INT,
  value VARCHAR(255),
  PRIMARY KEY(feature_id),
  FOREIGN KEY(product_id) REFERENCES products(id)
);

CREATE TABLE styles (
  style_id INT GENERATED ALWAYS AS IDENTITY,
  product_id INT,
  original_price INT NOT NULL,
  name VARCHAR(255) NOT NULL,
  sale_price VARCHAR(255) Default Null,
  default_style BOOLEAN,
  PRIMARY KEY(style_id),
  FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE TABLE photos (
  id INT GENERATED ALWAYS AS IDENTITY,
  style_id INT,
  url VARCHAR,
  thumbnail_url VARCHAR,
  PRIMARY KEY(id),
  FOREIGN KEY (style_id) REFERENCES styles(style_id)
);

CREATE TABLE skus (
  id INT GENERATED ALWAYS AS IDENTITY,
  styles_id INT,
  size VARCHAR(50),
  quantity INT,
  PRIMARY KEY(id),
  FOREIGN KEY (styles_id) REFERENCES styles(style_id)
);