--EXTRA


-------------DELETE TREE_ORC
select * from tree_orc;
set serveroutput on;
create or replace procedure delete_tree_orc (
    p_id_orchard orchard.id_orchard%type,
	p_id_tree tree.id_tree%type)
is
    v_tot_tree orchard.tot_tree%type;
	v_count number (9);
begin
    select count (*)
    into v_count
    from tree_orc
    where orchard_id_orchard = p_id_orchard and tree_id_tree = p_id_tree;
	
	if v_count = 0 then
		dbms_output.put_line('Verifique os dados de id_orchard e id_tree');
	else
		select count (*)
        into v_count
        from harvest
        where tree_orc_orchard_id_orchard = p_id_orchard;
        
        if v_count = 0 then        
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
        else
            dbms_output.put_line('Primeiro é preciso excluir na harvest os registros relacionado a esse pomar: '||p_id_orchard);
        end if;
    end if;
end;		
/

select count (*)
from harvest
where tree_orc_orchard_id_orchard = 'pb' and tree_orc_tree_id_tree = 'pw';
    
--exec delete_tree_orc(id_orchard, id_tree);
exec delete_tree_orc('pb', 'pw');
select * from tree_orc;
select * from orchard;
select * from harvest;

-------------DELETE TREE_ORC
select * from tree_orc;
set serveroutput on;
create or replace procedure delete_tree_orc (
    p_id_orchard orchard.id_orchard%type,
	p_id_tree tree.id_tree%type)
is
    v_tot_tree orchard.tot_tree%type;
	v_count number (9);
begin
	select count (*)
    into v_count
    from harvest
    where tree_orc_orchard_id_orchard = p_id_orchard and tree_orc_tree_id_tree = p_id_tree;
        
    if v_count != 0 then
        delete from harvest
        where tree_orc_orchard_id_orchard = p_id_orchard and tree_orc_tree_id_tree = p_id_tree;
    end if;
    
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


select count (*)
from harvest
where tree_orc_orchard_id_orchard = 'pb' and tree_orc_tree_id_tree = 'pw';
    
--exec delete_tree_orc(id_orchard, id_tree);
exec delete_tree_orc('pb', 'pw');
select * from tree_orc;
select * from orchard;
select * from harvest;
