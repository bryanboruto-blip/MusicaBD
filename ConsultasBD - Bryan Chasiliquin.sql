-- consultas de la base de datos Saludtotal
use saludtotal;

select * from clientes;
select count(*) from clientes;
select count(*) from medicinas;

-- caso: Consultar los datos de un cliente por su numero de cedula 
-- Ejempplo: 1000000041

select *
from clientes
where celdula = '1000000041'

select *
from clientes 
where cedula = '10000000041'

-- caso: Consultar todos los cilentes cuyos nombres enpiezen con la letra A
select 
    cedula,
    nombre
from clientes 
where nombre like 'A%';

-- caso: Consultar todos los medicamentos que enmpiezen con la letra F
select
    medicina
from medicina
where medicina

select
    cedula,
    nombre
FROM clientes
where nombre like 'Juan%';

where 


-- caso: Buscar los clientes cuyo email tengo dominio en gmail y sean JUR

SELECT
    cedula,
    nombre
FROM clientes
where clientes

