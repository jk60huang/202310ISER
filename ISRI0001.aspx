<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master"
	AutoEventWireup="true" CodeBehind="ISRI0001.aspx.cs"
	Inherits="ISRE.ISRI0001" %>

<%--this page is for backend activity create/edit--%>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
	<%
		string GUID = Request.QueryString["GUID"] ?? "";  /////////GUID=activity guid
		string ActioinName = (GUID == "") ? "新增" : "編輯";
		string sSelected = "";
	%>

	<main aria-labelledby="title">

		<div class=" my-2">
			<%   
				dynamic Model = Process_ActivityInfo(GUID);
			%>
			<%--  activity form starts--%>
			<div class="   ">
				<h3 class="text-center my-2"><%: String.Concat(ActioinName, "活動資訊") %> </h3>

				<div class="  row     ">
					<div class=" bg-ice   py-3  col-lg-2 border  ">
						<span class="note">*</span><label>發布⽇期</label>
					</div>
					<div class="  py-3   col-lg-10 border">
						<div class="d-flex">
							<input type="text" id="PUB_DATE_S_DATE" name="PUB_DATE_S_DATE"
								placeholder="民國年/月/日"
								class="form-control mx-1 requiredInput">

							<input type="time" id="PUB_DATE_S_TIME" name="PUB_DATE_S_TIME"
								placeholder="HH:mm"
								class="form-control mx-1 requiredInput">

							<input type="hidden" id="PUB_DATE_S" name="PUB_DATE_S"
								value="<%: (Model !=null &&  Model.PUB_DATE_S!=null
                            ? Model.PUB_DATE_S 
                            : DateTime.Now )  %>" />
							<span class="mx-2">~ </span>
							<input type="text" id="PUB_DATE_E_DATE" name="PUB_DATE_E_DATE"
								placeholder="民國年/月/日"
								class="form-control mx-1 requiredInput">

							<input type="time" id="PUB_DATE_E_TIME" name="PUB_DATE_E_TIME"
								placeholder="HH:mm"
								class="form-control mx-1 requiredInput">

							<input type="hidden" id="PUB_DATE_E" name="PUB_DATE_E"
								value="<%: (Model !=null &&  Model.PUB_DATE_E!=null
                                 ? Model.PUB_DATE_E 
                                 : DateTime.Now )  %>" />
						</div>
					</div>
				</div>

				<div class="  row     ">
					<div class=" bg-ice   py-3  col-lg-2 border  ">
						<span class="note">*</span><b><label>活動⽇期</label></b>
					</div>
					<div class="  py-3   col-lg-10 border">
						<div class="d-flex">
							<input type="text" id="ACT_DATE_S_DATE" name="ACT_DATE_S_DATE"
								placeholder="民國年/月/日"
								class="form-control mx-1 requiredInput">

							<input type="time" id="ACT_DATE_S_TIME" name="ACT_DATE_S_TIME"
								placeholder="HH:mm"
								class="form-control mx-1 requiredInput">

							<input type="hidden" id="ACT_DATE_S" name="ACT_DATE_S"
								value="<%: (Model !=null &&  Model.ACT_DATE_S!=null
                             ? Model.ACT_DATE_S 
                             : DateTime.Now )  %>" />
							<span class="mx-2">~ </span>
							<input type="text" id="ACT_DATE_E_DATE" name="ACT_DATE_E_DATE"
								placeholder="民國年/月/日"
								class="form-control mx-1 requiredInput">

							<input type="time" id="ACT_DATE_E_TIME" name="ACT_DATE_E_TIME"
								placeholder="HH:mm"
								class="form-control mx-1 requiredInput">
							<input type="hidden" id="ACT_DATE_E" name="ACT_DATE_E"
								value="<%: (Model !=null &&  Model.ACT_DATE_E!=null
                            ? Model.ACT_DATE_E 
                            : DateTime.Now )  %>" />
						</div>
					</div>
				</div>

				<div class="   row      ">
					<div class="  bg-ice   py-3   col-lg-2 border">
						<span class="note">*</span><b><label>活動⽣效註記</label></b>
					</div>
					<div class="  py-3   col-lg-10 border">
						<div class="form-check  form-check-inline">
							<input type="radio" class="form-check-input requiredInput"
								id="ACT_ENABLE1" name="ACT_ENABLE" value="1"
								checked>啟用
                    <label class="form-check-label" for="ACT_ENABLE1"></label>
						</div>
						<div class="form-check  form-check-inline">
							<input type="radio" class="form-check-input requiredInput"
								id="ACT_ENABLE2" name="ACT_ENABLE" value="2">停用
                    <label class="form-check-label" for="ACT_ENABLE2"></label>
						</div>
					</div>
				</div>

				<div class="    row ">
					<div class=" border  py-3    bg-ice  col-lg-2">
						<label>負責⼈</label>
					</div>
					<div class="  border  py-3     col-lg-10">
						A111888 王⼩明
					</div>
				</div>

				<%--  @*代理人員*@--%>
				<div class=" row   ">
					<div class="   border  py-3  bg-ice col-lg-2">
						<label>代理人員</label>
					</div>
					<div class=" border  py-3   col-lg-10">
						<div class="d-flex">
							<button type="button" class="btn bg-white border ">
								<span class="text-black-50">A111885 王大明</span>
								<span class="badge "><span class="fas  text-danger fa-times-circle  fa-2x"></span></span>
							</button>

							<button type="button" class="btn bg-white border ">
								<span class="text-black-50">A111880 王中明</span>
								<span class="badge "><span class="fas  text-danger fa-times-circle  fa-2x"></span></span>
							</button>
							<span>
								<button type="button" class="btn btn-primary-isre px-4">新增</button>
							</span>
						</div>
						<div class="py-2">代理人員最多設定10名</div>
					</div>
				</div>


				<div class=" row     ">
					<div class="  bg-ice  py-3  border col-lg-2">
						<span class="note">*</span><b><label>活動類別</label></b>
					</div>
					<div class="    py-3  border  col-lg-10">
						<select name="ACT_TYPE" id="ACT_TYPE" class="form-control form-select">
							<option value="">請選擇</option>
							<% 								
								foreach (var item in List_ACT_TYPE)
								{
									sSelected = (Model != null && Model.ACT_TYPE.ToString() == item.SerialID.ToString()) ? "selected" : "";
							%>
							<option value="<%: item.SerialID %>" <%: sSelected %>><%: item.TYPE_NAME%> </option>
							<%
								}
							%>
						</select>
					</div>
				</div>
				<%--  @*主辦單位*@--%>
				<div class="  row   ">
					<div class="  border  bg-ice   py-3  col-lg-2">
						<span class="note">*</span><b><label>主辦單位</label></b>
					</div>
					<div class="  border    py-3  col-lg-10">
						<input type="text" id="ACT_HOST" name="ACT_HOST" class="form-control  requiredInput "
							value="<%: (Model !=null &&  Model.ACT_HOST!=null
                        ? Model.ACT_HOST   : ""  )  %>">
					</div>
				</div>

				<%-- @*活動主題*@--%>
				<div class="  row   ">
					<div class="  border  bg-ice   py-3  col-lg-2">
						<span class="note">*</span><b><label>活動主題</label></b>
					</div>
					<div class="  border    py-3  col-lg-10">
						<textarea name="ACT_NAME"
							id="ACT_NAME" rows="3"
							class="form-control requiredInput"><%: (Model !=null &&  Model.ACT_NAME!=null  ? Model.ACT_NAME   : ""  )  %></textarea>
					</div>
				</div>


				<%-- @*視覺圖檔*@--%>
				<div class="  row    ">
					<div class=" border  py-3 bg-ice   col-lg-2">
						<label>視覺圖檔</label>
					</div>
					<div class="   border  py-3    col-lg-10">
						<%-- @*<button class="btn btn-primary-isre">檔案上傳</button>*@--%>
						<div class="note-b">上傳圖檔⼤⼩請勿超過2M，⻑寬比例在16:9~32:9較佳</div>

						<%-- @*<input type="file" class="custom-file-input  requiredInput "
                       id="ACT_IMG"
                       name="ACT_IMG"
                       accept="@acceptType">
                <div class="d-flex custom-file-label " for="customFile">
                </div>*@--%>
					</div>
				</div>
				<%--  @*活動說明*@--%>
				<div class=" row    ">
					<div class=" border py-3 bg-ice col-lg-2">
						<label>活動說明</label>
					</div>
					<div class="border  py-3    col-lg-10">
						<textarea name="ACT_DESC" id="ACT_DESC" rows="6"
							class="form-control   "><%: (Model !=null &&  Model.ACT_DESC!=null 
                                                                ? Model.ACT_DESC   : ""  )  %> </textarea>
					</div>
				</div>
				<%-- @*參加對象*@--%>
				<div class="  row   ">
					<div class="  border  py-3  bg-ice    col-lg-2">
						<span class="note">*</span><b><label>參加對象</label></b>
					</div>
					<div class=" border  py-3     col-lg-10">


						<div class="">
							<span>
								<label>說明文字：</label></span>
							<span class="note">(必填)</span>
							<input type="text" id="OBJ_DESC" name="OBJ_DESC"
								class="form-control requiredInput  "
								value="<%: (Model !=null &&  Model.OBJ_DESC!=null
                     ? Model.OBJ_DESC   : ""  )  %>">
						</div>
					</div>
				</div>
				<div class="d-flex justify-content-end ">
					<div class="text-black-50">
					<%: (GUID == "") ? "Created By:" : "Modified By:" %> <span>A111888 王⼩明</span>
					</div>

				</div>
				<%--<div class="    row  ">
					<div class=" border  py-3   bg-ice col-lg-2">
						<span class="note">*</span><label>建立者</label>
					</div>
					<div class="  border  py-3     col-lg-10">
						<input type="text" id="CREATEDBY" name="CREATEDBY"
							class="form-control requiredInput "
							value="<%: (Model !=null &&  Model.CREATEDBY!=null ? Model.CREATEDBY  : ""  )  %>">
					</div>
				</div>--%>
				<%--<div class="    row  ">
					<div class=" border  py-3   bg-ice col-lg-2">
						<span class="note">*</span><label>建立⽇期</label>
					</div>
					<div class="  border  py-3     col-lg-10">
						<input type="text" id="CREATE_DATE" name="CREATE_DATE"
							class="form-control requiredInput "
							value="<%: (Model !=null &&  Model.CREATE_DATE!=null
                          ? Model.CREATE_DATE.ToString("yyyy-MM-dd") 
                          : DateTime.Now.ToString("yyyy-MM-dd")  )  %>">
					</div>
				</div>--%>
				<%--<div class="    row  ">
					<div class=" border  py-3   bg-ice col-lg-2">
						<span class="note">*</span><label>更新者</label>
					</div>
					<div class="  border  py-3     col-lg-10">
						<input type="text" id="MODIFIEDBY" name="MODIFIEDBY"
							class="form-control requiredInput "
							value="<%: (Model !=null &&  Model.MODIFIEDBY!=null ? Model.MODIFIEDBY  : ""  )  %>">
					</div>
				</div>--%>
				<%--<div class="  row  ">
					<div class=" border  py-3  bg-ice   col-lg-2">
						<span class="note">*</span><label>更新⽇期</label>
					</div>
					<div class="  border  py-3     col-lg-10">
						<input type="text" id="TXT_DATE" name="TXT_DATE" class="form-control  requiredInput"
							readonly
							value="<%: (Model !=null &&  Model.TXT_DATE!=null
                   ? Model.TXT_DATE.ToString("yyyy-MM-dd") 
                   : DateTime.Now.ToString("yyyy-MM-dd")  )  %>">
					</div>
				</div>--%>


				<div class="d-flex justify-content-center mt-5">
					<button type="button" id="btn_Insert"
						guid="<%:GUID%>"
						class="   px-sm-4 py-2  me-md-5 mb-2 text-nowrap  btn-primary-isre btn ">
						<span><%: (Model !=null   ?  "儲存"  : "新增"  ) %> </span>
					</button>
					<button class="btn btn-primary-isre text-nowrap   px-sm-4 py-2  me-md-5 mb-2 ">活動預覽</button>
					<a href="ISRI0000.ASPX" class="btn btn-primary-isre  text-nowrap    px-sm-4 py-2  me-md-5 mb-2 ">回首頁</a>

					<% if (Model != null)
						{%>
					<a href="#" class="btn   btn-primary-isre  text-nowrap     px-sm-4 py-2  me-md-5 mb-2">刪除  </a>

					<%}  %>
				</div>
			</div>			
			<%--  activity form end--%>
		</div>
	</main>

	<script> 
		var SaveForm = function (btn) {
			// return;
			//  btn.attr('disabled', 'disabled');
			var id = btn.attr('id');
			var guid = btn.attr('guid');
			var target = btn.attr('data-target');
			var thisForm = btn.closest('form');
			// thisForm.attr('enctype', 'multipart/form-data');
			console.log(thisForm);
			let thisFormId = thisForm.attr('id');
			//let formElement = document.querySelector("form");
			//let formData = new FormData(formElement);
			//console.log(formData);

			//  console.log(id);
			//  console.log(target);

			////////// customer form data
			// $("#inputForm :input").prop("disabled", false);
			var data = new FormData($('#' + thisFormId).get(0));
			//  let data = new FormData();
			//   var data = new FormData(thisForm.get(0));
			data.append('guid', guid);
			console.log(data);
			return;
			$.ajax({
				url: target,
				data: data,
				//  dataType: 'json', // 預期從server接收的資料型態
				//   contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
				//   contentType: 'application/json; charset=utf-8', // 要送到server的資料型態
				type: 'POST',
				enctype: 'multipart/form-data',
				caches: false,
				contentType: false, // Not to set any content header  //formdata required
				processData: false, // Not to process data  //formdata required
				success: function (response, textStatus, jqXHR) {
					//   alert('here');

					var responseDOM = $(response);
					var QueryMode = responseDOM.attr('QueryMode');
					var IsSuccess = responseDOM.attr('IsSuccess');

					if (QueryMode == 'U') {
						ShowToast('活動修改成功!');
					}
					else {
						ShowToast('活動新增成功!');
					}

					//   console.log(EMAIL);
					//var responseDOM = $(response);
					//var tableRow = responseDOM.find('tr').get(0);
					//history.replaceState(null, null, ' ');
					//var IsSuccess = $(tableRow).attr('IsSuccess');
					//var Message = $(tableRow).attr('Message');
					//  if (IsSuccess == "Y") {   ////no  error
					//   var id = $(tableRow).attr('id');
					//////////// table view update , only returned one record in table view , get(0)=get 1st element
					//   $('tr[id="' + id + '"').after(tableRow.outerHTML).remove();
					//////// return to list page
					//  ShowToast(Message);
					//    CancelOperation(oPageLayout);
					//     btn.removeAttr('disabled');
					//  }
					//   else if (IsSuccess == "N") {   //////////error
					//   console.log('error');
					//  alert(Message);
					//   btn.removeAttr('disabled');
					//   }
				}
				, fail: function (jqXHR, textStatus, errorThrown) {
					console.log('fail');
					console.log(errorThrown);
				}
				, error: function (data) {
					console.log('error');
					console.log(data);
					console.log(data.responseText);
					console.log(data.status);
					console.log(data.statusText);
					jQuery('<div/>', {
						id: 'errorDiv'
					}).html(data.responseText).appendTo($('.footer')).hide();
					var msg = $('#errorDiv').find('title').text();
					$('#errorDiv').remove();
					//alert(msg);
				}
				, done: function (data) {
					console.log('done');
					console.log(data);
				}
			});
		};

		$(document).ready(function () {
			
			$("#PUB_DATE_S_DATE , #PUB_DATE_E_DATE , #ACT_DATE_S_DATE , #ACT_DATE_E_DATE ")
				.datepicker($.datepicker.regional['zh-TW']);

			//$("#PUB_DATE_S_TIME , #PUB_DATE_E_TIME, #ACT_DATE_S_TIME, #ACT_DATE_E_TIME")
			//    .timepicker(
			// {
			//     'timeFormat': 'H: i',
			//     'step': 5,
			// });
          
			$(document).on('click', '#btn_Insert', function (e) {
				e.preventDefault();
				var btn = $(this);
				
				//var requiredInput = $("#inputForm").find('.requiredInput');
				//if (HasAllRequireValue(requiredInput) == false)
				//    return false;
				SaveForm(btn);
			});

           
			/*
				Creation date: 20231002 By Alex Huang
				Modification date : 20231003 By Alex Huang
			*/           
			$("#btn_Insert").click(function () {

                var arForm = $("form").serializeArray();	//This method does not accept any arguments.

				$.ajax({
                    type: "POST",
                    url: 'ISRI0001.aspx/InsertData',
                    data: JSON.stringify({ formVars: arForm }), 
                    contentType: "application/json; charset=utf-8",
					dataType: "json",
					success: function (response) {
                        
                        if (response != null && response.d != null) {    
                            $('#btn_Insert').prop('disabled', true);	// Disable button
						}
                    },
                    error: function () {
                        alert("Error while inserting data");
                    }
				});

			});

            $('#btn_Insert').prop('disabled', false); // Enable button
            /*	
				Creation date: 20231002 By Alex Huang
				Modification date : 20231003 By Alex Huang
			*/

		});

    </script>
</asp:Content>


