using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dapper;
using static ISRE.ISRI0001;
using System.Text;
using System.Web.Services;
using System.Web;


namespace ISRE
{

    public partial class ISRI0003 : Page
    {
        public static readonly int _ConnectionTimeout = 10000;
        public static readonly IDbConnection _dbConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
        
        public string SESSIONGUID =string.Empty;
        public string ActioinName = string.Empty;
        public string sSelected = string.Empty;
        public dynamic Model = null;
        public dynamic SESS_LOC = null;
        public dynamic List_CityList = null;
   


        protected void Page_Load(object sender, EventArgs e)
        {
            
            var GetSESSIONGUID = Request.QueryString["SESSIONGUID"] ?? "";
            var GetGUID = Request.QueryString["GUID"] ?? "";

            //SESSIONGUID = GetSESSIONGUID;1
            //dynamic Model1 = Process_Session(SESSIONGUID);

            SESSIONGUID = Request.QueryString["SESSIONGUID"] ?? "";  /////////SESSIONGUID=session guid
            ActioinName = (SESSIONGUID == "") ? "新增" : "編輯";

            Model = Process_Session(SESSIONGUID);
            sSelected = "";

            SESS_LOC = Request["SESS_LOC"] ?? "";
            List_CityList = StaticQueryDB("Home_ISRE_ACTIVITY_MAIN", "CityList");

        }
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
        protected ISRE_ACTIVITY_MAIN Process_ActivityInfo(String GUID)
        {
            DynamicParameters param = new DynamicParameters();
            param.Add("@GUID", GUID, DbType.String, ParameterDirection.Input);
            param.Add("@QueryMode", "R", DbType.String, ParameterDirection.Input);
            ISRE_ACTIVITY_MAIN model = new ISRE_ACTIVITY_MAIN();


            using (IDbConnection _dbConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
            {
                model = _dbConn.Query<ISRE_ACTIVITY_MAIN>(
                        "Home_ISRE_ACTIVITY_MAIN",
                        param,
                        commandType: CommandType.StoredProcedure
                        , commandTimeout: _ConnectionTimeout)
                        .FirstOrDefault();
            }

            return model;
        }

        /// <summary>
        /// ////////// get activity by session guid
        /// </summary>
        /// <param name="GUID"></param>
        /// <returns></returns>

        protected ISRE_SESSION_MAIN Process_Session(string GUID)
        {
            DynamicParameters param = new DynamicParameters();
            param.Add("@GUID", GUID, DbType.String, ParameterDirection.Input);
            param.Add("@QueryMode", "R", DbType.String, ParameterDirection.Input);
            ISRE_SESSION_MAIN model = new ISRE_SESSION_MAIN();

            using (IDbConnection _dbConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
            {
                model = _dbConn.Query<ISRE_SESSION_MAIN>(
                        "Session_ISRE_SESSION_MAIN",
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
        private static DynamicParameters CompParamFormVarle(List<NameValue> paramFormVars, string QueryMode = "")
        {
            DynamicParameters result = new DynamicParameters();

            if (QueryMode != "")
                result.Add("@QueryMode", QueryMode, DbType.String, ParameterDirection.Input);

            foreach (NameValue ncv in paramFormVars)
            {
                if (ncv.Value.Trim().Length > 0)
                {
                    result.Add(string.Format(@"@{0}", ncv.Name), ncv.Value, DbType.String, ParameterDirection.Input);
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

            string QueryMode = "C";

            foreach (NameValue nv in formVars)
            {
                // strip out ASP.NET form vars like _ViewState/_EventValidation
                //if (!nv.Name.StartsWith("__") && !nv.Name.EndsWith("_S") && !nv.Name.EndsWith("_E"))
                if (!nv.Name.StartsWith("__") 
                    && !nv.Name.StartsWith("SESS_DATE_S")
                    && !nv.Name.StartsWith("SESS_DATE_E")
                    && !nv.Name.StartsWith("REMIND_MAIL_TEXT")
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
                var encvName = ncv.Name;
                var encvValue = ncv.Value;

                if (ncv.Value.Trim().Length > 0)
                {
                    param.Add(string.Format(@"@{0}", ncv.Name), ncv.Value, DbType.String, ParameterDirection.Input);
                }
            }

            param = CompParamFormVarle(paramFormVars, QueryMode);

            dynamic model = new DynamicParameters();

            using (IDbConnection _dbConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
            {
                model = _dbConn.Query<dynamic>(
                                "Session_ISRE_SESSION_MAIN",
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


    }
}