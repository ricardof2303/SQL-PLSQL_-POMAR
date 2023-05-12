--Criação das tabelas

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