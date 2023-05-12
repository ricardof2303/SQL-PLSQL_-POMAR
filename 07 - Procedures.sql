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