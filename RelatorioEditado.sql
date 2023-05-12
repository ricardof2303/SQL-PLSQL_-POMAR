--Definição do produto
Estou residindo atualmente em Belmonte e nessa região das beiras vemos muitos pomares.
Durante as férias de verão estive trabalhando em alguns pomares de pêssego e tive a impressão que em algumas localidades 
os frutos tinham melhor qualidade, um calibre maior, produzindo assim maior lucro ao agricultor.
Então me ocorreu a seguinte interrogação, e se esse agricultor tivesse como analisar os frutos por localidade? Para isso
ele precisaria de uma base de dados, com os dados dos pomares e das colheitas, pra saber qual localidade produzia a maior quantidade de frutos e 
com melhores calibres. Daí surge esse trabalho.

Esse trabalho é uma base de dados dos pomares de um agricultorar que tem pomares em cinco localidades diferentes.
A princípio são pomares de pêssego, mas pode ser inserido pomares de outros tipos de frutos.
É composto por seis entiades, das quais duas são tabelas de ligação.
Visto que é alvo que esse trabalho contenha somente seis tabelas, algumas outras questões que podem influenciar na podutividade
de uma pomar não são abordadas, tais como poda, irrigação, condições climáticas, etc. partimos do princípio que essas questões são a mesma 
para todos os pomares.
Esse trabalho é feito com a finalidade principal de fazer uma análise de qualidade e quantidade de fruto/localidade.

--#########################################################################################
--Modelo ER (basta o modelo relacional com a desnormalização)

Acredito que aqui o professor queira o pdf do modelo relacional

--#########################################################################################
--Dicionário de Dados
ok




--#########################################################################################
--Desnormalização e análise das anomalias

Para resolver problema de velocidade de query fiz desnormalização a tabela ORCHARD por adição de coluna derivada:
TOT_TREE
A desnormalização por adição de coluna derivada pode originar anomalias de INSERT, DELETE, UPDATE. Estas anomalias podem surgir em qualquer uma das tabelas afetadas. Em seguida faço a análise de anomalias.


Análise das anomalias de INSERT no TREE_ORC:
Quando se insere um registo na tabela TREE_ORC tenho de lidar com a coluna derivada existente na tabela ORCHARD? 
Sim, pois quando se insere um registo na tabela TREE_ORC, o valor correspondente do TREE_AMOUNT do registo relacionado da tabela ORCHARD deve ser incrementado
Resolução da anomalia de INSERT na ORCHARD: 
1. INSERT na tabela TREE_ORC
2. UPDATE na tabela ORCHARD incrementando a coluna TOT_TREE
Este caso necessita de uma transação, pois ambos os comandos são de escrita e têm de ser executados de forma atómica.

Análise das anomalias de INSERT na ORCHARD:
Quando se insere um registo na ORCHARD tenho de lidar com as colunas derivadas?
Sim, pois quando se insere um registo na tabela ORCHARD não existe nenhum registo correspondente na tabela TREE_ORC, pelo que o valor do 
TOT_TREE deve ser 0.
Resolução da anomalia de INSERT na ORCHARD: 
1. INSERT na tabela ORCHARD colocando 0 na coluna TOT_TREE.
Este caso não necessita de uma transação, pois só existe um único comando de escrita.

Análise das anomalias de DELETE no TREE_ORC:
Quando se elimina um registo na TREE_ORC tenho de lidar com a coluna derivada existente na tabela ORCHARD? 
Sim, pois quando se elimina um registo na tabela TREE_ORC, os valores correspondentes do TOT_TREE do registo relacionado da tabela ORCHARD deve ser decrementado 
Resolução da anomalia de DELETE na ORCHARD: 
1. DELETE na tabela TREE_ORC
2. UPDATE na tabela ORCHARD nos registos relacionados, decrementando o TOT_TREE.
Este caso necessita de uma transação, pois ambos os comandos são de escrita e têm de ser executados de forma atómica.

Análise das anomalias de DELETE no ORCHARD:
Quando se elimina um registo na ORCHARD temos de lidar com a coluna derivada?
Não, pois a eliminação do registo na ORCHARD vai eliminar a eventual redundância, já que a coluna derivada se encontra precisamente nessa tabela 

