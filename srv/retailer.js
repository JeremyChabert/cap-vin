const winston = require('./config/winston');

module.exports = (srv) => {
  const { Vin, Assemblage, Cepage, VinAnalytics, Cave } = cds.entities('my.cave');

  const updateStatus = async () => {
    const vins = await SELECT.from(Vin).columns(['ID', 'status_code', 'annee', 'garde']);
    for (let vin of vins) {
      const status_code = calculateGardeCriticality(vin);
      await UPDATE(Vin, vin).with(`status_code = '${status_code}'`);
      vin.status_code = status_code;
    }
  };

  const calculateGardeCriticality = (item) => {
    const { annee, garde } = item;
    const currentYear = new Date().getFullYear();

    let status_code = '';
    if (annee && garde) {
      const ratio = (currentYear - annee) / garde;
      if (ratio < 0.5) {
        status_code = 'B';
      } else if (ratio > 0.5 && ratio < 0.9) {
        status_code = 'C';
      } else if (ratio >= 1) {
        status_code = 'D';
      } else {
        status_code = 'E';
      }
    }
    return status_code;
  };
  //
  //
  srv.before('SAVE', 'Vin', async (req) => {
    winston.debug(['BEFORE', 'SAVE', 'Vin']);
    const tot = req.data.to_cepages.reduce((acc, { pourcent }) => {
      return acc + Number(pourcent);
    }, 0);
    if (tot > 100) req.reject('417', 'The composition of cepage is above 100% (actual:{0})', 'tot');
  });
  //
  //
  srv.on('SAVE', 'Vin', (req, next) => {
    winston.debug(['ON', 'SAVE', 'Vin']);
    return next();
  });
  //
  //
  srv.on('UPDATE', 'Vin', (req, next) => {
    winston.debug(['ON', 'UPDATE', 'Vin']);
    return next();
  });
  //
  //
  srv.on('READ', 'Vin', async (req, next) => {
    winston.debug(['ON', 'READ', 'Vin']);
    // await updateStatus();
    return next();
  });
  //
  //
  srv.on('READ', 'VinAnalytics', async (req, next) => {
    winston.debug(['ON', 'READ', 'VinAnlytics']);
    await updateStatus();
    return next();
  });
  //
  //
  srv.after('READ', 'VinAnalytics', (lines) => {
    winston.debug(['AFTER', 'READ', 'VinAnalytics', JSON.stringify(lines)]);
  });
  //
  //
  srv.on('postGoods', async (req) => {
    winston.debug(['ON', 'postGoods']);
    const { ID } = req.params[0];
    const { quantity } = req.data;
    const wine = await SELECT.one
      .from(Vin, (a) => {
        a.ID,
          a.name,
          a.annee,
          a.inStockQty,
          a.orderQty,
          a.color((b) => {
            b.name;
          });
      })
      .where({ ID });
    if (quantity > wine.orderQty) {
      req.error({
        code: '417',
        message: `You cannot check more than ordered. Actual ordered ${wine.orderQty}, requested ${quantity}`,
        status: 417,
      });
    } else {
      await UPDATE(Vin, ID).with(
        `inStockQty  = ${wine.inStockQty + quantity}, orderQty = ${wine.orderQty - quantity}, availability_code = 'A'`
      );
      req.notify({
        code: '200',
        message: `${quantity} checked in`,
        status: 200,
      });
    }

    srv.emit('productAvailable', {
      name: wine.name,
      vintage: wine.annee,
      color: wine.color.name,
      quantity,
    });
  });
  //
  //
  srv.on('withdrawFromSale', async (req) => {
    winston.debug(['ON', 'withdrawFromSale']);
    const { ID } = req.params[0];
    const wine = await SELECT.one
      .from(Vin, (a) => {
        a.name,
          a.annee,
          a.color((b) => {
            b.name;
          });
      })
      .where({ ID });
    await UPDATE(Vin, ID).with(`inStockQty = 0,availability_code = 'B'`);
    req.notify({
      code: '202',
      message: `[${wine.name},${wine.annee},${wine.color.name} checked out`,
      status: 202,
    });
  });
  //
  //
  srv.on('order', async (req) => {
    winston.debug(['ON', 'order']);
    const { ID } = req.params[0];
    const { quantity } = req.data;
    const wine = await SELECT.one
      .from(Vin, (a) => {
        a.ID,
          a.name,
          a.annee,
          a.orderQty,
          a.color((b) => {
            b.name;
          });
      })
      .where({ ID });
    await UPDATE(Vin, ID).with(`orderQty  = ${wine.orderQty + quantity},availability_code = 'C'`);
    req.notify({
      code: '200',
      message: `Order for ${quantity} placed`,
      status: 200,
    });

    srv.emit('productOrdered', {
      name: wine.name,
      vintage: wine.annee,
      color: wine.color.name,
      quantity,
    });
  });
  //
  //
  srv.after('each', 'Vin', (vin) => {
    if (vin.orderQty > 0) vin.postGoodsEnabled = true;
    if (vin.inStockQty === 0) vin.orderEnabled = true;
    if (vin.inStockQty > 0) vin.withdrawFromSaleEnabled = true;
  });
  //
  //
  srv.on('productSoldOut', (msg) => {
    winston.info(['ON',msg.event, msg.data]);
  });
  //
  //
};