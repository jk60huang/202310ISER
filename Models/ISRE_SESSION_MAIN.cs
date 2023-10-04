using System;

namespace ISRE
{
    /// <summary>
    /// /////////// this is for update/insert
    /// </summary>
    public class ISRE_SESSION_MAIN
    {
        public string SESS_SEQ_NO { get; set; }
        public string ACT_SEQ_NO { get; set; }
		public string SESS_SERIAL_NO { get; set; }
		
		public string SESS_STATUS { get; set; }
        public string SESS_NO { get; set; }
        public string SESS_LOC { get; set; }
        public DateTime SESS_DATE_S  { get; set; } 
        public DateTime SESS_DATE_E { get; set; } 

        public DateTime REG_DATE_S { get; set; }
        public DateTime REG_DATE_E { get; set; }
        
        public DateTime CHK_DATE_S  { get; set; } 
        public DateTime CHK_DATE_E  { get; set; } 
        public string REG_MAX_COUNT { get; set; }
        public string WAIT_NAX_COUNT { get; set; }
        public string UNIT_NAX_COUNT { get; set; }
        public string OBJ_NO { get; set; }
        public string OBJ_DESC { get; set; }
        public string SESS_HOST { get; set; }
        public string SESS_CO_HOST { get; set; }
        public string SESS_CONTACT_INFO { get; set; }
        public string VIDEO_LINK { get; set; }
        public string ATTACH_VIDEO_LINK { get; set; }
        public string CONFIRM_MAIL { get; set; }
        public string SUCCESS_MAIL { get; set; }
        public string WAIT_MAIL { get; set; }
        public string REMIND_MAIL { get; set; }
        public string REMIND_MAIL_ENABLE { get; set; }
        public DateTime REMIND_MAIL_DATE { get; set; }
        public DateTime REMIND_MAIL_TIME { get; set; }
        public DateTime TXT_DATE { get; set; }
        public string TXT_USER_ID { get; set; }
         
        public string GUID { get; set; } 

    }
}