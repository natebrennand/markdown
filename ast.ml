exception SyntaxError of string

let _ =
  let lexbuf = Lexing.from_channel stdin in
  let ast =
    try
      Parser.document Scanner.token lexbuf
    with e ->
      let exception_string = Printexc.to_string e in
      let curr = lexbuf.Lexing.lex_curr_p in
      let line = curr.Lexing.pos_lnum in
      let col = curr.Lexing.pos_cnum in
      let tok = Lexing.lexeme lexbuf in
      raise (SyntaxError
        (Format.sprintf "Syntax error on line %d, col %d, token '%s': %s"
          line col tok exception_string))
  (* this output is grepped for in the test script *)
  in print_endline "TEST_SUCCESS"

