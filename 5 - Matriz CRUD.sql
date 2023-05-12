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