Análise das anomalias de UPDATE no TREE_ORC:
Quando se altera um registo na TREE_ORC tenho de lidar com as colunas derivadas existente na tabela ORCHARD? 
Sim, é necessário atualizar os valores correspondentes do TREE_TOT da tabela ORCHARD
Resolução da anomalia de UPDATE na TREE_ORC: 
1. UPDATE na tabela TREE_ORC alterando a quantidade de árvores
2. UPDATE na tabela ORCHARD alterando a TOT_TREE.
Este caso necessita de uma transação, pois ambos os comandos são de escrita e têm de ser executados de forma atómica.

Análise das anomalias de UPDATE no ORCHARD:
Quando se altera um registo na ORCHARD tenho de lidar com a coluna derivada existente nessa tabela? 
Sim, caso as alterações afetem a coluna TOT_TREE alterando a quantidade de árvores.
Resolução da anomalia de UPDATE na ORCHARD: 
1. SELECTE na tabela ORCHARD para somar a quantidade de árvore total daquele pomar
2. UPDATE na tabela TREE_ORC
Este caso não necessita de uma transação pois apenas um comando é de escrita, podendo ser feita com subquerys.

--#########################################################################################

--Restrições
As restrições de integridade restringe-nos do que podemos colocar na tabela.
Nesse trabalho temos as seguintes restrições:
	Chave primaria que deve ser única e não nula
	Chave estrangeira que são restrição de integridade referencial
	Restrição de integridade de domínio
		Temos como restrição os tipos de dados e o espaço (tamanho) que pode ocupar
		e também restrições do tipo Check que põe condições para insersão dos dados.
		Sobre essa última especifico abaixo, sobre as demais, são especificadas
		no dicionário de dados

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



--#########################################################################################
--Matriz CRUD, Privilégios e Roles

----------------------------------------------------------------------------------------
Utilizador		Tree	Caliber		Orchard		Harvest		Tree_cal		Tree_Orc 
----------------------------------------------------------------------------------------
adm				CRUD	CRUD		CRUD		CRUD		CRUD			CRUD
mgr_Orchard		CRUD	CRD			CRUD 		R							R
mgr_Harvest							R			CRUD		R				R
client											R
----------------------------------------------------------------------------------------
1 - Criação
create role adm;
create role mgr_Orchard;
create role mgr_Harvest;
create role client; 

2 - Carregamento
grant CREATE, SELECT, UPDATE, DELETE on Tree to adm;
grant CREATE, SELECT, UPDATE, DELETE on Caliber to adm;
grant CREATE, SELECT, UPDATE, DELETE on Orchard to adm;
grant CREATE, SELECT, UPDATE, DELETE on Harvest to adm;
grant CREATE, SELECT, UPDATE, DELETE on Tree_cal to adm;
grant CREATE, SELECT, UPDATE, DELETE on Tree_Orc to adm;

grant CREATE, SELECT, UPDATE, DELETE on Tree to mgr_Orchard;
grant CREATE, SELECT, DELETE on Caliber to mgr_Orchard;
grant CREATE, SELECT, UPDATE, DELETE on Orchard to mgr_Orchard;
grant SELECT on Harvest to mgr_Orchard;
grant SELECT on Tree_Orc to mgr_Orchard;

grant SELECT on Orchard to mgr_Harvest;
grant CREATE, SELECT, UPDATE, DELETE on Harvest to mgr_Harvest;
grant SELECT on Tree_cal to mgr_Harvest;
grant SELECT on Tree_Orc to mgr_Harvest;

grant SELECT on Harvest to Client;

3 - Atribuição
grant adm to BDII_AD_1706995.pomar;
grant mgr_Orchard to BDII_AD_1706995.pomar;
grant mgr_Harvest to BDII_AD_1706995.pomar;
grant client to BDII_AD_1706995.pomar;

--#########################################################################################
--SYNONYM
Nome alternativo para um objeto da BD

