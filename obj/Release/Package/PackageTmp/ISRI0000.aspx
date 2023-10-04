<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master"
	AutoEventWireup="true" CodeBehind="ISRI0000.aspx.cs"
	Inherits="ISRE.ISRI0000" %>

<%--this page is for backend activity list--%>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

	<main>
		<section class="mb-2 my-2">
			<div class="d-flex  justify-content-between align-items-center  ">
				<div class="d-none d-sm-block"></div>
				<h3 class="  ">活動清單</h3>

				<a href="ISRI0001.aspx" class=" btn btn-primary-isre   ">新增活動  
				</a>
			</div>
			<div class="d-flex">
				<div class="  ">
					<div>代理人員：</div>
					<select name="agentName" id="agentName" class="form-control form-select">

						<option value=""></option>
						<option value="">王大頭</option>
					</select>
				</div>
				<div class="mx-1 mx-sm-3">
					<div>查詢條件：</div>
					<select name="pagesize" id="pagesize" class="form-control form-select">
						<option value="">最近20筆</option>
						<option value="">全部</option>
					</select>
				</div>
			</div>
		</section>



		<div class="    card p-2  my-2 d-none d-lg-block bg-ice ">

			<div class="row  text-center  ">
				<div class=" col-lg-3">
					<div class=" text-start">活動主題 </div>
				</div>
				<div class=" col-lg-3">
					<div class=" ">活動⽇期區間</div>
				</div>
				<div class=" col-lg-1">
					<div class="   ">總場次</div>
				</div>
				<div class=" col-lg-1 ">
					<div class="   ">主辦單位</div>
				</div>
				<div class=" col-lg-2 ">
					發布⽇期 
					<i class="fas fa-long-arrow-alt-down ms-1 color-isre "></i> 
				</div>
				<div class=" col-lg-2">
					<div class="   ">編輯/管理</div>
				</div>

			</div>

		</div>

		<% 
           dynamic List_Activities =  Process_ActivityList(  1,    1);  
             foreach (var item in List_Activities) 
           { 
		%>

		<div class="    card p-2  my-2   ">
			<div class=" row  d-flex align-items-center  ">
				<div class="col-12 col-lg-3 ">
					<div class="row      ">
						<span class="d-lg-none col-3 col-sm-2   ">
							<span class="badge bg-info">活動主題</span>
						</span>
						<span class="col-9 col-sm-10 col-lg-12 ">
							<%:item.ACT_NAME %>  
						</span>
					</div>
				</div>
				<div class="col-12 col-lg-3 ">
					<div class="row  d-flex align-items-center ">
						<span class="d-lg-none  col-3   col-sm-2  ">
							<span class="badge bg-info">活動⽇期區間</span>
						</span>
						<div class="col-9 col-sm-10 col-lg-12 ">
							<div class="d-block  d-lg-flex     justify-content-lg-center">
								<div class=" ">112/08/31- 112/08/31</div>
							</div>
						</div>


					</div>
				</div>
				<div class="col-12 col-lg-1">
					<div class="row  d-flex align-items-center ">
						<div class="d-lg-none  col-3  col-sm-2   ">
							<div class="badge bg-info">總場次</div>
						</div>
						<div class="col-9 col-sm-10 col-lg-12 ">
							<div class=" d-block  d-lg-flex   justify-content-lg-center">
								<div class="badge bg-warning">12</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-12 col-lg-1 ">
					<div class="row  d-flex align-items-center ">
						<div class="d-lg-none  col-3  col-sm-2   ">
							<div class="badge bg-info">主辦單位</div>
						</div>
						<div class="col-9 col-sm-10 col-lg-12 ">
							<div class="d-block  d-lg-flex   justify-content-lg-center">
								<div class=" ">健保署</div>
							</div>
						</div>
					</div>
				</div>

				<div class="col-12 col-lg-2 ">
					<div class="row  d-flex align-items-center ">
						<span class="d-lg-none  col-3   col-sm-2  ">
							<span class="badge bg-info">發布⽇期</span>
						</span>
						<div class="col-9 col-sm-10 col-lg-12 ">
							<div class=" d-block  d-lg-flex   justify-content-lg-center">
								<div class="  ">112/08/31 </div>
							</div>
						</div>
					</div>
				</div>

				<div class="col-12 col-lg-2">
					<div class=" d-flex justify-content-between mt-3 mt-lg-0 mx-2 mx-sm-5 mx-lg-0">
						<a href="ISRI0001.aspx?GUID=<%:item.GUID %>"
							class="btn btn-primary-isre text-nowrap px-4 px-lg-2 ">編輯
							<i class="fa-solid fa-pen-to-square"></i>
						</a>
						<a href="ISRI0002.aspx?GUID=<%:item.GUID %>"
							class="btn btn-primary-isre text-nowrap px-4 px-lg-2 ">
							場次 
							<i class="fa-solid fa-bars-progress"></i>
						</a>
					</div>
				</div>

			</div>
		</div>


		<% } %>
	</main>

	<script>
    
    $(document).ready(function () {
         

        $('#MainContent_test').on('click', function () {
            var postData = { User: 'JOE', Phone: '0900222333' };
            alert('readt');
          
            var url = "https://localhost:44396/Default.aspx/GetData";
            alert(url);
            $.ajax({
                type: "POST",
                url: url,
             // url: "https://localhost:44396/Default.aspx/GetData",
                data: "{postData:'1'}", 
              //  data: JSON.stringify({ 'postData': postData }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    console.log(data.d);
                    //alert(data);
                }
            });
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

        $("#ACT_DATE_S_DATE, #ACT_DATE_E_DATE").datepicker($.datepicker.regional['zh-TW']);

        $(".collapse").on('show.bs.collapse', function () {
            $('#aFilter').children().addClass('fa-chevron-up').removeClass('fa-chevron-down');
        });

        $(".collapse").on('hide.bs.collapse', function () {
            $('#aFilter').children().addClass('fa-chevron-down').removeClass('fa-chevron-up');
        });
    });

     

	</script>
</asp:Content>
