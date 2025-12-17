drop database saludtotal;
CREATE DATABASE SaludTotal;

USE SaludTotal;

create table medicinas 
(
id int primary key, -- declaramos el identificador foraneo 
nombre VARCHAR(100),
tipo CHAR(3), -- valores que puede tener (GEN - generico // COM - comercial)
precio DECIMAL(15,2), -- indicamos los digtos enteros y decimales
stock int, -- siempre tenemos cantidades enteras
fechadecaducidad date
);

insert into medicinas
values (1, 'paracetamol','GEN',1.5,12,'2026-01-01');

insert into medicinas
values (2, 'acetaminofen','GEN', 0.56, 23,'2027-01-01');
insert into medicinas
values (3, 'finalin','GEN', 2.75, 43,'2028-01-01');

SELECT * from medicinas;

use saludtotal;
create table cliente 
(
cedula CHAR (10) primary key, -- declaramos el identificador foraneo 
nombre VARCHAR(100),
fechadenacimiento datetime,
tipodecliente CHAR(3)
);

insert into cliente
values('1725631827','Nancy','1934-05-12','Nt');
insert into cliente
values('1629174917','Vanessa','1932-11-15','Nt');
insert into cliente
values('1527185312','Juan','1966-02-10','Nt');

create table descuentos
(
    id int primary key,
    nombreCliente Varchar(100),
    nombreMedicina Varchar(100),
    precio decimal(15,2),
    descuento decimal(30,2)
);


insert into descuentos
values(1,'Nancy','paracetamol',2.34, 20);
insert into descuentos
values(2,'Vanessa','acetaminofen',3.00, 20);
insert into descuentos 
values(3,'Juan','finalin', 4.20, 30);

use saludtotal;
create table medicinafrecuente
( 
 cliente_cedula CHAR (10),
 medicina_id int,
 condicion VARCHAR (100),
 frecuencia CHAR(3),
 descuento DECIMAL(5,2)  -- 123,45
);

select * from medicinafrecuente;
alter table medicinafrecuente
add constraint clientecedulafx
Foreign Key (cliente_cedula) 
REFERENCES cliente (cedula);

alter table medicinafrecuente
add constraint medicionaid_fk
Foreign Key (medicina_id) 
REFERENCES medicinas (id);

alter table medicinafrecuente
add primary key (cliente_cedula, medicina_id);
-- colocar correctamente los datos en entre cliente y medicamento

use saludtotal;
SELECT * from cliente;
SELECT * from medicinas;

select * from medicinafrecuente;

insert into medicinafrecuente
values('1725631827', 12, 'diabetes','SEM', 0.25);

-- fecha: 12-12-2025
-- 
use saludtotal;
-- creación de tabla datos de la empresa
create table empresa(
    RUC CHAR(13),
    razonsocial VARCHAR(100),
    direccion_empresa VARCHAR(100),
    telefono_empresa VARCHAR(14),
    correo_empresa VARCHAR (25)
);

use saludtotal;
insert into empresa values('1712839719382','Salud Total S.A','AV. 10 de Agosto S/N','0262818565','bchasiliquin@gmail.com');

-- añadimos campos a la tabla clientes
alter table cliente
add column email VARCHAR (20);

desc cliente;
SELECT * from cliente;

-- actualizamos los datos del cliente
update cliente
set email = 'juanito@gmial.com'
where id = '1527185312';

update cliente
set email = 'Vanessa@gmial.com'
where id = '1629174917';

update cliente
set email = 'Nancy@gmial.com'
where id = '1725631827';

-- Creación de la tabla de facturas y facturasdetalle
use saludtotal;
create table factura (
    facturanumero CHAR(10) PRIMARY KEY,
    fecha date,
    cedula CHAR(10),
    total DECIMAL(15,2)
);
insert into factura values(
    '0000000001','2025-12-12','1629174917', 5.25
);
insert into facturadetalle values(
    '000000001', 3, 12, 2.25
);
insert into facturadetalle values(
    '1725631827', 4, 10, 1.50
);
-- ingresamos validaciones
-- en mi caso en el cliente el campo cedula se llama id
alter table factura
add constraint facturacedulafx
Foreign Key (cedula) -- nombre de la columna que estoy aplicando 
REFERENCES cliente (cedula); -- a que tabla estamos apuntando

-- creamos la tabla detalle_factura

create table facturadetalle(
    facturanumero CHAR(10),
    medicamento_id int,
    cantidad int,
    precio DECIMAL(15,2)
);

-- la tabla factura detalle tendra 2 campos de validacion, primary key compuesta

use saludtotal;
alter table facturadetalle
add PRIMARY key (facturanumero, medicamento_id);

insert into facturadetalle values ('0000000001',3,12,2.73);
-- se repite el número de factura pero agregamos

Erika Ortiz, [13/12/2025 22:05]
más medicamentos
insert into facturadetalle values ('0000000001',2,3,0.53);
insert into facturadetalle values ('0000000002',1,4,1.52);
insert into facturadetalle values ('0000000002',4,3,1.74);

SELECT * FROM factura;
SELECT * from facturadetalle;
SELECT * from medicinas;

-- validamos de que no se ingrese un número de factura que no existe
alter table facturadetalle
add constraint facturanumero_fk
Foreign Key (facturanumero) 
REFERENCES factura (facturanumero);


SELECT * from medicinas;

select * from facturadetalle;
-- validación para no ingresa números negativos
alter table facturadetalle
add constraint facturadetalle_cantidad_ck
check(cantidad > 0);

-- validación para precio
alter table facturadetalle
add constraint facturadetalle_precio_ck
check(precio > 0);


