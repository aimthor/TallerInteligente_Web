USE [ TallerInteligente]
GO
/****** Object:  StoredProcedure [taller].[pr_recuProyectos]    Script Date: 06/06/2022 22:59:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   procedure [taller].[pr_recuProyectos]
	@p_IdProyecto CHAR(5),
	@p_NombreCliente varChar(120)
as
BEGIN
	IF (@p_IdProyecto = '')
	BEGIN
		SELECT IdProyecto, clientes.Nombre+' '+clientes.Apellido1 as NombreCliente, vehiculos.Matricula as Matricula, FechaCreacion,  FechaFinal, EstadoProyecto
		FROM taller.proyectos
		Inner Join taller.clientes on clientes.IdCliente = proyectos.IdCliente
		Join taller.vehiculos on proyectos.IdVehiculo = vehiculos.IdVehiculo and proyectos.IdCliente = vehiculos.IdCliente
		where clientes.Nombre like '%'+@p_NombreCliente+'%'
	END
	IF (@p_NombreCliente = '')
	BEGIN
		SELECT IdProyecto, clientes.Nombre+' '+clientes.Apellido1 as NombreCliente, vehiculos.Matricula as Matricula, FechaCreacion,  FechaFinal, EstadoProyecto
		FROM taller.proyectos
		Inner Join taller.clientes on clientes.IdCliente = proyectos.IdCliente
		Join taller.vehiculos on proyectos.IdVehiculo = vehiculos.IdVehiculo and proyectos.IdCliente = vehiculos.IdCliente
		where IdProyecto = @p_IdProyecto
	END
	ELSE
		SELECT IdProyecto, clientes.Nombre+' '+clientes.Apellido1 as NombreCliente,vehiculos.Matricula as Matricula, FechaCreacion,  FechaFinal, EstadoProyecto
		FROM taller.proyectos
		Inner Join taller.clientes on clientes.IdCliente = proyectos.IdCliente
		Join taller.vehiculos on proyectos.IdVehiculo = vehiculos.IdVehiculo and proyectos.IdCliente = vehiculos.IdCliente
		where IdProyecto = @p_IdProyecto and clientes.Nombre like '%'+@p_NombreCliente+'%'
	END