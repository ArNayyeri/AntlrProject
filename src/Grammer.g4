grammar Grammer;
start : library* class+;
library : lib1 | lib2 | lib3 | lib4;
lib1 : 'import' (NAME('.'NAME)*) ';';
lib2 : 'from' (NAME('.'NAME)*) 'import' (NAME('.'NAME)*) (',' (NAME('.'NAME)*))* ';';
lib3 : 'from' (NAME('.'NAME)*) 'import *' ';';
lib4 : 'from' (NAME('.'NAME)*) 'import' (NAME('.'NAME)*) '=>' NAME ';';

datatype : 'Int' | 'String' | 'Double' | 'Char';

class : ACCESSLEVEL? 'class' NAME  extend?  impel? '{' classbody* classinit? classbody* '}';
extend : 'extends' NAME;
impel : 'implements' NAME ('with' NAME)*;
classbody : ACCESSLEVEL? ( functions | defineVar);
classinit : ACCESSLEVEL? NAME '('(datatype NAME)* ')' '{' statement* '}';
defineVar: defineVar1 | defineVar2 | defineArray;
defineVar1 : 'var' NAME ':' datatype ('=' initial_value)? ';';
defineVar2 : 'const' NAME ('=' initial_value)? ';';
defineArray :defineArray1 |defineArray2;
defineArray1 : 'var' NAME ':' 'new ' 'Array' '['datatype']' '(' INT ')' ';';
defineArray2 : 'const' NAME '=' 'Array' '(' DATATYPE (','DATATYPE)*')' ';';
initial_value : DATATYPE | (NAME('.'NAME)*);

statement : ifstatement | forstatement | whilestatement | switchstatement | trystatement | defineVar;
ifstatement : 'if' '(' conditions+ ')'  '{' statement* '}'
            ('elif' '(' conditions+ ')'  '{' statement* '}')*
            ('else' '(' conditions+ ')'  '{' statement* '}')?;
conditions : ((NAME('.'NAME)*) ('<' | '>' | '>=' | '<=' | '==' | '!=') (NAME('.'NAME)*)) | BOOL ;
forstatement : for1 | for2;
for1 : 'for' '(' for1init* ';' conditions+ ';' doLine* ')' '{' statement* '}';
for2 : 'for' '(' datatype NAME 'in' (NAME('.'NAME)*) ')' '{' statement* '}';
for1init : defineVar ;/*fix this*/
doLine : 'a++' ; /*fix this*/

trystatement : 'try' '{' statement* '}' cath+;
cath : cath1 | cath2 ;
cath1 :'on' NAME ('catch' '('((NAME('.'NAME)*))')')? '{' statement* '}';
cath2 : 'catch' '(' ((NAME('.'NAME)*)) ')' '{' statement* '}';

whilestatement : while1 | while2;
while1 : 'while' '(' conditions+ ')' '{' statement* '}';
while2 : 'do' '{' statement* '}' 'while' '(' conditions+ ')' ';';
switchstatement : 'switch' '(' (NAME('.'NAME)*) ')' '{' ('case' DATATYPE ':' statement* ('break' ';')?)+
            ('default' ':' statement* ('break' ';')?)? '}';

functions : fun1 | fun2;
fun1 :datatype NAME '(' (datatype NAME)* ')'
                  '{' statement* ('return' NAME ';') statement* '}';
fun2: 'void' NAME '(' (datatype NAME)* ')'
                  '{' statement* ('return;')? statement* '}';

COMMENT :'/*' .*? '*/'->skip;
LINECOMMENT :  '//' ~( '\r' | '\n' )*->skip;
ACCESSLEVEL : 'public' | 'private' | 'protected';
DATATYPE : INT | DOUBLE | CHAR | STRING;
BOOL : 'true' | 'false';
INT : [0-9]+;
DOUBLE : INT+ '.' INT+;
CHAR : '\'' ~[''] '\'';
STRING : '"' CHAR* '"';
WS : [ \t\r\n]+ -> skip;
NAME : [A-za-z$_] ([A-za-z0-9$_])+;