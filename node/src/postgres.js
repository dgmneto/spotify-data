const { Pool } = require('pg')

const pool = new Pool()
const query = 'INSERT INTO spotify_data.regions (id, spotify_id, spotify_display_name) VALUES (uuid_in(md5(random()::text || now()::text)::cstring), $1, $2) RETURNING *'

function addRegions(countries, callback) {
    let count = countries.length;
    let results = [];
    countries.forEach((element) => {
        pool.query(query, [element.id, element.display_name], (err, result) => {
            results.push(result.rows[0]);
            if(--count == 0) {
                callback(results)
            }
        })
    }, this);
}

module.exports = {
    addRegions: addRegions
}