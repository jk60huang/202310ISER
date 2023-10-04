<%-- THIS IS SUB PAGE FOR SESSION INFO --%>
<%
	String SessionGUID = Request.QueryString["SessionGUID"];
	ISRE.ISRE_SESSION_MAIN Model = Process_SessionInfo(SessionGUID); 
%>

<div class="my-2">
	
	<h3 class="text-center mt-5 mb-2">場次資訊  </h3>


	<div class="  card p-2  my-2 d-none d-lg-block bg-ice      ">
		<div class="row text-center   d-flex align-items-center">
			<div class=" col-lg-1  ">
				場次
       
			</div>
			<div class=" col-lg-1 ">
				日期時間
       
			</div>
			<div class=" col-lg-1  ">
				地點
       
			</div>
			<div class=" col-lg-1 ">
				主辦單位
       
			</div>
			<div class=" col-lg-2      ">
				上傳單位限定資料
       
			</div>
			<div class=" col-lg-1      ">
				報名截⽌⽇
       
			</div>

			<div class=" col-lg-2     ">
				可報名⼈數
       
			</div>
			<div class=" col-lg-2     ">
				已報名⼈數
       
			</div>
			<div class=" col-lg-1    ">
				尚餘名額
       
			</div>

		</div>
	</div>


	<div class="    card p-2  my-2     ">
		<div class=" row  d-flex align-items-center  ">
			<div class="col-12 col-sm-5  col-lg-1 ">
				<div class="row  d-flex align-items-center">
					<span class="d-lg-none  col-4 col-sm-5     ">
						<span class="badge bg-info">場次</span>
					</span>
					<div class=" col-8 col-sm-7    col-lg-12 ">
						<div class="d-flex justify-content-lg-center">
							 <%:Model!= null ? Model.SESS_SERIAL_NO :"" %>
						</div>
					</div>
				</div>
			</div>
			<div class="col-12 col-sm-7  col-lg-1 ">
				<div class="row  d-flex align-items-center">
					<span class="d-lg-none   col-4 col-sm-5     ">
						<span class="badge bg-info">日期時間</span>
					</span>
					<div class=" col-8 col-sm-7    col-lg-12  text-center  ">
						<div class="d-flex justify-content-lg-center">112/08/31 </div>
					</div>
				</div>
			</div>
			<div class="col-12 col-sm-5  col-lg-1 ">
				<div class="row  d-flex align-items-center">
					<span class="d-lg-none  col-4 col-sm-5      ">
						<span class="badge bg-info">地點</span>
					</span>
					<div class=" col-8 col-sm-7    col-lg-12   text-center  ">
						<div class="d-flex justify-content-lg-center">台北市 </div>
					</div>
				</div>
			</div>
			<div class="col-12 col-sm-7 col-lg-1 ">
				<div class="row  d-flex align-items-center">
					<span class="d-lg-none    col-4 col-sm-5      ">
						<span class="badge bg-info">主辦單位</span>
					</span>
					<div class=" col-8 col-sm-7    col-lg-12   text-center  ">
						<div class="d-flex justify-content-lg-center">台北市 </div>
					</div>
				</div>
			</div>
			<div class="col-12 col-sm-5 col-lg-2 ">
				<div class="row  d-flex align-items-center">
					<div class="d-lg-none   col-4 col-sm-5       ">
						<span class="badge bg-info">上傳單位限定資料</span>
					</div>
					<div class=" col-8 col-sm-7    col-lg-12  text-center  ">
						<div class="d-flex justify-content-lg-center">單位限定資料.xls  </div>
					</div>
				</div>
			</div>
			<div class="col-12 col-sm-5 col-lg-1 ">
				<div class="row  d-flex align-items-center">
					<div class="d-lg-none   col-4 col-sm-5       ">
						<span class="badge bg-info">報名截⽌⽇</span>
					</div>
					<div class=" col-8 col-sm-7    col-lg-12  text-center  ">
						<div class="d-flex justify-content-lg-center">112/08/31  </div>
					</div>
				</div>
			</div>

			<div class="col-12 col-sm-7 col-lg-2 ">
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
			</div>

			<div class="col-12 col-sm-5 col-lg-2 ">
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
			</div>

			<div class="col-12 col-sm-7 col-lg-1 ">
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
			</div>
		</div>
	</div>

</div>








