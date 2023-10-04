using Dapper;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ISRE
{
	public partial class ISRE0000 : Page
    {
        public static readonly int _ConnectionTimeout = 10000;
        public static readonly IDbConnection _dbConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
        public static readonly int _PageSize = 3;
         
       

        public dynamic List_Activities = null;
        private dynamic List_CityList1 = null;
        private dynamic OBJ_NOList1 = null;
        private dynamic List_ACT_TYPE1 = null;

        /// <summary>
        /// DropDownList class
        /// </summary>
        /// <remarks>
        /// Creation date: 20230922 
        /// Author : Alex Huang
        /// </remarks>
        public class CboDataList
        {
            /// <summary>
            /// Conbobox名稱
            /// </summary>
            public string Cbo_Name { get; set; }
            /// <summary>
            /// Conbobox名稱
            /// </summary>
            public string Cbo_Value { get; set; }
        }


        /// <summary>
        /// Page_Load
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Page_Load(object sender, EventArgs e)
        {

            // Creation date: 20230923 By Alex Huang
            this.BtnQuery.ServerClick += new EventHandler(BtnQuery_Click);  // 將 HTML 伺服器控制 變成 ASP.NET 伺服器控制項 加ServerClick 事件
            // Creation date: 20230923 By Alex Huang

            //  Modification date : 20230926 By Alex Huang
            if (!CheckDBConn())
            {                
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "message", "<script language='javascript' defer>alert('Oops 連線失敗，請通知管理人員!');</script>");
                return;
            }
            else
            {
                GetData();

            }
            //  Modification date : 20230926 By Alex Huang

            

            if (!this.IsPostBack)
            {
                //  Modification date : 20230926 By Alex Huang
                BindDropDownList();
                //  Modification date : 20230926 By Alex Huang

                //  Modification date : 20230923 By Alex Huang
                    SearchResult.Visible = false;   // 查詢結果
                    SearchCriteria.Visible = false; // 搜尋條件                           
                //  Modification date : 20230923,20230928 By Alex Huang

            }
            else
            {
                // Creation date: 20230928 By Alex Huang
                var IsValueToFindWebElementValue = IsValueToFindWebElement();
                // Creation date: 20230928 By Alex Huang

                //  Modification date : 20230923,20230928 By Alex Huang
                SearchResult.Visible = (IsValueToFindWebElementValue == true);    // 查詢結果
                SearchCriteria.Visible = (IsValueToFindWebElementValue == true);  // 搜尋條件
                //  Modification date : 20230923,20230928 By Alex Huang
            }
        }


        /// <summary>
        /// StaticQueryDB
        /// </summary>
        /// <param name="SPName">程序名稱</param>
        /// <param name="QueryMode">QueryMode名稱</param>
        /// <returns></returns>
        /// <remarks>
        /// Modification date : 20230925
        /// Modifier :Alex Huang
        /// </remarks> 
        //protected static List<dynamic> StaticQueryDB(string SPName, string QueryMode)
        //{
        //    DynamicParameters param = new DynamicParameters();
        //    param.Add("@QueryMode", QueryMode, DbType.String, ParameterDirection.Input);

        //    try
        //    {
        //        List<dynamic> result = 
        //            _dbConn.Query<dynamic>(
        //                SPName,
        //                param,
        //                commandType: CommandType.StoredProcedure
        //            , commandTimeout: _ConnectionTimeout
        //           )
        //        .ToList();
        //        return result;
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex.GetBaseException();
        //    }
        //    finally
        //    {
        //        _dbConn.Close();
        //    }
        //}

        /// <summary>
        /// Process_ActivityList
        /// </summary>
        /// <param name="Page"></param>
        /// <param name="OrderIndex"></param>
        /// <returns></returns>
        /// <remarks>
        /// Modification date : 20230925
        /// Modifier :Alex Huang
        /// </remarks> 
        //protected List<dynamic> Process_ActivityList(int Page = 1
        //    , int OrderIndex = 1)
        //{
        //    DynamicParameters param = new DynamicParameters();
        //    param.Add("@PageSize", _PageSize, DbType.Int16, ParameterDirection.Input);
        //    param.Add("@Page", Page, DbType.Int16, ParameterDirection.Input);
        //    param.Add("@OrderIndex", OrderIndex, DbType.Int16, ParameterDirection.Input);
        //    param.Add("@QueryMode", "QF", DbType.String, ParameterDirection.Input);

        //    try
        //    {

        //        List<dynamic> model = _dbConn.Query<dynamic>(
        //            SPName,
        //            param,
        //            commandType: CommandType.StoredProcedure
        //            , commandTimeout: _ConnectionTimeout
        //        )
        //        .ToList();

        //        return model;
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex.GetBaseException();
        //    }
        //    finally
        //    {
        //        _dbConn.Close();
        //    }
        //}



        /// <summary>
        /// 取資料
        /// </summary>
        /// <returns>true(連線成功)/false(連線失敗)</returns>
        /// <remarks>
        /// Creation date: 20230927
        /// Author : Alex Huang
        /// </remarks>
        private void GetData()
        {
            List_CityList1 = GetQueryDB("Home_ISRE_ACTIVITY_MAIN", "CityList");
            OBJ_NOList1 = GetQueryDB("Home_ISRE_ACTIVITY_MAIN", "OBJ_NO");
            List_ACT_TYPE1 = GetQueryDB("Home_ISRE_ACTIVITY_MAIN", "ACT_TYPE");
            List_Activities = GetProcess_ActivityList(1, 1);
        }


        /// <summary>
        /// Process_ActivityList
        /// </summary>
        /// <param name="Page"></param>
        /// <param name="OrderIndex"></param>
        /// <returns></returns>
        /// <remarks>
        /// Modification date : 20230925、20230927
        /// Modifier :Alex Huang
        /// </remarks> 
        protected List<dynamic> GetProcess_ActivityList(int Page = 1
            , int OrderIndex = 1)
        {
            DynamicParameters param = new DynamicParameters();
            param.Add("@PageSize", _PageSize, DbType.Int16, ParameterDirection.Input);
            param.Add("@Page", Page, DbType.Int16, ParameterDirection.Input);
            param.Add("@OrderIndex", OrderIndex, DbType.Int16, ParameterDirection.Input);
            param.Add("@QueryMode", "QF", DbType.String, ParameterDirection.Input);

            try
            {

                List<dynamic> model = _dbConn.Query<dynamic>(
				   "HOME_ISRE_ACTIVITY_MAIN",
					param,
                    commandType: CommandType.StoredProcedure
                    , commandTimeout: _ConnectionTimeout
                )
                .ToList();

                return model;
            }
            catch 
            {
                List<dynamic> result = new List<dynamic>();
                return result;
            }
            finally
            {
                _dbConn.Close();
            }
        }

        /// <summary>
        /// 判斷資料庫是否連線?
        /// </summary>
        /// <returns>true(連線成功)/false(連線失敗)</returns>
        /// <remarks>
        /// Creation date: 20230926
        /// Author : Alex Huang
        /// </remarks>
        private Boolean CheckDBConn()
        {
            try
            {
                _dbConn.Open();  

                if (_dbConn.State == ConnectionState.Open)
                {
                    return true;
                }
                return false;
            }
            catch
            {
               return false;
            }


        }

        /// <summary>
        /// 組成下拉式
        /// </summary>
        /// <remarks>
        /// Creation date: 20230922 
        /// Author : Alex Huang
        /// Modification date : 20230926、20230927
        /// Modifier :Alex Huang
        /// </remarks>
        private void BindDropDownList() 
        {

            List<CboDataList> lis_DataList = new List<CboDataList>();

            // 預設值
            CboDataList DefaultVal = new CboDataList
            {
                Cbo_Value = "",
                Cbo_Name = "請選擇"
            };

            // ddlCityList
            lis_DataList.Add(DefaultVal);

            if (List_CityList1 != null)
            { 
                 foreach (var item in List_CityList1)
                 {
                     CboDataList comObj1 = new CboDataList
                     {
                         Cbo_Value = item.CityNo,
                         Cbo_Name = item.CityName
                     };
                     lis_DataList.Add(comObj1);
                 }                       
            }

            SESS_LOC.DataSource = lis_DataList;
            SESS_LOC.DataTextField = "Cbo_Name";
            SESS_LOC.DataValueField = "Cbo_Value";
            SESS_LOC.DataBind();

            // ddlNOList
            lis_DataList = new List<CboDataList>
            {
                DefaultVal
            };

            if (OBJ_NOList1 != null)
            {
                foreach (var item in OBJ_NOList1)
                {
                    CboDataList comObj1 = new CboDataList
                    { //SerialID
                        Cbo_Value = item.SerialID.ToString(),
                        Cbo_Name = item.OBJ_NO_NAME
                    };
                    lis_DataList.Add(comObj1);
                }

            }
            OBJ_NO.DataSource = lis_DataList;
            OBJ_NO.DataTextField = "Cbo_Name";
            OBJ_NO.DataValueField = "Cbo_Value";
            OBJ_NO.DataBind();

            // ddlActTypeList
            lis_DataList = new List<CboDataList>
            {
                DefaultVal
            };


            if (List_ACT_TYPE1 != null)
            {
                foreach (var item in List_ACT_TYPE1)
                {
                    CboDataList comObj1 = new CboDataList
                    { //SerialID
                        Cbo_Value = item.SerialID.ToString(),
                        Cbo_Name = item.TYPE_NAME
                    };
                    lis_DataList.Add(comObj1);
                }
            }

            ACT_TYPE.DataSource = lis_DataList;
            ACT_TYPE.DataTextField = "Cbo_Name";
            ACT_TYPE.DataValueField = "Cbo_Value";
            ACT_TYPE.DataBind();

        }



        /// <summary>
        /// 取搜尋條件相關欄位
        /// </summary>
        /// <remarks>
        /// Creation date: 20230922 
        /// Author : Alex Huang
        /// </remarks>
        private void GetFieID()
        {
            ContentPlaceHolder PageNow;

            string StrLabel = string.Empty;
            
            string ComSearchCriteriaData = string.Empty;

            PageNow = (ContentPlaceHolder)Master.FindControl("MainContent");

            foreach (Control myControl in PageNow.Controls)
            {
                if (myControl is DropDownList)
                {
                    DropDownList dropDownList = myControl as DropDownList;
                    if (dropDownList != null)
                    {
                        var dropDownListID = dropDownList.ID;
                        
                        DropDownList ddlDept = (DropDownList)Master.FindControl("MainContent").FindControl(dropDownListID);

                        var svalue = ddlDept.SelectedValue;

                        if (svalue != "")
                        {
                            ComSearchCriteriaData += CombineSearchCriteriaData(ddlDept.SelectedItem.Text);
                        }
                    }
                }

                if (myControl is TextBox)
                { 
                    TextBox textBox = (TextBox)myControl;
                    if (textBox != null) 
                    { 
                        var textBoxValue = textBox.Text;

                        if (textBoxValue != "")
                        {
                            ComSearchCriteriaData += CombineSearchCriteriaData(textBoxValue);
                        }
                    }
                }                
            }

            var tmpDate = Request.Form["ACT_DATE_S_DATE"].ToString();
            ComSearchCriteriaData += (tmpDate.Trim().Length ==0) ? "": CombineSearchCriteriaData(tmpDate);
            tmpDate = Request.Form["ACT_DATE_E_DATE"].ToString();
            ComSearchCriteriaData += (tmpDate.ToString().Trim().Length == 0) ? "" : CombineSearchCriteriaData(tmpDate.ToString());            
            LiteralSearchCriteriaData.Text = ComSearchCriteriaData;
        }

        /// <summary>
        /// 組合搜尋條件資料
        /// </summary>
        /// <param name="SearchCriteriaDatas">搜尋條件資料</param>
        /// <returns>回傳HTML文字</returns>
        /// <remarks>
        /// Creation date: 20230922 
        /// Author : Alex Huang
        /// </remarks>
        public static string CombineSearchCriteriaData(string SearchCriteriaDatas ="")
        { 
            string result = string.Empty;
           
            if(SearchCriteriaDatas.Trim() != string.Empty)
            {
                result = String.Format("<span class=\"badge bg-secondary  \">{0}</span>&nbsp;", SearchCriteriaDatas);
            }

            return result;
        }



        /// <summary>
        /// StaticQueryDB
        /// </summary>
        /// <param name="SPName">程序名稱</param>
        /// <param name="QueryMode">QueryMode名稱</param>
        /// <returns></returns>
        /// <remarks>
        /// Modification date : 20230925
        /// Modifier :Alex Huang
        /// </remarks> 
        protected static List<dynamic> GetQueryDB(string SPName, string QueryMode)
        {
            DynamicParameters param = new DynamicParameters();
            param.Add("@QueryMode", QueryMode, DbType.String, ParameterDirection.Input);

            try
            {
                List<dynamic> result =
                    _dbConn.Query<dynamic>(
                        SPName,
                        param,
                        commandType: CommandType.StoredProcedure
                    , commandTimeout: _ConnectionTimeout
                   )
                .ToList();
                return result;
            }
            //catch (Exception ex)
            //{
            //    throw ex.GetBaseException();
            //}
            catch
            {
                List<dynamic> result = new List<dynamic>();
                return result;
            }
            finally
            {
                _dbConn.Close();
            }
        }

        /// <summary>
        /// 檢查下拉、文字盒是否有值?
        /// </summary>
        /// <returns>ture(有值)/flase(無值)</returns>
        /// <remarks>
        /// Creation date: 20230928
        /// Author : Alex Huang
        /// </remarks>
        private Boolean IsValueToFindWebElement()
        {
            //Boolean Result = false;
            int IsValue = 0;

            ContentPlaceHolder PageNow;

            PageNow = (ContentPlaceHolder)Master.FindControl("MainContent");

            foreach (Control myControl in PageNow.Controls)
            {
                if (myControl is DropDownList)
                {
                    DropDownList dropDownList = myControl as DropDownList;
                    if (dropDownList != null)
                    {
                        var dropDownListID = dropDownList.ID;

                        DropDownList ddlDept = (DropDownList)Master.FindControl("MainContent").FindControl(dropDownListID);

                        var svalue = ddlDept.SelectedValue;

                        if (svalue != "")
                        {
                            IsValue++;
                        }
                    }
                }

                if (myControl is TextBox)
                {
                    TextBox textBox = (TextBox)myControl;
                    if (textBox != null)
                    {
                        var textBoxValue = textBox.Text;

                        if (textBoxValue != "")
                        {
                            IsValue++;
                        }
                    }
                }
            }

            //var tmpDate = Request.Form["ACT_DATE_S_DATE"].ToString().Length;

            var tmpDate = (Request.Form["ACT_DATE_S_DATE"] == null)? 0: Request.Form["ACT_DATE_S_DATE"].ToString().Length;

            if (tmpDate > 0)
            {
                IsValue++;
            }

            //tmpDate = Request.Form["ACT_DATE_E_DATE"].ToString().Length;
            tmpDate = (Request.Form["ACT_DATE_E_DATE"] == null) ? 0 : Request.Form["ACT_DATE_E_DATE"].ToString().Length;
           

            if (tmpDate > 0)
            {
                IsValue++;
            }

            //Result = (IsValue == 0) ? false:  true;

            return IsValue != 0;
        }

        /// <summary>
        /// 查詢按鈕
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        /// <remarks>
        /// Creation date: 20230922 
        /// Author : Alex Huang
        /// </remarks>
        protected void BtnQuery_Click(object sender, EventArgs e)
        {
            GetFieID();
        }





    }

}