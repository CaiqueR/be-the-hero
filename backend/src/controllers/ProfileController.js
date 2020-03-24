const connection = require('../database/connection');

module.exports = {
  async index(req, res) {
    const ongId = req.headers.authorization;

    const incidets = await connection('incidents')
      .where('ong_id', ongId)
      .select('*');

    return res.json(incidets);
  },
};
