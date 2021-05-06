grammar Grammer;
start : library* class+;
library : lib1 | lib2 | lib3 | lib4;
lib1 : 'import' (NAME('.'NAME)*) SEMI;
lib2 : 'from' (NAME('.'NAME)*) 'import' (NAME('.'NAME)*) (',' (NAME('.'NAME)*))* SEMI;
lib3 : 'from' (NAME('.'NAME)*) 'import *' SEMI;
lib4 : 'from' (NAME('.'NAME)*) 'import' (NAME('.'NAME)*) '=>' NAME SEMI;

datatype : 'Int' | 'String' | 'Double' | 'Char';
accesslevel : 'public' | 'private' | 'protected';

class : accesslevel? 'class' NAME  extend? impel? BRACEIN classbody* classinit? classbody* BRACEOUT;
extend : 'extends' NAME;
impel : 'implements' NAME ('with' NAME)*;
classbody : accesslevel? ( functions | defineVar );
classinit : accesslevel? NAME BRACIN (datatype NAME(',' datatype NAME)*)? BRACOUT BRACEIN statement* BRACEOUT;
defineVar: defineVar1 | defineVar2 | defineArray;
defineVar1 : 'var' NAME ':' datatype ('=' initial_value)? SEMI;
defineVar2 : 'const' NAME ('=' initial_value)? SEMI;
defineArray : defineArray1 | defineArray2;
defineArray1 : 'var' NAME ':' 'new ' 'Array' '['datatype']' BRACIN INT BRACOUT SEMI;
defineArray2 : 'const' NAME '=' 'Array' BRACIN DATATYPE (','DATATYPE)*BRACOUT SEMI;
initial_value : DATATYPE | (NAME('.'NAME)*);

returnstatement : 'return' (NAME('.'NAME)*)? SEMI;
statement : ifstatement | forstatement | whilestatement
            | switchstatement | trystatement | defineVar | returnstatement;
ifstatement : 'if' BRACIN conditions+ BRACOUT  BRACEIN statement* BRACEOUT
            ('elif' BRACIN conditions+ BRACOUT  BRACEIN statement* BRACEOUT)*
            ('else' BRACIN conditions+ BRACOUT  BRACEIN statement* BRACEOUT)?;
conditions : ((NAME('.'NAME)*) ('<' | '>' | '>=' | '<=' | '==' | '!=') (NAME('.'NAME)*)) | BOOL ;
forstatement : for1 | for2;
for1 : 'for' BRACIN for1init* SEMI conditions+ SEMI doLine* BRACOUT BRACEIN statement* BRACEOUT;
for2 : 'for' BRACIN datatype NAME 'in' (NAME('.'NAME)*) BRACOUT BRACEIN statement* BRACEOUT;
for1init : defineVar ;/*fix this*/
doLine : 'a++' ; /*fix this*/

trystatement : 'try' BRACEIN statement* BRACEOUT cath+;
cath : cath1 | cath2 ;
cath1 :'on' NAME ('catch' BRACIN((NAME('.'NAME)*))BRACOUT)? BRACEIN statement* BRACEOUT;
cath2 : 'catch' BRACIN ((NAME('.'NAME)*)) BRACOUT BRACEIN statement* BRACEOUT;

whilestatement : while1 | while2;
while1 : 'while' BRACIN conditions+ BRACOUT BRACEIN statement* BRACEOUT;
while2 : 'do' BRACEIN statement* BRACEOUT 'while' BRACIN conditions+ BRACOUT SEMI;
switchstatement : 'switch' BRACIN (NAME('.'NAME)*) BRACOUT BRACEIN ('case' DATATYPE ':' statement* ('break' SEMI)?)+
            ('default' ':' statement* ('break' SEMI)?)? BRACEOUT;

functions : fun1 | fun2;
fun1 :datatype NAME BRACIN (datatype NAME)* BRACOUT
                  BRACEIN statement*BRACEOUT;
fun2: 'void' NAME BRACIN (datatype NAME)* BRACOUT
                  BRACEIN statement* BRACEOUT;

COMMENT :'/*' .*? '*/'->skip;
LINECOMMENT :  '//' ~( '\r' | '\n' )*->skip;
DATATYPE : INT | DOUBLE | CHAR | STRING;
BOOL : 'true' | 'false';
DIGIT : [0-9];
INT : DIGIT+;
DOUBLE : INT+ '.' INT+;
CHAR : '\'' ~['\\'] '\'';
STRING : '"' ('\\' ["\\] | ~["\\\r\n])* '"' ;
BRACIN : '(';
BRACOUT : ')';
SEMI : ';' ;
BRACEIN : '{';
BRACEOUT : '}' ;
WS : [ \t\r\n]+ -> skip;
NAME : [A-za-z$_] ([A-za-z0-9$_])+;