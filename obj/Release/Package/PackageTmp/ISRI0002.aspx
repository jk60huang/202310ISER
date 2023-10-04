<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master"
	AutoEventWireup="true" CodeBehind="ISRI0002.aspx.cs"
	Inherits="ISRE.ISRI0002" %>

<%--this page is for backend activity info and sesseion list--%>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
 
	<main>
		<div class="my-2"> 

			<div id="ActivityInfo" runat="server">
				<!-- #Include virtual="ISRI_ActivityInfo.aspx" -->
			</div>
			 
			<%--   session list   start--%>
			<div class="d-flex  justify-content-between  align-items-center mt-5 ">
				<div></div>
				<h3 class="text-center ">場次列表</h3>
				<a href="ISRI0003.aspx" class="btn btn-Create btn-primary-isre px-3">新增場次</a>
			</div>

			<%--session list title columns start --%>
			<div class="   card p-2  my-2 d-none d-lg-block bg-ice  ">

				<div class="row  text-center  d-flex align-items-center ">
					<div class=" col-lg-1  ">
						<span>場次 </span>
					</div>
					<div class=" col-lg-2   ">
						<span>日期時間</span>
					</div>
					<div class=" col-lg-1   ">
						<span>地點</span>
					</div>
					<div class=" col-lg-1    ">
						<span>報名<br />
							截⽌⽇</span>
					</div>

					<div class=" col-lg-1       ">
						<span>可報名<br />
							⼈數</span>
					</div>
					<div class=" col-lg-1      ">
						<span>已報名<br />
							⼈數</span>
					</div>

					<%--<div class=" col-lg-1 text-center ">
							<span>議程/資料</span>
						</div>--%>
					<div class=" col-lg-1    ">
						<span>尚餘名額</span>
					</div>

					<div class=" col-lg-4  ">
						<span>編輯/管理</span>
					</div>

				</div>

			</div>

			<%-- session list title columns end--%>



			<%--session list start  --%>
			<%  
				string GUID =   Request.QueryString["GUID"] ?? ""; ;/////////GUID= activity guid
				dynamic sessions = Process_SessionList(GUID);
				foreach (var item in sessions)
				{
			%>

			<div class="   card p-2  my-2     ">
				<div class=" row d-flex align-items-center  ">
					<div class="col-12  col-sm-5  col-lg-1 ">
						<div class="row  d-flex align-items-center ">
							<span class="d-lg-none col-4  col-sm-5   ">
								<span class="badge bg-info">場次</span>
							</span>
							<div class="col-8  col-sm-7  col-lg-12 ">
								<div class="d-flex justify-content-lg-center">
									4  
								</div>
							</div>
						</div>
					</div>
					<div class="col-12  col-sm-7  col-lg-2 ">
						<div class="row  d-flex align-items-center ">
							<span class="d-lg-none  col-4  col-sm-5    ">
								<span class="badge bg-info">日期時間</span>
							</span>
							<div class="col-8  col-sm-7 col-lg-12    ">
								<div class="d-flex justify-content-lg-center">
									112/08/31 09:00
								</div>
							</div>
						</div>
					</div>
					<div class="col-12 col-lg-1  col-sm-5">
						<div class="row  d-flex align-items-center ">
							<span class="d-lg-none col-4  col-sm-5   ">
								<span class="badge bg-info">地點</span>
							</span>
							<div class="col-8    col-sm-7  col-lg-12     ">
								<div class="d-flex justify-content-lg-center">台北市 </div>
							</div>
						</div>
					</div>
					<div class="col-12 col-lg-1 col-sm-7 ">
						<div class="row  d-flex align-items-center ">
							<div class="d-lg-none col-4  col-sm-5   ">
								<span class="badge bg-info">報名截⽌⽇</span>
							</div>
							<div class="col-8  col-sm-7  col-lg-12     ">
								<div class="d-flex justify-content-lg-center">112/08/31  </div>
							</div>
						</div>
					</div>

					<div class="col-12 col-lg-1  col-sm-5">
						<div class="row  d-flex align-items-center ">
							<div class="d-lg-none  col-4  col-sm-5   ">
								<span class="badge bg-info">可報名⼈數</span>
							</div>
							<div class="col-8  col-sm-7  col-lg-12    ">
								<div class="d-flex justify-content-lg-center">
									<div class="badge bg-primary">21</div>
								</div>
							</div>
						</div>
					</div>

					<div class="col-12 col-lg-1  col-sm-7">
						<div class="row  d-flex align-items-center ">
							<div class="d-lg-none col-4  col-sm-5   ">
								<span class="badge bg-info">已報名⼈數</span>
							</div>
							<div class="col-8  col-sm-7 col-lg-12   ">
								<div class="d-flex justify-content-lg-center">
									<div class="badge bg-success">7</div>
								</div>
							</div>
						</div>
					</div>
					<%--<div class="col-12 col-lg-1 ">
							<div class="row ">
								<div class="d-lg-none  col-4  col-sm-2   ">
									<span class="badge bg-info">活動資料</span>
								</div>
								<div class="col-8 col-lg-12 ">
									<div class="  text-center ">
										<div class="d-flex justify-content-lg-center">21  </div>
									</div>
								</div>
							</div>
						</div>--%>
					<div class="col-12 col-lg-1  col-sm-5 ">
						<div class="row  d-flex align-items-center ">
							<div class="d-lg-none  col-4  col-sm-5    ">
								<span class="badge bg-info">尚餘名額</span>
							</div>
							<div class="col-8  col-sm-7  col-lg-12   ">
								<div class="d-flex justify-content-lg-center">
									<div class="badge bg-dark">14</div>
								</div>
							</div>
						</div>
					</div>

					<div class="col-12 col-lg-4 mt-5 mt-lg-0 ">
						<div class="row   d-flex align-items-center  ">
							<div class="col d-flex justify-content-between">

								<a guid="<%:item.GUID %>"
									href="ISRI0003.aspx?SESSIONGUID=<%:item.GUID%>&GUID=<%:GUID %>"
									class="btn btn-primary-isre text-nowrap mx-1  px-2">編輯
									<i class="fa-solid fa-pen-to-square"></i>
								</a>


								<a guid="<%:item.GUID %>"
									href="ISRI0004.aspx?SESSIONGUID=<%:item.GUID%>&GUID=<%:GUID %>"
									class="btn btn-primary-isre text-nowrap mx-1  px-2 ">報名表
									<i class="fa-solid fa-gear"></i>
								</a>


								<a guid="<%:item.GUID %>"
									href="ISRI0005.aspx?SESSIONGUID=<%:item.GUID%>&GUID=<%:GUID %>"
									class="btn btn-primary-isre text-nowrap mx-1  px-2">報到
									<i class="fa-solid fa-list-check"></i>
								</a>


							</div>
						</div>
					</div>
				</div>
			</div>
			<%} %>

			<%--   session list   end--%>
		</div>

	</main>





	<script> 

		$(document).ready(function () {

			$(document).on('click', '#btn_Clear', function (e) {
				$('#cardInput').find('input[type=text]').val('');
			});



		});

	</script>
</asp:Content>
