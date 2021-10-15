module.exports = (srv) => {
  const { Vin, Assemblage, Cepage } = cds.entities('my.cave');
  srv.before('SAVE', 'Vin', async (req) => {
    const tot = req.data.to_cepages.reduce((acc, { pourcent }) => {
      return acc + Number(pourcent);
    }, 0);
    if (tot > 100) req.reject('417', 'The composition of cepage is above 100% (actual:{0})', 'tot');
  });
};
