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

  srv.before('SAVE', 'Vin', async (req) => {
    winston.debug(['BEFORE', 'SAVE', 'Vin']);
    const tot = req.data.to_cepages.reduce((acc, { pourcent }) => {
      return acc + Number(pourcent);
    }, 0);
    if (tot > 100) req.reject('417', 'The composition of cepage is above 100% (actual:{0})', 'tot');
  });

  srv.on('SAVE', 'Vin', async (req) => {
    winston.debug(['ON', 'SAVE', 'Vin']);
  });

  srv.on('UPDATE', 'Vin', async (req) => {
    winston.debug(['ON', 'UPDATE', 'Vin']);
    console.log(req.data);
  });
  //
  //
  srv.on('READ', 'Vin', async (req, next) => {
    winston.debug(['ON', 'READ', 'Vin']);
    updateStatus();
    return next();
  });
  //
  //
  srv.on('READ', 'VinAnalytics', (req, next) => {
    winston.debug(['ON', 'READ', 'VinAnlytics']);
    updateStatus();
    return next();
  });
  //
  //
  srv.after('READ', 'VinAnalytics', (lines) => {
    winston.debug(['AFTER', 'READ', 'VinAnalytics', JSON.stringify(lines)]);
  });
  //
  //
  srv.on('addToMyCave', async (req) => {
    winston.debug(['ON', 'addToMyCave']);
    const vin_ID = req.params[0];
    const { quantity } = req.data;
    await INSERT({ quantity, vin_ID }).into(Cave);
  });
};
