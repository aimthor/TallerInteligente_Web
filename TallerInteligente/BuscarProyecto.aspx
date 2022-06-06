<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BuscarProyecto.aspx.cs" Inherits="TallerInteligente.BuscarProyecto" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="App_Themes/Estilos.css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.4/css/jquery.dataTables.css"/>
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.11.4/js/jquery.dataTables.js"></script>
    <script type="text/javascript">
       
        //Al cargarse
        $(document).ready(function () {
            var btBuscar = $("#btBuscarProd");
            var instanciaDataTable = $("#dataTable").DataTable({
                searching: false                
            });
            //Al pulsar buscar cargar tabla proyectos
            btBuscar.click(function () {
                $.ajax({
                    url: 'proyectoHandler.asmx/recuProyectos',
                    method: 'post',
                    dataType: 'json',
                    data: { IdProyecto: $("#txtIdProyecto").val(), NombreCliente: $("#txtNombre").val() },
                    success: function (data) {
                        instanciaDataTable.destroy();
                            instanciaDataTable = $("#dataTable").DataTable({
                                data: data,
                                paging: true,
                                searching: false,
                                columns: [
                                    { 'data': 'IdProyecto' },
                                    { 'data': 'NombreCliente' },
                                    { 'data': 'Matricula' },
                                    { 'data': 'FechaCreacion' },
                                    { 'data': 'FechaFinal' },
                                    { 'data': 'EstadoProyecto'}
                                ]
                            });
                    },
                    
                    error: function (err) {
                        alert(err.statusText);
                    }
                });
            });
        });
    </script>
    <div id="cabecera">
        <img src="Img/taller.jpg" style="margin-left:30px; width:121px; height:116px; padding:-140px;"/>
    </div>
</head>
<body>
    <form id="form1" runat="server">
        <div class="contenedor">
            <div id="dvTablaProyectos" class ="left" style="margin: 15px;">
                Nombre Cliente:
                <input type="text" placeholder="Nombre" id="txtNombre"/>
               
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IdProyecto:
                <input type="text" placeholder="ID" id="txtIdProyecto"/>
                
                        &nbsp;&nbsp;&nbsp;&nbsp;
                <input type ="button" value="Buscar" id="btBuscarProd" />
                <br />
                <br />
                Proyectos:
                <br />
                <table id="dataTable" class="cell-border compact stripe hover" >
                    <thead>
                        <tr>
                            <th>IdProyecto</th>
                            <th>Nombre</th>
                            <th>Matricula</th>
                            <th>FechaCreacion</th>
                            <th>FechaFinal</th>
                            <th>EstadoProyecto</th>
                        </tr>
                    </thead>
                </table>
            </div>
        </div>
    </form>
</body>
</html>

