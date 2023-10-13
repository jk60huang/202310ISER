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

            btnAdd.Enabled = GetGUID.Length!=0;

            txtGUID.Text = GetGUID;

        }


        //public static bool IsDate(string strDate)
        //{
        //    try
        //    {
        //        DateTime.Parse(strDate);
        //        return true;
        //    }
        //    catch
        //    {
        //        return false;
        //    }
        //}

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



        protected void btnAdd_Click(object sender, EventArgs e)
        {

            Send00(sender, e);
        }

        protected void Send00(object sender, EventArgs e)
        {

            NameValueCollection coll;

            //Load Form variables into NameValueCollection variable.
            coll = Request.Form;

            DynamicParameters param = new DynamicParameters();
            string QueryMode = "C";
            string ActSeqNO = GetActSeqNO(GetGUID);

            param.Add("@QueryMode", QueryMode, DbType.String, ParameterDirection.Input);
            param.Add(string.Format(@"@{0}", "ACT_SEQ_NO"), ActSeqNO, DbType.String, ParameterDirection.Input);

            foreach (string key in Request.Form.AllKeys)
            {
                var stras = "";
                if (key.StartsWith("__")
                       && !key.StartsWith("ctl00$MainContent$btnAdd")) continue;
                string value = Request.Form[key]; // do something with the key-value pair
                Response.Write(stras+"Form: " + key + "=" + Server.HtmlEncode(value) + "<br>");
                param.Add(string.Format(@"@{0}", key), value, DbType.String, ParameterDirection.Input);

            }
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

        }

        protected void Send01(object sender, EventArgs e)
        {
            string CHK_DATE_S_DATE = string.Empty;
            string CHK_DATE_S_TIME = string.Empty; string CHK_DATE_E_DATE = string.Empty; string CHK_DATE_E_TIME = string.Empty;


            if (GetGUID.Trim().Length == 0)
            {
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "message", "<script language='javascript' defer>alert('無GUID值');</script>");
                return;
            }

            Dictionary<string, string> MyDic = new Dictionary<string, string>();
            DynamicParameters param = new DynamicParameters();

            string QueryMode = "C";
            string ActSeqNO = GetActSeqNO(GetGUID);

            param.Add("@QueryMode", QueryMode, DbType.String, ParameterDirection.Input);
            param.Add(string.Format(@"@{0}", "ACT_SEQ_NO"), ActSeqNO, DbType.String, ParameterDirection.Input);

            List<NameValue> paramFormVars = new List<NameValue>();
            NameValue paramFormVar = new NameValue();

            MyDic.Add("CHK_DATE_S", "");
            MyDic.Add("CHK_DATE_E", "");
            foreach (string key in Request.Form.AllKeys)
            {
                string value = Request.Form[key]; // do something with the key-value pair

                if (null != value)
                {
                    if (!key.StartsWith("__")
                        && !key.StartsWith("ctl00$MainContent$btnAdd") && !key.StartsWith("SESS_DATE_E_TIME") && key.StartsWith("CHK_DATE_S_TIME")

                                            && !key.StartsWith("SESS_DATE_S")
                    && !key.StartsWith("SESS_DATE_E")
                    && !key.StartsWith("CHK_DATE_S_DATE")
                    && !key.StartsWith("CHK_DATE_S_TIME")
                    && !key.StartsWith("CHK_DATE_E_DATE")
                    && !key.StartsWith("CHK_DATE_E_TIME")
                        )
                    {
                        switch (key)
                        {
                            case "SESS_DATE_S_DATE":
                            case "SESS_DATE_E_DATE":
                            case "CHK_DATE_S_DATE":
                            case "CHK_DATE_E_DATE":
                                MyDic.Add(key, toADDate(value));
                                paramFormVar = new NameValue
                                {
                                    Name = key,
                                    Value = toADDate(value)
                                };

                                break;

                            case "REMIND_MAIL_DATE":
                                MyDic.Add(key, toADDate(value));
                                paramFormVar = new NameValue
                                {
                                    Name = key,
                                    Value = toADDate(value)
                                };
                                if (value.Length > 0)
                                    param.Add(string.Format(@"@{0}", key), toADDate(value), DbType.String, ParameterDirection.Input);


                                break;
                            //case "SESS_DATE_S":
                            //case "SESS_DATE_E":
                            case "REG_DATE_S":
                            case "REG_DATE_E":
                                MyDic.Add(key, ToyyyyMMddHHmmss(value));
                                paramFormVar = new NameValue
                                {
                                    Name = key,
                                    Value = ToyyyyMMddHHmmss(value)
                                };
                                if (value.Length > 0)
                                    param.Add(string.Format(@"@{0}", key), ToyyyyMMddHHmmss(value), DbType.String, ParameterDirection.Input);
                                break;

                            case "SESS_DATE_S_TIME":
                                break;
                            default:
                                MyDic.Add(key, value);
                                paramFormVar = new NameValue
                                {
                                    Name = key,
                                    Value = value
                                };

                                if (value != null)
                                    param.Add(string.Format(@"@{0}", key), value, DbType.String, ParameterDirection.Input);
                                break;
                        }

                        paramFormVars.Add(paramFormVar);

                    }

                }



            }




            //var MyDicValDATE = MyDic.Where(x => x.Key == "SESS_DATE_S_DATE").Select(x=>x.Value);
            //var MyDicValTime = MyDic.Where(x => x.Key == "SESS_DATE_S_Time").Select(x => x.Value);
            //if (MyDicValDATE.ToString().Length == 0 || MyDicValTime.ToString().Length == 0)
            //{
            //    MyDic["SESS_DATE_S"] = string.Empty;
            //}
            //else
            //{
            //    param.Add(string.Format(@"@{0}", key), value, DbType.String, ParameterDirection.Input);
            //}

            //MyDicValDATE = MyDic.Where(x => x.Key == "SESS_DATE_E_DATE").Select(x => x.Value);
            //MyDicValTime = MyDic.Where(x => x.Key == "SESS_DATE_E_Time").Select(x => x.Value);
            //if (MyDicValDATE.ToString().Length == 0 || MyDicValTime.ToString().Length == 0)
            //{
            //    MyDic["SESS_DATE_E"] = string.Empty;
            //}

            //string tempDatetime = string.Empty;

            //MyDicValDATE = MyDic.Where(x => x.Key == "CHK_DATE_S_DATE").Select(x => x.Value);
            //MyDicValTime = MyDic.Where(x => x.Key == "CHK_DATE_S_Time").Select(x => x.Value);
            //if (String.IsNullOrEmpty(MyDicValDATE.ToString()) || String.IsNullOrEmpty(MyDicValTime.ToString()))
            //{   
            //    MyDic["CHK_DATE_S"] = string.Empty;
            //}
            //else
            //{
            //    tempDatetime = string.Format("{0} {1}", MyDicValDATE.ToString(), MyDicValTime.ToString());
            //    MyDic["CHK_DATE_S"] = tempDatetime;
            //}

            //MyDicValDATE = MyDic.Where(x => x.Key == "CHK_DATE_E_DATE").Select(x => x.Value);
            //MyDicValTime = MyDic.Where(x => x.Key == "CHK_DATE_E_Time").Select(x => x.Value);
            //if (MyDicValDATE.ToString().Length == 0 || MyDicValTime.ToString().Length == 0)
            //{
            //    MyDic["CHK_DATE_E"] = string.Empty;
            //}
            //else
            //{
            //    tempDatetime = string.Format("{0} {1}", MyDicValDATE.ToString(), MyDicValTime.ToString());
            //    MyDic["CHK_DATE_E"] = tempDatetime;
            //}

            string l = string.Empty;

            //foreach (KeyValuePair<string, string> item in MyDic)
            //{

            //    switch (item.Key)
            //    {
            //        case "SESS_DATE_S":
            //        case "SESS_DATE_E":
            //        case "CHK_DATE_S":
            //        case "CHK_DATE_E":
            //        case "SESS_LOC":
            //        case "REG_DATE_S":
            //        case "REG_DATE_E":
            //        case "SESS_HOST":
            //        case "SESS_CO_HOST":
            //        case "SESS_CONTACT_INFO":
            //        case "REG_MAX_COUNT":
            //        case "WAIT_NAX_COUNT":
            //        case "UNIT_NAX_COUNT":
            //        case "VIDEO_LINK":
            //        case "ATTACH_VIDEO_LINK":
            //        case "CONFIRM_MAIL":
            //        case "SUCCESS_MAIL":
            //        case "WAIT_MAIL":
            //        case "REMIND_MAIL_ENABLE":
            //        case "REMIND_MAIL_DATE":
            //        case "REMIND_MAIL_TIME":
            //        case "REMIND_MAIL_TEXT":

            //               if(item.Value != null || item.Value.Length >0) 
            //                param.Add(string.Format(@"@{0}", item.Key), item.Value, DbType.String, ParameterDirection.Input);
            //            break;
            //    }




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




            //}


            //var itemsToRemove = MyDic.Where(f => f.Value == null).Where(f =>f.Value == "").ToArray();
            //foreach (var item in itemsToRemove)
            //    MyDic.Remove(item.Key);

        }


        protected void btnInsert_Click(object sender, EventArgs e)
        {

        }

        /// <summary>
        /// 判斷是否為日期
        /// </summary>
        /// <param name="pDate">傳入字串。</param>
        public static bool IsDate(string pDate)
        {
            return Regex.IsMatch(pDate, @"^((((1[6-9]|[2-9]\d)\d{2})-(0?[13578]|1[02])-(0?[1-9]|[12]\d|3[01]))|(((1[6-9]|[2-9]\d)\d{2})-(0?[13456789]|1[012])-(0?[1-9]|[12]\d|30))|(((1[6-9]|[2-9]\d)\d{2})-0?2-(0?[1-9]|1\d|2[0-9]))|(((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))-0?2-29-))$");
        }

        /// <summary>
        /// 判斷是否為時間HHmm
        /// </summary>
        /// <param name="pTime">傳入字串。</param>
        public static bool IsTimeHHmm(string pTime)
        {
            return Regex.IsMatch(pTime, @"^((20|21|22|23|[0-1]?\d):[0-5]?\d)$");
        }

        /// <summary>
        /// 判斷是否為時間HHmmss
        /// </summary>
        /// <param name="pTime">傳入字串。</param>
        public static bool IsTimeHHmmss(string pTime)
        {
            return Regex.IsMatch(pTime, @"^((20|21|22|23|[0-1]?\d):[0-5]?\d:[0-5]?\d)$");
        }
        

        /// <summary>
        /// 判斷是否日期+時間
        /// </summary>
        /// <param name="pDateTime"></param>
        public static bool IsDateTime(string pDateTime)
        {
            return Regex.IsMatch(pDateTime, @"^(((((1[6-9]|[2-9]\d)\d{2})-(0?[13578]|1[02])-(0?[1-9]|[12]\d|3[01]))|(((1[6-9]|[2-9]\d)\d{2})-(0?[13456789]|1[012])-(0?[1-9]|[12]\d|30))|(((1[6-9]|[2-9]\d)\d{2})-0?2-(0?[1-9]|1\d|2[0-8]))|(((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))-0?2-29-)) (20|21|22|23|[0-1]?\d):[0-5]?\d:[0-5]?\d)$ ");
        }

        public static string ToADDate(string pDate)
        {
            if (pDate == "")
                return null;

            CultureInfo culture = new CultureInfo("zh-TW");
            culture.DateTimeFormat.Calendar = new TaiwanCalendar();
            DateTime dateTime = DateTime.Parse(pDate, culture);
            var s = DateTime.Parse(pDate, culture).ToString("yyy/MM/d");
            return DateTime.Parse(pDate, culture).ToString("yyy/MM/dd");
        }

        /// <summary>
        /// 回傳yyyy/MM/dd
        /// </summary>
        /// <param name="pDate">傳入字串。</param>
        public static string ToyyyyMMdd(string pDate)
        {
            string mReturn = string.Empty;

            if (pDate != "")
            {
                mReturn = DateTime.Parse(pDate).ToString("yyyy/MM/dd");
            }
            return mReturn;
        }
        /// <summary>
        /// 回傳yyyy/MM/dd
        /// </summary>
        /// <param name="pDate">傳入字串。</param>
        public static string ToyyyyMMddHHmmss(string pDate)
        {           

            if (pDate == "")
                return null;

            return DateTime.Parse(pDate).ToString("yyy/MM/dd HH:mm:ss");

        }
        public static string toADDate(string pDate)
        {
            if (pDate == "")
                return null;

            CultureInfo culture = new CultureInfo("zh-TW");
            culture.DateTimeFormat.Calendar = new TaiwanCalendar();
            DateTime dateTime = DateTime.Parse(pDate, culture);
            var s = DateTime.Parse(pDate, culture).ToString("yyy/MM/d");
            return DateTime.Parse(pDate, culture).ToString("yyy/MM/dd");
        }
        public static string toADDateTime(string pDate)
        {
            if (pDate == "")
                return null;

            CultureInfo culture = new CultureInfo("zh-TW");
            culture.DateTimeFormat.Calendar = new TaiwanCalendar();
            DateTime dateTime = DateTime.Parse(pDate, culture);
            var s = DateTime.Parse(pDate, culture).ToString("yyy/MM/dd HH:mm:ss");
            return DateTime.Parse(pDate, culture).ToString("yyy/MM/dd HH:mm:ss");
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

}