// Run this with `node pokemon_regions.js`

// Download this file from https://raw.githubusercontent.com/jalyna/oakdex-pokedex/master/data/pokemon.json
// and put it in the same directory as this
json = require('./pokemon.json')

Object.values(json).forEach(pokemon => {
	const fields = ['kanto_id', 'johto_id', 'hoenn_id', 'sinnoh_id', 'unova_id', 'kalos_id', 'alola_id']
	let query = `UPDATE Pokemon SET `
	query += fields
		.map(f => `${f} = ${pokemon[f]}`)
		.join(', ')
	query += ` WHERE national_id = ${pokemon['national_id']};`
	console.log(query)
})
