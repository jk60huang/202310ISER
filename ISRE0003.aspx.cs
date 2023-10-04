using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dapper;

namespace ISRE
{

    public partial class ISRE0003 : Page
    {
        public static readonly int _ConnectionTimeout = 10000;
        public static readonly IDbConnection _dbConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
        public static readonly int _PageSize = 3; 
        
        protected void Page_Load(object sender, EventArgs e)
        {
           

		}
        protected   dynamic  Process_ActivityInfo(String GUID)
        {
            GUID = Request.QueryString["GUID"];
             
            DynamicParameters param = new DynamicParameters();
            param.Add("@GUID", GUID, DbType.String, ParameterDirection.Input);
            param.Add("@QueryMode", "SessionList", DbType.String, ParameterDirection.Input);

            dynamic  model = _dbConn.Query<dynamic>(
            "Home_ISRE_ACTIVITY_MAIN",
            param,
            commandType: CommandType.StoredProcedure
            , commandTimeout: _ConnectionTimeout)
            .FirstOrDefault();

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

        protected List<dynamic> Process_SessionList(string GUID)
        {
            
            DynamicParameters param = new DynamicParameters();
            param.Add("@GUID", GUID, DbType.String, ParameterDirection.Input);
            param.Add("@QueryMode", "SessionList", DbType.String, ParameterDirection.Input);

            List<dynamic> model = _dbConn.Query<dynamic>(
            "Home_ISRE_ACTIVITY_MAIN",
            param,
            commandType: CommandType.StoredProcedure
            , commandTimeout: _ConnectionTimeout)
            .ToList();

            return model;
        }
        protected dynamic Process_Session(string GUID)
        {
            DynamicParameters param = new DynamicParameters();
            param.Add("@GUID", GUID, DbType.String, ParameterDirection.Input);
            param.Add("@QueryMode", "R", DbType.String, ParameterDirection.Input);

            dynamic model = _dbConn.Query<dynamic>(
            "Session_ISRE_SESSION_MAIN",
            param,
            commandType: CommandType.StoredProcedure
            , commandTimeout: _ConnectionTimeout)
            .FirstOrDefault();

            return model;
        }

    }
}