CREATE SYNONYM arvore FOR tree;
select * from arvore;

CREATE SYNONYM calibre FOR caliber;
select * from calibre;

CREATE SYNONYM colheita FOR harvest;
select * from colheita;

CREATE SYNONYM pomar FOR orchard;
select * from pomar;

CREATE SYNONYM arvore_pomar FOR tree_orc;
select * from arvore_pomar;

--#########################################################################################
--Transação
Após fazer análise de anomalias na tabela ORCHARD, por conta da desnormalização por adição de coluna derivada 
percebi que para fazer algumas operações de escrita preciso de transações. São elas:
	INSERT na tabela TREE_ORC
	DELETE na tabela TREE_ORC
	UPDATE na tabela TREE_ORC

Estes casos necessitam de uma transação, pois tem mais de um comando de escrita e têm de ser executados 
de forma atómica.

--#########################################################################################
--Procedures (transações) com estrutura de controle de fluxo

-----------------INSERT TREE_ORC
set serveroutput on;
create or replace procedure insert_tree_orc (
    p_id_tree tree.id_tree%type,
	p_id_orchard orchard.id_orchard%type,
	P_tree_amount tree_orc.tree_amount%type)
is
    v_tot_tree orchard.tot_tree%type;
	v_count number (1);
begin
	select count (*)
    into v_count
    from tree_orc
    where orchard_id_orchard = p_id_orchard and tree_id_tree = p_id_tree;
	
	if v_count = 1 then
		dbms_output.put_line('Já existe um registro com esse conjunto de chaves');
	else
		INSERT INTO tree_orc (tree_id_tree, orchard_id_orchard, tree_amount)
		VALUES (p_id_tree, p_id_orchard, P_tree_amount);
		
		SELECT sum (tree_amount)
		INTO v_tot_tree
		FROM tree_orc
		WHERE orchard_id_orchard = p_id_orchard;
		
		update orchard
		set tot_tree = v_tot_tree        
		WHERE id_orchard = p_id_orchard;
    end if;
end;
/
--exec insert_tree_orc(id_orchard, id_tree, tree_amount);
exec insert_tree_orc('pb', 'pn', 350);
/

-------------UPDATE TREE_ORC
set serveroutput on;
create or replace procedure update_tree_orc (
    p_id_orchard orchard.id_orchard%type,
	p_id_tree tree.id_tree%type,
	P_tree_amount tree_orc.tree_amount%type)
is
    v_tot_tree orchard.tot_tree%type;
	v_count number (1);
begin
	select count (*)
    into v_count
    from tree_orc
    where orchard_id_orchard = p_id_orchard and tree_id_tree = p_id_tree;
	
	if v_count = 0 then
		dbms_output.put_line('Verifique os dados de id_orchard e id_tree');
	else
		update tree_orc
		set tree_amount = P_tree_amount        
		WHERE orchard_id_orchard = p_id_orchard and tree_id_tree = p_id_tree;
		
		SELECT sum (tree_amount)
		INTO v_tot_tree
		FROM tree_orc
		WHERE orchard_id_orchard = p_id_orchard;
		
		update orchard
		set tot_tree = v_tot_tree        
		WHERE id_orchard = p_id_orchard;
    end if;
end;
/
--exec update_tree_orc(id_orchard, id_tree, tree_amount);
exec update_tree_orc('pb', 'pw', 550);
/
-------------DELETE TREE_ORC
set serveroutput on;
create or replace procedure delete_tree_orc (
    p_id_orchard orchard.id_orchard%type,
	p_id_tree tree.id_tree%type)
is
    v_tot_tree orchard.tot_tree%type;
	v_count number (1);
begin
    select count (*)
    into v_count
    from tree_orc
    where orchard_id_orchard = p_id_orchard and tree_id_tree = p_id_tree;
	
	if v_count = 0 then
		dbms_output.put_line('Verifique os dados de id_orchard e id_tree');
	else
		delete from tree_orc
		where orchard_id_orchard = p_id_orchard and tree_id_tree = p_id_tree;
    
        select count (*)
        into v_count
        from tree_orc
        where orchard_id_orchard = p_id_orchard;
        
        if v_count = 0 then
            update orchard
            set tot_tree = 0        
            WHERE id_orchard = p_id_orchard;
        else    
            SELECT sum (tree_amount)
            INTO v_tot_tree
            FROM tree_orc
            WHERE orchard_id_orchard = p_id_orchard;
            
            update orchard
            set tot_tree = v_tot_tree        
            WHERE id_orchard = p_id_orchard; 
        end if;
    end if;
