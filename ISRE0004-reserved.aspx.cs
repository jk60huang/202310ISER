using Dapper;
using Microsoft.Ajax.Utilities;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ISRE
{
    public partial class ISRE0004 : Page
    {
        public static readonly int _ConnectionTimeout = 10000;
        public static readonly IDbConnection _dbConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
        public static readonly int _PageSize = 3;

        private readonly static string TableName = "ISRE_ACTIVITY_MAIN";
        //  private readonly static string ControllerName = string.Concat("/Home/");
        private readonly static string SPName = "[dbo].[HOME_ISRE_ACTIVITY_MAIN]";
		//  private readonly static string Updated_RowView = "Updated_Row";
		//  string sSelected= "";
		
		protected void Page_Load(object sender, EventArgs e)
        {
			//string colorName = SESS_LOC.Items[SESS_LOC.SelectedIndex].Text;
			//StringBuilder sb2 = new StringBuilder();
			Tuple< string, string> city = null;
			ListItem LICountry =  null;
			if (!this.IsPostBack)
			{
				//List<string> list = new List<string>()
				// {
				//	"test",
				//	"test2"
				// };
				//ListItem LICountry = new ListItem("----Select----", "-1");
				 dynamic  CityList  = StaticQueryDB("Home_ISRE_ACTIVITY_MAIN", "CityList");
			

				//foreach (DataRow row in List_CityList)
				//{
				//	products.add(New dynamic { row.CityNo, row.CityName  });
				//}
				//sb2.Append("<option>請選擇</option>");
				foreach (var item in  CityList)
				{
					city = Tuple.Create(item.CityNo, item.CityName);
					 
					//ShowAssumptions.Items.Add(item);
					//sb2.Append("<option value=");
					//sb2.Append(item.CityNo);
					//sb2.Append(">");
					//sb2.Append(item.CityName);
					//sb2.Append("</option>");
					//list.Add(item);
				}
				//ShowAssumptions.DataSource = city;
				//  ShowAssumptions.DataBind();
				


				//DataTable dt = new DataTable();
				//dt.Columns.AddRange(new DataColumn[3] { new DataColumn("Id", typeof(int)),
				//	new DataColumn("Name", typeof(string)),
				//	new DataColumn("Country",typeof(string)) });
				//dt.Rows.Add(1, "John Hammond", "United States");
				//dt.Rows.Add(2, "Mudassar Khan", "India");
				//dt.Rows.Add(3, "Suzanne Mathews", "France");
				//dt.Rows.Add(4, "Robert Schidner", "Russia");

				//StringBuilder sb = new StringBuilder();
				////Table start.
				//sb.Append("<table cellpadding='5' cellspacing='0' style='border: 1px solid #ccc;font-size: 9pt;font-family:Arial'>");

				////Adding HeaderRow.
				//sb.Append("<tr>");
				//foreach (DataColumn column in dt.Columns)
				//{
				//	sb.Append("<th style='background-color: #B8DBFD;border: 1px solid #ccc'>" + column.ColumnName + "</th>");
				//}
				//sb.Append("</tr>");


				////Adding DataRow.
				//foreach (DataRow row in dt.Rows)
				//{
				//	sb.Append("<tr>");
				//	foreach (DataColumn column in dt.Columns)
				//	{
				//		sb.Append("<td style='width:100px;border: 1px solid #ccc'>" + row[column.ColumnName].ToString() + "</td>");
				//	}
				//	sb.Append("</tr>");
				//}

				////Table end.
				//sb.Append("</table>");
				//ltTable.Text = sb.ToString();
			}
			
			//string SESS_LOC = Request["SESS_LOC"] ?? "";
			
			//SESS_LOC= sb2.ToString();
		}
		 
	protected static List<dynamic> StaticQueryDB(string SPName, string QueryMode)
        {
            DynamicParameters param = new DynamicParameters();
            param.Add("@QueryMode", QueryMode, DbType.String, ParameterDirection.Input);

            List<dynamic> result = _dbConn.Query<dynamic>(
           SPName,
            param,
            commandType: CommandType.StoredProcedure
            , commandTimeout: _ConnectionTimeout)
            .ToList();
            return result;
        }

        protected List<dynamic> Process_ActivityList(int Page = 1
            , int OrderIndex = 1)
        {
            DynamicParameters param = new DynamicParameters();
            param.Add("@PageSize", _PageSize, DbType.Int16, ParameterDirection.Input);
            param.Add("@Page", Page, DbType.Int16, ParameterDirection.Input);
            param.Add("@OrderIndex", OrderIndex, DbType.Int16, ParameterDirection.Input);
            param.Add("@QueryMode", "QF", DbType.String, ParameterDirection.Input);

            List<dynamic> model = _dbConn.Query<dynamic>(
            SPName,
            param,
            commandType: CommandType.StoredProcedure
            , commandTimeout: _ConnectionTimeout)
            .ToList();

            return model;
        }

    }
}