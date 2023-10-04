using System;

namespace ISRE
{
    [Serializable]
    public class AjaxMessage
    {
        /// <summary>
        /// 訊息
        /// </summary>
        public string Message { get; set; }

        /// <summary>
        /// 是否成功
        /// </summary>
        public bool IsSuccess { get; set; }

        /// <summary>
        /// 轉址URL
        /// </summary>
        public string RedirectUrl { get; set; }

        /// <summary>
        /// 資料
        /// </summary>
        public object Data { get; set; }

        /// <summary>
        /// Id
        /// </summary>
        public int Id { get; set; }

        
    }
}