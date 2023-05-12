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