end;		
/
--exec delete_tree_orc(id_orchard, id_tree);
exec delete_tree_orc('pb', 'pw');
/
--procedure que mostra a soma da colheita (boa e ruím) por ano
set serveroutput on;
create or replace procedure sum_yaer(p_yaer number )
is
    v_k_good harvest.kilo_good%type;
    v_k_bad harvest.kilo_bad%type;
begin   
        select sum(kilo_good)
        into v_k_good
        from harvest
        where to_char(dateh,'yyyy') = p_yaer;
        
        select sum(kilo_bad)
        into v_k_bad
        from harvest
        where to_char(dateh,'yyyy') = p_yaer;
        
	dbms_output.put_line('No ano de '||p_yaer||' a soma de frutos bom foi: '||v_k_good||' a soma de fruto ruim foi: '||v_k_bad);
end;
/
exec sum_yaer (2022);
/
--Procedure que mostra o percentual dos da colheita por kilos bons e ruins.
create or replace procedure percentual_kilos (p_id number)
is
    v_perct_good number (9);
    v_perct_bad number (9);
begin
    select round((kilo_good * 100)/(select (kilo_good + kilo_bad) from harvest where id_harvest = p_id))
    into v_perct_good
    from harvest
    where id_harvest = p_id;
    
    select round((kilo_bad * 100)/(select (kilo_good + kilo_bad) from harvest where id_harvest = p_id))
    into v_perct_bad
    from harvest
    where id_harvest = p_id;
    
    dbms_output.put_line('Percentual de kilos bons: '||v_perct_good||'%');
    dbms_output.put_line('Percentual de kilos ruins: '||v_perct_bad||'%');
end;
/
exec percentual_kilos (11);
--#########################################################################################
--FUNCTIONS

--set serveroutput on;

--Função que devolve a média dos kilogramas dos frutos bons das colheitas por ano
create or replace function media(p_yaer number )
return number
is
    v_media harvest.kilo_good%type;
begin   
    select avg(kilo_good)
    into v_media
    from harvest
    where to_char(dateh,'yyyy') = p_yaer;
    return v_media;
end;

create or replace procedure media_ano (p_yaer number)
is
    v_media number (9);
begin
    v_media := media(p_yaer);
    dbms_output.put_line(v_media);
end;

--exec media_ano (2021);
/

--Função que devolve a quantidade de colheitas por ano
create or replace function cont(p_yaer number )
return number
is
    v_cont harvest.kilo_good%type;
begin   
    select count(kilo_good)
    into v_cont
    from harvest
    where to_char(dateh,'yyyy') = p_yaer;
    return v_cont;
end;

create or replace procedure quant_col_ano (p_yaer number)
is
    v_cont number (9);
begin
    v_cont := cont(p_yaer);
    dbms_output.put_line(v_cont);
end;
/
--exec quant_col_ano (2021);
--#########################################################################################
--SEQUENCE AND TRIGGER
--sequence que será utilizada para colocar o id na tabela harvest quando for inserido um novo registro.
CREATE sequence id_harvest_seq start with 1;
/
--Trigger que utiliza a sequnce para colocar o id na tabela harvest quando é inserido um novo registro.
CREATE OR REPLACE TRIGGER harvest_tr
before insert on harvest
for each row
begin  
    :NEW.ID_HARVEST := id_harvest_seq.nextval;
end;
/
--trigger que quando inserido um novo registro na tabela orchard coloca um zero na coluna tot_tree se esta estiver null
CREATE OR REPLACE TRIGGER orchard_tr
before insert on orchard
for each row
begin  
    if :NEW.tot_tree is null then
        :NEW.tot_tree := 0;
    end if;
