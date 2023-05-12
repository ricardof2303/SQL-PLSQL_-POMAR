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