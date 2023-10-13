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
using System.Text.RegularExpressions;
using Newtonsoft.Json.Linq;
using System.Collections.Specialized;

namespace ISRE
{

    public partial class ISRI0003 : Page
    {
        public static readonly int _ConnectionTimeout = 10000;
        public static readonly IDbConnection _dbConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);

        public string SESSIONGUID = string.Empty;
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

            /// <remarks>
            /// Modification date : 20230925
            /// Modifier :Alex Huang
            /// </remarks> 
            if (GetGUID.Trim().Length == 0)
            {
                Response.Redirect("ISRI0000.ASPX");
                return;
            }
            /// <remarks>
            /// Modification date : 20230925
            /// Modifier :Alex Huang
            /// </remarks> 



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

            result = _dbConn.Query<dynamic>(
               SPName,
                param,
                commandType: CommandType.StoredProcedure
                , commandTimeout: _ConnectionTimeout)
                .ToList();

            return result;

        }

        protected ISRE_ACTIVITY_MAIN Process_ActivityInfo(String GUID)
        {
            DynamicParameters param = new DynamicParameters();
            param.Add("@GUID", GUID, DbType.String, ParameterDirection.Input);
            param.Add("@QueryMode", "R", DbType.String, ParameterDirection.Input);
            ISRE_ACTIVITY_MAIN model = new ISRE_ACTIVITY_MAIN();


            model = _dbConn.Query<ISRE_ACTIVITY_MAIN>(
                    "Home_ISRE_ACTIVITY_MAIN",
                    param,
                    commandType: CommandType.StoredProcedure
                    , commandTimeout: _ConnectionTimeout)
                    .FirstOrDefault();

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
        /// 新增按鈕
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        /// <remarks>
        /// Modification date : 20231013 
        /// Modifier :Alex Huang
        /// </remarks> 

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            Send(sender, e);
            Response.Redirect(string.Format("ISRI0002.aspx?GUID={0}", GetGUID));
        }


        /// <summary>
        /// 更新資料
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        /// <remarks>
        /// Modification date : 20231013 
        /// Modifier :Alex Huang
        /// </remarks> 
        protected void btnInsert_Click(object sender, EventArgs e)
        { }

        /// <summary>
        /// 傳送新增表單資料
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        /// <remarks>
        /// Modification date : 20231013 
        /// Modifier :Alex Huang
        /// </remarks> 
        protected void Send(object sender, EventArgs e)
        {
            DynamicParameters param = new DynamicParameters();
            string QueryMode = "C";
            string ActSeqNO = GetActSeqNO(GetGUID);

            param.Add("@QueryMode", QueryMode, DbType.String, ParameterDirection.Input);
            param.Add(string.Format(@"@{0}", "ACT_SEQ_NO"), ActSeqNO, DbType.String, ParameterDirection.Input);

            foreach (string key in Request.Form.AllKeys)
            {
                if (!key.StartsWith("__")
                       && !key.StartsWith("ctl00$MainContent$btnAdd"))
                {
                    string value = Request.Form[key];
                    param.Add(string.Format(@"@{0}", key), value, DbType.String, ParameterDirection.Input);
                }
            }
            dynamic model = _dbConn.Query<dynamic>(
                            "Session_ISRE_SESSION_MAIN",
                            param,
                            commandType: CommandType.StoredProcedure
                        , commandTimeout: _ConnectionTimeout)
                        .FirstOrDefault();
        }

        /// <summary>
        /// ProcessActivityInfo class
        /// </summary>
        /// <param name="GUID"></param>
        /// <returns></returns>
        /// <remarks>
        /// Modification date : 20231013 
        /// Modifier :Alex Huang
        /// </remarks> 
        public static IsreActivityMain ProcessActivityInfo(String GUID)
        {
            DynamicParameters param = new DynamicParameters();
            param.Add("@GUID", GUID, DbType.String, ParameterDirection.Input);
            param.Add("@QueryMode", "R", DbType.String, ParameterDirection.Input);
            IsreActivityMain model = new IsreActivityMain();


            using (IDbConnection _dbConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
            {
                model = _dbConn.Query<IsreActivityMain>(
                        "Home_ISRE_ACTIVITY_MAIN",
                        param,
                        commandType: CommandType.StoredProcedure
                        , commandTimeout: _ConnectionTimeout)
                        .FirstOrDefault();
            }

            return model;
        }


        /// <summary>
        ///  GetActSeqNO
        /// </summary>
        /// <param name="GUID"></param>
        /// <returns></returns>
        /// <remarks>
        /// Modification date : 20231013 
        /// Modifier :Alex Huang
        /// </remarks> 
        public static string GetActSeqNO(string GUID = "")
        {

            IsreActivityMain GetActivityMainDatas = new IsreActivityMain();

            string GetActSeqNO = string.Empty;

            GetActivityMainDatas = ProcessActivityInfo(GUID);

            GetActSeqNO = (GetActivityMainDatas == null) ? "" : GetActivityMainDatas.ACT_SEQ_NO;

            return GetActSeqNO;

        }

        /// <summary>
        /// class IsreActivityMain
        /// </summary>
        /// <remarks>
        /// Modification date : 20231013 
        /// Modifier :Alex Huang
        /// </remarks> 
        public class IsreActivityMain : ISRE_ACTIVITY_MAIN
        {
            public string ACT_SEQ_NO { get; set; }
        }


    }

}