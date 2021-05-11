lexer grammar MyLexer;

Accesslevel :'public' | 'private' | 'protected';

COMMENT :'/*' .*? '*/'->skip;
LINECOMMENT :  '#' ~( '\r' | '\n' )*->skip;
IMPORT : 'import';
IMPORTSTAR : 'import *';
FROM : 'from';
FLASH : '=>';
DOT : '.';
COMMA :  ',';
CLASS : 'class';
EXTEND : 'extends';
IMPLEMENT :'implements';
EQUAL :  '=';
WITH : 'with';
VAR : 'var';
CONST : 'const';
COLON : ':';
NEW : 'new';
ARRAY : 'Array';
BRACKETIN :  '[';
BRACKETOUT : ']';
RETURN : 'return';
IF : 'if';
ELIF : 'elif';
ELSE : 'else';
FOR : 'for';
IN : 'in';
TRY : 'try';
CATCH : 'catch';
ON : 'on';
WHILE : 'while';
DO : 'do';
SWITCH : 'switch';
CASE : 'case';
BREAK : 'break';
DEFAULT : 'default';
VOID : 'void';
PRINT : 'print';
PLUSEQUAL: '+=';
MINUSEQUAL : '-=';
MULTIEQUAL : '*=';
DIVIDEEQUAL1 : '/=';
DIVIDEEQUAL2 : '//=';
MODEQUAL : '%=';
NOT : 'not';
AND : 'and' | '&&';
OR : 'or' | '||';
LESS : '<';
GREATER : '>';
LESSEQUAL: '<=';
GREATEREQUAL : '>=';
EQUALITY : '==';
NOTEQUALITY: '!='| '<>';
BIT1 : '&';
BIT2: '|';
BIT3 : '^';
LESSLESS:'<<';
GREATERGREATER: '>>';
PLUS : '+';
MINUS : '-';
MULIT : '*';
DIVIDE1 : '/';
DIVIDE2 : '//';
MOD : '%';
PLUSPLUS : '++';
MINUSMINUS : '--';
TILDE: '~';
POW : '**';
DOLLAR : '$';
UNDERLINE : '_';
BOOL : 'true' | 'false';
DOUBLE : INT* DOT INT+;
SCI : DIGIT DOT INT 'e' ('+' | '-') INT;
INT : DIGIT+;
fragment DIGIT : [0-9];
fragment LETTER : [A-Za-z];
CHAR : '\'' ('\\' ["\\] | ~["\\\r\n]) '\'';
STRING : '"' ('\\' ["\\] | ~["\\\r\n])* '"';
BRACIN : '(';
BRACOUT : ')';
SEMI : ';' ;
BRACEIN : '{';
BRACEOUT : '}';
DATATYPE : 'Int' | 'String' | 'Double' | 'Char';
WS : [ \t\r\n]+ -> skip;
NAME : (LETTER | DOLLAR | UNDERLINE) (LETTER | DOLLAR | UNDERLINE | DIGIT)+;