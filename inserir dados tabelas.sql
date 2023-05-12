--inserção de dados nas tabelas

INSERT INTO tree (id_tree, type_tree) VALUES ('pw', 'white');
INSERT INTO tree (id_tree, type_tree) VALUES ('py', 'yellow');
INSERT INTO tree (id_tree, type_tree) VALUES ('pn', 'nectarine');

--###############################################################

INSERT INTO caliber (id_caliber, cal) VALUES ('caa', 'AA');
INSERT INTO caliber (id_caliber, cal) VALUES ('ca', 'A');
INSERT INTO caliber (id_caliber, cal) VALUES ('cb', 'B');
INSERT INTO caliber (id_caliber, cal) VALUES ('cc', 'C');
--#########################################################

INSERT INTO orchard (id_orchard, oname, loc)
VALUES ('pb', 'brejo', 'quinta_do_brejo');
INSERT INTO orchard (id_orchard, oname, loc)
VALUES ('pc', 'capela', 'capela_sao_jose');
INSERT INTO orchard (id_orchard, oname, loc)
VALUES ('pz', 'ze', 'quinta_do_ze');
INSERT INTO orchard (id_orchard, oname, loc)
VALUES ('pp', 'ponte', 'quinta_da_coruja');
INSERT INTO orchard (id_orchard, oname, loc)
VALUES ('pf', 'fagundes', 'quinta_do_joao_fagundes');
INSERT INTO orchard (id_orchard, oname, loc)
VALUES ('px', 'xpto', 'quinta_do_jorge');


--select * from orchard;

--###################################################################

exec insert_tree_orc('pw', 'pb', 350);
exec insert_tree_orc('py', 'pb', 0);
exec insert_tree_orc('pn', 'pb', 500);
exec insert_tree_orc('pw', 'pc', 250);
exec insert_tree_orc('py', 'pc', 600);
exec insert_tree_orc('pn', 'pc', 300);
exec insert_tree_orc('pw', 'pz', 0);
exec insert_tree_orc('py', 'pz', 0);
exec insert_tree_orc('pn', 'pz', 800);
exec insert_tree_orc('pw', 'pp', 350);
exec insert_tree_orc('py', 'pp', 400);
exec insert_tree_orc('pn', 'pp', 500);
exec insert_tree_orc('pw', 'pf', 350);
exec insert_tree_orc('py', 'pf', 1100);
exec insert_tree_orc('pn', 'pf', 600);
exec insert_tree_orc('pn', 'px', 400);
exec insert_tree_orc('pw', 'px', 600);


--select * from tree_orc;
--select * from orchard;

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

--########################################################################################################

INSERT INTO harvest (dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES ('22/06/2020', 4500, 250, 'pw', 'pw', 'ca', 'pb');

INSERT INTO harvest (dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES ('23/06/2020', 5500, 350, 'pn', 'pn', 'cb', 'pp');

INSERT INTO harvest (dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES ('23/06/2020', 3500, 450, 'pn', 'pn', 'cc', 'pf');

INSERT INTO harvest (dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES ('24/06/2020', 4500, 250, 'py', 'py', 'caa', 'pf');

INSERT INTO harvest (dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES ('25/06/2020', 4700, 200, 'py', 'py', 'cb', 'pf');

INSERT INTO harvest (dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES ('26/06/2020', 1500, 250, 'pn', 'pn', 'cc', 'pz');

INSERT INTO harvest (dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES ('27/06/2020', 5500, 300, 'pn', 'pn', 'caa', 'pb');

INSERT INTO harvest (dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES ('27/06/2020', 3500, 500, 'pw', 'pw', 'cb', 'pp');

INSERT INTO harvest (dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES ('29/06/2020', 3000, 400, 'pn', 'pn', 'cc', 'pz');

INSERT INTO harvest (dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES ('30/06/2020', 4800, 300, 'py', 'py', 'caa', 'pc');

INSERT INTO harvest (dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES ('22/06/2021', 5500, 450, 'pw', 'pw', 'ca', 'pb');

INSERT INTO harvest (dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES ('23/06/2021', 3500, 350, 'pn', 'pn', 'cb', 'pp');

INSERT INTO harvest (dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES ('23/06/2021', 7500, 400, 'pn', 'pn', 'cc', 'pf');

INSERT INTO harvest (dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES ('24/06/2021', 4500, 250, 'py', 'py', 'caa', 'pf');

INSERT INTO harvest (dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES ('25/06/2021', 4700, 250, 'py', 'py', 'cb', 'pf');

INSERT INTO harvest (dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES ('26/06/2021', 2500, 300, 'pn', 'pn', 'cc', 'pz');

INSERT INTO harvest (dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES ('27/06/2021', 6500, 400, 'pn', 'pn', 'caa', 'pb');

INSERT INTO harvest (dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES ('27/06/2021', 5500, 300, 'pw', 'pw', 'cb', 'pp');

INSERT INTO harvest (dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES ('29/06/2021', 4000, 400, 'pn', 'pn', 'cc', 'pz');

INSERT INTO harvest (dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES ('30/06/2021', 6800, 500, 'py', 'py', 'caa', 'pc');

INSERT INTO harvest (dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES ('22/06/2022', 5500, 550, 'pw', 'pw', 'ca', 'pb');

INSERT INTO harvest (dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES ('23/06/2022', 2500, 350, 'pn', 'pn', 'cb', 'pp');

INSERT INTO harvest (dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES ('23/06/2022', 7500, 500, 'pn', 'pn', 'cc', 'pf');

INSERT INTO harvest (dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES ('24/06/2022', 4000, 350, 'py', 'py', 'caa', 'pf');

INSERT INTO harvest (dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES ('25/06/2022', 4900, 150, 'py', 'py', 'cb', 'pf');

INSERT INTO harvest (dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES ('26/06/2022', 3500, 350, 'pn', 'pn', 'cc', 'pz');

INSERT INTO harvest (dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES ('27/06/2022', 4500, 200, 'pn', 'pn', 'caa', 'pb');

INSERT INTO harvest (dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES ('27/06/2022', 5500, 400, 'pw', 'pw', 'cb', 'pp');

INSERT INTO harvest (dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES ('29/06/2022', 4500, 300, 'pn', 'pn', 'cc', 'pz');

INSERT INTO harvest (dateh, kilo_good, kilo_bad, tree_orc_tree_id_tree, tree_cal_tree_id_tree, 
                        tree_cal_caliber_id_caliber, tree_orc_orchard_id_orchard)
VALUES ('30/06/2022', 6700, 400, 'py', 'py', 'caa', 'pc');

--select * from harvest;