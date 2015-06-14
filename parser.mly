%{ open Blocks %}

%token BACKSLASH
%token HASH1 HASH2 HASH3 HASH4 HASH5 HASH6 DASH
%token LBRACKET RBRACKET LPAREN RPAREN PIPE COLON STAR

%token <string> STRING
%token EOF

%left HASH1 HASH2 HASH3 HASH4 HASH5 HASH6


%start document
%type <Blocks.document> document


%%

document:
  | /* nothing */   { [] }
  | document header { $2 :: $1 }
  | document string { $2 :: $1 }

string:
  | STRING { String($1) }

header:
  | HASH1 STRING { Header(1, $2) }
  | HASH2 STRING { Header(2, $2) }
  | HASH3 STRING { Header(3, $2) }
  | HASH4 STRING { Header(4, $2) }
  | HASH5 STRING { Header(5, $2) }
  | HASH6 STRING { Header(6, $2) }


%%
