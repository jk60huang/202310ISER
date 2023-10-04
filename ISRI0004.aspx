<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master"
	AutoEventWireup="true" CodeBehind="ISRI0004.aspx.cs"
	Inherits="ISRE.ISRI0004" %>

<%--this page is for backend to manage frontend registration form (show/required) --%>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

	<%
		String SESSIONGUID = Request.QueryString["SESSIONGUID"] ?? "";  /////////GUID=activity guid


	%>

	<main aria-labelledby="title">


		<div class=" my-2 ">
			<div id="ISRI_SessionFlow" runat="server">
				<!-- #Include virtual="ISRI_SessionFlow.aspx" -->
			</div>

			<div id="ActivityInfo" runat="server">
				<!-- #Include virtual="ISRI_ActivityInfo.aspx" -->
			</div>

			<div id="ISRI_SessionInfo" runat="server">
				<!-- #Include virtual="ISRI_SessionInfo.aspx" -->
			</div>



			<div id="RegistrationFormSetting" runat="server">
				<!-- #Include virtual="ISRI_RegistrationFormSetting.aspx" -->
			</div>


			<div class="d-flex justify-content-center my-4">

				<button type="button" id="btn_Insert" guid="<%:SESSIONGUID %>"
					data-target="ISRI0004.aspx/Process_SettingForm"
					class="    px-4 py-2  me-5 mb-2 text-nowrap  btn-primary-isre btn ">
					<span>儲存</span>
				</button>
				<a href="#" class="btn btn-primary-isre    px-3 py-2  me-5 mb-2 ">回前頁</a>

			</div>


		</div>




	</main>

	<script>
		$(document).on('click', '.rdoREG_TYPE', function (e) {  
			$('.table_REG_TYPE').addClass('d-none');
			$('#table_REG_TYPE' + $(this).val()).removeClass('d-none');
		})

		$(document).on('click', '.requiredCheck', function (e) {
			e.preventDefault();
			return;
		})
		$(document).ready(function () {
			var SaveForm = function (btn) {
				//let id = btn.attr('id');
				let guid = btn.attr('guid');
				let target = btn.attr('data-target');
				let thisFormId = btn.closest('form').attr('id'); 
				let formData = new FormData($('#' + thisFormId).get(0));
				formData.append('guid', guid);
				var object = {};
				formData.forEach((value, key) => {
					// Reflect.has in favor of: object.hasOwnProperty(key)
					if (key == "__VIEWSTATEGENERATOR" || key == "__VIEWSTATE")
						return;
					if (!Reflect.has(object, key)) {
						object[key] = value;
						return;
					}
					if (!Array.isArray(object[key])) {
						object[key] = [object[key]];
					}
					object[key].push(value);
				});
				console.log(object);
				var json = JSON.stringify(object);
				console.log(json);
				// return;
				$.ajax({
					url: target,
					data: JSON.stringify({ 'formData': json }),
					dataType: 'json', // 預期從server接收的資料型態
					//   contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
					contentType: 'application/json; charset=utf-8', // 要送到server的資料型態
					type: 'POST',
					//  enctype: 'multipart/form-data',
					caches: false,
					async: false,
					// contentType: false, // Not to set any content header  //formdata required
					//	processData: false, // Not to process data  //formdata required
					success: function (response, textStatus, jqXHR) {
						console.log('success');
						var responseDOM = $(response);
						console.log(responseDOM);
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
						alert(msg);
					}
					, done: function (data) {
						console.log('done');
						console.log(data);
					}
				});
			};

			var SaveFormTest2 = function (btn) {
				//let id = btn.attr('id');
				let guid = btn.attr('guid');
				let target = btn.attr('data-target');
				let thisFormId = btn.closest('form').attr('id');
				let formData = new FormData($('#' + thisFormId).get(0));
				formData.append('guid', guid);
				var object = {};
				formData.forEach((value, key) => {
					// Reflect.has in favor of: object.hasOwnProperty(key)
					if (key == "__VIEWSTATEGENERATOR" || key == "__VIEWSTATE")
						return;
					if (!Reflect.has(object, key)) {
						object[key] = value;
						return;
					}
					if (!Array.isArray(object[key])) {
						object[key] = [object[key]];
					}
					object[key].push(value);
				});
				console.log(object);
				var json = JSON.stringify(object);
				console.log(json);
				  return;
				$.ajax({
					url: target,
					data: JSON.stringify({ 'formData': json }),
					dataType: 'json', // 預期從server接收的資料型態
					//   contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
					contentType: 'application/json; charset=utf-8', // 要送到server的資料型態
					type: 'POST',
					//  enctype: 'multipart/form-data',
					caches: false,
					async: false,
					// contentType: false, // Not to set any content header  //formdata required
					//	processData: false, // Not to process data  //formdata required
					success: function (response, textStatus, jqXHR) {
						console.log('success');
						var responseDOM = $(response);
						console.log(responseDOM);
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
						alert(msg);
					}
					, done: function (data) {
						console.log('done');
						console.log(data);
					}
				});
			};

			$('#btn_Insert').on('click', function () {
			 	SaveForm($(this));
				SaveFormTest2($(this));
			});


			var SearchResult = $('#SearchResult');
			var thisForm = SearchResult.closest('form');
			//SearchResult.parent().find('form');

			//$(thisForm)
			//    .attr('data-ajax', 'true')
			//    .attr('data-ajax-method', 'GET')
			//    .attr('data-ajax-mode', 'replace')
			//    .attr('data-ajax-update', '#SearchResult')
			//    ;

			//var w = $(window).width();
			//var actionUrl = (w <= 576) ? formAction_Mobile : formAction_Desktop;
			//$("#clientScreenWidth").val(w);
			/////////// event handler
			////////// must be on last
			//console.log(thisForm);
			// alert('here');
			// thisForm.attr('action', actionUrl).submit();
			//  thisForm.submit();


		});



	</script>
</asp:Content>
