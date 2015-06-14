{ open Parser }

rule token = parse
| ['\r' '\n'] { token lexbuf }
| "<!--"      { comment lexbuf }
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

| [^'\n' '#'][^'\n']* as str { STRING(str) }
| eof         { EOF }
| _ as char   { raise (Failure("illegal character " ^ Char.escaped char)) }

and comment = parse
| "-->" { token lexbuf }
| _     { comment lexbuf }

