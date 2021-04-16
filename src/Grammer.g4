grammar Grammer;
start : library*;
library : lib1 | lib2 | lib3 | lib4;
lib1 : 'import' NAMEUSE ';';
lib2 : 'from' NAMEUSE 'import' NAMEUSE (',' NAMEUSE)* ';';
lib3 : 'from' NAMEUSE 'import *' ';';
lib4 : 'from' NAMEUSE 'import' NAMEUSE '=>' NAME ';';




NAMEUSE :NAME (['.']NAME)*;
NAME : [A-za-z'$''_'] ([A-za-z0-9'$''_'])+;
WS: [ \t\r\n]+ -> skip;