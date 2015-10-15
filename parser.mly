%{ open Blocks %}

%token BACKSLASH
%token HASH1 HASH2 HASH3 HASH4 HASH5 HASH6 DASH
%token START_TAG END_TAG
%token COMMENT_START COMMENT_END
%token LBRACKET RBRACKET LPAREN RPAREN COLON STAR
%token HASH1 HASH2 HASH3 HASH4 HASH5 HASH6

%token EOF

%token <string> STRING



%start document
%type <Blocks.document> document

%%

document:
  | document comment      { $2 :: $1 }
  | document header       { $2 :: $1 }
  | document string_block { $2 :: $1 }
  | /* nothing */         { [] }

header:
  | HASH1 STRING { Header(1, $2) }
  | HASH2 STRING { Header(2, $2) }
  | HASH3 STRING { Header(3, $2) }
  | HASH4 STRING { Header(4, $2) }
  | HASH5 STRING { Header(5, $2) }
  | HASH6 STRING { Header(6, $2) }


comment:
  | COMMENT_START STRING COMMENT_END { Comment $2 }


string_block:
  | STRING { String $1 }

%%
