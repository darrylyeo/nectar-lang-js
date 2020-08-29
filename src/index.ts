const VERSION = "0.0"

import { readLines } from "https://deno.land/std@v0.66.0/io/bufio.ts"
import { parser } from "./parser.ts"


function print(str: string){
	Deno.stdout.writeSync(new TextEncoder().encode(str));
}


async function repl(){
	console.log(`Welcome to the Nectar REPL! You're using version ${VERSION}.`)
	console.log("Type statements like this: @Nectar is a #language.\n")

	print("nectar $ ")
	for await (const line of readLines(Deno.stdin)) {
		evaluate(line)
		print("\nnectar $ ")
	}
}

function evaluate(contents: string){
	const state = parser.save()
	try {
		parser.feed(contents)
	}catch(e){
		console.error(e)
	}
	console.log("->", parser.results)
	parser.restore(state)
}


if(Deno.args.length === 0)
	repl()
else if(Deno.args.length === 1)
	evaluate(new TextDecoder('utf-8').decode(Deno.readFileSync(Deno.args[0])))