end;
/
--#########################################################################################
--CURSORES
--cursor que mostra a chave e o tipo das árvores
set serveroutput on;
create or replace procedure key_and_typo_tree is
begin
	for v_rec_tree in (select id_tree,type_tree from tree) loop
	dbms_output.put_line(v_rec_tree.id_tree||' - '||v_rec_tree.type_tree);
	end loop;
end;
/
exec key_and_typo_tree;
/
--Cursor mostrando o nome dos pomares com o respectivo total de árvores
set serveroutput on;
create or replace procedure orchards_and_tot_trees
is
	CURSOR c_orchards is
		select oname, tot_tree
		from orchard;

	v_oname orchard.oname%type;
	v_tot orchard.tot_tree%type;
begin
	open c_orchards;
	loop
		fetch c_orchards into v_oname, v_tot;
		exit when c_orchards%NOTFOUND;
		dbms_output.put_line(v_oname||' - '||v_tot);
	end loop;	
	close c_orchards;
end;
/
exec orchards_and_tot_trees;
/
--#########################################################################################
--VIEWS
create or replace view vision_orchard as
select oname Nome_Pomar, type_tree Tipo_Fruto, tree_amount Quant_Árvore_Tipo, tot_tree Total_Árvore_Pomar
from orchard, tree_orc, tree
where orchard.id_orchard = tree_orc.orchard_id_orchard
and tree_orc.tree_id_tree = tree.id_tree
order by (oname);

--select * from vision_orchard;

create or replace view harvest_orchard as
select  oname as Nome_Pomar, to_char(dateh,'dd/mm/yyyy') as Data_Colheita ,kilo_good as Kilo_Frutos_boms, kilo_bad as Kilo_Frutos_Ruins
from harvest, orchard
where harvest.tree_orc_orchard_id_orchard = orchard.id_orchard
order by (dateh);

--select * from harvest_orchard;

--#########################################################################################
--Anexo com código de criação das tabelas
DROP TABLE caliber CASCADE CONSTRAINTS;

DROP TABLE harvest CASCADE CONSTRAINTS;

DROP TABLE orchard CASCADE CONSTRAINTS;

DROP TABLE tree CASCADE CONSTRAINTS;

DROP TABLE tree_cal CASCADE CONSTRAINTS;

DROP TABLE tree_orc CASCADE CONSTRAINTS;


CREATE TABLE caliber (
    id_caliber VARCHAR2(3) NOT NULL,
    cal        VARCHAR2(2) NOT NULL
);

ALTER TABLE CALIBER
    add (CONSTRAINT caliber_ck
        check(UPPER(cal) in ('AA', 'A', 'B', 'C')));

ALTER TABLE caliber ADD CONSTRAINT caliber_pk PRIMARY KEY ( id_caliber );

CREATE TABLE harvest (
    id_harvest                  NUMBER(5) NOT NULL,
    dateh                       DATE NOT NULL,
    kilo_good                   NUMBER(9, 2) NOT NULL,
    kilo_bad                    NUMBER(9, 2) NOT NULL,
    tree_orc_tree_id_tree       VARCHAR2(3) NOT NULL,
    tree_orc_orchard_id_orchard VARCHAR2(2) NOT NULL,
    tree_cal_caliber_id_caliber VARCHAR2(3) NOT NULL,
    tree_cal_tree_id_tree       VARCHAR2(3) NOT NULL
);

ALTER TABLE harvest
    ADD CONSTRAINT kilo_good_ck
        CHECK ( ( kilo_good > 0 ) );

ALTER TABLE harvest 
    ADD CONSTRAINT kilo_bad_ck
        CHECK ( ( kilo_bad > - 1 ) );

ALTER TABLE harvest ADD CONSTRAINT harvest_pk PRIMARY KEY ( id_harvest );

CREATE TABLE orchard (
    id_orchard VARCHAR2(2) NOT NULL,
    oname      VARCHAR2(20) NOT NULL,
    tot_tree   NUMBER(9),
    loc        VARCHAR2(30) NOT NULL
);

