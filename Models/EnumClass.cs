using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace ISRE
{
	/// <summary>
	/// /////////// this is for update/insert
	/// </summary>
	public enum Enum_REG_STATUS
    {
        [Description("已填寫報名表(線上正取"), Display(Name="已填寫報名表(線上正取")]
        Register_Official =10,
        [Description("已填寫報名表(線上候補"), Display(Name = "已填寫報名表(線上候補)")]
        Register_Backup = 11,
        [Description("已完成報名(確認信)"), Display(Name = "已確認")]
        Register_Confirmed = 20,
        [Description("已完成報名(後臺)"), Display(Name = "已完成報名(後臺)")]
        Register_Backend = 21,
        [Description("已報到(掃碼、線上)"), Display(Name = "已報到(掃碼、線上)")]
        CheckIn_Frontend = 30,
        [Description("已報到(負責人)"), Display(Name = "已報到(負責人)")]
        CheckIn_Backend = 31,
        [Description("取消報名(線上)"), Display(Name = "取消報名(線上)")]
        Cancel_Frontend = 40,
        [Description("取消報名(後臺)"), Display(Name = "取消報名(後臺)")]
        Cancel_Backend = 41
//        10:已填寫報名表(線上正取)
//11:已填寫報名表(線上候補)
//20:已完成報名(確認信)
//21:已完成報名(後臺)
//30:已報到(掃碼、線上)
//31:已報到(負責人)
//40:取消報名(線上)
//41:取消報名(後臺) 

    }

	public enum Enum_AttendCategory
	{
		[Description("未確認"), Display(Name = "未確認")]
		 Unconfirm = 0,
		[Description("已確認"), Display(Name = "已確認")]
		 Confirmed = 1 ,
		[Description("已報到"), Display(Name = "已報到")]
		 Attended = 2   
	}


	public enum  Enum_SessionFlow
	{ 
		[Description("場次建立"), Display(Name = "場次建立")]
		Session = 1,
		[Description("報名表設定"), Display(Name = "報名表設定")]
		RegistrationForm = 2,
		[Description("場次傳送"), Display(Name = "場次傳送")]
		Activate = 3
	}

	public enum Enum_REG_TYPE
    {
        [Description("個人"), Display(Name = "單位")]
        Personal = 1,
        [Description("單位"), Display(Name = "單位")]
        Unit = 2  
    }
    public enum Enum_Register 
    {
        [Description("單人"), Display(Name = "單人")]
        Single = 0,
        [Description("多人"), Display(Name = "多人")]
        Multiple=1,
		[Description("候補"), Display(Name = "候補")]
		Backup = 2
	}


    public enum Enum_AttachmentCategory
    {
        [Description("視覺圖檔"), Display(Name = "視覺圖檔")]
        Banner = 1,
        [Description("活動資料"), Display(Name = "活動資料")]
        SessionInfo = 2,
        [Description("活動上傳資料"), Display(Name = "活動上傳資料")]
        SessionUploadInfo = 3
    }






	 




	public enum Enum_Dispaly_Required
    { 
        [Description("顯示"), Display(Name = "顯示")]
        Dispaly = 1,
        [Description("必填"), Display(Name = "必填")]
        Required = 2,
        [Description("必填且顯示"), Display(Name = "必填且顯示")]
        DispalyNRequired = 3
    }
    public enum Enum_YesNo
    {
        [Description("Yes"), Display(Name = "Yes")]
        Yes = 1,
        [Description("No"), Display(Name = "No")]
        No = 2 
    }
    public enum Enum_OBJ_NO
    {
        [Description("ISR"), Display(Name = "ISR")]
        ISR = 3
    }
}