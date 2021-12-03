-- CREATE TABLE t_mizack
-- (
--    codigo int not null,
--    nome varchar(20) not null
-- );
--INSERT INTO t_mizack(
--    codigo, 
--    nome
--)
--VALUES(
--    1, 
--    'antonio'
--);
/*ALTER TABLE t_mizack ADD CONSTRAINT t_mizack_pk PRIMARY KEY ( codigo );*/

-- CREATE TABLE t_cliente
-- (
--    codigo int not null,
--    nome varchar(20) not null,
--    endereco varchar(20) not null
-- );
-- insert into t_cliente(
--    codigo,
--    nome,
--    endereco
-- )values(
--    (1,'jose','cubatao'),(2,'maria','bahia'),(3,'cleberson','são paulo')
-- );
-- create table t_nf(
--     codigo int not null,
--     num_cliente int not null,
--     valor numeric(6,2)
-- );
-- commit;



-- MACETES SQL

-- ASSIM QUE CRIAR TABELAS, COMMITAR PARA CONSEGUIR MANUSEA-LAS


-- SELECT:
-- select first X -> apresentar os primeiros resultados do select de acordo com o valor determinado em "X"
-- select distinct -> apresentar somente dados que não são replicados
-- select skip X -> apresentar resultado de seleção pulando as primeiras ocorrencias de acordo com o valor determinado em "X"
-- ORDER BY -> apresentar informações em ordem, seja numérica ou alfanumérica
-- select current_timestamp from RDB$DATABASE; -> retorna data e hora do banco
-- select campo1 || campo2 as nome_juncao from tabela -> concatenar informações da tabela;
-- select count(*) AS TOTAL from tabela; -> quantas ocorrencias tem na tabela
-- select max(campo1) as MAXIMO from tabela; -> maior número;
-- INNER JOIN -> tentará cruzar os dados das tabelas de modo que, havendo correspondência, o resultado do select seja apresentado;
-- OUTER JOIN:
--       left -> retorna todas as linhas do stream esquerdo 
--       right -> retorna todas as linhas do stream direito

-- OPERADORES, PREDICADOS E PRECEDÊNCIAS:
--    maior prioridade (maior ao menor):
         -- concatenação = ||;
         -- aritmético:
            -- ();
            -- *
            -- /
            -- +
            -- -
         -- comparação:
            -- =, <, >, >=, <=, != etc...
            -- in
            -- starting with 'value'
            -- like -> '%a' = palavras que terminam com A | 'a%' = palavras que começam com A | 'a_t%' = palavras que tem o primeiro e terceiro caractere igual a A e T, respec.

         -- lógico: AND, OR, NOT

-- Null é comparado com uma condição específica -> "IS NULL" ou "IS NOT NULL":
   -- SELECT CASE WHEN (1 IS NOT NULL) then 'verdade' else 'falso' end FROM rdb$database;

-- CHARSET -> tipos de caracteres que podem ser utilizados por uma determinada database, tabela ou campo.

-- GENERATORS E SEQUENCES:
   -- basicamente representam a mesma idéia, porém os generators representam uma nomenclatura específica do Firebird.
   -- CREATE TRIGGER TESTE_SEQ_AUTO FOR TESTE_SEQ
   -- ACTIVE BEFORE INSERT POSITION 0
   -- AS
   -- BEGIN
   -- if (new.ID is null) then
   -- NEW.ID = gen_id(vll,1);