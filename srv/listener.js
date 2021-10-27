const cds = require('@sap/cds');
const winston = require('./config/winston');

module.exports = async (srv) => {
  const { LogOfEvent, LogOfDemand } = cds.entities('my.cave');

  const retailerService = await cds.connect.to('retailer');
  const customerService = await cds.connect.to('customer');
  //
  //
  retailerService.on('productAvailable', async (msg) => {
    winston.info(['==>> msg received from retailerService', msg.event, msg.data]);
    await INSERT.into(LogOfEvent).entries({ name: msg.event });
  });
  //
  //
  retailerService.on('productOrdered', async (msg) => {
    winston.info(['==>> msg received from retailerService', msg.event, msg.data]);
    await INSERT.into(LogOfEvent).entries({ name: msg.event });
  });
  //
  //
  customerService.on('productSoldOut', async (msg) => {
    winston.info(['==>> msg received from customerService', msg.event, msg.data]);
    await INSERT.into(LogOfEvent).entries({ name: msg.event });
  });
  //
  //
  customerService.on('registerDemand', async (msg) => {
    winston.info(['==>> msg received from customerService', msg.event, msg.data]);
    const date = new Date();
    const month = date.getMonth() + 1;
    const year = date.getFullYear();
    const { vin_ID, quantity, status_code } = msg.data;
    await INSERT.into(LogOfDemand).entries({ vin_ID, status_code, quantity, month, year });
  });
};
