var request = require('request');
var cheerio = require('cheerio');

function updateRegions(dao, callback){
    request('https://spotifycharts.com/', function (error, response, html) {
        if (!error && response.statusCode == 200) {
            var $ = cheerio.load(html);
            var countries = $('.responsive-select[data-type=country] ul li').map((i,element) => {
                return {
                    id: $(element).attr('data-value'),
                    display_name: $(element).html()
                }
            }).toArray();
            dao.addRegions(countries, callback);
          }
      });   
}

module.exports = {
    updateRegions: updateRegions
}