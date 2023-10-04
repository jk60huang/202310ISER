using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using Dapper;
using Newtonsoft.Json;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Web.Script.Services;
using System.Collections.Generic;

namespace ISRE
{

	public partial class ISRI0004 : System.Web.UI.Page
    {
        public static readonly int _ConnectionTimeout = 10000;
        public static readonly IDbConnection _dbConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
       
		 
      
        protected void Page_Load(object sender, EventArgs e)
        {

        }



		protected ISRE_ACTIVITY_MAIN Process_ActivityInfo(String GUID)
		{
			DynamicParameters param = new DynamicParameters();
			param.Add("@GUID", GUID, DbType.String, ParameterDirection.Input);
			param.Add("@QueryMode", "R", DbType.String, ParameterDirection.Input);

			ISRE_ACTIVITY_MAIN model = _dbConn.Query<ISRE_ACTIVITY_MAIN>(
			"Home_ISRE_ACTIVITY_MAIN",
			param,
			commandType: CommandType.StoredProcedure
			, commandTimeout: _ConnectionTimeout)
			.FirstOrDefault();

			return model;
		}


		protected ISRE_SESSION_MAIN Process_SessionInfo(string GUID)
		{
			DynamicParameters param = new DynamicParameters();
			param.Add("@GUID", GUID, DbType.String, ParameterDirection.Input);
			param.Add("@QueryMode", "R", DbType.String, ParameterDirection.Input);

			ISRE_SESSION_MAIN model = _dbConn.Query<ISRE_SESSION_MAIN>(
			"Session_ISRE_SESSION_MAIN",
			param,
			commandType: CommandType.StoredProcedure
			, commandTimeout: _ConnectionTimeout)
			.FirstOrDefault();

			return model;
		}


		protected ISRE_SESSION_MAIN Process_SessionRegForm(string GUID)
		{
			DynamicParameters param = new DynamicParameters();
			param.Add("@GUID", GUID, DbType.String, ParameterDirection.Input);
			param.Add("@QueryMode", "R", DbType.String, ParameterDirection.Input);

			ISRE_SESSION_MAIN model = _dbConn.Query<ISRE_SESSION_MAIN>(
			"Session_ISRE_SESSION_REG_FORM",
			param,
			commandType: CommandType.StoredProcedure
			, commandTimeout: _ConnectionTimeout)
			.FirstOrDefault();

			return model;
		}
		
		[WebMethod]
        /////////// guid=session guid
		public static  ISRE_SESSION_REG_FORM Process_SettingForm(string formData )
		{
			DynamicParameters param = new DynamicParameters();
		//	string jsonData = JsonConvert.SerializeObject(formData);
			dynamic InputsJSON = JsonConvert.DeserializeObject<dynamic>(formData);
			foreach (var item in InputsJSON)
			{
				param.Add(String.Format("@{0}", item.Name), item.Value.ToString(), DbType.String, ParameterDirection.Input);
			}
			 
			param.Add("@QueryMode", "S", DbType.String, ParameterDirection.Input);

			ISRE_SESSION_REG_FORM model = _dbConn.Query<ISRE_SESSION_REG_FORM>(
			"Session_ISRE_SESSION_REG_FORM",
			param,
			commandType: CommandType.StoredProcedure
			, commandTimeout: _ConnectionTimeout)
			.FirstOrDefault();

			return model;
		}

		[WebMethod]
		/////////// guid=session guid
		public static string Process_Test(string test)
		{
			string result = "here"; 
			return result;
		}

	}
}