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
using System.Globalization;

namespace ISRE
{

    public partial class ISRI0003 : Page
    {
        public static readonly int _ConnectionTimeout = 10000;
        public static readonly IDbConnection _dbConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
        
        public string SESSIONGUID =string.Empty;
        public string ActioinName = string.Empty;
        public string sSelected = string.Empty;
        //public string GUID = string.Empty;
        public string GetGUID = string.Empty;
        public dynamic Model = null;
        public dynamic SESS_LOC = null;
        public dynamic List_CityList = null;

      


        protected void Page_Load(object sender, EventArgs e)
        {
            
            var GetSESSIONGUID = Request.QueryString["SESSIONGUID"] ?? "";
            GetGUID = Request.QueryString["GUID"] ?? "";

            //SESSIONGUID = GetSESSIONGUID;1
            //dynamic Model1 = Process_Session(SESSIONGUID);

            SESSIONGUID = Request.QueryString["SESSIONGUID"] ?? "";  /////////SESSIONGUID=session guid
            ActioinName = (SESSIONGUID == "") ? "新增" : "編輯";

            Model = Process_Session(SESSIONGUID);
            sSelected = "";

            SESS_LOC = Request["SESS_LOC"] ?? "";
            List_CityList = StaticQueryDB("Home_ISRE_ACTIVITY_MAIN", "CityList");

            //string ActSeqNO = GetActSeqNO(GetGUID);

            
                //.Text = GetGUID;

            txtGUID.Text = GetGUID;
            //Page.ClientScript.RegisterStartupScript(Page.GetType(), "message", "<script language='javascript' defer>$(\"#GUID\").text(\""+ GetGUID + "\");</script>");

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

        public static string GetActSeqNO(string GUID = "")
        {            

            IsreActivityMain01 GetActivityMainDatas = new IsreActivityMain01();

            string GetActSeqNO = string.Empty;

            GetActivityMainDatas = Process_ActivityInfo01(GUID);

            GetActSeqNO = (GetActivityMainDatas == null) ? "" : GetActivityMainDatas.ACT_SEQ_NO;

            return GetActSeqNO;

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


        public static IsreActivityMain01 Process_ActivityInfo01(String GUID)
        {
            DynamicParameters param = new DynamicParameters();
            param.Add("@GUID", GUID, DbType.String, ParameterDirection.Input);
            param.Add("@QueryMode", "R", DbType.String, ParameterDirection.Input);
            IsreActivityMain01 model = new IsreActivityMain01();


            using (IDbConnection _dbConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
            {
                model = _dbConn.Query<IsreActivityMain01>(
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
                    && !nv.Name.StartsWith("CHK_DATE_S_DATE")
                    && !nv.Name.StartsWith("CHK_DATE_S_TIME") 
                    && !nv.Name.StartsWith("CHK_DATE_E_DATE")
                    && !nv.Name.StartsWith("CHK_DATE_E_TIME")
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

           
            
            //string ActSeqNO = GetActSeqNO(GetGUID);


            foreach (NameValue ncv in paramFormVars)
            {
                var encvName = ncv.Name;
                var encvValue = ncv.Value;
                string tempName = string.Empty;
                string tempValue = string.Empty;
                //if (ncv.Value.Trim().Length > 0)
                //{
                if (ncv.Name == "ctl00$MainContent$txtGUID")
                    {
                        //tempName = "GUID";
                        string ActSeqNO = GetActSeqNO(ncv.Value);
                        //param.Add(string.Format(@"@{0}", "GUID"), ncv.Value, DbType.String, ParameterDirection.Input);
                        param.Add(string.Format(@"@{0}", "ACT_SEQ_NO"), ActSeqNO, DbType.String, ParameterDirection.Input);
                    }
                    else 
                    {
                        //tempName = ncv.Name;
                        param.Add(string.Format(@"@{0}", ncv.Name), ncv.Value, DbType.String, ParameterDirection.Input);
                    }
                //}

                switch (ncv.Name)
                {
                    case "ctl00$MainContent$txtGUID":
                        string ActSeqNO = GetActSeqNO(ncv.Value);
                        param.Add(string.Format(@"@{0}", "ACT_SEQ_NO"), ActSeqNO, DbType.String, ParameterDirection.Input);
                        break;

                    case "SESS_DATE_S_DATE":
                    case "SESS_DATE_E_DATE":
                    case "REG_DATE_S":
                    case "REG_DATE_E":
                    case "CHK_DATE_S_DATE":
                    case "CHK_DATE_E_DATE":
                    case "sch_s_datepicker":
                        //Console.WriteLine($"Measured value is {measurement}; too high.");                        
                        CultureInfo culture = new CultureInfo("zh-TW");
                        culture.DateTimeFormat.Calendar = new System.Globalization.TaiwanCalendar();

                        if (IsDate(ncv.Value)) 
                        {
                            DateTime dateTime = DateTime.Parse(ncv.Value, culture);
                            tempValue = dateTime.ToString("yyy/MM/dd");
                            param.Add(string.Format(@"@{0}", ncv.Name), tempValue, DbType.String, ParameterDirection.Input);
                        }

                        break;
                    default:
                        param.Add(string.Format(@"@{0}", ncv.Name), ncv.Value, DbType.String, ParameterDirection.Input);
                        break;
                }

            }



            //param = CompParamFormVarle(paramFormVars, QueryMode);

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

        // Derive a new class from ISRE_ACTIVITY_MAIN.
        public class IsreActivityMain01  
        {
            public string ACT_ENABLE { get; set; }
            //public string PUB_DATE_S { get; set; }
            //public string PUB_DATE_E { get; set; }
            public string USER_ID { get; set; }
            public string AGENT_ID { get; set; }
            public string ACT_STATUS { get; set; }
            public string ACT_TYPE { get; set; }
            public string ACT_NAME { get; set; }
            public string ACT_IMG { get; set; }
            public string ACT_DESC { get; set; }
            public string OBJ_NO { get; set; }
            public string OBJ_DESC { get; set; }
            public string ACT_HOST { get; set; }
            public string ACT_CO_HOST { get; set; }
            public string ACT_CONTACT_INFO { get; set; }
            public string CREATE_DATE { get; set; }
            public string TXT_DATE { get; set; }
            public string TXT_USER_ID { get; set; }
            public string GUID { get; set; }

            public string ACT_SEQ_NO { get; set; }
            public string PUB_DATE_S { get; set; }

            public string PUB_DATE_E { get; set; }

            public string ACT_DATE_S { get; set; }

            public string ACT_DATE_E { get; set; }
        }
    }
}