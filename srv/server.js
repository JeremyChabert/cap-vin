const cds = require('@sap/cds');
const cors = require('cors');
const config = require('./config/config');
const { auth, requiresAuth } = require('express-openid-connect');
const express = require('express');
module.exports = cds.server;

async function getPlotChart(req, res, next) {
  const srv = await cds.connect.to('sqlite:db');
  const { Position } = srv.entities('my.cave');
  // const createdBy = req.user.id;
  const positions = await SELECT.from(Position, (a) => {
    a.positionX,
      a.positionY,
      a.cave((b) => {
        b.ID,
          b.vin((c) => {
            c.name;
            c.annee;
            c.color((d)=>{
              d.name
            });
          });
      });
  });
  res.send(positions);
}

const settings = {
  authRequired: false,
  auth0Logout: true,
  authorizationParams: { // required to retrieve JWT including permissions (our roles)
    response_type: "code",
    scope: "openid",
    audience: "https://my-wine-app-api.com",
  },
};

cds.on('bootstrap', (app) => {
  if (process.env.NODE_ENV !== 'production') {
    const cds_swagger = require('cds-swagger-ui-express');
    app.use(cors());
    app.use(cds_swagger());
  }  
  app.use(auth(settings));
  app.get('/getPlotChart', [getPlotChart]);
  app.get('/profile', requiresAuth(), (req, res) => {
    res.send(JSON.stringify(req.oidc.user));
  });

  app.use('/', requiresAuth());  //protect app from root fo
});
