create table taller.clientes(
	IdCliente char(5) primary key not null,
	Nombre varchar(120),
	Apellido1 varchar(120),
	Apellido2 varchar(120),
	DNI char(9) unique not null,
	Email varchar(50),
	Telefono char(9))

create table taller.vehiculos(
	IdVehiculo char(5) not null,
	Matricula varchar(8) unique not null,
	IdCliente char(5) not null,
	Marca varchar(100),
	Modelo varchar(100),
	PRIMARY KEY(IdVehiculo, IdCliente),
	foreign key(IdCliente) references  taller.clientes(IdCliente))

create table taller.usuarios(
	IdUsuario char(5) primary key not null,
	NombreUsuario varchar(50) unique not null,
	Contrasena varchar(50) not null,
	IdCliente char(5),
	constraint usuarioCliente foreign key(IdCliente) references  taller.clientes(IdCliente)
)

create table taller.proyectos(
	IdProyecto char(5) PRIMARY KEY not null,
	FechaCreacion smalldatetime,
	FechaFinal smalldatetime,
	EstadoProyecto char(1) not null,
	IdCliente char(5),
	IdVehiculo char(5),
	constraint proyectoVehiculo foreign key (IdVehiculo, IdCliente) references taller.vehiculos(IdVehiculo, IdCliente)
)

create table taller.detallesProyecto(
	IdDetalleProyecto char(5) not null,
	IdProyecto char(5) not null,
	NombreProducto varchar(120),
	CosteProducto smallmoney,
	CosteInstalacion smallmoney,
	PRIMARY KEY(IdDetalleProyecto, IdProyecto),
	constraint detallesProyectoProyecto foreign key (IdProyecto) references taller.proyectos(IdProyecto)
)