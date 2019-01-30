Definitions.

NUMBER = \-?[0-9]+
WS = [\s\t]
LB = \n|\r\n|\r


Rules.

{NUMBER}    : {token, {number, TokenLine, list_to_integer(TokenChars)}}.
\+          : {token, {plus, TokenLine}}.
\-          : {token, {minus, TokenLine}}.
\*          : {token, {mult, TokenLine}}.
\/          : {token, {divd, TokenLine}}.
\(          : {token, {lparen, TokenLine}}.
\)          : {token, {rparen, TokenLine}}.
{WS}        : skip_token.
{LB}        : skip_token.

Erlang code.
