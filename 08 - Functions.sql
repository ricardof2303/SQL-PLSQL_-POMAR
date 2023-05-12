FUNCTIONS

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