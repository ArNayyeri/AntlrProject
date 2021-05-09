grammar Grammer;
start : library* class+;
library : lib1 | lib2 | lib3 | lib4;
lib1 : 'import' NAME('.'NAME)* SEMI;
lib2 : 'from' NAME('.'NAME)* 'import' NAME('.'NAME)* (',' NAME('.'NAME)*)* SEMI;
lib3 : 'from' NAME('.'NAME)* 'import *' SEMI;
lib4 : 'from' NAME('.'NAME)* 'import' NAME('.'NAME)* '=>' NAME SEMI;

datatypes : INT | DOUBLE | CHAR | STRING | BOOL;
accesslevel : 'public' | 'private' | 'protected';

class : accesslevel? 'class' NAME  extend? impel? BRACEIN classbody* classinit? classbody* BRACEOUT;
extend : 'extends' NAME;
impel : 'implements' NAME ('with' NAME)*;
classbody : accesslevel? ( functions | defineVar );
classinit : accesslevel? NAME BRACIN (DATATYPE NAME ('=' initial_value)? (',' DATATYPE NAME ('=' initial_value)?)*)?
                    BRACOUT BRACEIN statement* BRACEOUT;
defineVar: ( 'var' | 'const' ) (defineVar1 | defineVar2 | defineVar3 | defineVar4);
defineVar1 :  NAME ':' DATATYPE ('=' initial_value)? (',' NAME ':' DATATYPE ('=' initial_value)?)* SEMI;
defineVar2 :  NAME ('=' initial_value)? (',' ('=' initial_value)?)* SEMI;
defineVar4 : NAME ':' 'new' ('Array' defineArray1 | NAME defineClass);
defineArray1 : '['DATATYPE']' BRACIN INT BRACOUT SEMI;
defineVar3 :  NAME '=' 'Array' BRACIN datatypes? (','datatypes)* BRACOUT SEMI;
defineClass : BRACIN (datatypes(','datatypes)*)? BRACOUT SEMI;
initial_value : opeator;

returnstatement : 'return' NAME('.'NAME)*? SEMI;
statement : ifstatement | forstatement | whilestatement
            | switchstatement | trystatement | defineVar | returnstatement | (initial_value SEMI);
ifstatement : 'if' BRACIN conditions+ BRACOUT  BRACEIN statement* BRACEOUT
            ('elif' BRACIN conditions+ BRACOUT  BRACEIN statement* BRACEOUT)*
            ('else' BRACEIN statement* BRACEOUT)?;
conditions : (opeator) | BOOL ;
forstatement : for1 | for2;
for1 : 'for' BRACIN for1init* SEMI conditions+ SEMI doLine* BRACOUT BRACEIN statement* BRACEOUT;
for2 : 'for' BRACIN 'var' NAME 'in' NAME('.'NAME)* BRACOUT BRACEIN statement* BRACEOUT;
for1init : defineVar | initial_value;
doLine : opeator ;

trystatement : 'try' BRACEIN statement* BRACEOUT cath+;
cath : cath1 | cath2 ;
cath1 :'on' NAME ('catch' BRACIN(NAME('.'NAME)*)BRACOUT)? BRACEIN statement* BRACEOUT;
cath2 : 'catch' BRACIN (NAME('.'NAME)*) BRACOUT BRACEIN statement* BRACEOUT;

whilestatement : while1 | while2;
while1 : 'while' BRACIN conditions+ BRACOUT BRACEIN statement* BRACEOUT;
while2 : 'do' BRACEIN statement* BRACEOUT 'while' BRACIN conditions+ BRACOUT;
switchstatement : 'switch' BRACIN NAME('.'NAME)* BRACOUT BRACEIN ('case' datatypes ':' statement* ('break' SEMI)?)+
            ('default' ':' statement* ('break' SEMI)?)? BRACEOUT;

functions : fun1 | fun2;
fun1 :DATATYPE NAME BRACIN (DATATYPE NAME ('=' initial_value)? (',' DATATYPE NAME ('=' initial_value)?)*)? BRACOUT
                  BRACEIN statement*BRACEOUT;
fun2: 'void' NAME BRACIN (DATATYPE NAME ('=' initial_value)? (',' DATATYPE NAME ('=' initial_value)?)*)? BRACOUT
                  BRACEIN statement* BRACEOUT;
opeator : o1;
o1 : o1 '=' o2 | o1 '+=' o2 | o1 '-=' o2 | o1 '*=' o2 | o1 '//=' o2 | o1 '/=' o2 | o1 '%=' o2 | o2 ;
o2 : o2 'not' o3 | o2 'and' o3 | o2 'or' o3 | o2 '||' o3 | o2 '&&' o3 | o3;
o3 : o3 '<' o4 | o3 '>' o4 | o3 '<=' o4 | o3 '>=' o4 | o4;
o4 : o4 '==' o5 | o4 '!=' o5 | o4 '<>' o5 | o5;
o5 : o5 '&' o6 | o5 '^' o6 | o5 '|' o6 | o6;
o6 : o6 '<<' o7 | o6 '>>' o7 | o7;
o7 : o7 '+' o8 | o7 '-' o8 | o8;
o8 : o8 '*' o8 | o8 '//' o9 |  o8 '/' o9 |  o8 '%' o9 | o9;
o9 : '++' o9 | '--' o9 | o9 '++' | o9 '--'| o10;
o10 : '+' o10 | '-' o10 | o11;
o11 : '~' o11 | o12;
o12 : o12 '**' o13 | o13;
o13 : BRACIN o1 BRACOUT | NAME('.'NAME)* | datatypes;

COMMENT :'/*' .*? '*/'->skip;
LINECOMMENT :  '#' ~( '\r' | '\n' )*->skip;
BOOL : 'true' | 'false';
DOUBLE : INT+ '.' INT+;
INT : DIGIT+;
DIGIT : [0-9];
CHAR : '\'' ('\\' ["\\] | ~["\\\r\n]) '\'';
STRING : '"' ('\\' ["\\] | ~["\\\r\n])* '"' ;
BRACIN : '(';
BRACOUT : ')';
SEMI : ';' ;
BRACEIN : '{';
BRACEOUT : '}' ;
DATATYPE : 'Int' | 'String' | 'Double' | 'Char';
WS : [ \t\r\n]+ -> skip;
NAME : [A-Za-z$_] ([A-Za-z0-9$_])+;