ALTER TABLE orchard ADD CONSTRAINT orchard_pk PRIMARY KEY ( id_orchard );

CREATE TABLE tree (
    id_tree   VARCHAR2(2) NOT NULL,
    type_tree VARCHAR2(15) NOT NULL
);

ALTER TABLE TREE
    add CONSTRAINT tree_ck
        check(LOWER (type_tree) IN ('white', 'yellow', 'nectarine'));

ALTER TABLE tree ADD CONSTRAINT tree_pk PRIMARY KEY ( id_tree );

CREATE TABLE tree_cal (
    caliber_id_caliber VARCHAR2(3) NOT NULL,
    tree_id_tree       VARCHAR2(2) NOT NULL
);

ALTER TABLE tree_cal ADD CONSTRAINT tree_cal_pk PRIMARY KEY ( caliber_id_caliber,
                                                              tree_id_tree );

CREATE TABLE tree_orc (
    tree_id_tree       VARCHAR2(2) NOT NULL,
    orchard_id_orchard VARCHAR2(2) NOT NULL,
    tree_amount        NUMBER(9) NOT NULL
);

ALTER TABLE tree_orc ADD CONSTRAINT tree_orc_pk PRIMARY KEY ( tree_id_tree,
                                                              orchard_id_orchard );

ALTER TABLE harvest
    ADD CONSTRAINT harvest_tree_cal_fk FOREIGN KEY ( tree_cal_caliber_id_caliber,
                                                     tree_cal_tree_id_tree )
        REFERENCES tree_cal ( caliber_id_caliber,
                              tree_id_tree );

ALTER TABLE harvest
    ADD CONSTRAINT harvest_tree_orc_fk FOREIGN KEY ( tree_orc_tree_id_tree,
                                                     tree_orc_orchard_id_orchard )
        REFERENCES tree_orc ( tree_id_tree,
                              orchard_id_orchard );

ALTER TABLE tree_cal
    ADD CONSTRAINT tree_cal_caliber_fk FOREIGN KEY ( caliber_id_caliber )
        REFERENCES caliber ( id_caliber );

ALTER TABLE tree_cal
    ADD CONSTRAINT tree_cal_tree_fk FOREIGN KEY ( tree_id_tree )
        REFERENCES tree ( id_tree );

ALTER TABLE tree_orc
    ADD CONSTRAINT tree_orc_orchard_fk FOREIGN KEY ( orchard_id_orchard )
        REFERENCES orchard ( id_orchard );

ALTER TABLE tree_orc
    ADD CONSTRAINT tree_orc_tree_fk FOREIGN KEY ( tree_id_tree )
        REFERENCES tree ( id_tree );

--##########################################################################################
--Anexo com código de inserção de dados nas tabelas

INSERT INTO tree (id_tree, type_tree) VALUES ('pw', 'white');
INSERT INTO tree (id_tree, type_tree) VALUES ('py', 'yellow');
INSERT INTO tree (id_tree, type_tree) VALUES ('pn', 'nectarine');

--###############################################################

INSERT INTO caliber (id_caliber, cal) VALUES ('caa', 'AA');
INSERT INTO caliber (id_caliber, cal) VALUES ('ca', 'A');
INSERT INTO caliber (id_caliber, cal) VALUES ('cb', 'B');
INSERT INTO caliber (id_caliber, cal) VALUES ('cc', 'C');
--#########################################################

INSERT INTO orchard (id_orchard, oname, tot_tree, loc)
VALUES ('pb', 'brejo', 850, 'quinta_do_brejo');
INSERT INTO orchard (id_orchard, oname, tot_tree, loc)
VALUES ('pc', 'capela', 1150, 'capela_sao_jose');
INSERT INTO orchard (id_orchard, oname, tot_tree, loc)
VALUES ('pz', 'ze', 800, 'quinta_do_ze');
INSERT INTO orchard (id_orchard, oname, tot_tree, loc)
VALUES ('pp', 'ponte', 1250, 'quinta_da_coruja');
INSERT INTO orchard (id_orchard, oname, tot_tree, loc)
VALUES ('pf', 'fagundes', 2050, 'quinta_do_joao_fagundes');

