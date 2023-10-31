%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "zeynephaykir-hw2.tab.h"
void yyerror(const char *msg) {
    return;}
%}

%token tSTRING tGET tSET tFUNCTION tPRINT tIF tRETURN tADD tSUB tMUL tDIV tINC tGT tEQUALITY tDEC
%token tLT tLEQ tGEQ tIDENT tNUM

%left tADD tSUB
%left tMUL tDIV
%right tINC tDEC

%start program
%%

program:    '[' statement_list ']'
    ;

statement_list:
        statements
		| statements statement_list ;
		;

statements:
    | set_statement
    | if_statement
    | print_statement
    | increment_statement
    | decrement_statement
    | return_statement
    | expression
    ;

expression:		
    tNUM
	| tSTRING
	| get
	| function_declaration
	| operator_application
	| condition
	;

expression_list:	
    expression ',' expression_list
	| expression
	;

parameter_list:
    | tIDENT
    | tIDENT ',' parameter_list
    ;

condition:
	'[' tLEQ ',' expression ',' expression ']'
	| '[' tGEQ ',' expression ',' expression ']'
	| '[' tEQUALITY ',' expression ',' expression ']'
	| '[' tGT ',' expression ',' expression ']'
	| '[' tLT ',' expression ',' expression ']'
 	;

set_statement:
    '[' tSET ',' tIDENT ',' expression ']'
        ;


if_statement:
    '[' tIF ',' condition ',' then else ']'
    | '[' tIF ',' condition ',' then ']'
    ;

print_statement:
    '[' tPRINT ','  expression ']'
    ;

increment_statement:	
    '[' tINC ',' tIDENT ']' 
	;

decrement_statement:
	'[' tDEC ',' tIDENT ']'
	;

return_statement:
    '[' tRETURN ',' expression ']'
    | '[' tRETURN ']'
    ;

then:
    '[' statement_list ']'
    ;

else:
    '[' statement_list ']'
    ;

get:
    '[' tGET ',' tIDENT ']'
    | '[' tGET ',' tIDENT ',' '[' ']' ']'
    | '[' tGET ',' tIDENT ',' '[' expression_list ']' ']'
    ;

operator_application:	
    '[' tADD ',' expression ',' expression ']'
	| '[' tSUB ',' expression ',' expression ']'
	| '[' tMUL ',' expression ',' expression ']'
	| '[' tDIV ',' expression ',' expression ']'
	;

function_declaration:
    '[' tFUNCTION ',' '[' ']' ',' '[' statement_list ']' ']'
    | '[' tFUNCTION ',' '[' parameter_list ']' ',' '[' statement_list ']' ']' 
    ;

%%

int main() {
   if(yyparse())
   {
        printf("ERROR\n");
        return 1;
   }
   else
   {
        printf("OK\n");
        return 0;
   }
}
