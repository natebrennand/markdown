{ open Parser }

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
| [ ' ' 'a'-'z' 'A'-'Z'][^ '\n' '-' '>']* as str { STRING(str |> String.trim) }
| _ as char   { raise (Failure("illegal character " ^ Char.escaped char)) }