--###################################################################

INSERT INTO tree_orc (tree_id_tree, orchard_id_orchard, tree_amount)
VALUES ('pw', 'pb', 350);
INSERT INTO tree_orc (tree_id_tree, orchard_id_orchard, tree_amount)
VALUES ('py', 'pb', 0);
INSERT INTO tree_orc (tree_id_tree, orchard_id_orchard, tree_amount)
VALUES ('pn', 'pb', 500);

INSERT INTO tree_orc (tree_id_tree, orchard_id_orchard, tree_amount)
VALUES ('pw', 'pc', 250);
INSERT INTO tree_orc (tree_id_tree, orchard_id_orchard, tree_amount)
VALUES ('py', 'pc', 600);
INSERT INTO tree_orc (tree_id_tree, orchard_id_orchard, tree_amount)
VALUES ('pn', 'pc', 300);

INSERT INTO tree_orc (tree_id_tree, orchard_id_orchard, tree_amount)
VALUES ('pw', 'pz', 0);
INSERT INTO tree_orc (tree_id_tree, orchard_id_orchard, tree_amount)
VALUES ('py', 'pz', 0);
INSERT INTO tree_orc (tree_id_tree, orchard_id_orchard, tree_amount)
VALUES ('pn', 'pz', 800);

INSERT INTO tree_orc (tree_id_tree, orchard_id_orchard, tree_amount)
VALUES ('pw', 'pp', 350);
INSERT INTO tree_orc (tree_id_tree, orchard_id_orchard, tree_amount)
VALUES ('py', 'pp', 400);
INSERT INTO tree_orc (tree_id_tree, orchard_id_orchard, tree_amount)
VALUES ('pn', 'pp', 500);

INSERT INTO tree_orc (tree_id_tree, orchard_id_orchard, tree_amount)
VALUES ('pw', 'pf', 350);
INSERT INTO tree_orc (tree_id_tree, orchard_id_orchard, tree_amount)
VALUES ('py', 'pf', 1100);
INSERT INTO tree_orc (tree_id_tree, orchard_id_orchard, tree_amount)
VALUES ('pn', 'pf', 600);

--####################################################################

INSERT INTO tree_cal (tree_id_tree, caliber_id_caliber)
VALUES ('pw', 'caa');
INSERT INTO tree_cal (tree_id_tree, caliber_id_caliber)
VALUES ('pw', 'ca');
INSERT INTO tree_cal (tree_id_tree, caliber_id_caliber)
VALUES ('pw', 'cb');
INSERT INTO tree_cal (tree_id_tree, caliber_id_caliber)
VALUES ('pw', 'cc');

INSERT INTO tree_cal (tree_id_tree, caliber_id_caliber)
VALUES ('py', 'caa');
INSERT INTO tree_cal (tree_id_tree, caliber_id_caliber)
VALUES ('py', 'ca');
INSERT INTO tree_cal (tree_id_tree, caliber_id_caliber)
VALUES ('py', 'cb');
INSERT INTO tree_cal (tree_id_tree, caliber_id_caliber)
VALUES ('py', 'cc');

INSERT INTO tree_cal (tree_id_tree, caliber_id_caliber)
VALUES ('pn', 'caa');
INSERT INTO tree_cal (tree_id_tree, caliber_id_caliber)
VALUES ('pn', 'ca');
INSERT INTO tree_cal (tree_id_tree, caliber_id_caliber)
VALUES ('pn', 'cb');
INSERT INTO tree_cal (tree_id_tree, caliber_id_caliber)
VALUES ('pn', 'cc');

--###########################################################################################################################################

