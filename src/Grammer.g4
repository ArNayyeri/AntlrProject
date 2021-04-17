grammar Grammer;
start : library;
library : lib1 | lib2 | lib3 | lib4;
lib1 : 'import' (NAME('.'NAME)*) ';';
lib2 : 'from' (NAME('.'NAME)*) 'import' (NAME('.'NAME)*) (',' (NAME('.'NAME)*))* ';';
lib3 : 'from' (NAME('.'NAME)*) 'import *' ';';
lib4 : 'from' (NAME('.'NAME)*) 'import' (NAME('.'NAME)*) '=>' NAME ';';



COMMENT :'/*' .*? '*/'->skip;
LINECOMMENT :  '//' ~( '\r' | '\n' )*->skip;
WS : [ \t\r\n]+ -> skip;
NAME : [A-za-z$_] ([A-za-z0-9$_])+;