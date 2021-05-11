parser grammar MyParser;

@header  {
    import java.util.Properties;
    import java.util.Scanner;
}
options {
    tokenVocab=MyLexer;
}

start : library* class+;
library : lib1 | lib2 | lib3 | lib4;
lib1 : IMPORT NAME(DOT NAME)* SEMI;
lib2 : FROM NAME(DOT NAME)* IMPORT NAME(DOT NAME)* (COMMA NAME(DOT NAME)*)* SEMI;
lib3 : FROM NAME(DOT NAME)* IMPORTSTAR SEMI;
lib4 : FROM NAME(DOT NAME)* IMPORT NAME(DOT NAME)* FLASH NAME SEMI;

string : S_BRACEIN string BRACEOUT
    | opeator
    | DQUOTE stringContents* DQUOTE
    ;

stringContents : STRINGTYPE
               | ESCAPEDOLLAR
               | STARTInterpolation string BRACEOUT;

datatypes : INT | DOUBLE | BOOL | string;

class : Accesslevel? CLASS NAME  extend? impel? BRACEIN classbody* classinit? classbody* BRACEOUT;
extend : EXTEND NAME;
impel : IMPLEMENT NAME (WITH NAME)*;
classbody : Accesslevel? ( functions | defineVar );
classinit : Accesslevel? NAME BRACIN (DATATYPE NAME (EQUAL initial_value)? (COMMA DATATYPE NAME (EQUAL initial_value)?)*)?
                    BRACOUT BRACEIN statement* BRACEOUT;
defineVar: ( VAR | CONST ) (defineVar1 | defineVar2 | defineVar3 | defineVar4);
defineVar1 :  NAME COLON DATATYPE (EQUAL initial_value)? (COMMA NAME COLON DATATYPE (EQUAL  initial_value)?)* SEMI;
defineVar2 :  NAME (EQUAL  initial_value)? (COMMA (EQUAL initial_value)?)* SEMI;
defineVar4 : NAME COLON NEW (ARRAY defineArray1 | NAME defineClass);
defineArray1 : BRACKETIN DATATYPE BRACKETOUT  BRACIN INT BRACOUT SEMI;
defineVar3 :  NAME EQUAL ARRAY BRACIN datatypes? (COMMA datatypes)* BRACOUT SEMI;
defineClass : BRACIN (datatypes( COMMA datatypes)*)? BRACOUT SEMI;
initial_value : opeator | SCI | string;


returnstatement : RETURN NAME(DOT NAME)*? SEMI;
statement : ifstatement | forstatement | whilestatement
            | switchstatement | trystatement | defineVar | returnstatement | (initial_value SEMI) | functionCall | print;
ifstatement : IF BRACIN conditions+ BRACOUT  BRACEIN statement* BRACEOUT
            (ELIF BRACIN conditions+ BRACOUT  BRACEIN statement* BRACEOUT)*
            (ELSE BRACEIN statement* BRACEOUT)?;

functionCall : NAME (DOT NAME BRACIN (datatypes | NAME(DOT NAME)*)? (COMMA (datatypes | NAME(DOT NAME)*))* BRACOUT)+ SEMI;
print : PRINT BRACIN initial_value BRACOUT SEMI;

conditions : opeator;
forstatement : for1 | for2;
for1 : FOR BRACIN for1init* SEMI conditions+ SEMI doLine* BRACOUT BRACEIN statement* BRACEOUT;
for2 : FOR BRACIN VAR NAME IN NAME(DOT NAME)* BRACOUT BRACEIN statement* BRACEOUT;
for1init : defineVar | initial_value;
doLine : opeator ;

trystatement : TRY BRACEIN statement* BRACEOUT cath+;
cath : cath1 | cath2 ;
cath1 :ON NAME (CATCH BRACIN(NAME(DOT NAME)*)BRACOUT)? BRACEIN statement* BRACEOUT;
cath2 : CATCH BRACIN (NAME(DOT NAME)*) BRACOUT BRACEIN statement* BRACEOUT;

whilestatement : while1 | while2;
while1 : WHILE BRACIN conditions+ BRACOUT BRACEIN statement* BRACEOUT;
while2 : DO BRACEIN statement* BRACEOUT WHILE BRACIN conditions+ BRACOUT;

switchstatement : SWITCH BRACIN NAME(DOT NAME)* BRACOUT BRACEIN (CASE datatypes COLON statement* (BREAK SEMI)?)+
            (DEFAULT COLON statement* (BREAK SEMI)?)? BRACEOUT;

functions : fun1 | fun2;
fun1 :DATATYPE NAME BRACIN (DATATYPE NAME ( EQUAL  initial_value)? (COMMA DATATYPE NAME (EQUAL initial_value)?)*)? BRACOUT
                  BRACEIN statement*BRACEOUT;
fun2: VOID NAME BRACIN (DATATYPE NAME (EQUAL initial_value)? (COMMA DATATYPE NAME (EQUAL initial_value)?)*)? BRACOUT
                  BRACEIN statement* BRACEOUT;
opeator : o1;
level1 : PLUSEQUAL | MINUSEQUAL | MULTIEQUAL | DIVIDEEQUAL1 | DIVIDEEQUAL2 | MODEQUAL | EQUAL;
level2 : NOT | AND | OR;
level3: LESS | GREATER | LESSEQUAL | GREATEREQUAL;
level4: EQUALITY | NOTEQUALITY;
level5 : BIT1 | BIT2 | BIT3;
level6: LESSLESS | GREATERGREATER;
level7_10 : PLUS | MINUS;
level8: MULIT | DIVIDE1 | DIVIDE2 | MOD;
level9: PLUSPLUS | MINUSMINUS;
level11: TILDE;
level12 : POW;
o1 : o1 level1 o2 | o2 ;
o2 : o2 level2 o3 | o3;
o3 : o3 level3 o4 | o4;
o4 : o4 level4 o5 | o5;
o5 : o5 level5 o6 | o6;
o6 : o6 level6 o7 | o7;
o7 : o7 level7_10 o8 | o8;
o8 : o8 level8 o8 | o9;
o9 : level9 o9 | o9 level9 | o10;
o10 : level7_10 o10 | o11;
o11 : level11 o11 | o12;
o12 : o12 level12 o13 | o13;
o13 : BRACIN o1 BRACOUT | NAME(DOT NAME)* | INT | DOUBLE | BOOL ;