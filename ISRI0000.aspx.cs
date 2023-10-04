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
	public partial class ISRI0000 : Page
    {
        public static readonly int _ConnectionTimeout = 10000;
        public static readonly IDbConnection _dbConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
        public static readonly int _PageSize = 3;

       

        protected void Page_Load(object sender, EventArgs e)
        {

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

        protected List<ISRE_ACTIVITY_MAIN> Process_ActivityList(int Page = 1
            , int OrderIndex = 1)
        {
            DynamicParameters param = new DynamicParameters();
            param.Add("@PageSize", _PageSize, DbType.Int16, ParameterDirection.Input);
            param.Add("@Page", Page, DbType.Int16, ParameterDirection.Input);
            param.Add("@OrderIndex", OrderIndex, DbType.Int16, ParameterDirection.Input);
            param.Add("@QueryMode", "QF", DbType.String, ParameterDirection.Input);

            List<ISRE_ACTIVITY_MAIN> model = _dbConn.Query<ISRE_ACTIVITY_MAIN>(
			 "Home_ISRE_ACTIVITY_MAIN",
			param,
            commandType: CommandType.StoredProcedure
            , commandTimeout: _ConnectionTimeout)
            .ToList();

            return model;
        }

    }
}