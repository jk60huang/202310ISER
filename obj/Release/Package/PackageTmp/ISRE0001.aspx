<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master"
	AutoEventWireup="true" CodeBehind="ISRE0001.aspx.cs"
	Inherits="ISRE.ISRE0001" %>

<%--this page is for frontend activity and session list--%>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
	<%
		string GUID = Request.QueryString["GUID"] ?? "";  /////////GUID=activity guid 
	%>
	 <style>
			.table td
			{
				text-align:left !important;
				vertical-align:top !important;
				padding:4px !important;
			}
	 </style>
	
	<main aria-labelledby="title">


		<div class="">
			<h3 class="text-center my-2">活動主題</h3>
			<%

				dynamic Activity = Process_ActivityInfo(GUID);
			%>
			<h5 class="text-center my-4">0524「東區第⼆、三類投保單位承保業務說明會」視訊會議</h5>


			<%-- @*banner*@--%>
			<div class="text-center">
				<img src="https://localhost:444/images/even-banner-img.png" alt="" width="100%">
			</div>

			<%-- @*活動說明*@--%>
			<div>
				<div class="card p-2  my-2  mt-4 bg-ice">
					 活動說明 
				</div>
				<div class="my-2 d-flex ">
					<ol>
						<li>為利⼆三類業務承辦⼈員熟悉健保承保法規與業務，本組特以Microsoft Teams軟
                                體辦理視訊說明會，採網路報名⾄5⽉19⽇截⽌。
						</li>
						<li>會議連結預計5⽉22⽇寄⾄您於報名網站登錄的電⼦郵件信箱，另將於5⽉23⽇
                                14:00~14:30召開測試會議，屆時請開啟郵件連結，以來賓⾝分登入並輸入【投保單位
                                代號+姓名】即可參與，務請撥宂參與測試。
						</li>
						<li>簡報資料預計5⽉23⽇上架，請⾄本報名系統下⽅之「活動資料」下載。</li>
						<li>說明會當⽇如遇颱風、豪雨或其他不可抗拒之因素，經轄區縣市政府宣布停班時，
                                說明會將延期辦理，本組將以報名網站登錄的電⼦郵件信箱另⾏通知。
						</li>
					</ol>
				</div>
			</div>

			<%-- @*參加對象*@--%>
			<div>
				<div class="card p-2  my-2  mt-4 bg-ice">
					 參加對象 
				</div>
				<div class="my-2   font85  px-3">
					花蓮縣及台東縣⼆、三類投保單位業務承辦⼈員
				</div>
			</div>
			 

			<%--  @*主辦單位*@--%>
			<div>
				<div class="card p-2  my-2  mt-4 bg-ice">
					 相關資訊 
				</div>
				<div class="my-2 px-3">
					<div class=" d-flex">
						<div class="">
							<span class="badge bg-info">主辦單位</span>
						</div>
						<div class="ms-2">承保服務科 </div>
					</div>
					<div class=" d-flex">
						<div class="">
							<span class="badge bg-info">協辦單位</span>
						</div>
						<div class="ms-2">協辦單位 </div>
					</div>
					<div class=" d-flex">
						<div class="">
							<span class="badge bg-info">洽詢專線</span>
						</div>
						<div class="ms-2">03-8332111轉1002梁⼩姐 (東區業務組承保服務科)</div>
					</div>
				</div>
			</div>


		</div>



		<%--session list title columns start --%>
		<div class="card  mt-4 d-lg-none">
			 <div class="card-header ">場次列表</div>
		</div>
		<div class="  card mt-4 p-2  my-2 d-none d-lg-block bg-ice ">
			 
				<div class="row   text-center  d-flex align-items-center  ">
					<div class=" col-lg-1 ">
						<span>場次 </span>
					</div>
					<div class=" col-lg-3   ">
						<span>日期時間</span>
					</div>
					<div class=" col-lg-1   ">
						<span>地點</span>
					</div>
					<div class=" col-lg-1     ">
						<span  >報名截⽌⽇</span>
					</div>
					<div class=" col-lg-2   ">
						<span>議程/資料</span>
					</div>
					<div class=" col-lg-1     ">
						<span>尚餘名額</span>
					</div>

					<div class=" col-lg-3  ">
						<span>報名</span>
					</div>

				</div>
			 
		</div>

		<%-- session list title columns end--%>

		<%--session list start  --%>
		<%  
			dynamic sessions = Process_SessionList(GUID);
			foreach (var item in sessions)
			{
		%>
		 
			<div class="    card p-2  my-2      ">
				<div class=" row  d-flex align-items-center session ">
					<div class="col-12 col-sm-5 col-lg-1 ">
						<div class="row  d-flex align-items-center  ">
							<span class="d-lg-none col-4     ">
								<span class="badge bg-info">場次</span>
							</span>
							<div class="col-8    col-lg-12 ">
								<div class="d-flex justify-content-lg-center">
									<%:item.SESS_Serial_NO??"" %>
								</div>
							</div>
						</div>
					</div>
					<div class="col-12  col-sm-7  col-lg-3 ">
						<div class="row   d-flex align-items-center ">
							<span class="d-lg-none  col-4     ">
								<span class="badge bg-info">日期時間</span>
							</span>
							<div class="col-8 col-lg-12   ">
								<div class="d-flex justify-content-lg-center">112/08/31 09:00-15:30</div>
							</div>
						</div>
					</div>
					<div class="col-12 col-sm-5  col-lg-1 ">
						<div class="row  d-flex align-items-center  ">
							<span class="d-lg-none  col-4     ">
								<span class="badge bg-info">地點</span>
							</span>
							<div class="col-8 col-lg-12     ">
								<div class="d-flex justify-content-lg-center">台北市 </div>
							</div>
						</div>
					</div>
					<div class="col-12 col-sm-7  col-lg-1 ">
						<div class="row  d-flex align-items-center ">
							<div class="d-lg-none  col-4      ">
								<span class="badge bg-info">報名截⽌⽇</span>
							</div>
							<div class="col-8 col-lg-12   ">
								<div class="d-flex justify-content-lg-center">112/08/31  </div>
							</div>
						</div>
					</div>

					<div class="col-12 col-sm-5  col-lg-2 ">
						<div class="row   d-flex align-items-center ">
							<div class="d-lg-none  col-4    ">
								<span class="badge bg-info">議程/資料</span>
							</div>
							<div class="col-8 col-lg-12 "> 
									<div class="d-flex justify-content-lg-center">
									<a href="#" class="  btn-showSchedule ">議程/資料
										  <i class="fa-solid fa-chevron-down btn-primary"></i>
									</a>	 
									</div>
								 
							</div>
						</div>
					</div>
					<div class="col-12 col-sm-7  col-lg-1 ">
						<div class="row   d-flex align-items-center ">
							<div class="d-lg-none  col-4   ">
								<span class="badge bg-info">尚餘名額</span>
							</div>
							<div class="col-8 col-lg-12   ">
								<div class="d-flex justify-content-lg-center">
									<div class="badge bg-primary">21</div>
								</div>
							</div>
						</div>
					</div>

					<div class="col-12  showSchedule collapse ">
						<div class="row   d-flex align-items-center  ">
							 
							<div class="  col-lg-12   ">
								<div class="row     ">
									<div class="col-12  col-md-6">
										 <div class="card  m-2   h-100 ">
											<div class="card-header">議程</div>
											<div class="card-body">
												<div class="   table-responsive">
													<table class="schedule table  table-borderless table-info ">
														 
														<tbody>
															<tr>
																<td class="time-td">10:30~10:40</td>
																<td>主席致詞</td>
															</tr>
															<tr>
																<td class="time-td">10:40~10:50</td>
																<td>本署政策暨廉政業務宣導、「健保好夥伴。五恁真好」活動說明</td>
															</tr>
															<tr>
																<td class="time-td">10:50~11:20</td>
																<td>⼆三類承保業務說明</td>
															</tr>
															<tr>
																<td class="time-td">11:20~11:30</td>
																<td>休息</td>
															</tr>
															<tr>
																<td class="time-td">11:30~11:50</td>
																<td>⼆三類多憑證網路承保業務</td>
															</tr>
															<tr>
																<td class="time-td">11:50~12:00</td>
																<td>弱勢協助措施</td>
															</tr>
														</tbody>
													</table>
												</div>

											</div>

										</div> 
										
										
									</div>
									<div class="col-12 col-md-6">
									 	 <div class="card   m-2  h-100 "> 
											<div class="card-header">資料</div>
											<div class="card-body">
												<div class="badge   bg-secondary p-2 m-2">簡報.pdf　</div>
												<div class="badge bg-secondary p-2 m-2"> 高雄場議程表發函附件.pdf　</div>
												<div class="badge bg-secondary p-2 m-2"> 交通位置圖(高雄場).pdf　</div>
												 
											</div>
										</div> 
										
										 
										
									</div>
								</div>
								

							</div>
						</div>
					</div>



					<div class="col-12 col-lg-3 mt-3 mt-lg-0 col-Command">
						<div class="   d-flex align-items-center   justify-content-center mx-sm-5 mx-lg-0 ">
							 

								<% if (sessions.Count == 1)
									{ %>
								 
									<a class="btn disabled px-3   text-nowrap mx-1 btn-SessionSingleRegister">額滿</a>
								 
								<% 	}
									else if (sessions.Count == 2)
									{%>
								 
									<a guid="<%:item.GUID %>"
										href="ISRE0002.aspx?guid=<%:item.GUID %>&RegisterMultiple=2"
										class="btn btn-danger text-nowrap mx-1  ">候補報名</a>
								 
								<% }
									else
									{ %>
								 
									<a guid="<%:item.GUID %>"
										href="ISRE0002.aspx?guid=<%:item.GUID %>&RegisterMultiple=0"
										class="btn btn-primary-isre text-nowrap mx-1 ">單人報名</a>
								 
									<a guid="<%:item.GUID %>"
										href="ISRE0002.aspx?guid=<%:item.GUID %>&RegisterMultiple=1"
										class="btn btn-primary-isre text-nowrap mx-1   ">多人報名 </a>
								 
								<% 	}%>
							 
						</div>
					</div>


				</div>
			</div>

		 

		<%} %>

		<%--  session list end  --%>
	</main>
	<script> 

		$(document).ready(function () {

			$('#btnMore').on('click', function () {
				this.remove();
			});

			$('.btn-showSchedule').on('click', function (e) {
				e.preventDefault();
				let sessionRow = $(this).closest('.session');
				let colShowSchedule = sessionRow.find('.showSchedule');
				let colCommand = sessionRow.find('.col-Command');
				let hasClassCollapse = colShowSchedule.hasClass('collapse');
				if (hasClassCollapse) {  /////need to  show
					colShowSchedule.removeClass('collapse');
					colCommand.removeClass('col-lg-3').addClass('mb-5');
					colCommand.find('.btn').addClass('mx-md-5 mt-5');
					MoveTo(colShowSchedule);
					$(this).children().removeClass('fa-chevron-down').addClass('fa-chevron-up');
				}
				else { //////// need to hide
					MoveTo(sessionRow); 
					 
					colShowSchedule.addClass('collapse');  
					colCommand.addClass('col-lg-3 ').removeClass('mb-5');
					colCommand.find('.btn').removeClass('mx-md-5 mt-5');
					$(this).children().removeClass('fa-chevron-up').addClass('fa-chevron-down');
				} 
			});
 


		});

	</script>
</asp:Content>
