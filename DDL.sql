
use antiguedades_campus;

create table usuario(
	id int auto_increment primary key,
	nombre varchar(50) unique not null,
	rol enum('Comprador', 'Vendedor', 'Administrador') not null,
	contrasena varchar(100) not null	
)

create table categoria(
	id int auto_increment primary key,
	nombre varchar(50) unique not null
)

create table pago(
	id int auto_increment primary key,
	metodo_pago varchar(50) not null
)

create table entrega(
	id int auto_increment primary key,
	fecha date not null,
	direccion varchar(100)
)

create table pieza(
	id int auto_increment primary key,
	nombre varchar(50) unique not null,
	descripcion varchar(300) unique not null,
	precio decimal(10,2) not null,
	estatus enum('En venta', 'Vendido', 'Retirado') not null,
	estado_conservacion varchar(300) not null,
	categoria_id int not null,
	usuario_id int not null,
	foreign key (categoria_id) references categoria(id),
	foreign key (usuario_id) references usuario(id)
)

create table transaccion(
	id int auto_increment primary key,
	precio decimal(10,2) not null,
	fecha datetime not null,
	pieza_id int not null,
	usuario_id int not null,
	pago_id int not null,
	entrega_id int not null,
	foreign key (pago_id) references pago(id),
	foreign key (entrega_id) references entrega(id),
	foreign key (pieza_id) references pieza(id),
	foreign key (usuario_id) references usuario(id)
)

create table inventario(
	id int auto_increment primary key,
	cantidad int not null,
	pieza_id int not null,
	foreign key (pieza_id) references pieza(id)
)





