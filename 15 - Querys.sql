--Selecione todas as colheitas (harvests) realizadas no dia 23 de junho de 2020.
SELECT * FROM harvest WHERE dateh = '23/06/2020';

--Selecione todas as árvores (trees) do tipo "white".
SELECT * FROM tree WHERE type_tree = 'white';

--Selecione o nome (oname) e a localização (loc) de todos os pomares (orchards) em ordem alfabética.
SELECT oname, loc FROM orchard ORDER BY oname;

--Selecione a contagem total de árvores (tot_tree) para cada pomar (orchard).
SELECT id_orchard, SUM(tot_tree) AS total_trees FROM orchard GROUP BY id_orchard;

--Selecione a quantidade total de árvores (tree_amount) para cada combinação de árvore (tree) e pomar (orchard).
SELECT tree_id_tree, orchard_id_orchard, SUM(tree_amount) AS total_amount
FROM tree_orc
GROUP BY tree_id_tree, orchard_id_orchard;

--Selecione a colheita (harvest) com a maior quantidade de quilos bons (kilo_good).
SELECT * FROM harvest ORDER BY kilo_good DESC FETCH FIRST 1 ROW ONLY;

--Selecione a quantidade média de quilos ruins (kilo_bad) por colheita (harvest).
SELECT AVG(kilo_bad) AS average_bad FROM harvest;

--Selecione a quantidade total de árvores (tot_tree) para todos os pomares (orchards) que possuem mais de 500 árvores.
SELECT id_orchard, tot_tree
FROM orchard
WHERE tot_tree > 500;

--Selecione a quantidade total de árvores (tree_amount) para cada pomar (orchard) em que o tipo de árvore (type_tree) seja "yellow".
SELECT tree_orc_orchard_id_orchard, SUM(tree_amount) AS total_amount
FROM tree_orc
JOIN tree ON tree.id_tree = tree_orc.tree_id_tree
WHERE tree.type_tree = 'yellow'
GROUP BY tree_orc_orchard_id_orchard;

--Selecione a quantidade de árvores (tree_amount) para cada combinação de árvore (tree) e pomar (orchard) em que a quantidade seja maior que 500.
SELECT tree_id_tree, orchard_id_orchard, tree_amount
FROM tree_orc
WHERE tree_amount > 500;

--Selecione todas as colheitas (harvests) realizadas em 2020:
SELECT *
FROM harvest
WHERE EXTRACT(YEAR FROM dateh) = 2020;

--Selecione o nome (oname) e a localização (loc) de todos os pomares (orchards) em ordem alfabética pelo nome:
SELECT oname, loc
FROM orchard
ORDER BY oname;

--Selecione a quantidade total de árvores (tot_tree) em cada pomar (orchard):
SELECT id_orchard, tot_tree
FROM orchard;

--Selecione a quantidade total de colheitas (harvests) realizadas em cada pomar (orchard):
SELECT tree_orc_orchard_id_orchard, COUNT(*) AS total_harvests
FROM harvest
GROUP BY tree_orc_orchard_id_orchard;

--Selecione o tipo de árvore (type_tree) e o calibre (cal) de todas as árvores e calibres disponíveis:
SELECT t.type_tree, c.cal
FROM tree t, caliber c;

--Selecione a data (dateh) e a quantidade total de colheitas boas (kilo_good) realizadas em cada data:
SELECT dateh, SUM(kilo_good) AS total_kilo_good
FROM harvest
GROUP BY dateh;

--Selecione o calibre (cal) e a quantidade total de colheitas ruins (kilo_bad) para cada calibre:
SELECT c.cal, SUM(h.kilo_bad) AS total_kilo_bad
FROM harvest h
JOIN tree_cal tc ON h.tree_cal_tree_id_tree = tc.tree_id_tree
    AND h.tree_cal_caliber_id_caliber = tc.caliber_id_caliber
JOIN caliber c ON tc.caliber_id_caliber = c.id_caliber
GROUP BY c.cal;

--Selecione o tipo de árvore (type_tree) e a quantidade total de colheitas (harvests) realizadas para cada tipo:
SELECT t.type_tree, COUNT(*) AS total_harvests
FROM harvest h
JOIN tree_cal tc ON h.tree_cal_tree_id_tree = tc.tree_id_tree
JOIN tree t ON tc.tree_id_tree = t.id_tree
GROUP BY t.type_tree;

--Selecione o nome (oname) e a quantidade total de árvores (tot_tree) para os pomares (orchards) que possuem mais de 500 árvores:
SELECT oname, tot_tree
FROM orchard
WHERE tot_tree > 500;

--Selecione o tipo de árvore (type_tree) e a quantidade total de colheitas (harvests) boas e ruins realizadas para cada tipo de árvore:
SELECT t.type_tree, SUM(h.kilo_good) AS total_kilo_good, SUM(h.kilo_bad) AS total_kilo_bad
FROM harvest h
JOIN tree_cal tc ON h.tree_cal_tree_id_tree = tc.tree_id_tree
JOIN tree t ON tc.tree_id_tree = t.id_tree
GROUP BY t.type_tree;
