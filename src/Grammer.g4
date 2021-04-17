grammar Grammer;
start : library* class+;
library : lib1 | lib2 | lib3 | lib4;
lib1 : 'import' (NAME('.'NAME)*) ';';
lib2 : 'from' (NAME('.'NAME)*) 'import' (NAME('.'NAME)*) (',' (NAME('.'NAME)*))* ';';
lib3 : 'from' (NAME('.'NAME)*) 'import *' ';';
lib4 : 'from' (NAME('.'NAME)*) 'import' (NAME('.'NAME)*) '=>' NAME ';';

class : ACCESSLEVEL? 'class' NAME  extend?  impel? '{'  '}'; //statement*
extend : 'extends' NAME;
impel : 'implements' NAME ('with' NAME)*;
//statement : ;

COMMENT :'/*' .*? '*/'->skip;
LINECOMMENT :  '//' ~( '\r' | '\n' )*->skip;
ACCESSLEVEL : 'public' | 'private' | 'protected';
WS : [ \t\r\n]+ -> skip;
NAME : [A-za-z$_] ([A-za-z0-9$_])+;