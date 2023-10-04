<%-- THIS IS SUB PAGE FOR SESSION REGISTRATION FORM SETTING --%>


<%
	String SESSIONGUID = Request.QueryString["SESSIONGUID"] ?? "";  /////////GUID=activity guid
	String ActioinName = (SESSIONGUID == "") ? "新增" : "編輯";
	string sSelected = "";
	ISRE.ISRE_SESSION_MAIN Model = Process_SessionRegForm(SESSIONGUID);
%>

<h3 class="text-center mt-5">活動報名表</h3>
<div class="my-1 py-1">

	<div class="d-flex justify-content-center">
		<span>報名⾝分：</span>
		<div class="form-check  form-check-inline">
			<input type="radio" class="form-check-input rdoREG_TYPE"
				   id="rdoREG_TYPE1" name="rdoREG_TYPE" value="1" checked>個人
			<label class="form-check-label" for="rdoREG_TYPE1"></label>
		</div>
		<div class="form-check  form-check-inline">
			<input type="radio" class="form-check-input rdoREG_TYPE"
				   id="rdoREG_TYPE2"  name="rdoREG_TYPE"  value="2">單位
			<label class="form-check-label" for="rdoREG_TYPE2"></label>
		</div>
	</div>



	<table class="  table_REG_TYPE  table border  " id="table_REG_TYPE1">
		<thead>
			<tr>
				<th class="left">欄位</th>
				<th>顯示</th>
				<th>必填</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td class="left">姓名</td>
				<td>
					<input type="checkbox" checked class="requiredCheck " disabled>
				</td>
				<td>
					<input type="checkbox" checked class="requiredCheck " disabled>
				</td>
			</tr>
			<tr>
				<td class="left">⾝分證號/居留證號</td>
				<td>
					<input   type="checkbox" class="chk_mask">
				</td>
				<td>
					<input  type="checkbox" class="chk_mask">
				 
				</td>
				
			</tr>
			<tr>
				<td class="left">出生⽇期</td>
				<td>
					<input type="checkbox">
				</td>
				<td>
					<input type="checkbox">
				</td>
			</tr>


			<tr>
				<td class="left">服務單位</td>
				<td>
					<input type="checkbox">
				</td>
				<td>
					<input type="checkbox">
				</td>
			</tr>
			<tr>
				<td class="left">連絡電話</td>
				<td>
					<input type="checkbox" checked class="requiredCheck " disabled>
				</td>
				<td>
					<input type="checkbox" checked class="requiredCheck " disabled>
				</td>
			</tr>
			<tr>
				<td class="left">電⼦郵件信箱</td>
				<td>
					<input  id="PERSONAL_EMAIL_D" name="PERSONAL_EMAIL_D" value="1"
						type="checkbox" checked class="requiredCheck "   >
				</td>
				<td>
					<input  id="PERSONAL_EMAIL_R" name="PERSONAL_EMAIL_R"  value="1"
						type="checkbox" checked class="requiredCheck "   >
				</td>
			</tr>
			<tr>
				<td class="left">製作教師研習證明</td>
				<td>
					<input type="checkbox">
				</td>
				<td>
					<input type="checkbox">
				</td>
			</tr>
			<tr>
				<td class="left">上傳公務⼈員訓練時數</td>
				<td>
					<input type="checkbox">
				</td>
				<td>
					<input type="checkbox">
				</td>
			</tr>
			<tr>
				<td class="left">參與⽅式</td>
				<td>
					<input type="checkbox">
				</td>
				<td>
					<input type="checkbox">
				</td>
			</tr>
			<tr>
				<td class="left">個資使⽤同意證明</td>
				<td>
					<input type="checkbox">
				</td>
				<td>
					<input type="checkbox">
				</td>
			</tr>
			<tr>
				<td class="left">餐飲習慣</td>
				<td>
					<input type="checkbox">
				</td>
				<td>
					<input type="checkbox">
				</td>
			</tr>
			<tr>
				<td class="left">備註</td>
				<td>
					<input type="checkbox">
				</td>
				<td>
					<input type="checkbox">
				</td>
			</tr>
		</tbody>
	</table>



	<table class="d-none table_REG_TYPE  table border   caption-top" id="table_REG_TYPE2">
		<caption class="ps-2">註：投保單位代號、醫療院所代號、統⼀編號、投保單位代號或統⼀編號、指定單位代號必須擇⼀填寫。</caption>
		<thead>
			<tr>
				<th class="left">欄位</th>
				<th>顯示</th>
				<th>必填</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td class="left">投保單位代號</td>
				<td>

					<input type="checkbox">
				</td>
				<td rowspan="5" class="border">
					<input type="checkbox" checked class="requiredCheck " disabled>
				</td>
			</tr>
			<tr>
				<td class="left">醫療院所代號</td>
				<td>

					<input type="checkbox">
				</td>
			</tr>
			<tr>
				<td class="left">統⼀編號</td>
				<td>

					<input type="checkbox">
				</td>
			</tr>
			<tr>
				<td class="left">投保單位代號或統⼀編號</td>
				<td>

					<input type="checkbox">
				</td>
			</tr>
			<tr>
				<td class="left">指定單位代號</td>
				<td>

					<input type="checkbox">
				</td>
			</tr>
			<tr>
				<td class="left">單位名稱</td>
				<td>

					<input type="checkbox">
				</td>
				<td>

					<input type="checkbox">
				</td>
			</tr>
			<tr>
				<td class="left">姓名</td>
				<td>

					<input type="checkbox" checked class="requiredCheck " disabled>
				</td>
				<td>

					<input type="checkbox" checked class="requiredCheck " disabled>
				</td>
			</tr>
			<tr>
				<td class="left">⾝分證號/居留證號</td>
				<td>

					<input type="checkbox">
				</td>
				<td>

					<input type="checkbox">
				</td>
			</tr>
			<tr>
				<td class="left">職稱</td>
				<td>

					<input type="checkbox">
				</td>
				<td>

					<input type="checkbox">
				</td>
			</tr>
			<tr>
				<td class="left">連絡電話</td>
				<td>

					<input type="checkbox" checked class="requiredCheck " disabled>
				</td>
				<td>

					<input type="checkbox" checked class="requiredCheck " disabled>
				</td>
			</tr>
			<tr>
				<td class="left">電⼦郵件信箱</td>
				<td>

					<input type="checkbox" checked class="requiredCheck " disabled>
				</td>
				<td>

					<input type="checkbox" checked class="requiredCheck " disabled>
				</td>
			</tr>
			<tr>
				<td class="left">製作教師研習證明</td>
				<td>

					<input type="checkbox">
				</td>
				<td>

					<input type="checkbox">
				</td>
			</tr>
			<tr>
				<td class="left">上傳公務⼈員訓練時數</td>
				<td>
					<input type="checkbox">
				</td>
				<td>
					<input type="checkbox">
				</td>
			</tr>
			<tr>
				<td class="left">參與⽅式</td>
				<td>
					<input type="checkbox">
				</td>
				<td>
					<input type="checkbox">
				</td>
			</tr>
			<tr>
				<td class="left">個資使⽤同意證明</td>
				<td>
					<input type="checkbox">
				</td>
				<td>
					<input type="checkbox">
				</td>
			</tr>
			<tr>
				<td class="left">餐飲習慣</td>
				<td>
					<input type="checkbox">
				</td>
				<td>
					<input type="checkbox">
				</td>
			</tr>
			<tr>
				<td class="left">備註</td>
				<td>
					<input type="checkbox">
				</td>
				<td>
					<input type="checkbox">
				</td>
			</tr>
		</tbody>
	</table>


</div>

<script>


	$(document).ready(function () {
		$('.table_REG_TYPE').addClass('d-none');
		if ($('#rdoREG_TYPE1').is(':checked')) {
			$('#table_REG_TYPE1').removeClass('d-none');
		}
		else {
			$('#table_REG_TYPE2').removeClass('d-none');
		}
		
	});

</script>