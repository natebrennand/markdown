%{ open Blocks %}

%token BACKSLASH
%token <int> HASH
%token START_TAG END_TAG
%token COMMENT_START COMMENT_END
%token LBRACKET RBRACKET LPAREN RPAREN COLON STAR
%token <string> URL

%token EOF

%token <string> TEXT LINK
%token <string> STRING

%left RPAREN
%left LBRACKET



%start document
%type <Blocks.document> document

%%

document:
  | document comment      { $2 :: $1 }
  | document header       { $2 :: $1 }
  | document string_block { Paragraph($2) :: $1 }
  | /* nothing */         { [] }

header:
  | HASH STRING { Header($1, $2) }


comment:
  | COMMENT_START STRING COMMENT_END { Comment $2 }


string_block:
  | STRING { String $1 }
  | LBRACKET STRING RBRACKET LPAREN URL RPAREN { Link($2, $5) }

%%
