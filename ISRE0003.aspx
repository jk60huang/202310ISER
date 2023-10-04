<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master"
	AutoEventWireup="true" CodeBehind="ISRI0003.aspx.cs"
	Inherits="ISRE.ISRI0003"   %>

<%--this page is for backend to edit   register --%>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
	<%
		string GUID = Request.QueryString["GUID"] ?? "";  /////////GUID=session guid 
		//string ActioinName = (GUID == "") ? "新增" : "編輯";
	%>

	
	<main aria-labelledby="title">
		<div class=" my-2">

	<h3 class="text-center  ">活動內容</h3>
	 
	<%-- activity info summary start --%>
	<%-- activity info summary title start --%>
	<div class="    card p-2  my-2 d-none d-lg-block bg-ice    ">
		<div class="row text-center  ">
			<div class=" col-lg-3   text-start">
				活動主題  
			</div>
			<div class=" col-lg-3  ">
				⽇期 
			</div>
			 
			<div class=" col-lg-2    ">
				主辦單位 
			</div>
			<div class=" col-lg-3   ">
				發布⽇期 
			</div>

		</div>

	</div>
	<%-- activity info summary title end --%>
	<%-- activity info summary content start --%>
	<div class="    card p-2  my-2     ">
		<div class=" row    d-flex align-items-center ">
			<div class="col-12 col-sm-5 col-lg-3 ">
				<div class="row   ">
					<span class="d-lg-none col-3 col-sm-4   ">
						<span class="badge bg-info  ">活動主題</span>
					</span>
					<div class="col-9 col-sm-8 col-lg-12 ">
						<div>
							活動主題
						</div>
					</div>
				</div>
			</div>
			<div class="col-12 col-sm-7 col-lg-3 ">
				<div class="row  d-flex align-items-center ">
					<span class="d-lg-none  col-3 col-sm-4    ">
						<span class="badge bg-info">⽇期</span>
					</span>
					<div class="col-9 col-sm-8 col-lg-12    ">
						<div class="d-flex justify-content-lg-center">112/08/31-112/09/30 </div>
					</div>
				</div>
			</div>
			 
			<div class="col-12  col-sm-7  col-lg-2 ">
				<div class="row  d-flex align-items-center ">
					<div class="d-lg-none  col-3  col-sm-4   ">
						<span class="badge bg-info">主辦單位</span>
					</div>
					<div class="col-9 col-sm-8 col-lg-12  text-center  ">
						<div class="d-flex justify-content-lg-center">主辦單位 </div>
					</div>
				</div>
			</div>

			<div class="col-12  col-sm-5 col-lg-3 ">
				<div class="row  d-flex align-items-center ">
					<div class="d-lg-none  col-3  col-sm-4   ">
						<span class="badge bg-info">發布⽇期</span>
					</div>
					<div class="col-9 col-sm-8 col-lg-12 ">
						<div class="  text-center ">
							<div class="d-flex justify-content-lg-center">112/08/31  </div>
						</div>
					</div>
				</div>
			</div>


		</div>

	</div>
	<%-- activity info summary content end --%>
	<%--   activity info summary end--%>


	 


	<%--session   start  --%>
	<h3 class="text-center mt-5 mb-2">場次資訊  </h3>
	<%  
		dynamic Model = Process_Session(GUID);

	%>

	<%--session   title columns start --%>
	<div class="  card p-2  my-2 d-none d-lg-block bg-ice      ">
		<div class="row text-center   d-flex align-items-center">
			<div class=" col-lg-1  ">
				場次  
			</div>
			<div class=" col-lg-3  ">
				日期時間 
			</div>
			<div class=" col-lg-2  ">
				地點 
			</div>
			<div class=" col-lg-2 ">
				主辦單位 
			</div>
			<div class=" col-lg-3     ">
				報名截⽌⽇ 
			</div>
		<%--	<div class=" col-lg-2     ">
				可報名⼈數 
			</div>
			<div class=" col-lg-2     ">
				已報名⼈數 
			</div>
			<div class=" col-lg-1    ">
				尚餘名額 
			</div>--%>

		</div>
	</div>
	<%-- session   title columns end--%>

	<%-- session summary  content start --%>

	<div class="    card p-2  my-2     ">
		<div class=" row  d-flex align-items-center  ">
			<div class="col-12 col-sm-5  col-lg-1 ">
				<div class="row  d-flex align-items-center">
					<span class="d-lg-none  col-4 col-sm-5     ">
						<span class="badge bg-info">場次</span>
					</span>
					<div class=" col-8 col-sm-7    col-lg-12 ">
						<div class="d-flex justify-content-lg-center">
							4  
						</div>
					</div>
				</div>
			</div>
			<div class="col-12 col-sm-7  col-lg-3 ">
				<div class="row  d-flex align-items-center">
					<span class="d-lg-none   col-4 col-sm-5     ">
						<span class="badge bg-info">日期時間</span>
					</span>
					<div class=" col-8 col-sm-7    col-lg-12  text-center  ">
						<div class="d-flex justify-content-lg-center">112/08/31 </div>
					</div>
				</div>
			</div>
			<div class="col-12 col-sm-5  col-lg-2 ">
				<div class="row  d-flex align-items-center">
					<span class="d-lg-none  col-4 col-sm-5      ">
						<span class="badge bg-info">地點</span>
					</span>
					<div class=" col-8 col-sm-7    col-lg-12   text-center  ">
						<div class="d-flex justify-content-lg-center">台北市 </div>
					</div>
				</div>
			</div>
			<div class="col-12 col-sm-7 col-lg-2 ">
				<div class="row  d-flex align-items-center">
					<span class="d-lg-none    col-4 col-sm-5      ">
						<span class="badge bg-info">主辦單位</span>
					</span>
					<div class=" col-8 col-sm-7    col-lg-12   text-center  ">
						<div class="d-flex justify-content-lg-center">台北市 </div>
					</div>
				</div>
			</div>
			<div class="col-12 col-sm-5 col-lg-3 ">
				<div class="row  d-flex align-items-center">
					<div class="d-lg-none   col-4 col-sm-5       ">
						<span class="badge bg-info">報名截⽌⽇</span>
					</div>
					<div class=" col-8 col-sm-7    col-lg-12  text-center  ">
						<div class="d-flex justify-content-lg-center">112/08/31  </div>
					</div>
				</div>
			</div>

			<%--<div class="col-12 col-sm-7 col-lg-2 ">
				<div class="row  d-flex align-items-center">
					<div class="d-lg-none   col-4 col-sm-5     ">
						<span class="badge bg-info">可報名⼈數</span>
					</div>
					<div class=" col-8 col-sm-7    col-lg-12  text-center ">
						<div class="d-flex justify-content-lg-center">
							<div class="badge bg-primary">
								21
							</div>
						</div>
					</div>
				</div>
			</div>--%>

			<%--<div class="col-12 col-sm-5 col-lg-2 ">
				<div class="row  d-flex align-items-center">
					<div class="d-lg-none   col-4 col-sm-5      ">
						<span class="badge bg-info">已報名⼈數</span>
					</div>
					<div class="  col-8 col-sm-7    col-lg-12  text-center ">
						<div class="d-flex justify-content-lg-center">
							<div class="badge bg-success">
								7
							</div>
						</div>
					</div>
				</div>
			</div>--%>

			<%--<div class="col-12 col-sm-7 col-lg-1 ">
				<div class="row  d-flex align-items-center">
					<div class="d-lg-none   col-4 col-sm-5     ">
						<span class="badge bg-info">尚餘名額</span>
					</div>
					<div class="  col-8 col-sm-7     col-lg-12  text-center ">
						<div class="d-flex justify-content-lg-center">
							<div class="badge bg-dark">
								14
							</div>
						</div>
					</div>
				</div>
			</div>--%>
		</div>
	</div>

	<%-- session summary  content end --%>



	 
	<%-- <div class="card p-2  my-2  mt-4 bg-ice"> 報名表</div>
	--%> 
			<%--     registration form start--%>
  

