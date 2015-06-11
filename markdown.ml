exception SyntaxError of string

let _ =
  let lexbuf = Lexing.from_channel stdin in
  let ast =
    try
      Parser.document Scanner.token lexbuf
    with _ ->
      let curr = lexbuf.Lexing.lex_curr_p in
      let line = curr.Lexing.pos_lnum in
      let col = curr.Lexing.pos_cnum in
      let tok = Lexing.lexeme lexbuf in
      raise (SyntaxError
        (Format.sprintf "Syntax error on line %d, col %d, character '%s'"
          line col tok))
  in
  print_string (Blocks.document_string ast)

