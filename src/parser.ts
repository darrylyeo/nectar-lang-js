import nearley from "https://dev.jspm.io/nearley";
import * as grammar from "./grammar.ts"

export default new nearley.Parser(nearley.Grammar.fromCompiled(grammar));