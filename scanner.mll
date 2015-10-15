{ open Parser }

rule token = parse
| ['\t' '\r' '\n'] { token lexbuf }
| "#"         { HASH1 }
| "##"        { HASH2 }
| "###"       { HASH3 }
| "####"      { HASH4 }
| "#####"     { HASH5 }
| "######"    { HASH6 }
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
| [ ' ' 'a'-'z' 'A'-'Z'][^ '\n' '-']* as str { STRING(str |> String.trim) }
| _ as char   { raise (Failure("illegal character " ^ Char.escaped char)) }

