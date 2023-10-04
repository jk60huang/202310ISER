<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master"
	AutoEventWireup="true" CodeBehind="ISRE0000.aspx.cs"
	Inherits="ISRE.ISRE0000" %>

<%--this page is for frontend activity list--%>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
	<main>
		<section>
			<%--20230927 By Alex Huang --%>
			<div id="dialog" title="訊息">
				<p>Oops 連線失敗，請通知管理人員!</p>
			</div>
			<%--20230927 By Alex Huang --%>

			<div class="d-flex  justify-content-between align-content-center  ">
				<div class="d-none d-sm-block"></div>
				<div>
					<h3 class="text-center my-3">活動報名</h3>
				</div>
				<div class="mt-2">
					<a id="aFilter" href="#Filter" class=" btn btn-primary-isre  px-lg-4 "
						data-bs-toggle="collapse">查詢條件 
                            <i class="fa-solid fa-chevron-down  text-white"></i>
					</a>
				</div>
			</div>

			<div id="Filter" class="collapse ">
				<div class="card">
					<div class="card-body  ">
						<div class="">
							<div class="      row  ">
								<div class="    col-lg-4">
									<div class="row d-flex align-items-center p-2">
										<div class="col-4">
											<div class="    ">
												<label class="text-nowrap">辦理縣市</label>
											</div>
										</div>
										<div class="col-8">
											<div class="  flex-grow-1 ">
												<%--20230923 Modification By Alex Huang --%>
												<asp:DropDownList ID="SESS_LOC" runat="server" CssClass="form-control form-select"></asp:DropDownList>
												<%--20230923 Modification By Alex Huang --%>
											</div>
										</div>
									</div>
								</div>

								<div class="    col-lg-4">
									<div class="row d-flex align-items-center p-2">
										<div class="col-4">
											<div class="    ">
												<label class="text-nowrap">身分別</label>
											</div>
										</div>
										<div class="col-8">
											<div class="  flex-grow-1 ">
												<%--20230923 Modification By Alex Huang --%>
												<asp:DropDownList ID="OBJ_NO" runat="server" CssClass="form-control form-select"></asp:DropDownList>
												<%--20230923 Modification By Alex Huang --%>
											</div>
										</div>
									</div>
								</div>

								<div class="    col-lg-4">
									<div class="row d-flex align-items-center p-2">
										<div class="col-4">
											<div class="    ">
												<label class="text-nowrap">活動類別</label>
											</div>
										</div>
										<div class="col-8">
											<div class="  flex-grow-1 ">
												<%--20230925 Modification By Alex Huang --%>
												<asp:DropDownList ID="ACT_TYPE" runat="server" CssClass="form-control form-select"></asp:DropDownList>
												<%--20230925 Modification By Alex Huang --%>
											</div>
										</div>
									</div>
								</div>
							</div>

							<div class="      row  ">
								<div class="    col-lg-8">
									<div class="row d-flex align-items-center p-2">
										<div class="col-4 col-lg-2">
											<div class="    ">
												<label class="text-nowrap">活動名稱</label>
											</div>
										</div>
										<div class="col-8 col-lg-10">
											<div class="  flex-grow-1 ">
												<%--20230925 Modification By Alex Huang --%>
												<asp:TextBox ID="ACT_NAME" runat="server" CssClass="form-control"></asp:TextBox>
												<%--20230925 Modification By Alex Huang --%>
											</div>
										</div>
									</div>
								</div>

								<div class="    col-lg-4">
									<div class="row d-flex align-items-center p-2">
										<div class="col-4">
											<div class="    ">
												<label class="text-nowrap">主辦單位</label>
											</div>
										</div>
										<div class="col-8">
											<div class="  flex-grow-1 ">
												<%--20230925 Modification By Alex Huang --%>
												<asp:TextBox ID="ACT_HOST" name="ACT_HOST" runat="server" CssClass="form-control"></asp:TextBox>
												<%--20230925 Modification By Alex Huang --%>
											</div>
										</div>
									</div>
								</div>
							</div>

							<div class=" row  ">
								<div class="    col-lg-8">
									<div class="row d-flex align-items-center p-2">
										<div class="col-4 col-lg-2">
											<div class="    ">
												<label class="text-nowrap">活動區間</label>
											</div>
										</div>
										<div class="col-8 col-lg-10">
											<div class="d-lg-flex">
												<div class="d-lg-flex   flex-grow-1">
													<input type="text" id="ACT_DATE_S_DATE" name="ACT_DATE_S_DATE"
														class="form-control " placeholder="民國年/月/日"
														value="<%:  Request["ACT_DATE_S_DATE"] %>">
													<input type="hidden" id="ACT_DATE_S" name="ACT_DATE_S" />
													<span class="mx-1">~</span>
												</div>
												<div class="d-lg-flex  flex-grow-1">
													<input type="text" id="ACT_DATE_E_DATE" name="ACT_DATE_E_DATE"
														class="form-control " placeholder="民國年/月/日"
														value="<%:  Request["ACT_DATE_E_DATE"] %>">
													<input type="hidden" id="ACT_DATE_E" name="ACT_DATE_E" />
												</div>
											</div>
										</div>
									</div>
								</div>

								<div class="  d-lg-none  col-lg-4">
									<div class="row d-flex align-items-center p-2">
										<div class="col-4">
											<div class="    ">
												<label class="text-nowrap">排序</label>
											</div>
										</div>
										<div class="col-8">
											<div class="  flex-grow-1 ">
												<select class="form-control form-select">
													<option>發布⽇期</option>
													<option>活動主題</option>
													<option>活動區間</option>  
												</select>
											</div>
										</div>
									</div>
								</div>

							</div>
						</div>
					</div>
				</div>
				<div class="card-footer d-flex justify-content-center m-4">
					<%-- Modification date : 20230923 By Alex Huang --%>
					<button type="button" id="BtnQuery" name="BtnQuery"
						class="btn btn-primary-isre px-4  mx-4 text-nowrap" runat="server"
						onserverclick="BtnQuery_Click">
						查詢 <i class="fa-solid fa-magnifying-glass text-white"></i>
					</button>
					<button type="button" id="btnClear"
						class="btn btn-primary-isre px-4 mx-4 text-nowrap">
						清除                    
					</button>
					<%-- Modification date : 20230923 By Alex Huang --%>
				</div>
			</div>
		</section>

		<div
			runat="server"
			id="SearchCriteria"
			class="card mb-2">
			<div class="card-body d-flex align-items-start">
				<div>
					<div class="badge bg-info me-2">搜尋條件</div>
				</div>

				<div>
					<!--earch criteria-->
					<asp:Literal ID="LiteralSearchCriteriaData" runat="server"></asp:Literal>
				</div>

			</div>
		</div>

		<h5 class="my-2  text-center" runat="server" id="SearchResult">查詢結果</h5>
		<div class="  card  d-none d-lg-block ">
			<div class="card-header ">
				<div class="row no-gutters  ">
					<div class=" col-lg-5">
						<div class=" ">
							活動主題
						</div>
					</div>
					<div class=" col-lg-2">
						<div class=" text-center ">活動區間</div>
					</div>
					<div class=" col-lg-1">
						<div class=" text-center ">尚餘名額</div>
					</div>
					<div class=" col-lg-2    ">
						<div class=" text-center ">
							發布⽇期
                            <i class="fas fa-long-arrow-alt-down mx-1" style="color: #197584"></i>
						</div>
					</div>
					<div class=" col-lg-2"></div>

				</div>
			</div>
		</div>

		<%  
			//dynamic List_Activities = GetProcess_ActivityList(1, 1);
			if (List_Activities != null)
			{
				foreach (var item in List_Activities)
				{ %>
		<div class="border rounded my-1 py-1">
			<div class="    card m-1 border-0   ">
				<div class=" row no-gutters  ">
					<div class="col-12 col-lg-5 ">
						<div class="row no-gutters">
							<span class="d-lg-none col-4 col-sm-2   ">
								<span class="badge bg-info">活動主題</span>
							</span>
							<span class="col-8 col-sm-10">
								<%:item.ACT_NAME %> 
							</span>
						</div>
					</div>
					<div class="col-12 col-lg-2 ">
						<div class="row no-gutters">
							<span class="d-lg-none  col-4   col-sm-2  ">
								<span class="badge bg-info">活動區間</span>
							</span>
							<div class="col-8 col-sm-10 col-lg-12 ">
								<div class=" d-flex  d-lg-block">
									<div class="text-center">112/08/31-112/12/31 </div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-12 col-lg-1 d-none d-lg-block">
						<div class="row no-gutters">
							<div class="d-lg-none  col-4  col-sm-2   ">
								<div class="badge bg-info">尚餘名額</div>
							</div>
							<div class="col-8 col-sm-10 col-lg-12 ">
								<div class=" d-flex  d-lg-block">
									<div class="text-center">
										<div class="badge bg-primary">
											122
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-12 col-lg-2 ">
						<div class="row no-gutters">
							<div class="d-lg-none  col-4  col-sm-2   ">
								<div class="badge bg-info">發布⽇期</div>
							</div>
							<div class="col-8 col-sm-10 col-lg-12 ">
								<div class=" d-flex  d-lg-block">
									<div class="text-center">112/08/31 </div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-12 col-lg-2 mt-3 mt-lg-0">
						<div class="row no-gutters">
							<div class="col d-flex justify-content-around">
								<div class="d-flex">
									<%-- <a href="/isre0001.aspx?guid=this&multiple=1"  class="btn btn-primary-isre text-nowrap mx-1"> 查場次  </a> --%>

									<a href="ISRE0001.aspx?GUID=<%:item.GUID %> "
										class="btn btn-primary-isre text-nowrap mx-1 px-3">檢視場次<span class="d-lg-none badge bg-warning mx-1"><%:item.TotalSessionNo %></span>

									</a>
								</div>
							</div>

						</div>
					</div>

				</div>
			</div>

		</div>


		<%}
			}

		%>
	</main>

	<script> 
		$(document).ready(function () {
			$(document).on('click', '#btnClear', function () {
				$(this).closest('section').find('input, select').each(function () { 
					$(this).val('');
				}); 
			});
			$("#ACT_DATE_S_DATE, #ACT_DATE_E_DATE").datepicker($.datepicker.regional['zh-TW']);

			$(".collapse").on('show.bs.collapse', function () {
				$('#aFilter').children().addClass('fa-chevron-up').removeClass('fa-chevron-down');
			});

			$(".collapse").on('hide.bs.collapse', function () {
				$('#aFilter').children().addClass('fa-chevron-down').removeClass('fa-chevron-up');
			});
			$("#dialog").dialog({
				autoOpen: false,
				show: {
					effect: "blind",
					duration: 1000
				},
				hide: {
					effect: "explode",
					duration: 1000
				}
			});
			//$("#dialog").dialog("open");

			//function Showalert() {
			//    alert('Call JavaScript function from codebehind');
			//}
		});
	</script>
</asp:Content>