<div id="registrationForm" class="mt-5">
	<h3 class="text-center mt-5 mb-2">報到專區 </h3>


	 
	<%--<div class="text-center">
		<div class=" mx-2  form-check-inline">報名⾝分：</div>
		<div class="form-check mx-2   form-check-inline">
			<input type="radio" class="form-check-input" id="REG_TYPE1" name="REG_TYPE" value="1" checked>個人
          <label class="form-check-label" for="REG_TYPE1"></label>
		</div>
		<div class="form-check mx-2  form-check-inline">
			<input type="radio" class="form-check-input" id="REG_TYPE2" name="REG_TYPE" value="2">單位
          <label class="form-check-label" for="REG_TYPE2"></label>
		</div>
		<div class="text-center text-danger"><span class="note">「*」</span>為必填</div>
	</div>--%>

	<div id="cardInput" class="card border-4">
		<div class="card-body">

<%--			<div class="   row   unit   ">
				<div class="    py-lg-3    col-lg-2  ">
					<span class="note">*</span><b><label>投保單位代號</label></b>
				</div>
				<div class="    py-lg-3   col-lg-10  ">
					<div>
						<input type="text" class=" form-control requiredInput" name="UNIT_NO" id="UNIT_NO">
					</div>
				</div>
			</div>

			<div class="   row   unit   ">
				<div class="   py-lg-3    col-lg-2  ">
					<span class="note">*</span><b><label>投保單位名稱</label></b>
				</div>
				<div class="    py-lg-3  col-lg-10    ">
					<div>
						<input type="text" name="UNIT_NAME2" id="UNIT_NAME2" class=" form-control requiredInput">
					</div>
				</div>
			</div>
		--%>	 
			 <div class="   row      ">
				<div class="      py-lg-3   col-lg-3  ">
					<span class="note">*</span><b><label>姓名</label></b>
				</div>
				<div class="  py-lg-3   col-lg-9  ">
					<div>
						<input type="text" name="APPLY_NAME" id="APPLY_NAME" class=" form-control requiredInput">
					</div>
				</div>
			</div> 

 
			<%--<div class="  row  personal    ">
				<div class="      py-lg-3  col-lg-3    ">
					<span class="note">*</span><b><label>⾝分證號/居留證號</label></b>
				</div>
				<div class="   py-lg-3    col-lg-9  ">
					<div>
						<input type="text" name="ID_AES" id="ID_AES" class=" form-control requiredInput">
						<p class="note-r">(若需登錄公務⼈員教育訓練時數，請填寫本項資料)</p>
					</div>
				</div>
			</div>

			<div class="  row  personal   ">
				<div class="   py-lg-3   col-lg-3   ">
					<span class="note">*</span><b><label>服務單位</label></b>
				</div>
				<div class="   py-lg-3   col-lg-9 ">
					<div>
						<input type="text" name="UNIT_NAME"
							id="UNIT_NAME" class=" form-control requiredInput">
					</div>
				</div>
			</div>--%>

			<div class="  row     ">
				<div class="     py-lg-3   col-lg-3    ">
					<span class="note">*</span><b><label>聯絡電話</label></b>
				</div>
				<div class="    py-lg-3   col-lg-9  ">
					<div>
						<p class="note">＊市話或⾏動電話請務必⾄少填寫⼀項</p>
						<input type="text" name="MOB_NUM" id="MOB_NUM" class=" form-control requiredInput" placeholder="行動電話號碼">
						<p>格式：09XXXXXXXX</p>
						<div class="d-flex">
							<input type="text" size="20" maxlength="10" name="TEL_AREA" id="TEL_AREA"
								class=" form-control requiredInput" placeholder="區碼">
							<input type="text" name="TEL_NUM" id="TEL_NUM"
								class=" form-control requiredInput" placeholder="室內電話號碼">
						</div>
					</div>
				</div>
			</div>
			<%--<div class="  row     ">
				<div class="      py-lg-3   col-lg-3    ">
					<span class="note">*</span><b><label>電⼦郵件信箱</label></b>
				</div>
				<div class="    py-lg-3  col-lg-9  ">
					<div>
						<input type="text" id="EMAIL" name="EMAIL" class=" form-control requiredInput">
						<p class="note font85">
							1.請正確填寫以利確認信寄達，並請
                      於 2 小時內完成信件內點選連結驗證，未於時限內確認則取消報名。
							<br>
							2.若您使⽤免費信箱（例如：QQ、iCloud、pchome 信箱等）
                      ，本署的回信可能被移⾄垃圾信件，或無法寄達，敬請留意。
						</p>
					</div>
				</div>
			</div>
			<div class="  row    personal ">
				<div class="     py-lg-3   col-lg-3    ">
					<span class="note">*</span><b><label>上傳公務⼈員訓練時數</label></b>
				</div>
				<div class="    py-lg-3  col-lg-9 ">
					<div class="form-control">
						<div class="form-check  form-check-inline">
							<input type="radio" class="form-check-input  requiredInput" id="UPLOAD_TRAIN_HOUR1" name="UPLOAD_TRAIN_HOUR" value="Y" checked>是
                      <label class="form-check-label" for="UPLOAD_TRAIN_HOUR1"></label>
						</div>
						<div class="form-check  form-check-inline">
							<input type="radio" class="form-check-input requiredInput" id="UPLOAD_TRAIN_HOUR2" name="UPLOAD_TRAIN_HOUR" value="N">否
                      <label class="form-check-label" for="UPLOAD_TRAIN_HOUR2"></label>
						</div>

					</div>
				</div>
			</div>
			<div class="  row     ">
				<div class="   py-lg-3   col-lg-3    ">
					<span class="note">*</span><b><label>餐飲</label></b>
				</div>
				<div class="    py-lg-3   col-lg-9 ">
					<div class="form-control">
						<div class="form-check  form-check-inline">
							<input type="radio" class="form-check-input requiredInput" id="DIET_TEND1" name="DIET_TEND" value="1" checked>無
                      <label class="form-check-label" for="UPLOAD_TRAIN_HOUR1"></label>
						</div>
						<div class="form-check  form-check-inline">
							<input type="radio" class="form-check-input requiredInput" id="DIET_TEND2" name="DIET_TEND" value="2">葷食
                      <label class="form-check-label" for="UPLOAD_TRAIN_HOUR2"></label>
						</div>
						<div class="form-check  form-check-inline">
							<input type="radio" class="form-check-input requiredInput" id="DIET_TEND3" name="DIET_TEND" value="3">素食
                      <label class="form-check-label" for="UPLOAD_TRAIN_HOUR2"></label>
						</div>

					</div>
				</div>
			</div>
			 --%>
		</div>
	</div>

	<%--  command buttons start--%>
	<div class="d-flex  justify-content-center mx-5 my-5">
		<div>
			<button type="button" id="btn_Register"
				class="btn btn-primary-isre px-3 mx-4   px-md-4 text-nowrap"
				data-target="/Session/Register">
				報到
			</button>
		</div>

		<div>
			<button type="button" id="btn_Clear"
				class="btn btn-primary-isre  px-3 mx-4  px-md-4 text-nowrap">
				清除</button>
		</div>
		<%--<div>
			<a href="\isre0000.aspx" class="btn btn-primary-isre   mx-1 mx-md-4 px-md-4 text-nowrap">回首頁</a>
		</div>--%>

	</div>

	<%--  command buttons end--%>
	 
</div>

<%-- registration form end--%>

</div>

	</main>
	<script> 

		$(document).ready(function () {
			 

		});

	</script>
</asp:Content>
