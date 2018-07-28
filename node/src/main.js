const Postgres = require('./postgres');
const { updateRegions } = require('./scrape');

updateRegions(Postgres, console.log);
