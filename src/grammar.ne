@builtin "whitespace.ne"
@builtin "number.ne"
@builtin "string.ne"


statements -> compound_statement _ (identifier:* _ "." _ compound_statement):*
compound_statement -> subjects _ predicates


predicates -> predicate _ (("," | and):? _ predicate):*
predicate -> is_a_predicate | has_property_predicate | relation_predicate | hyper_relation_predicate

hyper_relation_predicate -> relation _ categorizations
relation_predicate -> relation _ subject
has_property_predicate -> (has | with) _ article:? _ property _ of:? _ expression
is_a_predicate -> ( is _ article:? | has _ article:? _ ("category"i | "type"i) _ of:? ) _ categorizations



relation ->
	"to"i:? _ (
		is |
		has |
		"created by"i |
		"represent"i |
		"works with"i |
		"compiles to"i |
		"says"i
	)

property -> identifier


categorizations ->
	categorization _ ("," _ categorization):* _ (",":? _ and _ categorization):+ |
	categorization _ (";" _ categorization):* _ (";":? _ and _ categorization):+ |
	categorization _ ("/" _ categorization):*

categorization ->
	category _ category_alias:?


category_alias ->
	"(" _ aka:? _ (category | category_disjunction) _ ")" |
	",":? _ aka _ (category | category_disjunction) _ ",":?
category_conjunction -> category _ ("," _ category):* _ (",":? _ and _ category):+
category_disjunction -> category _ ("," _ category):* _ (",":? _ or _ category):+
category -> article:? "#" identifier


subjects ->
	subject _ ("," _ subject):* _ (",":? _ and _ subject):+ |
	subject _ (";" _ subject):* _ (";":? _ and _ subject):+ |
	subject _ ("/" _ subject):*

subject ->
	noun _ noun_alias:?


noun_alias ->
	"(" _ aka:? _ (noun | noun_disjunction) _ ")" |
	",":? _ aka _ (noun | noun_disjunction) _ ",":?
	{% null %}
noun_conjunction -> noun _ ("," _ noun):* _ (",":? _ and _ noun):+ {% null %}
noun_disjunction -> noun _ ("," _ noun):* _ (",":? _ or _ noun):+ {% null %}
noun -> article:? "@" identifier | "@" string

expression -> string | quantity | number

non_keyword -> identifier {% null %}
keyword -> article | and | or | is | has | of | with | aka {% null %}

aka -> "aka"i | "alias"i | ("also"i | "better"i | "commonly"i | "otherwise"i | "widely"i):? _ ("called"i | "known as"i | "named"i | "titled"i) | or {% null %}
with -> "with"i {% null %}
of -> "of"i {% null %}
has -> ("has"i | "have"i) _ article:? {% null %}
is -> ("is"i | "are"i _ "all"i:? | "can be"i | "am"i) {% null %}
or -> "or"i {% null %}
and -> "and"i {% null %}
article -> "an"i | "a"i | "the"i {% null %}

quantity -> number _ unit
unit -> non_keyword _ ("/" _ non_keyword):*

string -> dqstring | sqstring
number -> (decimal | int) ("e"i int):?

identifier -> alpha (alpha | digit | "_" | "-"):*

digit -> [0-9]
alpha -> [a-zA-Z]