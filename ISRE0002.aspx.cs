using Dapper;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Dynamic;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ISRE
{
    public partial class ISRE0002 : Page
    {
        public static readonly int _ConnectionTimeout = 10000;
        public static readonly IDbConnection _dbConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
        public static readonly int _PageSize = 3;
         
        //  private readonly static string ControllerName = string.Concat("/Home/");
        
        // private readonly static string Updated_RowView = "Updated_Row";
        private string RegisterMultiple = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack)
            {
                RegisterMultiple = Request["RegisterMultiple"]; 
            }
            else
            {
                RegisterMultiple = Request["RegisterMultiple"];
            } 
        }
        public dynamic Process_Read(string SPName, string GUID = "")
        {
            dynamic model = new ExpandoObject();
            try
            {
                DynamicParameters param = new DynamicParameters();

                param.Add("@GUID", GUID, DbType.String, ParameterDirection.Input);
                param.Add("@QueryMode", "R", DbType.String, ParameterDirection.Input);

                model = _dbConn.Query<dynamic>(
                   SPName,
                   param,
                   commandType: CommandType.StoredProcedure
                   , commandTimeout: _ConnectionTimeout)
                   .FirstOrDefault();

                if (model != null)
                {
                    model.IsSuccess = "Y";
                    
                }
                else  ////////// can't be inserted  for some reason, model should be returned dapperRowObject
                {
                    model.IsSuccess = "N";
                    model.Message = "系統發生錯誤";
                }
            }
            catch (Exception ex)
            {
                if (model != null)
                {
                    ////////////////model should be ExpandoObject
                    model.IsSuccess = "N";
                    if (ex == null)
                    {
                        model.IsSuccess = "Unknow Error";
                    }
                    else if (ex.Message != null)
                    {
                        model.Message = ex.Message.ToString();
                    }
                    else if (ex.InnerException != null)
                    {
                        model.Message = ex.InnerException.ToString();
                    }
                    else
                    {
                        model.Message = "Message or InnerException is null";
                    }

                } 
            }

            return model;
        }

		protected dynamic Process_ActivityInfoBySession(String GUID)
		{
			DynamicParameters param = new DynamicParameters();
			param.Add("@GUID", GUID, DbType.String, ParameterDirection.Input);
			param.Add("@QueryMode", "ActivityInfoBySession", DbType.String, ParameterDirection.Input);

			dynamic model = _dbConn.Query<dynamic>(
			"Session_ISRE_SESSION_MAIN",
			param,
			commandType: CommandType.StoredProcedure
			, commandTimeout: _ConnectionTimeout)
			.FirstOrDefault();

			return model;
		}
		protected dynamic Process_ActivityInfo(String GUID)
		{
			DynamicParameters param = new DynamicParameters();
			param.Add("@GUID", GUID, DbType.String, ParameterDirection.Input);
			param.Add("@QueryMode", "R", DbType.String, ParameterDirection.Input);

			dynamic model = _dbConn.Query<dynamic>(
			"Home_ISRE_ACTIVITY_MAIN",
			param,
			commandType: CommandType.StoredProcedure
			, commandTimeout: _ConnectionTimeout)
			.FirstOrDefault();

			return model;
		}


	}
}