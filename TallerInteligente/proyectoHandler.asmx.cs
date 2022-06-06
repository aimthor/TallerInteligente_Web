using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.Configuration;

namespace TallerInteligente
{
    /// <summary>
    /// Descripción breve de proyectoHandler
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    [System.Web.Script.Services.ScriptService]
    public class proyectoHandler : System.Web.Services.WebService
    {
        List<Clases.Proyectos> proyectos = new List<Clases.Proyectos>();

        [WebMethod]
        public void recuProyectos(string IdProyecto, string NombreCliente) //recupero toda la lista de proyectos que se han creado
        {
            string txtIdProyecto = IdProyecto;
            string txtNombreCliente = NombreCliente;

            string strConexion = ConfigurationManager.ConnectionStrings["TallerDB"].ConnectionString;

            using (SqlConnection con = new SqlConnection(strConexion)) //Abro conexion para recuperar los proyectos
            {
                SqlCommand cmdProyectos = new SqlCommand("taller.pr_recuProyectos", con);
                cmdProyectos.CommandType = CommandType.StoredProcedure;
                SqlParameter prmIdProyecto = new SqlParameter();
                SqlParameter prmNombreCliente = new SqlParameter();

                prmIdProyecto.ParameterName = "@p_IdProyecto";
                prmIdProyecto.SqlDbType = SqlDbType.Char;
                prmIdProyecto.Size = 5;
                prmIdProyecto.Direction = ParameterDirection.Input;

                prmNombreCliente.ParameterName = "@p_NombreCliente";
                prmNombreCliente.SqlDbType = SqlDbType.VarChar;
                prmNombreCliente.Size = 120;
                prmNombreCliente.Direction = ParameterDirection.Input;

                cmdProyectos.Parameters.Add(prmIdProyecto);
                cmdProyectos.Parameters.Add(prmNombreCliente);

                cmdProyectos.Parameters[0].Value = convProd(txtIdProyecto);
                cmdProyectos.Parameters[1].Value = txtNombreCliente;

                con.Open();
                SqlDataReader lector = cmdProyectos.ExecuteReader();
                while (lector.Read())
                {
                    Clases.Proyectos objProyecto = new Clases.Proyectos();
                    objProyecto.IdProyecto = lector["IdProyecto"].ToString();
                    objProyecto.NombreCliente = lector["NombreCliente"].ToString();
                    objProyecto.Matricula = lector["Matricula"].ToString();
                    objProyecto.FechaCreacion = lector["FechaCreacion"].ToString();
                    objProyecto.FechaFinal = comprobarNull(lector["FechaFinal"].ToString());
                    objProyecto.EstadoProyecto = estadoProyecto(lector["EstadoProyecto"].ToString());

                    proyectos.Add(objProyecto);
                }
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(proyectos));
        }

        private string comprobarNull(string v)
        {
            string resp = v;
            if(v == "")
            {
                resp = "------";
            }
            return resp;
        }

        private string estadoProyecto(string estado)
        {
            string resp = "";
            switch(estado)
            {
                case "0":
                     resp = "RECIBIDO";
                    break;
                case "1":
                    resp = "EN PROCESO";
                    break;
                case "2":
                    resp = "FINALIZADO";
                    break;
            }
            return resp;
        }

        private string convProd(string prod)
        {
            String codProd = "";
            codProd = prod;

            if (codProd.Length == 4)
            {
                codProd = "0" + codProd;
            }
            else if (codProd.Length == 3)
            {
                codProd = "00" + codProd;
            }
            else if (codProd.Length == 2)
            {
                codProd = "000" + codProd;
            }
            else if (codProd.Length == 1)
            {
                codProd = "0000" + codProd;
            }
            return codProd;
        }
    }
}
