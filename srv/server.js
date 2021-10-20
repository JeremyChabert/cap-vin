const cds = require('@sap/cds');
module.exports = cds.server;

cds.on('bootstrap', (app) => {
  if (process.env.NODE_ENV !== 'production') {
    const cds_swagger = require('cds-swagger-ui-express');
    app.use(cds_swagger());
  }
});
