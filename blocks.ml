type header = int * string

type block =
  | Header of header
  | String of string
  | Comment of string

let block_string = function
  | Header(n, str) -> Format.sprintf "<h%d>%s</h%d>" n str n
  | String(str)    -> str
  | Comment(str)   -> Format.sprintf "<!-- %s -->" str

type document = block list

let document_string document_blocks =
  String.concat "\n" (List.map block_string document_blocks)

