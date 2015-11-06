{ open Parser }

let whitespace = [' ' '\t']
let text = ['a'-'z' 'A'-'Z']
let number = ['0'-'9']

(* https://tools.ietf.org/html/rfc3986#section-2 *)
let url_unreserved = ['-' '.' '_' '~' ]
let url_gen_delims = [':' '/' '?' '#' '[' ']' '@' ]
let url_sub_delims = ['!' '$' '&' ''' '(' ')'
                      '*' '+' ',' ';' '=' ]
let url = text|number|url_unreserved|url_gen_delims|url_sub_delims


rule token = parse
| ['\t' '\r' '\n'] { token lexbuf }
| "("         { LPAREN }
| ")"         { RPAREN }
| "["         { LBRACKET }
| "]"         { RBRACKET }
| ":"         { COLON }
| "<"         { START_TAG }
| ">"         { END_TAG }
| "<!--"      { COMMENT_START }
| "-->"       { COMMENT_END }
| eof         { EOF }
| ['#']+ as hash { HASH (String.length hash) }
| (whitespace|text|number)+ as str { STRING(str) }
| ("http")("s"?)(url)+(text#[')']) as str { LINK str }
| ("http"|"/")url+ as u   { URL u }
| _ as char   { raise (Failure("illegal character " ^ Char.escaped char)) }

