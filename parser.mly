%{ open Blocks %}

%token BACKSLASH
%token <int> HASH
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
  | HASH STRING { Header($1, $2) }


comment:
  | COMMENT_START STRING COMMENT_END { Comment $2 }


string_block:
  | STRING { String $1 }

%%
