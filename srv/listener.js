const cds = require('@sap/cds');
const winston = require('./config/winston');

module.exports = async (srv) => {
  const { LogOfEvent } = cds.entities('my.cave');

  const retailerService = await cds.connect.to('retailer');
  const customerService = await cds.connect.to('customer');
  //
  //
  retailerService.on('productAvailable',  async(msg) => {
    winston.info(['==>> msg received from customerService', msg.event, msg.data]);
    await INSERT.into(LogOfEvent).entries({ name: msg.event });
  });
  //
  //
  retailerService.on('productOrdered', async(msg) => {
    winston.info(['==>> msg received from customerService', msg.event, msg.data]);
    await INSERT.into(LogOfEvent).entries({ name: msg.event });
  });
  //
  //
  customerService.on('productSoldOut',  async(msg) => {
    winston.info(['==>> msg received from retailerService', msg.event, msg.data]);
     await INSERT.into(LogOfEvent).entries({ name: msg.event });
  });
};
