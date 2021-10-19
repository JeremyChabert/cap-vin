module.exports = (srv) => {
  const { Vin, Assemblage, Cepage } = cds.entities('my.cave');

  const calculateGardeCriticality = (item) => {
    const { annee, garde } = item;
    const currentYear = new Date().getFullYear();

    let criticality = 0,
      status = '';
    if (annee && garde) {
      const ratio = (currentYear - annee) / garde;
      if (ratio < 0.5) {
        criticality = 3;
        status = 'Conservable';
      } else if (ratio > 0.5 && ratio < 0.9) {
        criticality = 2;
        status = 'Bon à boire';
      } else if (ratio >= 1) {
        criticality = 1;
        status = 'A boire rapidement';
      } else {
        criticality = 0;
        status = '';
      }
    }
    return { criticality, status };
  };

  srv.before('SAVE', 'Vin', async (req) => {
    const tot = req.data.to_cepages.reduce((acc, { pourcent }) => {
      return acc + Number(pourcent);
    }, 0);
    if (tot > 100) req.reject('417', 'The composition of cepage is above 100% (actual:{0})', 'tot');
  });
  //
  //
  srv.after('READ', 'Vin', (each) => {
    console.log('handler criticality triggered');
    const { criticality, status } = calculateGardeCriticality(each);
    each.criticality = criticality;
    each.status = status;
  });
};
