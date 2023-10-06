using Dapper;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Dynamic;
using System.Linq;
using System.Web.UI;

namespace ISRE
{
    public partial class ISRI0002 : Page
    {
        public static readonly int _ConnectionTimeout = 10000;
        public static readonly IDbConnection _dbConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
        public static readonly int _PageSize = 3;


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


        protected List<ISRE_SESSION_MAIN> Process_SessionList(string GUID)
        {

            DynamicParameters param = new DynamicParameters();
            param.Add("@GUID", GUID, DbType.String, ParameterDirection.Input);
            param.Add("@QueryMode", "SessionList", DbType.String, ParameterDirection.Input);

            List<ISRE_SESSION_MAIN> model =  new List<ISRE_SESSION_MAIN>();

            using (IDbConnection _dbConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
            {
                model = _dbConn.Query<ISRE_SESSION_MAIN>(
                        "Home_ISRE_ACTIVITY_MAIN",
                        param,
                        commandType: CommandType.StoredProcedure
                        , commandTimeout: _ConnectionTimeout)
                        .ToList();

            }

            return model;
        }

    }
}