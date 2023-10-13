using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dapper;
using System.Web.Services;
using System.Text;
using System.Web;
using static ISRE.ISRI0001;
using System.Globalization;

namespace ISRE
{
    
    public partial class ISRI0001 : Page
    {
        public static readonly int _ConnectionTimeout = 10000;
        public static readonly int _PageSize = 3;

        private string TableName = "ISRE_ACTIVITY_MAIN"; 
        private readonly static string SPName = "Home_ISRE_ACTIVITY_MAIN";
        // private string GUID = "";

        public dynamic List_ACT_TYPE = null;


        protected void Page_Load(object sender, EventArgs e)
        {
            /// Creation date: 20231003 Modification date : 20231003 Author : Alex Huang
            List_ACT_TYPE = StaticQueryDB("Home_ISRE_ACTIVITY_MAIN", "ACT_TYPE");
            /// Creation date: 20231003 Modification date : 20231003 Author : Alex Huang
        }

        /// <summary>
        /// StaticQueryDB
        /// </summary>
        /// <param name="SPName">Stored Procedure Name </param>
        /// <param name="QueryMode"></param>
        /// <returns>result</returns>
        /// <remarks>
        /// Modification date : 20231003
        /// Author : Alex Huang
        /// </remarks> 
        protected static List<dynamic> StaticQueryDB(string SPName, string QueryMode)
        {
            DynamicParameters param = new DynamicParameters();
            param.Add("@QueryMode", QueryMode, DbType.String, ParameterDirection.Input);

            List<dynamic> result = new List<dynamic>();

            using (IDbConnection _dbConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
            {
                result = _dbConn.Query<dynamic>(
                        SPName,
                        param,
                        commandType: CommandType.StoredProcedure
                        , commandTimeout: _ConnectionTimeout)
                    .ToList();
            }
            return result;
        }

        /// <summary>
        /// Process_ActivityInfo
        /// </summary>
        /// <param name="GUID">Globally Unique Identifier</param>
        /// <returns>Return data</returns>
        /// <remarks>
        /// Modification date : 20231003
        /// Author : Alex Huang
        /// </remarks> 
        protected dynamic Process_ActivityInfo(String GUID)
        {
            DynamicParameters param = new DynamicParameters();
            param.Add("@GUID", GUID, DbType.String, ParameterDirection.Input);
            param.Add("@QueryMode", "R", DbType.String, ParameterDirection.Input);

            dynamic model = new DynamicParameters();

            using (IDbConnection _dbConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
            {
                model = _dbConn.Query<dynamic>(
                            "Home_ISRE_ACTIVITY_MAIN",
                            param,
                            commandType: CommandType.StoredProcedure
                            , commandTimeout: _ConnectionTimeout)
                            .FirstOrDefault();
            }
            return model;
        }
        
        /// <summary>
        /// CompParamFormVar
        /// <para>
        /// The DynamicParameters class has a dynamic object that represents the anonymous parameters
        /// </para>
        /// </summary>
        /// <param name="paramFormVars"></param>
        /// <param name="QueryMode"></param>
        /// <returns>Return data</returns>
        /// <remarks>
        /// Creation date: 20231003
        /// Modification date : 20231003
        /// Author : Alex Huang
        /// </remarks> 
        private static DynamicParameters CompParamFormVarle(List<NameValue> paramFormVars,string QueryMode = "")
        {
            DynamicParameters result = new DynamicParameters();

            if(QueryMode != "")
                result.Add("@QueryMode", QueryMode, DbType.String, ParameterDirection.Input);

            foreach (NameValue ncv in paramFormVars)
            {
                if (ncv.Value.Trim().Length > 0)
                {
                    result.Add(string.Format(@"@{0}",ncv.Name), ncv.Value, DbType.String, ParameterDirection.Input);
                }
            }
            return result;
        }

        /// <summary>
        ///  WebMethod : InsertData
        /// </summary>
        /// <param name="formVars"> on the server we’re going to call is going to be very simple and just capture the content of these values </param>
        /// <returns>Return data</returns>
        /// <remarks>
        /// Creation date: 20231002
        /// Modification date : 20231003
        /// Author : Alex Huang
        /// </remarks> 
        [WebMethod]
        public static String InsertData(NameValue[] formVars)
        {

            List<NameValue> paramFormVars = new List<NameValue>();

            NameValue paramFormVar = new NameValue();
            DynamicParameters param = new DynamicParameters();
            StringBuilder sb = new StringBuilder();
            string tempValue = string.Empty;
            string QueryMode = "C";

            foreach (NameValue nv in formVars)
            {
                // strip out ASP.NET form vars like _ViewState/_EventValidation
                if (!nv.Name.StartsWith("__") 
                    && !nv.Name.EndsWith("_S_DATE") && !nv.Name.EndsWith("_S_TIME")
                    && !nv.Name.EndsWith("_E_DATE") && !nv.Name.EndsWith("_E_TIME")
                    )
                {
                    sb.Append(nv.Name);
                    sb.AppendLine(": " + HttpUtility.HtmlEncode(nv.Value) + "<br/>");

                    paramFormVar = new NameValue
                    {
                        Name = nv.Name,
                        Value = nv.Value ?? ""
                    };
                    paramFormVars.Add(paramFormVar);
                }
            }

            int i = paramFormVars.Where(x => x.Value != "").Count();

            if (QueryMode != "")
                param.Add("@QueryMode", QueryMode, DbType.String, ParameterDirection.Input);

            foreach (NameValue ncv in paramFormVars)
            {
                switch (ncv.Name)
                {
                    case "PUB_DATE_S":
                    case "PUB_DATE_E":
                    case "ACT_DATE_S":
                    case "ACT_DATE_E":
 
                        CultureInfo culture = new CultureInfo("zh-TW");
                        culture.DateTimeFormat.Calendar = new System.Globalization.TaiwanCalendar();

                        if (IsDate(ncv.Value))
                        {
                            DateTime dateTime = DateTime.Parse(ncv.Value, culture);
                            tempValue = dateTime.ToString();//.ToString("yyy/MM/dd");
                            param.Add(string.Format(@"@{0}", ncv.Name), tempValue, DbType.DateTime, ParameterDirection.Input);
                        }

                        break;
                    default:
                        param.Add(string.Format(@"@{0}", ncv.Name), ncv.Value, DbType.String, ParameterDirection.Input);
                        break;
                }




                //if (ncv.Value.Trim().Length > 0)
                //{
                //    param.Add(string.Format(@"@{0}", ncv.Name), ncv.Value, DbType.String, ParameterDirection.Input);
                //}
            }

            param = CompParamFormVarle(paramFormVars, QueryMode);

            dynamic model = new DynamicParameters();

            using (IDbConnection _dbConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
            {
                model = _dbConn.Query<dynamic>(
                                "Home_ISRE_ACTIVITY_MAIN",
                                param,
                                commandType: CommandType.StoredProcedure
                            , commandTimeout: _ConnectionTimeout)
                            .FirstOrDefault();
            }

            return Newtonsoft.Json.JsonConvert.SerializeObject(new
            {
                model
            });
        }

        public static bool IsDate(string strDate)
        {
            try
            {
                DateTime.Parse(strDate);
                return true;
            }
            catch
            {
                return false;
            }
        }
        /// <summary>
        /// The NameValue class is as simple as this and simply maps the structure of the array elements of .serializeArray():
        /// </summary>
        public class NameValue
        {
            /// <summary>
            /// Name
            /// </summary>
            public string Name { get; set; }
            /// <summary>
            /// ValueS
            /// </summary>
            public string Value { get; set; }
        }

    }

    /// <summary>
    /// Simple NameValue class that maps name and value
    /// properties that can be used with jQuery's 
    /// $.serializeArray() function and JSON requests
    /// </summary>
    public static class NameValueExtensionMethods
    {
        /// <summary>
        /// Retrieves a single form variable from the list of
        /// form variables stored
        /// </summary>
        /// <param name="formVars"></param>
        /// <param name="name">formvar to retrieve</param>
        /// <returns>value or string.Empty if not found</returns>
        public static string Form(this NameValue[] formVars, string name)
        {
            var matches = formVars.Where(nv => nv.Name.ToLower() == name.ToLower()).FirstOrDefault();
            if (matches != null)
                return matches.Value;
            return string.Empty;
        }

        /// <summary>
        /// Retrieves multiple selection form variables from the list of 
        /// form variables stored.
        /// </summary>
        /// <param name="formVars"></param>
        /// <param name="name">The name of the form var to retrieve</param>
        /// <returns>values as string[] or null if no match is found</returns>
        public static string[] FormMultiple(this NameValue[] formVars, string name)
        {
            var matches = formVars.Where(nv => nv.Name.ToLower() == name.ToLower()).Select(nv => nv.Value).ToArray();
            if (matches.Length == 0)
                return null;
            return matches;
        }
    }
}