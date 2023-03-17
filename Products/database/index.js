const {Pool} = require('pg');

const pool = new Pool({
  host: 'localhost',
  port: 5432,
  user: 'me',
  password: 'password',
  database: 'product'
});

pool.connect();

module.exports = {
  getProducts: function(pg, num) {
    return pool.query({text: `select * from products
    where id between $1 and $2
    limit $3;`, values: [0, 10 * pg, num]});
  },
  getOneProduct: function(id) {
    return pool.query({text: `select products.*, array_agg(json_build_object('feature', features.feature,
    'value', features.value)) as features from products
inner join features on features.product_id = products.id
where product_id = $1 group by products.id`, values: [id]})
  },
  getStyles: function(id) {
    return pool.query( {text: `select product_id,
    JSON_BUILD_ARRAY (
      JSON_BUILD_OBJECT (
        'style_id', styles.id, 'name', name, 'original_price', original_price,
        'sale_price', sale_price, 'default?', default_style, 'photos', ARRAY_AGG (DISTINCT JSONB_BUILD_OBJECT ('thumbnail_url', thumbnail_url, 'url', url)))) AS results,
    JSON_OBJECT_AGG( DISTINCT skus.id, JSONB_BUILD_OBJECT(
        'quantity', skus.quantity, 'size', skus.size) ) AS skus
  from styles inner join skus on styles.id = skus.style_id
  inner join photos on styles.id = photos.style_id
  where styles.product_id = $1
  group by styles.id`, values: [id]});
  },
  getProductsRelated: function(id){
    return pool.query({text: `SELECT * FROM related WHERE current_product_id = $1`, values: [id]});
  }
}
