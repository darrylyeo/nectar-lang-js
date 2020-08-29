import parser from "./parser.ts"

export function evaluate(contents: string){
	const state = parser.save()
	try {
		parser.feed(contents)
	}catch(e){
		console.error(e)
	}
	console.log("->", parser.results)
	parser.restore(state)
}