--
-- PostgreSQL database dump
--

-- Dumped from database version 13.3 (Debian 13.3-1.pgdg100+1)
-- Dumped by pg_dump version 13.3 (Debian 13.3-1.pgdg100+1)

-- Started on 2021-06-08 22:19:39 UTC

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 6 (class 2615 OID 16385)
-- Name: pacto; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA pacto;


ALTER SCHEMA pacto OWNER TO postgres;

--
-- TOC entry 227 (class 1255 OID 16386)
-- Name: casos_insert(); Type: FUNCTION; Schema: pacto; Owner: postgres
--

CREATE FUNCTION pacto.casos_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    begin
      
      delete 
      from pacto.municipioindices 
      where idmunicipioindice in 
        (select idmunicipioindice 
          from pacto.municipioindices ri
          inner join pacto.indice i on i.descricaoindice = 'Índice de notificações por síndrome gripal'
          where ri.idmunicipio = new.idmunicipio  
          and ri.idindice = i.idinide 
          and ri.datacalculo = new.datacasos);
      
      INSERT INTO pacto.municipioindices 
      (idmunicipio, datacalculo, idindice, valorabsolutoindice, leitosuti, leitosclinico, valocalculoincide, pesoindice)
      select m.idmunicipio, 
             new.datacasos, 
             i.idinide, 
             coalesce(im.indice,0), 
             m.leitosuti, 
             m.leitosclinico, 
             coalesce(im.indice,0) valocalculoincide, 
             i.pesoindice 
      from pacto.municipio m,
      pacto.indice i,
      pacto.notificaomunicipio(new.datacasos) im
      where m.idmunicipio = new.idmunicipio and 
      im.nomemunicipio = m.nomemunicipio and
      i.descricaoindice = 'Índice de notificações por síndrome gripal';
    
      delete 
      from pacto.regionalindices 
      where idregionalindice in 
        (select idregionalindice 
          from pacto.regionalindices ri
          inner join pacto.indice i on i.descricaoindice = 'Índice de notificações por síndrome gripal' 
          inner join pacto.municipio m on m.idmunicipio = new.idmunicipio
          where ri.idregional = m.idregional 
          and ri.idindice = i.idinide 
          and ri.datacalculo = new.datacasos);
      
      INSERT INTO pacto.regionalindices
      (idregional, datacalculo, idindice, valorabsolutoindice, leitosuti, leitosclinico, valocalculoincide, pesoindice)
      select r.idregional, 
             new.datacasos, 
             i.idinide, 
             coalesce(im.indice,0), 
             r.leitosuti, 
             r.leitosclinico, 
             coalesce(im.indice,0) valocalculoincide, 
             i.pesoindice 
      from pacto.regional r,
      pacto.notificaoregional(new.datacasos) im,
      pacto.indice i, 
      pacto.municipio m
      where r.idregional = m.idregional
      and i.descricaoindice = 'Índice de notificações por síndrome gripal' 
      and im.nomeregional =  r.nomeregional 
      and m.idmunicipio = new.idmunicipio;
      
      delete 
      from pacto.municipioindices 
      where idmunicipioindice in 
        (select idmunicipioindice 
          from pacto.municipioindices ri
          inner join pacto.indice i on i.descricaoindice = 'Índice de novos casos por síndrome gripal COVID 19'
          where ri.idmunicipio = new.idmunicipio  
          and ri.idindice = i.idinide 
          and ri.datacalculo = new.datacasos);
            
    
      INSERT INTO pacto.municipioindices 
      (idmunicipio, datacalculo, idindice, valorabsolutoindice, leitosuti, leitosclinico, valocalculoincide, pesoindice)
      select m.idmunicipio, 
             new.datacasos, 
             i.idinide, 
             coalesce(im.indice,0), 
             m.leitosuti, 
             m.leitosclinico, 
             coalesce(im.indice,0) valocalculoincide, 
             i.pesoindice 
      from pacto.municipio m,
      pacto.indice i,
      pacto.confirmadomunicipio(new.datacasos) im
      where m.idmunicipio = new.idmunicipio and 
      im.nomemunicipio = m.nomemunicipio and
      i.descricaoindice = 'Índice de novos casos por síndrome gripal COVID 19';
    
      delete 
      from pacto.regionalindices 
      where idregionalindice in 
        (select idregionalindice 
          from pacto.regionalindices ri
          inner join pacto.indice i on i.descricaoindice = 'Índice de novos casos por síndrome gripal COVID 19' 
          inner join pacto.municipio m on m.idmunicipio = new.idmunicipio
          where ri.idregional = m.idregional 
          and ri.idindice = i.idinide 
          and ri.datacalculo = new.datacasos);
      
      INSERT INTO pacto.regionalindices
      (idregional, datacalculo, idindice, valorabsolutoindice, leitosuti, leitosclinico, valocalculoincide, pesoindice)
      select r.idregional, 
             new.datacasos, 
             i.idinide, 
             coalesce(im.indice,0), 
             r.leitosuti, 
             r.leitosclinico, 
             coalesce(im.indice,0) valocalculoincide, 
             i.pesoindice 
      from pacto.regional r,
      pacto.confirmadoregional(new.datacasos) im,
      pacto.indice i, 
      pacto.municipio m
      where r.idregional = m.idregional
      and i.descricaoindice = 'Índice de novos casos por síndrome gripal COVID 19' 
      and im.nomeregional =  r.nomeregional 
      and m.idmunicipio = new.idmunicipio;
      
      RETURN NEW;
    END;
$$;


ALTER FUNCTION pacto.casos_insert() OWNER TO postgres;

--
-- TOC entry 228 (class 1255 OID 16387)
-- Name: clinicosmunicipio(date); Type: FUNCTION; Schema: pacto; Owner: postgres
--

CREATE FUNCTION pacto.clinicosmunicipio(dataref date) RETURNS TABLE(nomemunicipio character varying, indice numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN QUERY EXECUTE '
    SELECT DISTINCT m.nomemunicipio,
    d7.total::numeric AS indice
   from pacto.municipio m inner join
(select i.idmunicipio, 
        avg(i.leitosclinicos)::numeric total
from pacto.internacoes i 
where datainternacoes between (CAST('''||dataRef||''' as date) - interval ''6 days'') and CAST('''||dataRef||''' as date)
AND i.leitosclinicos > 0
group by i.idmunicipio) d7 on d7.idmunicipio = m.idmunicipio
';
END;
$$;


ALTER FUNCTION pacto.clinicosmunicipio(dataref date) OWNER TO postgres;

--
-- TOC entry 229 (class 1255 OID 16388)
-- Name: clinicosregional(date); Type: FUNCTION; Schema: pacto; Owner: postgres
--

CREATE FUNCTION pacto.clinicosregional(dataref date) RETURNS TABLE(nomeregional character varying, indice numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN QUERY EXECUTE '
    SELECT DISTINCT r.nomeregional,
    d7.total::numeric AS indice
   from pacto.regional r left join
(select m.idregional, 
        avg(i.leitosclinicos)::numeric total
from pacto.internacoes i inner join 
pacto.municipio m on i.idmunicipio = m.idmunicipio 
where datainternacoes between (CAST('''||dataRef||''' as date) - interval ''6 days'') and CAST('''||dataRef||''' as date) and 
i.leitosclinicos > 0 
group by m.idregional) d7 on d7.idregional = r.idregional
';
END;
$$;


ALTER FUNCTION pacto.clinicosregional(dataref date) OWNER TO postgres;

--
-- TOC entry 230 (class 1255 OID 16389)
-- Name: clinicosregional14(date); Type: FUNCTION; Schema: pacto; Owner: postgres
--

CREATE FUNCTION pacto.clinicosregional14(dataref date) RETURNS TABLE(nomeregional character varying, indice numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN QUERY EXECUTE '
    SELECT DISTINCT r.nomeregional,
    d7.total::numeric AS indice
   from pacto.regional r left join
(select m.idregional, 
        avg(i.leitosclinicos)::numeric total
from pacto.internacoes i inner join 
pacto.municipio m on i.idmunicipio = m.idmunicipio 
where datainternacoes between (CAST('''||dataRef||''' as date) - interval ''13 days'') and CAST('''||dataRef||''' as date) and 
i.leitosclinicos > 0 
group by m.idregional) d7 on d7.idregional = r.idregional
';
END;
$$;


ALTER FUNCTION pacto.clinicosregional14(dataref date) OWNER TO postgres;

--
-- TOC entry 231 (class 1255 OID 16390)
-- Name: confirmadomunicipio(date); Type: FUNCTION; Schema: pacto; Owner: postgres
--

CREATE FUNCTION pacto.confirmadomunicipio(dataref date) RETURNS TABLE(nomemunicipio character varying, d14 integer, d7 integer, med14 numeric, med7 numeric, indice numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN QUERY EXECUTE '
    SELECT DISTINCT m.nomemunicipio,
    d14.total::int AS d14,
    d7.total::int AS d7,
    d14.total / 7::numeric AS med14,
    d7.total / 7::numeric AS med7,
    case 
    when d14.total > 0 THEN
      d7.total / 7::numeric / (d14.total / 7::numeric)
    else 
       d7.total / 7::numeric
     end indice
   from pacto.municipio m LEFT join
(select c.idmunicipio, 
        sum(c.confirmacoes)::numeric total
from pacto.casos c 
where datacasos between (CAST('''||dataRef||''' as date) - interval ''13 days'') and (CAST('''||dataRef||''' as date) - interval ''7 days'')
group by c.idmunicipio) d14 on d14.idmunicipio = m.idmunicipio inner join
(select c.idmunicipio, 
        sum(c.confirmacoes)::numeric total
from pacto.casos c 
where datacasos between  (CAST('''||dataRef||''' as date) - interval ''6 days'') and CAST('''||dataRef||''' as date)
group by c.idmunicipio) d7 on d7.idmunicipio = m.idmunicipio';
END;
$$;


ALTER FUNCTION pacto.confirmadomunicipio(dataref date) OWNER TO postgres;

--
-- TOC entry 243 (class 1255 OID 16391)
-- Name: confirmadoregional(date); Type: FUNCTION; Schema: pacto; Owner: postgres
--

CREATE FUNCTION pacto.confirmadoregional(dataref date) RETURNS TABLE(nomeregional character varying, d14 integer, d7 integer, med14 numeric, med7 numeric, indice numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN QUERY EXECUTE '
    SELECT DISTINCT r.nomeregional,
    d14.total::int AS d14,
    d7.total::int AS d7,
    d14.total / 7::numeric AS med14,
    d7.total / 7::numeric AS med7,
    case 
    when d14.total > 0 THEN
      d7.total / 7::numeric / (d14.total / 7::numeric)
    else 
       d7.total / 7::numeric
     end indice
   from pacto.regional r LEFT join
(select m.idregional, 
        sum(c.confirmacoes)::numeric total
from pacto.casos c inner join 
pacto.municipio m on m.idmunicipio = c.idmunicipio 
where datacasos between (CAST('''||dataRef||''' as date) - interval ''13 days'') and (CAST('''||dataRef||''' as date) - interval ''7 days'')
group by m.idregional) d14 on d14.idregional = r.idregional inner join
(select m.idregional, 
        sum(c.confirmacoes)::numeric total
from pacto.casos c inner join 
pacto.municipio m on m.idmunicipio = c.idmunicipio 
where datacasos between  (CAST('''||dataRef||''' as date) - interval ''6 days'') and CAST('''||dataRef||''' as date)
group by m.idregional) d7 on d7.idregional = r.idregional 
';
END;
$$;


ALTER FUNCTION pacto.confirmadoregional(dataref date) OWNER TO postgres;

--
-- TOC entry 244 (class 1255 OID 16392)
-- Name: confirmadoregional14(date); Type: FUNCTION; Schema: pacto; Owner: postgres
--

CREATE FUNCTION pacto.confirmadoregional14(dataref date) RETURNS TABLE(nomeregional character varying, d14 integer, d7 integer, med14 numeric, med7 numeric, indice numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN QUERY EXECUTE '
    SELECT DISTINCT r.nomeregional,
    d14.total::int AS d14,
    d7.total::int AS d7,
    d14.total / 7::numeric AS med14,
    d7.total / 7::numeric AS med7,
    case 
    when d14.total > 0 THEN
      d7.total / 7::numeric / (d14.total / 7::numeric)
    else 
       d7.total / 7::numeric
     end indice
   from pacto.regional r LEFT join
(select m.idregional, 
        sum(c.confirmacoes)::numeric total
from pacto.casos c inner join 
pacto.municipio m on m.idmunicipio = c.idmunicipio 
where datacasos between (CAST('''||dataRef||''' as date) - interval ''27 days'') and (CAST('''||dataRef||''' as date) - interval ''14 days'')
group by m.idregional) d14 on d14.idregional = r.idregional inner join
(select m.idregional, 
        sum(c.confirmacoes)::numeric total
from pacto.casos c inner join 
pacto.municipio m on m.idmunicipio = c.idmunicipio 
where datacasos between  (CAST('''||dataRef||''' as date) - interval ''13 days'') and CAST('''||dataRef||''' as date)
group by m.idregional) d7 on d7.idregional = r.idregional 
';
END;
$$;


ALTER FUNCTION pacto.confirmadoregional14(dataref date) OWNER TO postgres;

--
-- TOC entry 245 (class 1255 OID 16393)
-- Name: extratocalculo(date); Type: FUNCTION; Schema: pacto; Owner: postgres
--

CREATE FUNCTION pacto.extratocalculo(dataref date) RETURNS TABLE(nomeregional character varying, descricaoindice character varying, mediaultimo7 numeric, media7anterior character varying, valorabsolutoindice numeric, valocalculoincide numeric, pesoindice numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN QUERY EXECUTE '
  select r2.nomeregional,
       i.descricaoindice, 
       o.med7::numeric(8,4) mediaultimo7,
       cast(o.med14::numeric(8,4) as varchar) media7Anterior ,
       r.valorabsolutoindice, 
       r.valocalculoincide,
       r.pesoindice
from pacto.indice i 
inner join pacto.regionalindices r 
  on r.idindice = i.idinide and r.datacalculo = CAST('''||dataRef||''' as date)
inner join pacto.regional r2 
  on r2.idregional = r.idregional 
inner join pacto.obitosregional(CAST('''||dataRef||''' as date)) o 
  on o.nomeregional = r2.nomeregional 
where i.idinide = 1 
and datacalculo = CAST('''||dataRef||''' as date)
union 
select r2.nomeregional,
       i.descricaoindice, 
       o.indice::numeric(8,4) mediaultimo7,
       ''Não se aplica'' media7Anterior,
       r.valorabsolutoindice, 
       r.valocalculoincide,
       r.pesoindice
from pacto.indice i 
inner join pacto.regionalindices r 
  on r.idindice = i.idinide and r.datacalculo = CAST('''||dataRef||''' as date)
inner join pacto.regional r2 
  on r2.idregional = r.idregional 
inner join pacto.utiregional(CAST('''||dataRef||''' as date)) o 
  on o.nomeregional = r2.nomeregional 
where i.idinide = 2 
and datacalculo = CAST('''||dataRef||''' as date)
union 
select r2.nomeregional,
       i.descricaoindice, 
       o.indice::numeric(8,4) mediaultimo7,
       ''Não se aplica'' media7Anterior ,
       r.valorabsolutoindice, 
       r.valocalculoincide,
       r.pesoindice
from pacto.indice i 
inner join pacto.regionalindices r 
  on r.idindice = i.idinide and r.datacalculo = CAST('''||dataRef||''' as date)
inner join pacto.regional r2 
  on r2.idregional = r.idregional 
inner join pacto.isolamentoregional(CAST('''||dataRef||''' as date)) o 
  on o.nomeregional = r2.nomeregional 
where i.idinide = 3 
and datacalculo = CAST('''||dataRef||''' as date)
union 
select r2.nomeregional,
       i.descricaoindice, 
       o.med7::numeric(8,4) mediaultimo7,
       cast(o.med14::numeric(8,4) as varchar) media7Anterior,
       r.valorabsolutoindice, 
       r.valocalculoincide,
       r.pesoindice
from pacto.indice i 
inner join pacto.regionalindices r 
  on r.idindice = i.idinide and r.datacalculo = CAST('''||dataRef||''' as date)
inner join pacto.regional r2 
  on r2.idregional = r.idregional 
inner join pacto.notificaoregional(CAST('''||dataRef||''' as date)) o 
  on o.nomeregional = r2.nomeregional 
where i.idinide = 4 
and datacalculo = CAST('''||dataRef||''' as date)
union 
select r2.nomeregional,
       i.descricaoindice, 
       o.med7::numeric(8,4) mediaultimo7,
       cast(o.med14::numeric(8,4) as varchar) media7Anterior,
       r.valorabsolutoindice, 
       r.valocalculoincide,
       r.pesoindice
from pacto.indice i 
inner join pacto.regionalindices r 
  on r.idindice = i.idinide and r.datacalculo = CAST('''||dataRef||''' as date)
inner join pacto.regional r2 
  on r2.idregional = r.idregional 
inner join pacto.confirmadoregional(CAST('''||dataRef||''' as date)) o 
  on o.nomeregional = r2.nomeregional 
where i.idinide = 5 
and datacalculo = CAST('''||dataRef||''' as date)
union 
select r2.nomeregional,
       i.descricaoindice, 
       o.med7::numeric(8,4) mediaultimo7,
       cast(o.med14::numeric(8,4) as varchar) media7Anterior,
       r.valorabsolutoindice, 
       r.valocalculoincide,
       r.pesoindice
from pacto.indice i 
inner join pacto.regionalindices r 
  on r.idindice = i.idinide and r.datacalculo = CAST('''||dataRef||''' as date)
inner join pacto.regional r2 
  on r2.idregional = r.idregional 
inner join pacto.internacoesregional(CAST('''||dataRef||''' as date)) o 
  on o.nomeregional = r2.nomeregional 
where i.idinide = 6 
and datacalculo = CAST('''||dataRef||''' as date)
union 
select r2.nomeregional,
       i.descricaoindice, 
       o.indice::numeric(8,4) mediaultimo7,
       ''Não se aplica'' media7Anterior,
       r.valorabsolutoindice, 
       r.valocalculoincide,
       r.pesoindice
from pacto.indice i 
inner join pacto.regionalindices r 
  on r.idindice = i.idinide and r.datacalculo = CAST('''||dataRef||''' as date)
inner join pacto.regional r2 
  on r2.idregional = r.idregional 
inner join pacto.clinicosregional(CAST('''||dataRef||''' as date)) o 
  on o.nomeregional = r2.nomeregional 
where i.idinide = 7 
and datacalculo = CAST('''||dataRef||''' as date)
order by nomeregional, descricaoindice    
';
END;
$$;


ALTER FUNCTION pacto.extratocalculo(dataref date) OWNER TO postgres;

--
-- TOC entry 262 (class 1255 OID 16394)
-- Name: internacoes_insert(); Type: FUNCTION; Schema: pacto; Owner: postgres
--

CREATE FUNCTION pacto.internacoes_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
      
      delete 
      from pacto.municipioindices 
      where idmunicipioindice in 
        (select idmunicipioindice 
          from pacto.municipioindices ri
          inner join pacto.indice i on i.descricaoindice = 'Índice de ocupação de UTIs COVID19'
          where ri.idmunicipio = new.idmunicipio  
          and ri.idindice = i.idinide 
          and ri.datacalculo = new.datainternacoes);            
    
      INSERT INTO pacto.municipioindices 
      (idmunicipio, datacalculo, idindice, valorabsolutoindice, leitosuti, leitosclinico, valocalculoincide, pesoindice)
      select m.idmunicipio, 
             new.datainternacoes, 
             i.idinide, 
             coalesce(im.indice,0), 
             m.leitosuti, 
             m.leitosclinico, 
             coalesce(e.valorcalculo, coalesce(im.indice,0)) valocalculoincide, 
             i.pesoindice 
      from pacto.municipio m,
      pacto.indice i,
      pacto.utimunicipio(new.datainternacoes) im,
      pacto.equivalencia e              
      where m.idmunicipio = new.idmunicipio and 
      im.nomemunicipio = m.nomemunicipio and
      e.idindice = i.idinide and 
      im.indice between e.valorinicial and e.valorfinal and
      i.descricaoindice = 'Índice de ocupação de UTIs COVID19';
    
      delete 
      from pacto.regionalindices 
      where idregionalindice in 
        (select idregionalindice 
          from pacto.regionalindices ri
          inner join pacto.indice i on i.descricaoindice = 'Índice de ocupação de UTIs COVID19' 
          inner join pacto.municipio m on m.idmunicipio = new.idmunicipio
          where ri.idregional = m.idregional 
          and ri.idindice = i.idinide 
          and ri.datacalculo = new.datainternacoes);
      
      INSERT INTO pacto.regionalindices
      (idregional, datacalculo, idindice, valorabsolutoindice, leitosuti, leitosclinico, valocalculoincide, pesoindice)
      select r.idregional, 
             new.datainternacoes, 
             i.idinide, 
             coalesce(im.indice,0), 
             r.leitosuti, 
             r.leitosclinico, 
             coalesce(e.valorcalculo, coalesce(im.indice,0)) valocalculoincide, 
             i.pesoindice 
      from pacto.regional r,
      pacto.utiregional(new.datainternacoes) im,
      pacto.equivalencia e,
      pacto.indice i, 
      pacto.municipio m
      where r.idregional = m.idregional 
      and e.idindice = i.idinide  
      and im.indice between e.valorinicial and e.valorfinal 
      and i.descricaoindice = 'Índice de ocupação de UTIs COVID19' 
      and im.nomeregional =  r.nomeregional 
      and m.idmunicipio = new.idmunicipio;  
    
      delete 
      from pacto.municipioindices 
      where idmunicipioindice in 
        (select idmunicipioindice 
          from pacto.municipioindices ri
          inner join pacto.indice i on i.descricaoindice = 'Índice de  ocupação de Leitos Clínicos COVID19'
          where ri.idmunicipio = new.idmunicipio  
          and ri.idindice = i.idinide 
          and ri.datacalculo = new.datainternacoes);
            
    
      INSERT INTO pacto.municipioindices 
      (idmunicipio, datacalculo, idindice, valorabsolutoindice, leitosuti, leitosclinico, valocalculoincide, pesoindice)
      select m.idmunicipio, 
             new.datainternacoes, 
             i.idinide, 
             coalesce(im.indice,0), 
             m.leitosuti, 
             m.leitosclinico, 
             coalesce(e.valorcalculo, coalesce(im.indice,0)) valocalculoincide, 
             i.pesoindice 
      from pacto.municipio m,
      pacto.indice i,
      pacto.clinicosmunicipio(new.datainternacoes) im,
      pacto.equivalencia e              
      where m.idmunicipio = new.idmunicipio and 
      im.nomemunicipio = m.nomemunicipio and
      e.idindice = i.idinide and 
      im.indice between e.valorinicial and e.valorfinal and
      i.descricaoindice = 'Índice de  ocupação de Leitos Clínicos COVID19';
    
      delete 
      from pacto.regionalindices 
      where idregionalindice in 
        (select idregionalindice 
          from pacto.regionalindices ri
          inner join pacto.indice i on i.descricaoindice = 'Índice de  ocupação de Leitos Clínicos COVID19' 
          inner join pacto.municipio m on m.idmunicipio = new.idmunicipio
          where ri.idregional = m.idregional 
          and ri.idindice = i.idinide 
          and ri.datacalculo = new.datainternacoes);
      
      INSERT INTO pacto.regionalindices
      (idregional, datacalculo, idindice, valorabsolutoindice, leitosuti, leitosclinico, valocalculoincide, pesoindice)
      select r.idregional, 
             new.datainternacoes, 
             i.idinide, 
             coalesce(im.indice,0), 
             r.leitosuti, 
             r.leitosclinico, 
             coalesce(e.valorcalculo, coalesce(im.indice,0)) valocalculoincide, 
             i.pesoindice 
      from pacto.regional r,
      pacto.clinicosregional(new.datainternacoes) im,
      pacto.equivalencia e,
      pacto.indice i, 
      pacto.municipio m
      where r.idregional = m.idregional
      and e.idindice = i.idinide 
      and im.indice between e.valorinicial and e.valorfinal
      and i.descricaoindice = 'Índice de  ocupação de Leitos Clínicos COVID19' 
      and im.nomeregional =  r.nomeregional 
      and m.idmunicipio = new.idmunicipio;  
    
      delete 
      from pacto.municipioindices 
      where idmunicipioindice in 
        (select idmunicipioindice 
          from pacto.municipioindices ri
          inner join pacto.indice i on i.descricaoindice = 'Índice de novos óbitos por covid'
          where ri.idmunicipio = new.idmunicipio  
          and ri.idindice = i.idinide 
          and ri.datacalculo = new.datainternacoes);
            
    
      INSERT INTO pacto.municipioindices 
      (idmunicipio, datacalculo, idindice, valorabsolutoindice, leitosuti, leitosclinico, valocalculoincide, pesoindice)
      select distinct m.idmunicipio, 
             new.datainternacoes, 
             i.idinide, 
             coalesce(im.indice,0), 
             m.leitosuti, 
             m.leitosclinico, 
             coalesce(e.valorcalculo, coalesce(im.indice,0)) valocalculoincide, 
             i.pesoindice 
      from pacto.municipio m,
      pacto.indice i,
      pacto.obitosmunicipio(new.datainternacoes) im,
      pacto.equivalencia e 
      where m.idmunicipio = new.idmunicipio and 
      im.nomemunicipio = m.nomemunicipio and
      e.idindice = i.idinide and        
      im.indice between e.valorinicial and e.valorfinal and
      i.descricaoindice = 'Índice de novos óbitos por covid';
    
      delete 
      from pacto.regionalindices 
      where idregionalindice in 
        (select idregionalindice 
          from pacto.regionalindices ri
          inner join pacto.indice i on i.descricaoindice = 'Índice de novos óbitos por covid' 
          inner join pacto.municipio m on m.idmunicipio = new.idmunicipio
          where ri.idregional = m.idregional 
          and ri.idindice = i.idinide 
          and ri.datacalculo = new.datainternacoes);
      
      INSERT INTO pacto.regionalindices
      (idregional, datacalculo, idindice, valorabsolutoindice, leitosuti, leitosclinico, valocalculoincide, pesoindice)
      select distinct r.idregional, 
             new.datainternacoes, 
             i.idinide, 
             coalesce(im.indice,0), 
             r.leitosuti, 
             r.leitosclinico, 
             coalesce(e.valorcalculo, coalesce(im.indice,0)) valocalculoincide, 
             i.pesoindice 
      from pacto.regional r,
      pacto.obitosregional(new.datainternacoes) im,
      pacto.indice i, 
      pacto.municipio m,
      pacto.equivalencia e      
      where r.idregional = m.idregional
      and i.descricaoindice = 'Índice de novos óbitos por covid' 
      and im.nomeregional =  r.nomeregional 
      and e.idindice = i.idinide         
      and im.indice between e.valorinicial and e.valorfinal 
      and m.idmunicipio = new.idmunicipio; 
    
      delete 
      from pacto.municipioindices 
      where idmunicipioindice in 
        (select idmunicipioindice 
          from pacto.municipioindices ri
          inner join pacto.indice i on i.descricaoindice = 'Índice de novas internações por Síndrome Respiratória Aguda Grave'
          where ri.idmunicipio = new.idmunicipio  
          and ri.idindice = i.idinide 
          and ri.datacalculo = new.datainternacoes);
            
    
      INSERT INTO pacto.municipioindices 
      (idmunicipio, datacalculo, idindice, valorabsolutoindice, leitosuti, leitosclinico, valocalculoincide, pesoindice)
      select m.idmunicipio, 
             new.datainternacoes, 
             i.idinide, 
             coalesce(im.indice,0), 
             m.leitosuti, 
             m.leitosclinico, 
             coalesce(im.indice,0) valocalculoincide, 
             i.pesoindice 
      from pacto.municipio m,
      pacto.indice i,
      pacto.internacoesmunicipio(new.datainternacoes) im
      where m.idmunicipio = new.idmunicipio and 
      im.nomemunicipio = m.nomemunicipio and
      i.descricaoindice = 'Índice de novas internações por Síndrome Respiratória Aguda Grave';
    
      delete 
      from pacto.regionalindices 
      where idregionalindice in 
        (select idregionalindice 
          from pacto.regionalindices ri
          inner join pacto.indice i on i.descricaoindice = 'Índice de novas internações por Síndrome Respiratória Aguda Grave' 
          inner join pacto.municipio m on m.idmunicipio = new.idmunicipio
          where ri.idregional = m.idregional 
          and ri.idindice = i.idinide 
          and ri.datacalculo = new.datainternacoes);
      
      INSERT INTO pacto.regionalindices
      (idregional, datacalculo, idindice, valorabsolutoindice, leitosuti, leitosclinico, valocalculoincide, pesoindice)
      select r.idregional, 
             new.datainternacoes, 
             i.idinide, 
             coalesce(im.indice,0), 
             r.leitosuti, 
             r.leitosclinico, 
             coalesce(im.indice,0) valocalculoincide, 
             i.pesoindice 
      from pacto.regional r,
      pacto.internacoesregional(new.datainternacoes) im,
      pacto.indice i, 
      pacto.municipio m
      where r.idregional = m.idregional
      and i.descricaoindice = 'Índice de novas internações por Síndrome Respiratória Aguda Grave' 
      and im.nomeregional =  r.nomeregional 
      and m.idmunicipio = new.idmunicipio; 
      
      RETURN NEW;
    END;
$$;


ALTER FUNCTION pacto.internacoes_insert() OWNER TO postgres;

--
-- TOC entry 246 (class 1255 OID 16395)
-- Name: internacoesmunicipio(date); Type: FUNCTION; Schema: pacto; Owner: postgres
--

CREATE FUNCTION pacto.internacoesmunicipio(dataref date) RETURNS TABLE(nomemunicipio character varying, d14 integer, d7 integer, med14 numeric, med7 numeric, indice numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN QUERY EXECUTE '
    SELECT DISTINCT m.nomemunicipio,
    d14.total::int AS d14,
    d7.total::int AS d7,
    d14.total / 7::numeric AS med14,
    d7.total / 7::numeric AS med7,
    case 
    when d14.total > 0  THEN
      d7.total / 7::numeric / (d14.total / 7::numeric)
    else 
       d7.total / 7::numeric
     end indice
   from pacto.municipio m LEFT  join
(select i.idmunicipio, 
        sum(i.internacoes)::numeric total
from pacto.internacoes i 
where datainternacoes between (CAST('''||dataRef||''' as date) - interval ''13 days'') and (CAST('''||dataRef||''' as date) - interval ''7 days'')
group by i.idmunicipio) d14 on d14.idmunicipio = m.idmunicipio inner join
(select i.idmunicipio, 
        sum(i.internacoes)::numeric total
from pacto.internacoes i 
where datainternacoes between (CAST('''||dataRef||''' as date) - interval ''6 days'') and CAST('''||dataRef||''' as date)
group by i.idmunicipio) d7 on d7.idmunicipio = m.idmunicipio';
END;
$$;


ALTER FUNCTION pacto.internacoesmunicipio(dataref date) OWNER TO postgres;

--
-- TOC entry 247 (class 1255 OID 16396)
-- Name: internacoesregional(date); Type: FUNCTION; Schema: pacto; Owner: postgres
--

CREATE FUNCTION pacto.internacoesregional(dataref date) RETURNS TABLE(nomeregional character varying, d14 integer, d7 integer, med14 numeric, med7 numeric, indice numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN QUERY EXECUTE '
    SELECT DISTINCT r.nomeregional ,
    d14.total::int AS d14,
    d7.total::int AS d7,
    d14.total / 7::numeric AS med14,
    d7.total / 7::numeric AS med7,
    case 
    when d14.total > 0  THEN
      d7.total / 7::numeric / (d14.total / 7::numeric)
    else 
       d7.total / 7::numeric
     end indice
   from pacto.regional r left join
(select m2.idregional, 
        sum(c.internacoes)::numeric total
from pacto.internacoes c 
inner join pacto.municipio m2 on m2.idmunicipio = c.idmunicipio 
where datainternacoes between (CAST('''||dataRef||''' as date) - interval ''13 days'') and (CAST('''||dataRef||''' as date) - interval ''7 days'')
group by m2.idregional) d14 on d14.idregional = r.idregional inner join
(select m2.idregional, 
        sum(c.internacoes)::numeric total
from pacto.internacoes c 
inner join pacto.municipio m2 on m2.idmunicipio = c.idmunicipio 
where datainternacoes between  (CAST('''||dataRef||''' as date) - interval ''6 days'') and CAST('''||dataRef||''' as date)
group by m2.idregional) d7 on d7.idregional = r.idregional
';
END;
$$;


ALTER FUNCTION pacto.internacoesregional(dataref date) OWNER TO postgres;

--
-- TOC entry 248 (class 1255 OID 16397)
-- Name: internacoesregional14(date); Type: FUNCTION; Schema: pacto; Owner: postgres
--

CREATE FUNCTION pacto.internacoesregional14(dataref date) RETURNS TABLE(nomeregional character varying, d14 integer, d7 integer, med14 numeric, med7 numeric, indice numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN QUERY EXECUTE '
    SELECT DISTINCT r.nomeregional ,
    d14.total::int AS d14,
    d7.total::int AS d7,
    d14.total / 7::numeric AS med14,
    d7.total / 7::numeric AS med7,
    case 
    when d14.total > 0  THEN
      d7.total / 7::numeric / (d14.total / 7::numeric)
    else 
       d7.total / 7::numeric
     end indice
   from pacto.regional r left join
(select m2.idregional, 
        sum(c.internacoes)::numeric total
from pacto.internacoes c 
inner join pacto.municipio m2 on m2.idmunicipio = c.idmunicipio 
where datainternacoes between (CAST('''||dataRef||''' as date) - interval ''27 days'') and (CAST('''||dataRef||''' as date) - interval ''14 days'')
group by m2.idregional) d14 on d14.idregional = r.idregional inner join
(select m2.idregional, 
        sum(c.internacoes)::numeric total
from pacto.internacoes c 
inner join pacto.municipio m2 on m2.idmunicipio = c.idmunicipio 
where datainternacoes between  (CAST('''||dataRef||''' as date) - interval ''13 days'') and CAST('''||dataRef||''' as date)
group by m2.idregional) d7 on d7.idregional = r.idregional
';
END;
$$;


ALTER FUNCTION pacto.internacoesregional14(dataref date) OWNER TO postgres;

--
-- TOC entry 249 (class 1255 OID 16398)
-- Name: isolamento_insert(); Type: FUNCTION; Schema: pacto; Owner: postgres
--

CREATE FUNCTION pacto.isolamento_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    begin
      
      delete 
      from pacto.municipioindices 
      where idmunicipioindice in 
        (select idmunicipioindice 
          from pacto.municipioindices ri
          inner join pacto.indice i on i.descricaoindice = 'Índice de isolamento social' 
          inner join pacto.municipio m on m.nomemunicipio = new.nomemunicipio
          where ri.idmunicipio = m.idmunicipio  
          and ri.idindice = i.idinide 
          and ri.datacalculo = new.dataisolamentosocial);           
      
      INSERT INTO pacto.municipioindices 
      (idmunicipio, datacalculo, idindice, valorabsolutoindice, leitosuti, leitosclinico, valocalculoincide, pesoindice)
      select m.idmunicipio, 
             new.dataisolamentosocial, 
             i.idinide, 
             coalesce(im.indice,0), 
             m.leitosuti, 
             m.leitosclinico, 
             coalesce(e.valorcalculo, new.indiceisolamento) valocalculoincide, 
             i.pesoindice 
      from pacto.municipio m ,
      pacto.indice i left join
      pacto.equivalencia e left join 
      pacto.isolamentomunicipio(new.dataisolamentosocial) im on im.nomemunicipio = new.nomemunicipio
      on e.idindice = i.idinide and im.indice between e.valorinicial and e.valorfinal 
      where m.nomemunicipio = new.nomemunicipio
      and i.descricaoindice = 'Índice de isolamento social';
    
      delete 
      from pacto.regionalindices 
      where idregionalindice in 
        (select idregionalindice 
          from pacto.regionalindices ri
          inner join pacto.indice i on i.descricaoindice = 'Índice de isolamento social' 
          inner join pacto.municipio m on m.nomemunicipio = new.nomemunicipio
          where ri.idregional = m.idregional 
          and ri.idindice = i.idinide 
          and ri.datacalculo = new.dataisolamentosocial);
      
      INSERT INTO pacto.regionalindices
      (idregional, datacalculo, idindice, valorabsolutoindice, leitosuti, leitosclinico, valocalculoincide, pesoindice)
      select r.idregional, 
             new.dataisolamentosocial, 
             i.idinide, 
             coalesce(im.indice,0), 
             r.leitosuti, 
             r.leitosclinico, 
             coalesce((select valorcalculo 
                        from pacto.equivalencia e 
                        where idindice = i.idinide and 
                            im.indice between  valorinicial  and valorfinal), new.indiceisolamento) valocalculoincide, 
             i.pesoindice 
      from pacto.regional r,
      pacto.isolamentoregional(new.dataisolamentosocial) im,
      pacto.indice i, 
      pacto.municipio m
      where r.idregional = m.idregional
      and i.descricaoindice = 'Índice de isolamento social' 
      and im.nomeregional =  r.nomeregional 
      and m.nomemunicipio = new.nomemunicipio;
      
      RETURN NEW;
    END;
$$;


ALTER FUNCTION pacto.isolamento_insert() OWNER TO postgres;

--
-- TOC entry 250 (class 1255 OID 16399)
-- Name: isolamentomunicipio(date); Type: FUNCTION; Schema: pacto; Owner: postgres
--

CREATE FUNCTION pacto.isolamentomunicipio(dataref date) RETURNS TABLE(nomemunicipio character varying, indice numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN QUERY EXECUTE '
    SELECT DISTINCT m.nomemunicipio,
    d7.total::numeric indice
   from pacto.municipio m inner join
(select i.nomemunicipio, 
        avg(i.indiceisolamento )::numeric total
from pacto.isolamentosocial i 
where i.dataisolamentosocial between (CAST('''||dataRef||''' as date) - interval ''6 days'') and CAST('''||dataRef||''' as date)
group by i.nomemunicipio) d7 on d7.nomemunicipio = m.nomemunicipio
';
END;
$$;


ALTER FUNCTION pacto.isolamentomunicipio(dataref date) OWNER TO postgres;

--
-- TOC entry 251 (class 1255 OID 16400)
-- Name: isolamentoregional(date); Type: FUNCTION; Schema: pacto; Owner: postgres
--

CREATE FUNCTION pacto.isolamentoregional(dataref date) RETURNS TABLE(nomeregional character varying, indice numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN QUERY EXECUTE 'SELECT DISTINCT r.nomeregional,
    d7.total::numeric indice
   from pacto.regional r  inner join
(select m2.idregional, 
        avg(i.indiceisolamento )::numeric total
from pacto.isolamentosocial i 
inner join pacto.municipio m2 on i.nomemunicipio = m2.nomemunicipio 
where i.dataisolamentosocial between (CAST('''||dataRef||''' as date) - interval ''6 days'') and CAST('''||dataRef||''' as date)
and i.idisolamentosocial > 0
group by m2.idregional) d7 on d7.idregional = r.idregional
' ;
END;
$$;


ALTER FUNCTION pacto.isolamentoregional(dataref date) OWNER TO postgres;

--
-- TOC entry 252 (class 1255 OID 16401)
-- Name: isolamentoregional14(date); Type: FUNCTION; Schema: pacto; Owner: postgres
--

CREATE FUNCTION pacto.isolamentoregional14(dataref date) RETURNS TABLE(nomeregional character varying, indice numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN QUERY EXECUTE 'SELECT DISTINCT r.nomeregional,
    d7.total::numeric indice
   from pacto.regional r  inner join
(select m2.idregional, 
        avg(i.indiceisolamento )::numeric total
from pacto.isolamentosocial i 
inner join pacto.municipio m2 on i.nomemunicipio = m2.nomemunicipio 
where i.dataisolamentosocial between (CAST('''||dataRef||''' as date) - interval ''13 days'') and CAST('''||dataRef||''' as date)
and i.idisolamentosocial > 0
group by m2.idregional) d7 on d7.idregional = r.idregional
' ;
END;
$$;


ALTER FUNCTION pacto.isolamentoregional14(dataref date) OWNER TO postgres;

--
-- TOC entry 253 (class 1255 OID 16402)
-- Name: notificaomunicipio(date); Type: FUNCTION; Schema: pacto; Owner: postgres
--

CREATE FUNCTION pacto.notificaomunicipio(dataref date) RETURNS TABLE(nomemunicipio character varying, d14 integer, d7 integer, med14 numeric, med7 numeric, indice numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN QUERY EXECUTE '
    SELECT DISTINCT m.nomemunicipio,
    d14.total::int AS d14,
    d7.total::int AS d7,
    d14.total / 7::numeric AS med14,
    d7.total / 7::numeric AS med7,
    case 
    when d14.total > 0  THEN
      d7.total / 7::numeric / (d14.total / 7::numeric)
    else 
       d7.total / 7::numeric
     end indice
   from pacto.municipio m LEFT join
(select c.idmunicipio, 
        sum(c.notificacoes)::numeric total
from pacto.casos c 
where datacasos between (CAST('''||dataRef||''' as date) - interval ''13 days'') and (CAST('''||dataRef||''' as date) - interval ''7 days'')
group by c.idmunicipio) d14 on d14.idmunicipio = m.idmunicipio inner join
(select c.idmunicipio, 
        sum(c.notificacoes)::numeric total
from pacto.casos c 
where datacasos between  (CAST('''||dataRef||''' as date) - interval ''6 days'') and CAST('''||dataRef||''' as date)
group by c.idmunicipio) d7 on d7.idmunicipio = m.idmunicipio';
END;
$$;


ALTER FUNCTION pacto.notificaomunicipio(dataref date) OWNER TO postgres;

--
-- TOC entry 254 (class 1255 OID 16403)
-- Name: notificaoregional(date); Type: FUNCTION; Schema: pacto; Owner: postgres
--

CREATE FUNCTION pacto.notificaoregional(dataref date) RETURNS TABLE(nomeregional character varying, d14 integer, d7 integer, med14 numeric, med7 numeric, indice numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN QUERY EXECUTE '
  SELECT DISTINCT r.nomeregional ,
    d14.total::int AS d14,
    d7.total::int AS d7,
    d14.total / 7::numeric AS med14,
    d7.total / 7::numeric AS med7,
    case 
    when d14.total > 0  THEN
      d7.total / 7::numeric / (d14.total / 7::numeric)
    else 
       d7.total / 7::numeric
     end indice
   from pacto.regional r LEFT join
(select m.idregional, 
        sum(c.notificacoes)::numeric total
from pacto.casos c LEFT join 
  pacto.municipio m on m.idmunicipio = c.idmunicipio 
where datacasos between (CAST('''||dataref||''' as date) - interval ''13 days'') and (CAST('''||dataref||''' as date) - interval ''7 days'')
group by m.idregional) d14 on d14.idregional = r.idregional inner join
(select m.idregional, 
        sum(c.notificacoes)::numeric total
from pacto.casos c inner join 
  pacto.municipio m on m.idmunicipio = c.idmunicipio 
where datacasos between  (CAST('''||dataref||''' as date) - interval ''6 days'') and CAST('''||dataref||''' as date)
group by m.idregional) d7 on d7.idregional = r.idregional     
';
END;
$$;


ALTER FUNCTION pacto.notificaoregional(dataref date) OWNER TO postgres;

--
-- TOC entry 255 (class 1255 OID 16404)
-- Name: notificaoregional14(date); Type: FUNCTION; Schema: pacto; Owner: postgres
--

CREATE FUNCTION pacto.notificaoregional14(dataref date) RETURNS TABLE(nomeregional character varying, d14 integer, d7 integer, med14 numeric, med7 numeric, indice numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN QUERY EXECUTE '
  SELECT DISTINCT r.nomeregional ,
    d14.total::int AS d14,
    d7.total::int AS d7,
    d14.total / 7::numeric AS med14,
    d7.total / 7::numeric AS med7,
    case 
    when d14.total > 0  THEN
      d7.total / 7::numeric / (d14.total / 7::numeric)
    else 
       d7.total / 7::numeric
     end indice
   from pacto.regional r LEFT join
(select m.idregional, 
        sum(c.notificacoes)::numeric total
from pacto.casos c LEFT join 
  pacto.municipio m on m.idmunicipio = c.idmunicipio 
where datacasos between (CAST('''||dataref||''' as date) - interval ''27 days'') and (CAST('''||dataref||''' as date) - interval ''14 days'')
group by m.idregional) d14 on d14.idregional = r.idregional inner join
(select m.idregional, 
        sum(c.notificacoes)::numeric total
from pacto.casos c inner join 
  pacto.municipio m on m.idmunicipio = c.idmunicipio 
where datacasos between  (CAST('''||dataref||''' as date) - interval ''13 days'') and CAST('''||dataref||''' as date)
group by m.idregional) d7 on d7.idregional = r.idregional     
';
END;
$$;


ALTER FUNCTION pacto.notificaoregional14(dataref date) OWNER TO postgres;

--
-- TOC entry 261 (class 1255 OID 16405)
-- Name: obitosmunicipio(date); Type: FUNCTION; Schema: pacto; Owner: postgres
--

CREATE FUNCTION pacto.obitosmunicipio(dataref date) RETURNS TABLE(nomemunicipio character varying, d14 integer, d7 integer, med14 numeric, med7 numeric, indice numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN QUERY EXECUTE '
    SELECT DISTINCT m.nomemunicipio,
    d14.total::int AS d14,
    d7.total::int AS d7,
    d14.total::numeric AS med14,
    d7.total::numeric AS med7,
    d7.total::numeric AS indice
   from pacto.municipio m LEFT join
(select i.idmunicipio, 
        sum(i.obitos)::numeric total
from pacto.internacoes i 
where datainternacoes between (CAST('''||dataRef||''' as date) - interval ''13 days'') and (CAST('''||dataRef||''' as date) - interval ''7 days'')
group by i.idmunicipio) d14 on d14.idmunicipio = m.idmunicipio inner join
(select i.idmunicipio, 
        sum(i.obitos)::numeric total
from pacto.internacoes i 
where datainternacoes between (CAST('''||dataRef||''' as date) - interval ''6 days'') and CAST('''||dataRef||''' as date)
group by i.idmunicipio) d7 on d7.idmunicipio = m.idmunicipio';
END;
$$;


ALTER FUNCTION pacto.obitosmunicipio(dataref date) OWNER TO postgres;

--
-- TOC entry 260 (class 1255 OID 16406)
-- Name: obitosregional(date); Type: FUNCTION; Schema: pacto; Owner: postgres
--

CREATE FUNCTION pacto.obitosregional(dataref date) RETURNS TABLE(nomeregional character varying, d14 integer, d7 integer, med14 numeric, med7 numeric, indice numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN QUERY EXECUTE '
    SELECT DISTINCT r.nomeregional ,
    d14.total::int AS d14,
    d7.total::int AS d7,
    d14.total::numeric AS med14,
    d7.total::numeric AS med7,
    d7.total::numeric AS indice
   from pacto.regional r left join
(select m2.idregional, 
        sum(c.obitos)::numeric total
from pacto.internacoes c 
inner join pacto.municipio m2 on m2.idmunicipio = c.idmunicipio 
where datainternacoes between (CAST('''||dataRef||''' as date) - interval ''13 days'') and (CAST('''||dataRef||''' as date) - interval ''7 days'')
group by m2.idregional) d14 on d14.idregional = r.idregional inner join
(select m2.idregional, 
        sum(c.obitos)::numeric total
from pacto.internacoes c 
inner join pacto.municipio m2 on m2.idmunicipio = c.idmunicipio 
where datainternacoes between  (CAST('''||dataRef||''' as date) - interval ''6 days'') and CAST('''||dataRef||''' as date)
group by m2.idregional) d7 on d7.idregional = r.idregional
';
END;
$$;


ALTER FUNCTION pacto.obitosregional(dataref date) OWNER TO postgres;

--
-- TOC entry 256 (class 1255 OID 16407)
-- Name: obitosregional14(date); Type: FUNCTION; Schema: pacto; Owner: postgres
--

CREATE FUNCTION pacto.obitosregional14(dataref date) RETURNS TABLE(nomeregional character varying, d14 integer, d7 integer, med14 numeric, med7 numeric, indice numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN QUERY EXECUTE '
    SELECT DISTINCT r.nomeregional ,
    d14.total::int AS d14,
    d7.total::int AS d7,
    d14.total / 7::numeric AS med14,
    d7.total / 7::numeric AS med7,
    case 
    when d14.total > 0 THEN
      d7.total / 7::numeric / (d14.total / 7::numeric)
    else 
       d7.total / 7::numeric
     end indice
   from pacto.regional r left join
(select m2.idregional, 
        sum(c.obitos)::numeric total
from pacto.internacoes c 
inner join pacto.municipio m2 on m2.idmunicipio = c.idmunicipio 
where datainternacoes between (CAST('''||dataRef||''' as date) - interval ''27 days'') and (CAST('''||dataRef||''' as date) - interval ''14 days'')
group by m2.idregional) d14 on d14.idregional = r.idregional inner join
(select m2.idregional, 
        sum(c.obitos)::numeric total
from pacto.internacoes c 
inner join pacto.municipio m2 on m2.idmunicipio = c.idmunicipio 
where datainternacoes between  (CAST('''||dataRef||''' as date) - interval ''13 days'') and CAST('''||dataRef||''' as date)
group by m2.idregional) d7 on d7.idregional = r.idregional
';
END;
$$;


ALTER FUNCTION pacto.obitosregional14(dataref date) OWNER TO postgres;

--
-- TOC entry 257 (class 1255 OID 16408)
-- Name: utimunicipio(date); Type: FUNCTION; Schema: pacto; Owner: postgres
--

CREATE FUNCTION pacto.utimunicipio(dataref date) RETURNS TABLE(nomemunicipio character varying, indice numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN QUERY EXECUTE '
    SELECT DISTINCT m.nomemunicipio,
    d7.total::numeric AS indice
   from pacto.municipio m inner join
(select i.idmunicipio, 
        avg(i.leitosuti)::numeric total
from pacto.internacoes i 
where datainternacoes between (CAST('''||dataRef||''' as date) - interval ''6 days'') and CAST('''||dataRef||''' as date) 
and i.leitosuti > 0
group by i.idmunicipio) d7 on d7.idmunicipio = m.idmunicipio 
';
END;
$$;


ALTER FUNCTION pacto.utimunicipio(dataref date) OWNER TO postgres;

--
-- TOC entry 258 (class 1255 OID 16409)
-- Name: utiregional(date); Type: FUNCTION; Schema: pacto; Owner: postgres
--

CREATE FUNCTION pacto.utiregional(dataref date) RETURNS TABLE(nomeregional character varying, indice numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN QUERY EXECUTE '
SELECT DISTINCT r.nomeregional,
    d7.total::numeric AS indice
   from pacto.regional r left join
(select m.idregional, 
        avg(i.leitosuti)::numeric total
from pacto.internacoes i inner join 
pacto.municipio m on i.idmunicipio = m.idmunicipio 
where datainternacoes between (CAST('''||dataRef||''' as date) - interval ''6 days'') and CAST('''||dataRef||''' as date) and 
i.leitosuti > 0 
group by m.idregional) d7 on d7.idregional = r.idregional
';
END;
$$;


ALTER FUNCTION pacto.utiregional(dataref date) OWNER TO postgres;

--
-- TOC entry 259 (class 1255 OID 16410)
-- Name: utiregional14(date); Type: FUNCTION; Schema: pacto; Owner: postgres
--

CREATE FUNCTION pacto.utiregional14(dataref date) RETURNS TABLE(nomeregional character varying, indice numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN QUERY EXECUTE '
SELECT DISTINCT r.nomeregional,
    d7.total::numeric AS indice
   from pacto.regional r left join
(select m.idregional, 
        avg(i.leitosuti)::numeric total
from pacto.internacoes i inner join 
pacto.municipio m on i.idmunicipio = m.idmunicipio 
where datainternacoes between (CAST('''||dataRef||''' as date) - interval ''13 days'') and CAST('''||dataRef||''' as date) and 
i.leitosuti > 0 
group by m.idregional) d7 on d7.idregional = r.idregional
';
END;
$$;


ALTER FUNCTION pacto.utiregional14(dataref date) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 201 (class 1259 OID 16411)
-- Name: casos; Type: TABLE; Schema: pacto; Owner: postgres
--

CREATE TABLE pacto.casos (
    iscasos integer NOT NULL,
    idmunicipio integer NOT NULL,
    notificacoes integer DEFAULT 0 NOT NULL,
    confirmacoes integer DEFAULT 0 NOT NULL,
    datacasos date DEFAULT now() NOT NULL
);


ALTER TABLE pacto.casos OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 16417)
-- Name: casos_iscasos_seq; Type: SEQUENCE; Schema: pacto; Owner: postgres
--

CREATE SEQUENCE pacto.casos_iscasos_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pacto.casos_iscasos_seq OWNER TO postgres;

--
-- TOC entry 3157 (class 0 OID 0)
-- Dependencies: 202
-- Name: casos_iscasos_seq; Type: SEQUENCE OWNED BY; Schema: pacto; Owner: postgres
--

ALTER SEQUENCE pacto.casos_iscasos_seq OWNED BY pacto.casos.iscasos;


--
-- TOC entry 203 (class 1259 OID 16419)
-- Name: equivalencia; Type: TABLE; Schema: pacto; Owner: postgres
--

CREATE TABLE pacto.equivalencia (
    idequivalencia integer NOT NULL,
    idindice integer NOT NULL,
    valorinicial numeric(8,2) NOT NULL,
    valorfinal numeric(8,2) NOT NULL,
    valorcalculo numeric(8,2) NOT NULL
);


ALTER TABLE pacto.equivalencia OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 16422)
-- Name: equivalencia_idequivalencia_seq; Type: SEQUENCE; Schema: pacto; Owner: postgres
--

CREATE SEQUENCE pacto.equivalencia_idequivalencia_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pacto.equivalencia_idequivalencia_seq OWNER TO postgres;

--
-- TOC entry 3158 (class 0 OID 0)
-- Dependencies: 204
-- Name: equivalencia_idequivalencia_seq; Type: SEQUENCE OWNED BY; Schema: pacto; Owner: postgres
--

ALTER SEQUENCE pacto.equivalencia_idequivalencia_seq OWNED BY pacto.equivalencia.idequivalencia;


--
-- TOC entry 205 (class 1259 OID 16424)
-- Name: indice; Type: TABLE; Schema: pacto; Owner: postgres
--

CREATE TABLE pacto.indice (
    nomeindice character varying(400) NOT NULL,
    descricaoindice character varying(10000),
    formulaindice character varying(10000) NOT NULL,
    iniciouso date DEFAULT now() NOT NULL,
    fimuso date,
    idinide integer NOT NULL,
    pesoindice numeric(8,2) DEFAULT 0 NOT NULL
);


ALTER TABLE pacto.indice OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 16432)
-- Name: indice_idinide_seq; Type: SEQUENCE; Schema: pacto; Owner: postgres
--

CREATE SEQUENCE pacto.indice_idinide_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pacto.indice_idinide_seq OWNER TO postgres;

--
-- TOC entry 3159 (class 0 OID 0)
-- Dependencies: 206
-- Name: indice_idinide_seq; Type: SEQUENCE OWNED BY; Schema: pacto; Owner: postgres
--

ALTER SEQUENCE pacto.indice_idinide_seq OWNED BY pacto.indice.idinide;


--
-- TOC entry 207 (class 1259 OID 16434)
-- Name: indicematriz; Type: TABLE; Schema: pacto; Owner: postgres
--

CREATE TABLE pacto.indicematriz (
    idindicematriz integer NOT NULL,
    idmatriz integer NOT NULL,
    idindice integer NOT NULL,
    gravidade integer NOT NULL,
    urgencia integer NOT NULL,
    tendencia integer NOT NULL
);


ALTER TABLE pacto.indicematriz OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 16437)
-- Name: indicematriz_idindicematriz_seq; Type: SEQUENCE; Schema: pacto; Owner: postgres
--

CREATE SEQUENCE pacto.indicematriz_idindicematriz_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pacto.indicematriz_idindicematriz_seq OWNER TO postgres;

--
-- TOC entry 3160 (class 0 OID 0)
-- Dependencies: 208
-- Name: indicematriz_idindicematriz_seq; Type: SEQUENCE OWNED BY; Schema: pacto; Owner: postgres
--

ALTER SEQUENCE pacto.indicematriz_idindicematriz_seq OWNED BY pacto.indicematriz.idindicematriz;


--
-- TOC entry 209 (class 1259 OID 16439)
-- Name: internacoes; Type: TABLE; Schema: pacto; Owner: postgres
--

CREATE TABLE pacto.internacoes (
    idinternacoes integer NOT NULL,
    datainternacoes date DEFAULT now() NOT NULL,
    idmunicipio integer NOT NULL,
    internacoes integer DEFAULT 0 NOT NULL,
    obitos integer DEFAULT 0 NOT NULL,
    leitosclinicos numeric(8,2) DEFAULT 0,
    leitosuti numeric(8,2) DEFAULT 0
);


ALTER TABLE pacto.internacoes OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 16447)
-- Name: internacoes_idinternacoes_seq; Type: SEQUENCE; Schema: pacto; Owner: postgres
--

CREATE SEQUENCE pacto.internacoes_idinternacoes_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pacto.internacoes_idinternacoes_seq OWNER TO postgres;

--
-- TOC entry 3161 (class 0 OID 0)
-- Dependencies: 210
-- Name: internacoes_idinternacoes_seq; Type: SEQUENCE OWNED BY; Schema: pacto; Owner: postgres
--

ALTER SEQUENCE pacto.internacoes_idinternacoes_seq OWNED BY pacto.internacoes.idinternacoes;


--
-- TOC entry 211 (class 1259 OID 16449)
-- Name: isolamentosocial; Type: TABLE; Schema: pacto; Owner: postgres
--

CREATE TABLE pacto.isolamentosocial (
    idisolamentosocial integer NOT NULL,
    dataisolamentosocial date DEFAULT now() NOT NULL,
    nomemunicipio character varying(400) NOT NULL,
    indiceisolamento numeric(8,2)
);


ALTER TABLE pacto.isolamentosocial OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 16453)
-- Name: isolamentosocial_idisolamentosocial_seq; Type: SEQUENCE; Schema: pacto; Owner: postgres
--

CREATE SEQUENCE pacto.isolamentosocial_idisolamentosocial_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pacto.isolamentosocial_idisolamentosocial_seq OWNER TO postgres;

--
-- TOC entry 3162 (class 0 OID 0)
-- Dependencies: 212
-- Name: isolamentosocial_idisolamentosocial_seq; Type: SEQUENCE OWNED BY; Schema: pacto; Owner: postgres
--

ALTER SEQUENCE pacto.isolamentosocial_idisolamentosocial_seq OWNED BY pacto.isolamentosocial.idisolamentosocial;


--
-- TOC entry 213 (class 1259 OID 16455)
-- Name: matrizgut; Type: TABLE; Schema: pacto; Owner: postgres
--

CREATE TABLE pacto.matrizgut (
    idmatriz integer NOT NULL,
    entidade character varying(400) NOT NULL,
    responsavelpreenchimento character varying(400) NOT NULL,
    emailcontato character varying(400),
    inciouso date DEFAULT now() NOT NULL,
    fimuso date
);


ALTER TABLE pacto.matrizgut OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16462)
-- Name: matrizgut_idmatriz_seq; Type: SEQUENCE; Schema: pacto; Owner: postgres
--

CREATE SEQUENCE pacto.matrizgut_idmatriz_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pacto.matrizgut_idmatriz_seq OWNER TO postgres;

--
-- TOC entry 3163 (class 0 OID 0)
-- Dependencies: 214
-- Name: matrizgut_idmatriz_seq; Type: SEQUENCE OWNED BY; Schema: pacto; Owner: postgres
--

ALTER SEQUENCE pacto.matrizgut_idmatriz_seq OWNED BY pacto.matrizgut.idmatriz;


--
-- TOC entry 215 (class 1259 OID 16464)
-- Name: municipio; Type: TABLE; Schema: pacto; Owner: postgres
--

CREATE TABLE pacto.municipio (
    idmunicipio integer NOT NULL,
    nomemunicipio character varying(400) NOT NULL,
    idregional integer NOT NULL,
    leitosuti integer DEFAULT 0 NOT NULL,
    leitosclinico integer DEFAULT 0 NOT NULL
);


ALTER TABLE pacto.municipio OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16469)
-- Name: municipio_idmunicipio_seq; Type: SEQUENCE; Schema: pacto; Owner: postgres
--

CREATE SEQUENCE pacto.municipio_idmunicipio_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pacto.municipio_idmunicipio_seq OWNER TO postgres;

--
-- TOC entry 3164 (class 0 OID 0)
-- Dependencies: 216
-- Name: municipio_idmunicipio_seq; Type: SEQUENCE OWNED BY; Schema: pacto; Owner: postgres
--

ALTER SEQUENCE pacto.municipio_idmunicipio_seq OWNED BY pacto.municipio.idmunicipio;


--
-- TOC entry 217 (class 1259 OID 16471)
-- Name: municipioindices; Type: TABLE; Schema: pacto; Owner: postgres
--

CREATE TABLE pacto.municipioindices (
    idmunicipioindice integer NOT NULL,
    idmunicipio integer,
    datacalculo date DEFAULT now() NOT NULL,
    idindice integer NOT NULL,
    valorabsolutoindice numeric(8,2) DEFAULT 0 NOT NULL,
    leitosuti integer NOT NULL,
    leitosclinico integer NOT NULL,
    valocalculoincide numeric(8,2),
    pesoindice numeric(8,2) DEFAULT 1 NOT NULL
);


ALTER TABLE pacto.municipioindices OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16477)
-- Name: municipioindices_idmunicipioindice_seq; Type: SEQUENCE; Schema: pacto; Owner: postgres
--

CREATE SEQUENCE pacto.municipioindices_idmunicipioindice_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pacto.municipioindices_idmunicipioindice_seq OWNER TO postgres;

--
-- TOC entry 3165 (class 0 OID 0)
-- Dependencies: 218
-- Name: municipioindices_idmunicipioindice_seq; Type: SEQUENCE OWNED BY; Schema: pacto; Owner: postgres
--

ALTER SEQUENCE pacto.municipioindices_idmunicipioindice_seq OWNED BY pacto.municipioindices.idmunicipioindice;


--
-- TOC entry 219 (class 1259 OID 16479)
-- Name: municipionomes; Type: TABLE; Schema: pacto; Owner: postgres
--

CREATE TABLE pacto.municipionomes (
    idmunicipionome integer NOT NULL,
    idmunicipio integer NOT NULL,
    nomemunicipio character varying(400)
);


ALTER TABLE pacto.municipionomes OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16482)
-- Name: municipionomes_idmunicipionome_seq; Type: SEQUENCE; Schema: pacto; Owner: postgres
--

CREATE SEQUENCE pacto.municipionomes_idmunicipionome_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pacto.municipionomes_idmunicipionome_seq OWNER TO postgres;

--
-- TOC entry 3166 (class 0 OID 0)
-- Dependencies: 220
-- Name: municipionomes_idmunicipionome_seq; Type: SEQUENCE OWNED BY; Schema: pacto; Owner: postgres
--

ALTER SEQUENCE pacto.municipionomes_idmunicipionome_seq OWNED BY pacto.municipionomes.idmunicipionome;


--
-- TOC entry 221 (class 1259 OID 16484)
-- Name: regional; Type: TABLE; Schema: pacto; Owner: postgres
--

CREATE TABLE pacto.regional (
    idregional integer NOT NULL,
    nomeregional character varying(400) NOT NULL,
    leitosuti integer DEFAULT 0 NOT NULL,
    leitosclinico integer DEFAULT 0 NOT NULL
);


ALTER TABLE pacto.regional OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16489)
-- Name: regionalindices; Type: TABLE; Schema: pacto; Owner: postgres
--

CREATE TABLE pacto.regionalindices (
    idregionalindice integer NOT NULL,
    idregional integer,
    datacalculo date DEFAULT now() NOT NULL,
    idindice integer NOT NULL,
    valorabsolutoindice numeric(8,2) DEFAULT 0 NOT NULL,
    leitosuti integer NOT NULL,
    leitosclinico integer,
    valocalculoincide numeric(8,2),
    pesoindice numeric(8,2) DEFAULT 1 NOT NULL
);


ALTER TABLE pacto.regionalindices OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16495)
-- Name: notas; Type: VIEW; Schema: pacto; Owner: postgres
--

CREATE VIEW pacto.notas AS
 SELECT r.nomeregional,
    ri.datacalculo,
    i.descricaoindice,
    ri.valocalculoincide,
    ri.pesoindice,
    (ri.valocalculoincide * ri.pesoindice) AS produto
   FROM ((pacto.regionalindices ri
     JOIN pacto.regional r ON ((r.idregional = ri.idregional)))
     JOIN pacto.indice i ON ((i.idinide = ri.idindice)));


ALTER TABLE pacto.notas OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16500)
-- Name: notas14_14; Type: VIEW; Schema: pacto; Owner: postgres
--

CREATE VIEW pacto.notas14_14 AS
 SELECT i14.nomeregional,
    i.descricaoindice,
    (i14.indice)::numeric(8,2) AS indice,
    i.pesoindice
   FROM (pacto.isolamentoregional14('2020-07-04'::date) i14(nomeregional, indice)
     JOIN pacto.indice i ON ((i.idinide = 3)))
UNION
 SELECT i14.nomeregional,
    i.descricaoindice,
    (i14.indice)::numeric(8,2) AS indice,
    i.pesoindice
   FROM (pacto.notificaoregional14('2020-07-04'::date) i14(nomeregional, d14, d7, med14, med7, indice)
     JOIN pacto.indice i ON ((i.idinide = 4)))
UNION
 SELECT i14.nomeregional,
    i.descricaoindice,
    (i14.indice)::numeric(8,2) AS indice,
    i.pesoindice
   FROM (pacto.internacoesregional14('2020-07-04'::date) i14(nomeregional, d14, d7, med14, med7, indice)
     JOIN pacto.indice i ON ((i.idinide = 6)))
UNION
 SELECT i14.nomeregional,
    i.descricaoindice,
    (i14.indice)::numeric(8,2) AS indice,
    i.pesoindice
   FROM (pacto.confirmadoregional14('2020-07-04'::date) i14(nomeregional, d14, d7, med14, med7, indice)
     JOIN pacto.indice i ON ((i.idinide = 5)))
UNION
 SELECT i14.nomeregional,
    i.descricaoindice,
    (i14.indice)::numeric(8,2) AS indice,
    i.pesoindice
   FROM (pacto.obitosregional14('2020-07-04'::date) i14(nomeregional, d14, d7, med14, med7, indice)
     JOIN pacto.indice i ON ((i.idinide = 1)))
UNION
 SELECT i14.nomeregional,
    i.descricaoindice,
    (i14.indice)::numeric(8,2) AS indice,
    i.pesoindice
   FROM (pacto.notificaoregional14('2020-07-04'::date) i14(nomeregional, d14, d7, med14, med7, indice)
     JOIN pacto.indice i ON ((i.idinide = 4)))
UNION
 SELECT i14.nomeregional,
    i.descricaoindice,
    (i14.indice)::numeric(8,2) AS indice,
    i.pesoindice
   FROM (pacto.clinicosregional14('2020-07-04'::date) i14(nomeregional, indice)
     JOIN pacto.indice i ON ((i.idinide = 7)))
UNION
 SELECT i14.nomeregional,
    i.descricaoindice,
    (i14.indice)::numeric(8,2) AS indice,
    i.pesoindice
   FROM (pacto.utiregional14('2020-07-04'::date) i14(nomeregional, indice)
     JOIN pacto.indice i ON ((i.idinide = 2)))
  ORDER BY 1, 2;


ALTER TABLE pacto.notas14_14 OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16505)
-- Name: regional_idregional_seq; Type: SEQUENCE; Schema: pacto; Owner: postgres
--

CREATE SEQUENCE pacto.regional_idregional_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pacto.regional_idregional_seq OWNER TO postgres;

--
-- TOC entry 3167 (class 0 OID 0)
-- Dependencies: 225
-- Name: regional_idregional_seq; Type: SEQUENCE OWNED BY; Schema: pacto; Owner: postgres
--

ALTER SEQUENCE pacto.regional_idregional_seq OWNED BY pacto.regional.idregional;


--
-- TOC entry 226 (class 1259 OID 16507)
-- Name: regionalindices_idregionalindice_seq; Type: SEQUENCE; Schema: pacto; Owner: postgres
--

CREATE SEQUENCE pacto.regionalindices_idregionalindice_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pacto.regionalindices_idregionalindice_seq OWNER TO postgres;

--
-- TOC entry 3168 (class 0 OID 0)
-- Dependencies: 226
-- Name: regionalindices_idregionalindice_seq; Type: SEQUENCE OWNED BY; Schema: pacto; Owner: postgres
--

ALTER SEQUENCE pacto.regionalindices_idregionalindice_seq OWNED BY pacto.regionalindices.idregionalindice;


--
-- TOC entry 2908 (class 2604 OID 16509)
-- Name: casos iscasos; Type: DEFAULT; Schema: pacto; Owner: postgres
--

ALTER TABLE ONLY pacto.casos ALTER COLUMN iscasos SET DEFAULT nextval('pacto.casos_iscasos_seq'::regclass);


--
-- TOC entry 2909 (class 2604 OID 16510)
-- Name: equivalencia idequivalencia; Type: DEFAULT; Schema: pacto; Owner: postgres
--

ALTER TABLE ONLY pacto.equivalencia ALTER COLUMN idequivalencia SET DEFAULT nextval('pacto.equivalencia_idequivalencia_seq'::regclass);


--
-- TOC entry 2912 (class 2604 OID 16511)
-- Name: indice idinide; Type: DEFAULT; Schema: pacto; Owner: postgres
--

ALTER TABLE ONLY pacto.indice ALTER COLUMN idinide SET DEFAULT nextval('pacto.indice_idinide_seq'::regclass);


--
-- TOC entry 2913 (class 2604 OID 16512)
-- Name: indicematriz idindicematriz; Type: DEFAULT; Schema: pacto; Owner: postgres
--

ALTER TABLE ONLY pacto.indicematriz ALTER COLUMN idindicematriz SET DEFAULT nextval('pacto.indicematriz_idindicematriz_seq'::regclass);


--
-- TOC entry 2919 (class 2604 OID 16513)
-- Name: internacoes idinternacoes; Type: DEFAULT; Schema: pacto; Owner: postgres
--

ALTER TABLE ONLY pacto.internacoes ALTER COLUMN idinternacoes SET DEFAULT nextval('pacto.internacoes_idinternacoes_seq'::regclass);


--
-- TOC entry 2921 (class 2604 OID 16514)
-- Name: isolamentosocial idisolamentosocial; Type: DEFAULT; Schema: pacto; Owner: postgres
--

ALTER TABLE ONLY pacto.isolamentosocial ALTER COLUMN idisolamentosocial SET DEFAULT nextval('pacto.isolamentosocial_idisolamentosocial_seq'::regclass);


--
-- TOC entry 2923 (class 2604 OID 16515)
-- Name: matrizgut idmatriz; Type: DEFAULT; Schema: pacto; Owner: postgres
--

ALTER TABLE ONLY pacto.matrizgut ALTER COLUMN idmatriz SET DEFAULT nextval('pacto.matrizgut_idmatriz_seq'::regclass);


--
-- TOC entry 2926 (class 2604 OID 16516)
-- Name: municipio idmunicipio; Type: DEFAULT; Schema: pacto; Owner: postgres
--

ALTER TABLE ONLY pacto.municipio ALTER COLUMN idmunicipio SET DEFAULT nextval('pacto.municipio_idmunicipio_seq'::regclass);


--
-- TOC entry 2930 (class 2604 OID 16517)
-- Name: municipioindices idmunicipioindice; Type: DEFAULT; Schema: pacto; Owner: postgres
--

ALTER TABLE ONLY pacto.municipioindices ALTER COLUMN idmunicipioindice SET DEFAULT nextval('pacto.municipioindices_idmunicipioindice_seq'::regclass);


--
-- TOC entry 2931 (class 2604 OID 16518)
-- Name: municipionomes idmunicipionome; Type: DEFAULT; Schema: pacto; Owner: postgres
--

ALTER TABLE ONLY pacto.municipionomes ALTER COLUMN idmunicipionome SET DEFAULT nextval('pacto.municipionomes_idmunicipionome_seq'::regclass);


--
-- TOC entry 2934 (class 2604 OID 16519)
-- Name: regional idregional; Type: DEFAULT; Schema: pacto; Owner: postgres
--

ALTER TABLE ONLY pacto.regional ALTER COLUMN idregional SET DEFAULT nextval('pacto.regional_idregional_seq'::regclass);


--
-- TOC entry 2938 (class 2604 OID 16520)
-- Name: regionalindices idregionalindice; Type: DEFAULT; Schema: pacto; Owner: postgres
--

ALTER TABLE ONLY pacto.regionalindices ALTER COLUMN idregionalindice SET DEFAULT nextval('pacto.regionalindices_idregionalindice_seq'::regclass);


--
-- TOC entry 3130 (class 0 OID 16419)
-- Dependencies: 203
-- Data for Name: equivalencia; Type: TABLE DATA; Schema: pacto; Owner: postgres
--

INSERT INTO pacto.equivalencia VALUES (20, 7, 0.00, 0.00, 0.00);
INSERT INTO pacto.equivalencia VALUES (25, 7, 60.00, 70.00, 1.20);
INSERT INTO pacto.equivalencia VALUES (26, 7, 70.01, 79.99, 1.50);
INSERT INTO pacto.equivalencia VALUES (28, 2, 70.01, 79.99, 1.50);
INSERT INTO pacto.equivalencia VALUES (29, 2, 80.00, 1000.00, 2.00);
INSERT INTO pacto.equivalencia VALUES (31, 7, 80.00, 1000.00, 2.00);
INSERT INTO pacto.equivalencia VALUES (32, 2, 30.01, 40.00, 0.30);
INSERT INTO pacto.equivalencia VALUES (18, 2, 40.01, 50.00, 0.50);
INSERT INTO pacto.equivalencia VALUES (21, 2, 50.01, 60.00, 1.00);
INSERT INTO pacto.equivalencia VALUES (27, 2, 60.01, 70.00, 1.20);
INSERT INTO pacto.equivalencia VALUES (35, 2, 0.01, 30.00, 0.10);
INSERT INTO pacto.equivalencia VALUES (37, 2, 0.00, 0.00, 0.00);
INSERT INTO pacto.equivalencia VALUES (19, 7, 50.01, 59.99, 1.00);
INSERT INTO pacto.equivalencia VALUES (38, 7, 40.01, 50.00, 0.50);
INSERT INTO pacto.equivalencia VALUES (39, 7, 30.01, 40.00, 0.30);
INSERT INTO pacto.equivalencia VALUES (41, 7, 0.01, 30.00, 0.10);
INSERT INTO pacto.equivalencia VALUES (22, 3, 0.00, 39.99, 2.00);
INSERT INTO pacto.equivalencia VALUES (43, 3, 40.00, 49.99, 1.50);
INSERT INTO pacto.equivalencia VALUES (23, 3, 50.01, 59.99, 1.20);
INSERT INTO pacto.equivalencia VALUES (24, 3, 60.00, 69.99, 1.00);
INSERT INTO pacto.equivalencia VALUES (30, 3, 70.00, 1000.00, 0.20);
INSERT INTO pacto.equivalencia VALUES (44, 1, 0.00, 0.00, 0.00);
INSERT INTO pacto.equivalencia VALUES (45, 1, 0.01, 2.99, 0.25);
INSERT INTO pacto.equivalencia VALUES (46, 1, 3.00, 5.99, 0.50);
INSERT INTO pacto.equivalencia VALUES (47, 1, 6.00, 9.99, 0.75);
INSERT INTO pacto.equivalencia VALUES (48, 1, 10.00, 13.99, 1.00);
INSERT INTO pacto.equivalencia VALUES (49, 1, 14.00, 15.99, 1.25);
INSERT INTO pacto.equivalencia VALUES (50, 1, 16.00, 20.99, 1.50);
INSERT INTO pacto.equivalencia VALUES (51, 1, 21.00, 30.99, 2.50);
INSERT INTO pacto.equivalencia VALUES (52, 1, 31.00, 40.99, 3.50);
INSERT INTO pacto.equivalencia VALUES (53, 1, 41.00, 100000.00, 5.00);


--
-- TOC entry 3132 (class 0 OID 16424)
-- Dependencies: 205
-- Data for Name: indice; Type: TABLE DATA; Schema: pacto; Owner: postgres
--

INSERT INTO pacto.indice VALUES ('isolamentoSocial', 'Índice de isolamento social', '.', '2020-06-22', NULL, 3, 0.42);
INSERT INTO pacto.indice VALUES ('leitos', 'Índice de  ocupação de Leitos Clínicos COVID19', '.', '2020-06-22', NULL, 7, 2.57);
INSERT INTO pacto.indice VALUES ('notificacoes', 'Índice de notificações por síndrome gripal', '.', '2020-06-22', NULL, 4, 1.71);
INSERT INTO pacto.indice VALUES ('internacoes', 'Índice de novas internações por Síndrome Respiratória Aguda Grave', '.', '2020-06-22', NULL, 6, 2.14);
INSERT INTO pacto.indice VALUES ('confirmados', 'Índice de novos casos por síndrome gripal COVID 19', '.', '2020-06-22', NULL, 5, 0.85);
INSERT INTO pacto.indice VALUES ('obitos', 'Índice de novos óbitos por covid', '.', '2020-06-22', NULL, 1, 1.28);
INSERT INTO pacto.indice VALUES ('utiCovid', 'Índice de ocupação de UTIs COVID19', '.', '2020-06-22', NULL, 2, 3.00);


--
-- TOC entry 3134 (class 0 OID 16434)
-- Dependencies: 207
-- Data for Name: indicematriz; Type: TABLE DATA; Schema: pacto; Owner: postgres
--

INSERT INTO pacto.indicematriz VALUES (205, 1, 5, 3, 3, 3);
INSERT INTO pacto.indicematriz VALUES (206, 1, 6, 3, 4, 4);
INSERT INTO pacto.indicematriz VALUES (207, 1, 1, 3, 3, 2);
INSERT INTO pacto.indicematriz VALUES (209, 1, 7, 4, 4, 5);
INSERT INTO pacto.indicematriz VALUES (210, 1, 4, 3, 3, 3);
INSERT INTO pacto.indicematriz VALUES (211, 1, 3, 2, 3, 2);
INSERT INTO pacto.indicematriz VALUES (212, 2, 5, 4, 2, 5);
INSERT INTO pacto.indicematriz VALUES (213, 2, 6, 4, 3, 5);
INSERT INTO pacto.indicematriz VALUES (214, 2, 1, 2, 5, 2);
INSERT INTO pacto.indicematriz VALUES (216, 2, 7, 5, 5, 5);
INSERT INTO pacto.indicematriz VALUES (217, 2, 4, 3, 3, 3);
INSERT INTO pacto.indicematriz VALUES (218, 2, 3, 3, 1, 2);
INSERT INTO pacto.indicematriz VALUES (219, 3, 5, 1, 3, 5);
INSERT INTO pacto.indicematriz VALUES (220, 3, 6, 2, 4, 5);
INSERT INTO pacto.indicematriz VALUES (221, 3, 1, 5, 5, 3);
INSERT INTO pacto.indicematriz VALUES (223, 3, 7, 4, 4, 2);
INSERT INTO pacto.indicematriz VALUES (224, 3, 4, 3, 3, 5);
INSERT INTO pacto.indicematriz VALUES (225, 3, 3, 3, 4, 5);
INSERT INTO pacto.indicematriz VALUES (226, 4, 5, 3, 3, 3);
INSERT INTO pacto.indicematriz VALUES (227, 4, 6, 4, 5, 5);
INSERT INTO pacto.indicematriz VALUES (230, 4, 7, 5, 2, 5);
INSERT INTO pacto.indicematriz VALUES (231, 4, 4, 3, 4, 5);
INSERT INTO pacto.indicematriz VALUES (232, 4, 3, 3, 3, 3);
INSERT INTO pacto.indicematriz VALUES (233, 15, 5, 4, 3, 4);
INSERT INTO pacto.indicematriz VALUES (234, 15, 6, 3, 3, 4);
INSERT INTO pacto.indicematriz VALUES (235, 15, 1, 3, 1, 4);
INSERT INTO pacto.indicematriz VALUES (237, 15, 7, 4, 5, 4);
INSERT INTO pacto.indicematriz VALUES (238, 15, 4, 4, 4, 4);
INSERT INTO pacto.indicematriz VALUES (239, 15, 3, 4, 3, 2);
INSERT INTO pacto.indicematriz VALUES (240, 16, 5, 3, 2, 3);
INSERT INTO pacto.indicematriz VALUES (241, 16, 6, 4, 3, 4);
INSERT INTO pacto.indicematriz VALUES (242, 16, 1, 4, 2, 2);
INSERT INTO pacto.indicematriz VALUES (244, 16, 7, 4, 4, 4);
INSERT INTO pacto.indicematriz VALUES (245, 16, 4, 3, 2, 3);
INSERT INTO pacto.indicematriz VALUES (246, 16, 3, 3, 2, 2);
INSERT INTO pacto.indicematriz VALUES (247, 11, 5, 3, 3, 4);
INSERT INTO pacto.indicematriz VALUES (248, 11, 6, 4, 4, 5);
INSERT INTO pacto.indicematriz VALUES (249, 11, 1, 3, 3, 5);
INSERT INTO pacto.indicematriz VALUES (251, 11, 7, 4, 4, 5);
INSERT INTO pacto.indicematriz VALUES (252, 11, 4, 3, 3, 4);
INSERT INTO pacto.indicematriz VALUES (253, 11, 3, 3, 3, 4);
INSERT INTO pacto.indicematriz VALUES (228, 4, 1, 3, 3, 3);
INSERT INTO pacto.indicematriz VALUES (254, 1, 2, 5, 5, 5);
INSERT INTO pacto.indicematriz VALUES (255, 2, 2, 5, 5, 2);
INSERT INTO pacto.indicematriz VALUES (256, 3, 2, 5, 4, 3);
INSERT INTO pacto.indicematriz VALUES (257, 4, 2, 5, 5, 5);
INSERT INTO pacto.indicematriz VALUES (258, 15, 2, 5, 5, 5);
INSERT INTO pacto.indicematriz VALUES (259, 16, 2, 5, 5, 5);
INSERT INTO pacto.indicematriz VALUES (260, 11, 2, 5, 5, 5);


--
-- TOC entry 3138 (class 0 OID 16449)
-- Dependencies: 211
-- Data for Name: isolamentosocial; Type: TABLE DATA; Schema: pacto; Owner: postgres
--

INSERT INTO pacto.isolamentosocial VALUES (7158, '2020-07-26', 'Capixaba', 54.35);
INSERT INTO pacto.isolamentosocial VALUES (7159, '2020-07-26', 'Cruzeiro do Sul', 54.44);
INSERT INTO pacto.isolamentosocial VALUES (7160, '2020-07-26', 'Epitaciolândia', 56.02);
INSERT INTO pacto.isolamentosocial VALUES (7161, '2020-07-26', 'Feijó', 53.80);
INSERT INTO pacto.isolamentosocial VALUES (7162, '2020-07-26', 'Mâncio Lima', 53.33);
INSERT INTO pacto.isolamentosocial VALUES (7163, '2020-07-26', 'Manoel Urbano', 48.65);
INSERT INTO pacto.isolamentosocial VALUES (7164, '2020-07-26', 'Marechal Thaumaturgo', 57.14);
INSERT INTO pacto.isolamentosocial VALUES (7165, '2020-07-26', 'Plácido de Castro', 51.43);
INSERT INTO pacto.isolamentosocial VALUES (7166, '2020-07-26', 'Porto Acre', 49.24);
INSERT INTO pacto.isolamentosocial VALUES (7167, '2020-07-26', 'Rio Branco', 51.49);
INSERT INTO pacto.isolamentosocial VALUES (7168, '2020-07-26', 'Rodrigues Alves', 42.86);
INSERT INTO pacto.isolamentosocial VALUES (7169, '2020-07-26', 'Sena Madureira', 50.25);
INSERT INTO pacto.isolamentosocial VALUES (7170, '2020-07-26', 'Senador Guiomard', 56.29);
INSERT INTO pacto.isolamentosocial VALUES (7171, '2020-07-26', 'Tarauacá', 44.67);
INSERT INTO pacto.isolamentosocial VALUES (7172, '2020-07-26', 'Xapuri', 59.60);
INSERT INTO pacto.isolamentosocial VALUES (7173, '2020-07-27', 'Acrelândia', 40.81);
INSERT INTO pacto.isolamentosocial VALUES (7174, '2020-07-27', 'Assis Brasil', 50.94);
INSERT INTO pacto.isolamentosocial VALUES (7175, '2020-07-27', 'Brasiléia', 37.27);
INSERT INTO pacto.isolamentosocial VALUES (7176, '2020-07-27', 'Bujari', 43.71);
INSERT INTO pacto.isolamentosocial VALUES (7177, '2020-07-27', 'Capixaba', 48.51);
INSERT INTO pacto.isolamentosocial VALUES (7178, '2020-07-27', 'Cruzeiro do Sul', 41.40);
INSERT INTO pacto.isolamentosocial VALUES (7179, '2020-07-27', 'Epitaciolândia', 43.20);
INSERT INTO pacto.isolamentosocial VALUES (7180, '2020-07-27', 'Feijó', 46.03);
INSERT INTO pacto.isolamentosocial VALUES (7181, '2020-07-27', 'Mâncio Lima', 51.61);
INSERT INTO pacto.isolamentosocial VALUES (7182, '2020-07-27', 'Manoel Urbano', 39.06);
INSERT INTO pacto.isolamentosocial VALUES (7183, '2020-07-27', 'Marechal Thaumaturgo', 39.13);
INSERT INTO pacto.isolamentosocial VALUES (7184, '2020-07-27', 'Plácido de Castro', 39.60);
INSERT INTO pacto.isolamentosocial VALUES (7185, '2020-07-27', 'Porto Acre', 37.55);
INSERT INTO pacto.isolamentosocial VALUES (7186, '2020-07-27', 'Rio Branco', 41.64);
INSERT INTO pacto.isolamentosocial VALUES (7187, '2020-07-27', 'Rodrigues Alves', 42.42);
INSERT INTO pacto.isolamentosocial VALUES (7188, '2020-07-27', 'Sena Madureira', 36.08);
INSERT INTO pacto.isolamentosocial VALUES (7189, '2020-07-27', 'Senador Guiomard', 43.20);
INSERT INTO pacto.isolamentosocial VALUES (7190, '2020-07-27', 'Tarauacá', 39.60);
INSERT INTO pacto.isolamentosocial VALUES (7191, '2020-07-27', 'Xapuri', 43.18);
INSERT INTO pacto.isolamentosocial VALUES (7192, '2020-07-28', 'Acrelândia', 36.49);
INSERT INTO pacto.isolamentosocial VALUES (7193, '2020-07-28', 'Assis Brasil', 33.33);
INSERT INTO pacto.isolamentosocial VALUES (7194, '2020-07-28', 'Brasiléia', 39.86);
INSERT INTO pacto.isolamentosocial VALUES (7195, '2020-07-28', 'Bujari', 48.47);
INSERT INTO pacto.isolamentosocial VALUES (7196, '2020-07-28', 'Capixaba', 48.51);
INSERT INTO pacto.isolamentosocial VALUES (7197, '2020-07-28', 'Cruzeiro do Sul', 44.36);
INSERT INTO pacto.isolamentosocial VALUES (7198, '2020-07-28', 'Epitaciolândia', 46.96);
INSERT INTO pacto.isolamentosocial VALUES (7199, '2020-07-28', 'Feijó', 36.84);
INSERT INTO pacto.isolamentosocial VALUES (7200, '2020-07-28', 'Mâncio Lima', 49.30);
INSERT INTO pacto.isolamentosocial VALUES (7201, '2020-07-28', 'Manoel Urbano', 38.67);
INSERT INTO pacto.isolamentosocial VALUES (7202, '2020-07-28', 'Marechal Thaumaturgo', 55.17);
INSERT INTO pacto.isolamentosocial VALUES (7203, '2020-07-28', 'Plácido de Castro', 44.35);
INSERT INTO pacto.isolamentosocial VALUES (7204, '2020-07-28', 'Porto Acre', 41.92);
INSERT INTO pacto.isolamentosocial VALUES (7205, '2020-07-28', 'Rio Branco', 42.12);
INSERT INTO pacto.isolamentosocial VALUES (7206, '2020-07-28', 'Rodrigues Alves', 33.33);
INSERT INTO pacto.isolamentosocial VALUES (7207, '2020-07-28', 'Sena Madureira', 39.60);
INSERT INTO pacto.isolamentosocial VALUES (7208, '2020-07-28', 'Senador Guiomard', 42.73);
INSERT INTO pacto.isolamentosocial VALUES (7209, '2020-07-28', 'Tarauacá', 41.10);
INSERT INTO pacto.isolamentosocial VALUES (7210, '2020-07-28', 'Xapuri', 40.24);
INSERT INTO pacto.isolamentosocial VALUES (7211, '2020-07-29', 'Acrelândia', 41.63);
INSERT INTO pacto.isolamentosocial VALUES (7212, '2020-07-29', 'Assis Brasil', 46.15);
INSERT INTO pacto.isolamentosocial VALUES (7213, '2020-07-29', 'Brasiléia', 37.63);
INSERT INTO pacto.isolamentosocial VALUES (7214, '2020-07-29', 'Bujari', 42.61);
INSERT INTO pacto.isolamentosocial VALUES (7215, '2020-07-29', 'Capixaba', 52.68);
INSERT INTO pacto.isolamentosocial VALUES (7216, '2020-07-29', 'Cruzeiro do Sul', 42.23);
INSERT INTO pacto.isolamentosocial VALUES (7217, '2020-07-29', 'Epitaciolândia', 45.83);
INSERT INTO pacto.isolamentosocial VALUES (7218, '2020-07-29', 'Feijó', 47.34);
INSERT INTO pacto.isolamentosocial VALUES (7219, '2020-07-29', 'Mâncio Lima', 36.62);
INSERT INTO pacto.isolamentosocial VALUES (7220, '2020-07-29', 'Manoel Urbano', 29.85);
INSERT INTO pacto.isolamentosocial VALUES (7221, '2020-07-29', 'Marechal Thaumaturgo', 45.00);
INSERT INTO pacto.isolamentosocial VALUES (7222, '2020-07-29', 'Plácido de Castro', 41.91);
INSERT INTO pacto.isolamentosocial VALUES (7229, '2020-07-29', 'Xapuri', 38.41);
INSERT INTO pacto.isolamentosocial VALUES (7021, '2020-07-19', 'Acrelândia', 43.40);
INSERT INTO pacto.isolamentosocial VALUES (7022, '2020-07-19', 'Assis Brasil', 63.04);
INSERT INTO pacto.isolamentosocial VALUES (7023, '2020-07-19', 'Brasiléia', 44.31);
INSERT INTO pacto.isolamentosocial VALUES (7024, '2020-07-19', 'Bujari', 51.90);
INSERT INTO pacto.isolamentosocial VALUES (7025, '2020-07-19', 'Capixaba', 49.49);
INSERT INTO pacto.isolamentosocial VALUES (7026, '2020-07-19', 'Cruzeiro do Sul', 52.94);
INSERT INTO pacto.isolamentosocial VALUES (7027, '2020-07-19', 'Epitaciolândia', 57.64);
INSERT INTO pacto.isolamentosocial VALUES (7028, '2020-07-19', 'Feijó', 53.37);
INSERT INTO pacto.isolamentosocial VALUES (7029, '2020-07-19', 'Mâncio Lima', 52.83);
INSERT INTO pacto.isolamentosocial VALUES (7030, '2020-07-19', 'Manoel Urbano', 57.69);
INSERT INTO pacto.isolamentosocial VALUES (7031, '2020-07-19', 'Marechal Thaumaturgo', 61.90);
INSERT INTO pacto.isolamentosocial VALUES (7032, '2020-07-19', 'Plácido de Castro', 51.60);
INSERT INTO pacto.isolamentosocial VALUES (7033, '2020-07-19', 'Porto Acre', 54.85);
INSERT INTO pacto.isolamentosocial VALUES (7034, '2020-07-19', 'Rio Branco', 51.95);
INSERT INTO pacto.isolamentosocial VALUES (7035, '2020-07-19', 'Rodrigues Alves', 36.00);
INSERT INTO pacto.isolamentosocial VALUES (7036, '2020-07-19', 'Sena Madureira', 50.26);
INSERT INTO pacto.isolamentosocial VALUES (7037, '2020-07-19', 'Senador Guiomard', 53.87);
INSERT INTO pacto.isolamentosocial VALUES (7038, '2020-07-19', 'Tarauacá', 38.96);
INSERT INTO pacto.isolamentosocial VALUES (7039, '2020-07-19', 'Xapuri', 52.56);
INSERT INTO pacto.isolamentosocial VALUES (7040, '2020-07-20', 'Acrelândia', 35.84);
INSERT INTO pacto.isolamentosocial VALUES (7041, '2020-07-20', 'Assis Brasil', 44.00);
INSERT INTO pacto.isolamentosocial VALUES (7042, '2020-07-20', 'Brasiléia', 39.31);
INSERT INTO pacto.isolamentosocial VALUES (7043, '2020-07-20', 'Bujari', 43.72);
INSERT INTO pacto.isolamentosocial VALUES (7044, '2020-07-20', 'Capixaba', 49.07);
INSERT INTO pacto.isolamentosocial VALUES (7045, '2020-07-20', 'Cruzeiro do Sul', 41.56);
INSERT INTO pacto.isolamentosocial VALUES (7046, '2020-07-20', 'Epitaciolândia', 47.51);
INSERT INTO pacto.isolamentosocial VALUES (7047, '2020-07-20', 'Feijó', 46.24);
INSERT INTO pacto.isolamentosocial VALUES (7048, '2020-07-20', 'Mâncio Lima', 45.45);
INSERT INTO pacto.isolamentosocial VALUES (7049, '2020-07-20', 'Manoel Urbano', 47.95);
INSERT INTO pacto.isolamentosocial VALUES (7050, '2020-07-20', 'Marechal Thaumaturgo', 48.28);
INSERT INTO pacto.isolamentosocial VALUES (7051, '2020-07-20', 'Plácido de Castro', 41.44);
INSERT INTO pacto.isolamentosocial VALUES (7052, '2020-07-20', 'Porto Acre', 46.15);
INSERT INTO pacto.isolamentosocial VALUES (7053, '2020-07-20', 'Rio Branco', 43.61);
INSERT INTO pacto.isolamentosocial VALUES (7054, '2020-07-20', 'Rodrigues Alves', 51.72);
INSERT INTO pacto.isolamentosocial VALUES (7055, '2020-07-20', 'Sena Madureira', 36.00);
INSERT INTO pacto.isolamentosocial VALUES (7056, '2020-07-20', 'Senador Guiomard', 45.42);
INSERT INTO pacto.isolamentosocial VALUES (7057, '2020-07-20', 'Tarauacá', 35.71);
INSERT INTO pacto.isolamentosocial VALUES (7058, '2020-07-20', 'Xapuri', 42.07);
INSERT INTO pacto.isolamentosocial VALUES (7059, '2020-07-21', 'Acrelândia', 38.79);
INSERT INTO pacto.isolamentosocial VALUES (7060, '2020-07-21', 'Assis Brasil', 55.56);
INSERT INTO pacto.isolamentosocial VALUES (7061, '2020-07-21', 'Brasiléia', 43.01);
INSERT INTO pacto.isolamentosocial VALUES (7062, '2020-07-21', 'Bujari', 47.19);
INSERT INTO pacto.isolamentosocial VALUES (7063, '2020-07-21', 'Capixaba', 38.95);
INSERT INTO pacto.isolamentosocial VALUES (7064, '2020-07-21', 'Cruzeiro do Sul', 44.97);
INSERT INTO pacto.isolamentosocial VALUES (7065, '2020-07-21', 'Epitaciolândia', 43.25);
INSERT INTO pacto.isolamentosocial VALUES (7066, '2020-07-21', 'Feijó', 46.29);
INSERT INTO pacto.isolamentosocial VALUES (7067, '2020-07-21', 'Mâncio Lima', 41.43);
INSERT INTO pacto.isolamentosocial VALUES (7068, '2020-07-21', 'Manoel Urbano', 41.27);
INSERT INTO pacto.isolamentosocial VALUES (7069, '2020-07-21', 'Marechal Thaumaturgo', 48.00);
INSERT INTO pacto.isolamentosocial VALUES (7070, '2020-07-21', 'Plácido de Castro', 42.97);
INSERT INTO pacto.isolamentosocial VALUES (7071, '2020-07-21', 'Porto Acre', 43.73);
INSERT INTO pacto.isolamentosocial VALUES (7072, '2020-07-21', 'Rio Branco', 43.62);
INSERT INTO pacto.isolamentosocial VALUES (7073, '2020-07-21', 'Rodrigues Alves', 48.15);
INSERT INTO pacto.isolamentosocial VALUES (7074, '2020-07-21', 'Sena Madureira', 39.12);
INSERT INTO pacto.isolamentosocial VALUES (7075, '2020-07-21', 'Senador Guiomard', 43.96);
INSERT INTO pacto.isolamentosocial VALUES (7076, '2020-07-21', 'Tarauacá', 37.93);
INSERT INTO pacto.isolamentosocial VALUES (7077, '2020-07-21', 'Xapuri', 41.50);
INSERT INTO pacto.isolamentosocial VALUES (7078, '2020-07-22', 'Acrelândia', 34.96);
INSERT INTO pacto.isolamentosocial VALUES (7079, '2020-07-22', 'Assis Brasil', 41.07);
INSERT INTO pacto.isolamentosocial VALUES (7080, '2020-07-22', 'Brasiléia', 41.41);
INSERT INTO pacto.isolamentosocial VALUES (7081, '2020-07-22', 'Bujari', 43.10);
INSERT INTO pacto.isolamentosocial VALUES (7082, '2020-07-22', 'Capixaba', 48.48);
INSERT INTO pacto.isolamentosocial VALUES (7083, '2020-07-22', 'Cruzeiro do Sul', 40.88);
INSERT INTO pacto.isolamentosocial VALUES (7084, '2020-07-22', 'Epitaciolândia', 43.08);
INSERT INTO pacto.isolamentosocial VALUES (7085, '2020-07-22', 'Feijó', 41.72);
INSERT INTO pacto.isolamentosocial VALUES (7086, '2020-07-22', 'Mâncio Lima', 45.59);
INSERT INTO pacto.isolamentosocial VALUES (7087, '2020-07-22', 'Manoel Urbano', 40.00);
INSERT INTO pacto.isolamentosocial VALUES (7088, '2020-07-22', 'Marechal Thaumaturgo', 47.83);
INSERT INTO pacto.isolamentosocial VALUES (7089, '2020-07-22', 'Plácido de Castro', 43.75);
INSERT INTO pacto.isolamentosocial VALUES (7090, '2020-07-22', 'Porto Acre', 43.12);
INSERT INTO pacto.isolamentosocial VALUES (7091, '2020-07-22', 'Rio Branco', 42.12);
INSERT INTO pacto.isolamentosocial VALUES (7092, '2020-07-22', 'Rodrigues Alves', 46.88);
INSERT INTO pacto.isolamentosocial VALUES (7093, '2020-07-22', 'Sena Madureira', 36.88);
INSERT INTO pacto.isolamentosocial VALUES (7094, '2020-07-22', 'Senador Guiomard', 43.76);
INSERT INTO pacto.isolamentosocial VALUES (7095, '2020-07-22', 'Tarauacá', 38.03);
INSERT INTO pacto.isolamentosocial VALUES (7096, '2020-07-22', 'Xapuri', 41.94);
INSERT INTO pacto.isolamentosocial VALUES (7097, '2020-07-23', 'Acrelândia', 34.20);
INSERT INTO pacto.isolamentosocial VALUES (7098, '2020-07-23', 'Assis Brasil', 36.00);
INSERT INTO pacto.isolamentosocial VALUES (7099, '2020-07-23', 'Brasiléia', 35.16);
INSERT INTO pacto.isolamentosocial VALUES (7100, '2020-07-23', 'Bujari', 49.44);
INSERT INTO pacto.isolamentosocial VALUES (7101, '2020-07-23', 'Capixaba', 44.68);
INSERT INTO pacto.isolamentosocial VALUES (7102, '2020-07-23', 'Cruzeiro do Sul', 40.81);
INSERT INTO pacto.isolamentosocial VALUES (7103, '2020-07-23', 'Epitaciolândia', 48.21);
INSERT INTO pacto.isolamentosocial VALUES (7104, '2020-07-23', 'Feijó', 46.93);
INSERT INTO pacto.isolamentosocial VALUES (7105, '2020-07-23', 'Mâncio Lima', 40.54);
INSERT INTO pacto.isolamentosocial VALUES (7106, '2020-07-23', 'Manoel Urbano', 39.44);
INSERT INTO pacto.isolamentosocial VALUES (7107, '2020-07-23', 'Marechal Thaumaturgo', 47.83);
INSERT INTO pacto.isolamentosocial VALUES (7108, '2020-07-23', 'Plácido de Castro', 45.77);
INSERT INTO pacto.isolamentosocial VALUES (7109, '2020-07-23', 'Porto Acre', 43.66);
INSERT INTO pacto.isolamentosocial VALUES (7110, '2020-07-23', 'Rio Branco', 42.94);
INSERT INTO pacto.isolamentosocial VALUES (7111, '2020-07-23', 'Rodrigues Alves', 34.48);
INSERT INTO pacto.isolamentosocial VALUES (7112, '2020-07-23', 'Sena Madureira', 39.16);
INSERT INTO pacto.isolamentosocial VALUES (7113, '2020-07-23', 'Senador Guiomard', 44.56);
INSERT INTO pacto.isolamentosocial VALUES (7114, '2020-07-23', 'Tarauacá', 43.14);
INSERT INTO pacto.isolamentosocial VALUES (7115, '2020-07-23', 'Xapuri', 43.88);
INSERT INTO pacto.isolamentosocial VALUES (7116, '2020-07-24', 'Acrelândia', 37.62);
INSERT INTO pacto.isolamentosocial VALUES (7117, '2020-07-24', 'Assis Brasil', 39.22);
INSERT INTO pacto.isolamentosocial VALUES (7118, '2020-07-24', 'Brasiléia', 37.10);
INSERT INTO pacto.isolamentosocial VALUES (7119, '2020-07-24', 'Bujari', 45.76);
INSERT INTO pacto.isolamentosocial VALUES (7120, '2020-07-24', 'Capixaba', 46.60);
INSERT INTO pacto.isolamentosocial VALUES (7121, '2020-07-24', 'Cruzeiro do Sul', 44.57);
INSERT INTO pacto.isolamentosocial VALUES (7122, '2020-07-24', 'Epitaciolândia', 50.38);
INSERT INTO pacto.isolamentosocial VALUES (7123, '2020-07-24', 'Feijó', 49.24);
INSERT INTO pacto.isolamentosocial VALUES (7124, '2020-07-24', 'Mâncio Lima', 42.86);
INSERT INTO pacto.isolamentosocial VALUES (7125, '2020-07-24', 'Manoel Urbano', 46.38);
INSERT INTO pacto.isolamentosocial VALUES (7126, '2020-07-24', 'Marechal Thaumaturgo', 51.85);
INSERT INTO pacto.isolamentosocial VALUES (7127, '2020-07-24', 'Plácido de Castro', 42.25);
INSERT INTO pacto.isolamentosocial VALUES (7128, '2020-07-24', 'Porto Acre', 46.58);
INSERT INTO pacto.isolamentosocial VALUES (7129, '2020-07-24', 'Rio Branco', 42.07);
INSERT INTO pacto.isolamentosocial VALUES (7130, '2020-07-24', 'Rodrigues Alves', 45.83);
INSERT INTO pacto.isolamentosocial VALUES (7131, '2020-07-24', 'Sena Madureira', 38.20);
INSERT INTO pacto.isolamentosocial VALUES (7132, '2020-07-24', 'Senador Guiomard', 44.66);
INSERT INTO pacto.isolamentosocial VALUES (7133, '2020-07-24', 'Tarauacá', 40.00);
INSERT INTO pacto.isolamentosocial VALUES (7134, '2020-07-24', 'Xapuri', 45.77);
INSERT INTO pacto.isolamentosocial VALUES (7135, '2020-07-25', 'Acrelândia', 42.20);
INSERT INTO pacto.isolamentosocial VALUES (7136, '2020-07-25', 'Assis Brasil', 42.59);
INSERT INTO pacto.isolamentosocial VALUES (7137, '2020-07-25', 'Brasiléia', 42.80);
INSERT INTO pacto.isolamentosocial VALUES (7138, '2020-07-25', 'Bujari', 45.56);
INSERT INTO pacto.isolamentosocial VALUES (7139, '2020-07-25', 'Capixaba', 53.40);
INSERT INTO pacto.isolamentosocial VALUES (7140, '2020-07-25', 'Cruzeiro do Sul', 44.84);
INSERT INTO pacto.isolamentosocial VALUES (7141, '2020-07-25', 'Epitaciolândia', 49.80);
INSERT INTO pacto.isolamentosocial VALUES (7142, '2020-07-25', 'Feijó', 55.80);
INSERT INTO pacto.isolamentosocial VALUES (7143, '2020-07-25', 'Mâncio Lima', 60.66);
INSERT INTO pacto.isolamentosocial VALUES (7144, '2020-07-25', 'Manoel Urbano', 43.84);
INSERT INTO pacto.isolamentosocial VALUES (7145, '2020-07-25', 'Marechal Thaumaturgo', 60.71);
INSERT INTO pacto.isolamentosocial VALUES (7146, '2020-07-25', 'Plácido de Castro', 44.53);
INSERT INTO pacto.isolamentosocial VALUES (7147, '2020-07-25', 'Porto Acre', 43.59);
INSERT INTO pacto.isolamentosocial VALUES (7148, '2020-07-25', 'Rio Branco', 46.76);
INSERT INTO pacto.isolamentosocial VALUES (7149, '2020-07-25', 'Rodrigues Alves', 40.00);
INSERT INTO pacto.isolamentosocial VALUES (7150, '2020-07-25', 'Sena Madureira', 42.09);
INSERT INTO pacto.isolamentosocial VALUES (7151, '2020-07-25', 'Senador Guiomard', 47.23);
INSERT INTO pacto.isolamentosocial VALUES (7152, '2020-07-25', 'Tarauacá', 37.18);
INSERT INTO pacto.isolamentosocial VALUES (7153, '2020-07-25', 'Xapuri', 53.02);
INSERT INTO pacto.isolamentosocial VALUES (7154, '2020-07-26', 'Acrelândia', 38.71);
INSERT INTO pacto.isolamentosocial VALUES (7155, '2020-07-26', 'Assis Brasil', 56.52);
INSERT INTO pacto.isolamentosocial VALUES (7156, '2020-07-26', 'Brasiléia', 50.54);
INSERT INTO pacto.isolamentosocial VALUES (7157, '2020-07-26', 'Bujari', 55.83);
INSERT INTO pacto.isolamentosocial VALUES (7223, '2020-07-29', 'Porto Acre', 39.18);
INSERT INTO pacto.isolamentosocial VALUES (7224, '2020-07-29', 'Rio Branco', 41.48);
INSERT INTO pacto.isolamentosocial VALUES (7225, '2020-07-29', 'Rodrigues Alves', 57.69);
INSERT INTO pacto.isolamentosocial VALUES (7226, '2020-07-29', 'Sena Madureira', 34.53);
INSERT INTO pacto.isolamentosocial VALUES (7227, '2020-07-29', 'Senador Guiomard', 43.70);
INSERT INTO pacto.isolamentosocial VALUES (7228, '2020-07-29', 'Tarauacá', 38.26);
INSERT INTO pacto.isolamentosocial VALUES (4625, '2020-03-12', 'Capixaba', 32.43);
INSERT INTO pacto.isolamentosocial VALUES (4626, '2020-03-13', 'Capixaba', 41.03);
INSERT INTO pacto.isolamentosocial VALUES (4627, '2020-03-14', 'Capixaba', 39.74);
INSERT INTO pacto.isolamentosocial VALUES (4628, '2020-03-15', 'Capixaba', 37.88);
INSERT INTO pacto.isolamentosocial VALUES (4629, '2020-03-16', 'Capixaba', 38.36);
INSERT INTO pacto.isolamentosocial VALUES (4630, '2020-03-17', 'Capixaba', 32.88);
INSERT INTO pacto.isolamentosocial VALUES (4631, '2020-03-18', 'Capixaba', 42.86);
INSERT INTO pacto.isolamentosocial VALUES (4632, '2020-03-19', 'Capixaba', 37.66);
INSERT INTO pacto.isolamentosocial VALUES (4633, '2020-03-20', 'Capixaba', 36.14);
INSERT INTO pacto.isolamentosocial VALUES (4686, '2020-05-12', 'Capixaba', 45.98);
INSERT INTO pacto.isolamentosocial VALUES (4687, '2020-05-13', 'Capixaba', 44.94);
INSERT INTO pacto.isolamentosocial VALUES (4688, '2020-05-14', 'Capixaba', 52.50);
INSERT INTO pacto.isolamentosocial VALUES (4689, '2020-05-15', 'Capixaba', 38.20);
INSERT INTO pacto.isolamentosocial VALUES (4690, '2020-05-16', 'Capixaba', 47.67);
INSERT INTO pacto.isolamentosocial VALUES (4691, '2020-05-17', 'Capixaba', 53.76);
INSERT INTO pacto.isolamentosocial VALUES (4692, '2020-05-18', 'Capixaba', 40.21);
INSERT INTO pacto.isolamentosocial VALUES (4693, '2020-05-19', 'Capixaba', 47.52);
INSERT INTO pacto.isolamentosocial VALUES (4694, '2020-05-20', 'Capixaba', 36.59);
INSERT INTO pacto.isolamentosocial VALUES (4695, '2020-05-21', 'Capixaba', 39.77);
INSERT INTO pacto.isolamentosocial VALUES (4696, '2020-05-22', 'Capixaba', 52.69);
INSERT INTO pacto.isolamentosocial VALUES (4697, '2020-05-23', 'Capixaba', 48.24);
INSERT INTO pacto.isolamentosocial VALUES (4698, '2020-05-24', 'Capixaba', 51.06);
INSERT INTO pacto.isolamentosocial VALUES (4699, '2020-05-25', 'Capixaba', 54.08);
INSERT INTO pacto.isolamentosocial VALUES (4700, '2020-05-26', 'Capixaba', 53.68);
INSERT INTO pacto.isolamentosocial VALUES (4701, '2020-05-27', 'Capixaba', 44.44);
INSERT INTO pacto.isolamentosocial VALUES (4702, '2020-05-28', 'Capixaba', 44.32);
INSERT INTO pacto.isolamentosocial VALUES (4703, '2020-05-29', 'Capixaba', 44.57);
INSERT INTO pacto.isolamentosocial VALUES (4704, '2020-05-30', 'Capixaba', 50.56);
INSERT INTO pacto.isolamentosocial VALUES (4705, '2020-05-31', 'Capixaba', 55.56);
INSERT INTO pacto.isolamentosocial VALUES (4706, '2020-06-01', 'Capixaba', 36.08);
INSERT INTO pacto.isolamentosocial VALUES (4707, '2020-06-02', 'Capixaba', 49.40);
INSERT INTO pacto.isolamentosocial VALUES (4708, '2020-06-03', 'Capixaba', 52.75);
INSERT INTO pacto.isolamentosocial VALUES (4709, '2020-06-04', 'Capixaba', 46.67);
INSERT INTO pacto.isolamentosocial VALUES (4710, '2020-06-05', 'Capixaba', 41.46);
INSERT INTO pacto.isolamentosocial VALUES (4711, '2020-06-06', 'Capixaba', 44.05);
INSERT INTO pacto.isolamentosocial VALUES (4712, '2020-06-07', 'Capixaba', 47.37);
INSERT INTO pacto.isolamentosocial VALUES (4713, '2020-06-08', 'Capixaba', 38.96);
INSERT INTO pacto.isolamentosocial VALUES (4714, '2020-06-09', 'Capixaba', 39.08);
INSERT INTO pacto.isolamentosocial VALUES (4715, '2020-06-10', 'Capixaba', 37.65);
INSERT INTO pacto.isolamentosocial VALUES (4716, '2020-06-11', 'Capixaba', 44.19);
INSERT INTO pacto.isolamentosocial VALUES (4717, '2020-06-12', 'Capixaba', 36.36);
INSERT INTO pacto.isolamentosocial VALUES (4718, '2020-06-13', 'Capixaba', 35.80);
INSERT INTO pacto.isolamentosocial VALUES (4719, '2020-06-14', 'Capixaba', 61.36);
INSERT INTO pacto.isolamentosocial VALUES (4720, '2020-06-15', 'Capixaba', 39.81);
INSERT INTO pacto.isolamentosocial VALUES (4721, '2020-06-16', 'Capixaba', 41.49);
INSERT INTO pacto.isolamentosocial VALUES (4722, '2020-06-17', 'Capixaba', 38.10);
INSERT INTO pacto.isolamentosocial VALUES (4723, '2020-06-18', 'Capixaba', 42.00);
INSERT INTO pacto.isolamentosocial VALUES (4724, '2020-06-19', 'Capixaba', 35.87);
INSERT INTO pacto.isolamentosocial VALUES (4725, '2020-06-20', 'Capixaba', 41.12);
INSERT INTO pacto.isolamentosocial VALUES (4726, '2020-06-21', 'Capixaba', 55.56);
INSERT INTO pacto.isolamentosocial VALUES (4727, '2020-06-22', 'Capixaba', 47.62);
INSERT INTO pacto.isolamentosocial VALUES (4728, '2020-06-23', 'Capixaba', 48.11);
INSERT INTO pacto.isolamentosocial VALUES (4729, '2020-06-24', 'Capixaba', 54.72);
INSERT INTO pacto.isolamentosocial VALUES (4730, '2020-06-25', 'Capixaba', 46.46);
INSERT INTO pacto.isolamentosocial VALUES (4731, '2020-06-26', 'Capixaba', 34.74);
INSERT INTO pacto.isolamentosocial VALUES (4732, '2020-06-27', 'Capixaba', 52.25);
INSERT INTO pacto.isolamentosocial VALUES (4733, '2020-06-28', 'Capixaba', 58.10);
INSERT INTO pacto.isolamentosocial VALUES (4734, '2020-06-29', 'Capixaba', 47.93);
INSERT INTO pacto.isolamentosocial VALUES (4735, '2020-06-30', 'Capixaba', 38.94);
INSERT INTO pacto.isolamentosocial VALUES (4736, '2020-07-01', 'Capixaba', 45.45);
INSERT INTO pacto.isolamentosocial VALUES (4737, '2020-07-02', 'Capixaba', 37.40);
INSERT INTO pacto.isolamentosocial VALUES (4738, '2020-07-03', 'Capixaba', 42.74);
INSERT INTO pacto.isolamentosocial VALUES (4739, '2020-02-01', 'Cruzeiro do Sul', 32.12);
INSERT INTO pacto.isolamentosocial VALUES (4740, '2020-02-02', 'Cruzeiro do Sul', 43.52);
INSERT INTO pacto.isolamentosocial VALUES (4741, '2020-02-03', 'Cruzeiro do Sul', 34.72);
INSERT INTO pacto.isolamentosocial VALUES (4742, '2020-02-04', 'Cruzeiro do Sul', 30.63);
INSERT INTO pacto.isolamentosocial VALUES (4743, '2020-02-05', 'Cruzeiro do Sul', 29.90);
INSERT INTO pacto.isolamentosocial VALUES (4744, '2020-02-06', 'Cruzeiro do Sul', 30.09);
INSERT INTO pacto.isolamentosocial VALUES (4745, '2020-02-07', 'Cruzeiro do Sul', 29.66);
INSERT INTO pacto.isolamentosocial VALUES (4746, '2020-02-08', 'Cruzeiro do Sul', 33.10);
INSERT INTO pacto.isolamentosocial VALUES (4747, '2020-02-09', 'Cruzeiro do Sul', 38.41);
INSERT INTO pacto.isolamentosocial VALUES (4748, '2020-02-10', 'Cruzeiro do Sul', 23.79);
INSERT INTO pacto.isolamentosocial VALUES (4749, '2020-02-11', 'Cruzeiro do Sul', 27.80);
INSERT INTO pacto.isolamentosocial VALUES (4751, '2020-02-13', 'Cruzeiro do Sul', 29.69);
INSERT INTO pacto.isolamentosocial VALUES (4752, '2020-02-14', 'Cruzeiro do Sul', 27.62);
INSERT INTO pacto.isolamentosocial VALUES (4753, '2020-02-15', 'Cruzeiro do Sul', 32.99);
INSERT INTO pacto.isolamentosocial VALUES (4754, '2020-02-16', 'Cruzeiro do Sul', 42.54);
INSERT INTO pacto.isolamentosocial VALUES (4755, '2020-02-17', 'Cruzeiro do Sul', 22.94);
INSERT INTO pacto.isolamentosocial VALUES (4756, '2020-02-18', 'Cruzeiro do Sul', 30.18);
INSERT INTO pacto.isolamentosocial VALUES (4757, '2020-02-19', 'Cruzeiro do Sul', 33.28);
INSERT INTO pacto.isolamentosocial VALUES (4758, '2020-02-20', 'Cruzeiro do Sul', 28.26);
INSERT INTO pacto.isolamentosocial VALUES (4759, '2020-02-21', 'Cruzeiro do Sul', 27.52);
INSERT INTO pacto.isolamentosocial VALUES (4760, '2020-02-22', 'Cruzeiro do Sul', 37.03);
INSERT INTO pacto.isolamentosocial VALUES (4761, '2020-02-23', 'Cruzeiro do Sul', 40.92);
INSERT INTO pacto.isolamentosocial VALUES (4762, '2020-02-24', 'Cruzeiro do Sul', 32.25);
INSERT INTO pacto.isolamentosocial VALUES (4763, '2020-02-25', 'Cruzeiro do Sul', 42.96);
INSERT INTO pacto.isolamentosocial VALUES (4764, '2020-02-26', 'Cruzeiro do Sul', 33.39);
INSERT INTO pacto.isolamentosocial VALUES (4765, '2020-02-27', 'Cruzeiro do Sul', 31.41);
INSERT INTO pacto.isolamentosocial VALUES (4766, '2020-02-28', 'Cruzeiro do Sul', 30.19);
INSERT INTO pacto.isolamentosocial VALUES (4767, '2020-02-29', 'Cruzeiro do Sul', 31.06);
INSERT INTO pacto.isolamentosocial VALUES (4768, '2020-03-01', 'Cruzeiro do Sul', 42.50);
INSERT INTO pacto.isolamentosocial VALUES (4769, '2020-03-02', 'Cruzeiro do Sul', 26.71);
INSERT INTO pacto.isolamentosocial VALUES (4770, '2020-03-03', 'Cruzeiro do Sul', 31.29);
INSERT INTO pacto.isolamentosocial VALUES (4771, '2020-03-04', 'Cruzeiro do Sul', 32.51);
INSERT INTO pacto.isolamentosocial VALUES (4772, '2020-03-05', 'Cruzeiro do Sul', 31.43);
INSERT INTO pacto.isolamentosocial VALUES (4773, '2020-03-06', 'Cruzeiro do Sul', 29.23);
INSERT INTO pacto.isolamentosocial VALUES (4774, '2020-03-07', 'Cruzeiro do Sul', 36.15);
INSERT INTO pacto.isolamentosocial VALUES (4775, '2020-03-08', 'Cruzeiro do Sul', 44.11);
INSERT INTO pacto.isolamentosocial VALUES (4776, '2020-03-09', 'Cruzeiro do Sul', 29.57);
INSERT INTO pacto.isolamentosocial VALUES (4777, '2020-03-10', 'Cruzeiro do Sul', 29.97);
INSERT INTO pacto.isolamentosocial VALUES (4778, '2020-03-11', 'Cruzeiro do Sul', 31.21);
INSERT INTO pacto.isolamentosocial VALUES (4779, '2020-03-12', 'Cruzeiro do Sul', 32.23);
INSERT INTO pacto.isolamentosocial VALUES (4780, '2020-03-13', 'Cruzeiro do Sul', 33.10);
INSERT INTO pacto.isolamentosocial VALUES (4781, '2020-03-14', 'Cruzeiro do Sul', 38.66);
INSERT INTO pacto.isolamentosocial VALUES (4782, '2020-03-15', 'Cruzeiro do Sul', 44.11);
INSERT INTO pacto.isolamentosocial VALUES (4783, '2020-03-16', 'Cruzeiro do Sul', 25.41);
INSERT INTO pacto.isolamentosocial VALUES (4784, '2020-03-17', 'Cruzeiro do Sul', 30.41);
INSERT INTO pacto.isolamentosocial VALUES (4785, '2020-03-18', 'Cruzeiro do Sul', 35.01);
INSERT INTO pacto.isolamentosocial VALUES (4786, '2020-03-19', 'Cruzeiro do Sul', 40.96);
INSERT INTO pacto.isolamentosocial VALUES (4787, '2020-03-20', 'Cruzeiro do Sul', 42.63);
INSERT INTO pacto.isolamentosocial VALUES (4788, '2020-03-21', 'Cruzeiro do Sul', 50.33);
INSERT INTO pacto.isolamentosocial VALUES (4789, '2020-03-22', 'Cruzeiro do Sul', 58.24);
INSERT INTO pacto.isolamentosocial VALUES (4790, '2020-03-23', 'Cruzeiro do Sul', 48.36);
INSERT INTO pacto.isolamentosocial VALUES (4791, '2020-03-24', 'Cruzeiro do Sul', 52.08);
INSERT INTO pacto.isolamentosocial VALUES (4792, '2020-03-25', 'Cruzeiro do Sul', 52.24);
INSERT INTO pacto.isolamentosocial VALUES (4793, '2020-03-26', 'Cruzeiro do Sul', 49.82);
INSERT INTO pacto.isolamentosocial VALUES (4794, '2020-03-27', 'Cruzeiro do Sul', 46.84);
INSERT INTO pacto.isolamentosocial VALUES (4795, '2020-03-28', 'Cruzeiro do Sul', 48.04);
INSERT INTO pacto.isolamentosocial VALUES (4796, '2020-03-29', 'Cruzeiro do Sul', 57.14);
INSERT INTO pacto.isolamentosocial VALUES (4797, '2020-03-30', 'Cruzeiro do Sul', 46.59);
INSERT INTO pacto.isolamentosocial VALUES (4798, '2020-03-31', 'Cruzeiro do Sul', 47.32);
INSERT INTO pacto.isolamentosocial VALUES (4799, '2020-04-01', 'Cruzeiro do Sul', 48.68);
INSERT INTO pacto.isolamentosocial VALUES (4800, '2020-04-02', 'Cruzeiro do Sul', 46.99);
INSERT INTO pacto.isolamentosocial VALUES (4801, '2020-04-03', 'Cruzeiro do Sul', 47.91);
INSERT INTO pacto.isolamentosocial VALUES (4802, '2020-04-04', 'Cruzeiro do Sul', 44.81);
INSERT INTO pacto.isolamentosocial VALUES (4803, '2020-04-05', 'Cruzeiro do Sul', 52.68);
INSERT INTO pacto.isolamentosocial VALUES (4804, '2020-04-06', 'Cruzeiro do Sul', 44.78);
INSERT INTO pacto.isolamentosocial VALUES (4805, '2020-04-07', 'Cruzeiro do Sul', 50.09);
INSERT INTO pacto.isolamentosocial VALUES (4806, '2020-04-08', 'Cruzeiro do Sul', 45.07);
INSERT INTO pacto.isolamentosocial VALUES (4807, '2020-04-09', 'Cruzeiro do Sul', 45.13);
INSERT INTO pacto.isolamentosocial VALUES (4808, '2020-04-10', 'Cruzeiro do Sul', 50.37);
INSERT INTO pacto.isolamentosocial VALUES (4809, '2020-04-11', 'Cruzeiro do Sul', 45.05);
INSERT INTO pacto.isolamentosocial VALUES (4810, '2020-04-12', 'Cruzeiro do Sul', 52.52);
INSERT INTO pacto.isolamentosocial VALUES (4811, '2020-04-13', 'Cruzeiro do Sul', 42.61);
INSERT INTO pacto.isolamentosocial VALUES (4812, '2020-04-14', 'Cruzeiro do Sul', 48.56);
INSERT INTO pacto.isolamentosocial VALUES (4813, '2020-04-15', 'Cruzeiro do Sul', 47.14);
INSERT INTO pacto.isolamentosocial VALUES (4814, '2020-04-16', 'Cruzeiro do Sul', 45.17);
INSERT INTO pacto.isolamentosocial VALUES (4815, '2020-04-17', 'Cruzeiro do Sul', 45.59);
INSERT INTO pacto.isolamentosocial VALUES (4816, '2020-04-18', 'Cruzeiro do Sul', 47.07);
INSERT INTO pacto.isolamentosocial VALUES (4817, '2020-04-19', 'Cruzeiro do Sul', 56.34);
INSERT INTO pacto.isolamentosocial VALUES (4818, '2020-04-20', 'Cruzeiro do Sul', 50.36);
INSERT INTO pacto.isolamentosocial VALUES (4819, '2020-04-21', 'Cruzeiro do Sul', 57.76);
INSERT INTO pacto.isolamentosocial VALUES (4820, '2020-04-22', 'Cruzeiro do Sul', 47.67);
INSERT INTO pacto.isolamentosocial VALUES (4821, '2020-04-23', 'Cruzeiro do Sul', 45.66);
INSERT INTO pacto.isolamentosocial VALUES (4822, '2020-04-24', 'Cruzeiro do Sul', 43.56);
INSERT INTO pacto.isolamentosocial VALUES (4823, '2020-04-25', 'Cruzeiro do Sul', 45.56);
INSERT INTO pacto.isolamentosocial VALUES (4824, '2020-04-26', 'Cruzeiro do Sul', 56.64);
INSERT INTO pacto.isolamentosocial VALUES (4825, '2020-04-27', 'Cruzeiro do Sul', 45.90);
INSERT INTO pacto.isolamentosocial VALUES (4826, '2020-04-28', 'Cruzeiro do Sul', 45.88);
INSERT INTO pacto.isolamentosocial VALUES (4827, '2020-04-29', 'Cruzeiro do Sul', 45.67);
INSERT INTO pacto.isolamentosocial VALUES (4828, '2020-04-30', 'Cruzeiro do Sul', 43.71);
INSERT INTO pacto.isolamentosocial VALUES (4829, '2020-05-01', 'Cruzeiro do Sul', 48.25);
INSERT INTO pacto.isolamentosocial VALUES (4830, '2020-05-02', 'Cruzeiro do Sul', 46.45);
INSERT INTO pacto.isolamentosocial VALUES (4831, '2020-05-03', 'Cruzeiro do Sul', 57.85);
INSERT INTO pacto.isolamentosocial VALUES (4832, '2020-05-04', 'Cruzeiro do Sul', 47.58);
INSERT INTO pacto.isolamentosocial VALUES (4833, '2020-05-05', 'Cruzeiro do Sul', 44.74);
INSERT INTO pacto.isolamentosocial VALUES (4834, '2020-05-06', 'Cruzeiro do Sul', 71.83);
INSERT INTO pacto.isolamentosocial VALUES (4835, '2020-05-07', 'Cruzeiro do Sul', 50.74);
INSERT INTO pacto.isolamentosocial VALUES (4836, '2020-05-08', 'Cruzeiro do Sul', 47.01);
INSERT INTO pacto.isolamentosocial VALUES (4837, '2020-05-09', 'Cruzeiro do Sul', 48.32);
INSERT INTO pacto.isolamentosocial VALUES (4838, '2020-05-10', 'Cruzeiro do Sul', 53.85);
INSERT INTO pacto.isolamentosocial VALUES (4839, '2020-05-11', 'Cruzeiro do Sul', 49.13);
INSERT INTO pacto.isolamentosocial VALUES (4840, '2020-05-12', 'Cruzeiro do Sul', 51.97);
INSERT INTO pacto.isolamentosocial VALUES (4841, '2020-05-13', 'Cruzeiro do Sul', 55.17);
INSERT INTO pacto.isolamentosocial VALUES (4842, '2020-05-14', 'Cruzeiro do Sul', 51.76);
INSERT INTO pacto.isolamentosocial VALUES (4843, '2020-05-15', 'Cruzeiro do Sul', 49.19);
INSERT INTO pacto.isolamentosocial VALUES (4844, '2020-05-16', 'Cruzeiro do Sul', 52.13);
INSERT INTO pacto.isolamentosocial VALUES (4845, '2020-05-17', 'Cruzeiro do Sul', 57.31);
INSERT INTO pacto.isolamentosocial VALUES (4846, '2020-05-18', 'Cruzeiro do Sul', 47.56);
INSERT INTO pacto.isolamentosocial VALUES (4847, '2020-05-19', 'Cruzeiro do Sul', 48.36);
INSERT INTO pacto.isolamentosocial VALUES (4848, '2020-05-20', 'Cruzeiro do Sul', 52.16);
INSERT INTO pacto.isolamentosocial VALUES (4849, '2020-05-21', 'Cruzeiro do Sul', 54.48);
INSERT INTO pacto.isolamentosocial VALUES (4850, '2020-05-22', 'Cruzeiro do Sul', 51.30);
INSERT INTO pacto.isolamentosocial VALUES (4851, '2020-05-23', 'Cruzeiro do Sul', 57.17);
INSERT INTO pacto.isolamentosocial VALUES (4852, '2020-05-24', 'Cruzeiro do Sul', 61.92);
INSERT INTO pacto.isolamentosocial VALUES (4853, '2020-05-25', 'Cruzeiro do Sul', 53.63);
INSERT INTO pacto.isolamentosocial VALUES (4854, '2020-05-26', 'Cruzeiro do Sul', 48.33);
INSERT INTO pacto.isolamentosocial VALUES (4855, '2020-05-27', 'Cruzeiro do Sul', 47.28);
INSERT INTO pacto.isolamentosocial VALUES (4856, '2020-05-28', 'Cruzeiro do Sul', 51.39);
INSERT INTO pacto.isolamentosocial VALUES (4857, '2020-05-29', 'Cruzeiro do Sul', 46.19);
INSERT INTO pacto.isolamentosocial VALUES (4858, '2020-05-30', 'Cruzeiro do Sul', 51.82);
INSERT INTO pacto.isolamentosocial VALUES (4859, '2020-05-31', 'Cruzeiro do Sul', 55.77);
INSERT INTO pacto.isolamentosocial VALUES (4860, '2020-06-01', 'Cruzeiro do Sul', 44.44);
INSERT INTO pacto.isolamentosocial VALUES (4861, '2020-06-02', 'Cruzeiro do Sul', 47.65);
INSERT INTO pacto.isolamentosocial VALUES (4862, '2020-06-03', 'Cruzeiro do Sul', 53.25);
INSERT INTO pacto.isolamentosocial VALUES (4863, '2020-06-04', 'Cruzeiro do Sul', 45.52);
INSERT INTO pacto.isolamentosocial VALUES (4864, '2020-06-05', 'Cruzeiro do Sul', 45.01);
INSERT INTO pacto.isolamentosocial VALUES (4865, '2020-06-06', 'Cruzeiro do Sul', 48.51);
INSERT INTO pacto.isolamentosocial VALUES (4866, '2020-06-07', 'Cruzeiro do Sul', 56.85);
INSERT INTO pacto.isolamentosocial VALUES (4867, '2020-06-08', 'Cruzeiro do Sul', 44.55);
INSERT INTO pacto.isolamentosocial VALUES (4868, '2020-06-09', 'Cruzeiro do Sul', 43.96);
INSERT INTO pacto.isolamentosocial VALUES (4869, '2020-06-10', 'Cruzeiro do Sul', 46.68);
INSERT INTO pacto.isolamentosocial VALUES (4870, '2020-06-11', 'Cruzeiro do Sul', 51.94);
INSERT INTO pacto.isolamentosocial VALUES (4871, '2020-06-12', 'Cruzeiro do Sul', 45.79);
INSERT INTO pacto.isolamentosocial VALUES (4872, '2020-06-13', 'Cruzeiro do Sul', 44.83);
INSERT INTO pacto.isolamentosocial VALUES (4873, '2020-06-14', 'Cruzeiro do Sul', 55.81);
INSERT INTO pacto.isolamentosocial VALUES (4874, '2020-06-15', 'Cruzeiro do Sul', 46.01);
INSERT INTO pacto.isolamentosocial VALUES (4875, '2020-06-16', 'Cruzeiro do Sul', 43.49);
INSERT INTO pacto.isolamentosocial VALUES (4876, '2020-06-17', 'Cruzeiro do Sul', 45.25);
INSERT INTO pacto.isolamentosocial VALUES (4877, '2020-06-18', 'Cruzeiro do Sul', 45.00);
INSERT INTO pacto.isolamentosocial VALUES (4878, '2020-06-19', 'Cruzeiro do Sul', 39.66);
INSERT INTO pacto.isolamentosocial VALUES (4879, '2020-06-20', 'Cruzeiro do Sul', 49.48);
INSERT INTO pacto.isolamentosocial VALUES (4880, '2020-06-21', 'Cruzeiro do Sul', 53.90);
INSERT INTO pacto.isolamentosocial VALUES (4881, '2020-06-22', 'Cruzeiro do Sul', 45.78);
INSERT INTO pacto.isolamentosocial VALUES (4882, '2020-06-23', 'Cruzeiro do Sul', 40.85);
INSERT INTO pacto.isolamentosocial VALUES (4883, '2020-06-24', 'Cruzeiro do Sul', 43.71);
INSERT INTO pacto.isolamentosocial VALUES (4884, '2020-06-25', 'Cruzeiro do Sul', 40.96);
INSERT INTO pacto.isolamentosocial VALUES (4885, '2020-06-26', 'Cruzeiro do Sul', 43.04);
INSERT INTO pacto.isolamentosocial VALUES (4886, '2020-06-27', 'Cruzeiro do Sul', 47.19);
INSERT INTO pacto.isolamentosocial VALUES (4887, '2020-06-28', 'Cruzeiro do Sul', 55.87);
INSERT INTO pacto.isolamentosocial VALUES (4888, '2020-06-29', 'Cruzeiro do Sul', 42.91);
INSERT INTO pacto.isolamentosocial VALUES (4889, '2020-06-30', 'Cruzeiro do Sul', 43.85);
INSERT INTO pacto.isolamentosocial VALUES (4890, '2020-07-01', 'Cruzeiro do Sul', 45.62);
INSERT INTO pacto.isolamentosocial VALUES (4891, '2020-07-02', 'Cruzeiro do Sul', 43.58);
INSERT INTO pacto.isolamentosocial VALUES (4892, '2020-07-03', 'Cruzeiro do Sul', 40.19);
INSERT INTO pacto.isolamentosocial VALUES (4893, '2020-02-01', 'Epitaciolândia', 38.31);
INSERT INTO pacto.isolamentosocial VALUES (4894, '2020-02-02', 'Epitaciolândia', 41.78);
INSERT INTO pacto.isolamentosocial VALUES (4895, '2020-02-03', 'Epitaciolândia', 25.00);
INSERT INTO pacto.isolamentosocial VALUES (4896, '2020-02-04', 'Epitaciolândia', 27.52);
INSERT INTO pacto.isolamentosocial VALUES (4897, '2020-02-05', 'Epitaciolândia', 28.18);
INSERT INTO pacto.isolamentosocial VALUES (4898, '2020-02-06', 'Epitaciolândia', 27.36);
INSERT INTO pacto.isolamentosocial VALUES (4899, '2020-02-07', 'Epitaciolândia', 23.32);
INSERT INTO pacto.isolamentosocial VALUES (4900, '2020-02-08', 'Epitaciolândia', 30.98);
INSERT INTO pacto.isolamentosocial VALUES (4901, '2020-02-09', 'Epitaciolândia', 35.71);
INSERT INTO pacto.isolamentosocial VALUES (4902, '2020-02-10', 'Epitaciolândia', 24.00);
INSERT INTO pacto.isolamentosocial VALUES (4903, '2020-02-11', 'Epitaciolândia', 22.86);
INSERT INTO pacto.isolamentosocial VALUES (4904, '2020-02-12', 'Epitaciolândia', 28.71);
INSERT INTO pacto.isolamentosocial VALUES (4905, '2020-02-13', 'Epitaciolândia', 24.77);
INSERT INTO pacto.isolamentosocial VALUES (4906, '2020-02-14', 'Epitaciolândia', 35.38);
INSERT INTO pacto.isolamentosocial VALUES (4907, '2020-02-15', 'Epitaciolândia', 30.43);
INSERT INTO pacto.isolamentosocial VALUES (4908, '2020-02-16', 'Epitaciolândia', 42.92);
INSERT INTO pacto.isolamentosocial VALUES (6776, '2020-07-06', 'Capixaba', 43.48);
INSERT INTO pacto.isolamentosocial VALUES (4909, '2020-02-17', 'Epitaciolândia', 27.36);
INSERT INTO pacto.isolamentosocial VALUES (4910, '2020-02-18', 'Epitaciolândia', 31.16);
INSERT INTO pacto.isolamentosocial VALUES (4911, '2020-02-19', 'Epitaciolândia', 35.75);
INSERT INTO pacto.isolamentosocial VALUES (4912, '2020-02-20', 'Epitaciolândia', 34.78);
INSERT INTO pacto.isolamentosocial VALUES (4913, '2020-02-21', 'Epitaciolândia', 28.00);
INSERT INTO pacto.isolamentosocial VALUES (4914, '2020-02-22', 'Epitaciolândia', 33.80);
INSERT INTO pacto.isolamentosocial VALUES (4915, '2020-02-23', 'Epitaciolândia', 34.47);
INSERT INTO pacto.isolamentosocial VALUES (4916, '2020-02-24', 'Epitaciolândia', 39.71);
INSERT INTO pacto.isolamentosocial VALUES (4917, '2020-02-25', 'Epitaciolândia', 42.44);
INSERT INTO pacto.isolamentosocial VALUES (4918, '2020-02-26', 'Epitaciolândia', 30.93);
INSERT INTO pacto.isolamentosocial VALUES (4919, '2020-02-27', 'Epitaciolândia', 29.20);
INSERT INTO pacto.isolamentosocial VALUES (4920, '2020-02-28', 'Epitaciolândia', 36.12);
INSERT INTO pacto.isolamentosocial VALUES (4921, '2020-02-29', 'Epitaciolândia', 35.78);
INSERT INTO pacto.isolamentosocial VALUES (4922, '2020-03-01', 'Epitaciolândia', 42.86);
INSERT INTO pacto.isolamentosocial VALUES (4923, '2020-03-02', 'Epitaciolândia', 30.63);
INSERT INTO pacto.isolamentosocial VALUES (4924, '2020-03-03', 'Epitaciolândia', 30.70);
INSERT INTO pacto.isolamentosocial VALUES (4925, '2020-03-04', 'Epitaciolândia', 32.93);
INSERT INTO pacto.isolamentosocial VALUES (4926, '2020-03-05', 'Epitaciolândia', 41.32);
INSERT INTO pacto.isolamentosocial VALUES (4927, '2020-03-06', 'Epitaciolândia', 36.40);
INSERT INTO pacto.isolamentosocial VALUES (4928, '2020-03-07', 'Epitaciolândia', 38.89);
INSERT INTO pacto.isolamentosocial VALUES (4929, '2020-03-08', 'Epitaciolândia', 48.54);
INSERT INTO pacto.isolamentosocial VALUES (4930, '2020-03-09', 'Epitaciolândia', 38.40);
INSERT INTO pacto.isolamentosocial VALUES (4931, '2020-03-10', 'Epitaciolândia', 39.08);
INSERT INTO pacto.isolamentosocial VALUES (4932, '2020-03-11', 'Epitaciolândia', 39.06);
INSERT INTO pacto.isolamentosocial VALUES (4933, '2020-03-12', 'Epitaciolândia', 31.15);
INSERT INTO pacto.isolamentosocial VALUES (4934, '2020-03-13', 'Epitaciolândia', 41.91);
INSERT INTO pacto.isolamentosocial VALUES (4935, '2020-03-14', 'Epitaciolândia', 45.20);
INSERT INTO pacto.isolamentosocial VALUES (4936, '2020-03-15', 'Epitaciolândia', 42.74);
INSERT INTO pacto.isolamentosocial VALUES (4937, '2020-03-16', 'Epitaciolândia', 38.46);
INSERT INTO pacto.isolamentosocial VALUES (4938, '2020-03-17', 'Epitaciolândia', 39.83);
INSERT INTO pacto.isolamentosocial VALUES (4939, '2020-03-18', 'Epitaciolândia', 40.95);
INSERT INTO pacto.isolamentosocial VALUES (4940, '2020-03-19', 'Epitaciolândia', 48.65);
INSERT INTO pacto.isolamentosocial VALUES (4941, '2020-03-20', 'Epitaciolândia', 41.33);
INSERT INTO pacto.isolamentosocial VALUES (4942, '2020-03-21', 'Epitaciolândia', 50.45);
INSERT INTO pacto.isolamentosocial VALUES (4943, '2020-03-22', 'Epitaciolândia', 62.22);
INSERT INTO pacto.isolamentosocial VALUES (4944, '2020-03-23', 'Epitaciolândia', 48.89);
INSERT INTO pacto.isolamentosocial VALUES (4945, '2020-03-24', 'Epitaciolândia', 54.42);
INSERT INTO pacto.isolamentosocial VALUES (4946, '2020-03-25', 'Epitaciolândia', 52.75);
INSERT INTO pacto.isolamentosocial VALUES (4947, '2020-03-26', 'Epitaciolândia', 56.33);
INSERT INTO pacto.isolamentosocial VALUES (4948, '2020-03-27', 'Epitaciolândia', 51.85);
INSERT INTO pacto.isolamentosocial VALUES (4949, '2020-03-28', 'Epitaciolândia', 60.09);
INSERT INTO pacto.isolamentosocial VALUES (4950, '2020-03-29', 'Epitaciolândia', 61.90);
INSERT INTO pacto.isolamentosocial VALUES (4951, '2020-03-30', 'Epitaciolândia', 48.08);
INSERT INTO pacto.isolamentosocial VALUES (4952, '2020-03-31', 'Epitaciolândia', 46.93);
INSERT INTO pacto.isolamentosocial VALUES (4953, '2020-04-01', 'Epitaciolândia', 45.16);
INSERT INTO pacto.isolamentosocial VALUES (4954, '2020-04-02', 'Epitaciolândia', 48.93);
INSERT INTO pacto.isolamentosocial VALUES (4955, '2020-04-03', 'Epitaciolândia', 49.29);
INSERT INTO pacto.isolamentosocial VALUES (4956, '2020-04-04', 'Epitaciolândia', 57.14);
INSERT INTO pacto.isolamentosocial VALUES (4957, '2020-04-05', 'Epitaciolândia', 58.13);
INSERT INTO pacto.isolamentosocial VALUES (4958, '2020-04-06', 'Epitaciolândia', 45.73);
INSERT INTO pacto.isolamentosocial VALUES (4959, '2020-04-07', 'Epitaciolândia', 45.53);
INSERT INTO pacto.isolamentosocial VALUES (4960, '2020-04-08', 'Epitaciolândia', 50.00);
INSERT INTO pacto.isolamentosocial VALUES (4961, '2020-04-09', 'Epitaciolândia', 45.76);
INSERT INTO pacto.isolamentosocial VALUES (4962, '2020-04-10', 'Epitaciolândia', 54.33);
INSERT INTO pacto.isolamentosocial VALUES (4963, '2020-04-11', 'Epitaciolândia', 45.71);
INSERT INTO pacto.isolamentosocial VALUES (4964, '2020-04-12', 'Epitaciolândia', 49.27);
INSERT INTO pacto.isolamentosocial VALUES (4965, '2020-04-13', 'Epitaciolândia', 42.20);
INSERT INTO pacto.isolamentosocial VALUES (4966, '2020-04-14', 'Epitaciolândia', 46.12);
INSERT INTO pacto.isolamentosocial VALUES (4967, '2020-04-15', 'Epitaciolândia', 50.00);
INSERT INTO pacto.isolamentosocial VALUES (4968, '2020-04-16', 'Epitaciolândia', 41.18);
INSERT INTO pacto.isolamentosocial VALUES (4969, '2020-04-17', 'Epitaciolândia', 46.22);
INSERT INTO pacto.isolamentosocial VALUES (4970, '2020-04-18', 'Epitaciolândia', 42.86);
INSERT INTO pacto.isolamentosocial VALUES (4971, '2020-04-19', 'Epitaciolândia', 54.26);
INSERT INTO pacto.isolamentosocial VALUES (4972, '2020-04-20', 'Epitaciolândia', 41.15);
INSERT INTO pacto.isolamentosocial VALUES (4973, '2020-04-21', 'Epitaciolândia', 46.26);
INSERT INTO pacto.isolamentosocial VALUES (4974, '2020-04-22', 'Epitaciolândia', 39.81);
INSERT INTO pacto.isolamentosocial VALUES (4975, '2020-04-23', 'Epitaciolândia', 43.06);
INSERT INTO pacto.isolamentosocial VALUES (4976, '2020-04-24', 'Epitaciolândia', 42.27);
INSERT INTO pacto.isolamentosocial VALUES (4977, '2020-04-25', 'Epitaciolândia', 45.41);
INSERT INTO pacto.isolamentosocial VALUES (4978, '2020-04-26', 'Epitaciolândia', 44.90);
INSERT INTO pacto.isolamentosocial VALUES (4979, '2020-04-27', 'Epitaciolândia', 36.05);
INSERT INTO pacto.isolamentosocial VALUES (4980, '2020-04-28', 'Epitaciolândia', 41.56);
INSERT INTO pacto.isolamentosocial VALUES (4981, '2020-04-29', 'Epitaciolândia', 37.39);
INSERT INTO pacto.isolamentosocial VALUES (4982, '2020-04-30', 'Epitaciolândia', 40.65);
INSERT INTO pacto.isolamentosocial VALUES (4983, '2020-05-01', 'Epitaciolândia', 46.33);
INSERT INTO pacto.isolamentosocial VALUES (4984, '2020-05-02', 'Epitaciolândia', 41.81);
INSERT INTO pacto.isolamentosocial VALUES (4985, '2020-05-03', 'Epitaciolândia', 49.35);
INSERT INTO pacto.isolamentosocial VALUES (4986, '2020-05-04', 'Epitaciolândia', 35.56);
INSERT INTO pacto.isolamentosocial VALUES (4987, '2020-05-05', 'Epitaciolândia', 37.39);
INSERT INTO pacto.isolamentosocial VALUES (4988, '2020-05-06', 'Epitaciolândia', 45.70);
INSERT INTO pacto.isolamentosocial VALUES (4989, '2020-05-07', 'Epitaciolândia', 43.67);
INSERT INTO pacto.isolamentosocial VALUES (4990, '2020-05-08', 'Epitaciolândia', 44.27);
INSERT INTO pacto.isolamentosocial VALUES (4991, '2020-05-09', 'Epitaciolândia', 45.34);
INSERT INTO pacto.isolamentosocial VALUES (4992, '2020-05-10', 'Epitaciolândia', 50.82);
INSERT INTO pacto.isolamentosocial VALUES (4993, '2020-05-11', 'Epitaciolândia', 46.22);
INSERT INTO pacto.isolamentosocial VALUES (4994, '2020-05-12', 'Epitaciolândia', 42.26);
INSERT INTO pacto.isolamentosocial VALUES (4995, '2020-05-13', 'Epitaciolândia', 39.64);
INSERT INTO pacto.isolamentosocial VALUES (4996, '2020-05-14', 'Epitaciolândia', 48.06);
INSERT INTO pacto.isolamentosocial VALUES (4997, '2020-05-15', 'Epitaciolândia', 46.89);
INSERT INTO pacto.isolamentosocial VALUES (4998, '2020-05-16', 'Epitaciolândia', 46.95);
INSERT INTO pacto.isolamentosocial VALUES (4999, '2020-05-17', 'Epitaciolândia', 57.96);
INSERT INTO pacto.isolamentosocial VALUES (5000, '2020-05-18', 'Epitaciolândia', 44.15);
INSERT INTO pacto.isolamentosocial VALUES (5001, '2020-05-19', 'Epitaciolândia', 42.06);
INSERT INTO pacto.isolamentosocial VALUES (5002, '2020-05-20', 'Epitaciolândia', 43.48);
INSERT INTO pacto.isolamentosocial VALUES (5003, '2020-05-21', 'Epitaciolândia', 43.36);
INSERT INTO pacto.isolamentosocial VALUES (5004, '2020-05-22', 'Epitaciolândia', 46.06);
INSERT INTO pacto.isolamentosocial VALUES (5005, '2020-05-23', 'Epitaciolândia', 49.21);
INSERT INTO pacto.isolamentosocial VALUES (5006, '2020-05-24', 'Epitaciolândia', 58.93);
INSERT INTO pacto.isolamentosocial VALUES (5007, '2020-05-25', 'Epitaciolândia', 44.35);
INSERT INTO pacto.isolamentosocial VALUES (5008, '2020-05-26', 'Epitaciolândia', 46.61);
INSERT INTO pacto.isolamentosocial VALUES (5009, '2020-05-27', 'Epitaciolândia', 50.97);
INSERT INTO pacto.isolamentosocial VALUES (5010, '2020-05-28', 'Epitaciolândia', 52.00);
INSERT INTO pacto.isolamentosocial VALUES (5011, '2020-05-29', 'Epitaciolândia', 41.31);
INSERT INTO pacto.isolamentosocial VALUES (5012, '2020-05-30', 'Epitaciolândia', 49.34);
INSERT INTO pacto.isolamentosocial VALUES (5013, '2020-05-31', 'Epitaciolândia', 56.14);
INSERT INTO pacto.isolamentosocial VALUES (5014, '2020-06-01', 'Epitaciolândia', 42.44);
INSERT INTO pacto.isolamentosocial VALUES (5015, '2020-06-02', 'Epitaciolândia', 43.93);
INSERT INTO pacto.isolamentosocial VALUES (5016, '2020-06-03', 'Epitaciolândia', 43.69);
INSERT INTO pacto.isolamentosocial VALUES (5017, '2020-06-04', 'Epitaciolândia', 42.11);
INSERT INTO pacto.isolamentosocial VALUES (5018, '2020-06-05', 'Epitaciolândia', 47.49);
INSERT INTO pacto.isolamentosocial VALUES (5019, '2020-06-06', 'Epitaciolândia', 43.17);
INSERT INTO pacto.isolamentosocial VALUES (5020, '2020-06-07', 'Epitaciolândia', 52.54);
INSERT INTO pacto.isolamentosocial VALUES (5021, '2020-06-08', 'Epitaciolândia', 35.36);
INSERT INTO pacto.isolamentosocial VALUES (5022, '2020-06-09', 'Epitaciolândia', 42.80);
INSERT INTO pacto.isolamentosocial VALUES (5023, '2020-06-10', 'Epitaciolândia', 43.87);
INSERT INTO pacto.isolamentosocial VALUES (5024, '2020-06-11', 'Epitaciolândia', 43.82);
INSERT INTO pacto.isolamentosocial VALUES (5025, '2020-06-12', 'Epitaciolândia', 42.29);
INSERT INTO pacto.isolamentosocial VALUES (5026, '2020-06-13', 'Epitaciolândia', 42.80);
INSERT INTO pacto.isolamentosocial VALUES (5027, '2020-06-14', 'Epitaciolândia', 53.33);
INSERT INTO pacto.isolamentosocial VALUES (5028, '2020-06-15', 'Epitaciolândia', 44.76);
INSERT INTO pacto.isolamentosocial VALUES (5029, '2020-06-16', 'Epitaciolândia', 42.86);
INSERT INTO pacto.isolamentosocial VALUES (5030, '2020-06-17', 'Epitaciolândia', 41.73);
INSERT INTO pacto.isolamentosocial VALUES (5031, '2020-06-18', 'Epitaciolândia', 46.56);
INSERT INTO pacto.isolamentosocial VALUES (5032, '2020-06-19', 'Epitaciolândia', 43.51);
INSERT INTO pacto.isolamentosocial VALUES (5033, '2020-06-20', 'Epitaciolândia', 43.44);
INSERT INTO pacto.isolamentosocial VALUES (5034, '2020-06-21', 'Epitaciolândia', 48.48);
INSERT INTO pacto.isolamentosocial VALUES (5035, '2020-06-22', 'Epitaciolândia', 42.39);
INSERT INTO pacto.isolamentosocial VALUES (5036, '2020-06-23', 'Epitaciolândia', 44.85);
INSERT INTO pacto.isolamentosocial VALUES (5037, '2020-06-24', 'Epitaciolândia', 38.02);
INSERT INTO pacto.isolamentosocial VALUES (5038, '2020-06-25', 'Epitaciolândia', 44.06);
INSERT INTO pacto.isolamentosocial VALUES (5039, '2020-06-26', 'Epitaciolândia', 35.95);
INSERT INTO pacto.isolamentosocial VALUES (5040, '2020-06-27', 'Epitaciolândia', 40.77);
INSERT INTO pacto.isolamentosocial VALUES (5041, '2020-06-28', 'Epitaciolândia', 59.16);
INSERT INTO pacto.isolamentosocial VALUES (5042, '2020-06-29', 'Epitaciolândia', 40.15);
INSERT INTO pacto.isolamentosocial VALUES (5043, '2020-06-30', 'Epitaciolândia', 43.27);
INSERT INTO pacto.isolamentosocial VALUES (5044, '2020-07-01', 'Epitaciolândia', 41.32);
INSERT INTO pacto.isolamentosocial VALUES (5045, '2020-07-02', 'Epitaciolândia', 36.89);
INSERT INTO pacto.isolamentosocial VALUES (5046, '2020-07-03', 'Epitaciolândia', 46.00);
INSERT INTO pacto.isolamentosocial VALUES (5047, '2020-02-01', 'Feijó', 34.91);
INSERT INTO pacto.isolamentosocial VALUES (5048, '2020-02-02', 'Feijó', 44.91);
INSERT INTO pacto.isolamentosocial VALUES (5049, '2020-02-03', 'Feijó', 30.43);
INSERT INTO pacto.isolamentosocial VALUES (5050, '2020-02-04', 'Feijó', 30.54);
INSERT INTO pacto.isolamentosocial VALUES (5051, '2020-02-05', 'Feijó', 35.71);
INSERT INTO pacto.isolamentosocial VALUES (5052, '2020-02-06', 'Feijó', 39.16);
INSERT INTO pacto.isolamentosocial VALUES (5053, '2020-02-07', 'Feijó', 37.11);
INSERT INTO pacto.isolamentosocial VALUES (5054, '2020-02-08', 'Feijó', 32.37);
INSERT INTO pacto.isolamentosocial VALUES (5055, '2020-02-09', 'Feijó', 37.82);
INSERT INTO pacto.isolamentosocial VALUES (5056, '2020-02-10', 'Feijó', 31.58);
INSERT INTO pacto.isolamentosocial VALUES (5057, '2020-02-11', 'Feijó', 22.86);
INSERT INTO pacto.isolamentosocial VALUES (5058, '2020-02-12', 'Feijó', 35.95);
INSERT INTO pacto.isolamentosocial VALUES (5059, '2020-02-13', 'Feijó', 29.09);
INSERT INTO pacto.isolamentosocial VALUES (5060, '2020-02-14', 'Feijó', 29.82);
INSERT INTO pacto.isolamentosocial VALUES (5061, '2020-02-15', 'Feijó', 43.31);
INSERT INTO pacto.isolamentosocial VALUES (5062, '2020-02-16', 'Feijó', 42.28);
INSERT INTO pacto.isolamentosocial VALUES (5063, '2020-02-17', 'Feijó', 29.19);
INSERT INTO pacto.isolamentosocial VALUES (5064, '2020-02-18', 'Feijó', 35.50);
INSERT INTO pacto.isolamentosocial VALUES (5065, '2020-02-19', 'Feijó', 27.33);
INSERT INTO pacto.isolamentosocial VALUES (5066, '2020-02-20', 'Feijó', 30.30);
INSERT INTO pacto.isolamentosocial VALUES (5068, '2020-02-22', 'Feijó', 26.58);
INSERT INTO pacto.isolamentosocial VALUES (5069, '2020-02-23', 'Feijó', 38.06);
INSERT INTO pacto.isolamentosocial VALUES (5070, '2020-02-24', 'Feijó', 35.12);
INSERT INTO pacto.isolamentosocial VALUES (5071, '2020-02-25', 'Feijó', 34.12);
INSERT INTO pacto.isolamentosocial VALUES (5072, '2020-02-26', 'Feijó', 32.16);
INSERT INTO pacto.isolamentosocial VALUES (5073, '2020-02-27', 'Feijó', 27.43);
INSERT INTO pacto.isolamentosocial VALUES (5074, '2020-02-28', 'Feijó', 32.53);
INSERT INTO pacto.isolamentosocial VALUES (5075, '2020-02-29', 'Feijó', 37.50);
INSERT INTO pacto.isolamentosocial VALUES (5076, '2020-03-01', 'Feijó', 46.06);
INSERT INTO pacto.isolamentosocial VALUES (5077, '2020-03-02', 'Feijó', 29.61);
INSERT INTO pacto.isolamentosocial VALUES (5078, '2020-03-03', 'Feijó', 32.14);
INSERT INTO pacto.isolamentosocial VALUES (5079, '2020-03-04', 'Feijó', 30.59);
INSERT INTO pacto.isolamentosocial VALUES (5080, '2020-03-05', 'Feijó', 27.65);
INSERT INTO pacto.isolamentosocial VALUES (5081, '2020-03-06', 'Feijó', 34.41);
INSERT INTO pacto.isolamentosocial VALUES (5082, '2020-03-07', 'Feijó', 37.09);
INSERT INTO pacto.isolamentosocial VALUES (5083, '2020-03-08', 'Feijó', 40.65);
INSERT INTO pacto.isolamentosocial VALUES (5084, '2020-03-09', 'Feijó', 38.07);
INSERT INTO pacto.isolamentosocial VALUES (5085, '2020-03-10', 'Feijó', 33.91);
INSERT INTO pacto.isolamentosocial VALUES (5086, '2020-03-11', 'Feijó', 31.89);
INSERT INTO pacto.isolamentosocial VALUES (5087, '2020-03-12', 'Feijó', 27.88);
INSERT INTO pacto.isolamentosocial VALUES (5088, '2020-03-13', 'Feijó', 36.02);
INSERT INTO pacto.isolamentosocial VALUES (5089, '2020-03-14', 'Feijó', 42.77);
INSERT INTO pacto.isolamentosocial VALUES (5090, '2020-03-15', 'Feijó', 40.26);
INSERT INTO pacto.isolamentosocial VALUES (5091, '2020-03-16', 'Feijó', 30.19);
INSERT INTO pacto.isolamentosocial VALUES (5092, '2020-03-17', 'Feijó', 25.15);
INSERT INTO pacto.isolamentosocial VALUES (5093, '2020-03-18', 'Feijó', 39.88);
INSERT INTO pacto.isolamentosocial VALUES (5094, '2020-03-19', 'Feijó', 37.57);
INSERT INTO pacto.isolamentosocial VALUES (5095, '2020-03-20', 'Feijó', 42.20);
INSERT INTO pacto.isolamentosocial VALUES (5096, '2020-03-21', 'Feijó', 50.31);
INSERT INTO pacto.isolamentosocial VALUES (5097, '2020-03-22', 'Feijó', 59.41);
INSERT INTO pacto.isolamentosocial VALUES (5098, '2020-03-23', 'Feijó', 49.06);
INSERT INTO pacto.isolamentosocial VALUES (5099, '2020-03-24', 'Feijó', 46.45);
INSERT INTO pacto.isolamentosocial VALUES (5100, '2020-03-25', 'Feijó', 51.19);
INSERT INTO pacto.isolamentosocial VALUES (5101, '2020-03-26', 'Feijó', 49.35);
INSERT INTO pacto.isolamentosocial VALUES (5102, '2020-03-27', 'Feijó', 45.45);
INSERT INTO pacto.isolamentosocial VALUES (5103, '2020-03-28', 'Feijó', 51.59);
INSERT INTO pacto.isolamentosocial VALUES (5104, '2020-03-29', 'Feijó', 49.70);
INSERT INTO pacto.isolamentosocial VALUES (5105, '2020-03-30', 'Feijó', 48.43);
INSERT INTO pacto.isolamentosocial VALUES (5106, '2020-03-31', 'Feijó', 48.75);
INSERT INTO pacto.isolamentosocial VALUES (5107, '2020-04-01', 'Feijó', 48.19);
INSERT INTO pacto.isolamentosocial VALUES (5108, '2020-04-02', 'Feijó', 45.96);
INSERT INTO pacto.isolamentosocial VALUES (5109, '2020-04-03', 'Feijó', 46.75);
INSERT INTO pacto.isolamentosocial VALUES (5110, '2020-04-04', 'Feijó', 46.36);
INSERT INTO pacto.isolamentosocial VALUES (5111, '2020-04-05', 'Feijó', 47.06);
INSERT INTO pacto.isolamentosocial VALUES (5112, '2020-04-06', 'Feijó', 42.11);
INSERT INTO pacto.isolamentosocial VALUES (5113, '2020-04-07', 'Feijó', 43.40);
INSERT INTO pacto.isolamentosocial VALUES (5114, '2020-04-08', 'Feijó', 40.12);
INSERT INTO pacto.isolamentosocial VALUES (5115, '2020-04-09', 'Feijó', 42.77);
INSERT INTO pacto.isolamentosocial VALUES (5116, '2020-04-10', 'Feijó', 45.39);
INSERT INTO pacto.isolamentosocial VALUES (5117, '2020-04-11', 'Feijó', 38.31);
INSERT INTO pacto.isolamentosocial VALUES (5118, '2020-04-12', 'Feijó', 57.23);
INSERT INTO pacto.isolamentosocial VALUES (5119, '2020-04-13', 'Feijó', 39.31);
INSERT INTO pacto.isolamentosocial VALUES (5120, '2020-04-14', 'Feijó', 40.12);
INSERT INTO pacto.isolamentosocial VALUES (5121, '2020-04-15', 'Feijó', 51.08);
INSERT INTO pacto.isolamentosocial VALUES (5122, '2020-04-16', 'Feijó', 41.28);
INSERT INTO pacto.isolamentosocial VALUES (5123, '2020-04-17', 'Feijó', 33.68);
INSERT INTO pacto.isolamentosocial VALUES (5124, '2020-04-18', 'Feijó', 45.36);
INSERT INTO pacto.isolamentosocial VALUES (5125, '2020-04-19', 'Feijó', 46.11);
INSERT INTO pacto.isolamentosocial VALUES (5126, '2020-04-20', 'Feijó', 42.44);
INSERT INTO pacto.isolamentosocial VALUES (5127, '2020-04-21', 'Feijó', 41.94);
INSERT INTO pacto.isolamentosocial VALUES (5128, '2020-04-22', 'Feijó', 36.79);
INSERT INTO pacto.isolamentosocial VALUES (5129, '2020-04-23', 'Feijó', 40.45);
INSERT INTO pacto.isolamentosocial VALUES (5130, '2020-04-24', 'Feijó', 44.04);
INSERT INTO pacto.isolamentosocial VALUES (5131, '2020-04-25', 'Feijó', 43.37);
INSERT INTO pacto.isolamentosocial VALUES (5132, '2020-04-26', 'Feijó', 51.41);
INSERT INTO pacto.isolamentosocial VALUES (5133, '2020-04-27', 'Feijó', 41.90);
INSERT INTO pacto.isolamentosocial VALUES (5134, '2020-04-28', 'Feijó', 38.55);
INSERT INTO pacto.isolamentosocial VALUES (5135, '2020-04-29', 'Feijó', 40.86);
INSERT INTO pacto.isolamentosocial VALUES (5136, '2020-04-30', 'Feijó', 35.59);
INSERT INTO pacto.isolamentosocial VALUES (5137, '2020-05-01', 'Feijó', 41.44);
INSERT INTO pacto.isolamentosocial VALUES (5138, '2020-05-02', 'Feijó', 48.86);
INSERT INTO pacto.isolamentosocial VALUES (5139, '2020-05-03', 'Feijó', 56.40);
INSERT INTO pacto.isolamentosocial VALUES (5140, '2020-05-04', 'Feijó', 45.11);
INSERT INTO pacto.isolamentosocial VALUES (5141, '2020-05-05', 'Feijó', 46.15);
INSERT INTO pacto.isolamentosocial VALUES (5142, '2020-05-06', 'Feijó', 35.39);
INSERT INTO pacto.isolamentosocial VALUES (5143, '2020-05-07', 'Feijó', 44.44);
INSERT INTO pacto.isolamentosocial VALUES (5144, '2020-05-08', 'Feijó', 48.31);
INSERT INTO pacto.isolamentosocial VALUES (5145, '2020-05-09', 'Feijó', 42.37);
INSERT INTO pacto.isolamentosocial VALUES (5146, '2020-05-10', 'Feijó', 46.96);
INSERT INTO pacto.isolamentosocial VALUES (5147, '2020-05-11', 'Feijó', 50.00);
INSERT INTO pacto.isolamentosocial VALUES (5148, '2020-05-12', 'Feijó', 44.51);
INSERT INTO pacto.isolamentosocial VALUES (5149, '2020-05-13', 'Feijó', 41.45);
INSERT INTO pacto.isolamentosocial VALUES (5150, '2020-05-14', 'Feijó', 37.65);
INSERT INTO pacto.isolamentosocial VALUES (5151, '2020-05-15', 'Feijó', 41.76);
INSERT INTO pacto.isolamentosocial VALUES (5152, '2020-05-16', 'Feijó', 45.45);
INSERT INTO pacto.isolamentosocial VALUES (5153, '2020-05-17', 'Feijó', 53.49);
INSERT INTO pacto.isolamentosocial VALUES (5154, '2020-05-18', 'Feijó', 40.51);
INSERT INTO pacto.isolamentosocial VALUES (5155, '2020-05-19', 'Feijó', 42.36);
INSERT INTO pacto.isolamentosocial VALUES (5156, '2020-05-20', 'Feijó', 45.27);
INSERT INTO pacto.isolamentosocial VALUES (5157, '2020-05-21', 'Feijó', 37.43);
INSERT INTO pacto.isolamentosocial VALUES (5158, '2020-05-22', 'Feijó', 39.13);
INSERT INTO pacto.isolamentosocial VALUES (5159, '2020-05-23', 'Feijó', 45.69);
INSERT INTO pacto.isolamentosocial VALUES (5160, '2020-05-24', 'Feijó', 52.72);
INSERT INTO pacto.isolamentosocial VALUES (5161, '2020-05-25', 'Feijó', 46.78);
INSERT INTO pacto.isolamentosocial VALUES (5162, '2020-05-26', 'Feijó', 39.23);
INSERT INTO pacto.isolamentosocial VALUES (5163, '2020-05-27', 'Feijó', 40.98);
INSERT INTO pacto.isolamentosocial VALUES (5164, '2020-05-28', 'Feijó', 45.90);
INSERT INTO pacto.isolamentosocial VALUES (5165, '2020-05-29', 'Feijó', 39.47);
INSERT INTO pacto.isolamentosocial VALUES (5166, '2020-05-30', 'Feijó', 41.72);
INSERT INTO pacto.isolamentosocial VALUES (5167, '2020-05-31', 'Feijó', 45.29);
INSERT INTO pacto.isolamentosocial VALUES (5168, '2020-06-01', 'Feijó', 33.33);
INSERT INTO pacto.isolamentosocial VALUES (5169, '2020-06-02', 'Feijó', 37.29);
INSERT INTO pacto.isolamentosocial VALUES (5170, '2020-06-03', 'Feijó', 43.18);
INSERT INTO pacto.isolamentosocial VALUES (5171, '2020-06-04', 'Feijó', 50.83);
INSERT INTO pacto.isolamentosocial VALUES (5172, '2020-06-05', 'Feijó', 41.46);
INSERT INTO pacto.isolamentosocial VALUES (5173, '2020-06-06', 'Feijó', 45.98);
INSERT INTO pacto.isolamentosocial VALUES (5174, '2020-06-07', 'Feijó', 48.99);
INSERT INTO pacto.isolamentosocial VALUES (5175, '2020-06-08', 'Feijó', 43.40);
INSERT INTO pacto.isolamentosocial VALUES (5176, '2020-06-09', 'Feijó', 44.59);
INSERT INTO pacto.isolamentosocial VALUES (5177, '2020-06-10', 'Feijó', 43.40);
INSERT INTO pacto.isolamentosocial VALUES (5178, '2020-06-11', 'Feijó', 46.51);
INSERT INTO pacto.isolamentosocial VALUES (5179, '2020-06-12', 'Feijó', 40.37);
INSERT INTO pacto.isolamentosocial VALUES (5180, '2020-06-13', 'Feijó', 42.14);
INSERT INTO pacto.isolamentosocial VALUES (5181, '2020-06-14', 'Feijó', 55.97);
INSERT INTO pacto.isolamentosocial VALUES (5182, '2020-06-15', 'Feijó', 40.80);
INSERT INTO pacto.isolamentosocial VALUES (5183, '2020-06-16', 'Feijó', 40.70);
INSERT INTO pacto.isolamentosocial VALUES (5184, '2020-06-17', 'Feijó', 38.51);
INSERT INTO pacto.isolamentosocial VALUES (5185, '2020-06-18', 'Feijó', 43.11);
INSERT INTO pacto.isolamentosocial VALUES (5186, '2020-06-19', 'Feijó', 33.33);
INSERT INTO pacto.isolamentosocial VALUES (5187, '2020-06-20', 'Feijó', 42.77);
INSERT INTO pacto.isolamentosocial VALUES (5188, '2020-06-21', 'Feijó', 54.55);
INSERT INTO pacto.isolamentosocial VALUES (5189, '2020-06-22', 'Feijó', 38.69);
INSERT INTO pacto.isolamentosocial VALUES (5190, '2020-06-23', 'Feijó', 37.65);
INSERT INTO pacto.isolamentosocial VALUES (5191, '2020-06-24', 'Feijó', 42.37);
INSERT INTO pacto.isolamentosocial VALUES (5192, '2020-06-25', 'Feijó', 45.00);
INSERT INTO pacto.isolamentosocial VALUES (5193, '2020-06-26', 'Feijó', 45.14);
INSERT INTO pacto.isolamentosocial VALUES (5194, '2020-06-27', 'Feijó', 46.03);
INSERT INTO pacto.isolamentosocial VALUES (5195, '2020-06-28', 'Feijó', 54.02);
INSERT INTO pacto.isolamentosocial VALUES (5196, '2020-06-29', 'Feijó', 37.14);
INSERT INTO pacto.isolamentosocial VALUES (5197, '2020-06-30', 'Feijó', 47.09);
INSERT INTO pacto.isolamentosocial VALUES (5198, '2020-07-01', 'Feijó', 42.11);
INSERT INTO pacto.isolamentosocial VALUES (5199, '2020-07-02', 'Feijó', 45.18);
INSERT INTO pacto.isolamentosocial VALUES (5200, '2020-07-03', 'Feijó', 38.69);
INSERT INTO pacto.isolamentosocial VALUES (5201, '2020-02-05', 'Jordão', 20.00);
INSERT INTO pacto.isolamentosocial VALUES (5202, '2020-02-01', 'Mâncio Lima', 45.16);
INSERT INTO pacto.isolamentosocial VALUES (5203, '2020-02-02', 'Mâncio Lima', 52.54);
INSERT INTO pacto.isolamentosocial VALUES (5204, '2020-02-03', 'Mâncio Lima', 27.87);
INSERT INTO pacto.isolamentosocial VALUES (5205, '2020-02-04', 'Mâncio Lima', 34.33);
INSERT INTO pacto.isolamentosocial VALUES (5206, '2020-02-05', 'Mâncio Lima', 32.81);
INSERT INTO pacto.isolamentosocial VALUES (5207, '2020-02-06', 'Mâncio Lima', 30.51);
INSERT INTO pacto.isolamentosocial VALUES (5208, '2020-02-07', 'Mâncio Lima', 26.42);
INSERT INTO pacto.isolamentosocial VALUES (5209, '2020-02-08', 'Mâncio Lima', 41.18);
INSERT INTO pacto.isolamentosocial VALUES (5210, '2020-02-09', 'Mâncio Lima', 42.86);
INSERT INTO pacto.isolamentosocial VALUES (5211, '2020-02-10', 'Mâncio Lima', 28.13);
INSERT INTO pacto.isolamentosocial VALUES (5212, '2020-02-11', 'Mâncio Lima', 33.85);
INSERT INTO pacto.isolamentosocial VALUES (5213, '2020-02-12', 'Mâncio Lima', 31.82);
INSERT INTO pacto.isolamentosocial VALUES (5214, '2020-02-13', 'Mâncio Lima', 32.84);
INSERT INTO pacto.isolamentosocial VALUES (5215, '2020-02-14', 'Mâncio Lima', 28.79);
INSERT INTO pacto.isolamentosocial VALUES (5216, '2020-02-15', 'Mâncio Lima', 46.97);
INSERT INTO pacto.isolamentosocial VALUES (5217, '2020-02-16', 'Mâncio Lima', 56.25);
INSERT INTO pacto.isolamentosocial VALUES (5218, '2020-02-17', 'Mâncio Lima', 35.94);
INSERT INTO pacto.isolamentosocial VALUES (5219, '2020-02-18', 'Mâncio Lima', 36.51);
INSERT INTO pacto.isolamentosocial VALUES (5220, '2020-02-19', 'Mâncio Lima', 35.59);
INSERT INTO pacto.isolamentosocial VALUES (5221, '2020-02-20', 'Mâncio Lima', 28.13);
INSERT INTO pacto.isolamentosocial VALUES (5222, '2020-02-21', 'Mâncio Lima', 34.85);
INSERT INTO pacto.isolamentosocial VALUES (5223, '2020-02-22', 'Mâncio Lima', 42.86);
INSERT INTO pacto.isolamentosocial VALUES (5224, '2020-02-23', 'Mâncio Lima', 38.46);
INSERT INTO pacto.isolamentosocial VALUES (5225, '2020-02-24', 'Mâncio Lima', 36.07);
INSERT INTO pacto.isolamentosocial VALUES (5226, '2020-02-25', 'Mâncio Lima', 42.59);
INSERT INTO pacto.isolamentosocial VALUES (5227, '2020-02-26', 'Mâncio Lima', 37.50);
INSERT INTO pacto.isolamentosocial VALUES (5228, '2020-02-27', 'Mâncio Lima', 30.77);
INSERT INTO pacto.isolamentosocial VALUES (5229, '2020-02-28', 'Mâncio Lima', 27.45);
INSERT INTO pacto.isolamentosocial VALUES (5230, '2020-02-29', 'Mâncio Lima', 32.79);
INSERT INTO pacto.isolamentosocial VALUES (5231, '2020-03-01', 'Mâncio Lima', 50.00);
INSERT INTO pacto.isolamentosocial VALUES (5232, '2020-03-02', 'Mâncio Lima', 35.42);
INSERT INTO pacto.isolamentosocial VALUES (5233, '2020-03-03', 'Mâncio Lima', 35.85);
INSERT INTO pacto.isolamentosocial VALUES (5234, '2020-03-04', 'Mâncio Lima', 40.74);
INSERT INTO pacto.isolamentosocial VALUES (5235, '2020-03-05', 'Mâncio Lima', 32.69);
INSERT INTO pacto.isolamentosocial VALUES (5236, '2020-03-06', 'Mâncio Lima', 50.00);
INSERT INTO pacto.isolamentosocial VALUES (5237, '2020-03-07', 'Mâncio Lima', 46.00);
INSERT INTO pacto.isolamentosocial VALUES (5238, '2020-03-08', 'Mâncio Lima', 58.82);
INSERT INTO pacto.isolamentosocial VALUES (5239, '2020-03-09', 'Mâncio Lima', 32.65);
INSERT INTO pacto.isolamentosocial VALUES (5240, '2020-03-10', 'Mâncio Lima', 41.94);
INSERT INTO pacto.isolamentosocial VALUES (5241, '2020-03-11', 'Mâncio Lima', 40.38);
INSERT INTO pacto.isolamentosocial VALUES (5242, '2020-03-12', 'Mâncio Lima', 36.21);
INSERT INTO pacto.isolamentosocial VALUES (5243, '2020-03-13', 'Mâncio Lima', 39.13);
INSERT INTO pacto.isolamentosocial VALUES (5244, '2020-03-14', 'Mâncio Lima', 34.48);
INSERT INTO pacto.isolamentosocial VALUES (5245, '2020-03-15', 'Mâncio Lima', 41.67);
INSERT INTO pacto.isolamentosocial VALUES (5246, '2020-03-16', 'Mâncio Lima', 29.17);
INSERT INTO pacto.isolamentosocial VALUES (5247, '2020-03-17', 'Mâncio Lima', 28.57);
INSERT INTO pacto.isolamentosocial VALUES (5248, '2020-03-18', 'Mâncio Lima', 41.38);
INSERT INTO pacto.isolamentosocial VALUES (5249, '2020-03-19', 'Mâncio Lima', 40.74);
INSERT INTO pacto.isolamentosocial VALUES (5250, '2020-03-20', 'Mâncio Lima', 33.33);
INSERT INTO pacto.isolamentosocial VALUES (5251, '2020-03-21', 'Mâncio Lima', 41.51);
INSERT INTO pacto.isolamentosocial VALUES (5252, '2020-03-22', 'Mâncio Lima', 65.57);
INSERT INTO pacto.isolamentosocial VALUES (5253, '2020-03-23', 'Mâncio Lima', 48.98);
INSERT INTO pacto.isolamentosocial VALUES (5254, '2020-03-24', 'Mâncio Lima', 44.64);
INSERT INTO pacto.isolamentosocial VALUES (5255, '2020-03-25', 'Mâncio Lima', 55.00);
INSERT INTO pacto.isolamentosocial VALUES (5256, '2020-03-26', 'Mâncio Lima', 45.76);
INSERT INTO pacto.isolamentosocial VALUES (5257, '2020-03-27', 'Mâncio Lima', 56.90);
INSERT INTO pacto.isolamentosocial VALUES (5258, '2020-03-28', 'Mâncio Lima', 50.00);
INSERT INTO pacto.isolamentosocial VALUES (5259, '2020-03-29', 'Mâncio Lima', 64.41);
INSERT INTO pacto.isolamentosocial VALUES (5260, '2020-03-30', 'Mâncio Lima', 50.82);
INSERT INTO pacto.isolamentosocial VALUES (5261, '2020-03-31', 'Mâncio Lima', 49.12);
INSERT INTO pacto.isolamentosocial VALUES (5262, '2020-04-01', 'Mâncio Lima', 41.51);
INSERT INTO pacto.isolamentosocial VALUES (5263, '2020-04-02', 'Mâncio Lima', 51.61);
INSERT INTO pacto.isolamentosocial VALUES (5264, '2020-04-03', 'Mâncio Lima', 40.91);
INSERT INTO pacto.isolamentosocial VALUES (5265, '2020-04-04', 'Mâncio Lima', 38.46);
INSERT INTO pacto.isolamentosocial VALUES (5266, '2020-04-05', 'Mâncio Lima', 53.85);
INSERT INTO pacto.isolamentosocial VALUES (5267, '2020-04-06', 'Mâncio Lima', 46.55);
INSERT INTO pacto.isolamentosocial VALUES (5268, '2020-04-07', 'Mâncio Lima', 52.38);
INSERT INTO pacto.isolamentosocial VALUES (5269, '2020-04-08', 'Mâncio Lima', 44.93);
INSERT INTO pacto.isolamentosocial VALUES (5270, '2020-04-09', 'Mâncio Lima', 36.84);
INSERT INTO pacto.isolamentosocial VALUES (5271, '2020-04-10', 'Mâncio Lima', 46.30);
INSERT INTO pacto.isolamentosocial VALUES (5272, '2020-04-11', 'Mâncio Lima', 48.39);
INSERT INTO pacto.isolamentosocial VALUES (5273, '2020-04-12', 'Mâncio Lima', 43.33);
INSERT INTO pacto.isolamentosocial VALUES (5274, '2020-04-13', 'Mâncio Lima', 42.86);
INSERT INTO pacto.isolamentosocial VALUES (5275, '2020-04-14', 'Mâncio Lima', 52.46);
INSERT INTO pacto.isolamentosocial VALUES (5276, '2020-04-15', 'Mâncio Lima', 47.62);
INSERT INTO pacto.isolamentosocial VALUES (5277, '2020-04-16', 'Mâncio Lima', 40.32);
INSERT INTO pacto.isolamentosocial VALUES (5278, '2020-04-17', 'Mâncio Lima', 40.32);
INSERT INTO pacto.isolamentosocial VALUES (5279, '2020-04-18', 'Mâncio Lima', 49.30);
INSERT INTO pacto.isolamentosocial VALUES (5280, '2020-04-19', 'Mâncio Lima', 53.57);
INSERT INTO pacto.isolamentosocial VALUES (5281, '2020-04-20', 'Mâncio Lima', 47.46);
INSERT INTO pacto.isolamentosocial VALUES (5282, '2020-04-21', 'Mâncio Lima', 43.48);
INSERT INTO pacto.isolamentosocial VALUES (5283, '2020-04-22', 'Mâncio Lima', 43.33);
INSERT INTO pacto.isolamentosocial VALUES (5284, '2020-04-23', 'Mâncio Lima', 43.40);
INSERT INTO pacto.isolamentosocial VALUES (5285, '2020-04-24', 'Mâncio Lima', 52.73);
INSERT INTO pacto.isolamentosocial VALUES (5286, '2020-04-25', 'Mâncio Lima', 38.78);
INSERT INTO pacto.isolamentosocial VALUES (5287, '2020-04-26', 'Mâncio Lima', 57.14);
INSERT INTO pacto.isolamentosocial VALUES (5288, '2020-04-27', 'Mâncio Lima', 50.00);
INSERT INTO pacto.isolamentosocial VALUES (5289, '2020-04-28', 'Mâncio Lima', 44.78);
INSERT INTO pacto.isolamentosocial VALUES (5290, '2020-04-29', 'Mâncio Lima', 38.81);
INSERT INTO pacto.isolamentosocial VALUES (5291, '2020-04-30', 'Mâncio Lima', 35.14);
INSERT INTO pacto.isolamentosocial VALUES (5292, '2020-05-01', 'Mâncio Lima', 39.73);
INSERT INTO pacto.isolamentosocial VALUES (5293, '2020-05-02', 'Mâncio Lima', 40.51);
INSERT INTO pacto.isolamentosocial VALUES (5294, '2020-05-03', 'Mâncio Lima', 57.14);
INSERT INTO pacto.isolamentosocial VALUES (5295, '2020-05-04', 'Mâncio Lima', 51.43);
INSERT INTO pacto.isolamentosocial VALUES (5296, '2020-05-05', 'Mâncio Lima', 56.76);
INSERT INTO pacto.isolamentosocial VALUES (5297, '2020-05-06', 'Mâncio Lima', 58.70);
INSERT INTO pacto.isolamentosocial VALUES (5298, '2020-05-07', 'Mâncio Lima', 55.84);
INSERT INTO pacto.isolamentosocial VALUES (5299, '2020-05-08', 'Mâncio Lima', 38.89);
INSERT INTO pacto.isolamentosocial VALUES (5300, '2020-05-09', 'Mâncio Lima', 51.35);
INSERT INTO pacto.isolamentosocial VALUES (5301, '2020-05-10', 'Mâncio Lima', 52.24);
INSERT INTO pacto.isolamentosocial VALUES (5302, '2020-05-11', 'Mâncio Lima', 34.38);
INSERT INTO pacto.isolamentosocial VALUES (5303, '2020-05-12', 'Mâncio Lima', 47.30);
INSERT INTO pacto.isolamentosocial VALUES (5304, '2020-05-13', 'Mâncio Lima', 48.39);
INSERT INTO pacto.isolamentosocial VALUES (5305, '2020-05-14', 'Mâncio Lima', 46.48);
INSERT INTO pacto.isolamentosocial VALUES (5306, '2020-05-15', 'Mâncio Lima', 44.87);
INSERT INTO pacto.isolamentosocial VALUES (5307, '2020-05-16', 'Mâncio Lima', 53.95);
INSERT INTO pacto.isolamentosocial VALUES (5308, '2020-05-17', 'Mâncio Lima', 56.96);
INSERT INTO pacto.isolamentosocial VALUES (5309, '2020-05-18', 'Mâncio Lima', 53.33);
INSERT INTO pacto.isolamentosocial VALUES (5310, '2020-05-19', 'Mâncio Lima', 57.14);
INSERT INTO pacto.isolamentosocial VALUES (5311, '2020-05-20', 'Mâncio Lima', 60.00);
INSERT INTO pacto.isolamentosocial VALUES (5312, '2020-05-21', 'Mâncio Lima', 57.50);
INSERT INTO pacto.isolamentosocial VALUES (5313, '2020-05-22', 'Mâncio Lima', 42.35);
INSERT INTO pacto.isolamentosocial VALUES (5314, '2020-05-23', 'Mâncio Lima', 56.47);
INSERT INTO pacto.isolamentosocial VALUES (5315, '2020-05-24', 'Mâncio Lima', 56.63);
INSERT INTO pacto.isolamentosocial VALUES (5316, '2020-05-25', 'Mâncio Lima', 50.67);
INSERT INTO pacto.isolamentosocial VALUES (5317, '2020-05-26', 'Mâncio Lima', 54.76);
INSERT INTO pacto.isolamentosocial VALUES (5318, '2020-05-27', 'Mâncio Lima', 50.00);
INSERT INTO pacto.isolamentosocial VALUES (5319, '2020-05-28', 'Mâncio Lima', 50.00);
INSERT INTO pacto.isolamentosocial VALUES (5320, '2020-05-29', 'Mâncio Lima', 51.35);
INSERT INTO pacto.isolamentosocial VALUES (5321, '2020-05-30', 'Mâncio Lima', 64.79);
INSERT INTO pacto.isolamentosocial VALUES (5322, '2020-05-31', 'Mâncio Lima', 63.16);
INSERT INTO pacto.isolamentosocial VALUES (5323, '2020-06-01', 'Mâncio Lima', 47.95);
INSERT INTO pacto.isolamentosocial VALUES (5324, '2020-06-02', 'Mâncio Lima', 57.83);
INSERT INTO pacto.isolamentosocial VALUES (5325, '2020-06-03', 'Mâncio Lima', 45.21);
INSERT INTO pacto.isolamentosocial VALUES (5326, '2020-06-04', 'Mâncio Lima', 45.45);
INSERT INTO pacto.isolamentosocial VALUES (5327, '2020-06-05', 'Mâncio Lima', 57.58);
INSERT INTO pacto.isolamentosocial VALUES (5328, '2020-06-06', 'Mâncio Lima', 55.22);
INSERT INTO pacto.isolamentosocial VALUES (5329, '2020-06-07', 'Mâncio Lima', 61.54);
INSERT INTO pacto.isolamentosocial VALUES (5330, '2020-06-08', 'Mâncio Lima', 53.97);
INSERT INTO pacto.isolamentosocial VALUES (5331, '2020-06-09', 'Mâncio Lima', 44.62);
INSERT INTO pacto.isolamentosocial VALUES (5332, '2020-06-10', 'Mâncio Lima', 52.70);
INSERT INTO pacto.isolamentosocial VALUES (5333, '2020-06-11', 'Mâncio Lima', 44.62);
INSERT INTO pacto.isolamentosocial VALUES (5334, '2020-06-12', 'Mâncio Lima', 40.68);
INSERT INTO pacto.isolamentosocial VALUES (5335, '2020-06-13', 'Mâncio Lima', 45.16);
INSERT INTO pacto.isolamentosocial VALUES (5336, '2020-06-14', 'Mâncio Lima', 48.39);
INSERT INTO pacto.isolamentosocial VALUES (5337, '2020-06-15', 'Mâncio Lima', 43.33);
INSERT INTO pacto.isolamentosocial VALUES (5338, '2020-06-16', 'Mâncio Lima', 48.39);
INSERT INTO pacto.isolamentosocial VALUES (5339, '2020-06-17', 'Mâncio Lima', 46.77);
INSERT INTO pacto.isolamentosocial VALUES (5340, '2020-06-18', 'Mâncio Lima', 50.00);
INSERT INTO pacto.isolamentosocial VALUES (5341, '2020-06-19', 'Mâncio Lima', 38.60);
INSERT INTO pacto.isolamentosocial VALUES (5342, '2020-06-20', 'Mâncio Lima', 49.28);
INSERT INTO pacto.isolamentosocial VALUES (5343, '2020-06-21', 'Mâncio Lima', 50.00);
INSERT INTO pacto.isolamentosocial VALUES (5344, '2020-06-22', 'Mâncio Lima', 50.62);
INSERT INTO pacto.isolamentosocial VALUES (5345, '2020-06-23', 'Mâncio Lima', 48.61);
INSERT INTO pacto.isolamentosocial VALUES (5346, '2020-06-24', 'Mâncio Lima', 43.28);
INSERT INTO pacto.isolamentosocial VALUES (5347, '2020-06-25', 'Mâncio Lima', 39.71);
INSERT INTO pacto.isolamentosocial VALUES (5348, '2020-06-26', 'Mâncio Lima', 39.74);
INSERT INTO pacto.isolamentosocial VALUES (5349, '2020-06-27', 'Mâncio Lima', 44.44);
INSERT INTO pacto.isolamentosocial VALUES (5350, '2020-06-28', 'Mâncio Lima', 46.88);
INSERT INTO pacto.isolamentosocial VALUES (5351, '2020-06-29', 'Mâncio Lima', 44.44);
INSERT INTO pacto.isolamentosocial VALUES (5352, '2020-06-30', 'Mâncio Lima', 38.96);
INSERT INTO pacto.isolamentosocial VALUES (5353, '2020-07-01', 'Mâncio Lima', 40.98);
INSERT INTO pacto.isolamentosocial VALUES (5354, '2020-07-02', 'Mâncio Lima', 44.12);
INSERT INTO pacto.isolamentosocial VALUES (5355, '2020-07-03', 'Mâncio Lima', 45.07);
INSERT INTO pacto.isolamentosocial VALUES (5356, '2020-02-01', 'Manoel Urbano', 37.50);
INSERT INTO pacto.isolamentosocial VALUES (5357, '2020-02-02', 'Manoel Urbano', 35.19);
INSERT INTO pacto.isolamentosocial VALUES (5358, '2020-02-03', 'Manoel Urbano', 26.87);
INSERT INTO pacto.isolamentosocial VALUES (5359, '2020-02-04', 'Manoel Urbano', 23.33);
INSERT INTO pacto.isolamentosocial VALUES (5360, '2020-02-05', 'Manoel Urbano', 30.00);
INSERT INTO pacto.isolamentosocial VALUES (5361, '2020-02-06', 'Manoel Urbano', 31.25);
INSERT INTO pacto.isolamentosocial VALUES (5362, '2020-02-07', 'Manoel Urbano', 21.31);
INSERT INTO pacto.isolamentosocial VALUES (5363, '2020-02-08', 'Manoel Urbano', 40.00);
INSERT INTO pacto.isolamentosocial VALUES (5364, '2020-02-09', 'Manoel Urbano', 46.77);
INSERT INTO pacto.isolamentosocial VALUES (5365, '2020-02-10', 'Manoel Urbano', 19.61);
INSERT INTO pacto.isolamentosocial VALUES (5366, '2020-02-11', 'Manoel Urbano', 23.81);
INSERT INTO pacto.isolamentosocial VALUES (5367, '2020-02-12', 'Manoel Urbano', 23.21);
INSERT INTO pacto.isolamentosocial VALUES (5368, '2020-02-13', 'Manoel Urbano', 32.26);
INSERT INTO pacto.isolamentosocial VALUES (5369, '2020-02-14', 'Manoel Urbano', 31.58);
INSERT INTO pacto.isolamentosocial VALUES (5370, '2020-02-15', 'Manoel Urbano', 35.09);
INSERT INTO pacto.isolamentosocial VALUES (5371, '2020-02-16', 'Manoel Urbano', 36.92);
INSERT INTO pacto.isolamentosocial VALUES (5372, '2020-02-17', 'Manoel Urbano', 21.21);
INSERT INTO pacto.isolamentosocial VALUES (5373, '2020-02-18', 'Manoel Urbano', 15.87);
INSERT INTO pacto.isolamentosocial VALUES (5374, '2020-02-19', 'Manoel Urbano', 20.59);
INSERT INTO pacto.isolamentosocial VALUES (5376, '2020-02-21', 'Manoel Urbano', 30.88);
INSERT INTO pacto.isolamentosocial VALUES (5377, '2020-02-22', 'Manoel Urbano', 35.29);
INSERT INTO pacto.isolamentosocial VALUES (5378, '2020-02-23', 'Manoel Urbano', 44.07);
INSERT INTO pacto.isolamentosocial VALUES (5379, '2020-02-24', 'Manoel Urbano', 40.00);
INSERT INTO pacto.isolamentosocial VALUES (5381, '2020-02-26', 'Manoel Urbano', 37.50);
INSERT INTO pacto.isolamentosocial VALUES (5382, '2020-02-27', 'Manoel Urbano', 23.81);
INSERT INTO pacto.isolamentosocial VALUES (5383, '2020-02-28', 'Manoel Urbano', 28.57);
INSERT INTO pacto.isolamentosocial VALUES (5384, '2020-02-29', 'Manoel Urbano', 33.33);
INSERT INTO pacto.isolamentosocial VALUES (5385, '2020-03-01', 'Manoel Urbano', 37.50);
INSERT INTO pacto.isolamentosocial VALUES (5386, '2020-03-02', 'Manoel Urbano', 27.59);
INSERT INTO pacto.isolamentosocial VALUES (5387, '2020-03-03', 'Manoel Urbano', 30.65);
INSERT INTO pacto.isolamentosocial VALUES (5389, '2020-03-05', 'Manoel Urbano', 33.33);
INSERT INTO pacto.isolamentosocial VALUES (5390, '2020-03-06', 'Manoel Urbano', 33.33);
INSERT INTO pacto.isolamentosocial VALUES (5391, '2020-03-07', 'Manoel Urbano', 41.67);
INSERT INTO pacto.isolamentosocial VALUES (5392, '2020-03-08', 'Manoel Urbano', 33.33);
INSERT INTO pacto.isolamentosocial VALUES (5393, '2020-03-09', 'Manoel Urbano', 37.68);
INSERT INTO pacto.isolamentosocial VALUES (5394, '2020-03-10', 'Manoel Urbano', 41.82);
INSERT INTO pacto.isolamentosocial VALUES (5395, '2020-03-11', 'Manoel Urbano', 38.98);
INSERT INTO pacto.isolamentosocial VALUES (5396, '2020-03-12', 'Manoel Urbano', 38.89);
INSERT INTO pacto.isolamentosocial VALUES (5397, '2020-03-13', 'Manoel Urbano', 36.67);
INSERT INTO pacto.isolamentosocial VALUES (5398, '2020-03-14', 'Manoel Urbano', 40.32);
INSERT INTO pacto.isolamentosocial VALUES (5399, '2020-03-15', 'Manoel Urbano', 41.07);
INSERT INTO pacto.isolamentosocial VALUES (5400, '2020-03-16', 'Manoel Urbano', 28.33);
INSERT INTO pacto.isolamentosocial VALUES (5401, '2020-03-17', 'Manoel Urbano', 45.16);
INSERT INTO pacto.isolamentosocial VALUES (5403, '2020-03-19', 'Manoel Urbano', 39.71);
INSERT INTO pacto.isolamentosocial VALUES (5404, '2020-03-20', 'Manoel Urbano', 42.42);
INSERT INTO pacto.isolamentosocial VALUES (5405, '2020-03-21', 'Manoel Urbano', 41.82);
INSERT INTO pacto.isolamentosocial VALUES (5406, '2020-03-22', 'Manoel Urbano', 52.46);
INSERT INTO pacto.isolamentosocial VALUES (5407, '2020-03-23', 'Manoel Urbano', 48.28);
INSERT INTO pacto.isolamentosocial VALUES (5408, '2020-03-24', 'Manoel Urbano', 40.30);
INSERT INTO pacto.isolamentosocial VALUES (5409, '2020-03-25', 'Manoel Urbano', 49.02);
INSERT INTO pacto.isolamentosocial VALUES (5410, '2020-03-26', 'Manoel Urbano', 55.93);
INSERT INTO pacto.isolamentosocial VALUES (5411, '2020-03-27', 'Manoel Urbano', 36.54);
INSERT INTO pacto.isolamentosocial VALUES (5412, '2020-03-28', 'Manoel Urbano', 49.21);
INSERT INTO pacto.isolamentosocial VALUES (5413, '2020-03-29', 'Manoel Urbano', 55.17);
INSERT INTO pacto.isolamentosocial VALUES (5414, '2020-03-30', 'Manoel Urbano', 27.12);
INSERT INTO pacto.isolamentosocial VALUES (5416, '2020-04-01', 'Manoel Urbano', 40.00);
INSERT INTO pacto.isolamentosocial VALUES (5417, '2020-04-02', 'Manoel Urbano', 34.92);
INSERT INTO pacto.isolamentosocial VALUES (5418, '2020-04-03', 'Manoel Urbano', 38.10);
INSERT INTO pacto.isolamentosocial VALUES (5419, '2020-04-04', 'Manoel Urbano', 47.76);
INSERT INTO pacto.isolamentosocial VALUES (5420, '2020-04-05', 'Manoel Urbano', 46.67);
INSERT INTO pacto.isolamentosocial VALUES (5421, '2020-04-06', 'Manoel Urbano', 32.31);
INSERT INTO pacto.isolamentosocial VALUES (5422, '2020-04-07', 'Manoel Urbano', 33.33);
INSERT INTO pacto.isolamentosocial VALUES (5423, '2020-04-08', 'Manoel Urbano', 36.62);
INSERT INTO pacto.isolamentosocial VALUES (5424, '2020-04-09', 'Manoel Urbano', 42.19);
INSERT INTO pacto.isolamentosocial VALUES (5425, '2020-04-10', 'Manoel Urbano', 50.00);
INSERT INTO pacto.isolamentosocial VALUES (5426, '2020-04-11', 'Manoel Urbano', 42.25);
INSERT INTO pacto.isolamentosocial VALUES (5427, '2020-04-12', 'Manoel Urbano', 48.48);
INSERT INTO pacto.isolamentosocial VALUES (5428, '2020-04-13', 'Manoel Urbano', 46.67);
INSERT INTO pacto.isolamentosocial VALUES (5429, '2020-04-14', 'Manoel Urbano', 41.27);
INSERT INTO pacto.isolamentosocial VALUES (5430, '2020-04-15', 'Manoel Urbano', 37.88);
INSERT INTO pacto.isolamentosocial VALUES (5431, '2020-04-16', 'Manoel Urbano', 43.64);
INSERT INTO pacto.isolamentosocial VALUES (5432, '2020-04-17', 'Manoel Urbano', 43.10);
INSERT INTO pacto.isolamentosocial VALUES (5433, '2020-04-18', 'Manoel Urbano', 53.57);
INSERT INTO pacto.isolamentosocial VALUES (5434, '2020-04-19', 'Manoel Urbano', 51.92);
INSERT INTO pacto.isolamentosocial VALUES (5436, '2020-04-21', 'Manoel Urbano', 33.87);
INSERT INTO pacto.isolamentosocial VALUES (5437, '2020-04-22', 'Manoel Urbano', 41.51);
INSERT INTO pacto.isolamentosocial VALUES (5438, '2020-04-23', 'Manoel Urbano', 37.04);
INSERT INTO pacto.isolamentosocial VALUES (5439, '2020-04-24', 'Manoel Urbano', 36.51);
INSERT INTO pacto.isolamentosocial VALUES (5440, '2020-04-25', 'Manoel Urbano', 41.67);
INSERT INTO pacto.isolamentosocial VALUES (5441, '2020-04-26', 'Manoel Urbano', 60.00);
INSERT INTO pacto.isolamentosocial VALUES (5442, '2020-04-27', 'Manoel Urbano', 39.44);
INSERT INTO pacto.isolamentosocial VALUES (5443, '2020-04-28', 'Manoel Urbano', 32.84);
INSERT INTO pacto.isolamentosocial VALUES (5444, '2020-04-29', 'Manoel Urbano', 27.27);
INSERT INTO pacto.isolamentosocial VALUES (5445, '2020-04-30', 'Manoel Urbano', 35.00);
INSERT INTO pacto.isolamentosocial VALUES (5446, '2020-05-01', 'Manoel Urbano', 42.86);
INSERT INTO pacto.isolamentosocial VALUES (5447, '2020-05-02', 'Manoel Urbano', 35.71);
INSERT INTO pacto.isolamentosocial VALUES (5448, '2020-05-03', 'Manoel Urbano', 49.18);
INSERT INTO pacto.isolamentosocial VALUES (5449, '2020-05-04', 'Manoel Urbano', 32.14);
INSERT INTO pacto.isolamentosocial VALUES (5450, '2020-05-05', 'Manoel Urbano', 33.80);
INSERT INTO pacto.isolamentosocial VALUES (5451, '2020-05-06', 'Manoel Urbano', 28.81);
INSERT INTO pacto.isolamentosocial VALUES (5453, '2020-05-08', 'Manoel Urbano', 39.58);
INSERT INTO pacto.isolamentosocial VALUES (5454, '2020-05-09', 'Manoel Urbano', 38.60);
INSERT INTO pacto.isolamentosocial VALUES (5455, '2020-05-10', 'Manoel Urbano', 44.07);
INSERT INTO pacto.isolamentosocial VALUES (5456, '2020-05-11', 'Manoel Urbano', 42.59);
INSERT INTO pacto.isolamentosocial VALUES (5457, '2020-05-12', 'Manoel Urbano', 43.33);
INSERT INTO pacto.isolamentosocial VALUES (5458, '2020-05-13', 'Manoel Urbano', 41.82);
INSERT INTO pacto.isolamentosocial VALUES (5459, '2020-05-14', 'Manoel Urbano', 40.00);
INSERT INTO pacto.isolamentosocial VALUES (5460, '2020-05-15', 'Manoel Urbano', 33.90);
INSERT INTO pacto.isolamentosocial VALUES (5461, '2020-05-16', 'Manoel Urbano', 38.60);
INSERT INTO pacto.isolamentosocial VALUES (5462, '2020-05-17', 'Manoel Urbano', 43.10);
INSERT INTO pacto.isolamentosocial VALUES (5463, '2020-05-18', 'Manoel Urbano', 35.71);
INSERT INTO pacto.isolamentosocial VALUES (5464, '2020-05-19', 'Manoel Urbano', 38.18);
INSERT INTO pacto.isolamentosocial VALUES (5465, '2020-05-20', 'Manoel Urbano', 28.57);
INSERT INTO pacto.isolamentosocial VALUES (5466, '2020-05-21', 'Manoel Urbano', 39.66);
INSERT INTO pacto.isolamentosocial VALUES (5467, '2020-05-22', 'Manoel Urbano', 33.33);
INSERT INTO pacto.isolamentosocial VALUES (5468, '2020-05-23', 'Manoel Urbano', 35.09);
INSERT INTO pacto.isolamentosocial VALUES (5469, '2020-05-24', 'Manoel Urbano', 46.00);
INSERT INTO pacto.isolamentosocial VALUES (5470, '2020-05-25', 'Manoel Urbano', 41.03);
INSERT INTO pacto.isolamentosocial VALUES (5471, '2020-05-26', 'Manoel Urbano', 36.96);
INSERT INTO pacto.isolamentosocial VALUES (5472, '2020-05-27', 'Manoel Urbano', 42.31);
INSERT INTO pacto.isolamentosocial VALUES (5473, '2020-05-28', 'Manoel Urbano', 24.00);
INSERT INTO pacto.isolamentosocial VALUES (5474, '2020-05-29', 'Manoel Urbano', 36.36);
INSERT INTO pacto.isolamentosocial VALUES (5475, '2020-05-30', 'Manoel Urbano', 46.67);
INSERT INTO pacto.isolamentosocial VALUES (5476, '2020-05-31', 'Manoel Urbano', 34.09);
INSERT INTO pacto.isolamentosocial VALUES (5477, '2020-06-01', 'Manoel Urbano', 32.00);
INSERT INTO pacto.isolamentosocial VALUES (5478, '2020-06-02', 'Manoel Urbano', 39.62);
INSERT INTO pacto.isolamentosocial VALUES (5479, '2020-06-03', 'Manoel Urbano', 50.94);
INSERT INTO pacto.isolamentosocial VALUES (5480, '2020-06-04', 'Manoel Urbano', 38.18);
INSERT INTO pacto.isolamentosocial VALUES (5481, '2020-06-05', 'Manoel Urbano', 37.93);
INSERT INTO pacto.isolamentosocial VALUES (5482, '2020-06-06', 'Manoel Urbano', 51.22);
INSERT INTO pacto.isolamentosocial VALUES (5483, '2020-06-07', 'Manoel Urbano', 59.09);
INSERT INTO pacto.isolamentosocial VALUES (5484, '2020-06-08', 'Manoel Urbano', 41.30);
INSERT INTO pacto.isolamentosocial VALUES (5485, '2020-06-09', 'Manoel Urbano', 36.84);
INSERT INTO pacto.isolamentosocial VALUES (5486, '2020-06-10', 'Manoel Urbano', 40.82);
INSERT INTO pacto.isolamentosocial VALUES (5487, '2020-06-11', 'Manoel Urbano', 46.15);
INSERT INTO pacto.isolamentosocial VALUES (5488, '2020-06-12', 'Manoel Urbano', 41.30);
INSERT INTO pacto.isolamentosocial VALUES (5489, '2020-06-13', 'Manoel Urbano', 34.15);
INSERT INTO pacto.isolamentosocial VALUES (5490, '2020-06-14', 'Manoel Urbano', 43.24);
INSERT INTO pacto.isolamentosocial VALUES (5491, '2020-06-15', 'Manoel Urbano', 38.78);
INSERT INTO pacto.isolamentosocial VALUES (5493, '2020-06-17', 'Manoel Urbano', 41.18);
INSERT INTO pacto.isolamentosocial VALUES (5494, '2020-06-18', 'Manoel Urbano', 26.53);
INSERT INTO pacto.isolamentosocial VALUES (5495, '2020-06-19', 'Manoel Urbano', 43.75);
INSERT INTO pacto.isolamentosocial VALUES (5496, '2020-06-20', 'Manoel Urbano', 40.74);
INSERT INTO pacto.isolamentosocial VALUES (5497, '2020-06-21', 'Manoel Urbano', 43.64);
INSERT INTO pacto.isolamentosocial VALUES (5498, '2020-06-22', 'Manoel Urbano', 43.40);
INSERT INTO pacto.isolamentosocial VALUES (5499, '2020-06-23', 'Manoel Urbano', 40.82);
INSERT INTO pacto.isolamentosocial VALUES (5500, '2020-06-24', 'Manoel Urbano', 38.98);
INSERT INTO pacto.isolamentosocial VALUES (5501, '2020-06-25', 'Manoel Urbano', 40.30);
INSERT INTO pacto.isolamentosocial VALUES (5502, '2020-06-26', 'Manoel Urbano', 46.55);
INSERT INTO pacto.isolamentosocial VALUES (5503, '2020-06-27', 'Manoel Urbano', 48.48);
INSERT INTO pacto.isolamentosocial VALUES (5504, '2020-06-28', 'Manoel Urbano', 56.60);
INSERT INTO pacto.isolamentosocial VALUES (5506, '2020-06-30', 'Manoel Urbano', 37.04);
INSERT INTO pacto.isolamentosocial VALUES (5507, '2020-07-01', 'Manoel Urbano', 48.33);
INSERT INTO pacto.isolamentosocial VALUES (5508, '2020-07-02', 'Manoel Urbano', 40.91);
INSERT INTO pacto.isolamentosocial VALUES (5509, '2020-07-03', 'Manoel Urbano', 46.67);
INSERT INTO pacto.isolamentosocial VALUES (5510, '2020-05-11', 'Marechal Thaumaturgo', 54.17);
INSERT INTO pacto.isolamentosocial VALUES (5511, '2020-02-01', 'Plácido de Castro', 41.58);
INSERT INTO pacto.isolamentosocial VALUES (5512, '2020-02-02', 'Plácido de Castro', 41.90);
INSERT INTO pacto.isolamentosocial VALUES (5513, '2020-02-03', 'Plácido de Castro', 28.65);
INSERT INTO pacto.isolamentosocial VALUES (5514, '2020-02-04', 'Plácido de Castro', 29.63);
INSERT INTO pacto.isolamentosocial VALUES (5515, '2020-02-05', 'Plácido de Castro', 33.52);
INSERT INTO pacto.isolamentosocial VALUES (5516, '2020-02-06', 'Plácido de Castro', 29.94);
INSERT INTO pacto.isolamentosocial VALUES (5519, '2020-02-09', 'Plácido de Castro', 39.77);
INSERT INTO pacto.isolamentosocial VALUES (5520, '2020-02-10', 'Plácido de Castro', 24.71);
INSERT INTO pacto.isolamentosocial VALUES (5521, '2020-02-11', 'Plácido de Castro', 27.89);
INSERT INTO pacto.isolamentosocial VALUES (5522, '2020-02-12', 'Plácido de Castro', 22.53);
INSERT INTO pacto.isolamentosocial VALUES (5523, '2020-02-13', 'Plácido de Castro', 28.06);
INSERT INTO pacto.isolamentosocial VALUES (5524, '2020-02-14', 'Plácido de Castro', 25.00);
INSERT INTO pacto.isolamentosocial VALUES (5525, '2020-02-15', 'Plácido de Castro', 38.31);
INSERT INTO pacto.isolamentosocial VALUES (5526, '2020-02-16', 'Plácido de Castro', 39.50);
INSERT INTO pacto.isolamentosocial VALUES (5527, '2020-02-17', 'Plácido de Castro', 23.12);
INSERT INTO pacto.isolamentosocial VALUES (5528, '2020-02-18', 'Plácido de Castro', 31.15);
INSERT INTO pacto.isolamentosocial VALUES (5529, '2020-02-19', 'Plácido de Castro', 30.05);
INSERT INTO pacto.isolamentosocial VALUES (5530, '2020-02-20', 'Plácido de Castro', 26.11);
INSERT INTO pacto.isolamentosocial VALUES (5531, '2020-02-21', 'Plácido de Castro', 28.71);
INSERT INTO pacto.isolamentosocial VALUES (5532, '2020-02-22', 'Plácido de Castro', 33.16);
INSERT INTO pacto.isolamentosocial VALUES (5533, '2020-02-23', 'Plácido de Castro', 40.82);
INSERT INTO pacto.isolamentosocial VALUES (5534, '2020-02-24', 'Plácido de Castro', 32.26);
INSERT INTO pacto.isolamentosocial VALUES (5535, '2020-02-25', 'Plácido de Castro', 39.36);
INSERT INTO pacto.isolamentosocial VALUES (5536, '2020-02-26', 'Plácido de Castro', 33.84);
INSERT INTO pacto.isolamentosocial VALUES (5537, '2020-02-27', 'Plácido de Castro', 23.50);
INSERT INTO pacto.isolamentosocial VALUES (5538, '2020-02-28', 'Plácido de Castro', 32.80);
INSERT INTO pacto.isolamentosocial VALUES (5539, '2020-02-29', 'Plácido de Castro', 34.83);
INSERT INTO pacto.isolamentosocial VALUES (5540, '2020-03-01', 'Plácido de Castro', 34.43);
INSERT INTO pacto.isolamentosocial VALUES (5541, '2020-03-02', 'Plácido de Castro', 25.39);
INSERT INTO pacto.isolamentosocial VALUES (5542, '2020-03-03', 'Plácido de Castro', 28.88);
INSERT INTO pacto.isolamentosocial VALUES (5543, '2020-03-04', 'Plácido de Castro', 36.11);
INSERT INTO pacto.isolamentosocial VALUES (5544, '2020-03-05', 'Plácido de Castro', 34.95);
INSERT INTO pacto.isolamentosocial VALUES (5545, '2020-03-06', 'Plácido de Castro', 25.26);
INSERT INTO pacto.isolamentosocial VALUES (5546, '2020-03-07', 'Plácido de Castro', 35.44);
INSERT INTO pacto.isolamentosocial VALUES (5547, '2020-03-08', 'Plácido de Castro', 38.97);
INSERT INTO pacto.isolamentosocial VALUES (5548, '2020-03-09', 'Plácido de Castro', 26.06);
INSERT INTO pacto.isolamentosocial VALUES (5549, '2020-03-10', 'Plácido de Castro', 31.47);
INSERT INTO pacto.isolamentosocial VALUES (5550, '2020-03-11', 'Plácido de Castro', 28.08);
INSERT INTO pacto.isolamentosocial VALUES (5551, '2020-03-12', 'Plácido de Castro', 32.63);
INSERT INTO pacto.isolamentosocial VALUES (5552, '2020-03-13', 'Plácido de Castro', 35.53);
INSERT INTO pacto.isolamentosocial VALUES (5553, '2020-03-14', 'Plácido de Castro', 41.20);
INSERT INTO pacto.isolamentosocial VALUES (5554, '2020-03-15', 'Plácido de Castro', 46.70);
INSERT INTO pacto.isolamentosocial VALUES (5555, '2020-03-16', 'Plácido de Castro', 38.83);
INSERT INTO pacto.isolamentosocial VALUES (5556, '2020-03-17', 'Plácido de Castro', 35.89);
INSERT INTO pacto.isolamentosocial VALUES (5557, '2020-03-18', 'Plácido de Castro', 34.01);
INSERT INTO pacto.isolamentosocial VALUES (5558, '2020-03-19', 'Plácido de Castro', 35.58);
INSERT INTO pacto.isolamentosocial VALUES (5559, '2020-03-20', 'Plácido de Castro', 41.24);
INSERT INTO pacto.isolamentosocial VALUES (5560, '2020-03-21', 'Plácido de Castro', 47.03);
INSERT INTO pacto.isolamentosocial VALUES (5561, '2020-03-22', 'Plácido de Castro', 54.64);
INSERT INTO pacto.isolamentosocial VALUES (5402, '2020-03-18', 'Manoel Urbano', 42.86);
INSERT INTO pacto.isolamentosocial VALUES (5562, '2020-03-23', 'Plácido de Castro', 47.17);
INSERT INTO pacto.isolamentosocial VALUES (5563, '2020-03-24', 'Plácido de Castro', 56.25);
INSERT INTO pacto.isolamentosocial VALUES (5564, '2020-03-25', 'Plácido de Castro', 46.24);
INSERT INTO pacto.isolamentosocial VALUES (5565, '2020-03-26', 'Plácido de Castro', 43.65);
INSERT INTO pacto.isolamentosocial VALUES (5566, '2020-03-27', 'Plácido de Castro', 45.45);
INSERT INTO pacto.isolamentosocial VALUES (5567, '2020-03-28', 'Plácido de Castro', 53.44);
INSERT INTO pacto.isolamentosocial VALUES (5568, '2020-03-29', 'Plácido de Castro', 48.92);
INSERT INTO pacto.isolamentosocial VALUES (5569, '2020-03-30', 'Plácido de Castro', 41.49);
INSERT INTO pacto.isolamentosocial VALUES (5570, '2020-03-31', 'Plácido de Castro', 43.52);
INSERT INTO pacto.isolamentosocial VALUES (5571, '2020-04-01', 'Plácido de Castro', 39.51);
INSERT INTO pacto.isolamentosocial VALUES (5572, '2020-04-02', 'Plácido de Castro', 42.86);
INSERT INTO pacto.isolamentosocial VALUES (5573, '2020-04-03', 'Plácido de Castro', 48.47);
INSERT INTO pacto.isolamentosocial VALUES (5574, '2020-04-04', 'Plácido de Castro', 43.72);
INSERT INTO pacto.isolamentosocial VALUES (5575, '2020-04-05', 'Plácido de Castro', 49.15);
INSERT INTO pacto.isolamentosocial VALUES (5576, '2020-04-06', 'Plácido de Castro', 46.70);
INSERT INTO pacto.isolamentosocial VALUES (5577, '2020-04-07', 'Plácido de Castro', 43.56);
INSERT INTO pacto.isolamentosocial VALUES (5578, '2020-04-08', 'Plácido de Castro', 39.90);
INSERT INTO pacto.isolamentosocial VALUES (5579, '2020-04-09', 'Plácido de Castro', 49.03);
INSERT INTO pacto.isolamentosocial VALUES (5580, '2020-04-10', 'Plácido de Castro', 50.79);
INSERT INTO pacto.isolamentosocial VALUES (5581, '2020-04-11', 'Plácido de Castro', 49.73);
INSERT INTO pacto.isolamentosocial VALUES (5582, '2020-04-12', 'Plácido de Castro', 52.36);
INSERT INTO pacto.isolamentosocial VALUES (5583, '2020-04-13', 'Plácido de Castro', 46.63);
INSERT INTO pacto.isolamentosocial VALUES (5584, '2020-04-14', 'Plácido de Castro', 44.67);
INSERT INTO pacto.isolamentosocial VALUES (5585, '2020-04-15', 'Plácido de Castro', 49.24);
INSERT INTO pacto.isolamentosocial VALUES (5586, '2020-04-16', 'Plácido de Castro', 40.69);
INSERT INTO pacto.isolamentosocial VALUES (5587, '2020-04-17', 'Plácido de Castro', 44.66);
INSERT INTO pacto.isolamentosocial VALUES (5588, '2020-04-18', 'Plácido de Castro', 50.78);
INSERT INTO pacto.isolamentosocial VALUES (5589, '2020-04-19', 'Plácido de Castro', 52.72);
INSERT INTO pacto.isolamentosocial VALUES (5590, '2020-04-20', 'Plácido de Castro', 41.71);
INSERT INTO pacto.isolamentosocial VALUES (5591, '2020-04-21', 'Plácido de Castro', 47.12);
INSERT INTO pacto.isolamentosocial VALUES (5592, '2020-04-22', 'Plácido de Castro', 41.87);
INSERT INTO pacto.isolamentosocial VALUES (5593, '2020-04-23', 'Plácido de Castro', 35.75);
INSERT INTO pacto.isolamentosocial VALUES (5594, '2020-04-24', 'Plácido de Castro', 35.11);
INSERT INTO pacto.isolamentosocial VALUES (5595, '2020-04-25', 'Plácido de Castro', 44.97);
INSERT INTO pacto.isolamentosocial VALUES (5596, '2020-04-26', 'Plácido de Castro', 53.93);
INSERT INTO pacto.isolamentosocial VALUES (5597, '2020-04-27', 'Plácido de Castro', 39.58);
INSERT INTO pacto.isolamentosocial VALUES (5598, '2020-04-28', 'Plácido de Castro', 44.49);
INSERT INTO pacto.isolamentosocial VALUES (5599, '2020-04-29', 'Plácido de Castro', 42.36);
INSERT INTO pacto.isolamentosocial VALUES (5600, '2020-04-30', 'Plácido de Castro', 38.86);
INSERT INTO pacto.isolamentosocial VALUES (5601, '2020-05-01', 'Plácido de Castro', 48.11);
INSERT INTO pacto.isolamentosocial VALUES (5602, '2020-05-02', 'Plácido de Castro', 46.30);
INSERT INTO pacto.isolamentosocial VALUES (5603, '2020-05-03', 'Plácido de Castro', 51.56);
INSERT INTO pacto.isolamentosocial VALUES (5604, '2020-05-04', 'Plácido de Castro', 42.49);
INSERT INTO pacto.isolamentosocial VALUES (5605, '2020-05-05', 'Plácido de Castro', 50.00);
INSERT INTO pacto.isolamentosocial VALUES (5607, '2020-05-07', 'Plácido de Castro', 47.51);
INSERT INTO pacto.isolamentosocial VALUES (5608, '2020-05-08', 'Plácido de Castro', 48.44);
INSERT INTO pacto.isolamentosocial VALUES (5609, '2020-05-09', 'Plácido de Castro', 50.22);
INSERT INTO pacto.isolamentosocial VALUES (5610, '2020-05-10', 'Plácido de Castro', 48.92);
INSERT INTO pacto.isolamentosocial VALUES (5611, '2020-05-11', 'Plácido de Castro', 37.66);
INSERT INTO pacto.isolamentosocial VALUES (5612, '2020-05-12', 'Plácido de Castro', 42.80);
INSERT INTO pacto.isolamentosocial VALUES (5613, '2020-05-13', 'Plácido de Castro', 47.56);
INSERT INTO pacto.isolamentosocial VALUES (5615, '2020-05-15', 'Plácido de Castro', 48.62);
INSERT INTO pacto.isolamentosocial VALUES (5616, '2020-05-16', 'Plácido de Castro', 43.86);
INSERT INTO pacto.isolamentosocial VALUES (5617, '2020-05-17', 'Plácido de Castro', 58.85);
INSERT INTO pacto.isolamentosocial VALUES (5618, '2020-05-18', 'Plácido de Castro', 43.81);
INSERT INTO pacto.isolamentosocial VALUES (5619, '2020-05-19', 'Plácido de Castro', 52.26);
INSERT INTO pacto.isolamentosocial VALUES (5620, '2020-05-20', 'Plácido de Castro', 48.44);
INSERT INTO pacto.isolamentosocial VALUES (5621, '2020-05-21', 'Plácido de Castro', 43.03);
INSERT INTO pacto.isolamentosocial VALUES (5622, '2020-05-22', 'Plácido de Castro', 46.67);
INSERT INTO pacto.isolamentosocial VALUES (5623, '2020-05-23', 'Plácido de Castro', 53.28);
INSERT INTO pacto.isolamentosocial VALUES (5624, '2020-05-24', 'Plácido de Castro', 58.37);
INSERT INTO pacto.isolamentosocial VALUES (5625, '2020-05-25', 'Plácido de Castro', 40.56);
INSERT INTO pacto.isolamentosocial VALUES (5626, '2020-05-26', 'Plácido de Castro', 43.97);
INSERT INTO pacto.isolamentosocial VALUES (5627, '2020-05-27', 'Plácido de Castro', 43.61);
INSERT INTO pacto.isolamentosocial VALUES (5628, '2020-05-28', 'Plácido de Castro', 43.82);
INSERT INTO pacto.isolamentosocial VALUES (5629, '2020-05-29', 'Plácido de Castro', 43.60);
INSERT INTO pacto.isolamentosocial VALUES (5630, '2020-05-30', 'Plácido de Castro', 49.57);
INSERT INTO pacto.isolamentosocial VALUES (5631, '2020-05-31', 'Plácido de Castro', 45.78);
INSERT INTO pacto.isolamentosocial VALUES (5632, '2020-06-01', 'Plácido de Castro', 40.52);
INSERT INTO pacto.isolamentosocial VALUES (5633, '2020-06-02', 'Plácido de Castro', 38.82);
INSERT INTO pacto.isolamentosocial VALUES (5634, '2020-06-03', 'Plácido de Castro', 39.22);
INSERT INTO pacto.isolamentosocial VALUES (5635, '2020-06-04', 'Plácido de Castro', 38.20);
INSERT INTO pacto.isolamentosocial VALUES (5637, '2020-06-06', 'Plácido de Castro', 45.78);
INSERT INTO pacto.isolamentosocial VALUES (5638, '2020-06-07', 'Plácido de Castro', 54.09);
INSERT INTO pacto.isolamentosocial VALUES (5639, '2020-06-08', 'Plácido de Castro', 37.07);
INSERT INTO pacto.isolamentosocial VALUES (5640, '2020-06-09', 'Plácido de Castro', 39.84);
INSERT INTO pacto.isolamentosocial VALUES (5641, '2020-06-10', 'Plácido de Castro', 40.51);
INSERT INTO pacto.isolamentosocial VALUES (5642, '2020-06-11', 'Plácido de Castro', 41.77);
INSERT INTO pacto.isolamentosocial VALUES (5643, '2020-06-12', 'Plácido de Castro', 40.33);
INSERT INTO pacto.isolamentosocial VALUES (5644, '2020-06-13', 'Plácido de Castro', 39.74);
INSERT INTO pacto.isolamentosocial VALUES (5645, '2020-06-14', 'Plácido de Castro', 49.79);
INSERT INTO pacto.isolamentosocial VALUES (5646, '2020-06-15', 'Plácido de Castro', 44.80);
INSERT INTO pacto.isolamentosocial VALUES (5647, '2020-06-16', 'Plácido de Castro', 39.85);
INSERT INTO pacto.isolamentosocial VALUES (5648, '2020-06-17', 'Plácido de Castro', 37.69);
INSERT INTO pacto.isolamentosocial VALUES (5649, '2020-06-18', 'Plácido de Castro', 42.37);
INSERT INTO pacto.isolamentosocial VALUES (5650, '2020-06-19', 'Plácido de Castro', 37.50);
INSERT INTO pacto.isolamentosocial VALUES (5651, '2020-06-20', 'Plácido de Castro', 38.98);
INSERT INTO pacto.isolamentosocial VALUES (5652, '2020-06-21', 'Plácido de Castro', 52.38);
INSERT INTO pacto.isolamentosocial VALUES (5653, '2020-06-22', 'Plácido de Castro', 35.97);
INSERT INTO pacto.isolamentosocial VALUES (5654, '2020-06-23', 'Plácido de Castro', 33.06);
INSERT INTO pacto.isolamentosocial VALUES (5655, '2020-06-24', 'Plácido de Castro', 37.25);
INSERT INTO pacto.isolamentosocial VALUES (5656, '2020-06-25', 'Plácido de Castro', 38.43);
INSERT INTO pacto.isolamentosocial VALUES (5657, '2020-06-26', 'Plácido de Castro', 38.08);
INSERT INTO pacto.isolamentosocial VALUES (5658, '2020-06-27', 'Plácido de Castro', 51.49);
INSERT INTO pacto.isolamentosocial VALUES (5659, '2020-06-28', 'Plácido de Castro', 50.00);
INSERT INTO pacto.isolamentosocial VALUES (5660, '2020-06-29', 'Plácido de Castro', 40.14);
INSERT INTO pacto.isolamentosocial VALUES (5661, '2020-06-30', 'Plácido de Castro', 41.47);
INSERT INTO pacto.isolamentosocial VALUES (5662, '2020-07-01', 'Plácido de Castro', 45.72);
INSERT INTO pacto.isolamentosocial VALUES (5663, '2020-07-02', 'Plácido de Castro', 47.81);
INSERT INTO pacto.isolamentosocial VALUES (5664, '2020-07-03', 'Plácido de Castro', 42.25);
INSERT INTO pacto.isolamentosocial VALUES (5665, '2020-02-01', 'Porto Acre', 38.89);
INSERT INTO pacto.isolamentosocial VALUES (5666, '2020-02-02', 'Porto Acre', 36.26);
INSERT INTO pacto.isolamentosocial VALUES (5667, '2020-02-03', 'Porto Acre', 32.37);
INSERT INTO pacto.isolamentosocial VALUES (5668, '2020-02-04', 'Porto Acre', 32.29);
INSERT INTO pacto.isolamentosocial VALUES (5669, '2020-02-05', 'Porto Acre', 35.42);
INSERT INTO pacto.isolamentosocial VALUES (5670, '2020-02-06', 'Porto Acre', 30.00);
INSERT INTO pacto.isolamentosocial VALUES (5671, '2020-02-07', 'Porto Acre', 30.96);
INSERT INTO pacto.isolamentosocial VALUES (5672, '2020-02-08', 'Porto Acre', 27.37);
INSERT INTO pacto.isolamentosocial VALUES (5673, '2020-02-09', 'Porto Acre', 35.71);
INSERT INTO pacto.isolamentosocial VALUES (5674, '2020-02-10', 'Porto Acre', 27.18);
INSERT INTO pacto.isolamentosocial VALUES (5675, '2020-02-11', 'Porto Acre', 29.41);
INSERT INTO pacto.isolamentosocial VALUES (5676, '2020-02-12', 'Porto Acre', 27.72);
INSERT INTO pacto.isolamentosocial VALUES (5677, '2020-02-13', 'Porto Acre', 32.80);
INSERT INTO pacto.isolamentosocial VALUES (5678, '2020-02-14', 'Porto Acre', 35.08);
INSERT INTO pacto.isolamentosocial VALUES (5679, '2020-02-15', 'Porto Acre', 36.36);
INSERT INTO pacto.isolamentosocial VALUES (5680, '2020-02-16', 'Porto Acre', 42.33);
INSERT INTO pacto.isolamentosocial VALUES (5681, '2020-02-17', 'Porto Acre', 26.44);
INSERT INTO pacto.isolamentosocial VALUES (5682, '2020-02-18', 'Porto Acre', 34.09);
INSERT INTO pacto.isolamentosocial VALUES (5683, '2020-02-19', 'Porto Acre', 40.22);
INSERT INTO pacto.isolamentosocial VALUES (5684, '2020-02-20', 'Porto Acre', 31.55);
INSERT INTO pacto.isolamentosocial VALUES (5685, '2020-02-21', 'Porto Acre', 31.25);
INSERT INTO pacto.isolamentosocial VALUES (5686, '2020-02-22', 'Porto Acre', 40.56);
INSERT INTO pacto.isolamentosocial VALUES (5687, '2020-02-23', 'Porto Acre', 47.25);
INSERT INTO pacto.isolamentosocial VALUES (5688, '2020-02-24', 'Porto Acre', 37.31);
INSERT INTO pacto.isolamentosocial VALUES (5689, '2020-02-25', 'Porto Acre', 48.97);
INSERT INTO pacto.isolamentosocial VALUES (5690, '2020-02-26', 'Porto Acre', 41.18);
INSERT INTO pacto.isolamentosocial VALUES (5691, '2020-02-27', 'Porto Acre', 36.90);
INSERT INTO pacto.isolamentosocial VALUES (5692, '2020-02-28', 'Porto Acre', 34.01);
INSERT INTO pacto.isolamentosocial VALUES (5693, '2020-02-29', 'Porto Acre', 36.70);
INSERT INTO pacto.isolamentosocial VALUES (5694, '2020-03-01', 'Porto Acre', 49.21);
INSERT INTO pacto.isolamentosocial VALUES (5695, '2020-03-02', 'Porto Acre', 30.17);
INSERT INTO pacto.isolamentosocial VALUES (5696, '2020-03-03', 'Porto Acre', 30.54);
INSERT INTO pacto.isolamentosocial VALUES (5697, '2020-03-04', 'Porto Acre', 41.75);
INSERT INTO pacto.isolamentosocial VALUES (5698, '2020-03-05', 'Porto Acre', 35.12);
INSERT INTO pacto.isolamentosocial VALUES (5699, '2020-03-06', 'Porto Acre', 44.50);
INSERT INTO pacto.isolamentosocial VALUES (5700, '2020-03-07', 'Porto Acre', 39.22);
INSERT INTO pacto.isolamentosocial VALUES (5701, '2020-03-08', 'Porto Acre', 36.04);
INSERT INTO pacto.isolamentosocial VALUES (5703, '2020-03-10', 'Porto Acre', 40.31);
INSERT INTO pacto.isolamentosocial VALUES (5704, '2020-03-11', 'Porto Acre', 34.20);
INSERT INTO pacto.isolamentosocial VALUES (5705, '2020-03-12', 'Porto Acre', 31.90);
INSERT INTO pacto.isolamentosocial VALUES (5706, '2020-03-13', 'Porto Acre', 36.36);
INSERT INTO pacto.isolamentosocial VALUES (5707, '2020-03-14', 'Porto Acre', 38.12);
INSERT INTO pacto.isolamentosocial VALUES (5708, '2020-03-15', 'Porto Acre', 51.35);
INSERT INTO pacto.isolamentosocial VALUES (5709, '2020-03-16', 'Porto Acre', 31.90);
INSERT INTO pacto.isolamentosocial VALUES (5710, '2020-03-17', 'Porto Acre', 37.23);
INSERT INTO pacto.isolamentosocial VALUES (5711, '2020-03-18', 'Porto Acre', 49.25);
INSERT INTO pacto.isolamentosocial VALUES (5712, '2020-03-19', 'Porto Acre', 42.13);
INSERT INTO pacto.isolamentosocial VALUES (5713, '2020-03-20', 'Porto Acre', 47.69);
INSERT INTO pacto.isolamentosocial VALUES (5714, '2020-03-21', 'Porto Acre', 50.24);
INSERT INTO pacto.isolamentosocial VALUES (5715, '2020-03-22', 'Porto Acre', 59.57);
INSERT INTO pacto.isolamentosocial VALUES (5716, '2020-03-23', 'Porto Acre', 49.53);
INSERT INTO pacto.isolamentosocial VALUES (5717, '2020-03-24', 'Porto Acre', 52.58);
INSERT INTO pacto.isolamentosocial VALUES (5718, '2020-03-25', 'Porto Acre', 56.28);
INSERT INTO pacto.isolamentosocial VALUES (5719, '2020-03-26', 'Porto Acre', 48.35);
INSERT INTO pacto.isolamentosocial VALUES (5720, '2020-03-27', 'Porto Acre', 53.72);
INSERT INTO pacto.isolamentosocial VALUES (5721, '2020-03-28', 'Porto Acre', 49.45);
INSERT INTO pacto.isolamentosocial VALUES (5722, '2020-03-29', 'Porto Acre', 53.80);
INSERT INTO pacto.isolamentosocial VALUES (5723, '2020-03-30', 'Porto Acre', 43.78);
INSERT INTO pacto.isolamentosocial VALUES (5724, '2020-03-31', 'Porto Acre', 51.00);
INSERT INTO pacto.isolamentosocial VALUES (5725, '2020-04-01', 'Porto Acre', 50.26);
INSERT INTO pacto.isolamentosocial VALUES (5726, '2020-04-02', 'Porto Acre', 55.29);
INSERT INTO pacto.isolamentosocial VALUES (5727, '2020-04-03', 'Porto Acre', 51.34);
INSERT INTO pacto.isolamentosocial VALUES (5728, '2020-04-04', 'Porto Acre', 55.49);
INSERT INTO pacto.isolamentosocial VALUES (5729, '2020-04-05', 'Porto Acre', 58.79);
INSERT INTO pacto.isolamentosocial VALUES (5730, '2020-04-06', 'Porto Acre', 48.74);
INSERT INTO pacto.isolamentosocial VALUES (5731, '2020-04-07', 'Porto Acre', 47.15);
INSERT INTO pacto.isolamentosocial VALUES (5732, '2020-04-08', 'Porto Acre', 50.25);
INSERT INTO pacto.isolamentosocial VALUES (5733, '2020-04-09', 'Porto Acre', 48.31);
INSERT INTO pacto.isolamentosocial VALUES (5734, '2020-04-10', 'Porto Acre', 54.76);
INSERT INTO pacto.isolamentosocial VALUES (5735, '2020-04-11', 'Porto Acre', 47.03);
INSERT INTO pacto.isolamentosocial VALUES (5736, '2020-04-12', 'Porto Acre', 48.45);
INSERT INTO pacto.isolamentosocial VALUES (5737, '2020-04-13', 'Porto Acre', 48.47);
INSERT INTO pacto.isolamentosocial VALUES (5738, '2020-04-14', 'Porto Acre', 49.76);
INSERT INTO pacto.isolamentosocial VALUES (5739, '2020-04-15', 'Porto Acre', 49.26);
INSERT INTO pacto.isolamentosocial VALUES (5740, '2020-04-16', 'Porto Acre', 46.92);
INSERT INTO pacto.isolamentosocial VALUES (5741, '2020-04-17', 'Porto Acre', 44.14);
INSERT INTO pacto.isolamentosocial VALUES (5742, '2020-04-18', 'Porto Acre', 47.17);
INSERT INTO pacto.isolamentosocial VALUES (5743, '2020-04-19', 'Porto Acre', 50.00);
INSERT INTO pacto.isolamentosocial VALUES (5744, '2020-04-20', 'Porto Acre', 47.78);
INSERT INTO pacto.isolamentosocial VALUES (5745, '2020-04-21', 'Porto Acre', 51.33);
INSERT INTO pacto.isolamentosocial VALUES (5746, '2020-04-22', 'Porto Acre', 48.88);
INSERT INTO pacto.isolamentosocial VALUES (5747, '2020-04-23', 'Porto Acre', 46.19);
INSERT INTO pacto.isolamentosocial VALUES (5748, '2020-04-24', 'Porto Acre', 45.25);
INSERT INTO pacto.isolamentosocial VALUES (5749, '2020-04-25', 'Porto Acre', 52.63);
INSERT INTO pacto.isolamentosocial VALUES (5750, '2020-04-26', 'Porto Acre', 50.23);
INSERT INTO pacto.isolamentosocial VALUES (5751, '2020-04-27', 'Porto Acre', 46.55);
INSERT INTO pacto.isolamentosocial VALUES (5752, '2020-04-28', 'Porto Acre', 43.10);
INSERT INTO pacto.isolamentosocial VALUES (5753, '2020-04-29', 'Porto Acre', 42.22);
INSERT INTO pacto.isolamentosocial VALUES (5754, '2020-04-30', 'Porto Acre', 38.58);
INSERT INTO pacto.isolamentosocial VALUES (5756, '2020-05-02', 'Porto Acre', 44.40);
INSERT INTO pacto.isolamentosocial VALUES (5757, '2020-05-03', 'Porto Acre', 51.03);
INSERT INTO pacto.isolamentosocial VALUES (5758, '2020-05-04', 'Porto Acre', 47.64);
INSERT INTO pacto.isolamentosocial VALUES (5759, '2020-05-05', 'Porto Acre', 50.98);
INSERT INTO pacto.isolamentosocial VALUES (5760, '2020-05-06', 'Porto Acre', 44.70);
INSERT INTO pacto.isolamentosocial VALUES (5761, '2020-05-07', 'Porto Acre', 46.54);
INSERT INTO pacto.isolamentosocial VALUES (5762, '2020-05-08', 'Porto Acre', 45.02);
INSERT INTO pacto.isolamentosocial VALUES (5763, '2020-05-09', 'Porto Acre', 47.49);
INSERT INTO pacto.isolamentosocial VALUES (5764, '2020-05-10', 'Porto Acre', 48.21);
INSERT INTO pacto.isolamentosocial VALUES (5765, '2020-05-11', 'Porto Acre', 48.13);
INSERT INTO pacto.isolamentosocial VALUES (5766, '2020-05-12', 'Porto Acre', 46.28);
INSERT INTO pacto.isolamentosocial VALUES (5767, '2020-05-13', 'Porto Acre', 41.32);
INSERT INTO pacto.isolamentosocial VALUES (5768, '2020-05-14', 'Porto Acre', 53.60);
INSERT INTO pacto.isolamentosocial VALUES (5769, '2020-05-15', 'Porto Acre', 53.41);
INSERT INTO pacto.isolamentosocial VALUES (5771, '2020-05-17', 'Porto Acre', 54.14);
INSERT INTO pacto.isolamentosocial VALUES (5772, '2020-05-18', 'Porto Acre', 51.18);
INSERT INTO pacto.isolamentosocial VALUES (5773, '2020-05-19', 'Porto Acre', 47.17);
INSERT INTO pacto.isolamentosocial VALUES (5774, '2020-05-20', 'Porto Acre', 50.76);
INSERT INTO pacto.isolamentosocial VALUES (5775, '2020-05-21', 'Porto Acre', 47.67);
INSERT INTO pacto.isolamentosocial VALUES (5776, '2020-05-22', 'Porto Acre', 44.05);
INSERT INTO pacto.isolamentosocial VALUES (5777, '2020-05-23', 'Porto Acre', 49.60);
INSERT INTO pacto.isolamentosocial VALUES (5778, '2020-05-24', 'Porto Acre', 55.56);
INSERT INTO pacto.isolamentosocial VALUES (5779, '2020-05-25', 'Porto Acre', 42.12);
INSERT INTO pacto.isolamentosocial VALUES (5780, '2020-05-26', 'Porto Acre', 48.90);
INSERT INTO pacto.isolamentosocial VALUES (5781, '2020-05-27', 'Porto Acre', 47.69);
INSERT INTO pacto.isolamentosocial VALUES (5782, '2020-05-28', 'Porto Acre', 48.45);
INSERT INTO pacto.isolamentosocial VALUES (5783, '2020-05-29', 'Porto Acre', 42.86);
INSERT INTO pacto.isolamentosocial VALUES (5784, '2020-05-30', 'Porto Acre', 49.80);
INSERT INTO pacto.isolamentosocial VALUES (5785, '2020-05-31', 'Porto Acre', 57.02);
INSERT INTO pacto.isolamentosocial VALUES (5786, '2020-06-01', 'Porto Acre', 42.39);
INSERT INTO pacto.isolamentosocial VALUES (5787, '2020-06-02', 'Porto Acre', 46.64);
INSERT INTO pacto.isolamentosocial VALUES (5788, '2020-06-03', 'Porto Acre', 55.06);
INSERT INTO pacto.isolamentosocial VALUES (5789, '2020-06-04', 'Porto Acre', 53.01);
INSERT INTO pacto.isolamentosocial VALUES (5790, '2020-06-05', 'Porto Acre', 49.32);
INSERT INTO pacto.isolamentosocial VALUES (5791, '2020-06-06', 'Porto Acre', 50.61);
INSERT INTO pacto.isolamentosocial VALUES (5792, '2020-06-07', 'Porto Acre', 58.17);
INSERT INTO pacto.isolamentosocial VALUES (5793, '2020-06-08', 'Porto Acre', 42.35);
INSERT INTO pacto.isolamentosocial VALUES (5794, '2020-06-09', 'Porto Acre', 42.06);
INSERT INTO pacto.isolamentosocial VALUES (5795, '2020-06-10', 'Porto Acre', 46.88);
INSERT INTO pacto.isolamentosocial VALUES (5796, '2020-06-11', 'Porto Acre', 52.59);
INSERT INTO pacto.isolamentosocial VALUES (5797, '2020-06-12', 'Porto Acre', 41.04);
INSERT INTO pacto.isolamentosocial VALUES (5798, '2020-06-13', 'Porto Acre', 52.51);
INSERT INTO pacto.isolamentosocial VALUES (5799, '2020-06-14', 'Porto Acre', 56.35);
INSERT INTO pacto.isolamentosocial VALUES (5800, '2020-06-15', 'Porto Acre', 44.02);
INSERT INTO pacto.isolamentosocial VALUES (5801, '2020-06-16', 'Porto Acre', 42.80);
INSERT INTO pacto.isolamentosocial VALUES (5802, '2020-06-17', 'Porto Acre', 39.15);
INSERT INTO pacto.isolamentosocial VALUES (5803, '2020-06-18', 'Porto Acre', 43.75);
INSERT INTO pacto.isolamentosocial VALUES (5804, '2020-06-19', 'Porto Acre', 37.45);
INSERT INTO pacto.isolamentosocial VALUES (5805, '2020-06-20', 'Porto Acre', 44.79);
INSERT INTO pacto.isolamentosocial VALUES (5806, '2020-06-21', 'Porto Acre', 50.60);
INSERT INTO pacto.isolamentosocial VALUES (5807, '2020-06-22', 'Porto Acre', 47.00);
INSERT INTO pacto.isolamentosocial VALUES (5808, '2020-06-23', 'Porto Acre', 44.95);
INSERT INTO pacto.isolamentosocial VALUES (5809, '2020-06-24', 'Porto Acre', 46.32);
INSERT INTO pacto.isolamentosocial VALUES (5810, '2020-06-25', 'Porto Acre', 42.03);
INSERT INTO pacto.isolamentosocial VALUES (5811, '2020-06-26', 'Porto Acre', 42.24);
INSERT INTO pacto.isolamentosocial VALUES (5812, '2020-06-27', 'Porto Acre', 49.68);
INSERT INTO pacto.isolamentosocial VALUES (5813, '2020-06-28', 'Porto Acre', 51.64);
INSERT INTO pacto.isolamentosocial VALUES (5814, '2020-06-29', 'Porto Acre', 45.00);
INSERT INTO pacto.isolamentosocial VALUES (5815, '2020-06-30', 'Porto Acre', 43.30);
INSERT INTO pacto.isolamentosocial VALUES (5816, '2020-07-01', 'Porto Acre', 44.79);
INSERT INTO pacto.isolamentosocial VALUES (5817, '2020-07-02', 'Porto Acre', 44.85);
INSERT INTO pacto.isolamentosocial VALUES (5818, '2020-07-03', 'Porto Acre', 45.91);
INSERT INTO pacto.isolamentosocial VALUES (5819, '2020-02-01', 'Rio Branco', 36.27);
INSERT INTO pacto.isolamentosocial VALUES (5820, '2020-02-02', 'Rio Branco', 42.28);
INSERT INTO pacto.isolamentosocial VALUES (5821, '2020-02-03', 'Rio Branco', 29.61);
INSERT INTO pacto.isolamentosocial VALUES (5822, '2020-02-04', 'Rio Branco', 30.54);
INSERT INTO pacto.isolamentosocial VALUES (5823, '2020-02-05', 'Rio Branco', 31.48);
INSERT INTO pacto.isolamentosocial VALUES (5824, '2020-02-06', 'Rio Branco', 31.32);
INSERT INTO pacto.isolamentosocial VALUES (5825, '2020-02-07', 'Rio Branco', 27.02);
INSERT INTO pacto.isolamentosocial VALUES (5826, '2020-02-08', 'Rio Branco', 31.41);
INSERT INTO pacto.isolamentosocial VALUES (5827, '2020-02-09', 'Rio Branco', 40.58);
INSERT INTO pacto.isolamentosocial VALUES (5828, '2020-02-10', 'Rio Branco', 27.32);
INSERT INTO pacto.isolamentosocial VALUES (5829, '2020-02-11', 'Rio Branco', 26.67);
INSERT INTO pacto.isolamentosocial VALUES (5830, '2020-02-12', 'Rio Branco', 27.46);
INSERT INTO pacto.isolamentosocial VALUES (5831, '2020-02-13', 'Rio Branco', 29.46);
INSERT INTO pacto.isolamentosocial VALUES (5832, '2020-02-14', 'Rio Branco', 29.46);
INSERT INTO pacto.isolamentosocial VALUES (5833, '2020-02-15', 'Rio Branco', 38.22);
INSERT INTO pacto.isolamentosocial VALUES (5834, '2020-02-16', 'Rio Branco', 43.89);
INSERT INTO pacto.isolamentosocial VALUES (5835, '2020-02-17', 'Rio Branco', 27.39);
INSERT INTO pacto.isolamentosocial VALUES (5836, '2020-02-18', 'Rio Branco', 30.23);
INSERT INTO pacto.isolamentosocial VALUES (5837, '2020-02-19', 'Rio Branco', 33.73);
INSERT INTO pacto.isolamentosocial VALUES (5838, '2020-02-20', 'Rio Branco', 28.85);
INSERT INTO pacto.isolamentosocial VALUES (5839, '2020-02-21', 'Rio Branco', 28.97);
INSERT INTO pacto.isolamentosocial VALUES (5840, '2020-02-22', 'Rio Branco', 36.03);
INSERT INTO pacto.isolamentosocial VALUES (5841, '2020-02-23', 'Rio Branco', 43.35);
INSERT INTO pacto.isolamentosocial VALUES (5842, '2020-02-24', 'Rio Branco', 37.93);
INSERT INTO pacto.isolamentosocial VALUES (5843, '2020-02-25', 'Rio Branco', 44.41);
INSERT INTO pacto.isolamentosocial VALUES (5844, '2020-02-26', 'Rio Branco', 38.24);
INSERT INTO pacto.isolamentosocial VALUES (5845, '2020-02-27', 'Rio Branco', 31.39);
INSERT INTO pacto.isolamentosocial VALUES (5846, '2020-02-28', 'Rio Branco', 29.54);
INSERT INTO pacto.isolamentosocial VALUES (5847, '2020-02-29', 'Rio Branco', 34.94);
INSERT INTO pacto.isolamentosocial VALUES (5848, '2020-03-01', 'Rio Branco', 46.86);
INSERT INTO pacto.isolamentosocial VALUES (5849, '2020-03-02', 'Rio Branco', 29.31);
INSERT INTO pacto.isolamentosocial VALUES (5850, '2020-03-03', 'Rio Branco', 32.05);
INSERT INTO pacto.isolamentosocial VALUES (5851, '2020-03-04', 'Rio Branco', 34.65);
INSERT INTO pacto.isolamentosocial VALUES (5852, '2020-03-05', 'Rio Branco', 34.93);
INSERT INTO pacto.isolamentosocial VALUES (5853, '2020-03-06', 'Rio Branco', 33.10);
INSERT INTO pacto.isolamentosocial VALUES (5854, '2020-03-07', 'Rio Branco', 36.44);
INSERT INTO pacto.isolamentosocial VALUES (5855, '2020-03-08', 'Rio Branco', 45.69);
INSERT INTO pacto.isolamentosocial VALUES (5856, '2020-03-09', 'Rio Branco', 32.88);
INSERT INTO pacto.isolamentosocial VALUES (5857, '2020-03-10', 'Rio Branco', 34.07);
INSERT INTO pacto.isolamentosocial VALUES (5858, '2020-03-11', 'Rio Branco', 32.52);
INSERT INTO pacto.isolamentosocial VALUES (5859, '2020-03-12', 'Rio Branco', 34.29);
INSERT INTO pacto.isolamentosocial VALUES (5860, '2020-03-13', 'Rio Branco', 35.87);
INSERT INTO pacto.isolamentosocial VALUES (5861, '2020-03-14', 'Rio Branco', 40.35);
INSERT INTO pacto.isolamentosocial VALUES (5862, '2020-03-15', 'Rio Branco', 47.35);
INSERT INTO pacto.isolamentosocial VALUES (5863, '2020-03-16', 'Rio Branco', 34.69);
INSERT INTO pacto.isolamentosocial VALUES (5864, '2020-03-17', 'Rio Branco', 34.72);
INSERT INTO pacto.isolamentosocial VALUES (5865, '2020-03-18', 'Rio Branco', 42.37);
INSERT INTO pacto.isolamentosocial VALUES (5866, '2020-03-19', 'Rio Branco', 44.01);
INSERT INTO pacto.isolamentosocial VALUES (5867, '2020-03-20', 'Rio Branco', 45.47);
INSERT INTO pacto.isolamentosocial VALUES (5868, '2020-03-21', 'Rio Branco', 54.72);
INSERT INTO pacto.isolamentosocial VALUES (5869, '2020-03-22', 'Rio Branco', 64.22);
INSERT INTO pacto.isolamentosocial VALUES (5870, '2020-03-23', 'Rio Branco', 55.18);
INSERT INTO pacto.isolamentosocial VALUES (5871, '2020-03-24', 'Rio Branco', 56.02);
INSERT INTO pacto.isolamentosocial VALUES (5872, '2020-03-25', 'Rio Branco', 54.87);
INSERT INTO pacto.isolamentosocial VALUES (5873, '2020-03-26', 'Rio Branco', 53.95);
INSERT INTO pacto.isolamentosocial VALUES (5874, '2020-03-27', 'Rio Branco', 51.42);
INSERT INTO pacto.isolamentosocial VALUES (5875, '2020-03-28', 'Rio Branco', 55.64);
INSERT INTO pacto.isolamentosocial VALUES (5876, '2020-03-29', 'Rio Branco', 59.54);
INSERT INTO pacto.isolamentosocial VALUES (5877, '2020-03-30', 'Rio Branco', 51.59);
INSERT INTO pacto.isolamentosocial VALUES (5878, '2020-03-31', 'Rio Branco', 48.78);
INSERT INTO pacto.isolamentosocial VALUES (5879, '2020-04-01', 'Rio Branco', 46.89);
INSERT INTO pacto.isolamentosocial VALUES (5880, '2020-04-02', 'Rio Branco', 49.95);
INSERT INTO pacto.isolamentosocial VALUES (5882, '2020-04-04', 'Rio Branco', 51.54);
INSERT INTO pacto.isolamentosocial VALUES (5883, '2020-04-05', 'Rio Branco', 58.91);
INSERT INTO pacto.isolamentosocial VALUES (5884, '2020-04-06', 'Rio Branco', 47.52);
INSERT INTO pacto.isolamentosocial VALUES (5885, '2020-04-07', 'Rio Branco', 46.57);
INSERT INTO pacto.isolamentosocial VALUES (5886, '2020-04-08', 'Rio Branco', 46.49);
INSERT INTO pacto.isolamentosocial VALUES (5887, '2020-04-09', 'Rio Branco', 46.68);
INSERT INTO pacto.isolamentosocial VALUES (5888, '2020-04-10', 'Rio Branco', 54.49);
INSERT INTO pacto.isolamentosocial VALUES (5889, '2020-04-11', 'Rio Branco', 49.32);
INSERT INTO pacto.isolamentosocial VALUES (5890, '2020-04-12', 'Rio Branco', 56.29);
INSERT INTO pacto.isolamentosocial VALUES (5891, '2020-04-13', 'Rio Branco', 47.38);
INSERT INTO pacto.isolamentosocial VALUES (5892, '2020-04-14', 'Rio Branco', 47.80);
INSERT INTO pacto.isolamentosocial VALUES (5893, '2020-04-15', 'Rio Branco', 52.61);
INSERT INTO pacto.isolamentosocial VALUES (5894, '2020-04-16', 'Rio Branco', 44.00);
INSERT INTO pacto.isolamentosocial VALUES (5895, '2020-04-17', 'Rio Branco', 45.95);
INSERT INTO pacto.isolamentosocial VALUES (5896, '2020-04-18', 'Rio Branco', 49.22);
INSERT INTO pacto.isolamentosocial VALUES (5897, '2020-04-19', 'Rio Branco', 57.54);
INSERT INTO pacto.isolamentosocial VALUES (5898, '2020-04-20', 'Rio Branco', 47.46);
INSERT INTO pacto.isolamentosocial VALUES (5899, '2020-04-21', 'Rio Branco', 54.23);
INSERT INTO pacto.isolamentosocial VALUES (5900, '2020-04-22', 'Rio Branco', 46.63);
INSERT INTO pacto.isolamentosocial VALUES (5901, '2020-04-23', 'Rio Branco', 47.52);
INSERT INTO pacto.isolamentosocial VALUES (5902, '2020-04-24', 'Rio Branco', 46.39);
INSERT INTO pacto.isolamentosocial VALUES (5903, '2020-04-25', 'Rio Branco', 49.53);
INSERT INTO pacto.isolamentosocial VALUES (5905, '2020-04-27', 'Rio Branco', 46.74);
INSERT INTO pacto.isolamentosocial VALUES (5906, '2020-04-28', 'Rio Branco', 46.37);
INSERT INTO pacto.isolamentosocial VALUES (5907, '2020-04-29', 'Rio Branco', 44.15);
INSERT INTO pacto.isolamentosocial VALUES (5908, '2020-04-30', 'Rio Branco', 43.75);
INSERT INTO pacto.isolamentosocial VALUES (5909, '2020-05-01', 'Rio Branco', 52.44);
INSERT INTO pacto.isolamentosocial VALUES (5910, '2020-05-02', 'Rio Branco', 47.45);
INSERT INTO pacto.isolamentosocial VALUES (5911, '2020-05-03', 'Rio Branco', 54.55);
INSERT INTO pacto.isolamentosocial VALUES (5912, '2020-05-04', 'Rio Branco', 46.21);
INSERT INTO pacto.isolamentosocial VALUES (5913, '2020-05-05', 'Rio Branco', 45.89);
INSERT INTO pacto.isolamentosocial VALUES (5914, '2020-05-06', 'Rio Branco', 46.11);
INSERT INTO pacto.isolamentosocial VALUES (5915, '2020-05-07', 'Rio Branco', 46.80);
INSERT INTO pacto.isolamentosocial VALUES (5916, '2020-05-08', 'Rio Branco', 46.58);
INSERT INTO pacto.isolamentosocial VALUES (5917, '2020-05-09', 'Rio Branco', 48.54);
INSERT INTO pacto.isolamentosocial VALUES (5918, '2020-05-10', 'Rio Branco', 51.78);
INSERT INTO pacto.isolamentosocial VALUES (5919, '2020-05-11', 'Rio Branco', 47.60);
INSERT INTO pacto.isolamentosocial VALUES (5920, '2020-05-12', 'Rio Branco', 48.54);
INSERT INTO pacto.isolamentosocial VALUES (5921, '2020-05-13', 'Rio Branco', 47.72);
INSERT INTO pacto.isolamentosocial VALUES (5922, '2020-05-14', 'Rio Branco', 50.95);
INSERT INTO pacto.isolamentosocial VALUES (5923, '2020-05-15', 'Rio Branco', 47.40);
INSERT INTO pacto.isolamentosocial VALUES (5924, '2020-05-16', 'Rio Branco', 50.04);
INSERT INTO pacto.isolamentosocial VALUES (5925, '2020-05-17', 'Rio Branco', 56.76);
INSERT INTO pacto.isolamentosocial VALUES (5926, '2020-05-18', 'Rio Branco', 51.15);
INSERT INTO pacto.isolamentosocial VALUES (5927, '2020-05-19', 'Rio Branco', 50.34);
INSERT INTO pacto.isolamentosocial VALUES (5928, '2020-05-20', 'Rio Branco', 48.87);
INSERT INTO pacto.isolamentosocial VALUES (5929, '2020-05-21', 'Rio Branco', 49.24);
INSERT INTO pacto.isolamentosocial VALUES (5930, '2020-05-22', 'Rio Branco', 48.24);
INSERT INTO pacto.isolamentosocial VALUES (5931, '2020-05-23', 'Rio Branco', 51.00);
INSERT INTO pacto.isolamentosocial VALUES (5932, '2020-05-24', 'Rio Branco', 59.37);
INSERT INTO pacto.isolamentosocial VALUES (5933, '2020-05-25', 'Rio Branco', 48.99);
INSERT INTO pacto.isolamentosocial VALUES (5934, '2020-05-26', 'Rio Branco', 47.83);
INSERT INTO pacto.isolamentosocial VALUES (5935, '2020-05-27', 'Rio Branco', 46.65);
INSERT INTO pacto.isolamentosocial VALUES (5936, '2020-05-28', 'Rio Branco', 47.50);
INSERT INTO pacto.isolamentosocial VALUES (5937, '2020-05-29', 'Rio Branco', 44.75);
INSERT INTO pacto.isolamentosocial VALUES (5938, '2020-05-30', 'Rio Branco', 48.34);
INSERT INTO pacto.isolamentosocial VALUES (5939, '2020-05-31', 'Rio Branco', 55.04);
INSERT INTO pacto.isolamentosocial VALUES (5940, '2020-06-01', 'Rio Branco', 44.27);
INSERT INTO pacto.isolamentosocial VALUES (5941, '2020-06-02', 'Rio Branco', 44.57);
INSERT INTO pacto.isolamentosocial VALUES (5942, '2020-06-03', 'Rio Branco', 43.69);
INSERT INTO pacto.isolamentosocial VALUES (5943, '2020-06-04', 'Rio Branco', 44.21);
INSERT INTO pacto.isolamentosocial VALUES (5944, '2020-06-05', 'Rio Branco', 44.44);
INSERT INTO pacto.isolamentosocial VALUES (5945, '2020-06-06', 'Rio Branco', 45.35);
INSERT INTO pacto.isolamentosocial VALUES (5946, '2020-06-07', 'Rio Branco', 53.86);
INSERT INTO pacto.isolamentosocial VALUES (5947, '2020-06-08', 'Rio Branco', 42.14);
INSERT INTO pacto.isolamentosocial VALUES (5948, '2020-06-09', 'Rio Branco', 42.10);
INSERT INTO pacto.isolamentosocial VALUES (5949, '2020-06-10', 'Rio Branco', 44.01);
INSERT INTO pacto.isolamentosocial VALUES (5950, '2020-06-11', 'Rio Branco', 46.93);
INSERT INTO pacto.isolamentosocial VALUES (5951, '2020-06-12', 'Rio Branco', 42.08);
INSERT INTO pacto.isolamentosocial VALUES (5952, '2020-06-13', 'Rio Branco', 44.95);
INSERT INTO pacto.isolamentosocial VALUES (5953, '2020-06-14', 'Rio Branco', 53.49);
INSERT INTO pacto.isolamentosocial VALUES (5954, '2020-06-15', 'Rio Branco', 46.81);
INSERT INTO pacto.isolamentosocial VALUES (5955, '2020-06-16', 'Rio Branco', 42.68);
INSERT INTO pacto.isolamentosocial VALUES (5956, '2020-06-17', 'Rio Branco', 41.21);
INSERT INTO pacto.isolamentosocial VALUES (5957, '2020-06-18', 'Rio Branco', 42.72);
INSERT INTO pacto.isolamentosocial VALUES (5958, '2020-06-19', 'Rio Branco', 37.96);
INSERT INTO pacto.isolamentosocial VALUES (5959, '2020-06-20', 'Rio Branco', 44.41);
INSERT INTO pacto.isolamentosocial VALUES (5960, '2020-06-21', 'Rio Branco', 53.27);
INSERT INTO pacto.isolamentosocial VALUES (5961, '2020-06-22', 'Rio Branco', 43.61);
INSERT INTO pacto.isolamentosocial VALUES (5962, '2020-06-23', 'Rio Branco', 42.99);
INSERT INTO pacto.isolamentosocial VALUES (5963, '2020-06-24', 'Rio Branco', 43.82);
INSERT INTO pacto.isolamentosocial VALUES (5964, '2020-06-25', 'Rio Branco', 43.43);
INSERT INTO pacto.isolamentosocial VALUES (5965, '2020-06-26', 'Rio Branco', 41.95);
INSERT INTO pacto.isolamentosocial VALUES (5966, '2020-06-27', 'Rio Branco', 46.59);
INSERT INTO pacto.isolamentosocial VALUES (5967, '2020-06-28', 'Rio Branco', 54.19);
INSERT INTO pacto.isolamentosocial VALUES (5968, '2020-06-29', 'Rio Branco', 44.55);
INSERT INTO pacto.isolamentosocial VALUES (5969, '2020-06-30', 'Rio Branco', 42.78);
INSERT INTO pacto.isolamentosocial VALUES (5970, '2020-07-01', 'Rio Branco', 42.81);
INSERT INTO pacto.isolamentosocial VALUES (5971, '2020-07-02', 'Rio Branco', 43.42);
INSERT INTO pacto.isolamentosocial VALUES (5972, '2020-07-03', 'Rio Branco', 41.54);
INSERT INTO pacto.isolamentosocial VALUES (5973, '2020-02-02', 'Rodrigues Alves', 50.00);
INSERT INTO pacto.isolamentosocial VALUES (5974, '2020-02-03', 'Rodrigues Alves', 33.33);
INSERT INTO pacto.isolamentosocial VALUES (5975, '2020-02-04', 'Rodrigues Alves', 47.83);
INSERT INTO pacto.isolamentosocial VALUES (5976, '2020-02-05', 'Rodrigues Alves', 45.45);
INSERT INTO pacto.isolamentosocial VALUES (5977, '2020-02-06', 'Rodrigues Alves', 39.13);
INSERT INTO pacto.isolamentosocial VALUES (5978, '2020-02-07', 'Rodrigues Alves', 37.04);
INSERT INTO pacto.isolamentosocial VALUES (5979, '2020-02-08', 'Rodrigues Alves', 41.67);
INSERT INTO pacto.isolamentosocial VALUES (5980, '2020-02-09', 'Rodrigues Alves', 37.93);
INSERT INTO pacto.isolamentosocial VALUES (5981, '2020-02-11', 'Rodrigues Alves', 28.00);
INSERT INTO pacto.isolamentosocial VALUES (5982, '2020-02-12', 'Rodrigues Alves', 36.36);
INSERT INTO pacto.isolamentosocial VALUES (5983, '2020-02-13', 'Rodrigues Alves', 30.43);
INSERT INTO pacto.isolamentosocial VALUES (5984, '2020-02-14', 'Rodrigues Alves', 36.00);
INSERT INTO pacto.isolamentosocial VALUES (5985, '2020-02-15', 'Rodrigues Alves', 34.62);
INSERT INTO pacto.isolamentosocial VALUES (5986, '2020-02-16', 'Rodrigues Alves', 47.83);
INSERT INTO pacto.isolamentosocial VALUES (5987, '2020-02-17', 'Rodrigues Alves', 22.73);
INSERT INTO pacto.isolamentosocial VALUES (5988, '2020-02-18', 'Rodrigues Alves', 41.67);
INSERT INTO pacto.isolamentosocial VALUES (5989, '2020-02-19', 'Rodrigues Alves', 50.00);
INSERT INTO pacto.isolamentosocial VALUES (5990, '2020-02-21', 'Rodrigues Alves', 23.81);
INSERT INTO pacto.isolamentosocial VALUES (5991, '2020-02-22', 'Rodrigues Alves', 55.00);
INSERT INTO pacto.isolamentosocial VALUES (5992, '2020-02-23', 'Rodrigues Alves', 33.33);
INSERT INTO pacto.isolamentosocial VALUES (5993, '2020-02-24', 'Rodrigues Alves', 50.00);
INSERT INTO pacto.isolamentosocial VALUES (5994, '2020-02-25', 'Rodrigues Alves', 40.00);
INSERT INTO pacto.isolamentosocial VALUES (5995, '2020-02-28', 'Rodrigues Alves', 55.00);
INSERT INTO pacto.isolamentosocial VALUES (5996, '2020-02-29', 'Rodrigues Alves', 18.52);
INSERT INTO pacto.isolamentosocial VALUES (5997, '2020-03-01', 'Rodrigues Alves', 42.86);
INSERT INTO pacto.isolamentosocial VALUES (5998, '2020-03-04', 'Rodrigues Alves', 50.00);
INSERT INTO pacto.isolamentosocial VALUES (5999, '2020-03-06', 'Rodrigues Alves', 28.57);
INSERT INTO pacto.isolamentosocial VALUES (6000, '2020-03-07', 'Rodrigues Alves', 42.86);
INSERT INTO pacto.isolamentosocial VALUES (6001, '2020-03-08', 'Rodrigues Alves', 42.86);
INSERT INTO pacto.isolamentosocial VALUES (6002, '2020-03-09', 'Rodrigues Alves', 40.91);
INSERT INTO pacto.isolamentosocial VALUES (6003, '2020-03-10', 'Rodrigues Alves', 32.00);
INSERT INTO pacto.isolamentosocial VALUES (6004, '2020-03-12', 'Rodrigues Alves', 47.62);
INSERT INTO pacto.isolamentosocial VALUES (6005, '2020-03-13', 'Rodrigues Alves', 31.82);
INSERT INTO pacto.isolamentosocial VALUES (6006, '2020-03-14', 'Rodrigues Alves', 33.33);
INSERT INTO pacto.isolamentosocial VALUES (6007, '2020-03-15', 'Rodrigues Alves', 40.91);
INSERT INTO pacto.isolamentosocial VALUES (6008, '2020-03-16', 'Rodrigues Alves', 30.00);
INSERT INTO pacto.isolamentosocial VALUES (6009, '2020-03-17', 'Rodrigues Alves', 53.57);
INSERT INTO pacto.isolamentosocial VALUES (6010, '2020-03-18', 'Rodrigues Alves', 41.67);
INSERT INTO pacto.isolamentosocial VALUES (6011, '2020-03-19', 'Rodrigues Alves', 38.10);
INSERT INTO pacto.isolamentosocial VALUES (6012, '2020-03-20', 'Rodrigues Alves', 37.93);
INSERT INTO pacto.isolamentosocial VALUES (6013, '2020-03-21', 'Rodrigues Alves', 45.45);
INSERT INTO pacto.isolamentosocial VALUES (6014, '2020-03-22', 'Rodrigues Alves', 63.64);
INSERT INTO pacto.isolamentosocial VALUES (6015, '2020-03-23', 'Rodrigues Alves', 40.91);
INSERT INTO pacto.isolamentosocial VALUES (6016, '2020-03-24', 'Rodrigues Alves', 72.00);
INSERT INTO pacto.isolamentosocial VALUES (6017, '2020-03-25', 'Rodrigues Alves', 59.09);
INSERT INTO pacto.isolamentosocial VALUES (6018, '2020-03-26', 'Rodrigues Alves', 57.14);
INSERT INTO pacto.isolamentosocial VALUES (6019, '2020-03-27', 'Rodrigues Alves', 59.09);
INSERT INTO pacto.isolamentosocial VALUES (6020, '2020-03-28', 'Rodrigues Alves', 58.33);
INSERT INTO pacto.isolamentosocial VALUES (6021, '2020-03-29', 'Rodrigues Alves', 45.83);
INSERT INTO pacto.isolamentosocial VALUES (6022, '2020-03-30', 'Rodrigues Alves', 45.45);
INSERT INTO pacto.isolamentosocial VALUES (6023, '2020-03-31', 'Rodrigues Alves', 66.67);
INSERT INTO pacto.isolamentosocial VALUES (6024, '2020-04-01', 'Rodrigues Alves', 41.67);
INSERT INTO pacto.isolamentosocial VALUES (6025, '2020-04-02', 'Rodrigues Alves', 56.00);
INSERT INTO pacto.isolamentosocial VALUES (6026, '2020-04-03', 'Rodrigues Alves', 40.00);
INSERT INTO pacto.isolamentosocial VALUES (6027, '2020-04-04', 'Rodrigues Alves', 77.78);
INSERT INTO pacto.isolamentosocial VALUES (6028, '2020-04-05', 'Rodrigues Alves', 42.86);
INSERT INTO pacto.isolamentosocial VALUES (6029, '2020-04-06', 'Rodrigues Alves', 61.54);
INSERT INTO pacto.isolamentosocial VALUES (6030, '2020-04-07', 'Rodrigues Alves', 59.09);
INSERT INTO pacto.isolamentosocial VALUES (6031, '2020-04-08', 'Rodrigues Alves', 41.38);
INSERT INTO pacto.isolamentosocial VALUES (6032, '2020-04-09', 'Rodrigues Alves', 58.62);
INSERT INTO pacto.isolamentosocial VALUES (6033, '2020-04-10', 'Rodrigues Alves', 58.33);
INSERT INTO pacto.isolamentosocial VALUES (6034, '2020-04-11', 'Rodrigues Alves', 45.45);
INSERT INTO pacto.isolamentosocial VALUES (6035, '2020-04-13', 'Rodrigues Alves', 36.36);
INSERT INTO pacto.isolamentosocial VALUES (6036, '2020-04-14', 'Rodrigues Alves', 45.83);
INSERT INTO pacto.isolamentosocial VALUES (6037, '2020-04-15', 'Rodrigues Alves', 60.87);
INSERT INTO pacto.isolamentosocial VALUES (6038, '2020-04-17', 'Rodrigues Alves', 41.38);
INSERT INTO pacto.isolamentosocial VALUES (6039, '2020-04-18', 'Rodrigues Alves', 58.33);
INSERT INTO pacto.isolamentosocial VALUES (6040, '2020-04-24', 'Rodrigues Alves', 40.91);
INSERT INTO pacto.isolamentosocial VALUES (6041, '2020-04-25', 'Rodrigues Alves', 33.33);
INSERT INTO pacto.isolamentosocial VALUES (6042, '2020-04-27', 'Rodrigues Alves', 56.67);
INSERT INTO pacto.isolamentosocial VALUES (6043, '2020-04-28', 'Rodrigues Alves', 40.00);
INSERT INTO pacto.isolamentosocial VALUES (6044, '2020-04-29', 'Rodrigues Alves', 47.83);
INSERT INTO pacto.isolamentosocial VALUES (6045, '2020-04-30', 'Rodrigues Alves', 35.00);
INSERT INTO pacto.isolamentosocial VALUES (6046, '2020-05-01', 'Rodrigues Alves', 41.38);
INSERT INTO pacto.isolamentosocial VALUES (6047, '2020-05-02', 'Rodrigues Alves', 25.00);
INSERT INTO pacto.isolamentosocial VALUES (6048, '2020-05-03', 'Rodrigues Alves', 43.48);
INSERT INTO pacto.isolamentosocial VALUES (6049, '2020-05-04', 'Rodrigues Alves', 46.43);
INSERT INTO pacto.isolamentosocial VALUES (6050, '2020-05-07', 'Rodrigues Alves', 45.45);
INSERT INTO pacto.isolamentosocial VALUES (6051, '2020-05-08', 'Rodrigues Alves', 43.33);
INSERT INTO pacto.isolamentosocial VALUES (6052, '2020-05-09', 'Rodrigues Alves', 55.56);
INSERT INTO pacto.isolamentosocial VALUES (6053, '2020-05-10', 'Rodrigues Alves', 51.61);
INSERT INTO pacto.isolamentosocial VALUES (6054, '2020-05-11', 'Rodrigues Alves', 40.74);
INSERT INTO pacto.isolamentosocial VALUES (6055, '2020-05-12', 'Rodrigues Alves', 55.56);
INSERT INTO pacto.isolamentosocial VALUES (6056, '2020-05-13', 'Rodrigues Alves', 67.86);
INSERT INTO pacto.isolamentosocial VALUES (6057, '2020-05-14', 'Rodrigues Alves', 32.14);
INSERT INTO pacto.isolamentosocial VALUES (6058, '2020-05-15', 'Rodrigues Alves', 50.00);
INSERT INTO pacto.isolamentosocial VALUES (6059, '2020-05-16', 'Rodrigues Alves', 47.06);
INSERT INTO pacto.isolamentosocial VALUES (6060, '2020-05-17', 'Rodrigues Alves', 56.25);
INSERT INTO pacto.isolamentosocial VALUES (6061, '2020-05-18', 'Rodrigues Alves', 48.15);
INSERT INTO pacto.isolamentosocial VALUES (6062, '2020-05-19', 'Rodrigues Alves', 45.16);
INSERT INTO pacto.isolamentosocial VALUES (6063, '2020-05-20', 'Rodrigues Alves', 65.63);
INSERT INTO pacto.isolamentosocial VALUES (6064, '2020-05-21', 'Rodrigues Alves', 44.83);
INSERT INTO pacto.isolamentosocial VALUES (6065, '2020-05-22', 'Rodrigues Alves', 40.63);
INSERT INTO pacto.isolamentosocial VALUES (6066, '2020-05-23', 'Rodrigues Alves', 45.71);
INSERT INTO pacto.isolamentosocial VALUES (6067, '2020-05-24', 'Rodrigues Alves', 44.44);
INSERT INTO pacto.isolamentosocial VALUES (6068, '2020-05-25', 'Rodrigues Alves', 54.84);
INSERT INTO pacto.isolamentosocial VALUES (6069, '2020-05-26', 'Rodrigues Alves', 60.00);
INSERT INTO pacto.isolamentosocial VALUES (6070, '2020-05-27', 'Rodrigues Alves', 60.00);
INSERT INTO pacto.isolamentosocial VALUES (6071, '2020-05-28', 'Rodrigues Alves', 37.14);
INSERT INTO pacto.isolamentosocial VALUES (6072, '2020-05-29', 'Rodrigues Alves', 47.22);
INSERT INTO pacto.isolamentosocial VALUES (6073, '2020-05-30', 'Rodrigues Alves', 56.00);
INSERT INTO pacto.isolamentosocial VALUES (6074, '2020-05-31', 'Rodrigues Alves', 46.43);
INSERT INTO pacto.isolamentosocial VALUES (6075, '2020-06-01', 'Rodrigues Alves', 48.65);
INSERT INTO pacto.isolamentosocial VALUES (6076, '2020-06-02', 'Rodrigues Alves', 54.84);
INSERT INTO pacto.isolamentosocial VALUES (6077, '2020-06-03', 'Rodrigues Alves', 55.17);
INSERT INTO pacto.isolamentosocial VALUES (6078, '2020-06-04', 'Rodrigues Alves', 61.54);
INSERT INTO pacto.isolamentosocial VALUES (6079, '2020-06-05', 'Rodrigues Alves', 40.74);
INSERT INTO pacto.isolamentosocial VALUES (6080, '2020-06-06', 'Rodrigues Alves', 51.85);
INSERT INTO pacto.isolamentosocial VALUES (6081, '2020-06-07', 'Rodrigues Alves', 46.67);
INSERT INTO pacto.isolamentosocial VALUES (6082, '2020-06-08', 'Rodrigues Alves', 64.29);
INSERT INTO pacto.isolamentosocial VALUES (6083, '2020-06-09', 'Rodrigues Alves', 48.39);
INSERT INTO pacto.isolamentosocial VALUES (6084, '2020-06-10', 'Rodrigues Alves', 35.71);
INSERT INTO pacto.isolamentosocial VALUES (6085, '2020-06-11', 'Rodrigues Alves', 34.78);
INSERT INTO pacto.isolamentosocial VALUES (6086, '2020-06-12', 'Rodrigues Alves', 43.75);
INSERT INTO pacto.isolamentosocial VALUES (6087, '2020-06-13', 'Rodrigues Alves', 35.71);
INSERT INTO pacto.isolamentosocial VALUES (6088, '2020-06-14', 'Rodrigues Alves', 54.05);
INSERT INTO pacto.isolamentosocial VALUES (6089, '2020-06-15', 'Rodrigues Alves', 54.05);
INSERT INTO pacto.isolamentosocial VALUES (6090, '2020-06-16', 'Rodrigues Alves', 57.69);
INSERT INTO pacto.isolamentosocial VALUES (6091, '2020-06-17', 'Rodrigues Alves', 45.45);
INSERT INTO pacto.isolamentosocial VALUES (6092, '2020-06-19', 'Rodrigues Alves', 41.38);
INSERT INTO pacto.isolamentosocial VALUES (6093, '2020-06-20', 'Rodrigues Alves', 44.83);
INSERT INTO pacto.isolamentosocial VALUES (6094, '2020-06-21', 'Rodrigues Alves', 66.67);
INSERT INTO pacto.isolamentosocial VALUES (6095, '2020-06-22', 'Rodrigues Alves', 45.45);
INSERT INTO pacto.isolamentosocial VALUES (6096, '2020-06-23', 'Rodrigues Alves', 68.18);
INSERT INTO pacto.isolamentosocial VALUES (6097, '2020-06-24', 'Rodrigues Alves', 47.83);
INSERT INTO pacto.isolamentosocial VALUES (6098, '2020-06-25', 'Rodrigues Alves', 44.00);
INSERT INTO pacto.isolamentosocial VALUES (6099, '2020-06-26', 'Rodrigues Alves', 51.43);
INSERT INTO pacto.isolamentosocial VALUES (6100, '2020-06-27', 'Rodrigues Alves', 62.07);
INSERT INTO pacto.isolamentosocial VALUES (6101, '2020-06-28', 'Rodrigues Alves', 55.56);
INSERT INTO pacto.isolamentosocial VALUES (6102, '2020-06-29', 'Rodrigues Alves', 60.71);
INSERT INTO pacto.isolamentosocial VALUES (6103, '2020-07-01', 'Rodrigues Alves', 48.57);
INSERT INTO pacto.isolamentosocial VALUES (6104, '2020-07-02', 'Rodrigues Alves', 43.59);
INSERT INTO pacto.isolamentosocial VALUES (6105, '2020-07-03', 'Rodrigues Alves', 57.58);
INSERT INTO pacto.isolamentosocial VALUES (6106, '2020-02-15', 'Santa Rosa do Purus', 35.00);
INSERT INTO pacto.isolamentosocial VALUES (6107, '2020-02-23', 'Santa Rosa do Purus', 36.36);
INSERT INTO pacto.isolamentosocial VALUES (6108, '2020-02-25', 'Santa Rosa do Purus', 21.74);
INSERT INTO pacto.isolamentosocial VALUES (6109, '2020-03-11', 'Santa Rosa do Purus', 21.74);
INSERT INTO pacto.isolamentosocial VALUES (6110, '2020-03-15', 'Santa Rosa do Purus', 52.17);
INSERT INTO pacto.isolamentosocial VALUES (6111, '2020-03-20', 'Santa Rosa do Purus', 30.00);
INSERT INTO pacto.isolamentosocial VALUES (6112, '2020-03-24', 'Santa Rosa do Purus', 45.00);
INSERT INTO pacto.isolamentosocial VALUES (6113, '2020-04-14', 'Santa Rosa do Purus', 25.00);
INSERT INTO pacto.isolamentosocial VALUES (6114, '2020-04-18', 'Santa Rosa do Purus', 45.00);
INSERT INTO pacto.isolamentosocial VALUES (6115, '2020-04-21', 'Santa Rosa do Purus', 40.00);
INSERT INTO pacto.isolamentosocial VALUES (6116, '2020-04-22', 'Santa Rosa do Purus', 19.05);
INSERT INTO pacto.isolamentosocial VALUES (6117, '2020-05-20', 'Santa Rosa do Purus', 30.00);
INSERT INTO pacto.isolamentosocial VALUES (6118, '2020-05-22', 'Santa Rosa do Purus', 20.00);
INSERT INTO pacto.isolamentosocial VALUES (6119, '2020-05-23', 'Santa Rosa do Purus', 22.73);
INSERT INTO pacto.isolamentosocial VALUES (6120, '2020-02-01', 'Sena Madureira', 34.04);
INSERT INTO pacto.isolamentosocial VALUES (6121, '2020-02-02', 'Sena Madureira', 40.17);
INSERT INTO pacto.isolamentosocial VALUES (6122, '2020-02-03', 'Sena Madureira', 27.40);
INSERT INTO pacto.isolamentosocial VALUES (6123, '2020-02-04', 'Sena Madureira', 32.82);
INSERT INTO pacto.isolamentosocial VALUES (6124, '2020-02-05', 'Sena Madureira', 28.23);
INSERT INTO pacto.isolamentosocial VALUES (6125, '2020-02-06', 'Sena Madureira', 33.16);
INSERT INTO pacto.isolamentosocial VALUES (6126, '2020-02-07', 'Sena Madureira', 29.02);
INSERT INTO pacto.isolamentosocial VALUES (6127, '2020-02-08', 'Sena Madureira', 30.75);
INSERT INTO pacto.isolamentosocial VALUES (6128, '2020-02-09', 'Sena Madureira', 37.67);
INSERT INTO pacto.isolamentosocial VALUES (6129, '2020-02-10', 'Sena Madureira', 20.68);
INSERT INTO pacto.isolamentosocial VALUES (6130, '2020-02-11', 'Sena Madureira', 26.15);
INSERT INTO pacto.isolamentosocial VALUES (6131, '2020-02-12', 'Sena Madureira', 28.27);
INSERT INTO pacto.isolamentosocial VALUES (6132, '2020-02-13', 'Sena Madureira', 30.23);
INSERT INTO pacto.isolamentosocial VALUES (6133, '2020-02-14', 'Sena Madureira', 27.93);
INSERT INTO pacto.isolamentosocial VALUES (6134, '2020-02-15', 'Sena Madureira', 33.42);
INSERT INTO pacto.isolamentosocial VALUES (6135, '2020-02-16', 'Sena Madureira', 38.06);
INSERT INTO pacto.isolamentosocial VALUES (6136, '2020-02-17', 'Sena Madureira', 23.06);
INSERT INTO pacto.isolamentosocial VALUES (6137, '2020-02-18', 'Sena Madureira', 29.47);
INSERT INTO pacto.isolamentosocial VALUES (6138, '2020-02-19', 'Sena Madureira', 34.48);
INSERT INTO pacto.isolamentosocial VALUES (6139, '2020-02-20', 'Sena Madureira', 29.31);
INSERT INTO pacto.isolamentosocial VALUES (6140, '2020-02-21', 'Sena Madureira', 32.18);
INSERT INTO pacto.isolamentosocial VALUES (6141, '2020-02-22', 'Sena Madureira', 33.60);
INSERT INTO pacto.isolamentosocial VALUES (6142, '2020-02-23', 'Sena Madureira', 40.88);
INSERT INTO pacto.isolamentosocial VALUES (6143, '2020-02-24', 'Sena Madureira', 35.52);
INSERT INTO pacto.isolamentosocial VALUES (6144, '2020-02-25', 'Sena Madureira', 36.71);
INSERT INTO pacto.isolamentosocial VALUES (6145, '2020-02-26', 'Sena Madureira', 34.59);
INSERT INTO pacto.isolamentosocial VALUES (6146, '2020-02-27', 'Sena Madureira', 32.51);
INSERT INTO pacto.isolamentosocial VALUES (6147, '2020-02-28', 'Sena Madureira', 31.20);
INSERT INTO pacto.isolamentosocial VALUES (6148, '2020-02-29', 'Sena Madureira', 35.35);
INSERT INTO pacto.isolamentosocial VALUES (6149, '2020-03-01', 'Sena Madureira', 46.62);
INSERT INTO pacto.isolamentosocial VALUES (6150, '2020-03-02', 'Sena Madureira', 24.87);
INSERT INTO pacto.isolamentosocial VALUES (6151, '2020-03-03', 'Sena Madureira', 33.25);
INSERT INTO pacto.isolamentosocial VALUES (6152, '2020-03-04', 'Sena Madureira', 37.28);
INSERT INTO pacto.isolamentosocial VALUES (6153, '2020-03-05', 'Sena Madureira', 33.77);
INSERT INTO pacto.isolamentosocial VALUES (6154, '2020-03-06', 'Sena Madureira', 37.62);
INSERT INTO pacto.isolamentosocial VALUES (6155, '2020-03-07', 'Sena Madureira', 36.50);
INSERT INTO pacto.isolamentosocial VALUES (6156, '2020-03-08', 'Sena Madureira', 40.26);
INSERT INTO pacto.isolamentosocial VALUES (6157, '2020-03-09', 'Sena Madureira', 29.01);
INSERT INTO pacto.isolamentosocial VALUES (6158, '2020-03-10', 'Sena Madureira', 31.55);
INSERT INTO pacto.isolamentosocial VALUES (6159, '2020-03-11', 'Sena Madureira', 30.87);
INSERT INTO pacto.isolamentosocial VALUES (6160, '2020-03-12', 'Sena Madureira', 28.72);
INSERT INTO pacto.isolamentosocial VALUES (6161, '2020-03-13', 'Sena Madureira', 34.88);
INSERT INTO pacto.isolamentosocial VALUES (6162, '2020-03-14', 'Sena Madureira', 40.57);
INSERT INTO pacto.isolamentosocial VALUES (6163, '2020-03-15', 'Sena Madureira', 45.25);
INSERT INTO pacto.isolamentosocial VALUES (6164, '2020-03-16', 'Sena Madureira', 32.55);
INSERT INTO pacto.isolamentosocial VALUES (6165, '2020-03-17', 'Sena Madureira', 33.16);
INSERT INTO pacto.isolamentosocial VALUES (6166, '2020-03-18', 'Sena Madureira', 38.28);
INSERT INTO pacto.isolamentosocial VALUES (6167, '2020-03-19', 'Sena Madureira', 44.44);
INSERT INTO pacto.isolamentosocial VALUES (6168, '2020-03-20', 'Sena Madureira', 41.25);
INSERT INTO pacto.isolamentosocial VALUES (6169, '2020-03-21', 'Sena Madureira', 47.68);
INSERT INTO pacto.isolamentosocial VALUES (6170, '2020-03-22', 'Sena Madureira', 58.44);
INSERT INTO pacto.isolamentosocial VALUES (6171, '2020-03-23', 'Sena Madureira', 48.89);
INSERT INTO pacto.isolamentosocial VALUES (6172, '2020-03-24', 'Sena Madureira', 49.34);
INSERT INTO pacto.isolamentosocial VALUES (6173, '2020-03-25', 'Sena Madureira', 49.45);
INSERT INTO pacto.isolamentosocial VALUES (6174, '2020-03-26', 'Sena Madureira', 47.09);
INSERT INTO pacto.isolamentosocial VALUES (6175, '2020-03-27', 'Sena Madureira', 45.30);
INSERT INTO pacto.isolamentosocial VALUES (6176, '2020-03-28', 'Sena Madureira', 50.55);
INSERT INTO pacto.isolamentosocial VALUES (6177, '2020-03-29', 'Sena Madureira', 53.97);
INSERT INTO pacto.isolamentosocial VALUES (6178, '2020-03-30', 'Sena Madureira', 43.22);
INSERT INTO pacto.isolamentosocial VALUES (6179, '2020-03-31', 'Sena Madureira', 39.13);
INSERT INTO pacto.isolamentosocial VALUES (6180, '2020-04-01', 'Sena Madureira', 42.28);
INSERT INTO pacto.isolamentosocial VALUES (6181, '2020-04-02', 'Sena Madureira', 40.87);
INSERT INTO pacto.isolamentosocial VALUES (6182, '2020-04-03', 'Sena Madureira', 46.98);
INSERT INTO pacto.isolamentosocial VALUES (6183, '2020-04-04', 'Sena Madureira', 47.30);
INSERT INTO pacto.isolamentosocial VALUES (6184, '2020-04-05', 'Sena Madureira', 56.21);
INSERT INTO pacto.isolamentosocial VALUES (6185, '2020-04-06', 'Sena Madureira', 39.67);
INSERT INTO pacto.isolamentosocial VALUES (6186, '2020-04-07', 'Sena Madureira', 42.36);
INSERT INTO pacto.isolamentosocial VALUES (6187, '2020-04-08', 'Sena Madureira', 43.01);
INSERT INTO pacto.isolamentosocial VALUES (6188, '2020-04-09', 'Sena Madureira', 47.12);
INSERT INTO pacto.isolamentosocial VALUES (6189, '2020-04-10', 'Sena Madureira', 52.19);
INSERT INTO pacto.isolamentosocial VALUES (6190, '2020-04-11', 'Sena Madureira', 40.34);
INSERT INTO pacto.isolamentosocial VALUES (6191, '2020-04-12', 'Sena Madureira', 54.47);
INSERT INTO pacto.isolamentosocial VALUES (6192, '2020-04-13', 'Sena Madureira', 40.22);
INSERT INTO pacto.isolamentosocial VALUES (6193, '2020-04-14', 'Sena Madureira', 47.24);
INSERT INTO pacto.isolamentosocial VALUES (6194, '2020-04-15', 'Sena Madureira', 43.40);
INSERT INTO pacto.isolamentosocial VALUES (6195, '2020-04-16', 'Sena Madureira', 44.50);
INSERT INTO pacto.isolamentosocial VALUES (6196, '2020-04-17', 'Sena Madureira', 39.28);
INSERT INTO pacto.isolamentosocial VALUES (6197, '2020-04-18', 'Sena Madureira', 45.38);
INSERT INTO pacto.isolamentosocial VALUES (6198, '2020-04-19', 'Sena Madureira', 48.02);
INSERT INTO pacto.isolamentosocial VALUES (6199, '2020-04-20', 'Sena Madureira', 42.63);
INSERT INTO pacto.isolamentosocial VALUES (6200, '2020-04-21', 'Sena Madureira', 46.40);
INSERT INTO pacto.isolamentosocial VALUES (6201, '2020-04-22', 'Sena Madureira', 43.58);
INSERT INTO pacto.isolamentosocial VALUES (6202, '2020-04-23', 'Sena Madureira', 42.93);
INSERT INTO pacto.isolamentosocial VALUES (6203, '2020-04-24', 'Sena Madureira', 41.07);
INSERT INTO pacto.isolamentosocial VALUES (6204, '2020-04-25', 'Sena Madureira', 39.77);
INSERT INTO pacto.isolamentosocial VALUES (6205, '2020-04-26', 'Sena Madureira', 48.56);
INSERT INTO pacto.isolamentosocial VALUES (6206, '2020-04-27', 'Sena Madureira', 41.61);
INSERT INTO pacto.isolamentosocial VALUES (6207, '2020-04-28', 'Sena Madureira', 41.69);
INSERT INTO pacto.isolamentosocial VALUES (6208, '2020-04-29', 'Sena Madureira', 37.00);
INSERT INTO pacto.isolamentosocial VALUES (6209, '2020-04-30', 'Sena Madureira', 40.37);
INSERT INTO pacto.isolamentosocial VALUES (6210, '2020-05-01', 'Sena Madureira', 43.18);
INSERT INTO pacto.isolamentosocial VALUES (6211, '2020-05-02', 'Sena Madureira', 42.40);
INSERT INTO pacto.isolamentosocial VALUES (6212, '2020-05-03', 'Sena Madureira', 45.87);
INSERT INTO pacto.isolamentosocial VALUES (6213, '2020-05-04', 'Sena Madureira', 40.20);
INSERT INTO pacto.isolamentosocial VALUES (6214, '2020-05-05', 'Sena Madureira', 42.00);
INSERT INTO pacto.isolamentosocial VALUES (6215, '2020-05-06', 'Sena Madureira', 43.45);
INSERT INTO pacto.isolamentosocial VALUES (6216, '2020-05-07', 'Sena Madureira', 36.91);
INSERT INTO pacto.isolamentosocial VALUES (6217, '2020-05-08', 'Sena Madureira', 38.36);
INSERT INTO pacto.isolamentosocial VALUES (6218, '2020-05-09', 'Sena Madureira', 46.17);
INSERT INTO pacto.isolamentosocial VALUES (6219, '2020-05-10', 'Sena Madureira', 48.51);
INSERT INTO pacto.isolamentosocial VALUES (6220, '2020-05-11', 'Sena Madureira', 43.84);
INSERT INTO pacto.isolamentosocial VALUES (6221, '2020-05-12', 'Sena Madureira', 42.04);
INSERT INTO pacto.isolamentosocial VALUES (6222, '2020-05-13', 'Sena Madureira', 46.60);
INSERT INTO pacto.isolamentosocial VALUES (6223, '2020-05-14', 'Sena Madureira', 42.45);
INSERT INTO pacto.isolamentosocial VALUES (6224, '2020-05-15', 'Sena Madureira', 48.66);
INSERT INTO pacto.isolamentosocial VALUES (6225, '2020-05-16', 'Sena Madureira', 44.47);
INSERT INTO pacto.isolamentosocial VALUES (6226, '2020-05-17', 'Sena Madureira', 53.08);
INSERT INTO pacto.isolamentosocial VALUES (6227, '2020-05-18', 'Sena Madureira', 44.47);
INSERT INTO pacto.isolamentosocial VALUES (6228, '2020-05-19', 'Sena Madureira', 46.57);
INSERT INTO pacto.isolamentosocial VALUES (6229, '2020-05-20', 'Sena Madureira', 44.58);
INSERT INTO pacto.isolamentosocial VALUES (6230, '2020-05-21', 'Sena Madureira', 48.94);
INSERT INTO pacto.isolamentosocial VALUES (6231, '2020-05-22', 'Sena Madureira', 48.38);
INSERT INTO pacto.isolamentosocial VALUES (6232, '2020-05-23', 'Sena Madureira', 47.82);
INSERT INTO pacto.isolamentosocial VALUES (6233, '2020-05-24', 'Sena Madureira', 52.25);
INSERT INTO pacto.isolamentosocial VALUES (6234, '2020-05-25', 'Sena Madureira', 45.02);
INSERT INTO pacto.isolamentosocial VALUES (6235, '2020-05-26', 'Sena Madureira', 45.32);
INSERT INTO pacto.isolamentosocial VALUES (6236, '2020-05-27', 'Sena Madureira', 43.67);
INSERT INTO pacto.isolamentosocial VALUES (6237, '2020-05-28', 'Sena Madureira', 41.48);
INSERT INTO pacto.isolamentosocial VALUES (6238, '2020-05-29', 'Sena Madureira', 41.57);
INSERT INTO pacto.isolamentosocial VALUES (6239, '2020-05-30', 'Sena Madureira', 43.03);
INSERT INTO pacto.isolamentosocial VALUES (6240, '2020-05-31', 'Sena Madureira', 48.65);
INSERT INTO pacto.isolamentosocial VALUES (6241, '2020-06-01', 'Sena Madureira', 43.24);
INSERT INTO pacto.isolamentosocial VALUES (6242, '2020-06-02', 'Sena Madureira', 43.33);
INSERT INTO pacto.isolamentosocial VALUES (6243, '2020-06-03', 'Sena Madureira', 43.18);
INSERT INTO pacto.isolamentosocial VALUES (6244, '2020-06-04', 'Sena Madureira', 36.58);
INSERT INTO pacto.isolamentosocial VALUES (6245, '2020-06-05', 'Sena Madureira', 43.04);
INSERT INTO pacto.isolamentosocial VALUES (6246, '2020-06-06', 'Sena Madureira', 41.71);
INSERT INTO pacto.isolamentosocial VALUES (6247, '2020-06-07', 'Sena Madureira', 50.25);
INSERT INTO pacto.isolamentosocial VALUES (6248, '2020-06-08', 'Sena Madureira', 41.81);
INSERT INTO pacto.isolamentosocial VALUES (6249, '2020-06-09', 'Sena Madureira', 46.39);
INSERT INTO pacto.isolamentosocial VALUES (6250, '2020-06-10', 'Sena Madureira', 39.90);
INSERT INTO pacto.isolamentosocial VALUES (6251, '2020-06-11', 'Sena Madureira', 39.16);
INSERT INTO pacto.isolamentosocial VALUES (6252, '2020-06-12', 'Sena Madureira', 39.15);
INSERT INTO pacto.isolamentosocial VALUES (6253, '2020-06-13', 'Sena Madureira', 43.73);
INSERT INTO pacto.isolamentosocial VALUES (6254, '2020-06-14', 'Sena Madureira', 47.00);
INSERT INTO pacto.isolamentosocial VALUES (6255, '2020-06-15', 'Sena Madureira', 39.81);
INSERT INTO pacto.isolamentosocial VALUES (6256, '2020-06-16', 'Sena Madureira', 38.12);
INSERT INTO pacto.isolamentosocial VALUES (6257, '2020-06-17', 'Sena Madureira', 38.00);
INSERT INTO pacto.isolamentosocial VALUES (6258, '2020-06-18', 'Sena Madureira', 32.37);
INSERT INTO pacto.isolamentosocial VALUES (6259, '2020-06-19', 'Sena Madureira', 33.89);
INSERT INTO pacto.isolamentosocial VALUES (6260, '2020-06-20', 'Sena Madureira', 42.22);
INSERT INTO pacto.isolamentosocial VALUES (6261, '2020-06-21', 'Sena Madureira', 45.43);
INSERT INTO pacto.isolamentosocial VALUES (6262, '2020-06-22', 'Sena Madureira', 38.05);
INSERT INTO pacto.isolamentosocial VALUES (6263, '2020-06-23', 'Sena Madureira', 36.54);
INSERT INTO pacto.isolamentosocial VALUES (6264, '2020-06-24', 'Sena Madureira', 40.93);
INSERT INTO pacto.isolamentosocial VALUES (6265, '2020-06-25', 'Sena Madureira', 37.38);
INSERT INTO pacto.isolamentosocial VALUES (6266, '2020-06-26', 'Sena Madureira', 40.22);
INSERT INTO pacto.isolamentosocial VALUES (6267, '2020-06-27', 'Sena Madureira', 44.87);
INSERT INTO pacto.isolamentosocial VALUES (6268, '2020-06-28', 'Sena Madureira', 49.53);
INSERT INTO pacto.isolamentosocial VALUES (6269, '2020-06-29', 'Sena Madureira', 36.84);
INSERT INTO pacto.isolamentosocial VALUES (6270, '2020-06-30', 'Sena Madureira', 39.79);
INSERT INTO pacto.isolamentosocial VALUES (6271, '2020-07-01', 'Sena Madureira', 37.24);
INSERT INTO pacto.isolamentosocial VALUES (6272, '2020-07-02', 'Sena Madureira', 39.35);
INSERT INTO pacto.isolamentosocial VALUES (6273, '2020-07-03', 'Sena Madureira', 35.98);
INSERT INTO pacto.isolamentosocial VALUES (6274, '2020-02-01', 'Senador Guiomard', 39.61);
INSERT INTO pacto.isolamentosocial VALUES (6275, '2020-02-02', 'Senador Guiomard', 42.86);
INSERT INTO pacto.isolamentosocial VALUES (6276, '2020-02-03', 'Senador Guiomard', 31.81);
INSERT INTO pacto.isolamentosocial VALUES (6277, '2020-02-04', 'Senador Guiomard', 30.43);
INSERT INTO pacto.isolamentosocial VALUES (6278, '2020-02-05', 'Senador Guiomard', 28.86);
INSERT INTO pacto.isolamentosocial VALUES (6279, '2020-02-06', 'Senador Guiomard', 37.56);
INSERT INTO pacto.isolamentosocial VALUES (6280, '2020-02-07', 'Senador Guiomard', 28.00);
INSERT INTO pacto.isolamentosocial VALUES (6281, '2020-02-08', 'Senador Guiomard', 35.68);
INSERT INTO pacto.isolamentosocial VALUES (6282, '2020-02-09', 'Senador Guiomard', 46.26);
INSERT INTO pacto.isolamentosocial VALUES (6283, '2020-02-10', 'Senador Guiomard', 29.40);
INSERT INTO pacto.isolamentosocial VALUES (6284, '2020-02-11', 'Senador Guiomard', 26.22);
INSERT INTO pacto.isolamentosocial VALUES (6285, '2020-02-12', 'Senador Guiomard', 31.56);
INSERT INTO pacto.isolamentosocial VALUES (6286, '2020-02-13', 'Senador Guiomard', 28.46);
INSERT INTO pacto.isolamentosocial VALUES (6287, '2020-02-14', 'Senador Guiomard', 30.15);
INSERT INTO pacto.isolamentosocial VALUES (6288, '2020-02-15', 'Senador Guiomard', 39.57);
INSERT INTO pacto.isolamentosocial VALUES (6289, '2020-02-16', 'Senador Guiomard', 44.02);
INSERT INTO pacto.isolamentosocial VALUES (6290, '2020-02-17', 'Senador Guiomard', 24.75);
INSERT INTO pacto.isolamentosocial VALUES (6291, '2020-02-18', 'Senador Guiomard', 31.90);
INSERT INTO pacto.isolamentosocial VALUES (6292, '2020-02-19', 'Senador Guiomard', 37.32);
INSERT INTO pacto.isolamentosocial VALUES (6293, '2020-02-20', 'Senador Guiomard', 32.77);
INSERT INTO pacto.isolamentosocial VALUES (6294, '2020-02-21', 'Senador Guiomard', 31.14);
INSERT INTO pacto.isolamentosocial VALUES (6295, '2020-02-22', 'Senador Guiomard', 37.14);
INSERT INTO pacto.isolamentosocial VALUES (6296, '2020-02-23', 'Senador Guiomard', 39.30);
INSERT INTO pacto.isolamentosocial VALUES (6297, '2020-02-24', 'Senador Guiomard', 37.96);
INSERT INTO pacto.isolamentosocial VALUES (6298, '2020-02-25', 'Senador Guiomard', 42.53);
INSERT INTO pacto.isolamentosocial VALUES (6299, '2020-02-26', 'Senador Guiomard', 36.88);
INSERT INTO pacto.isolamentosocial VALUES (6300, '2020-02-27', 'Senador Guiomard', 31.59);
INSERT INTO pacto.isolamentosocial VALUES (6301, '2020-02-28', 'Senador Guiomard', 30.35);
INSERT INTO pacto.isolamentosocial VALUES (6302, '2020-02-29', 'Senador Guiomard', 35.45);
INSERT INTO pacto.isolamentosocial VALUES (6303, '2020-03-01', 'Senador Guiomard', 48.92);
INSERT INTO pacto.isolamentosocial VALUES (6304, '2020-03-02', 'Senador Guiomard', 32.12);
INSERT INTO pacto.isolamentosocial VALUES (6305, '2020-03-03', 'Senador Guiomard', 31.11);
INSERT INTO pacto.isolamentosocial VALUES (6306, '2020-03-04', 'Senador Guiomard', 35.57);
INSERT INTO pacto.isolamentosocial VALUES (6307, '2020-03-05', 'Senador Guiomard', 36.58);
INSERT INTO pacto.isolamentosocial VALUES (6308, '2020-03-06', 'Senador Guiomard', 34.46);
INSERT INTO pacto.isolamentosocial VALUES (6309, '2020-03-07', 'Senador Guiomard', 39.01);
INSERT INTO pacto.isolamentosocial VALUES (6310, '2020-03-08', 'Senador Guiomard', 46.42);
INSERT INTO pacto.isolamentosocial VALUES (6311, '2020-03-09', 'Senador Guiomard', 36.68);
INSERT INTO pacto.isolamentosocial VALUES (6312, '2020-03-10', 'Senador Guiomard', 35.03);
INSERT INTO pacto.isolamentosocial VALUES (6313, '2020-03-11', 'Senador Guiomard', 38.12);
INSERT INTO pacto.isolamentosocial VALUES (6314, '2020-03-12', 'Senador Guiomard', 36.52);
INSERT INTO pacto.isolamentosocial VALUES (6315, '2020-03-13', 'Senador Guiomard', 38.57);
INSERT INTO pacto.isolamentosocial VALUES (6316, '2020-03-14', 'Senador Guiomard', 42.55);
INSERT INTO pacto.isolamentosocial VALUES (6317, '2020-03-15', 'Senador Guiomard', 46.93);
INSERT INTO pacto.isolamentosocial VALUES (6318, '2020-03-16', 'Senador Guiomard', 36.10);
INSERT INTO pacto.isolamentosocial VALUES (6319, '2020-03-17', 'Senador Guiomard', 31.28);
INSERT INTO pacto.isolamentosocial VALUES (6320, '2020-03-18', 'Senador Guiomard', 42.39);
INSERT INTO pacto.isolamentosocial VALUES (6321, '2020-03-19', 'Senador Guiomard', 41.65);
INSERT INTO pacto.isolamentosocial VALUES (6322, '2020-03-20', 'Senador Guiomard', 42.69);
INSERT INTO pacto.isolamentosocial VALUES (6323, '2020-03-21', 'Senador Guiomard', 51.82);
INSERT INTO pacto.isolamentosocial VALUES (6324, '2020-03-22', 'Senador Guiomard', 60.44);
INSERT INTO pacto.isolamentosocial VALUES (6325, '2020-03-23', 'Senador Guiomard', 51.87);
INSERT INTO pacto.isolamentosocial VALUES (6326, '2020-03-24', 'Senador Guiomard', 52.14);
INSERT INTO pacto.isolamentosocial VALUES (6327, '2020-03-25', 'Senador Guiomard', 49.41);
INSERT INTO pacto.isolamentosocial VALUES (6328, '2020-03-26', 'Senador Guiomard', 51.98);
INSERT INTO pacto.isolamentosocial VALUES (6329, '2020-03-27', 'Senador Guiomard', 50.26);
INSERT INTO pacto.isolamentosocial VALUES (6330, '2020-03-28', 'Senador Guiomard', 55.47);
INSERT INTO pacto.isolamentosocial VALUES (6331, '2020-03-29', 'Senador Guiomard', 55.19);
INSERT INTO pacto.isolamentosocial VALUES (6332, '2020-03-30', 'Senador Guiomard', 52.24);
INSERT INTO pacto.isolamentosocial VALUES (6333, '2020-03-31', 'Senador Guiomard', 47.24);
INSERT INTO pacto.isolamentosocial VALUES (6334, '2020-04-01', 'Senador Guiomard', 43.32);
INSERT INTO pacto.isolamentosocial VALUES (6335, '2020-04-02', 'Senador Guiomard', 50.26);
INSERT INTO pacto.isolamentosocial VALUES (6336, '2020-04-03', 'Senador Guiomard', 52.27);
INSERT INTO pacto.isolamentosocial VALUES (6337, '2020-04-04', 'Senador Guiomard', 51.72);
INSERT INTO pacto.isolamentosocial VALUES (6338, '2020-04-05', 'Senador Guiomard', 52.09);
INSERT INTO pacto.isolamentosocial VALUES (6339, '2020-04-06', 'Senador Guiomard', 45.90);
INSERT INTO pacto.isolamentosocial VALUES (6340, '2020-04-07', 'Senador Guiomard', 46.80);
INSERT INTO pacto.isolamentosocial VALUES (6341, '2020-04-08', 'Senador Guiomard', 44.36);
INSERT INTO pacto.isolamentosocial VALUES (6342, '2020-04-09', 'Senador Guiomard', 43.32);
INSERT INTO pacto.isolamentosocial VALUES (6343, '2020-04-10', 'Senador Guiomard', 56.42);
INSERT INTO pacto.isolamentosocial VALUES (6344, '2020-04-11', 'Senador Guiomard', 46.78);
INSERT INTO pacto.isolamentosocial VALUES (6345, '2020-04-12', 'Senador Guiomard', 53.02);
INSERT INTO pacto.isolamentosocial VALUES (6346, '2020-04-13', 'Senador Guiomard', 48.33);
INSERT INTO pacto.isolamentosocial VALUES (6347, '2020-04-14', 'Senador Guiomard', 43.49);
INSERT INTO pacto.isolamentosocial VALUES (6348, '2020-04-15', 'Senador Guiomard', 56.09);
INSERT INTO pacto.isolamentosocial VALUES (6349, '2020-04-16', 'Senador Guiomard', 46.97);
INSERT INTO pacto.isolamentosocial VALUES (6350, '2020-04-17', 'Senador Guiomard', 43.41);
INSERT INTO pacto.isolamentosocial VALUES (6351, '2020-04-18', 'Senador Guiomard', 48.60);
INSERT INTO pacto.isolamentosocial VALUES (6352, '2020-04-19', 'Senador Guiomard', 54.21);
INSERT INTO pacto.isolamentosocial VALUES (6353, '2020-04-20', 'Senador Guiomard', 48.31);
INSERT INTO pacto.isolamentosocial VALUES (6354, '2020-04-21', 'Senador Guiomard', 53.61);
INSERT INTO pacto.isolamentosocial VALUES (6355, '2020-04-22', 'Senador Guiomard', 40.83);
INSERT INTO pacto.isolamentosocial VALUES (6356, '2020-04-23', 'Senador Guiomard', 44.94);
INSERT INTO pacto.isolamentosocial VALUES (6357, '2020-04-24', 'Senador Guiomard', 47.45);
INSERT INTO pacto.isolamentosocial VALUES (6358, '2020-04-25', 'Senador Guiomard', 45.50);
INSERT INTO pacto.isolamentosocial VALUES (6359, '2020-04-26', 'Senador Guiomard', 55.85);
INSERT INTO pacto.isolamentosocial VALUES (6360, '2020-04-27', 'Senador Guiomard', 44.22);
INSERT INTO pacto.isolamentosocial VALUES (6361, '2020-04-28', 'Senador Guiomard', 42.28);
INSERT INTO pacto.isolamentosocial VALUES (6362, '2020-04-29', 'Senador Guiomard', 43.30);
INSERT INTO pacto.isolamentosocial VALUES (6363, '2020-04-30', 'Senador Guiomard', 43.53);
INSERT INTO pacto.isolamentosocial VALUES (6364, '2020-05-01', 'Senador Guiomard', 51.58);
INSERT INTO pacto.isolamentosocial VALUES (6365, '2020-05-02', 'Senador Guiomard', 46.30);
INSERT INTO pacto.isolamentosocial VALUES (6366, '2020-05-03', 'Senador Guiomard', 51.77);
INSERT INTO pacto.isolamentosocial VALUES (6367, '2020-05-04', 'Senador Guiomard', 45.42);
INSERT INTO pacto.isolamentosocial VALUES (6368, '2020-05-05', 'Senador Guiomard', 45.49);
INSERT INTO pacto.isolamentosocial VALUES (6369, '2020-05-06', 'Senador Guiomard', 44.59);
INSERT INTO pacto.isolamentosocial VALUES (6370, '2020-05-07', 'Senador Guiomard', 47.47);
INSERT INTO pacto.isolamentosocial VALUES (6371, '2020-05-08', 'Senador Guiomard', 45.59);
INSERT INTO pacto.isolamentosocial VALUES (6372, '2020-05-09', 'Senador Guiomard', 47.65);
INSERT INTO pacto.isolamentosocial VALUES (6373, '2020-05-10', 'Senador Guiomard', 50.00);
INSERT INTO pacto.isolamentosocial VALUES (6374, '2020-05-11', 'Senador Guiomard', 44.08);
INSERT INTO pacto.isolamentosocial VALUES (6375, '2020-05-12', 'Senador Guiomard', 47.39);
INSERT INTO pacto.isolamentosocial VALUES (6376, '2020-05-13', 'Senador Guiomard', 48.68);
INSERT INTO pacto.isolamentosocial VALUES (6377, '2020-05-14', 'Senador Guiomard', 55.24);
INSERT INTO pacto.isolamentosocial VALUES (6378, '2020-05-15', 'Senador Guiomard', 47.37);
INSERT INTO pacto.isolamentosocial VALUES (6379, '2020-05-16', 'Senador Guiomard', 48.72);
INSERT INTO pacto.isolamentosocial VALUES (6380, '2020-05-17', 'Senador Guiomard', 54.72);
INSERT INTO pacto.isolamentosocial VALUES (6381, '2020-05-18', 'Senador Guiomard', 45.47);
INSERT INTO pacto.isolamentosocial VALUES (6382, '2020-05-19', 'Senador Guiomard', 50.19);
INSERT INTO pacto.isolamentosocial VALUES (6383, '2020-05-20', 'Senador Guiomard', 51.17);
INSERT INTO pacto.isolamentosocial VALUES (6384, '2020-05-21', 'Senador Guiomard', 48.64);
INSERT INTO pacto.isolamentosocial VALUES (6385, '2020-05-22', 'Senador Guiomard', 48.98);
INSERT INTO pacto.isolamentosocial VALUES (6386, '2020-05-23', 'Senador Guiomard', 51.54);
INSERT INTO pacto.isolamentosocial VALUES (6387, '2020-05-24', 'Senador Guiomard', 58.16);
INSERT INTO pacto.isolamentosocial VALUES (6388, '2020-05-25', 'Senador Guiomard', 47.06);
INSERT INTO pacto.isolamentosocial VALUES (6389, '2020-05-26', 'Senador Guiomard', 47.33);
INSERT INTO pacto.isolamentosocial VALUES (6390, '2020-05-27', 'Senador Guiomard', 47.29);
INSERT INTO pacto.isolamentosocial VALUES (6391, '2020-05-28', 'Senador Guiomard', 48.03);
INSERT INTO pacto.isolamentosocial VALUES (6392, '2020-05-29', 'Senador Guiomard', 45.39);
INSERT INTO pacto.isolamentosocial VALUES (6393, '2020-05-30', 'Senador Guiomard', 45.09);
INSERT INTO pacto.isolamentosocial VALUES (6394, '2020-05-31', 'Senador Guiomard', 52.11);
INSERT INTO pacto.isolamentosocial VALUES (6395, '2020-06-01', 'Senador Guiomard', 44.68);
INSERT INTO pacto.isolamentosocial VALUES (6396, '2020-06-02', 'Senador Guiomard', 44.59);
INSERT INTO pacto.isolamentosocial VALUES (6397, '2020-06-03', 'Senador Guiomard', 44.67);
INSERT INTO pacto.isolamentosocial VALUES (6398, '2020-06-04', 'Senador Guiomard', 43.86);
INSERT INTO pacto.isolamentosocial VALUES (6399, '2020-06-05', 'Senador Guiomard', 45.07);
INSERT INTO pacto.isolamentosocial VALUES (6400, '2020-06-06', 'Senador Guiomard', 47.67);
INSERT INTO pacto.isolamentosocial VALUES (6401, '2020-06-07', 'Senador Guiomard', 52.10);
INSERT INTO pacto.isolamentosocial VALUES (6402, '2020-06-08', 'Senador Guiomard', 41.92);
INSERT INTO pacto.isolamentosocial VALUES (6403, '2020-06-09', 'Senador Guiomard', 42.33);
INSERT INTO pacto.isolamentosocial VALUES (6404, '2020-06-10', 'Senador Guiomard', 45.99);
INSERT INTO pacto.isolamentosocial VALUES (6405, '2020-06-11', 'Senador Guiomard', 49.14);
INSERT INTO pacto.isolamentosocial VALUES (6406, '2020-06-12', 'Senador Guiomard', 45.87);
INSERT INTO pacto.isolamentosocial VALUES (6407, '2020-06-13', 'Senador Guiomard', 45.71);
INSERT INTO pacto.isolamentosocial VALUES (6408, '2020-06-14', 'Senador Guiomard', 53.90);
INSERT INTO pacto.isolamentosocial VALUES (6409, '2020-06-15', 'Senador Guiomard', 46.21);
INSERT INTO pacto.isolamentosocial VALUES (6410, '2020-06-16', 'Senador Guiomard', 41.86);
INSERT INTO pacto.isolamentosocial VALUES (6411, '2020-06-17', 'Senador Guiomard', 41.65);
INSERT INTO pacto.isolamentosocial VALUES (6412, '2020-06-18', 'Senador Guiomard', 46.15);
INSERT INTO pacto.isolamentosocial VALUES (6413, '2020-06-19', 'Senador Guiomard', 39.93);
INSERT INTO pacto.isolamentosocial VALUES (6414, '2020-06-20', 'Senador Guiomard', 44.46);
INSERT INTO pacto.isolamentosocial VALUES (6415, '2020-06-21', 'Senador Guiomard', 52.22);
INSERT INTO pacto.isolamentosocial VALUES (6416, '2020-06-22', 'Senador Guiomard', 44.19);
INSERT INTO pacto.isolamentosocial VALUES (6417, '2020-06-23', 'Senador Guiomard', 44.92);
INSERT INTO pacto.isolamentosocial VALUES (6418, '2020-06-24', 'Senador Guiomard', 43.23);
INSERT INTO pacto.isolamentosocial VALUES (6419, '2020-06-25', 'Senador Guiomard', 38.91);
INSERT INTO pacto.isolamentosocial VALUES (6420, '2020-06-26', 'Senador Guiomard', 44.65);
INSERT INTO pacto.isolamentosocial VALUES (6421, '2020-06-27', 'Senador Guiomard', 47.75);
INSERT INTO pacto.isolamentosocial VALUES (6422, '2020-06-28', 'Senador Guiomard', 54.71);
INSERT INTO pacto.isolamentosocial VALUES (6423, '2020-06-29', 'Senador Guiomard', 42.15);
INSERT INTO pacto.isolamentosocial VALUES (6424, '2020-06-30', 'Senador Guiomard', 42.68);
INSERT INTO pacto.isolamentosocial VALUES (6425, '2020-07-01', 'Senador Guiomard', 43.95);
INSERT INTO pacto.isolamentosocial VALUES (6426, '2020-07-02', 'Senador Guiomard', 44.46);
INSERT INTO pacto.isolamentosocial VALUES (6427, '2020-07-03', 'Senador Guiomard', 45.47);
INSERT INTO pacto.isolamentosocial VALUES (6428, '2020-02-01', 'Tarauacá', 32.47);
INSERT INTO pacto.isolamentosocial VALUES (6429, '2020-02-02', 'Tarauacá', 39.31);
INSERT INTO pacto.isolamentosocial VALUES (6430, '2020-02-03', 'Tarauacá', 26.17);
INSERT INTO pacto.isolamentosocial VALUES (6431, '2020-02-04', 'Tarauacá', 27.92);
INSERT INTO pacto.isolamentosocial VALUES (6432, '2020-02-05', 'Tarauacá', 29.38);
INSERT INTO pacto.isolamentosocial VALUES (6433, '2020-02-06', 'Tarauacá', 28.65);
INSERT INTO pacto.isolamentosocial VALUES (6434, '2020-02-07', 'Tarauacá', 22.84);
INSERT INTO pacto.isolamentosocial VALUES (6435, '2020-02-08', 'Tarauacá', 24.32);
INSERT INTO pacto.isolamentosocial VALUES (6436, '2020-02-09', 'Tarauacá', 30.87);
INSERT INTO pacto.isolamentosocial VALUES (6437, '2020-02-10', 'Tarauacá', 18.06);
INSERT INTO pacto.isolamentosocial VALUES (6438, '2020-02-11', 'Tarauacá', 27.06);
INSERT INTO pacto.isolamentosocial VALUES (6439, '2020-02-12', 'Tarauacá', 22.01);
INSERT INTO pacto.isolamentosocial VALUES (6440, '2020-02-13', 'Tarauacá', 29.56);
INSERT INTO pacto.isolamentosocial VALUES (6441, '2020-02-14', 'Tarauacá', 30.52);
INSERT INTO pacto.isolamentosocial VALUES (6442, '2020-02-15', 'Tarauacá', 33.13);
INSERT INTO pacto.isolamentosocial VALUES (6443, '2020-02-16', 'Tarauacá', 34.72);
INSERT INTO pacto.isolamentosocial VALUES (6444, '2020-02-17', 'Tarauacá', 23.97);
INSERT INTO pacto.isolamentosocial VALUES (6445, '2020-02-18', 'Tarauacá', 22.60);
INSERT INTO pacto.isolamentosocial VALUES (6446, '2020-02-19', 'Tarauacá', 34.51);
INSERT INTO pacto.isolamentosocial VALUES (6447, '2020-02-20', 'Tarauacá', 22.86);
INSERT INTO pacto.isolamentosocial VALUES (6448, '2020-02-21', 'Tarauacá', 23.49);
INSERT INTO pacto.isolamentosocial VALUES (6449, '2020-02-22', 'Tarauacá', 28.48);
INSERT INTO pacto.isolamentosocial VALUES (6450, '2020-02-23', 'Tarauacá', 37.04);
INSERT INTO pacto.isolamentosocial VALUES (6451, '2020-02-24', 'Tarauacá', 32.19);
INSERT INTO pacto.isolamentosocial VALUES (6452, '2020-02-25', 'Tarauacá', 32.12);
INSERT INTO pacto.isolamentosocial VALUES (6453, '2020-02-26', 'Tarauacá', 35.62);
INSERT INTO pacto.isolamentosocial VALUES (6454, '2020-02-27', 'Tarauacá', 23.53);
INSERT INTO pacto.isolamentosocial VALUES (6455, '2020-02-28', 'Tarauacá', 20.00);
INSERT INTO pacto.isolamentosocial VALUES (6456, '2020-02-29', 'Tarauacá', 32.91);
INSERT INTO pacto.isolamentosocial VALUES (6457, '2020-03-01', 'Tarauacá', 45.68);
INSERT INTO pacto.isolamentosocial VALUES (6458, '2020-03-02', 'Tarauacá', 25.00);
INSERT INTO pacto.isolamentosocial VALUES (6459, '2020-03-03', 'Tarauacá', 30.12);
INSERT INTO pacto.isolamentosocial VALUES (6460, '2020-03-04', 'Tarauacá', 26.14);
INSERT INTO pacto.isolamentosocial VALUES (6461, '2020-03-05', 'Tarauacá', 23.84);
INSERT INTO pacto.isolamentosocial VALUES (6462, '2020-03-06', 'Tarauacá', 27.88);
INSERT INTO pacto.isolamentosocial VALUES (6463, '2020-03-07', 'Tarauacá', 31.51);
INSERT INTO pacto.isolamentosocial VALUES (6464, '2020-03-08', 'Tarauacá', 39.35);
INSERT INTO pacto.isolamentosocial VALUES (6465, '2020-03-09', 'Tarauacá', 29.66);
INSERT INTO pacto.isolamentosocial VALUES (6466, '2020-03-10', 'Tarauacá', 20.27);
INSERT INTO pacto.isolamentosocial VALUES (6467, '2020-03-11', 'Tarauacá', 25.68);
INSERT INTO pacto.isolamentosocial VALUES (6468, '2020-03-12', 'Tarauacá', 29.88);
INSERT INTO pacto.isolamentosocial VALUES (6469, '2020-03-13', 'Tarauacá', 38.51);
INSERT INTO pacto.isolamentosocial VALUES (6470, '2020-03-14', 'Tarauacá', 34.88);
INSERT INTO pacto.isolamentosocial VALUES (6471, '2020-03-15', 'Tarauacá', 36.62);
INSERT INTO pacto.isolamentosocial VALUES (6472, '2020-03-16', 'Tarauacá', 25.18);
INSERT INTO pacto.isolamentosocial VALUES (6473, '2020-03-17', 'Tarauacá', 31.55);
INSERT INTO pacto.isolamentosocial VALUES (6474, '2020-03-18', 'Tarauacá', 30.82);
INSERT INTO pacto.isolamentosocial VALUES (6475, '2020-03-19', 'Tarauacá', 33.77);
INSERT INTO pacto.isolamentosocial VALUES (6476, '2020-03-20', 'Tarauacá', 37.59);
INSERT INTO pacto.isolamentosocial VALUES (6477, '2020-03-21', 'Tarauacá', 48.57);
INSERT INTO pacto.isolamentosocial VALUES (6478, '2020-03-22', 'Tarauacá', 59.60);
INSERT INTO pacto.isolamentosocial VALUES (6479, '2020-03-23', 'Tarauacá', 49.34);
INSERT INTO pacto.isolamentosocial VALUES (6480, '2020-03-24', 'Tarauacá', 47.52);
INSERT INTO pacto.isolamentosocial VALUES (6481, '2020-03-25', 'Tarauacá', 45.70);
INSERT INTO pacto.isolamentosocial VALUES (6482, '2020-03-26', 'Tarauacá', 47.89);
INSERT INTO pacto.isolamentosocial VALUES (6483, '2020-03-27', 'Tarauacá', 42.57);
INSERT INTO pacto.isolamentosocial VALUES (6484, '2020-03-28', 'Tarauacá', 40.69);
INSERT INTO pacto.isolamentosocial VALUES (6485, '2020-03-29', 'Tarauacá', 47.06);
INSERT INTO pacto.isolamentosocial VALUES (6486, '2020-03-30', 'Tarauacá', 41.83);
INSERT INTO pacto.isolamentosocial VALUES (6487, '2020-03-31', 'Tarauacá', 38.71);
INSERT INTO pacto.isolamentosocial VALUES (6488, '2020-04-01', 'Tarauacá', 38.61);
INSERT INTO pacto.isolamentosocial VALUES (6489, '2020-04-02', 'Tarauacá', 39.52);
INSERT INTO pacto.isolamentosocial VALUES (6490, '2020-04-03', 'Tarauacá', 41.29);
INSERT INTO pacto.isolamentosocial VALUES (6491, '2020-04-04', 'Tarauacá', 40.25);
INSERT INTO pacto.isolamentosocial VALUES (6492, '2020-04-05', 'Tarauacá', 49.01);
INSERT INTO pacto.isolamentosocial VALUES (6493, '2020-04-06', 'Tarauacá', 36.47);
INSERT INTO pacto.isolamentosocial VALUES (6494, '2020-04-07', 'Tarauacá', 42.01);
INSERT INTO pacto.isolamentosocial VALUES (6495, '2020-04-08', 'Tarauacá', 42.86);
INSERT INTO pacto.isolamentosocial VALUES (6496, '2020-04-09', 'Tarauacá', 48.55);
INSERT INTO pacto.isolamentosocial VALUES (6497, '2020-04-10', 'Tarauacá', 49.38);
INSERT INTO pacto.isolamentosocial VALUES (6498, '2020-04-11', 'Tarauacá', 43.51);
INSERT INTO pacto.isolamentosocial VALUES (6499, '2020-04-12', 'Tarauacá', 58.11);
INSERT INTO pacto.isolamentosocial VALUES (6500, '2020-04-13', 'Tarauacá', 39.49);
INSERT INTO pacto.isolamentosocial VALUES (6501, '2020-04-14', 'Tarauacá', 46.15);
INSERT INTO pacto.isolamentosocial VALUES (6502, '2020-04-15', 'Tarauacá', 42.01);
INSERT INTO pacto.isolamentosocial VALUES (6503, '2020-04-16', 'Tarauacá', 44.30);
INSERT INTO pacto.isolamentosocial VALUES (6504, '2020-04-17', 'Tarauacá', 41.62);
INSERT INTO pacto.isolamentosocial VALUES (6505, '2020-04-18', 'Tarauacá', 41.36);
INSERT INTO pacto.isolamentosocial VALUES (6506, '2020-04-19', 'Tarauacá', 48.65);
INSERT INTO pacto.isolamentosocial VALUES (6507, '2020-04-20', 'Tarauacá', 47.65);
INSERT INTO pacto.isolamentosocial VALUES (6508, '2020-04-21', 'Tarauacá', 47.52);
INSERT INTO pacto.isolamentosocial VALUES (6509, '2020-04-22', 'Tarauacá', 45.56);
INSERT INTO pacto.isolamentosocial VALUES (6510, '2020-04-23', 'Tarauacá', 44.52);
INSERT INTO pacto.isolamentosocial VALUES (6511, '2020-04-24', 'Tarauacá', 43.37);
INSERT INTO pacto.isolamentosocial VALUES (6512, '2020-04-25', 'Tarauacá', 37.06);
INSERT INTO pacto.isolamentosocial VALUES (6513, '2020-04-26', 'Tarauacá', 42.51);
INSERT INTO pacto.isolamentosocial VALUES (6514, '2020-04-27', 'Tarauacá', 34.64);
INSERT INTO pacto.isolamentosocial VALUES (6515, '2020-04-28', 'Tarauacá', 34.10);
INSERT INTO pacto.isolamentosocial VALUES (6516, '2020-04-29', 'Tarauacá', 36.00);
INSERT INTO pacto.isolamentosocial VALUES (6517, '2020-04-30', 'Tarauacá', 30.77);
INSERT INTO pacto.isolamentosocial VALUES (6518, '2020-05-01', 'Tarauacá', 37.65);
INSERT INTO pacto.isolamentosocial VALUES (6519, '2020-05-02', 'Tarauacá', 38.24);
INSERT INTO pacto.isolamentosocial VALUES (6520, '2020-05-03', 'Tarauacá', 51.98);
INSERT INTO pacto.isolamentosocial VALUES (6521, '2020-05-04', 'Tarauacá', 37.50);
INSERT INTO pacto.isolamentosocial VALUES (6522, '2020-05-05', 'Tarauacá', 45.24);
INSERT INTO pacto.isolamentosocial VALUES (6523, '2020-05-06', 'Tarauacá', 43.45);
INSERT INTO pacto.isolamentosocial VALUES (6524, '2020-05-07', 'Tarauacá', 44.90);
INSERT INTO pacto.isolamentosocial VALUES (6525, '2020-05-08', 'Tarauacá', 44.37);
INSERT INTO pacto.isolamentosocial VALUES (6526, '2020-05-09', 'Tarauacá', 42.41);
INSERT INTO pacto.isolamentosocial VALUES (6527, '2020-05-10', 'Tarauacá', 45.56);
INSERT INTO pacto.isolamentosocial VALUES (6528, '2020-05-11', 'Tarauacá', 44.97);
INSERT INTO pacto.isolamentosocial VALUES (6529, '2020-05-12', 'Tarauacá', 47.77);
INSERT INTO pacto.isolamentosocial VALUES (6530, '2020-05-13', 'Tarauacá', 46.71);
INSERT INTO pacto.isolamentosocial VALUES (6531, '2020-05-14', 'Tarauacá', 43.43);
INSERT INTO pacto.isolamentosocial VALUES (6532, '2020-05-15', 'Tarauacá', 50.60);
INSERT INTO pacto.isolamentosocial VALUES (6533, '2020-05-16', 'Tarauacá', 48.05);
INSERT INTO pacto.isolamentosocial VALUES (6534, '2020-05-17', 'Tarauacá', 48.21);
INSERT INTO pacto.isolamentosocial VALUES (6535, '2020-05-18', 'Tarauacá', 46.10);
INSERT INTO pacto.isolamentosocial VALUES (6536, '2020-05-19', 'Tarauacá', 49.06);
INSERT INTO pacto.isolamentosocial VALUES (6537, '2020-05-20', 'Tarauacá', 36.53);
INSERT INTO pacto.isolamentosocial VALUES (6538, '2020-05-21', 'Tarauacá', 38.13);
INSERT INTO pacto.isolamentosocial VALUES (6539, '2020-05-22', 'Tarauacá', 46.01);
INSERT INTO pacto.isolamentosocial VALUES (6540, '2020-05-23', 'Tarauacá', 47.93);
INSERT INTO pacto.isolamentosocial VALUES (6541, '2020-05-24', 'Tarauacá', 55.69);
INSERT INTO pacto.isolamentosocial VALUES (6542, '2020-05-25', 'Tarauacá', 47.97);
INSERT INTO pacto.isolamentosocial VALUES (6543, '2020-05-26', 'Tarauacá', 42.76);
INSERT INTO pacto.isolamentosocial VALUES (6544, '2020-05-27', 'Tarauacá', 50.75);
INSERT INTO pacto.isolamentosocial VALUES (6545, '2020-05-28', 'Tarauacá', 48.18);
INSERT INTO pacto.isolamentosocial VALUES (6546, '2020-05-29', 'Tarauacá', 41.50);
INSERT INTO pacto.isolamentosocial VALUES (6547, '2020-05-30', 'Tarauacá', 47.80);
INSERT INTO pacto.isolamentosocial VALUES (6548, '2020-05-31', 'Tarauacá', 55.86);
INSERT INTO pacto.isolamentosocial VALUES (6549, '2020-06-01', 'Tarauacá', 43.87);
INSERT INTO pacto.isolamentosocial VALUES (6550, '2020-06-02', 'Tarauacá', 41.03);
INSERT INTO pacto.isolamentosocial VALUES (6551, '2020-06-03', 'Tarauacá', 37.50);
INSERT INTO pacto.isolamentosocial VALUES (6552, '2020-06-04', 'Tarauacá', 36.88);
INSERT INTO pacto.isolamentosocial VALUES (6553, '2020-06-05', 'Tarauacá', 35.07);
INSERT INTO pacto.isolamentosocial VALUES (6554, '2020-06-06', 'Tarauacá', 45.31);
INSERT INTO pacto.isolamentosocial VALUES (6555, '2020-06-07', 'Tarauacá', 46.27);
INSERT INTO pacto.isolamentosocial VALUES (6556, '2020-06-08', 'Tarauacá', 41.33);
INSERT INTO pacto.isolamentosocial VALUES (6557, '2020-06-09', 'Tarauacá', 51.32);
INSERT INTO pacto.isolamentosocial VALUES (6558, '2020-06-10', 'Tarauacá', 43.88);
INSERT INTO pacto.isolamentosocial VALUES (6559, '2020-06-11', 'Tarauacá', 42.95);
INSERT INTO pacto.isolamentosocial VALUES (6560, '2020-06-12', 'Tarauacá', 36.88);
INSERT INTO pacto.isolamentosocial VALUES (6561, '2020-06-13', 'Tarauacá', 43.97);
INSERT INTO pacto.isolamentosocial VALUES (6562, '2020-06-14', 'Tarauacá', 43.84);
INSERT INTO pacto.isolamentosocial VALUES (6563, '2020-06-15', 'Tarauacá', 36.73);
INSERT INTO pacto.isolamentosocial VALUES (6564, '2020-06-16', 'Tarauacá', 34.33);
INSERT INTO pacto.isolamentosocial VALUES (6565, '2020-06-17', 'Tarauacá', 40.43);
INSERT INTO pacto.isolamentosocial VALUES (6566, '2020-06-18', 'Tarauacá', 41.26);
INSERT INTO pacto.isolamentosocial VALUES (6567, '2020-06-19', 'Tarauacá', 37.01);
INSERT INTO pacto.isolamentosocial VALUES (6568, '2020-06-20', 'Tarauacá', 50.00);
INSERT INTO pacto.isolamentosocial VALUES (6569, '2020-06-21', 'Tarauacá', 50.35);
INSERT INTO pacto.isolamentosocial VALUES (6570, '2020-06-22', 'Tarauacá', 38.71);
INSERT INTO pacto.isolamentosocial VALUES (6571, '2020-06-23', 'Tarauacá', 43.21);
INSERT INTO pacto.isolamentosocial VALUES (6572, '2020-06-24', 'Tarauacá', 39.60);
INSERT INTO pacto.isolamentosocial VALUES (6573, '2020-06-25', 'Tarauacá', 42.68);
INSERT INTO pacto.isolamentosocial VALUES (6574, '2020-06-26', 'Tarauacá', 41.06);
INSERT INTO pacto.isolamentosocial VALUES (6575, '2020-06-27', 'Tarauacá', 47.78);
INSERT INTO pacto.isolamentosocial VALUES (6576, '2020-06-28', 'Tarauacá', 60.65);
INSERT INTO pacto.isolamentosocial VALUES (6577, '2020-06-29', 'Tarauacá', 42.42);
INSERT INTO pacto.isolamentosocial VALUES (6578, '2020-06-30', 'Tarauacá', 42.94);
INSERT INTO pacto.isolamentosocial VALUES (6579, '2020-07-01', 'Tarauacá', 32.95);
INSERT INTO pacto.isolamentosocial VALUES (6580, '2020-07-02', 'Tarauacá', 38.20);
INSERT INTO pacto.isolamentosocial VALUES (6581, '2020-07-03', 'Tarauacá', 38.20);
INSERT INTO pacto.isolamentosocial VALUES (6582, '2020-02-01', 'Xapuri', 27.43);
INSERT INTO pacto.isolamentosocial VALUES (6583, '2020-02-02', 'Xapuri', 42.98);
INSERT INTO pacto.isolamentosocial VALUES (6584, '2020-02-03', 'Xapuri', 23.13);
INSERT INTO pacto.isolamentosocial VALUES (6585, '2020-02-04', 'Xapuri', 18.60);
INSERT INTO pacto.isolamentosocial VALUES (6586, '2020-02-05', 'Xapuri', 21.88);
INSERT INTO pacto.isolamentosocial VALUES (6587, '2020-02-06', 'Xapuri', 24.24);
INSERT INTO pacto.isolamentosocial VALUES (6588, '2020-02-07', 'Xapuri', 22.90);
INSERT INTO pacto.isolamentosocial VALUES (6589, '2020-02-08', 'Xapuri', 29.84);
INSERT INTO pacto.isolamentosocial VALUES (6590, '2020-02-09', 'Xapuri', 32.59);
INSERT INTO pacto.isolamentosocial VALUES (6591, '2020-02-10', 'Xapuri', 20.00);
INSERT INTO pacto.isolamentosocial VALUES (6592, '2020-02-11', 'Xapuri', 33.08);
INSERT INTO pacto.isolamentosocial VALUES (6593, '2020-02-12', 'Xapuri', 24.79);
INSERT INTO pacto.isolamentosocial VALUES (6594, '2020-02-13', 'Xapuri', 27.61);
INSERT INTO pacto.isolamentosocial VALUES (6596, '2020-02-15', 'Xapuri', 30.61);
INSERT INTO pacto.isolamentosocial VALUES (6597, '2020-02-16', 'Xapuri', 32.14);
INSERT INTO pacto.isolamentosocial VALUES (6598, '2020-02-17', 'Xapuri', 24.65);
INSERT INTO pacto.isolamentosocial VALUES (6599, '2020-02-18', 'Xapuri', 24.82);
INSERT INTO pacto.isolamentosocial VALUES (6600, '2020-02-19', 'Xapuri', 26.56);
INSERT INTO pacto.isolamentosocial VALUES (6601, '2020-02-20', 'Xapuri', 21.71);
INSERT INTO pacto.isolamentosocial VALUES (6602, '2020-02-21', 'Xapuri', 21.43);
INSERT INTO pacto.isolamentosocial VALUES (6603, '2020-02-22', 'Xapuri', 28.93);
INSERT INTO pacto.isolamentosocial VALUES (6604, '2020-02-23', 'Xapuri', 27.35);
INSERT INTO pacto.isolamentosocial VALUES (6605, '2020-02-24', 'Xapuri', 35.43);
INSERT INTO pacto.isolamentosocial VALUES (6606, '2020-02-25', 'Xapuri', 37.31);
INSERT INTO pacto.isolamentosocial VALUES (6633, '2020-03-23', 'Xapuri', 54.69);
INSERT INTO pacto.isolamentosocial VALUES (3970, '2020-02-02', 'Acrelândia', 39.51);
INSERT INTO pacto.isolamentosocial VALUES (3971, '2020-02-03', 'Acrelândia', 26.01);
INSERT INTO pacto.isolamentosocial VALUES (3972, '2020-02-04', 'Acrelândia', 32.77);
INSERT INTO pacto.isolamentosocial VALUES (3973, '2020-02-05', 'Acrelândia', 30.64);
INSERT INTO pacto.isolamentosocial VALUES (3974, '2020-02-06', 'Acrelândia', 28.49);
INSERT INTO pacto.isolamentosocial VALUES (3975, '2020-02-07', 'Acrelândia', 29.31);
INSERT INTO pacto.isolamentosocial VALUES (3976, '2020-02-08', 'Acrelândia', 30.22);
INSERT INTO pacto.isolamentosocial VALUES (3977, '2020-02-09', 'Acrelândia', 38.01);
INSERT INTO pacto.isolamentosocial VALUES (3978, '2020-02-10', 'Acrelândia', 25.77);
INSERT INTO pacto.isolamentosocial VALUES (3979, '2020-02-11', 'Acrelândia', 27.04);
INSERT INTO pacto.isolamentosocial VALUES (3980, '2020-02-12', 'Acrelândia', 24.40);
INSERT INTO pacto.isolamentosocial VALUES (3981, '2020-02-13', 'Acrelândia', 28.90);
INSERT INTO pacto.isolamentosocial VALUES (6595, '2020-02-14', 'Xapuri', 27.86);
INSERT INTO pacto.isolamentosocial VALUES (6634, '2020-03-24', 'Xapuri', 55.17);
INSERT INTO pacto.isolamentosocial VALUES (6635, '2020-03-25', 'Xapuri', 56.20);
INSERT INTO pacto.isolamentosocial VALUES (6636, '2020-03-26', 'Xapuri', 47.66);
INSERT INTO pacto.isolamentosocial VALUES (6637, '2020-03-27', 'Xapuri', 50.00);
INSERT INTO pacto.isolamentosocial VALUES (6638, '2020-03-28', 'Xapuri', 54.62);
INSERT INTO pacto.isolamentosocial VALUES (6639, '2020-03-29', 'Xapuri', 56.93);
INSERT INTO pacto.isolamentosocial VALUES (6640, '2020-03-30', 'Xapuri', 45.65);
INSERT INTO pacto.isolamentosocial VALUES (6641, '2020-03-31', 'Xapuri', 38.76);
INSERT INTO pacto.isolamentosocial VALUES (6642, '2020-04-01', 'Xapuri', 47.20);
INSERT INTO pacto.isolamentosocial VALUES (6643, '2020-04-02', 'Xapuri', 47.10);
INSERT INTO pacto.isolamentosocial VALUES (6644, '2020-04-03', 'Xapuri', 50.76);
INSERT INTO pacto.isolamentosocial VALUES (6645, '2020-04-04', 'Xapuri', 55.91);
INSERT INTO pacto.isolamentosocial VALUES (6646, '2020-04-05', 'Xapuri', 43.44);
INSERT INTO pacto.isolamentosocial VALUES (6647, '2020-04-06', 'Xapuri', 46.56);
INSERT INTO pacto.isolamentosocial VALUES (6648, '2020-04-07', 'Xapuri', 41.09);
INSERT INTO pacto.isolamentosocial VALUES (6649, '2020-04-08', 'Xapuri', 38.57);
INSERT INTO pacto.isolamentosocial VALUES (6650, '2020-04-09', 'Xapuri', 45.30);
INSERT INTO pacto.isolamentosocial VALUES (6652, '2020-04-11', 'Xapuri', 48.72);
INSERT INTO pacto.isolamentosocial VALUES (6653, '2020-04-12', 'Xapuri', 47.46);
INSERT INTO pacto.isolamentosocial VALUES (6654, '2020-04-13', 'Xapuri', 44.68);
INSERT INTO pacto.isolamentosocial VALUES (6655, '2020-04-14', 'Xapuri', 45.11);
INSERT INTO pacto.isolamentosocial VALUES (6656, '2020-04-15', 'Xapuri', 51.88);
INSERT INTO pacto.isolamentosocial VALUES (6657, '2020-04-16', 'Xapuri', 40.15);
INSERT INTO pacto.isolamentosocial VALUES (6658, '2020-04-17', 'Xapuri', 48.18);
INSERT INTO pacto.isolamentosocial VALUES (6659, '2020-04-18', 'Xapuri', 53.90);
INSERT INTO pacto.isolamentosocial VALUES (6660, '2020-04-19', 'Xapuri', 50.00);
INSERT INTO pacto.isolamentosocial VALUES (6661, '2020-04-20', 'Xapuri', 44.67);
INSERT INTO pacto.isolamentosocial VALUES (6662, '2020-04-21', 'Xapuri', 49.63);
INSERT INTO pacto.isolamentosocial VALUES (6663, '2020-04-22', 'Xapuri', 43.70);
INSERT INTO pacto.isolamentosocial VALUES (6664, '2020-04-23', 'Xapuri', 42.96);
INSERT INTO pacto.isolamentosocial VALUES (6665, '2020-04-24', 'Xapuri', 40.00);
INSERT INTO pacto.isolamentosocial VALUES (6666, '2020-04-25', 'Xapuri', 45.08);
INSERT INTO pacto.isolamentosocial VALUES (6667, '2020-04-26', 'Xapuri', 42.75);
INSERT INTO pacto.isolamentosocial VALUES (6668, '2020-04-27', 'Xapuri', 49.37);
INSERT INTO pacto.isolamentosocial VALUES (6669, '2020-04-28', 'Xapuri', 42.21);
INSERT INTO pacto.isolamentosocial VALUES (6670, '2020-04-29', 'Xapuri', 49.41);
INSERT INTO pacto.isolamentosocial VALUES (6671, '2020-04-30', 'Xapuri', 50.60);
INSERT INTO pacto.isolamentosocial VALUES (6672, '2020-05-01', 'Xapuri', 50.00);
INSERT INTO pacto.isolamentosocial VALUES (6673, '2020-05-02', 'Xapuri', 54.55);
INSERT INTO pacto.isolamentosocial VALUES (6674, '2020-05-03', 'Xapuri', 58.44);
INSERT INTO pacto.isolamentosocial VALUES (6675, '2020-05-04', 'Xapuri', 47.02);
INSERT INTO pacto.isolamentosocial VALUES (6676, '2020-05-05', 'Xapuri', 45.00);
INSERT INTO pacto.isolamentosocial VALUES (6677, '2020-05-06', 'Xapuri', 48.17);
INSERT INTO pacto.isolamentosocial VALUES (6678, '2020-05-07', 'Xapuri', 43.05);
INSERT INTO pacto.isolamentosocial VALUES (6679, '2020-05-08', 'Xapuri', 35.14);
INSERT INTO pacto.isolamentosocial VALUES (6680, '2020-05-09', 'Xapuri', 52.94);
INSERT INTO pacto.isolamentosocial VALUES (6681, '2020-05-10', 'Xapuri', 45.26);
INSERT INTO pacto.isolamentosocial VALUES (6682, '2020-05-11', 'Xapuri', 42.48);
INSERT INTO pacto.isolamentosocial VALUES (6683, '2020-05-12', 'Xapuri', 37.95);
INSERT INTO pacto.isolamentosocial VALUES (6684, '2020-05-13', 'Xapuri', 40.94);
INSERT INTO pacto.isolamentosocial VALUES (6685, '2020-05-14', 'Xapuri', 49.68);
INSERT INTO pacto.isolamentosocial VALUES (6686, '2020-05-15', 'Xapuri', 42.94);
INSERT INTO pacto.isolamentosocial VALUES (6687, '2020-05-16', 'Xapuri', 49.33);
INSERT INTO pacto.isolamentosocial VALUES (6688, '2020-05-17', 'Xapuri', 51.53);
INSERT INTO pacto.isolamentosocial VALUES (6689, '2020-05-18', 'Xapuri', 43.37);
INSERT INTO pacto.isolamentosocial VALUES (6690, '2020-05-19', 'Xapuri', 50.00);
INSERT INTO pacto.isolamentosocial VALUES (6691, '2020-05-20', 'Xapuri', 42.77);
INSERT INTO pacto.isolamentosocial VALUES (6692, '2020-05-21', 'Xapuri', 42.31);
INSERT INTO pacto.isolamentosocial VALUES (6693, '2020-05-22', 'Xapuri', 40.80);
INSERT INTO pacto.isolamentosocial VALUES (6694, '2020-05-23', 'Xapuri', 51.33);
INSERT INTO pacto.isolamentosocial VALUES (6695, '2020-05-24', 'Xapuri', 53.89);
INSERT INTO pacto.isolamentosocial VALUES (6696, '2020-05-25', 'Xapuri', 44.44);
INSERT INTO pacto.isolamentosocial VALUES (6697, '2020-05-26', 'Xapuri', 46.10);
INSERT INTO pacto.isolamentosocial VALUES (6698, '2020-05-27', 'Xapuri', 47.62);
INSERT INTO pacto.isolamentosocial VALUES (6699, '2020-05-28', 'Xapuri', 50.90);
INSERT INTO pacto.isolamentosocial VALUES (3982, '2020-02-14', 'Acrelândia', 28.11);
INSERT INTO pacto.isolamentosocial VALUES (3983, '2020-02-15', 'Acrelândia', 33.33);
INSERT INTO pacto.isolamentosocial VALUES (3984, '2020-02-16', 'Acrelândia', 42.54);
INSERT INTO pacto.isolamentosocial VALUES (3985, '2020-02-17', 'Acrelândia', 26.29);
INSERT INTO pacto.isolamentosocial VALUES (3986, '2020-02-18', 'Acrelândia', 31.11);
INSERT INTO pacto.isolamentosocial VALUES (3987, '2020-02-19', 'Acrelândia', 32.61);
INSERT INTO pacto.isolamentosocial VALUES (3988, '2020-02-20', 'Acrelândia', 32.78);
INSERT INTO pacto.isolamentosocial VALUES (3989, '2020-02-21', 'Acrelândia', 22.87);
INSERT INTO pacto.isolamentosocial VALUES (3990, '2020-02-22', 'Acrelândia', 38.29);
INSERT INTO pacto.isolamentosocial VALUES (3991, '2020-02-23', 'Acrelândia', 42.62);
INSERT INTO pacto.isolamentosocial VALUES (3992, '2020-02-24', 'Acrelândia', 37.87);
INSERT INTO pacto.isolamentosocial VALUES (3993, '2020-02-25', 'Acrelândia', 44.09);
INSERT INTO pacto.isolamentosocial VALUES (3994, '2020-02-26', 'Acrelândia', 37.77);
INSERT INTO pacto.isolamentosocial VALUES (3995, '2020-02-27', 'Acrelândia', 30.53);
INSERT INTO pacto.isolamentosocial VALUES (3996, '2020-02-28', 'Acrelândia', 37.16);
INSERT INTO pacto.isolamentosocial VALUES (3997, '2020-02-29', 'Acrelândia', 39.04);
INSERT INTO pacto.isolamentosocial VALUES (3998, '2020-03-01', 'Acrelândia', 40.96);
INSERT INTO pacto.isolamentosocial VALUES (3999, '2020-03-02', 'Acrelândia', 33.52);
INSERT INTO pacto.isolamentosocial VALUES (4000, '2020-03-03', 'Acrelândia', 30.43);
INSERT INTO pacto.isolamentosocial VALUES (4001, '2020-03-04', 'Acrelândia', 40.31);
INSERT INTO pacto.isolamentosocial VALUES (4002, '2020-03-05', 'Acrelândia', 42.94);
INSERT INTO pacto.isolamentosocial VALUES (4003, '2020-03-06', 'Acrelândia', 28.89);
INSERT INTO pacto.isolamentosocial VALUES (4004, '2020-03-07', 'Acrelândia', 37.36);
INSERT INTO pacto.isolamentosocial VALUES (4005, '2020-03-08', 'Acrelândia', 45.05);
INSERT INTO pacto.isolamentosocial VALUES (4006, '2020-03-09', 'Acrelândia', 38.64);
INSERT INTO pacto.isolamentosocial VALUES (4007, '2020-03-10', 'Acrelândia', 38.69);
INSERT INTO pacto.isolamentosocial VALUES (4008, '2020-03-11', 'Acrelândia', 35.83);
INSERT INTO pacto.isolamentosocial VALUES (4009, '2020-03-12', 'Acrelândia', 36.76);
INSERT INTO pacto.isolamentosocial VALUES (4010, '2020-03-13', 'Acrelândia', 32.97);
INSERT INTO pacto.isolamentosocial VALUES (4011, '2020-03-14', 'Acrelândia', 44.02);
INSERT INTO pacto.isolamentosocial VALUES (4012, '2020-03-15', 'Acrelândia', 44.63);
INSERT INTO pacto.isolamentosocial VALUES (4013, '2020-03-16', 'Acrelândia', 39.38);
INSERT INTO pacto.isolamentosocial VALUES (4014, '2020-03-17', 'Acrelândia', 29.89);
INSERT INTO pacto.isolamentosocial VALUES (6702, '2020-05-31', 'Xapuri', 56.94);
INSERT INTO pacto.isolamentosocial VALUES (6703, '2020-06-01', 'Xapuri', 42.47);
INSERT INTO pacto.isolamentosocial VALUES (6704, '2020-06-02', 'Xapuri', 43.27);
INSERT INTO pacto.isolamentosocial VALUES (6705, '2020-06-03', 'Xapuri', 50.33);
INSERT INTO pacto.isolamentosocial VALUES (6706, '2020-06-04', 'Xapuri', 46.45);
INSERT INTO pacto.isolamentosocial VALUES (6707, '2020-06-05', 'Xapuri', 46.36);
INSERT INTO pacto.isolamentosocial VALUES (6708, '2020-06-06', 'Xapuri', 50.00);
INSERT INTO pacto.isolamentosocial VALUES (6709, '2020-06-07', 'Xapuri', 58.17);
INSERT INTO pacto.isolamentosocial VALUES (6710, '2020-06-08', 'Xapuri', 43.86);
INSERT INTO pacto.isolamentosocial VALUES (6711, '2020-06-09', 'Xapuri', 39.24);
INSERT INTO pacto.isolamentosocial VALUES (6712, '2020-06-10', 'Xapuri', 44.67);
INSERT INTO pacto.isolamentosocial VALUES (6713, '2020-06-11', 'Xapuri', 50.34);
INSERT INTO pacto.isolamentosocial VALUES (6714, '2020-06-12', 'Xapuri', 44.81);
INSERT INTO pacto.isolamentosocial VALUES (6715, '2020-06-13', 'Xapuri', 45.21);
INSERT INTO pacto.isolamentosocial VALUES (6716, '2020-06-14', 'Xapuri', 54.97);
INSERT INTO pacto.isolamentosocial VALUES (6719, '2020-06-17', 'Xapuri', 48.13);
INSERT INTO pacto.isolamentosocial VALUES (6720, '2020-06-18', 'Xapuri', 46.36);
INSERT INTO pacto.isolamentosocial VALUES (6721, '2020-06-19', 'Xapuri', 39.63);
INSERT INTO pacto.isolamentosocial VALUES (6722, '2020-06-20', 'Xapuri', 41.45);
INSERT INTO pacto.isolamentosocial VALUES (6723, '2020-06-21', 'Xapuri', 47.59);
INSERT INTO pacto.isolamentosocial VALUES (6724, '2020-06-22', 'Xapuri', 41.88);
INSERT INTO pacto.isolamentosocial VALUES (6725, '2020-06-23', 'Xapuri', 42.14);
INSERT INTO pacto.isolamentosocial VALUES (6726, '2020-06-24', 'Xapuri', 53.21);
INSERT INTO pacto.isolamentosocial VALUES (6727, '2020-06-25', 'Xapuri', 39.63);
INSERT INTO pacto.isolamentosocial VALUES (6728, '2020-06-26', 'Xapuri', 40.40);
INSERT INTO pacto.isolamentosocial VALUES (6729, '2020-06-27', 'Xapuri', 44.94);
INSERT INTO pacto.isolamentosocial VALUES (6730, '2020-06-28', 'Xapuri', 52.08);
INSERT INTO pacto.isolamentosocial VALUES (6731, '2020-06-29', 'Xapuri', 39.75);
INSERT INTO pacto.isolamentosocial VALUES (6732, '2020-06-30', 'Xapuri', 42.59);
INSERT INTO pacto.isolamentosocial VALUES (6733, '2020-07-01', 'Xapuri', 43.64);
INSERT INTO pacto.isolamentosocial VALUES (6734, '2020-07-02', 'Xapuri', 43.04);
INSERT INTO pacto.isolamentosocial VALUES (6735, '2020-07-03', 'Xapuri', 48.04);
INSERT INTO pacto.isolamentosocial VALUES (3969, '2020-02-01', 'Acrelândia', 34.20);
INSERT INTO pacto.isolamentosocial VALUES (6607, '2020-02-26', 'Xapuri', 30.95);
INSERT INTO pacto.isolamentosocial VALUES (6608, '2020-02-27', 'Xapuri', 25.93);
INSERT INTO pacto.isolamentosocial VALUES (6609, '2020-02-28', 'Xapuri', 23.88);
INSERT INTO pacto.isolamentosocial VALUES (6610, '2020-02-29', 'Xapuri', 35.66);
INSERT INTO pacto.isolamentosocial VALUES (6611, '2020-03-01', 'Xapuri', 42.11);
INSERT INTO pacto.isolamentosocial VALUES (6612, '2020-03-02', 'Xapuri', 25.18);
INSERT INTO pacto.isolamentosocial VALUES (6614, '2020-03-04', 'Xapuri', 29.77);
INSERT INTO pacto.isolamentosocial VALUES (6615, '2020-03-05', 'Xapuri', 34.42);
INSERT INTO pacto.isolamentosocial VALUES (6616, '2020-03-06', 'Xapuri', 30.22);
INSERT INTO pacto.isolamentosocial VALUES (6617, '2020-03-07', 'Xapuri', 37.40);
INSERT INTO pacto.isolamentosocial VALUES (6618, '2020-03-08', 'Xapuri', 35.51);
INSERT INTO pacto.isolamentosocial VALUES (6619, '2020-03-09', 'Xapuri', 30.60);
INSERT INTO pacto.isolamentosocial VALUES (6620, '2020-03-10', 'Xapuri', 28.57);
INSERT INTO pacto.isolamentosocial VALUES (6621, '2020-03-11', 'Xapuri', 27.61);
INSERT INTO pacto.isolamentosocial VALUES (6622, '2020-03-12', 'Xapuri', 28.79);
INSERT INTO pacto.isolamentosocial VALUES (6623, '2020-03-13', 'Xapuri', 27.34);
INSERT INTO pacto.isolamentosocial VALUES (6624, '2020-03-14', 'Xapuri', 44.52);
INSERT INTO pacto.isolamentosocial VALUES (6625, '2020-03-15', 'Xapuri', 52.41);
INSERT INTO pacto.isolamentosocial VALUES (6626, '2020-03-16', 'Xapuri', 30.61);
INSERT INTO pacto.isolamentosocial VALUES (6627, '2020-03-17', 'Xapuri', 29.46);
INSERT INTO pacto.isolamentosocial VALUES (6628, '2020-03-18', 'Xapuri', 43.84);
INSERT INTO pacto.isolamentosocial VALUES (6629, '2020-03-19', 'Xapuri', 45.31);
INSERT INTO pacto.isolamentosocial VALUES (6630, '2020-03-20', 'Xapuri', 44.06);
INSERT INTO pacto.isolamentosocial VALUES (6631, '2020-03-21', 'Xapuri', 51.05);
INSERT INTO pacto.isolamentosocial VALUES (6632, '2020-03-22', 'Xapuri', 60.47);
INSERT INTO pacto.isolamentosocial VALUES (5435, '2020-04-20', 'Manoel Urbano', 45.90);
INSERT INTO pacto.isolamentosocial VALUES (4015, '2020-03-18', 'Acrelândia', 35.56);
INSERT INTO pacto.isolamentosocial VALUES (4016, '2020-03-19', 'Acrelândia', 40.22);
INSERT INTO pacto.isolamentosocial VALUES (4017, '2020-03-20', 'Acrelândia', 39.47);
INSERT INTO pacto.isolamentosocial VALUES (4018, '2020-03-21', 'Acrelândia', 51.89);
INSERT INTO pacto.isolamentosocial VALUES (4054, '2020-04-26', 'Acrelândia', 50.87);
INSERT INTO pacto.isolamentosocial VALUES (4055, '2020-04-27', 'Acrelândia', 43.41);
INSERT INTO pacto.isolamentosocial VALUES (4056, '2020-04-28', 'Acrelândia', 39.50);
INSERT INTO pacto.isolamentosocial VALUES (4057, '2020-04-29', 'Acrelândia', 36.74);
INSERT INTO pacto.isolamentosocial VALUES (4058, '2020-04-30', 'Acrelândia', 34.15);
INSERT INTO pacto.isolamentosocial VALUES (4059, '2020-05-01', 'Acrelândia', 42.41);
INSERT INTO pacto.isolamentosocial VALUES (4060, '2020-05-02', 'Acrelândia', 45.37);
INSERT INTO pacto.isolamentosocial VALUES (4061, '2020-05-03', 'Acrelândia', 42.93);
INSERT INTO pacto.isolamentosocial VALUES (4062, '2020-05-04', 'Acrelândia', 39.66);
INSERT INTO pacto.isolamentosocial VALUES (4063, '2020-05-05', 'Acrelândia', 41.28);
INSERT INTO pacto.isolamentosocial VALUES (4064, '2020-05-06', 'Acrelândia', 38.89);
INSERT INTO pacto.isolamentosocial VALUES (4065, '2020-05-07', 'Acrelândia', 47.03);
INSERT INTO pacto.isolamentosocial VALUES (4066, '2020-05-08', 'Acrelândia', 46.86);
INSERT INTO pacto.isolamentosocial VALUES (4067, '2020-05-09', 'Acrelândia', 48.83);
INSERT INTO pacto.isolamentosocial VALUES (4068, '2020-05-10', 'Acrelândia', 48.51);
INSERT INTO pacto.isolamentosocial VALUES (4069, '2020-05-11', 'Acrelândia', 40.18);
INSERT INTO pacto.isolamentosocial VALUES (4070, '2020-05-12', 'Acrelândia', 42.47);
INSERT INTO pacto.isolamentosocial VALUES (4071, '2020-05-13', 'Acrelândia', 41.31);
INSERT INTO pacto.isolamentosocial VALUES (4072, '2020-05-14', 'Acrelândia', 49.76);
INSERT INTO pacto.isolamentosocial VALUES (4073, '2020-05-15', 'Acrelândia', 37.20);
INSERT INTO pacto.isolamentosocial VALUES (4074, '2020-05-16', 'Acrelândia', 46.24);
INSERT INTO pacto.isolamentosocial VALUES (4075, '2020-05-17', 'Acrelândia', 49.28);
INSERT INTO pacto.isolamentosocial VALUES (4076, '2020-05-18', 'Acrelândia', 41.82);
INSERT INTO pacto.isolamentosocial VALUES (4254, '2020-06-11', 'Assis Brasil', 56.60);
INSERT INTO pacto.isolamentosocial VALUES (4255, '2020-06-12', 'Assis Brasil', 37.74);
INSERT INTO pacto.isolamentosocial VALUES (4256, '2020-06-13', 'Assis Brasil', 48.84);
INSERT INTO pacto.isolamentosocial VALUES (4257, '2020-06-14', 'Assis Brasil', 40.82);
INSERT INTO pacto.isolamentosocial VALUES (4258, '2020-06-15', 'Assis Brasil', 40.38);
INSERT INTO pacto.isolamentosocial VALUES (4259, '2020-06-16', 'Assis Brasil', 42.86);
INSERT INTO pacto.isolamentosocial VALUES (4260, '2020-06-17', 'Assis Brasil', 41.07);
INSERT INTO pacto.isolamentosocial VALUES (4261, '2020-06-18', 'Assis Brasil', 49.09);
INSERT INTO pacto.isolamentosocial VALUES (4262, '2020-06-19', 'Assis Brasil', 32.08);
INSERT INTO pacto.isolamentosocial VALUES (6651, '2020-04-10', 'Xapuri', 60.50);
INSERT INTO pacto.isolamentosocial VALUES (4263, '2020-06-20', 'Assis Brasil', 45.76);
INSERT INTO pacto.isolamentosocial VALUES (4264, '2020-06-21', 'Assis Brasil', 63.46);
INSERT INTO pacto.isolamentosocial VALUES (4265, '2020-06-22', 'Assis Brasil', 46.88);
INSERT INTO pacto.isolamentosocial VALUES (4266, '2020-06-23', 'Assis Brasil', 46.67);
INSERT INTO pacto.isolamentosocial VALUES (4267, '2020-06-24', 'Assis Brasil', 41.27);
INSERT INTO pacto.isolamentosocial VALUES (4268, '2020-06-25', 'Assis Brasil', 46.67);
INSERT INTO pacto.isolamentosocial VALUES (4269, '2020-06-26', 'Assis Brasil', 42.42);
INSERT INTO pacto.isolamentosocial VALUES (4270, '2020-06-27', 'Assis Brasil', 51.92);
INSERT INTO pacto.isolamentosocial VALUES (4271, '2020-06-28', 'Assis Brasil', 55.17);
INSERT INTO pacto.isolamentosocial VALUES (4272, '2020-06-29', 'Assis Brasil', 36.11);
INSERT INTO pacto.isolamentosocial VALUES (4273, '2020-06-30', 'Assis Brasil', 44.26);
INSERT INTO pacto.isolamentosocial VALUES (4274, '2020-07-01', 'Assis Brasil', 34.38);
INSERT INTO pacto.isolamentosocial VALUES (4275, '2020-07-02', 'Assis Brasil', 43.55);
INSERT INTO pacto.isolamentosocial VALUES (4276, '2020-07-03', 'Assis Brasil', 39.29);
INSERT INTO pacto.isolamentosocial VALUES (4277, '2020-02-01', 'Brasiléia', 37.96);
INSERT INTO pacto.isolamentosocial VALUES (4278, '2020-02-02', 'Brasiléia', 45.76);
INSERT INTO pacto.isolamentosocial VALUES (4279, '2020-02-03', 'Brasiléia', 30.86);
INSERT INTO pacto.isolamentosocial VALUES (4280, '2020-02-04', 'Brasiléia', 32.03);
INSERT INTO pacto.isolamentosocial VALUES (4281, '2020-02-05', 'Brasiléia', 26.15);
INSERT INTO pacto.isolamentosocial VALUES (4282, '2020-02-06', 'Brasiléia', 28.14);
INSERT INTO pacto.isolamentosocial VALUES (4283, '2020-02-07', 'Brasiléia', 31.35);
INSERT INTO pacto.isolamentosocial VALUES (4284, '2020-02-08', 'Brasiléia', 27.90);
INSERT INTO pacto.isolamentosocial VALUES (4285, '2020-02-09', 'Brasiléia', 38.40);
INSERT INTO pacto.isolamentosocial VALUES (4286, '2020-02-10', 'Brasiléia', 28.85);
INSERT INTO pacto.isolamentosocial VALUES (4287, '2020-02-11', 'Brasiléia', 21.19);
INSERT INTO pacto.isolamentosocial VALUES (4288, '2020-02-12', 'Brasiléia', 23.27);
INSERT INTO pacto.isolamentosocial VALUES (4289, '2020-02-13', 'Brasiléia', 25.77);
INSERT INTO pacto.isolamentosocial VALUES (4290, '2020-02-14', 'Brasiléia', 31.10);
INSERT INTO pacto.isolamentosocial VALUES (4291, '2020-02-15', 'Brasiléia', 30.74);
INSERT INTO pacto.isolamentosocial VALUES (4292, '2020-02-16', 'Brasiléia', 42.86);
INSERT INTO pacto.isolamentosocial VALUES (4293, '2020-02-17', 'Brasiléia', 29.57);
INSERT INTO pacto.isolamentosocial VALUES (4294, '2020-02-18', 'Brasiléia', 35.25);
INSERT INTO pacto.isolamentosocial VALUES (4295, '2020-02-19', 'Brasiléia', 35.14);
INSERT INTO pacto.isolamentosocial VALUES (4296, '2020-02-20', 'Brasiléia', 28.36);
INSERT INTO pacto.isolamentosocial VALUES (4297, '2020-02-21', 'Brasiléia', 26.94);
INSERT INTO pacto.isolamentosocial VALUES (4300, '2020-02-24', 'Brasiléia', 29.07);
INSERT INTO pacto.isolamentosocial VALUES (4302, '2020-02-26', 'Brasiléia', 27.91);
INSERT INTO pacto.isolamentosocial VALUES (4303, '2020-02-27', 'Brasiléia', 28.40);
INSERT INTO pacto.isolamentosocial VALUES (4304, '2020-02-28', 'Brasiléia', 25.37);
INSERT INTO pacto.isolamentosocial VALUES (4305, '2020-02-29', 'Brasiléia', 28.03);
INSERT INTO pacto.isolamentosocial VALUES (4306, '2020-03-01', 'Brasiléia', 40.71);
INSERT INTO pacto.isolamentosocial VALUES (4077, '2020-05-19', 'Acrelândia', 47.89);
INSERT INTO pacto.isolamentosocial VALUES (4078, '2020-05-20', 'Acrelândia', 46.79);
INSERT INTO pacto.isolamentosocial VALUES (4079, '2020-05-21', 'Acrelândia', 42.36);
INSERT INTO pacto.isolamentosocial VALUES (4080, '2020-05-22', 'Acrelândia', 39.82);
INSERT INTO pacto.isolamentosocial VALUES (4081, '2020-05-23', 'Acrelândia', 43.52);
INSERT INTO pacto.isolamentosocial VALUES (4082, '2020-05-24', 'Acrelândia', 49.02);
INSERT INTO pacto.isolamentosocial VALUES (4083, '2020-05-25', 'Acrelândia', 42.98);
INSERT INTO pacto.isolamentosocial VALUES (4084, '2020-05-26', 'Acrelândia', 39.47);
INSERT INTO pacto.isolamentosocial VALUES (4085, '2020-05-27', 'Acrelândia', 39.55);
INSERT INTO pacto.isolamentosocial VALUES (4086, '2020-05-28', 'Acrelândia', 41.59);
INSERT INTO pacto.isolamentosocial VALUES (4087, '2020-05-29', 'Acrelândia', 37.90);
INSERT INTO pacto.isolamentosocial VALUES (4088, '2020-05-30', 'Acrelândia', 40.47);
INSERT INTO pacto.isolamentosocial VALUES (4089, '2020-05-31', 'Acrelândia', 42.79);
INSERT INTO pacto.isolamentosocial VALUES (6700, '2020-05-29', 'Xapuri', 39.86);
INSERT INTO pacto.isolamentosocial VALUES (4353, '2020-04-17', 'Brasiléia', 38.23);
INSERT INTO pacto.isolamentosocial VALUES (4354, '2020-04-18', 'Brasiléia', 37.01);
INSERT INTO pacto.isolamentosocial VALUES (4355, '2020-04-19', 'Brasiléia', 43.88);
INSERT INTO pacto.isolamentosocial VALUES (4356, '2020-04-20', 'Brasiléia', 44.29);
INSERT INTO pacto.isolamentosocial VALUES (4357, '2020-04-21', 'Brasiléia', 46.18);
INSERT INTO pacto.isolamentosocial VALUES (4358, '2020-04-22', 'Brasiléia', 43.69);
INSERT INTO pacto.isolamentosocial VALUES (4359, '2020-04-23', 'Brasiléia', 43.31);
INSERT INTO pacto.isolamentosocial VALUES (4301, '2020-02-25', 'Brasiléia', 36.00);
INSERT INTO pacto.isolamentosocial VALUES (4134, '2020-02-12', 'Assis Brasil', 31.71);
INSERT INTO pacto.isolamentosocial VALUES (4135, '2020-02-13', 'Assis Brasil', 29.41);
INSERT INTO pacto.isolamentosocial VALUES (4136, '2020-02-14', 'Assis Brasil', 26.09);
INSERT INTO pacto.isolamentosocial VALUES (4401, '2020-06-04', 'Brasiléia', 38.19);
INSERT INTO pacto.isolamentosocial VALUES (4402, '2020-06-05', 'Brasiléia', 38.02);
INSERT INTO pacto.isolamentosocial VALUES (4403, '2020-06-06', 'Brasiléia', 38.25);
INSERT INTO pacto.isolamentosocial VALUES (4404, '2020-06-07', 'Brasiléia', 51.60);
INSERT INTO pacto.isolamentosocial VALUES (4405, '2020-06-08', 'Brasiléia', 36.74);
INSERT INTO pacto.isolamentosocial VALUES (4406, '2020-06-09', 'Brasiléia', 36.17);
INSERT INTO pacto.isolamentosocial VALUES (4407, '2020-06-10', 'Brasiléia', 36.23);
INSERT INTO pacto.isolamentosocial VALUES (4454, '2020-02-24', 'Bujari', 37.04);
INSERT INTO pacto.isolamentosocial VALUES (4455, '2020-02-25', 'Bujari', 35.20);
INSERT INTO pacto.isolamentosocial VALUES (4456, '2020-02-26', 'Bujari', 31.29);
INSERT INTO pacto.isolamentosocial VALUES (4457, '2020-02-27', 'Bujari', 30.77);
INSERT INTO pacto.isolamentosocial VALUES (6777, '2020-07-06', 'Cruzeiro do Sul', 46.13);
INSERT INTO pacto.isolamentosocial VALUES (6778, '2020-07-06', 'Epitaciolândia', 43.27);
INSERT INTO pacto.isolamentosocial VALUES (6779, '2020-07-06', 'Feijó', 40.61);
INSERT INTO pacto.isolamentosocial VALUES (6780, '2020-07-06', 'Mâncio Lima', 45.28);
INSERT INTO pacto.isolamentosocial VALUES (6781, '2020-07-06', 'Manoel Urbano', 34.55);
INSERT INTO pacto.isolamentosocial VALUES (6782, '2020-07-06', 'Plácido de Castro', 40.81);
INSERT INTO pacto.isolamentosocial VALUES (6783, '2020-07-06', 'Porto Acre', 39.41);
INSERT INTO pacto.isolamentosocial VALUES (6784, '2020-07-06', 'Rio Branco', 43.31);
INSERT INTO pacto.isolamentosocial VALUES (6785, '2020-07-06', 'Rodrigues Alves', 46.88);
INSERT INTO pacto.isolamentosocial VALUES (6786, '2020-07-06', 'Sena Madureira', 38.48);
INSERT INTO pacto.isolamentosocial VALUES (6787, '2020-07-06', 'Senador Guiomard', 44.61);
INSERT INTO pacto.isolamentosocial VALUES (6788, '2020-07-06', 'Tarauacá', 40.25);
INSERT INTO pacto.isolamentosocial VALUES (6789, '2020-07-06', 'Xapuri', 41.21);
INSERT INTO pacto.isolamentosocial VALUES (6790, '2020-07-07', 'Acrelândia', 37.39);
INSERT INTO pacto.isolamentosocial VALUES (6791, '2020-07-07', 'Assis Brasil', 43.40);
INSERT INTO pacto.isolamentosocial VALUES (6792, '2020-07-07', 'Brasiléia', 35.99);
INSERT INTO pacto.isolamentosocial VALUES (6793, '2020-07-07', 'Bujari', 37.44);
INSERT INTO pacto.isolamentosocial VALUES (6794, '2020-07-07', 'Capixaba', 33.94);
INSERT INTO pacto.isolamentosocial VALUES (6795, '2020-07-07', 'Cruzeiro do Sul', 58.06);
INSERT INTO pacto.isolamentosocial VALUES (6796, '2020-07-07', 'Epitaciolândia', 44.71);
INSERT INTO pacto.isolamentosocial VALUES (6797, '2020-07-07', 'Feijó', 40.31);
INSERT INTO pacto.isolamentosocial VALUES (6798, '2020-07-07', 'Mâncio Lima', 67.44);
INSERT INTO pacto.isolamentosocial VALUES (6799, '2020-07-07', 'Manoel Urbano', 42.19);
INSERT INTO pacto.isolamentosocial VALUES (6800, '2020-07-07', 'Plácido de Castro', 45.25);
INSERT INTO pacto.isolamentosocial VALUES (6801, '2020-07-07', 'Porto Acre', 47.06);
INSERT INTO pacto.isolamentosocial VALUES (6802, '2020-07-07', 'Rio Branco', 42.65);
INSERT INTO pacto.isolamentosocial VALUES (6803, '2020-07-07', 'Sena Madureira', 38.57);
INSERT INTO pacto.isolamentosocial VALUES (6804, '2020-07-07', 'Senador Guiomard', 43.49);
INSERT INTO pacto.isolamentosocial VALUES (6805, '2020-07-07', 'Tarauacá', 38.61);
INSERT INTO pacto.isolamentosocial VALUES (6807, '2020-07-08', 'Acrelândia', 35.56);
INSERT INTO pacto.isolamentosocial VALUES (6808, '2020-07-08', 'Assis Brasil', 47.17);
INSERT INTO pacto.isolamentosocial VALUES (6809, '2020-07-08', 'Brasiléia', 41.12);
INSERT INTO pacto.isolamentosocial VALUES (6810, '2020-07-08', 'Bujari', 42.00);
INSERT INTO pacto.isolamentosocial VALUES (6811, '2020-07-08', 'Capixaba', 37.72);
INSERT INTO pacto.isolamentosocial VALUES (6812, '2020-07-08', 'Cruzeiro do Sul', 41.26);
INSERT INTO pacto.isolamentosocial VALUES (6813, '2020-07-08', 'Epitaciolândia', 46.67);
INSERT INTO pacto.isolamentosocial VALUES (6814, '2020-07-08', 'Feijó', 31.95);
INSERT INTO pacto.isolamentosocial VALUES (6815, '2020-07-08', 'Mâncio Lima', 39.06);
INSERT INTO pacto.isolamentosocial VALUES (6816, '2020-07-08', 'Manoel Urbano', 38.71);
INSERT INTO pacto.isolamentosocial VALUES (6817, '2020-07-08', 'Marechal Thaumaturgo', 40.00);
INSERT INTO pacto.isolamentosocial VALUES (4476, '2020-03-17', 'Bujari', 30.60);
INSERT INTO pacto.isolamentosocial VALUES (4477, '2020-03-18', 'Bujari', 42.96);
INSERT INTO pacto.isolamentosocial VALUES (4478, '2020-03-19', 'Bujari', 36.00);
INSERT INTO pacto.isolamentosocial VALUES (4479, '2020-03-20', 'Bujari', 41.18);
INSERT INTO pacto.isolamentosocial VALUES (4480, '2020-03-21', 'Bujari', 42.54);
INSERT INTO pacto.isolamentosocial VALUES (4481, '2020-03-22', 'Bujari', 58.21);
INSERT INTO pacto.isolamentosocial VALUES (4482, '2020-03-23', 'Bujari', 46.36);
INSERT INTO pacto.isolamentosocial VALUES (4483, '2020-03-24', 'Bujari', 52.48);
INSERT INTO pacto.isolamentosocial VALUES (4484, '2020-03-25', 'Bujari', 53.44);
INSERT INTO pacto.isolamentosocial VALUES (4485, '2020-03-26', 'Bujari', 44.44);
INSERT INTO pacto.isolamentosocial VALUES (4486, '2020-03-27', 'Bujari', 49.32);
INSERT INTO pacto.isolamentosocial VALUES (4487, '2020-03-28', 'Bujari', 50.00);
INSERT INTO pacto.isolamentosocial VALUES (4488, '2020-03-29', 'Bujari', 50.82);
INSERT INTO pacto.isolamentosocial VALUES (4489, '2020-03-30', 'Bujari', 45.07);
INSERT INTO pacto.isolamentosocial VALUES (4490, '2020-03-31', 'Bujari', 47.01);
INSERT INTO pacto.isolamentosocial VALUES (4491, '2020-04-01', 'Bujari', 48.53);
INSERT INTO pacto.isolamentosocial VALUES (4492, '2020-04-02', 'Bujari', 44.22);
INSERT INTO pacto.isolamentosocial VALUES (4493, '2020-04-03', 'Bujari', 43.80);
INSERT INTO pacto.isolamentosocial VALUES (4494, '2020-04-04', 'Bujari', 52.03);
INSERT INTO pacto.isolamentosocial VALUES (4495, '2020-04-05', 'Bujari', 54.55);
INSERT INTO pacto.isolamentosocial VALUES (4496, '2020-04-06', 'Bujari', 40.60);
INSERT INTO pacto.isolamentosocial VALUES (4497, '2020-04-07', 'Bujari', 42.38);
INSERT INTO pacto.isolamentosocial VALUES (4498, '2020-04-08', 'Bujari', 45.77);
INSERT INTO pacto.isolamentosocial VALUES (4499, '2020-04-09', 'Bujari', 42.28);
INSERT INTO pacto.isolamentosocial VALUES (4500, '2020-04-10', 'Bujari', 45.74);
INSERT INTO pacto.isolamentosocial VALUES (4501, '2020-04-11', 'Bujari', 44.07);
INSERT INTO pacto.isolamentosocial VALUES (4502, '2020-04-12', 'Bujari', 49.21);
INSERT INTO pacto.isolamentosocial VALUES (4503, '2020-04-13', 'Bujari', 41.79);
INSERT INTO pacto.isolamentosocial VALUES (4504, '2020-04-14', 'Bujari', 45.81);
INSERT INTO pacto.isolamentosocial VALUES (4505, '2020-04-15', 'Bujari', 45.89);
INSERT INTO pacto.isolamentosocial VALUES (4506, '2020-04-16', 'Bujari', 38.41);
INSERT INTO pacto.isolamentosocial VALUES (4507, '2020-04-17', 'Bujari', 33.74);
INSERT INTO pacto.isolamentosocial VALUES (4508, '2020-04-18', 'Bujari', 50.00);
INSERT INTO pacto.isolamentosocial VALUES (4509, '2020-04-19', 'Bujari', 52.94);
INSERT INTO pacto.isolamentosocial VALUES (4510, '2020-04-20', 'Bujari', 43.42);
INSERT INTO pacto.isolamentosocial VALUES (4511, '2020-04-21', 'Bujari', 54.48);
INSERT INTO pacto.isolamentosocial VALUES (4512, '2020-04-22', 'Bujari', 37.68);
INSERT INTO pacto.isolamentosocial VALUES (4513, '2020-04-23', 'Bujari', 46.10);
INSERT INTO pacto.isolamentosocial VALUES (4514, '2020-04-24', 'Bujari', 41.22);
INSERT INTO pacto.isolamentosocial VALUES (4515, '2020-04-25', 'Bujari', 46.51);
INSERT INTO pacto.isolamentosocial VALUES (4516, '2020-04-26', 'Bujari', 49.18);
INSERT INTO pacto.isolamentosocial VALUES (4517, '2020-04-27', 'Bujari', 40.88);
INSERT INTO pacto.isolamentosocial VALUES (4518, '2020-04-28', 'Bujari', 42.38);
INSERT INTO pacto.isolamentosocial VALUES (4519, '2020-04-29', 'Bujari', 37.89);
INSERT INTO pacto.isolamentosocial VALUES (4520, '2020-04-30', 'Bujari', 46.99);
INSERT INTO pacto.isolamentosocial VALUES (6818, '2020-07-08', 'Plácido de Castro', 37.97);
INSERT INTO pacto.isolamentosocial VALUES (6819, '2020-07-08', 'Porto Acre', 43.85);
INSERT INTO pacto.isolamentosocial VALUES (6820, '2020-07-08', 'Rio Branco', 42.35);
INSERT INTO pacto.isolamentosocial VALUES (6821, '2020-07-08', 'Rodrigues Alves', 45.83);
INSERT INTO pacto.isolamentosocial VALUES (6822, '2020-07-08', 'Sena Madureira', 37.93);
INSERT INTO pacto.isolamentosocial VALUES (6823, '2020-07-08', 'Senador Guiomard', 43.62);
INSERT INTO pacto.isolamentosocial VALUES (6824, '2020-07-08', 'Tarauacá', 41.06);
INSERT INTO pacto.isolamentosocial VALUES (6825, '2020-07-08', 'Xapuri', 44.03);
INSERT INTO pacto.isolamentosocial VALUES (6826, '2020-07-09', 'Acrelândia', 41.86);
INSERT INTO pacto.isolamentosocial VALUES (6827, '2020-07-09', 'Assis Brasil', 43.48);
INSERT INTO pacto.isolamentosocial VALUES (6828, '2020-07-09', 'Brasiléia', 49.83);
INSERT INTO pacto.isolamentosocial VALUES (6895, '2020-07-12', 'Rodrigues Alves', 70.37);
INSERT INTO pacto.isolamentosocial VALUES (6896, '2020-07-12', 'Sena Madureira', 49.88);
INSERT INTO pacto.isolamentosocial VALUES (6955, '2020-07-15', 'Xapuri', 39.35);
INSERT INTO pacto.isolamentosocial VALUES (6956, '2020-07-16', 'Acrelândia', 31.96);
INSERT INTO pacto.isolamentosocial VALUES (6957, '2020-07-16', 'Assis Brasil', 31.92);
INSERT INTO pacto.isolamentosocial VALUES (6958, '2020-07-16', 'Brasiléia', 39.38);
INSERT INTO pacto.isolamentosocial VALUES (6959, '2020-07-16', 'Bujari', 45.69);
INSERT INTO pacto.isolamentosocial VALUES (6960, '2020-07-16', 'Capixaba', 41.75);
INSERT INTO pacto.isolamentosocial VALUES (6961, '2020-07-16', 'Cruzeiro do Sul', 43.49);
INSERT INTO pacto.isolamentosocial VALUES (6962, '2020-07-16', 'Epitaciolândia', 43.37);
INSERT INTO pacto.isolamentosocial VALUES (6963, '2020-07-16', 'Feijó', 41.81);
INSERT INTO pacto.isolamentosocial VALUES (6964, '2020-07-16', 'Mâncio Lima', 48.33);
INSERT INTO pacto.isolamentosocial VALUES (6965, '2020-07-16', 'Manoel Urbano', 46.05);
INSERT INTO pacto.isolamentosocial VALUES (6966, '2020-07-16', 'Marechal Thaumaturgo', 34.78);
INSERT INTO pacto.isolamentosocial VALUES (6967, '2020-07-16', 'Plácido de Castro', 41.88);
INSERT INTO pacto.isolamentosocial VALUES (6968, '2020-07-16', 'Porto Acre', 45.32);
INSERT INTO pacto.isolamentosocial VALUES (6969, '2020-07-16', 'Rio Branco', 43.16);
INSERT INTO pacto.isolamentosocial VALUES (6970, '2020-07-16', 'Rodrigues Alves', 52.17);
INSERT INTO pacto.isolamentosocial VALUES (6971, '2020-07-16', 'Sena Madureira', 39.43);
INSERT INTO pacto.isolamentosocial VALUES (6972, '2020-07-16', 'Senador Guiomard', 46.60);
INSERT INTO pacto.isolamentosocial VALUES (5755, '2020-05-01', 'Porto Acre', 47.50);
INSERT INTO pacto.isolamentosocial VALUES (6701, '2020-05-30', 'Xapuri', 50.35);
INSERT INTO pacto.isolamentosocial VALUES (4105, '2020-06-16', 'Acrelândia', 45.45);
INSERT INTO pacto.isolamentosocial VALUES (4106, '2020-06-17', 'Acrelândia', 38.53);
INSERT INTO pacto.isolamentosocial VALUES (4107, '2020-06-18', 'Acrelândia', 39.72);
INSERT INTO pacto.isolamentosocial VALUES (4108, '2020-06-19', 'Acrelândia', 37.50);
INSERT INTO pacto.isolamentosocial VALUES (4109, '2020-06-20', 'Acrelândia', 42.08);
INSERT INTO pacto.isolamentosocial VALUES (4110, '2020-06-21', 'Acrelândia', 46.23);
INSERT INTO pacto.isolamentosocial VALUES (4111, '2020-06-22', 'Acrelândia', 33.77);
INSERT INTO pacto.isolamentosocial VALUES (4112, '2020-06-23', 'Acrelândia', 43.27);
INSERT INTO pacto.isolamentosocial VALUES (4113, '2020-06-24', 'Acrelândia', 37.78);
INSERT INTO pacto.isolamentosocial VALUES (4114, '2020-06-25', 'Acrelândia', 37.50);
INSERT INTO pacto.isolamentosocial VALUES (4115, '2020-06-26', 'Acrelândia', 37.17);
INSERT INTO pacto.isolamentosocial VALUES (4116, '2020-06-27', 'Acrelândia', 44.87);
INSERT INTO pacto.isolamentosocial VALUES (4117, '2020-06-28', 'Acrelândia', 50.00);
INSERT INTO pacto.isolamentosocial VALUES (4118, '2020-06-29', 'Acrelândia', 35.77);
INSERT INTO pacto.isolamentosocial VALUES (4119, '2020-06-30', 'Acrelândia', 43.78);
INSERT INTO pacto.isolamentosocial VALUES (4228, '2020-05-16', 'Assis Brasil', 50.00);
INSERT INTO pacto.isolamentosocial VALUES (4229, '2020-05-17', 'Assis Brasil', 43.40);
INSERT INTO pacto.isolamentosocial VALUES (4230, '2020-05-18', 'Assis Brasil', 32.14);
INSERT INTO pacto.isolamentosocial VALUES (4231, '2020-05-19', 'Assis Brasil', 40.00);
INSERT INTO pacto.isolamentosocial VALUES (4232, '2020-05-20', 'Assis Brasil', 36.84);
INSERT INTO pacto.isolamentosocial VALUES (4233, '2020-05-21', 'Assis Brasil', 49.06);
INSERT INTO pacto.isolamentosocial VALUES (4234, '2020-05-22', 'Assis Brasil', 54.24);
INSERT INTO pacto.isolamentosocial VALUES (4235, '2020-05-23', 'Assis Brasil', 53.85);
INSERT INTO pacto.isolamentosocial VALUES (4236, '2020-05-24', 'Assis Brasil', 70.37);
INSERT INTO pacto.isolamentosocial VALUES (4237, '2020-05-25', 'Assis Brasil', 49.02);
INSERT INTO pacto.isolamentosocial VALUES (4238, '2020-05-26', 'Assis Brasil', 40.74);
INSERT INTO pacto.isolamentosocial VALUES (4239, '2020-05-27', 'Assis Brasil', 46.55);
INSERT INTO pacto.isolamentosocial VALUES (4240, '2020-05-28', 'Assis Brasil', 45.28);
INSERT INTO pacto.isolamentosocial VALUES (4241, '2020-05-29', 'Assis Brasil', 40.00);
INSERT INTO pacto.isolamentosocial VALUES (4242, '2020-05-30', 'Assis Brasil', 45.45);
INSERT INTO pacto.isolamentosocial VALUES (4243, '2020-05-31', 'Assis Brasil', 67.27);
INSERT INTO pacto.isolamentosocial VALUES (4244, '2020-06-01', 'Assis Brasil', 37.93);
INSERT INTO pacto.isolamentosocial VALUES (4245, '2020-06-02', 'Assis Brasil', 52.38);
INSERT INTO pacto.isolamentosocial VALUES (4246, '2020-06-03', 'Assis Brasil', 46.15);
INSERT INTO pacto.isolamentosocial VALUES (4247, '2020-06-04', 'Assis Brasil', 43.75);
INSERT INTO pacto.isolamentosocial VALUES (4248, '2020-06-05', 'Assis Brasil', 47.27);
INSERT INTO pacto.isolamentosocial VALUES (4249, '2020-06-06', 'Assis Brasil', 53.33);
INSERT INTO pacto.isolamentosocial VALUES (4120, '2020-07-01', 'Acrelândia', 37.92);
INSERT INTO pacto.isolamentosocial VALUES (4121, '2020-07-02', 'Acrelândia', 36.33);
INSERT INTO pacto.isolamentosocial VALUES (4149, '2020-02-27', 'Assis Brasil', 48.78);
INSERT INTO pacto.isolamentosocial VALUES (4150, '2020-02-28', 'Assis Brasil', 40.91);
INSERT INTO pacto.isolamentosocial VALUES (4209, '2020-04-27', 'Assis Brasil', 51.02);
INSERT INTO pacto.isolamentosocial VALUES (4210, '2020-04-28', 'Assis Brasil', 40.00);
INSERT INTO pacto.isolamentosocial VALUES (4211, '2020-04-29', 'Assis Brasil', 45.28);
INSERT INTO pacto.isolamentosocial VALUES (4212, '2020-04-30', 'Assis Brasil', 46.81);
INSERT INTO pacto.isolamentosocial VALUES (4213, '2020-05-01', 'Assis Brasil', 46.34);
INSERT INTO pacto.isolamentosocial VALUES (4214, '2020-05-02', 'Assis Brasil', 34.88);
INSERT INTO pacto.isolamentosocial VALUES (4215, '2020-05-03', 'Assis Brasil', 60.00);
INSERT INTO pacto.isolamentosocial VALUES (4216, '2020-05-04', 'Assis Brasil', 36.59);
INSERT INTO pacto.isolamentosocial VALUES (4217, '2020-05-05', 'Assis Brasil', 41.30);
INSERT INTO pacto.isolamentosocial VALUES (4218, '2020-05-06', 'Assis Brasil', 44.44);
INSERT INTO pacto.isolamentosocial VALUES (4219, '2020-05-07', 'Assis Brasil', 52.27);
INSERT INTO pacto.isolamentosocial VALUES (4220, '2020-05-08', 'Assis Brasil', 43.64);
INSERT INTO pacto.isolamentosocial VALUES (4221, '2020-05-09', 'Assis Brasil', 38.46);
INSERT INTO pacto.isolamentosocial VALUES (4222, '2020-05-10', 'Assis Brasil', 36.59);
INSERT INTO pacto.isolamentosocial VALUES (4223, '2020-05-11', 'Assis Brasil', 37.78);
INSERT INTO pacto.isolamentosocial VALUES (4369, '2020-05-03', 'Brasiléia', 51.59);
INSERT INTO pacto.isolamentosocial VALUES (4370, '2020-05-04', 'Brasiléia', 36.30);
INSERT INTO pacto.isolamentosocial VALUES (4371, '2020-05-05', 'Brasiléia', 41.28);
INSERT INTO pacto.isolamentosocial VALUES (4372, '2020-05-06', 'Brasiléia', 42.07);
INSERT INTO pacto.isolamentosocial VALUES (4373, '2020-05-07', 'Brasiléia', 40.07);
INSERT INTO pacto.isolamentosocial VALUES (4374, '2020-05-08', 'Brasiléia', 39.18);
INSERT INTO pacto.isolamentosocial VALUES (4375, '2020-05-09', 'Brasiléia', 39.26);
INSERT INTO pacto.isolamentosocial VALUES (4376, '2020-05-10', 'Brasiléia', 45.35);
INSERT INTO pacto.isolamentosocial VALUES (4377, '2020-05-11', 'Brasiléia', 43.01);
INSERT INTO pacto.isolamentosocial VALUES (4378, '2020-05-12', 'Brasiléia', 37.22);
INSERT INTO pacto.isolamentosocial VALUES (4379, '2020-05-13', 'Brasiléia', 42.52);
INSERT INTO pacto.isolamentosocial VALUES (4380, '2020-05-14', 'Brasiléia', 42.66);
INSERT INTO pacto.isolamentosocial VALUES (4381, '2020-05-15', 'Brasiléia', 38.94);
INSERT INTO pacto.isolamentosocial VALUES (4382, '2020-05-16', 'Brasiléia', 46.98);
INSERT INTO pacto.isolamentosocial VALUES (4383, '2020-05-17', 'Brasiléia', 49.25);
INSERT INTO pacto.isolamentosocial VALUES (4384, '2020-05-18', 'Brasiléia', 41.01);
INSERT INTO pacto.isolamentosocial VALUES (4385, '2020-05-19', 'Brasiléia', 43.71);
INSERT INTO pacto.isolamentosocial VALUES (4386, '2020-05-20', 'Brasiléia', 46.15);
INSERT INTO pacto.isolamentosocial VALUES (4387, '2020-05-21', 'Brasiléia', 40.50);
INSERT INTO pacto.isolamentosocial VALUES (4388, '2020-05-22', 'Brasiléia', 43.42);
INSERT INTO pacto.isolamentosocial VALUES (4389, '2020-05-23', 'Brasiléia', 46.29);
INSERT INTO pacto.isolamentosocial VALUES (4390, '2020-05-24', 'Brasiléia', 58.65);
INSERT INTO pacto.isolamentosocial VALUES (4391, '2020-05-25', 'Brasiléia', 43.46);
INSERT INTO pacto.isolamentosocial VALUES (4392, '2020-05-26', 'Brasiléia', 37.41);
INSERT INTO pacto.isolamentosocial VALUES (4393, '2020-05-27', 'Brasiléia', 46.93);
INSERT INTO pacto.isolamentosocial VALUES (4395, '2020-05-29', 'Brasiléia', 42.03);
INSERT INTO pacto.isolamentosocial VALUES (4396, '2020-05-30', 'Brasiléia', 43.96);
INSERT INTO pacto.isolamentosocial VALUES (4397, '2020-05-31', 'Brasiléia', 53.49);
INSERT INTO pacto.isolamentosocial VALUES (4398, '2020-06-01', 'Brasiléia', 38.19);
INSERT INTO pacto.isolamentosocial VALUES (4399, '2020-06-02', 'Brasiléia', 37.02);
INSERT INTO pacto.isolamentosocial VALUES (4400, '2020-06-03', 'Brasiléia', 38.16);
INSERT INTO pacto.isolamentosocial VALUES (6754, '2020-07-05', 'Acrelândia', 52.89);
INSERT INTO pacto.isolamentosocial VALUES (6752, '2020-07-04', 'Tarauacá', 43.53);
INSERT INTO pacto.isolamentosocial VALUES (4439, '2020-02-09', 'Bujari', 34.23);
INSERT INTO pacto.isolamentosocial VALUES (6755, '2020-07-05', 'Assis Brasil', 69.77);
INSERT INTO pacto.isolamentosocial VALUES (6756, '2020-07-05', 'Brasiléia', 43.60);
INSERT INTO pacto.isolamentosocial VALUES (6757, '2020-07-05', 'Bujari', 46.37);
INSERT INTO pacto.isolamentosocial VALUES (6758, '2020-07-05', 'Capixaba', 51.35);
INSERT INTO pacto.isolamentosocial VALUES (6759, '2020-07-05', 'Cruzeiro do Sul', 51.76);
INSERT INTO pacto.isolamentosocial VALUES (6760, '2020-07-05', 'Epitaciolândia', 51.42);
INSERT INTO pacto.isolamentosocial VALUES (6761, '2020-07-05', 'Feijó', 51.32);
INSERT INTO pacto.isolamentosocial VALUES (6762, '2020-07-05', 'Mâncio Lima', 43.33);
INSERT INTO pacto.isolamentosocial VALUES (6763, '2020-07-05', 'Manoel Urbano', 55.00);
INSERT INTO pacto.isolamentosocial VALUES (6764, '2020-07-05', 'Plácido de Castro', 52.11);
INSERT INTO pacto.isolamentosocial VALUES (6765, '2020-07-05', 'Porto Acre', 51.53);
INSERT INTO pacto.isolamentosocial VALUES (6766, '2020-07-05', 'Rio Branco', 51.89);
INSERT INTO pacto.isolamentosocial VALUES (6767, '2020-07-05', 'Rodrigues Alves', 64.00);
INSERT INTO pacto.isolamentosocial VALUES (6768, '2020-07-05', 'Sena Madureira', 54.38);
INSERT INTO pacto.isolamentosocial VALUES (6769, '2020-07-05', 'Senador Guiomard', 52.57);
INSERT INTO pacto.isolamentosocial VALUES (6770, '2020-07-05', 'Tarauacá', 45.81);
INSERT INTO pacto.isolamentosocial VALUES (6771, '2020-07-05', 'Xapuri', 53.95);
INSERT INTO pacto.isolamentosocial VALUES (6772, '2020-07-06', 'Acrelândia', 38.63);
INSERT INTO pacto.isolamentosocial VALUES (6773, '2020-07-06', 'Assis Brasil', 38.46);
INSERT INTO pacto.isolamentosocial VALUES (6774, '2020-07-06', 'Brasiléia', 44.86);
INSERT INTO pacto.isolamentosocial VALUES (6775, '2020-07-06', 'Bujari', 34.29);
INSERT INTO pacto.isolamentosocial VALUES (6736, '2020-07-04', 'Rio Branco', 44.49);
INSERT INTO pacto.isolamentosocial VALUES (6737, '2020-07-04', 'Acrelândia', 40.78);
INSERT INTO pacto.isolamentosocial VALUES (4250, '2020-06-07', 'Assis Brasil', 58.33);
INSERT INTO pacto.isolamentosocial VALUES (4251, '2020-06-08', 'Assis Brasil', 35.85);
INSERT INTO pacto.isolamentosocial VALUES (4252, '2020-06-09', 'Assis Brasil', 35.56);
INSERT INTO pacto.isolamentosocial VALUES (4253, '2020-06-10', 'Assis Brasil', 50.00);
INSERT INTO pacto.isolamentosocial VALUES (6738, '2020-07-04', 'Assis Brasil', 50.91);
INSERT INTO pacto.isolamentosocial VALUES (6739, '2020-07-04', 'Brasiléia', 42.37);
INSERT INTO pacto.isolamentosocial VALUES (6740, '2020-07-04', 'Bujari', 49.18);
INSERT INTO pacto.isolamentosocial VALUES (6741, '2020-07-04', 'Capixaba', 44.66);
INSERT INTO pacto.isolamentosocial VALUES (6742, '2020-07-04', 'Cruzeiro do Sul', 43.09);
INSERT INTO pacto.isolamentosocial VALUES (6743, '2020-07-04', 'Epitaciolândia', 45.30);
INSERT INTO pacto.isolamentosocial VALUES (6744, '2020-07-04', 'Feijó', 46.15);
INSERT INTO pacto.isolamentosocial VALUES (6745, '2020-07-04', 'Mâncio Lima', 46.77);
INSERT INTO pacto.isolamentosocial VALUES (6746, '2020-07-04', 'Manoel Urbano', 40.74);
INSERT INTO pacto.isolamentosocial VALUES (6747, '2020-07-04', 'Plácido de Castro', 48.33);
INSERT INTO pacto.isolamentosocial VALUES (6748, '2020-07-04', 'Porto Acre', 49.66);
INSERT INTO pacto.isolamentosocial VALUES (6749, '2020-07-04', 'Rodrigues Alves', 42.31);
INSERT INTO pacto.isolamentosocial VALUES (6750, '2020-07-04', 'Sena Madureira', 36.34);
INSERT INTO pacto.isolamentosocial VALUES (6751, '2020-07-04', 'Senador Guiomard', 47.77);
INSERT INTO pacto.isolamentosocial VALUES (5380, '2020-02-25', 'Manoel Urbano', 43.10);
INSERT INTO pacto.isolamentosocial VALUES (5517, '2020-02-07', 'Plácido de Castro', 29.51);
INSERT INTO pacto.isolamentosocial VALUES (5770, '2020-05-16', 'Porto Acre', 46.67);
INSERT INTO pacto.isolamentosocial VALUES (6717, '2020-06-15', 'Xapuri', 46.58);
INSERT INTO pacto.isolamentosocial VALUES (6718, '2020-06-16', 'Xapuri', 38.73);
INSERT INTO pacto.isolamentosocial VALUES (4091, '2020-06-02', 'Acrelândia', 40.00);
INSERT INTO pacto.isolamentosocial VALUES (4092, '2020-06-03', 'Acrelândia', 42.86);
INSERT INTO pacto.isolamentosocial VALUES (4093, '2020-06-04', 'Acrelândia', 42.86);
INSERT INTO pacto.isolamentosocial VALUES (4094, '2020-06-05', 'Acrelândia', 41.24);
INSERT INTO pacto.isolamentosocial VALUES (4095, '2020-06-06', 'Acrelândia', 36.89);
INSERT INTO pacto.isolamentosocial VALUES (4096, '2020-06-07', 'Acrelândia', 45.85);
INSERT INTO pacto.isolamentosocial VALUES (4097, '2020-06-08', 'Acrelândia', 34.54);
INSERT INTO pacto.isolamentosocial VALUES (4098, '2020-06-09', 'Acrelândia', 32.88);
INSERT INTO pacto.isolamentosocial VALUES (4099, '2020-06-10', 'Acrelândia', 38.28);
INSERT INTO pacto.isolamentosocial VALUES (4019, '2020-03-22', 'Acrelândia', 54.22);
INSERT INTO pacto.isolamentosocial VALUES (4020, '2020-03-23', 'Acrelândia', 52.07);
INSERT INTO pacto.isolamentosocial VALUES (4458, '2020-02-28', 'Bujari', 23.74);
INSERT INTO pacto.isolamentosocial VALUES (4021, '2020-03-24', 'Acrelândia', 56.98);
INSERT INTO pacto.isolamentosocial VALUES (5452, '2020-05-07', 'Manoel Urbano', 35.00);
INSERT INTO pacto.isolamentosocial VALUES (5702, '2020-03-09', 'Porto Acre', 33.50);
INSERT INTO pacto.isolamentosocial VALUES (4151, '2020-02-29', 'Assis Brasil', 56.00);
INSERT INTO pacto.isolamentosocial VALUES (4152, '2020-03-01', 'Assis Brasil', 55.32);
INSERT INTO pacto.isolamentosocial VALUES (4153, '2020-03-02', 'Assis Brasil', 43.75);
INSERT INTO pacto.isolamentosocial VALUES (4154, '2020-03-03', 'Assis Brasil', 38.64);
INSERT INTO pacto.isolamentosocial VALUES (4155, '2020-03-04', 'Assis Brasil', 44.44);
INSERT INTO pacto.isolamentosocial VALUES (4156, '2020-03-05', 'Assis Brasil', 47.37);
INSERT INTO pacto.isolamentosocial VALUES (4157, '2020-03-06', 'Assis Brasil', 41.86);
INSERT INTO pacto.isolamentosocial VALUES (4611, '2020-02-27', 'Capixaba', 25.37);
INSERT INTO pacto.isolamentosocial VALUES (5375, '2020-02-20', 'Manoel Urbano', 27.27);
INSERT INTO pacto.isolamentosocial VALUES (4750, '2020-02-12', 'Cruzeiro do Sul', 26.85);
INSERT INTO pacto.isolamentosocial VALUES (4624, '2020-03-11', 'Capixaba', 36.00);
INSERT INTO pacto.isolamentosocial VALUES (4158, '2020-03-07', 'Assis Brasil', 38.10);
INSERT INTO pacto.isolamentosocial VALUES (4159, '2020-03-08', 'Assis Brasil', 47.06);
INSERT INTO pacto.isolamentosocial VALUES (4160, '2020-03-09', 'Assis Brasil', 41.67);
INSERT INTO pacto.isolamentosocial VALUES (4161, '2020-03-10', 'Assis Brasil', 48.39);
INSERT INTO pacto.isolamentosocial VALUES (4162, '2020-03-11', 'Assis Brasil', 30.95);
INSERT INTO pacto.isolamentosocial VALUES (4163, '2020-03-12', 'Assis Brasil', 38.89);
INSERT INTO pacto.isolamentosocial VALUES (4164, '2020-03-13', 'Assis Brasil', 48.65);
INSERT INTO pacto.isolamentosocial VALUES (4165, '2020-03-14', 'Assis Brasil', 44.19);
INSERT INTO pacto.isolamentosocial VALUES (4166, '2020-03-15', 'Assis Brasil', 65.12);
INSERT INTO pacto.isolamentosocial VALUES (4167, '2020-03-16', 'Assis Brasil', 26.83);
INSERT INTO pacto.isolamentosocial VALUES (4168, '2020-03-17', 'Assis Brasil', 31.25);
INSERT INTO pacto.isolamentosocial VALUES (4169, '2020-03-18', 'Assis Brasil', 39.58);
INSERT INTO pacto.isolamentosocial VALUES (4170, '2020-03-19', 'Assis Brasil', 44.00);
INSERT INTO pacto.isolamentosocial VALUES (4171, '2020-03-20', 'Assis Brasil', 50.00);
INSERT INTO pacto.isolamentosocial VALUES (4172, '2020-03-21', 'Assis Brasil', 60.00);
INSERT INTO pacto.isolamentosocial VALUES (4173, '2020-03-22', 'Assis Brasil', 53.85);
INSERT INTO pacto.isolamentosocial VALUES (4174, '2020-03-23', 'Assis Brasil', 37.74);
INSERT INTO pacto.isolamentosocial VALUES (4175, '2020-03-24', 'Assis Brasil', 51.02);
INSERT INTO pacto.isolamentosocial VALUES (4176, '2020-03-25', 'Assis Brasil', 55.56);
INSERT INTO pacto.isolamentosocial VALUES (4177, '2020-03-26', 'Assis Brasil', 52.17);
INSERT INTO pacto.isolamentosocial VALUES (4178, '2020-03-27', 'Assis Brasil', 52.17);
INSERT INTO pacto.isolamentosocial VALUES (4179, '2020-03-28', 'Assis Brasil', 60.78);
INSERT INTO pacto.isolamentosocial VALUES (4180, '2020-03-29', 'Assis Brasil', 71.79);
INSERT INTO pacto.isolamentosocial VALUES (4181, '2020-03-30', 'Assis Brasil', 58.82);
INSERT INTO pacto.isolamentosocial VALUES (4182, '2020-03-31', 'Assis Brasil', 43.40);
INSERT INTO pacto.isolamentosocial VALUES (4183, '2020-04-01', 'Assis Brasil', 36.36);
INSERT INTO pacto.isolamentosocial VALUES (4184, '2020-04-02', 'Assis Brasil', 35.71);
INSERT INTO pacto.isolamentosocial VALUES (4185, '2020-04-03', 'Assis Brasil', 51.06);
INSERT INTO pacto.isolamentosocial VALUES (4186, '2020-04-04', 'Assis Brasil', 52.38);
INSERT INTO pacto.isolamentosocial VALUES (4187, '2020-04-05', 'Assis Brasil', 55.00);
INSERT INTO pacto.isolamentosocial VALUES (4188, '2020-04-06', 'Assis Brasil', 50.00);
INSERT INTO pacto.isolamentosocial VALUES (4189, '2020-04-07', 'Assis Brasil', 46.34);
INSERT INTO pacto.isolamentosocial VALUES (4190, '2020-04-08', 'Assis Brasil', 51.16);
INSERT INTO pacto.isolamentosocial VALUES (4191, '2020-04-09', 'Assis Brasil', 50.00);
INSERT INTO pacto.isolamentosocial VALUES (4192, '2020-04-10', 'Assis Brasil', 40.00);
INSERT INTO pacto.isolamentosocial VALUES (4193, '2020-04-11', 'Assis Brasil', 53.85);
INSERT INTO pacto.isolamentosocial VALUES (4194, '2020-04-12', 'Assis Brasil', 50.00);
INSERT INTO pacto.isolamentosocial VALUES (4195, '2020-04-13', 'Assis Brasil', 47.50);
INSERT INTO pacto.isolamentosocial VALUES (4196, '2020-04-14', 'Assis Brasil', 51.35);
INSERT INTO pacto.isolamentosocial VALUES (4197, '2020-04-15', 'Assis Brasil', 60.42);
INSERT INTO pacto.isolamentosocial VALUES (4198, '2020-04-16', 'Assis Brasil', 33.33);
INSERT INTO pacto.isolamentosocial VALUES (4199, '2020-04-17', 'Assis Brasil', 46.55);
INSERT INTO pacto.isolamentosocial VALUES (4200, '2020-04-18', 'Assis Brasil', 53.06);
INSERT INTO pacto.isolamentosocial VALUES (4122, '2020-07-03', 'Acrelândia', 35.86);
INSERT INTO pacto.isolamentosocial VALUES (4123, '2020-02-01', 'Assis Brasil', 51.22);
INSERT INTO pacto.isolamentosocial VALUES (4124, '2020-02-02', 'Assis Brasil', 69.44);
INSERT INTO pacto.isolamentosocial VALUES (4125, '2020-02-03', 'Assis Brasil', 52.50);
INSERT INTO pacto.isolamentosocial VALUES (4126, '2020-02-04', 'Assis Brasil', 34.15);
INSERT INTO pacto.isolamentosocial VALUES (4127, '2020-02-05', 'Assis Brasil', 38.10);
INSERT INTO pacto.isolamentosocial VALUES (4128, '2020-02-06', 'Assis Brasil', 48.57);
INSERT INTO pacto.isolamentosocial VALUES (4129, '2020-02-07', 'Assis Brasil', 38.89);
INSERT INTO pacto.isolamentosocial VALUES (4130, '2020-02-08', 'Assis Brasil', 34.38);
INSERT INTO pacto.isolamentosocial VALUES (4131, '2020-02-09', 'Assis Brasil', 25.53);
INSERT INTO pacto.isolamentosocial VALUES (4132, '2020-02-10', 'Assis Brasil', 35.29);
INSERT INTO pacto.isolamentosocial VALUES (4133, '2020-02-11', 'Assis Brasil', 34.00);
INSERT INTO pacto.isolamentosocial VALUES (4307, '2020-03-02', 'Brasiléia', 24.43);
INSERT INTO pacto.isolamentosocial VALUES (4308, '2020-03-03', 'Brasiléia', 28.67);
INSERT INTO pacto.isolamentosocial VALUES (4309, '2020-03-04', 'Brasiléia', 33.56);
INSERT INTO pacto.isolamentosocial VALUES (4310, '2020-03-05', 'Brasiléia', 30.07);
INSERT INTO pacto.isolamentosocial VALUES (4311, '2020-03-06', 'Brasiléia', 36.09);
INSERT INTO pacto.isolamentosocial VALUES (4312, '2020-03-07', 'Brasiléia', 31.49);
INSERT INTO pacto.isolamentosocial VALUES (4313, '2020-03-08', 'Brasiléia', 46.74);
INSERT INTO pacto.isolamentosocial VALUES (4314, '2020-03-09', 'Brasiléia', 33.45);
INSERT INTO pacto.isolamentosocial VALUES (4315, '2020-03-10', 'Brasiléia', 28.97);
INSERT INTO pacto.isolamentosocial VALUES (4316, '2020-03-11', 'Brasiléia', 30.24);
INSERT INTO pacto.isolamentosocial VALUES (4317, '2020-03-12', 'Brasiléia', 33.77);
INSERT INTO pacto.isolamentosocial VALUES (4318, '2020-03-13', 'Brasiléia', 35.35);
INSERT INTO pacto.isolamentosocial VALUES (4319, '2020-03-14', 'Brasiléia', 40.94);
INSERT INTO pacto.isolamentosocial VALUES (4320, '2020-03-15', 'Brasiléia', 49.22);
INSERT INTO pacto.isolamentosocial VALUES (4321, '2020-03-16', 'Brasiléia', 30.53);
INSERT INTO pacto.isolamentosocial VALUES (4322, '2020-03-17', 'Brasiléia', 26.92);
INSERT INTO pacto.isolamentosocial VALUES (4323, '2020-03-18', 'Brasiléia', 34.28);
INSERT INTO pacto.isolamentosocial VALUES (4324, '2020-03-19', 'Brasiléia', 37.94);
INSERT INTO pacto.isolamentosocial VALUES (4325, '2020-03-20', 'Brasiléia', 40.22);
INSERT INTO pacto.isolamentosocial VALUES (4326, '2020-03-21', 'Brasiléia', 46.74);
INSERT INTO pacto.isolamentosocial VALUES (4327, '2020-03-22', 'Brasiléia', 51.46);
INSERT INTO pacto.isolamentosocial VALUES (4328, '2020-03-23', 'Brasiléia', 44.03);
INSERT INTO pacto.isolamentosocial VALUES (4329, '2020-03-24', 'Brasiléia', 44.49);
INSERT INTO pacto.isolamentosocial VALUES (4330, '2020-03-25', 'Brasiléia', 43.43);
INSERT INTO pacto.isolamentosocial VALUES (4331, '2020-03-26', 'Brasiléia', 44.58);
INSERT INTO pacto.isolamentosocial VALUES (4332, '2020-03-27', 'Brasiléia', 41.88);
INSERT INTO pacto.isolamentosocial VALUES (4333, '2020-03-28', 'Brasiléia', 49.59);
INSERT INTO pacto.isolamentosocial VALUES (4334, '2020-03-29', 'Brasiléia', 52.27);
INSERT INTO pacto.isolamentosocial VALUES (4335, '2020-03-30', 'Brasiléia', 38.02);
INSERT INTO pacto.isolamentosocial VALUES (4336, '2020-03-31', 'Brasiléia', 41.95);
INSERT INTO pacto.isolamentosocial VALUES (4337, '2020-04-01', 'Brasiléia', 40.00);
INSERT INTO pacto.isolamentosocial VALUES (4338, '2020-04-02', 'Brasiléia', 47.47);
INSERT INTO pacto.isolamentosocial VALUES (4339, '2020-04-03', 'Brasiléia', 43.38);
INSERT INTO pacto.isolamentosocial VALUES (4340, '2020-04-04', 'Brasiléia', 47.77);
INSERT INTO pacto.isolamentosocial VALUES (4341, '2020-04-05', 'Brasiléia', 47.44);
INSERT INTO pacto.isolamentosocial VALUES (4342, '2020-04-06', 'Brasiléia', 43.84);
INSERT INTO pacto.isolamentosocial VALUES (4343, '2020-04-07', 'Brasiléia', 39.19);
INSERT INTO pacto.isolamentosocial VALUES (4344, '2020-04-08', 'Brasiléia', 35.19);
INSERT INTO pacto.isolamentosocial VALUES (4345, '2020-04-09', 'Brasiléia', 36.33);
INSERT INTO pacto.isolamentosocial VALUES (4346, '2020-04-10', 'Brasiléia', 47.76);
INSERT INTO pacto.isolamentosocial VALUES (4347, '2020-04-11', 'Brasiléia', 42.86);
INSERT INTO pacto.isolamentosocial VALUES (4348, '2020-04-12', 'Brasiléia', 47.74);
INSERT INTO pacto.isolamentosocial VALUES (4349, '2020-04-13', 'Brasiléia', 36.55);
INSERT INTO pacto.isolamentosocial VALUES (4350, '2020-04-14', 'Brasiléia', 41.80);
INSERT INTO pacto.isolamentosocial VALUES (4351, '2020-04-15', 'Brasiléia', 45.88);
INSERT INTO pacto.isolamentosocial VALUES (4352, '2020-04-16', 'Brasiléia', 42.45);
INSERT INTO pacto.isolamentosocial VALUES (4408, '2020-06-11', 'Brasiléia', 41.92);
INSERT INTO pacto.isolamentosocial VALUES (4409, '2020-06-12', 'Brasiléia', 38.62);
INSERT INTO pacto.isolamentosocial VALUES (4410, '2020-06-13', 'Brasiléia', 42.18);
INSERT INTO pacto.isolamentosocial VALUES (4411, '2020-06-14', 'Brasiléia', 47.22);
INSERT INTO pacto.isolamentosocial VALUES (4412, '2020-06-15', 'Brasiléia', 40.74);
INSERT INTO pacto.isolamentosocial VALUES (4413, '2020-06-16', 'Brasiléia', 35.45);
INSERT INTO pacto.isolamentosocial VALUES (4414, '2020-06-17', 'Brasiléia', 36.21);
INSERT INTO pacto.isolamentosocial VALUES (4415, '2020-06-18', 'Brasiléia', 40.13);
INSERT INTO pacto.isolamentosocial VALUES (4416, '2020-06-19', 'Brasiléia', 38.14);
INSERT INTO pacto.isolamentosocial VALUES (4417, '2020-06-20', 'Brasiléia', 41.37);
INSERT INTO pacto.isolamentosocial VALUES (4418, '2020-06-21', 'Brasiléia', 49.46);
INSERT INTO pacto.isolamentosocial VALUES (4419, '2020-06-22', 'Brasiléia', 36.96);
INSERT INTO pacto.isolamentosocial VALUES (4420, '2020-06-23', 'Brasiléia', 37.81);
INSERT INTO pacto.isolamentosocial VALUES (4421, '2020-06-24', 'Brasiléia', 39.26);
INSERT INTO pacto.isolamentosocial VALUES (4422, '2020-06-25', 'Brasiléia', 34.71);
INSERT INTO pacto.isolamentosocial VALUES (4423, '2020-06-26', 'Brasiléia', 36.72);
INSERT INTO pacto.isolamentosocial VALUES (4424, '2020-06-27', 'Brasiléia', 41.78);
INSERT INTO pacto.isolamentosocial VALUES (4425, '2020-06-28', 'Brasiléia', 50.88);
INSERT INTO pacto.isolamentosocial VALUES (4426, '2020-06-29', 'Brasiléia', 40.33);
INSERT INTO pacto.isolamentosocial VALUES (4427, '2020-06-30', 'Brasiléia', 37.99);
INSERT INTO pacto.isolamentosocial VALUES (4428, '2020-07-01', 'Brasiléia', 40.79);
INSERT INTO pacto.isolamentosocial VALUES (4429, '2020-07-02', 'Brasiléia', 36.41);
INSERT INTO pacto.isolamentosocial VALUES (4521, '2020-05-01', 'Bujari', 49.69);
INSERT INTO pacto.isolamentosocial VALUES (4522, '2020-05-02', 'Bujari', 47.09);
INSERT INTO pacto.isolamentosocial VALUES (4523, '2020-05-03', 'Bujari', 45.40);
INSERT INTO pacto.isolamentosocial VALUES (4524, '2020-05-04', 'Bujari', 44.24);
INSERT INTO pacto.isolamentosocial VALUES (4525, '2020-05-05', 'Bujari', 43.58);
INSERT INTO pacto.isolamentosocial VALUES (5388, '2020-03-04', 'Manoel Urbano', 34.38);
INSERT INTO pacto.isolamentosocial VALUES (6613, '2020-03-03', 'Xapuri', 25.76);
INSERT INTO pacto.isolamentosocial VALUES (4526, '2020-05-06', 'Bujari', 42.51);
INSERT INTO pacto.isolamentosocial VALUES (4527, '2020-05-07', 'Bujari', 46.39);
INSERT INTO pacto.isolamentosocial VALUES (4528, '2020-05-08', 'Bujari', 45.56);
INSERT INTO pacto.isolamentosocial VALUES (4529, '2020-05-09', 'Bujari', 45.20);
INSERT INTO pacto.isolamentosocial VALUES (4530, '2020-05-10', 'Bujari', 39.76);
INSERT INTO pacto.isolamentosocial VALUES (4531, '2020-05-11', 'Bujari', 41.04);
INSERT INTO pacto.isolamentosocial VALUES (4532, '2020-05-12', 'Bujari', 46.99);
INSERT INTO pacto.isolamentosocial VALUES (4533, '2020-05-13', 'Bujari', 45.98);
INSERT INTO pacto.isolamentosocial VALUES (4534, '2020-05-14', 'Bujari', 53.49);
INSERT INTO pacto.isolamentosocial VALUES (4535, '2020-05-15', 'Bujari', 45.76);
INSERT INTO pacto.isolamentosocial VALUES (4536, '2020-05-16', 'Bujari', 48.88);
INSERT INTO pacto.isolamentosocial VALUES (4537, '2020-05-17', 'Bujari', 54.86);
INSERT INTO pacto.isolamentosocial VALUES (4538, '2020-05-18', 'Bujari', 48.78);
INSERT INTO pacto.isolamentosocial VALUES (4539, '2020-05-19', 'Bujari', 54.69);
INSERT INTO pacto.isolamentosocial VALUES (4540, '2020-05-20', 'Bujari', 43.92);
INSERT INTO pacto.isolamentosocial VALUES (4541, '2020-05-21', 'Bujari', 49.48);
INSERT INTO pacto.isolamentosocial VALUES (4542, '2020-05-22', 'Bujari', 52.02);
INSERT INTO pacto.isolamentosocial VALUES (4543, '2020-05-23', 'Bujari', 48.28);
INSERT INTO pacto.isolamentosocial VALUES (4544, '2020-05-24', 'Bujari', 54.22);
INSERT INTO pacto.isolamentosocial VALUES (4430, '2020-07-03', 'Brasiléia', 40.81);
INSERT INTO pacto.isolamentosocial VALUES (4431, '2020-02-01', 'Bujari', 42.86);
INSERT INTO pacto.isolamentosocial VALUES (4432, '2020-02-02', 'Bujari', 40.31);
INSERT INTO pacto.isolamentosocial VALUES (4433, '2020-02-03', 'Bujari', 29.91);
INSERT INTO pacto.isolamentosocial VALUES (4434, '2020-02-04', 'Bujari', 24.79);
INSERT INTO pacto.isolamentosocial VALUES (4435, '2020-02-05', 'Bujari', 23.81);
INSERT INTO pacto.isolamentosocial VALUES (4436, '2020-02-06', 'Bujari', 34.85);
INSERT INTO pacto.isolamentosocial VALUES (4437, '2020-02-07', 'Bujari', 25.22);
INSERT INTO pacto.isolamentosocial VALUES (4438, '2020-02-08', 'Bujari', 28.45);
INSERT INTO pacto.isolamentosocial VALUES (4440, '2020-02-10', 'Bujari', 25.00);
INSERT INTO pacto.isolamentosocial VALUES (4441, '2020-02-11', 'Bujari', 24.81);
INSERT INTO pacto.isolamentosocial VALUES (4442, '2020-02-12', 'Bujari', 31.16);
INSERT INTO pacto.isolamentosocial VALUES (4443, '2020-02-13', 'Bujari', 30.53);
INSERT INTO pacto.isolamentosocial VALUES (4444, '2020-02-14', 'Bujari', 29.85);
INSERT INTO pacto.isolamentosocial VALUES (4445, '2020-02-15', 'Bujari', 42.86);
INSERT INTO pacto.isolamentosocial VALUES (4446, '2020-02-16', 'Bujari', 39.10);
INSERT INTO pacto.isolamentosocial VALUES (4447, '2020-02-17', 'Bujari', 24.14);
INSERT INTO pacto.isolamentosocial VALUES (4448, '2020-02-18', 'Bujari', 21.26);
INSERT INTO pacto.isolamentosocial VALUES (4449, '2020-02-19', 'Bujari', 26.47);
INSERT INTO pacto.isolamentosocial VALUES (4450, '2020-02-20', 'Bujari', 34.29);
INSERT INTO pacto.isolamentosocial VALUES (4451, '2020-02-21', 'Bujari', 20.80);
INSERT INTO pacto.isolamentosocial VALUES (4452, '2020-02-22', 'Bujari', 32.82);
INSERT INTO pacto.isolamentosocial VALUES (4453, '2020-02-23', 'Bujari', 41.67);
INSERT INTO pacto.isolamentosocial VALUES (4224, '2020-05-12', 'Assis Brasil', 52.38);
INSERT INTO pacto.isolamentosocial VALUES (4225, '2020-05-13', 'Assis Brasil', 42.86);
INSERT INTO pacto.isolamentosocial VALUES (4226, '2020-05-14', 'Assis Brasil', 45.45);
INSERT INTO pacto.isolamentosocial VALUES (4227, '2020-05-15', 'Assis Brasil', 35.59);
INSERT INTO pacto.isolamentosocial VALUES (4022, '2020-03-25', 'Acrelândia', 57.14);
INSERT INTO pacto.isolamentosocial VALUES (4023, '2020-03-26', 'Acrelândia', 51.18);
INSERT INTO pacto.isolamentosocial VALUES (4024, '2020-03-27', 'Acrelândia', 41.62);
INSERT INTO pacto.isolamentosocial VALUES (4025, '2020-03-28', 'Acrelândia', 47.59);
INSERT INTO pacto.isolamentosocial VALUES (4026, '2020-03-29', 'Acrelândia', 56.89);
INSERT INTO pacto.isolamentosocial VALUES (4027, '2020-03-30', 'Acrelândia', 44.81);
INSERT INTO pacto.isolamentosocial VALUES (4028, '2020-03-31', 'Acrelândia', 49.15);
INSERT INTO pacto.isolamentosocial VALUES (4029, '2020-04-01', 'Acrelândia', 50.83);
INSERT INTO pacto.isolamentosocial VALUES (4030, '2020-04-02', 'Acrelândia', 50.00);
INSERT INTO pacto.isolamentosocial VALUES (4031, '2020-04-03', 'Acrelândia', 51.16);
INSERT INTO pacto.isolamentosocial VALUES (4032, '2020-04-04', 'Acrelândia', 50.58);
INSERT INTO pacto.isolamentosocial VALUES (4033, '2020-04-05', 'Acrelândia', 54.78);
INSERT INTO pacto.isolamentosocial VALUES (4034, '2020-04-06', 'Acrelândia', 42.11);
INSERT INTO pacto.isolamentosocial VALUES (4035, '2020-04-07', 'Acrelândia', 44.62);
INSERT INTO pacto.isolamentosocial VALUES (4036, '2020-04-08', 'Acrelândia', 44.25);
INSERT INTO pacto.isolamentosocial VALUES (4037, '2020-04-09', 'Acrelândia', 43.93);
INSERT INTO pacto.isolamentosocial VALUES (4038, '2020-04-10', 'Acrelândia', 53.41);
INSERT INTO pacto.isolamentosocial VALUES (4039, '2020-04-11', 'Acrelândia', 51.89);
INSERT INTO pacto.isolamentosocial VALUES (4040, '2020-04-12', 'Acrelândia', 48.54);
INSERT INTO pacto.isolamentosocial VALUES (4041, '2020-04-13', 'Acrelândia', 42.33);
INSERT INTO pacto.isolamentosocial VALUES (4042, '2020-04-14', 'Acrelândia', 38.29);
INSERT INTO pacto.isolamentosocial VALUES (4545, '2020-05-25', 'Bujari', 49.75);
INSERT INTO pacto.isolamentosocial VALUES (4546, '2020-05-26', 'Bujari', 48.73);
INSERT INTO pacto.isolamentosocial VALUES (4547, '2020-05-27', 'Bujari', 51.11);
INSERT INTO pacto.isolamentosocial VALUES (4548, '2020-05-28', 'Bujari', 50.00);
INSERT INTO pacto.isolamentosocial VALUES (4549, '2020-05-29', 'Bujari', 49.72);
INSERT INTO pacto.isolamentosocial VALUES (4550, '2020-05-30', 'Bujari', 44.77);
INSERT INTO pacto.isolamentosocial VALUES (4551, '2020-05-31', 'Bujari', 46.15);
INSERT INTO pacto.isolamentosocial VALUES (4552, '2020-06-01', 'Bujari', 43.85);
INSERT INTO pacto.isolamentosocial VALUES (4553, '2020-06-02', 'Bujari', 48.65);
INSERT INTO pacto.isolamentosocial VALUES (4554, '2020-06-03', 'Bujari', 44.57);
INSERT INTO pacto.isolamentosocial VALUES (4555, '2020-06-04', 'Bujari', 45.60);
INSERT INTO pacto.isolamentosocial VALUES (4556, '2020-06-05', 'Bujari', 41.61);
INSERT INTO pacto.isolamentosocial VALUES (4557, '2020-06-06', 'Bujari', 47.33);
INSERT INTO pacto.isolamentosocial VALUES (4558, '2020-06-07', 'Bujari', 50.00);
INSERT INTO pacto.isolamentosocial VALUES (4559, '2020-06-08', 'Bujari', 40.44);
INSERT INTO pacto.isolamentosocial VALUES (4560, '2020-06-09', 'Bujari', 48.39);
INSERT INTO pacto.isolamentosocial VALUES (4561, '2020-06-10', 'Bujari', 50.29);
INSERT INTO pacto.isolamentosocial VALUES (4562, '2020-06-11', 'Bujari', 45.56);
INSERT INTO pacto.isolamentosocial VALUES (4563, '2020-06-12', 'Bujari', 45.45);
INSERT INTO pacto.isolamentosocial VALUES (4564, '2020-06-13', 'Bujari', 42.42);
INSERT INTO pacto.isolamentosocial VALUES (4565, '2020-06-14', 'Bujari', 52.60);
INSERT INTO pacto.isolamentosocial VALUES (4566, '2020-06-15', 'Bujari', 44.32);
INSERT INTO pacto.isolamentosocial VALUES (4567, '2020-06-16', 'Bujari', 36.41);
INSERT INTO pacto.isolamentosocial VALUES (4568, '2020-06-17', 'Bujari', 40.34);
INSERT INTO pacto.isolamentosocial VALUES (4569, '2020-06-18', 'Bujari', 43.33);
INSERT INTO pacto.isolamentosocial VALUES (4570, '2020-06-19', 'Bujari', 31.32);
INSERT INTO pacto.isolamentosocial VALUES (4571, '2020-06-20', 'Bujari', 48.33);
INSERT INTO pacto.isolamentosocial VALUES (4572, '2020-06-21', 'Bujari', 56.47);
INSERT INTO pacto.isolamentosocial VALUES (4573, '2020-06-22', 'Bujari', 47.28);
INSERT INTO pacto.isolamentosocial VALUES (4574, '2020-06-23', 'Bujari', 40.96);
INSERT INTO pacto.isolamentosocial VALUES (4575, '2020-06-24', 'Bujari', 46.01);
INSERT INTO pacto.isolamentosocial VALUES (4576, '2020-06-25', 'Bujari', 43.96);
INSERT INTO pacto.isolamentosocial VALUES (4577, '2020-06-26', 'Bujari', 38.37);
INSERT INTO pacto.isolamentosocial VALUES (4578, '2020-06-27', 'Bujari', 45.45);
INSERT INTO pacto.isolamentosocial VALUES (4579, '2020-06-28', 'Bujari', 42.86);
INSERT INTO pacto.isolamentosocial VALUES (4580, '2020-06-29', 'Bujari', 43.17);
INSERT INTO pacto.isolamentosocial VALUES (4581, '2020-06-30', 'Bujari', 48.11);
INSERT INTO pacto.isolamentosocial VALUES (4582, '2020-07-01', 'Bujari', 43.63);
INSERT INTO pacto.isolamentosocial VALUES (4583, '2020-07-02', 'Bujari', 39.06);
INSERT INTO pacto.isolamentosocial VALUES (4584, '2020-07-03', 'Bujari', 48.94);
INSERT INTO pacto.isolamentosocial VALUES (4585, '2020-02-01', 'Capixaba', 24.62);
INSERT INTO pacto.isolamentosocial VALUES (4586, '2020-02-02', 'Capixaba', 39.39);
INSERT INTO pacto.isolamentosocial VALUES (4587, '2020-02-03', 'Capixaba', 23.81);
INSERT INTO pacto.isolamentosocial VALUES (4588, '2020-02-04', 'Capixaba', 39.73);
INSERT INTO pacto.isolamentosocial VALUES (4589, '2020-02-05', 'Capixaba', 37.10);
INSERT INTO pacto.isolamentosocial VALUES (4590, '2020-02-06', 'Capixaba', 25.64);
INSERT INTO pacto.isolamentosocial VALUES (4591, '2020-02-07', 'Capixaba', 27.94);
INSERT INTO pacto.isolamentosocial VALUES (4592, '2020-02-08', 'Capixaba', 20.31);
INSERT INTO pacto.isolamentosocial VALUES (4593, '2020-02-09', 'Capixaba', 20.59);
INSERT INTO pacto.isolamentosocial VALUES (5067, '2020-02-21', 'Feijó', 29.38);
INSERT INTO pacto.isolamentosocial VALUES (5492, '2020-06-16', 'Manoel Urbano', 27.91);
INSERT INTO pacto.isolamentosocial VALUES (5614, '2020-05-14', 'Plácido de Castro', 52.82);
INSERT INTO pacto.isolamentosocial VALUES (5881, '2020-04-03', 'Rio Branco', 48.68);
INSERT INTO pacto.isolamentosocial VALUES (4298, '2020-02-22', 'Brasiléia', 34.85);
INSERT INTO pacto.isolamentosocial VALUES (4299, '2020-02-23', 'Brasiléia', 40.41);
INSERT INTO pacto.isolamentosocial VALUES (6829, '2020-07-09', 'Bujari', 43.92);
INSERT INTO pacto.isolamentosocial VALUES (6830, '2020-07-09', 'Capixaba', 40.00);
INSERT INTO pacto.isolamentosocial VALUES (6831, '2020-07-09', 'Cruzeiro do Sul', 44.63);
INSERT INTO pacto.isolamentosocial VALUES (6832, '2020-07-09', 'Epitaciolândia', 53.05);
INSERT INTO pacto.isolamentosocial VALUES (6833, '2020-07-09', 'Feijó', 44.44);
INSERT INTO pacto.isolamentosocial VALUES (6834, '2020-07-09', 'Mâncio Lima', 37.70);
INSERT INTO pacto.isolamentosocial VALUES (6835, '2020-07-09', 'Manoel Urbano', 38.60);
INSERT INTO pacto.isolamentosocial VALUES (6836, '2020-07-09', 'Marechal Thaumaturgo', 38.10);
INSERT INTO pacto.isolamentosocial VALUES (6837, '2020-07-09', 'Plácido de Castro', 48.07);
INSERT INTO pacto.isolamentosocial VALUES (6838, '2020-07-09', 'Porto Acre', 37.72);
INSERT INTO pacto.isolamentosocial VALUES (6839, '2020-07-09', 'Rio Branco', 42.23);
INSERT INTO pacto.isolamentosocial VALUES (6840, '2020-07-09', 'Rodrigues Alves', 50.00);
INSERT INTO pacto.isolamentosocial VALUES (6841, '2020-07-09', 'Sena Madureira', 40.77);
INSERT INTO pacto.isolamentosocial VALUES (6842, '2020-07-09', 'Senador Guiomard', 42.64);
INSERT INTO pacto.isolamentosocial VALUES (6843, '2020-07-09', 'Tarauacá', 40.13);
INSERT INTO pacto.isolamentosocial VALUES (6844, '2020-07-09', 'Xapuri', 46.71);
INSERT INTO pacto.isolamentosocial VALUES (6845, '2020-07-10', 'Acrelândia', 40.09);
INSERT INTO pacto.isolamentosocial VALUES (6846, '2020-07-10', 'Assis Brasil', 49.12);
INSERT INTO pacto.isolamentosocial VALUES (6847, '2020-07-10', 'Brasiléia', 45.17);
INSERT INTO pacto.isolamentosocial VALUES (6848, '2020-07-10', 'Bujari', 41.03);
INSERT INTO pacto.isolamentosocial VALUES (6849, '2020-07-10', 'Capixaba', 42.50);
INSERT INTO pacto.isolamentosocial VALUES (6850, '2020-07-10', 'Cruzeiro do Sul', 44.95);
INSERT INTO pacto.isolamentosocial VALUES (6851, '2020-07-10', 'Epitaciolândia', 46.04);
INSERT INTO pacto.isolamentosocial VALUES (6852, '2020-07-10', 'Feijó', 44.38);
INSERT INTO pacto.isolamentosocial VALUES (6853, '2020-07-10', 'Mâncio Lima', 53.23);
INSERT INTO pacto.isolamentosocial VALUES (6854, '2020-07-10', 'Manoel Urbano', 38.71);
INSERT INTO pacto.isolamentosocial VALUES (6855, '2020-07-10', 'Plácido de Castro', 46.95);
INSERT INTO pacto.isolamentosocial VALUES (6856, '2020-07-10', 'Porto Acre', 41.13);
INSERT INTO pacto.isolamentosocial VALUES (6857, '2020-07-10', 'Rio Branco', 42.83);
INSERT INTO pacto.isolamentosocial VALUES (6858, '2020-07-10', 'Rodrigues Alves', 52.38);
INSERT INTO pacto.isolamentosocial VALUES (6859, '2020-07-10', 'Sena Madureira', 39.18);
INSERT INTO pacto.isolamentosocial VALUES (6860, '2020-07-10', 'Senador Guiomard', 47.07);
INSERT INTO pacto.isolamentosocial VALUES (6861, '2020-07-10', 'Tarauacá', 36.24);
INSERT INTO pacto.isolamentosocial VALUES (6862, '2020-07-10', 'Xapuri', 40.40);
INSERT INTO pacto.isolamentosocial VALUES (6863, '2020-07-11', 'Acrelândia', 39.74);
INSERT INTO pacto.isolamentosocial VALUES (6864, '2020-07-11', 'Assis Brasil', 48.15);
INSERT INTO pacto.isolamentosocial VALUES (6865, '2020-07-11', 'Brasiléia', 41.30);
INSERT INTO pacto.isolamentosocial VALUES (6866, '2020-07-11', 'Bujari', 49.03);
INSERT INTO pacto.isolamentosocial VALUES (6867, '2020-07-11', 'Capixaba', 51.38);
INSERT INTO pacto.isolamentosocial VALUES (6868, '2020-07-11', 'Cruzeiro do Sul', 45.32);
INSERT INTO pacto.isolamentosocial VALUES (6869, '2020-07-11', 'Epitaciolândia', 43.44);
INSERT INTO pacto.isolamentosocial VALUES (6870, '2020-07-11', 'Feijó', 44.05);
INSERT INTO pacto.isolamentosocial VALUES (6871, '2020-07-11', 'Mâncio Lima', 45.45);
INSERT INTO pacto.isolamentosocial VALUES (6872, '2020-07-11', 'Manoel Urbano', 52.24);
INSERT INTO pacto.isolamentosocial VALUES (6873, '2020-07-11', 'Marechal Thaumaturgo', 38.10);
INSERT INTO pacto.isolamentosocial VALUES (6874, '2020-07-11', 'Plácido de Castro', 44.19);
INSERT INTO pacto.isolamentosocial VALUES (6875, '2020-07-11', 'Porto Acre', 45.36);
INSERT INTO pacto.isolamentosocial VALUES (6876, '2020-07-11', 'Rio Branco', 46.11);
INSERT INTO pacto.isolamentosocial VALUES (6877, '2020-07-11', 'Rodrigues Alves', 62.50);
INSERT INTO pacto.isolamentosocial VALUES (6878, '2020-07-11', 'Sena Madureira', 41.63);
INSERT INTO pacto.isolamentosocial VALUES (6879, '2020-07-11', 'Senador Guiomard', 50.00);
INSERT INTO pacto.isolamentosocial VALUES (6880, '2020-07-11', 'Tarauacá', 45.34);
INSERT INTO pacto.isolamentosocial VALUES (6881, '2020-07-11', 'Xapuri', 49.38);
INSERT INTO pacto.isolamentosocial VALUES (6882, '2020-07-12', 'Acrelândia', 42.54);
INSERT INTO pacto.isolamentosocial VALUES (6883, '2020-07-12', 'Assis Brasil', 52.08);
INSERT INTO pacto.isolamentosocial VALUES (6884, '2020-07-12', 'Brasiléia', 47.65);
INSERT INTO pacto.isolamentosocial VALUES (6885, '2020-07-12', 'Bujari', 54.50);
INSERT INTO pacto.isolamentosocial VALUES (6886, '2020-07-12', 'Capixaba', 54.46);
INSERT INTO pacto.isolamentosocial VALUES (6887, '2020-07-12', 'Cruzeiro do Sul', 48.01);
INSERT INTO pacto.isolamentosocial VALUES (6888, '2020-07-12', 'Epitaciolândia', 49.57);
INSERT INTO pacto.isolamentosocial VALUES (6889, '2020-07-12', 'Feijó', 49.71);
INSERT INTO pacto.isolamentosocial VALUES (6890, '2020-07-12', 'Mâncio Lima', 45.16);
INSERT INTO pacto.isolamentosocial VALUES (6891, '2020-07-12', 'Manoel Urbano', 50.00);
INSERT INTO pacto.isolamentosocial VALUES (6892, '2020-07-12', 'Plácido de Castro', 48.33);
INSERT INTO pacto.isolamentosocial VALUES (6893, '2020-07-12', 'Porto Acre', 50.00);
INSERT INTO pacto.isolamentosocial VALUES (6894, '2020-07-12', 'Rio Branco', 52.13);
INSERT INTO pacto.isolamentosocial VALUES (6897, '2020-07-12', 'Senador Guiomard', 50.85);
INSERT INTO pacto.isolamentosocial VALUES (6898, '2020-07-12', 'Tarauacá', 48.34);
INSERT INTO pacto.isolamentosocial VALUES (6899, '2020-07-12', 'Xapuri', 54.00);
INSERT INTO pacto.isolamentosocial VALUES (6900, '2020-07-13', 'Acrelândia', 33.33);
INSERT INTO pacto.isolamentosocial VALUES (6901, '2020-07-13', 'Assis Brasil', 38.30);
INSERT INTO pacto.isolamentosocial VALUES (6902, '2020-07-13', 'Brasiléia', 38.06);
INSERT INTO pacto.isolamentosocial VALUES (6903, '2020-07-13', 'Bujari', 39.90);
INSERT INTO pacto.isolamentosocial VALUES (6904, '2020-07-13', 'Capixaba', 48.51);
INSERT INTO pacto.isolamentosocial VALUES (6905, '2020-07-13', 'Cruzeiro do Sul', 43.35);
INSERT INTO pacto.isolamentosocial VALUES (6906, '2020-07-13', 'Epitaciolândia', 37.79);
INSERT INTO pacto.isolamentosocial VALUES (6907, '2020-07-13', 'Feijó', 39.27);
INSERT INTO pacto.isolamentosocial VALUES (6908, '2020-07-13', 'Mâncio Lima', 40.00);
INSERT INTO pacto.isolamentosocial VALUES (6909, '2020-07-13', 'Manoel Urbano', 47.14);
INSERT INTO pacto.isolamentosocial VALUES (6910, '2020-07-13', 'Marechal Thaumaturgo', 42.31);
INSERT INTO pacto.isolamentosocial VALUES (6911, '2020-07-13', 'Plácido de Castro', 48.66);
INSERT INTO pacto.isolamentosocial VALUES (6912, '2020-07-13', 'Porto Acre', 50.36);
INSERT INTO pacto.isolamentosocial VALUES (6913, '2020-07-13', 'Rio Branco', 43.26);
INSERT INTO pacto.isolamentosocial VALUES (6914, '2020-07-13', 'Rodrigues Alves', 53.85);
INSERT INTO pacto.isolamentosocial VALUES (6915, '2020-07-13', 'Sena Madureira', 40.92);
INSERT INTO pacto.isolamentosocial VALUES (6916, '2020-07-13', 'Senador Guiomard', 44.84);
INSERT INTO pacto.isolamentosocial VALUES (6917, '2020-07-13', 'Tarauacá', 36.94);
INSERT INTO pacto.isolamentosocial VALUES (6918, '2020-07-13', 'Xapuri', 41.07);
INSERT INTO pacto.isolamentosocial VALUES (6919, '2020-07-14', 'Acrelândia', 40.57);
INSERT INTO pacto.isolamentosocial VALUES (6920, '2020-07-14', 'Assis Brasil', 46.81);
INSERT INTO pacto.isolamentosocial VALUES (6921, '2020-07-14', 'Brasiléia', 40.88);
INSERT INTO pacto.isolamentosocial VALUES (6922, '2020-07-14', 'Bujari', 40.10);
INSERT INTO pacto.isolamentosocial VALUES (6923, '2020-07-14', 'Capixaba', 46.09);
INSERT INTO pacto.isolamentosocial VALUES (6924, '2020-07-14', 'Cruzeiro do Sul', 45.42);
INSERT INTO pacto.isolamentosocial VALUES (6925, '2020-07-14', 'Epitaciolândia', 42.12);
INSERT INTO pacto.isolamentosocial VALUES (6926, '2020-07-14', 'Feijó', 43.01);
INSERT INTO pacto.isolamentosocial VALUES (6927, '2020-07-14', 'Mâncio Lima', 54.69);
INSERT INTO pacto.isolamentosocial VALUES (6928, '2020-07-14', 'Manoel Urbano', 45.45);
INSERT INTO pacto.isolamentosocial VALUES (6929, '2020-07-14', 'Marechal Thaumaturgo', 39.13);
INSERT INTO pacto.isolamentosocial VALUES (6930, '2020-07-14', 'Plácido de Castro', 45.49);
INSERT INTO pacto.isolamentosocial VALUES (6931, '2020-07-14', 'Porto Acre', 45.58);
INSERT INTO pacto.isolamentosocial VALUES (6932, '2020-07-14', 'Rio Branco', 44.51);
INSERT INTO pacto.isolamentosocial VALUES (6933, '2020-07-14', 'Sena Madureira', 40.98);
INSERT INTO pacto.isolamentosocial VALUES (6934, '2020-07-14', 'Senador Guiomard', 45.16);
INSERT INTO pacto.isolamentosocial VALUES (6935, '2020-07-14', 'Tarauacá', 43.95);
INSERT INTO pacto.isolamentosocial VALUES (6936, '2020-07-14', 'Xapuri', 45.66);
INSERT INTO pacto.isolamentosocial VALUES (6937, '2020-07-15', 'Acrelândia', 39.74);
INSERT INTO pacto.isolamentosocial VALUES (6938, '2020-07-15', 'Assis Brasil', 45.28);
INSERT INTO pacto.isolamentosocial VALUES (6939, '2020-07-15', 'Brasiléia', 38.11);
INSERT INTO pacto.isolamentosocial VALUES (6940, '2020-07-15', 'Bujari', 46.04);
INSERT INTO pacto.isolamentosocial VALUES (6941, '2020-07-15', 'Capixaba', 45.05);
INSERT INTO pacto.isolamentosocial VALUES (6942, '2020-07-15', 'Cruzeiro do Sul', 42.81);
INSERT INTO pacto.isolamentosocial VALUES (6943, '2020-07-15', 'Epitaciolândia', 43.14);
INSERT INTO pacto.isolamentosocial VALUES (6944, '2020-07-15', 'Feijó', 47.42);
INSERT INTO pacto.isolamentosocial VALUES (6945, '2020-07-15', 'Mâncio Lima', 39.73);
INSERT INTO pacto.isolamentosocial VALUES (6946, '2020-07-15', 'Manoel Urbano', 50.62);
INSERT INTO pacto.isolamentosocial VALUES (6947, '2020-07-15', 'Marechal Thaumaturgo', 46.15);
INSERT INTO pacto.isolamentosocial VALUES (6948, '2020-07-15', 'Plácido de Castro', 37.31);
INSERT INTO pacto.isolamentosocial VALUES (6949, '2020-07-15', 'Porto Acre', 45.52);
INSERT INTO pacto.isolamentosocial VALUES (6950, '2020-07-15', 'Rio Branco', 43.22);
INSERT INTO pacto.isolamentosocial VALUES (6951, '2020-07-15', 'Rodrigues Alves', 40.63);
INSERT INTO pacto.isolamentosocial VALUES (6952, '2020-07-15', 'Sena Madureira', 42.17);
INSERT INTO pacto.isolamentosocial VALUES (6953, '2020-07-15', 'Senador Guiomard', 48.09);
INSERT INTO pacto.isolamentosocial VALUES (6954, '2020-07-15', 'Tarauacá', 45.93);
INSERT INTO pacto.isolamentosocial VALUES (6973, '2020-07-16', 'Tarauacá', 40.14);
INSERT INTO pacto.isolamentosocial VALUES (6974, '2020-07-16', 'Xapuri', 43.29);
INSERT INTO pacto.isolamentosocial VALUES (5636, '2020-06-05', 'Plácido de Castro', 42.34);
INSERT INTO pacto.isolamentosocial VALUES (5904, '2020-04-26', 'Rio Branco', 57.15);
INSERT INTO pacto.isolamentosocial VALUES (4090, '2020-06-01', 'Acrelândia', 40.18);
INSERT INTO pacto.isolamentosocial VALUES (4137, '2020-02-15', 'Assis Brasil', 47.73);
INSERT INTO pacto.isolamentosocial VALUES (4138, '2020-02-16', 'Assis Brasil', 59.57);
INSERT INTO pacto.isolamentosocial VALUES (4139, '2020-02-17', 'Assis Brasil', 27.27);
INSERT INTO pacto.isolamentosocial VALUES (4140, '2020-02-18', 'Assis Brasil', 35.42);
INSERT INTO pacto.isolamentosocial VALUES (4141, '2020-02-19', 'Assis Brasil', 34.78);
INSERT INTO pacto.isolamentosocial VALUES (4142, '2020-02-20', 'Assis Brasil', 44.44);
INSERT INTO pacto.isolamentosocial VALUES (4143, '2020-02-21', 'Assis Brasil', 36.36);
INSERT INTO pacto.isolamentosocial VALUES (4144, '2020-02-22', 'Assis Brasil', 48.00);
INSERT INTO pacto.isolamentosocial VALUES (4394, '2020-05-28', 'Brasiléia', 41.00);
INSERT INTO pacto.isolamentosocial VALUES (4145, '2020-02-23', 'Assis Brasil', 41.30);
INSERT INTO pacto.isolamentosocial VALUES (4146, '2020-02-24', 'Assis Brasil', 53.19);
INSERT INTO pacto.isolamentosocial VALUES (4147, '2020-02-25', 'Assis Brasil', 45.65);
INSERT INTO pacto.isolamentosocial VALUES (4148, '2020-02-26', 'Assis Brasil', 46.67);
INSERT INTO pacto.isolamentosocial VALUES (5606, '2020-05-06', 'Plácido de Castro', 44.69);
INSERT INTO pacto.isolamentosocial VALUES (4201, '2020-04-19', 'Assis Brasil', 51.06);
INSERT INTO pacto.isolamentosocial VALUES (4202, '2020-04-20', 'Assis Brasil', 44.19);
INSERT INTO pacto.isolamentosocial VALUES (4203, '2020-04-21', 'Assis Brasil', 59.57);
INSERT INTO pacto.isolamentosocial VALUES (4459, '2020-02-29', 'Bujari', 30.00);
INSERT INTO pacto.isolamentosocial VALUES (4460, '2020-03-01', 'Bujari', 44.67);
INSERT INTO pacto.isolamentosocial VALUES (4461, '2020-03-02', 'Bujari', 23.53);
INSERT INTO pacto.isolamentosocial VALUES (4462, '2020-03-03', 'Bujari', 25.00);
INSERT INTO pacto.isolamentosocial VALUES (4463, '2020-03-04', 'Bujari', 24.79);
INSERT INTO pacto.isolamentosocial VALUES (4464, '2020-03-05', 'Bujari', 29.86);
INSERT INTO pacto.isolamentosocial VALUES (4465, '2020-03-06', 'Bujari', 25.40);
INSERT INTO pacto.isolamentosocial VALUES (4466, '2020-03-07', 'Bujari', 29.01);
INSERT INTO pacto.isolamentosocial VALUES (4467, '2020-03-08', 'Bujari', 36.22);
INSERT INTO pacto.isolamentosocial VALUES (4468, '2020-03-09', 'Bujari', 34.48);
INSERT INTO pacto.isolamentosocial VALUES (4469, '2020-03-10', 'Bujari', 29.01);
INSERT INTO pacto.isolamentosocial VALUES (4470, '2020-03-11', 'Bujari', 30.99);
INSERT INTO pacto.isolamentosocial VALUES (4471, '2020-03-12', 'Bujari', 35.25);
INSERT INTO pacto.isolamentosocial VALUES (4472, '2020-03-13', 'Bujari', 30.43);
INSERT INTO pacto.isolamentosocial VALUES (4473, '2020-03-14', 'Bujari', 41.60);
INSERT INTO pacto.isolamentosocial VALUES (4474, '2020-03-15', 'Bujari', 42.95);
INSERT INTO pacto.isolamentosocial VALUES (4475, '2020-03-16', 'Bujari', 32.81);
INSERT INTO pacto.isolamentosocial VALUES (4204, '2020-04-22', 'Assis Brasil', 45.10);
INSERT INTO pacto.isolamentosocial VALUES (4205, '2020-04-23', 'Assis Brasil', 44.00);
INSERT INTO pacto.isolamentosocial VALUES (4206, '2020-04-24', 'Assis Brasil', 41.03);
INSERT INTO pacto.isolamentosocial VALUES (4207, '2020-04-25', 'Assis Brasil', 57.50);
INSERT INTO pacto.isolamentosocial VALUES (4208, '2020-04-26', 'Assis Brasil', 49.02);
INSERT INTO pacto.isolamentosocial VALUES (5505, '2020-06-29', 'Manoel Urbano', 40.00);
INSERT INTO pacto.isolamentosocial VALUES (4594, '2020-02-10', 'Capixaba', 22.39);
INSERT INTO pacto.isolamentosocial VALUES (4595, '2020-02-11', 'Capixaba', 17.19);
INSERT INTO pacto.isolamentosocial VALUES (4596, '2020-02-12', 'Capixaba', 23.81);
INSERT INTO pacto.isolamentosocial VALUES (4597, '2020-02-13', 'Capixaba', 28.38);
INSERT INTO pacto.isolamentosocial VALUES (4598, '2020-02-14', 'Capixaba', 26.87);
INSERT INTO pacto.isolamentosocial VALUES (4599, '2020-02-15', 'Capixaba', 30.51);
INSERT INTO pacto.isolamentosocial VALUES (4600, '2020-02-16', 'Capixaba', 47.46);
INSERT INTO pacto.isolamentosocial VALUES (4601, '2020-02-17', 'Capixaba', 33.87);
INSERT INTO pacto.isolamentosocial VALUES (4602, '2020-02-18', 'Capixaba', 26.09);
INSERT INTO pacto.isolamentosocial VALUES (4603, '2020-02-19', 'Capixaba', 29.87);
INSERT INTO pacto.isolamentosocial VALUES (4604, '2020-02-20', 'Capixaba', 21.13);
INSERT INTO pacto.isolamentosocial VALUES (4605, '2020-02-21', 'Capixaba', 26.25);
INSERT INTO pacto.isolamentosocial VALUES (4606, '2020-02-22', 'Capixaba', 36.36);
INSERT INTO pacto.isolamentosocial VALUES (4607, '2020-02-23', 'Capixaba', 41.38);
INSERT INTO pacto.isolamentosocial VALUES (4608, '2020-02-24', 'Capixaba', 38.81);
INSERT INTO pacto.isolamentosocial VALUES (4609, '2020-02-25', 'Capixaba', 35.71);
INSERT INTO pacto.isolamentosocial VALUES (4610, '2020-02-26', 'Capixaba', 36.21);
INSERT INTO pacto.isolamentosocial VALUES (4612, '2020-02-28', 'Capixaba', 27.40);
INSERT INTO pacto.isolamentosocial VALUES (4613, '2020-02-29', 'Capixaba', 30.77);
INSERT INTO pacto.isolamentosocial VALUES (4614, '2020-03-01', 'Capixaba', 28.33);
INSERT INTO pacto.isolamentosocial VALUES (4615, '2020-03-02', 'Capixaba', 28.99);
INSERT INTO pacto.isolamentosocial VALUES (4634, '2020-03-21', 'Capixaba', 56.94);
INSERT INTO pacto.isolamentosocial VALUES (4635, '2020-03-22', 'Capixaba', 55.38);
INSERT INTO pacto.isolamentosocial VALUES (4636, '2020-03-23', 'Capixaba', 52.46);
INSERT INTO pacto.isolamentosocial VALUES (4637, '2020-03-24', 'Capixaba', 62.50);
INSERT INTO pacto.isolamentosocial VALUES (4638, '2020-03-25', 'Capixaba', 58.46);
INSERT INTO pacto.isolamentosocial VALUES (4639, '2020-03-26', 'Capixaba', 50.00);
INSERT INTO pacto.isolamentosocial VALUES (4640, '2020-03-27', 'Capixaba', 46.97);
INSERT INTO pacto.isolamentosocial VALUES (4641, '2020-03-28', 'Capixaba', 48.53);
INSERT INTO pacto.isolamentosocial VALUES (4642, '2020-03-29', 'Capixaba', 50.00);
INSERT INTO pacto.isolamentosocial VALUES (4643, '2020-03-30', 'Capixaba', 47.30);
INSERT INTO pacto.isolamentosocial VALUES (4644, '2020-03-31', 'Capixaba', 44.12);
INSERT INTO pacto.isolamentosocial VALUES (4645, '2020-04-01', 'Capixaba', 38.89);
INSERT INTO pacto.isolamentosocial VALUES (4646, '2020-04-02', 'Capixaba', 44.78);
INSERT INTO pacto.isolamentosocial VALUES (4647, '2020-04-03', 'Capixaba', 39.06);
INSERT INTO pacto.isolamentosocial VALUES (4648, '2020-04-04', 'Capixaba', 49.25);
INSERT INTO pacto.isolamentosocial VALUES (4649, '2020-04-05', 'Capixaba', 37.10);
INSERT INTO pacto.isolamentosocial VALUES (4650, '2020-04-06', 'Capixaba', 39.19);
INSERT INTO pacto.isolamentosocial VALUES (4651, '2020-04-07', 'Capixaba', 44.62);
INSERT INTO pacto.isolamentosocial VALUES (4652, '2020-04-08', 'Capixaba', 41.10);
INSERT INTO pacto.isolamentosocial VALUES (4653, '2020-04-09', 'Capixaba', 35.71);
INSERT INTO pacto.isolamentosocial VALUES (4654, '2020-04-10', 'Capixaba', 53.42);
INSERT INTO pacto.isolamentosocial VALUES (4655, '2020-04-11', 'Capixaba', 44.44);
INSERT INTO pacto.isolamentosocial VALUES (4656, '2020-04-12', 'Capixaba', 61.19);
INSERT INTO pacto.isolamentosocial VALUES (4657, '2020-04-13', 'Capixaba', 35.62);
INSERT INTO pacto.isolamentosocial VALUES (4658, '2020-04-14', 'Capixaba', 34.85);
INSERT INTO pacto.isolamentosocial VALUES (4659, '2020-04-15', 'Capixaba', 49.37);
INSERT INTO pacto.isolamentosocial VALUES (4660, '2020-04-16', 'Capixaba', 40.79);
INSERT INTO pacto.isolamentosocial VALUES (4661, '2020-04-17', 'Capixaba', 42.11);
INSERT INTO pacto.isolamentosocial VALUES (4662, '2020-04-18', 'Capixaba', 51.28);
INSERT INTO pacto.isolamentosocial VALUES (4663, '2020-04-19', 'Capixaba', 48.00);
INSERT INTO pacto.isolamentosocial VALUES (4664, '2020-04-20', 'Capixaba', 37.97);
INSERT INTO pacto.isolamentosocial VALUES (4665, '2020-04-21', 'Capixaba', 48.44);
INSERT INTO pacto.isolamentosocial VALUES (4666, '2020-04-22', 'Capixaba', 45.95);
INSERT INTO pacto.isolamentosocial VALUES (4667, '2020-04-23', 'Capixaba', 41.43);
INSERT INTO pacto.isolamentosocial VALUES (4668, '2020-04-24', 'Capixaba', 28.36);
INSERT INTO pacto.isolamentosocial VALUES (4669, '2020-04-25', 'Capixaba', 41.25);
INSERT INTO pacto.isolamentosocial VALUES (4670, '2020-04-26', 'Capixaba', 46.05);
INSERT INTO pacto.isolamentosocial VALUES (4671, '2020-04-27', 'Capixaba', 33.33);
INSERT INTO pacto.isolamentosocial VALUES (4672, '2020-04-28', 'Capixaba', 38.82);
INSERT INTO pacto.isolamentosocial VALUES (4673, '2020-04-29', 'Capixaba', 48.24);
INSERT INTO pacto.isolamentosocial VALUES (4674, '2020-04-30', 'Capixaba', 32.88);
INSERT INTO pacto.isolamentosocial VALUES (4675, '2020-05-01', 'Capixaba', 46.03);
INSERT INTO pacto.isolamentosocial VALUES (4676, '2020-05-02', 'Capixaba', 41.38);
INSERT INTO pacto.isolamentosocial VALUES (4677, '2020-05-03', 'Capixaba', 42.50);
INSERT INTO pacto.isolamentosocial VALUES (4678, '2020-05-04', 'Capixaba', 38.89);
INSERT INTO pacto.isolamentosocial VALUES (4679, '2020-05-05', 'Capixaba', 40.24);
INSERT INTO pacto.isolamentosocial VALUES (4680, '2020-05-06', 'Capixaba', 42.86);
INSERT INTO pacto.isolamentosocial VALUES (4681, '2020-05-07', 'Capixaba', 36.62);
INSERT INTO pacto.isolamentosocial VALUES (4682, '2020-05-08', 'Capixaba', 46.43);
INSERT INTO pacto.isolamentosocial VALUES (4683, '2020-05-09', 'Capixaba', 41.30);
INSERT INTO pacto.isolamentosocial VALUES (4684, '2020-05-10', 'Capixaba', 48.86);
INSERT INTO pacto.isolamentosocial VALUES (4685, '2020-05-11', 'Capixaba', 41.30);
INSERT INTO pacto.isolamentosocial VALUES (4616, '2020-03-03', 'Capixaba', 30.99);
INSERT INTO pacto.isolamentosocial VALUES (4617, '2020-03-04', 'Capixaba', 30.56);
INSERT INTO pacto.isolamentosocial VALUES (4618, '2020-03-05', 'Capixaba', 32.39);
INSERT INTO pacto.isolamentosocial VALUES (4619, '2020-03-06', 'Capixaba', 32.86);
INSERT INTO pacto.isolamentosocial VALUES (4620, '2020-03-07', 'Capixaba', 24.19);
INSERT INTO pacto.isolamentosocial VALUES (4621, '2020-03-08', 'Capixaba', 44.23);
INSERT INTO pacto.isolamentosocial VALUES (4622, '2020-03-09', 'Capixaba', 41.67);
INSERT INTO pacto.isolamentosocial VALUES (4623, '2020-03-10', 'Capixaba', 25.00);
INSERT INTO pacto.isolamentosocial VALUES (5415, '2020-03-31', 'Manoel Urbano', 38.89);
INSERT INTO pacto.isolamentosocial VALUES (6806, '2020-07-07', 'Xapuri', 41.61);
INSERT INTO pacto.isolamentosocial VALUES (4043, '2020-04-15', 'Acrelândia', 48.22);
INSERT INTO pacto.isolamentosocial VALUES (4044, '2020-04-16', 'Acrelândia', 36.42);
INSERT INTO pacto.isolamentosocial VALUES (4045, '2020-04-17', 'Acrelândia', 37.23);
INSERT INTO pacto.isolamentosocial VALUES (4046, '2020-04-18', 'Acrelândia', 43.17);
INSERT INTO pacto.isolamentosocial VALUES (4047, '2020-04-19', 'Acrelândia', 53.22);
INSERT INTO pacto.isolamentosocial VALUES (4048, '2020-04-20', 'Acrelândia', 39.59);
INSERT INTO pacto.isolamentosocial VALUES (4049, '2020-04-21', 'Acrelândia', 39.23);
INSERT INTO pacto.isolamentosocial VALUES (4050, '2020-04-22', 'Acrelândia', 35.87);
INSERT INTO pacto.isolamentosocial VALUES (4051, '2020-04-23', 'Acrelândia', 36.67);
INSERT INTO pacto.isolamentosocial VALUES (4052, '2020-04-24', 'Acrelândia', 36.72);
INSERT INTO pacto.isolamentosocial VALUES (4053, '2020-04-25', 'Acrelândia', 42.56);
INSERT INTO pacto.isolamentosocial VALUES (5518, '2020-02-08', 'Plácido de Castro', 27.81);
INSERT INTO pacto.isolamentosocial VALUES (4100, '2020-06-11', 'Acrelândia', 38.84);
INSERT INTO pacto.isolamentosocial VALUES (4101, '2020-06-12', 'Acrelândia', 35.78);
INSERT INTO pacto.isolamentosocial VALUES (4102, '2020-06-13', 'Acrelândia', 43.96);
INSERT INTO pacto.isolamentosocial VALUES (4103, '2020-06-14', 'Acrelândia', 48.34);
INSERT INTO pacto.isolamentosocial VALUES (4104, '2020-06-15', 'Acrelândia', 43.89);
INSERT INTO pacto.isolamentosocial VALUES (6753, '2020-07-04', 'Xapuri', 42.41);
INSERT INTO pacto.isolamentosocial VALUES (4360, '2020-04-24', 'Brasiléia', 39.45);
INSERT INTO pacto.isolamentosocial VALUES (4361, '2020-04-25', 'Brasiléia', 43.40);
INSERT INTO pacto.isolamentosocial VALUES (4362, '2020-04-26', 'Brasiléia', 49.24);
INSERT INTO pacto.isolamentosocial VALUES (4363, '2020-04-27', 'Brasiléia', 45.17);
INSERT INTO pacto.isolamentosocial VALUES (4364, '2020-04-28', 'Brasiléia', 33.10);
INSERT INTO pacto.isolamentosocial VALUES (4365, '2020-04-29', 'Brasiléia', 34.00);
INSERT INTO pacto.isolamentosocial VALUES (4366, '2020-04-30', 'Brasiléia', 36.09);
INSERT INTO pacto.isolamentosocial VALUES (4367, '2020-05-01', 'Brasiléia', 45.86);
INSERT INTO pacto.isolamentosocial VALUES (4368, '2020-05-02', 'Brasiléia', 38.55);
INSERT INTO pacto.isolamentosocial VALUES (6985, '2020-07-17', 'Acrelandia', 29.53);
INSERT INTO pacto.isolamentosocial VALUES (6986, '2020-07-18', 'Acrelandia', 40.59);
INSERT INTO pacto.isolamentosocial VALUES (6987, '2020-07-17', 'Assis Brasil', 38.60);
INSERT INTO pacto.isolamentosocial VALUES (6988, '2020-07-18', 'Assis Brasil', 43.48);
INSERT INTO pacto.isolamentosocial VALUES (6989, '2020-07-17', 'Brasileia', 32.95);
INSERT INTO pacto.isolamentosocial VALUES (6990, '2020-07-18', 'Brasileia', 42.29);
INSERT INTO pacto.isolamentosocial VALUES (6991, '2020-07-17', 'Bujari', 44.94);
INSERT INTO pacto.isolamentosocial VALUES (6992, '2020-07-18', 'Bujari', 49.71);
INSERT INTO pacto.isolamentosocial VALUES (6993, '2020-07-17', 'Capixaba', 39.45);
INSERT INTO pacto.isolamentosocial VALUES (6994, '2020-07-18', 'Capixaba', 45.83);
INSERT INTO pacto.isolamentosocial VALUES (6995, '2020-07-17', 'Cruzeiro do Sul', 39.32);
INSERT INTO pacto.isolamentosocial VALUES (6996, '2020-07-18', 'Cruzeiro do Sul', 44.15);
INSERT INTO pacto.isolamentosocial VALUES (6997, '2020-07-17', 'Epitaciolandia', 36.03);
INSERT INTO pacto.isolamentosocial VALUES (6998, '2020-07-18', 'Epitaciolandia', 42.68);
INSERT INTO pacto.isolamentosocial VALUES (6999, '2020-07-17', 'Feijo', 45.83);
INSERT INTO pacto.isolamentosocial VALUES (7000, '2020-07-18', 'Feijo', 49.43);
INSERT INTO pacto.isolamentosocial VALUES (7001, '2020-07-17', 'Manoel Urbano', 41.77);
INSERT INTO pacto.isolamentosocial VALUES (7002, '2020-07-18', 'Manoel Urbano', 42.86);
INSERT INTO pacto.isolamentosocial VALUES (7003, '2020-07-17', 'Mancio Lima', 33.82);
INSERT INTO pacto.isolamentosocial VALUES (7004, '2020-07-18', 'Mancio Lima', 45.07);
INSERT INTO pacto.isolamentosocial VALUES (7005, '2020-07-17', 'Placido de Castro', 35.97);
INSERT INTO pacto.isolamentosocial VALUES (7006, '2020-07-18', 'Placido de Castro', 41.03);
INSERT INTO pacto.isolamentosocial VALUES (7007, '2020-07-17', 'Porto Acre', 42.97);
INSERT INTO pacto.isolamentosocial VALUES (7008, '2020-07-18', 'Porto Acre', 52.05);
INSERT INTO pacto.isolamentosocial VALUES (7009, '2020-07-17', 'Rio Branco', 38.89);
INSERT INTO pacto.isolamentosocial VALUES (7010, '2020-07-18', 'Rio Branco', 43.15);
INSERT INTO pacto.isolamentosocial VALUES (7011, '2020-07-17', 'Rodrigues Alves', 31.03);
INSERT INTO pacto.isolamentosocial VALUES (7012, '2020-07-18', 'Rodrigues Alves', 51.85);
INSERT INTO pacto.isolamentosocial VALUES (7013, '2020-07-17', 'Sena Madureira', 33.59);
INSERT INTO pacto.isolamentosocial VALUES (7014, '2020-07-18', 'Sena Madureira', 39.73);
INSERT INTO pacto.isolamentosocial VALUES (7015, '2020-07-17', 'Senador Guiomard', 42.91);
INSERT INTO pacto.isolamentosocial VALUES (7016, '2020-07-18', 'Senador Guiomard', 44.01);
INSERT INTO pacto.isolamentosocial VALUES (7017, '2020-07-17', 'Tarauaca', 35.97);
INSERT INTO pacto.isolamentosocial VALUES (7018, '2020-07-18', 'Tarauaca', 35.57);
INSERT INTO pacto.isolamentosocial VALUES (7019, '2020-07-17', 'Xapuri', 35.66);
INSERT INTO pacto.isolamentosocial VALUES (7020, '2020-07-18', 'Xapuri', 43.66);


--
-- TOC entry 3140 (class 0 OID 16455)
-- Dependencies: 213
-- Data for Name: matrizgut; Type: TABLE DATA; Schema: pacto; Owner: postgres
--

INSERT INTO pacto.matrizgut VALUES (1, 'MP', 'GLAUCIO', 'GLAUCIO@MP', '2020-06-22', NULL);
INSERT INTO pacto.matrizgut VALUES (2, 'SESACRE', 'MARCOS VM LIMA', 'MARCOS VM LIMA@SESACRE', '2020-06-22', NULL);
INSERT INTO pacto.matrizgut VALUES (3, 'VIGILANCIA EPIDEMIOLOGICA ESTADO', 'VIGILANCIA EPIDEMIOLOGICA ESTADO', 'VIGILANCIA EPIDEMIOLOGICA ESTADO@VIGILANCIA EPIDEMIOLOGICA ESTADO', '2020-06-22', NULL);
INSERT INTO pacto.matrizgut VALUES (4, 'SEPLAG', 'GERBSON MAIA', 'GERBSON MAIA@SEPLAG', '2020-06-22', NULL);
INSERT INTO pacto.matrizgut VALUES (11, 'VIGILANCIA EM SAÚDE - CAPITAL', 'VIGILANCIA EM SAÚDE - CAPITAL', 'VIGILANCIA EM SAÚDE - CAPITAL@VIGILANCIA EM SAÚDE - CAPITAL', '2020-06-22', NULL);
INSERT INTO pacto.matrizgut VALUES (15, 'MP', 'ALDO COLOMBO', 'ALDO COLOMBO@MP', '2020-06-22', NULL);
INSERT INTO pacto.matrizgut VALUES (16, 'SESACRE', 'KAROLINA', 'KAROLINA@SESACRE', '2020-06-22', NULL);


--
-- TOC entry 3142 (class 0 OID 16464)
-- Dependencies: 215
-- Data for Name: municipio; Type: TABLE DATA; Schema: pacto; Owner: postgres
--

INSERT INTO pacto.municipio VALUES (4, 'Bujari', 1, 0, 0);
INSERT INTO pacto.municipio VALUES (5, 'Capixaba', 1, 0, 0);
INSERT INTO pacto.municipio VALUES (14, 'Porto Acre', 1, 0, 0);
INSERT INTO pacto.municipio VALUES (20, 'Senador Guiomard', 1, 0, 0);
INSERT INTO pacto.municipio VALUES (22, 'Xapuri', 2, 0, 0);
INSERT INTO pacto.municipio VALUES (10, 'Mâncio Lima', 3, 0, 0);
INSERT INTO pacto.municipio VALUES (1, 'Acrelândia', 1, 0, 4);
INSERT INTO pacto.municipio VALUES (9, 'Jordão', 1, 0, 2);
INSERT INTO pacto.municipio VALUES (11, 'Manoel Urbano', 1, 0, 6);
INSERT INTO pacto.municipio VALUES (13, 'Plácido de Castro', 1, 0, 9);
INSERT INTO pacto.municipio VALUES (18, 'Santa Rosa do Purus', 1, 0, 5);
INSERT INTO pacto.municipio VALUES (19, 'Sena Madureira', 1, 0, 11);
INSERT INTO pacto.municipio VALUES (2, 'Assis Brasil', 2, 0, 2);
INSERT INTO pacto.municipio VALUES (3, 'Brasiléia', 2, 0, 20);
INSERT INTO pacto.municipio VALUES (6, 'Cruzeiro do Sul', 3, 10, 68);
INSERT INTO pacto.municipio VALUES (7, 'Epitaciolândia', 2, 0, 7);
INSERT INTO pacto.municipio VALUES (8, 'Feijó', 3, 0, 3);
INSERT INTO pacto.municipio VALUES (12, 'Marechal Thaumaturgo', 3, 0, 2);
INSERT INTO pacto.municipio VALUES (15, 'Porto Walter', 3, 0, 2);
INSERT INTO pacto.municipio VALUES (21, 'Tarauacá', 3, 0, 10);
INSERT INTO pacto.municipio VALUES (16, 'Rio Branco', 1, 37, 175);
INSERT INTO pacto.municipio VALUES (17, 'Rodrigues Alves', 3, 0, 2);


--
-- TOC entry 3146 (class 0 OID 16479)
-- Dependencies: 219
-- Data for Name: municipionomes; Type: TABLE DATA; Schema: pacto; Owner: postgres
--

INSERT INTO pacto.municipionomes VALUES (1, 4, 'Bujari');
INSERT INTO pacto.municipionomes VALUES (2, 5, 'Capixaba');
INSERT INTO pacto.municipionomes VALUES (3, 14, 'Porto Acre');
INSERT INTO pacto.municipionomes VALUES (4, 20, 'Senador Guiomard');
INSERT INTO pacto.municipionomes VALUES (5, 22, 'Xapuri');
INSERT INTO pacto.municipionomes VALUES (6, 10, 'Mâncio Lima');
INSERT INTO pacto.municipionomes VALUES (7, 10, 'Mancio Lima');
INSERT INTO pacto.municipionomes VALUES (8, 1, 'Acrelândia');
INSERT INTO pacto.municipionomes VALUES (9, 1, 'Acrelandia');
INSERT INTO pacto.municipionomes VALUES (10, 9, 'Jordão');
INSERT INTO pacto.municipionomes VALUES (11, 9, 'Jordao');
INSERT INTO pacto.municipionomes VALUES (12, 11, 'Manoel Urbano');
INSERT INTO pacto.municipionomes VALUES (13, 13, 'Plácido de Castro');
INSERT INTO pacto.municipionomes VALUES (14, 13, 'Placido de Castro');
INSERT INTO pacto.municipionomes VALUES (15, 18, 'Santa Rosa do Purus');
INSERT INTO pacto.municipionomes VALUES (16, 19, 'Sena Madureira');
INSERT INTO pacto.municipionomes VALUES (17, 2, 'Assis Brasil');
INSERT INTO pacto.municipionomes VALUES (18, 3, 'Brasiléia');
INSERT INTO pacto.municipionomes VALUES (19, 3, 'Brasileia');
INSERT INTO pacto.municipionomes VALUES (20, 6, 'Cruzeiro do Sul');
INSERT INTO pacto.municipionomes VALUES (21, 7, 'Epitaciolândia');
INSERT INTO pacto.municipionomes VALUES (22, 7, 'Epitaciolandia');
INSERT INTO pacto.municipionomes VALUES (23, 8, 'Feijó');
INSERT INTO pacto.municipionomes VALUES (24, 8, 'Feijo');
INSERT INTO pacto.municipionomes VALUES (25, 12, 'Marechal Thaumaturgo');
INSERT INTO pacto.municipionomes VALUES (26, 15, 'Porto Walter');
INSERT INTO pacto.municipionomes VALUES (27, 21, 'Tarauacá');
INSERT INTO pacto.municipionomes VALUES (28, 21, 'Tarauaca');
INSERT INTO pacto.municipionomes VALUES (29, 16, 'Rio Branco');
INSERT INTO pacto.municipionomes VALUES (30, 17, 'Rodrigues Alves');


--
-- TOC entry 3148 (class 0 OID 16484)
-- Dependencies: 221
-- Data for Name: regional; Type: TABLE DATA; Schema: pacto; Owner: postgres
--

INSERT INTO pacto.regional VALUES (1, 'Baixo Acre', 37, 212);
INSERT INTO pacto.regional VALUES (2, 'Alto Acre', 0, 29);
INSERT INTO pacto.regional VALUES (3, 'Juruá', 10, 87);


--
-- TOC entry 3169 (class 0 OID 0)
-- Dependencies: 202
-- Name: casos_iscasos_seq; Type: SEQUENCE SET; Schema: pacto; Owner: postgres
--

SELECT pg_catalog.setval('pacto.casos_iscasos_seq', 1, true);


--
-- TOC entry 3170 (class 0 OID 0)
-- Dependencies: 204
-- Name: equivalencia_idequivalencia_seq; Type: SEQUENCE SET; Schema: pacto; Owner: postgres
--

SELECT pg_catalog.setval('pacto.equivalencia_idequivalencia_seq', 53, true);


--
-- TOC entry 3171 (class 0 OID 0)
-- Dependencies: 206
-- Name: indice_idinide_seq; Type: SEQUENCE SET; Schema: pacto; Owner: postgres
--

SELECT pg_catalog.setval('pacto.indice_idinide_seq', 7, true);


--
-- TOC entry 3172 (class 0 OID 0)
-- Dependencies: 208
-- Name: indicematriz_idindicematriz_seq; Type: SEQUENCE SET; Schema: pacto; Owner: postgres
--

SELECT pg_catalog.setval('pacto.indicematriz_idindicematriz_seq', 260, true);


--
-- TOC entry 3173 (class 0 OID 0)
-- Dependencies: 210
-- Name: internacoes_idinternacoes_seq; Type: SEQUENCE SET; Schema: pacto; Owner: postgres
--

SELECT pg_catalog.setval('pacto.internacoes_idinternacoes_seq', 1, true);


--
-- TOC entry 3174 (class 0 OID 0)
-- Dependencies: 212
-- Name: isolamentosocial_idisolamentosocial_seq; Type: SEQUENCE SET; Schema: pacto; Owner: postgres
--

SELECT pg_catalog.setval('pacto.isolamentosocial_idisolamentosocial_seq', 7229, true);


--
-- TOC entry 3175 (class 0 OID 0)
-- Dependencies: 214
-- Name: matrizgut_idmatriz_seq; Type: SEQUENCE SET; Schema: pacto; Owner: postgres
--

SELECT pg_catalog.setval('pacto.matrizgut_idmatriz_seq', 17, true);


--
-- TOC entry 3176 (class 0 OID 0)
-- Dependencies: 216
-- Name: municipio_idmunicipio_seq; Type: SEQUENCE SET; Schema: pacto; Owner: postgres
--

SELECT pg_catalog.setval('pacto.municipio_idmunicipio_seq', 22, true);


--
-- TOC entry 3177 (class 0 OID 0)
-- Dependencies: 218
-- Name: municipioindices_idmunicipioindice_seq; Type: SEQUENCE SET; Schema: pacto; Owner: postgres
--

SELECT pg_catalog.setval('pacto.municipioindices_idmunicipioindice_seq', 1, true);


--
-- TOC entry 3178 (class 0 OID 0)
-- Dependencies: 220
-- Name: municipionomes_idmunicipionome_seq; Type: SEQUENCE SET; Schema: pacto; Owner: postgres
--

SELECT pg_catalog.setval('pacto.municipionomes_idmunicipionome_seq', 30, true);


--
-- TOC entry 3179 (class 0 OID 0)
-- Dependencies: 225
-- Name: regional_idregional_seq; Type: SEQUENCE SET; Schema: pacto; Owner: postgres
--

SELECT pg_catalog.setval('pacto.regional_idregional_seq', 3, true);


--
-- TOC entry 3180 (class 0 OID 0)
-- Dependencies: 226
-- Name: regionalindices_idregionalindice_seq; Type: SEQUENCE SET; Schema: pacto; Owner: postgres
--

SELECT pg_catalog.setval('pacto.regionalindices_idregionalindice_seq', 1, true);


--
-- TOC entry 2940 (class 2606 OID 16522)
-- Name: casos casos_pk; Type: CONSTRAINT; Schema: pacto; Owner: postgres
--

ALTER TABLE ONLY pacto.casos
    ADD CONSTRAINT casos_pk PRIMARY KEY (iscasos);


--
-- TOC entry 2942 (class 2606 OID 16524)
-- Name: casos casos_un; Type: CONSTRAINT; Schema: pacto; Owner: postgres
--

ALTER TABLE ONLY pacto.casos
    ADD CONSTRAINT casos_un UNIQUE (idmunicipio, datacasos);


--
-- TOC entry 2944 (class 2606 OID 16526)
-- Name: equivalencia equivalencia_pk; Type: CONSTRAINT; Schema: pacto; Owner: postgres
--

ALTER TABLE ONLY pacto.equivalencia
    ADD CONSTRAINT equivalencia_pk PRIMARY KEY (idequivalencia);


--
-- TOC entry 2946 (class 2606 OID 16528)
-- Name: equivalencia equivalencia_un; Type: CONSTRAINT; Schema: pacto; Owner: postgres
--

ALTER TABLE ONLY pacto.equivalencia
    ADD CONSTRAINT equivalencia_un UNIQUE (idindice, valorinicial);


--
-- TOC entry 2948 (class 2606 OID 16530)
-- Name: indice indice_pk; Type: CONSTRAINT; Schema: pacto; Owner: postgres
--

ALTER TABLE ONLY pacto.indice
    ADD CONSTRAINT indice_pk PRIMARY KEY (idinide);


--
-- TOC entry 2950 (class 2606 OID 16532)
-- Name: indice indice_un; Type: CONSTRAINT; Schema: pacto; Owner: postgres
--

ALTER TABLE ONLY pacto.indice
    ADD CONSTRAINT indice_un UNIQUE (nomeindice, iniciouso);


--
-- TOC entry 2952 (class 2606 OID 16534)
-- Name: indicematriz indicematriz_pk; Type: CONSTRAINT; Schema: pacto; Owner: postgres
--

ALTER TABLE ONLY pacto.indicematriz
    ADD CONSTRAINT indicematriz_pk PRIMARY KEY (idindicematriz);


--
-- TOC entry 2954 (class 2606 OID 16536)
-- Name: indicematriz indicematriz_un; Type: CONSTRAINT; Schema: pacto; Owner: postgres
--

ALTER TABLE ONLY pacto.indicematriz
    ADD CONSTRAINT indicematriz_un UNIQUE (idmatriz, idindice);


--
-- TOC entry 2956 (class 2606 OID 16538)
-- Name: isolamentosocial isolamentosocial_pk; Type: CONSTRAINT; Schema: pacto; Owner: postgres
--

ALTER TABLE ONLY pacto.isolamentosocial
    ADD CONSTRAINT isolamentosocial_pk PRIMARY KEY (idisolamentosocial);


--
-- TOC entry 2958 (class 2606 OID 16540)
-- Name: isolamentosocial isolamentosocial_un; Type: CONSTRAINT; Schema: pacto; Owner: postgres
--

ALTER TABLE ONLY pacto.isolamentosocial
    ADD CONSTRAINT isolamentosocial_un UNIQUE (dataisolamentosocial, nomemunicipio);


--
-- TOC entry 2960 (class 2606 OID 16542)
-- Name: matrizgut matrizgut_pk; Type: CONSTRAINT; Schema: pacto; Owner: postgres
--

ALTER TABLE ONLY pacto.matrizgut
    ADD CONSTRAINT matrizgut_pk PRIMARY KEY (idmatriz);


--
-- TOC entry 2962 (class 2606 OID 16544)
-- Name: matrizgut matrizgut_un; Type: CONSTRAINT; Schema: pacto; Owner: postgres
--

ALTER TABLE ONLY pacto.matrizgut
    ADD CONSTRAINT matrizgut_un UNIQUE (entidade, responsavelpreenchimento, inciouso);


--
-- TOC entry 2964 (class 2606 OID 16546)
-- Name: municipio municipio_pk; Type: CONSTRAINT; Schema: pacto; Owner: postgres
--

ALTER TABLE ONLY pacto.municipio
    ADD CONSTRAINT municipio_pk PRIMARY KEY (idmunicipio);


--
-- TOC entry 2966 (class 2606 OID 16548)
-- Name: municipio municipio_un; Type: CONSTRAINT; Schema: pacto; Owner: postgres
--

ALTER TABLE ONLY pacto.municipio
    ADD CONSTRAINT municipio_un UNIQUE (nomemunicipio);


--
-- TOC entry 2968 (class 2606 OID 16550)
-- Name: municipioindices municipioindices_pk; Type: CONSTRAINT; Schema: pacto; Owner: postgres
--

ALTER TABLE ONLY pacto.municipioindices
    ADD CONSTRAINT municipioindices_pk PRIMARY KEY (idmunicipioindice);


--
-- TOC entry 2970 (class 2606 OID 16552)
-- Name: municipioindices municipioindices_un; Type: CONSTRAINT; Schema: pacto; Owner: postgres
--

ALTER TABLE ONLY pacto.municipioindices
    ADD CONSTRAINT municipioindices_un UNIQUE (idmunicipio, datacalculo, idindice);


--
-- TOC entry 2972 (class 2606 OID 16554)
-- Name: municipionomes municipionomes_pk; Type: CONSTRAINT; Schema: pacto; Owner: postgres
--

ALTER TABLE ONLY pacto.municipionomes
    ADD CONSTRAINT municipionomes_pk PRIMARY KEY (idmunicipionome);


--
-- TOC entry 2974 (class 2606 OID 16556)
-- Name: municipionomes municipionomes_un; Type: CONSTRAINT; Schema: pacto; Owner: postgres
--

ALTER TABLE ONLY pacto.municipionomes
    ADD CONSTRAINT municipionomes_un UNIQUE (idmunicipio, nomemunicipio);


--
-- TOC entry 2976 (class 2606 OID 16558)
-- Name: regional regional_pk; Type: CONSTRAINT; Schema: pacto; Owner: postgres
--

ALTER TABLE ONLY pacto.regional
    ADD CONSTRAINT regional_pk PRIMARY KEY (idregional);


--
-- TOC entry 2978 (class 2606 OID 16560)
-- Name: regional regional_un; Type: CONSTRAINT; Schema: pacto; Owner: postgres
--

ALTER TABLE ONLY pacto.regional
    ADD CONSTRAINT regional_un UNIQUE (nomeregional);


--
-- TOC entry 2980 (class 2606 OID 16562)
-- Name: regionalindices regionalindices_pk; Type: CONSTRAINT; Schema: pacto; Owner: postgres
--

ALTER TABLE ONLY pacto.regionalindices
    ADD CONSTRAINT regionalindices_pk PRIMARY KEY (idregionalindice);


--
-- TOC entry 2982 (class 2606 OID 16564)
-- Name: regionalindices regionalindices_un; Type: CONSTRAINT; Schema: pacto; Owner: postgres
--

ALTER TABLE ONLY pacto.regionalindices
    ADD CONSTRAINT regionalindices_un UNIQUE (idregional, datacalculo, idindice);


--
-- TOC entry 2993 (class 2620 OID 16565)
-- Name: casos casos_insert; Type: TRIGGER; Schema: pacto; Owner: postgres
--

CREATE TRIGGER casos_insert BEFORE INSERT OR UPDATE ON pacto.casos FOR EACH ROW EXECUTE FUNCTION pacto.casos_insert();


--
-- TOC entry 2994 (class 2620 OID 16566)
-- Name: internacoes internacoes_insert; Type: TRIGGER; Schema: pacto; Owner: postgres
--

CREATE TRIGGER internacoes_insert BEFORE INSERT OR UPDATE ON pacto.internacoes FOR EACH ROW EXECUTE FUNCTION pacto.internacoes_insert();


--
-- TOC entry 2995 (class 2620 OID 16567)
-- Name: isolamentosocial isolamentosocial_insert; Type: TRIGGER; Schema: pacto; Owner: postgres
--

CREATE TRIGGER isolamentosocial_insert BEFORE INSERT OR UPDATE ON pacto.isolamentosocial FOR EACH ROW EXECUTE FUNCTION pacto.isolamento_insert();


--
-- TOC entry 2983 (class 2606 OID 16568)
-- Name: casos casos_fk; Type: FK CONSTRAINT; Schema: pacto; Owner: postgres
--

ALTER TABLE ONLY pacto.casos
    ADD CONSTRAINT casos_fk FOREIGN KEY (idmunicipio) REFERENCES pacto.municipio(idmunicipio);


--
-- TOC entry 2984 (class 2606 OID 16573)
-- Name: equivalencia equivalencia_fk; Type: FK CONSTRAINT; Schema: pacto; Owner: postgres
--

ALTER TABLE ONLY pacto.equivalencia
    ADD CONSTRAINT equivalencia_fk FOREIGN KEY (idindice) REFERENCES pacto.indice(idinide);


--
-- TOC entry 2985 (class 2606 OID 16578)
-- Name: indicematriz indicematriz_fk; Type: FK CONSTRAINT; Schema: pacto; Owner: postgres
--

ALTER TABLE ONLY pacto.indicematriz
    ADD CONSTRAINT indicematriz_fk FOREIGN KEY (idindice) REFERENCES pacto.indice(idinide);


--
-- TOC entry 2986 (class 2606 OID 16583)
-- Name: indicematriz indicematriz_fk_1; Type: FK CONSTRAINT; Schema: pacto; Owner: postgres
--

ALTER TABLE ONLY pacto.indicematriz
    ADD CONSTRAINT indicematriz_fk_1 FOREIGN KEY (idmatriz) REFERENCES pacto.matrizgut(idmatriz);


--
-- TOC entry 2987 (class 2606 OID 16588)
-- Name: municipio municipio_fk; Type: FK CONSTRAINT; Schema: pacto; Owner: postgres
--

ALTER TABLE ONLY pacto.municipio
    ADD CONSTRAINT municipio_fk FOREIGN KEY (idregional) REFERENCES pacto.regional(idregional);


--
-- TOC entry 2991 (class 2606 OID 16593)
-- Name: regionalindices municipioindices_fk; Type: FK CONSTRAINT; Schema: pacto; Owner: postgres
--

ALTER TABLE ONLY pacto.regionalindices
    ADD CONSTRAINT municipioindices_fk FOREIGN KEY (idindice) REFERENCES pacto.indice(idinide);


--
-- TOC entry 2988 (class 2606 OID 16598)
-- Name: municipioindices municipioindices_fk; Type: FK CONSTRAINT; Schema: pacto; Owner: postgres
--

ALTER TABLE ONLY pacto.municipioindices
    ADD CONSTRAINT municipioindices_fk FOREIGN KEY (idindice) REFERENCES pacto.indice(idinide);


--
-- TOC entry 2989 (class 2606 OID 16603)
-- Name: municipioindices municipioindices_fk_1; Type: FK CONSTRAINT; Schema: pacto; Owner: postgres
--

ALTER TABLE ONLY pacto.municipioindices
    ADD CONSTRAINT municipioindices_fk_1 FOREIGN KEY (idmunicipio) REFERENCES pacto.municipio(idmunicipio);


--
-- TOC entry 2990 (class 2606 OID 16608)
-- Name: municipionomes municipionomes_fk; Type: FK CONSTRAINT; Schema: pacto; Owner: postgres
--

ALTER TABLE ONLY pacto.municipionomes
    ADD CONSTRAINT municipionomes_fk FOREIGN KEY (idmunicipio) REFERENCES pacto.municipio(idmunicipio);


--
-- TOC entry 2992 (class 2606 OID 16613)
-- Name: regionalindices regionalindices_fk_1; Type: FK CONSTRAINT; Schema: pacto; Owner: postgres
--

ALTER TABLE ONLY pacto.regionalindices
    ADD CONSTRAINT regionalindices_fk_1 FOREIGN KEY (idregional) REFERENCES pacto.regional(idregional);


-- Completed on 2021-06-08 22:19:40 UTC

--
-- PostgreSQL database dump complete
--

