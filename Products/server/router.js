const app = require('express').Router();
const db = require('../database/index.js');

app.get('/', (request, response) => {
  db.getOneProduct(1).then(x => {
    response.send(x.rows);
  })
  .catch(error => {
    console.error('Cannot retrieve data', error);
    response.status(400).send(error.stack);
  });
});
app.get('/products', (request, response) => {

  db.getProducts(request.query.page || 1, request.query.count || 20)
    .then(x => {
      console.log('SUCCESS');
      return response.send(x.rows);
    })
    .catch(error => {
      console.error('Cannot retrieve data', error);
      response.status(400).send(error.stack);
    });
});
app.get('/products/:product_id', (request, response) => {
  db.getOneProduct(request.params.product_id)
    .then(x => {
      response.send(x.rows);
    })
    .catch(error => {
      console.error('Cannot retrieve data', error);
      response.status(400).send(error.stack);
    });
});
app.get('/products/:product_id/related', (request, response) => {
  db.getProductsRelated(request.params.product_id)
    .then(x => {
      console.log('SUCCESS', x);
      return response.send(x.rows);
    })
    .catch(error => {
      console.error('Cannot retrieve data', error);
      response.status(400).send(error.stack);
    });
});

app.get('/products/:product_id/styles', (request, response) => {
  db.getStyles(request.params.product_id)
    .then(ret => {
      console.log('SUCCESS');
      return response.send(ret.rows[0]);
    })
    .catch(error => {
      console.error('Cannot retrieve data', error);
      response.status(400).send(error.stack);
    });
});



module.exports.router = app;