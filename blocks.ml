type header = int * string

type paragraph_block =
  | String of string
  | Link of string * string

let paragraph_block_string = function
  | String str       -> str
  | Link(name, link) -> Format.sprintf "<a href=\"%s\">%s<a>" link name

type block =
  | Header of header
  | Paragraph of paragraph_block
  | Comment of string

let block_string = function
  | Header(n, str) -> Format.sprintf "<h%d>%s</h%d>" n str n
  | Paragraph p    -> paragraph_block_string p
  | Comment(str)   -> Format.sprintf "<!-- %s -->" str

type document = block list

let document_string document_blocks =
  String.concat "\n" (List.map block_string document_blocks)