INSERT INTO harvest (id_harvest, dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES (001, '22/06/2020', 4500, 250, 'pw', 'pw', 'ca', 'pb');

INSERT INTO harvest (id_harvest, dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES (002, '23/06/2020', 5500, 350, 'pn', 'pn', 'cb', 'pp');

INSERT INTO harvest (id_harvest, dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES (003, '23/06/2020', 3500, 450, 'pn', 'pn', 'cc', 'pf');

INSERT INTO harvest (id_harvest, dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES (004, '24/06/2020', 4500, 250, 'py', 'py', 'caa', 'pf');

INSERT INTO harvest (id_harvest, dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES (005, '25/06/2020', 4700, 200, 'py', 'py', 'cb', 'pf');

INSERT INTO harvest (id_harvest, dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES (006, '26/06/2020', 1500, 250, 'pn', 'pn', 'cc', 'pz');

INSERT INTO harvest (id_harvest, dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES (007, '27/06/2020', 5500, 300, 'pn', 'pn', 'caa', 'pb');

INSERT INTO harvest (id_harvest, dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES (008, '27/06/2020', 3500, 500, 'pw', 'pw', 'cb', 'pp');

INSERT INTO harvest (id_harvest, dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES (009, '29/06/2020', 3000, 400, 'pn', 'pn', 'cc', 'pz');

INSERT INTO harvest (id_harvest, dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES (010, '30/06/2020', 4800, 300, 'py', 'py', 'caa', 'pc');

------------
INSERT INTO harvest (id_harvest, dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES (011, '22/06/2021', 5500, 450, 'pw', 'pw', 'ca', 'pb');

INSERT INTO harvest (id_harvest, dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES (012, '23/06/2021', 3500, 350, 'pn', 'pn', 'cb', 'pp');

INSERT INTO harvest (id_harvest, dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES (013, '23/06/2021', 7500, 400, 'pn', 'pn', 'cc', 'pf');

INSERT INTO harvest (id_harvest, dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES (014, '24/06/2021', 4500, 250, 'py', 'py', 'caa', 'pf');

INSERT INTO harvest (id_harvest, dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES (015, '25/06/2021', 4700, 250, 'py', 'py', 'cb', 'pf');

INSERT INTO harvest (id_harvest, dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES (016, '26/06/2021', 2500, 300, 'pn', 'pn', 'cc', 'pz');

INSERT INTO harvest (id_harvest, dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES (017, '27/06/2021', 6500, 400, 'pn', 'pn', 'caa', 'pb');

INSERT INTO harvest (id_harvest, dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES (018, '27/06/2021', 5500, 300, 'pw', 'pw', 'cb', 'pp');

INSERT INTO harvest (id_harvest, dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES (019, '29/06/2021', 4000, 400, 'pn', 'pn', 'cc', 'pz');

INSERT INTO harvest (id_harvest, dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES (020, '30/06/2021', 6800, 500, 'py', 'py', 'caa', 'pc');

---------------
INSERT INTO harvest (id_harvest, dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES (021, '22/06/2022', 5500, 550, 'pw', 'pw', 'ca', 'pb');

INSERT INTO harvest (id_harvest, dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES (022, '23/06/2022', 2500, 350, 'pn', 'pn', 'cb', 'pp');

INSERT INTO harvest (id_harvest, dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES (023, '23/06/2022', 7500, 500, 'pn', 'pn', 'cc', 'pf');

INSERT INTO harvest (id_harvest, dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES (024, '24/06/2022', 4000, 350, 'py', 'py', 'caa', 'pf');

INSERT INTO harvest (id_harvest, dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES (025, '25/06/2022', 4900, 150, 'py', 'py', 'cb', 'pf');

INSERT INTO harvest (id_harvest, dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES (026, '26/06/2022', 3500, 350, 'pn', 'pn', 'cc', 'pz');

INSERT INTO harvest (id_harvest, dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES (027, '27/06/2022', 4500, 200, 'pn', 'pn', 'caa', 'pb');

INSERT INTO harvest (id_harvest, dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES (028, '27/06/2022', 5500, 400, 'pw', 'pw', 'cb', 'pp');

INSERT INTO harvest (id_harvest, dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES (029, '29/06/2022', 4500, 300, 'pn', 'pn', 'cc', 'pz');

INSERT INTO harvest (id_harvest, dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES (030, '30/06/2022', 6700, 400, 'py', 'py', 'caa', 'pc');