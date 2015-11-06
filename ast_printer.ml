exception SyntaxError of string
open Blocks

let fmt = Format.sprintf

let paragraph_string = function
  | String s         -> fmt "(STRING \"%s\")" s
  | Link(name, link) -> fmt "(%s: href=\"%s\")" name link

let block_string = function
  | Header(n, str) -> fmt "(HEADER %d \"%s\")" n str
  | Paragraph p    -> fmt "(PARAGRAPH \"%s\")" (paragraph_string p)
  | Comment(c)     -> fmt "(COMMENT \"%s\")" c


let ast_string document_blocks =
  let document_blocks = List.rev document_blocks in
    Format.sprintf "(DOCUMENT\n%s)\n"
      (String.concat "\n"
        (List.map (fun s -> "  " ^ s)
          (List.map block_string document_blocks)))


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
  in
  print_string (ast_string ast)

