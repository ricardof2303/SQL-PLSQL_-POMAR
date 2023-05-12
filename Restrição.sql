Restrição do tipo check na tabela tree, de forma que as árvores só podem receber os respectivos tipos:
white, yellow, nectarine
ALTER TABLE TREE
    add CONSTRAINT tree_ck
        check(LOWER (type_tree) IN ('white', 'yellow', 'nectarine'));


Restrição do tipo check na tabela harvest, de forma que os valores inseridos na coluna de bons kilos
tem que ser maiores que 0
ALTER TABLE harvest
    ADD CONSTRAINT kilo_good_ck
        CHECK ( ( kilo_good > 0 ) );


Restrição do tipo check na tabela harvest, de forma que os valores inseridos na coluna de kilos ruins
não podem ser menores que 0 
ALTER TABLE harvest 
    ADD CONSTRAINT kilo_bad_ck
        CHECK ( ( kilo_bad > - 1 ) );
		
		
Restrição do tipo check na tabela caliber, que apenas os quatro calibres pré-definidos é que podem ser inseridos
na coluna corespondente, os valores são: -> AA, A, B, C	
ALTER TABLE CALIBER
    add (CONSTRAINT caliber_ck
        check(UPPER(cal) in ('AA', 'A', 'B', 'C')));

