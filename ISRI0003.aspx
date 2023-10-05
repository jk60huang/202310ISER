<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="ISRI0003.aspx.cs"
    Inherits="ISRE.ISRI0003" %>

<%--this page is for backend session create/edit--%>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        /*.custom-file {
    position: relative;
    display: inline-block;
    width: 100%;
    height: calc(2.25rem + 2px);
    margin-bottom: 0;
}
.custom-file-input {
    position: relative;
    z-index: 2;
    width: 100%;
    height: calc(2.25rem + 2px);
    margin: 0;
    opacity: 0;
}
.custom-file-label {
    position: absolute;
    top: 0;
    right: 0;
    left: 0;
    z-index: 1;
    height: calc(2.25rem + 2px);
    padding: 0.375rem 0.75rem;
    font-weight: 400;
    line-height: 1.5;
    color: #495057;
    background-color: #fff;
    border: 1px solid #ced4da;
    border-radius: 0.25rem;
}
.custom-control-label::before, .custom-file-label, .custom-select {
    transition: background-color .15s ease-in-out,border-color .15s ease-in-out,box-shadow .15s ease-in-out;
}
.custom-file-input:disabled, .custom-file-input[readonly] {
    background-color: #e1e1e2;
    opacity: 1;
    border-color: #e1e1e2;
}
 
.custom-file-label::after {
    position: absolute;
    top: 0;
    right: 0;
    bottom: 0;
    z-index: 3;
    display: block;
    height: 2.25rem;
    padding: 0.375rem 0.75rem;
    line-height: 1.5;
    color: #495057;
    content: "瀏覽";*/
        /* background-color: #e9ecef;*/
        /*background-color: gold;
    border-left: inherit;
    border-radius: 0 0.25rem 0.25rem 0;
    cursor: pointer;
}*/
    </style>

    <main aria-labelledby="title">
        
        <div class=" my-2">
            
            <div id="ActivityInfo" runat="server">
                <!-- #Include virtual="ISRI_ActivityInfo.aspx" -->
            </div>

            <div id="ISRI_SessionFlow" runat="server">
                <!-- #Include virtual="ISRI_SessionFlow.aspx" -->
            </div>

            <%--session   start  --%>
            <h3 class="text-center mt-5 mb-2"><%: String.Concat(ActioinName, "場次資訊") %> </h3>

            <div class="m-2 p-2">

                <%   
                    if (Model != null)
                    { %>
                <div class="   row      ">
                    <div class=" bg-ice   py-3   col-lg-2 border">
                        <b>
                            <label>場次 </label>
                        </b>
                    </div>
                    <div class="  py-3   col-lg-10 border">
                        <input type="text" name="SESS_NO" id="SESS_NO"
                            class="form-control mx-1 " readonly disabled
                            value="<%: (Model !=null &&  Model.SESS_NO!=null)
                          ? Model.SESS_NO
                          : "" %>">
                    </div>
                </div>
                <%    }  %>


                <div class="  row     ">
                    <div class=" bg-ice  py-3  col-lg-2 border  ">
                        <span class="note">*</span><b><label>日期時間 </label>
                        </b>
                    </div>
                    <div class="  py-3   col-lg-10 border">
                        <div class="d-flex">
                            <input type="text" id="SESS_DATE_S_DATE" name="SESS_DATE_S_DATE"
                                class="form-control mx-1 requiredInput"
                                placeholder="民國年/月/日">
                            <input type="time" id="SESS_DATE_S_TIME" name="SESS_DATE_S_TIME"
                                placeholder="HH:mm"
                                class="form-control mx-1 requiredInput">
                            <input type="hidden" id="SESS_DATE_S" name="SESS_DATE_S"
                                value="<%: (Model !=null &&  Model.SESS_DATE_S!=null
                      ? Model.SESS_DATE_S 
                      : DateTime.Now )  %>" />
                            <span>~ </span>
                            <input type="text" id="SESS_DATE_E_DATE" name="SESS_DATE_E_DATE"
                                class="form-control mx-1 requiredInput"
                                placeholder="民國年/月/日">

                            <input type="time" id="SESS_DATE_E_TIME" name="SESS_DATE_E_TIME"
                                placeholder="HH:mm" class="form-control mx-1 requiredInput">
                            <input type="hidden" id="SESS_DATE_E" name="SESS_DATE_E"
                                value="<%: (Model !=null &&  Model.SESS_DATE_E!=null
                         ? Model.SESS_DATE_E 
                         : DateTime.Now )  %>" />
                        </div>
                    </div>
                </div>

                <div class="  row     ">
                    <div class=" bg-ice   py-3  col-lg-2 border  ">
                        <span class="note">*</span>
                        <label>地點 </label>
                    </div>
                    <div class="  py-3   col-lg-10 border">
                        <div>
                            <select name="SESS_LOC" id="SESS_LOC" class="form-control form-select">
                                <option value="">請選擇</option>
                                <% 
                                    //dynamic SESS_LOC = Request["SESS_LOC"] ?? "";
                                    //dynamic List_CityList = StaticQueryDB("Home_ISRE_ACTIVITY_MAIN", "CityList");
                                    foreach (var item in List_CityList)
                                    {
                                        sSelected = (SESS_LOC.ToString() == item.CityNo.ToString()) ? "selected" : "";
                                %>
                                <option value="<%: item.CityNo %>" <%: sSelected %>><%: item.CityName %> </option>
                                <%
                                    }
                                %>
                            </select>


                        </div>
                    </div>
                </div>

                <div class="  row     ">
                    <div class=" bg-ice   py-3  col-lg-2 border  ">
                        <span class="note">*</span>
                        <label>報名期間</label>
                    </div>
                    <div class="  py-3   col-lg-10 border">
                        <div class="d-flex">
                            <input type="text" id="REG_DATE_S" name="REG_DATE_S"
                                placeholder="民國年/月/日" class="form-control  mx-1 requiredInput"
                                value="<%: (Model !=null &&  Model.REG_DATE_S!=null
                         ? String.Concat(
							 (int.Parse(Model.REG_DATE_S.ToString("yyyy")) -1911).ToString() ,
							 "/", Model.REG_DATE_S.ToString("MM"), "/", Model.REG_DATE_S.ToString("dd"))
                         : ""  )  %>">
                            <span>~</span>
                            <input type="text" id="REG_DATE_E" name="REG_DATE_E"
                                placeholder="民國年/月/日" class="form-control  mx-1 requiredInput"
                                value="<%: (Model !=null &&  Model.REG_DATE_E!=null
                        ? String.Concat(
							 int.Parse(Model.REG_DATE_E.ToString("yyyy")) -1911 ,
							 "/", Model.REG_DATE_E.ToString("MM"), "/", Model.REG_DATE_E.ToString("dd"))
                        : ""  )  %>">
                        </div>
                    </div>
                </div>
                <div class="  row     ">
                    <div class=" bg-ice  py-3  col-lg-2 border  ">
                        <span class="note">*</span>
                        <label>報到時間 </label>
                    </div>
                    <div class="  py-3   col-lg-10 border">
                        <div class="d-flex">
                            <input type="text" id="CHK_DATE_S_DATE" name="CHK_DATE_S_DATE"
                                placeholder="民國年/月/日" class="form-control  mx-1 requiredInput"
                                value="<%: (Model !=null &&  Model.CHK_DATE_S !=null
                     ? Model.CHK_DATE_S.ToString("yyyy-MM-dd") 
                     : ""  )  %>">
                            <input type="time" id="CHK_DATE_S_TIME" name="CHK_DATE_S_TIME" placeholder="HH:mm" class="form-control mx-1 requiredInput"
                                value="<%: (Model !=null &&  Model.CHK_DATE_S!=null
                        ? Model.CHK_DATE_S.ToString("HH:mm")  
                        : ""  )  %>">
                            <span>~</span>
                            <input type="text" id="CHK_DATE_E_DATE" name="CHK_DATE_E_DATE" placeholder="民國年/月/日" class="form-control  mx-1 requiredInput"
                                value="<%: (Model !=null &&  Model.CHK_DATE_E!=null
                        ? Model.CHK_DATE_E.ToString("yyyy-MM-dd") 
                        : ""  )  %>">
                            <input type="time" id="CHK_DATE_E_TIME" name="CHK_DATE_E_TIME" placeholder="HH:mm" class="form-control mx-1 requiredInput"
                                value="<%: (Model !=null &&  Model.CHK_DATE_E!=null
                         ? Model.CHK_DATE_E.ToString("HH:mm")  
                         : ""  )  %>">
                        </div>
                    </div>
                </div>
                <div class="  row     ">
                    <div class=" bg-ice   py-3  col-lg-2 border  ">
                        <span class="note">*</span>
                        <label>主辦單位</label>
                    </div>
                    <div class="  py-3   col-lg-10 border">
                        <div>
                            <input type="text" class="form-control  mx-1 requiredInput"
                                id="SESS_HOST" name="SESS_HOST"
                                value="<%: (Model !=null &&  Model.SESS_HOST!=null
                     ? Model.SESS_HOST : ""  )  %>">
                        </div>
                    </div>
                </div>
                <div class="  row     ">
                    <div class=" bg-ice  py-3  col-lg-2 border  ">
                        <label>協辦單位</label>
                    </div>
                    <div class="  py-3   col-lg-10 border">
                        <div>
                            <input type="text" class="form-control  mx-1  " id="SESS_CO_HOST" name="SESS_CO_HOST"
                                value="<%: (Model !=null &&  Model.SESS_CO_HOST!=null
                        ? Model.SESS_CO_HOST : ""  )  %>">
                        </div>
                    </div>
                </div>
                <div class="  row     ">
                    <div class="bg-ice   py-3  col-lg-2 border  ">
                        <span class="note">*</span>
                        <label>洽詢專線</label>
                    </div>
                    <div class="  py-3   col-lg-10 border">
                        <div>
                            <input type="text" class="form-control  mx-1 requiredInput"
                                id="SESS_CONTACT_INFO" name="SESS_CONTACT_INFO"
                                value="<%: (Model !=null &&  Model.SESS_CONTACT_INFO!=null
                        ? Model.SESS_CONTACT_INFO : ""  )  %>">
                        </div>
                    </div>
                </div>
                <div class="  row     ">
                    <div class=" bg-ice   py-3  col-lg-2 border  ">
                        <label>報名⼈數上限</label>
                    </div>
                    <div class="  py-3   col-lg-10 border">
                        <div>
                            <input type="number" class="form-control  mx-1  "
                                id="REG_MAX_COUNT" name="REG_MAX_COUNT"
                                value="<%: (Model !=null &&  Model.REG_MAX_COUNT!=null
                        ? Model.REG_MAX_COUNT : ""  )  %>">
                        </div>
                    </div>
                </div>
                <div class="  row     ">
                    <div class=" bg-ice   py-3  col-lg-2 border  ">
                        <label>候補⼈數</label>
                    </div>
                    <div class="  py-3   col-lg-10 border">
                        <div>
                            <input type="number" class="form-control  mx-1  "
                                id="WAIT_NAX_COUNT" name="WAIT_NAX_COUNT"
                                value="<%: (Model !=null &&  Model.WAIT_NAX_COUNT!=null
                    ? Model.REG_MAX_COUNT : ""  )  %>">
                        </div>
                    </div>
                </div>
                <div class="  row     ">
                    <div class=" bg-ice   py-3  col-lg-2 border  ">
                        <label>單位報名⼈數上限</label>
                    </div>
                    <div class="  py-3   col-lg-10 border">
                        <div>
                            <input type="number" class="form-control  mx-1  "
                                id="UNIT_NAX_COUNT" name="UNIT_NAX_COUNT"
                                value="<%: (Model !=null &&  Model.UNIT_NAX_COUNT!=null
                        ? Model.UNIT_NAX_COUNT : ""  )  %>">
                        </div>
                    </div>
                </div>

                <div class="  row     ">
                    <div class=" bg-ice  py-3  col-lg-2 border  ">
                        <label>設定議程</label>
                    </div>
                    <div class="  py-3   col-lg-10 border">
                        <div>
                            <table class="table  ">
                                <thead>
                                    <tr class="bg-ice">
                                        <th class="left ps-2">時間</th>
                                        <th class="left ps-2">內容</th>
                                        <th class="right pe-4">刪除</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr class=" ">
                                        <!--<td><input type="datetime-local" class="medium"></td>-->
                                        <td>
                                            <div class="d-flex">
                                                <input type="text" class="form-control    "
                                                    id="sch_s_datepicker" placeholder="民國年/月/日">
                                                <input type="time" placeholder="HH:mm" class="form-control">
                                                <span>~</span>
                                                <%--<input type="text" id="sch_e_datepicker"
													class="form-control  " placeholder="民國年/月/日">--%>
                                                <input type="time" placeholder="HH:mm" class="form-control">
                                            </div>

                                        </td>
                                        <td>
                                            <textarea name="" id="" cols="30" rows="2" class="form-control"></textarea></td>
                                        <td class="right"><a href="#" class="btn btn-primary-isre  ">刪除</a></td>
                                    </tr>
                                </tbody>
                            </table>
                            <div class="d-flex">
                                <a href="#" class="btn btn-primary-isre px-4">+新增議程</a>
                            </div>
                        </div>
                    </div>
                </div>

                <%--  @*上傳活動資料*@--%>
                <div class="  row     ">
                    <div class="bg-ice  py-3  col-lg-2 border  ">
                        <label>上傳資料</label>
                    </div>
                    <div class="  py-3   col-lg-10 border">
                        <div class="d-flex">
                            <%--	<a href="#" class="btn btn-primary-isre px-5">選擇檔案</a>--%>

                            <input type="file" id="fileUpload" name="fileUpload"
                                class="form-control-file border   ">
                        </div>
                        <div>
                            <table class="table  ">
                                <thead>
                                    <tr>
                                        <th class="left ps-2">檔名</th>
                                        <th class="left ps-2">檔案大小</th>
                                        <th class="right pe-4">刪除</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>
                                            <div class="d-flex">
                                                交通資訊.pdf
                                            </div>

                                        </td>
                                        <td>1.35MB </td>
                                        <td class="right"><a href="#" class="btn btn-primary-isre  ">刪除</a></td>
                                    </tr>
                                </tbody>
                            </table>

                        </div>
                    </div>
                </div>

                <div class="  row     ">
                    <div class=" bg-ice   py-3  col-lg-2 border  ">
                        <label>上傳單位限定資料</label>
                    </div>
                    <div class="  py-3   col-lg-10 border">
                        <div>

                            <div class="table-wrap">
                                <div class="note-b">
                                    1.若無上傳資料，表此場次未限定特定參加單位。
									<br>
                                    2.若已有資料且再次上傳，則以最後⼀次上傳的資料為單位限定清單。<br>
                                    3.「投保單位代號」、「醫療院所代號」、「統⼀編號」及「指定單位代號」擇⼀匯入。<br>
                                    4.副檔名為.xlsx或.csv檔。<br>
                                    5.檔案欄位依序為「單位名稱」、「單位代號」及「單位報名⼈數上限」。
                                </div>

                                <div class="d-flex">
                                    <%--		<a href="#" class="btn btn-primary-isre px-5">選擇檔案</a>--%>
                                    <input id="fileRestricted" name="fileRestricted"
                                        type="file" class="form-control-file border   ">
                                </div>
                                <div>
                                    <table class="table  ">
                                        <thead>
                                            <tr>
                                                <th class="left ps-2">檔名</th>
                                                <th class="left ps-2">檔案大小</th>
                                                <th class="right pe-4">刪除</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>
                                                    <div class="d-flex">
                                                        交通資訊.pdf
                                                    </div>

                                                </td>
                                                <td>1.35MB </td>
                                                <td class="right">
                                                    <a href="#" class="btn btn-primary-isre ">刪除</a>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>

                                </div>

                            </div>
                        </div>
                    </div>
                </div>

                <div class="  row     ">
                    <div class="bg-ice   py-3  col-lg-2 border  ">
                        <label>視訊會議</label>
                    </div>
                    <div class="  py-3   col-lg-10 border">
                        <div>

                            <div>視訊連結</div>
                            <input type="text" class="form-control  mx-1  "
                                id="VIDEO_LINK" name="VIDEO_LINK"
                                value="<%: (Model !=null &&  Model.VIDEO_LINK!=null
                        ? Model.VIDEO_LINK : ""  )  %>">
                            <div class="unit-box">
                                <p>報名成功通知信是否附上視訊連結</p>
                                <div>
                                    <div class="form-check  form-check-inline">
                                        <input type="radio" class="form-check-input   "
                                            id="ATTACH_VIDEO_LINK1" name="ATTACH_VIDEO_LINK" value="1" checked>是
                              <label class="form-check-label" for="ATTACH_VIDEO_LINK1"></label>
                                    </div>
                                    <div class="form-check  form-check-inline">
                                        <input type="radio" class="form-check-input   "
                                            id="ATTACH_VIDEO_LINK2" name="ATTACH_VIDEO_LINK" value="2">否
                              <label class="form-check-label" for="ATTACH_VIDEO_LINK2"></label>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>

                <div class="  row     ">
                    <div class=" bg-ice   py-3  col-lg-2 border  ">
                        <label>報名確認信</label>
                    </div>
                    <div class="  py-3   col-lg-10 border">
                        <div>
                            <div>文字敘述</div>
                            <div class="d-flex  align-items-start">
                                <textarea name="CONFIRM_MAIL" id="CONFIRM_MAIL" cols="30" rows="3"
                                    class="form-control   "><%: (Model !=null &&  Model.CONFIRM_MAIL!=null ? Model.CONFIRM_MAIL : "您已完成填寫『0524「東區第二、三類投保單位承保業務說明會」視訊會議』活動報名表，為確保為您的電子信箱填寫無誤，請您點選下方連結進行電子郵件確認(112/05/25 14:20前)，確認完成後方能完成報名程序。\n　　如您未進行活動報名，有可能是他人誤用（或冒用），請將這封信直接刪除即可。"  )  %></textarea>
                                <a href="#" class="btn btn-primary-isre m-2 text-nowrap  px-4">預覽</a>
                            </div>

                        </div>
                    </div>
                </div>
                <div class="  row     ">
                    <div class=" bg-ice  py-3  col-lg-2 border  ">
                        <label>報名成功通知信 </label>
                    </div>
                    <div class="  py-3   col-lg-10 border">
                        <div>
                            <div>文字敘述</div>
                            <div class="d-flex align-items-start">
                                <textarea name="SUCCESS_MAIL" id="SUCCESS_MAIL" cols="30" rows="3"
                                    class="form-control    "><%: (Model !=null &&  Model.SUCCESS_MAIL!=null ? Model.SUCCESS_MAIL : "您已完成『0524「東區第二、三類投保單位承保業務說明會」視訊會議』活動報名，敬請記得活動當天攜帶 QR code 報到！"  )  %> </textarea>

                                <a href="#" class="btn btn-primary-isre m-2 text-nowrap  px-4">預覽</a>
                            </div>

                        </div>
                    </div>
                </div>
                <div class="  row     ">
                    <div class=" bg-ice  py-3  col-lg-2 border  ">
                        <label>報名候補確認信</label>
                    </div>
                    <div class="  py-3   col-lg-10 border">
                        <div>
                            <div>文字敘述</div>
                            <div class="d-flex align-items-start">
                                <textarea name="WAIT_MAIL" id="WAIT_MAIL" cols="30" rows="3"
                                    class="form-control    "><%: (Model !=null &&  Model.WAIT_MAIL!=null ? Model.WAIT_MAIL : "您已完成『0524「東區第二、三類投保單位承保業務說明會」視訊會議』活動報名候補，若您遞補成功將會另外發函通知，\n請密切注意您的電子郵件信箱。若無沒遞補恕不另外通知。"  )  %> </textarea>

                                <a href="#" class="btn btn-primary-isre m-2 text-nowrap  px-4">預覽</a>
                            </div>
                        </div>

                    </div>
                </div>

                <div class="  row     ">
                    <div class=" bg-ice   py-3  col-lg-2 border  ">
                        <label>活動提醒通知信</label>
                    </div>
                    <div class="  py-3   col-lg-10 border">
                        <div>
                            <div class="d-flex">
                                <div>
                                    <div class="form-check  form-check-inline">
                                        <input type="radio" class="form-check-input " id="REMIND_MAIL_ENABLE1"
                                            name="REMIND_MAIL_ENABLE" value="1" checked>啟用
                              <label class="form-check-label" for="REMIND_MAIL_ENABLE1"></label>
                                    </div>
                                    <div class="form-check  form-check-inline">
                                        <input type="radio" class="form-check-input " id="REMIND_MAIL_ENABLE2"
                                            name="REMIND_MAIL_ENABLE" value="2">停用
                              <label class="form-check-label" for="REMIND_MAIL_ENABLE2"></label>
                                    </div>
                                </div>
                                <div class="ms-5 me-3 "><b>寄送時間</b></div>
                                <div class="d-flex">
                                    <input type="text" id="REMIND_MAIL_DATE" name="REMIND_MAIL_DATE"
                                        placeholder="民國年/月/日" class="form-control  mx-1    requiredInput"
                                        value="<%: (Model !=null &&  Model.REMIND_MAIL_DATE!=null
                                ? Model.REMIND_MAIL_DATE.ToString("yyyy-MM-dd") : ""  )  %>">
                                    <input type="time" id="REMIND_MAIL_TIME" name="REMIND_MAIL_TIME" placeholder="HH:mm"
                                        class="form-control mx-1 flex-grow-1 requiredInput"
                                        value="<%: (Model !=null &&  Model.REMIND_MAIL_TIME!=null
                                ? Model.REMIND_MAIL_TIME : ""  )  %>" />



                                </div>

                            </div>
                            <div>文字敘述</div>
                            <div class="d-flex align-items-start">
                                <textarea name="REMIND_MAIL_TEXT" id="REMIND_MAIL_TEXT" cols="30" rows="3"
                                    class="form-control   "><%:(Model !=null &&  Model.REMIND_MAIL!=null 
                              ? Model.REMIND_MAIL : "『0524「東區第二、三類投保單位承保業務說明會」視訊會議』活動即將開始，敬請記得活動當天攜帶 QR code 報到！"  )  %> </textarea>

                                <a href="#" class="btn btn-primary-isre m-2 text-nowrap  px-4">預覽</a>
                            </div>

                        </div>
                    </div>
                </div>

                <div class="d-flex justify-content-end ">
                    <div class="text-black-50">
                        <%: (SESSIONGUID == "") ? "Created By:" : "Modified By:" %> <span>A111888 王⼩明</span>
                    </div>
                </div>


                <div class="d-flex justify-content-center flex-wrap  align-content-center mt-5 mb-3">

                    <% if (Model != null)
                        {%>
                    <a href="#" id="btnInsert" class="btn btn-primary-isre d-none text-nowrap    px-sm-4 py-2  me-md-5 m-2 ">新增</a>

                    <a href="#" id="btnSave" class="btn btn-primary-isre  text-nowrap    px-sm-4 py-2  me-md-5 m-2 ">儲存</a>

                    <a href="#" id="btnCopy" class="btn btn-primary-isre  text-nowrap    px-sm-4 py-2  me-md-5 m-2 ">複製資料</a>
                    <a href="#" id="btnRelease" class="btn btn-primary-isre  text-nowrap    px-sm-4 py-2  me-md-5 m-2 ">傳送</a>
                    <a href="#" id="btnDelete" class="btn btn-primary-isre  text-nowrap    px-sm-4 py-2  me-md-5 m-2 ">刪除</a>

                    <% }
                    else
                    { %>
                    <a href="#" id="btnAdd" class="btn btn-primary-isre  text-nowrap    px-sm-4 py-2  me-md-5 m-2 ">新增</a>

                    <%}%>
                    <a href="#" id="btnBack" class="btn btn-primary-isre  text-nowrap    px-sm-4 py-2  me-md-5 m-2 ">回前一頁</a>

                    <a href="ISRI0000.ASPX" id="btnBackToHome" class="btn btn-primary-isre  text-nowrap px-sm-4 py-2  me-md-5 m-2 ">回首頁</a>

                    <a href="#" id="btnPreview" class="btn btn-primary-isre  text-nowrap px-sm-4 py-2  me-md-5 m-2 ">預覽</a>

                    <a href="#" class="btn btn-primary-isre    px-3 py-2  me-5 mb-2 ">報名表設定</a>

                </div>

            </div>
            <%--  session   end  --%>
        </div>
        <div id="divMessage" class="errordisplay" style=""></div>

    </main>
    <script> 

        $(document).ready(function () {
            $("#SESS_DATE_S_DATE, #SESS_DATE_E_DATE,#REG_DATE_S, #REG_DATE_E, #CHK_DATE_S_DATE, #CHK_DATE_E_DATE, #REMIND_MAIL_DATE, #sch_s_datepicker")
                .datepicker($.datepicker.regional['zh-TW']);


            $(document).on('click', '#btnCopy', function (e) {
                e.preventDefault();
                $('#btnCopy, #btnSave, #btnRelease, #btnDelete').addClass('d-none');
                $('#btnInsert ').removeClass('d-none');
            });

            $("#btnAdd").click(function () {


                var arForm = $("form").serializeArray();	//This method does not accept any arguments.
                alert($("form").serialize());
                $("#divMessage").html($("form").serialize());


                $.ajax({
                    type: "POST",
                    url: 'ISRI0003.aspx/InsertData',
                    data: JSON.stringify({ formVars: arForm }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {

                        if (response != null && response.d != null) {
                            $('#btnAdd').prop('disabled', true);	// Disable button
                        }
                    },
                    error: function () {
                        alert("Error while inserting data");
                    }
                });




            });

            $('#btnAdd').prop('disabled', false); // Enable button
      

        });

    </script>
</asp:Content>
