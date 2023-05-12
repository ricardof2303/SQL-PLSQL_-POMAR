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
