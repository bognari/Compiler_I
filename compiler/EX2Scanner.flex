package ex2; // The generated parser will belong to this package 

import beaver.Symbol;
import beaver.Scanner;

import ex2.EX2Parser.Terminals; 
// The terminals are implicitly defined in the parser
%%

// define the signature for the generated scanner
%class EX2Scanner 
%extends Scanner

// the interface between the scanner and the parser is the nextToken() method
%function nextToken
%type Symbol 
%yylexthrow Scanner.Exception
%eofval{
	return sym(Terminals.EOF, "end-of-file");
%eofval}

// store line and column information in the tokens
%line
%column

// this code will be inlined in the body of the generated scanner class
%{
  private Symbol sym(short id) {
    return new beaver.Symbol(id, yyline + 1, yycolumn + 1, yylength());
  }
  private Symbol sym(short id, Object value) {
    return new beaver.Symbol(id, yyline + 1, yycolumn + 1, yylength(), value);
  }
%}

LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
WhiteSpace     = {LineTerminator}|[ \t\f]

CountT = [1-9][0-9]*|[0]
ValueT = {CountT}[.][:digit:][:digit:]
IDT = [:jletter:]+({WhiteSpace}*[:jletterdigit:]*)*

%%
// discard whitespace information and comments

{LineTerminator} { //System.out.println("LB!!!!");
}

{WhiteSpace} { }

// token definitions
"," {         //System.out.println("Komma");
return sym(Terminals.C); }
{CountT} {  //System.out.println("Count");
            //System.out.println(yytext());
            return sym(Terminals.COUNT, Integer.parseInt(yytext())); }
{ValueT} {  //System.out.println("Value");
            //System.out.println(yytext());
            return sym(Terminals.VALUE, Double.parseDouble(yytext())); }
{IDT} {      //System.out.println("ID");
             //System.out.println(yytext());
            return sym(Terminals.ID, yytext()); }


// fall through errors
.            { throw new beaver.Scanner.Exception("illegal character \"" + yytext() + "\" at line " + yyline + "," + yycolumn); }
