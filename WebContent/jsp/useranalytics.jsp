<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="Mosaddek">
<meta name="keyword" content="FlatLab, Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">
<title>Insert title here</title>
<!-- Bootstrap core CSS -->
<link href="/obigoProject/css/bootstrap.min.css" rel="stylesheet">
<link href="/obigoProject/css/bootstrap-reset.css" rel="stylesheet">
<!--external css-->
<link href="/obigoProject/assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
<link href="/obigoProject/assets/morris.js-0.4.3/morris.css" rel="stylesheet" />
<!--right slidebar-->
<link href="/obigoProject/css/slidebars.css" rel="stylesheet">
<!-- Custom styles for this template -->
<link href="/obigoProject/css/style.css" rel="stylesheet">
<link href="/obigoProject/css/style-responsive.css" rel="stylesheet" />
<link href="https://cdn.datatables.net/1.10.13/css/jquery.dataTables.min.css" rel="stylesheet" />
<!--     <link href="/obigoProject/assets/morris.js-0.4.3/morris.css" rel="stylesheet" /> -->

<style type="text/css">
#myTable_wrapper {
	margin-left: 0px;
	width: 80%;
}
</style>
</head>
<body>

	<!--header start-->
	<jsp:include page="/jsp/header/header.jsp"></jsp:include>
	<!--header end-->

	<!-- Select Box에 현재 년도와 1년전 년도를 표시하기 위함 -->
	<jsp:useBean id="toYear" class="java.util.Date" />
	<fmt:formatDate value="${toYear}" pattern="yyyy" var="nowYear" />
	
	<section id="container" class="">
		<!--main content start-->

		<section id="main-content">
			<section class="wrapper site-min-height">
				<div id="morris">
					<div class="row">
						<!-- page start-->
						<div class="col-lg-6" style="width: 1500px;">
							<section class="panel">
								<header class="panel-heading">
									사용자 접속 통계
									<span id="head-userid"></span>
								</header>
								<div class="panel-body">
									
									<!-- ------- 사용자 접속 통계의 대상이 되는 년도를 바꾸는 Select Box start ------- -->
									<form action="/obigoProject/useranalytics" id="frmSelectYear">
										<label>검색 년도: </label>&nbsp; &nbsp;
										<select id="selectYear" name="selectYear" onchange="changeYear()">
											<c:choose>
												<c:when test="${param.selectYear==nowYear}">
													<option value="${nowYear}" selected>${nowYear}년</option>
													<option value="${nowYear-1}">${nowYear-1}년</option>
												</c:when>
												<c:when test="${param.selectYear==nowYear-1}">
													<option value="${nowYear}">${nowYear}년</option>
													<option value="${nowYear-1}"  selected>${nowYear-1}년</option>
												</c:when>
												<c:otherwise>
													<option value="${nowYear}" selected>${nowYear}년</option>
													<option value="${nowYear-1}">${nowYear-1}년</option>
												</c:otherwise>
											</c:choose>
										</select>
										<input type="submit" hidden="hidden">
									</form>
									<!-- ------- 사용자 접속 통계의 대상이 되는 년도를 바꾸는 Select Box end ------- -->
									
									<!-- ------- User 접속 통계 start ------- -->
									<div id="hero-bar" class="graph"></div>
									<!-- ------- User 접속 통계 end ------- -->
								</div>
							</section>
						</div>
						<!-- page end-->
					</div>
				</div>
				<section class="panel" style="width: 1470px;">
					<header class="panel-heading">
						<form action="">
							<label>Search User ID:&nbsp;&nbsp; </label>
							<input type="text" id="searchId" style="width: 150px;" onkeyup="searchUserId()">
							<input type="text" style="display: none;" />
						</form>
					</header>
					<div class="panel-body">
						<table id="myTable">
							<thead>
								<tr>
									<th>User ID</th>
									<th>Password</th>
									<th>Name</th>
									<th>Email</th>
									<th>Phone</th>
									<th>Role Name</th>
									<th>Date</th>
								</tr>
							</thead>
						</table>
					</div>
				</section>
			</section>
		</section>
		<!--main content end-->

		<!--footer start-->
		<jsp:include page="/jsp/header/footer.jsp"></jsp:include>
		<!--footer end-->

	</section>

	<!-- js placed at the end of the document so the pages load faster -->
	<script src="/obigoProject/js/jquery.js"></script>
	<script src="/obigoProject/js/jquery-ui-1.9.2.custom.min.js"></script>
	<script src="/obigoProject/js/jquery-migrate-1.2.1.min.js"></script>
	<!--<script src="js/jquery-1.8.3.min.js"></script>-->
	<script src="/obigoProject/js/bootstrap.min.js"></script>
	<script class="include" type="text/javascript" src="/obigoProject/js/jquery.dcjqaccordion.2.7.js"></script>
	<script src="/obigoProject/js/jquery.scrollTo.min.js"></script>
	<script src="/obigoProject/js/jquery.nicescroll.js" type="text/javascript"></script>
	<script src="/obigoProject/assets/morris.js-0.4.3/morris.min.js" type="text/javascript"></script>
	<script src="/obigoProject/assets/morris.js-0.4.3/raphael-min.js" type="text/javascript"></script>
	<script src="/obigoProject/js/respond.min.js"></script>
	<script type="text/javascript" src="//cdn.datatables.net/1.10.4/js/jquery.dataTables.min.js"></script>
	<!--right slidebar-->
	<script src="/obigoProject/js/slidebars.min.js"></script>

	<!--common script for all pages-->
	<script src="/obigoProject/js/common-scripts.js"></script>

	<!-- script for this page only-->
	<!-- 		<script src="/obigoProject/js/morris-script.js"></script> -->

	<script type="text/javascript">
		var table = null;
		$(document).ready(
		function() {
			// datatables 라이브러리는 사용하는데 table을 사용하기 위해서 initialize 해주는 작업
			table = $("#myTable").DataTable({
				"processing" : true,
				// 				"bDestroy" : true,
				"destroy" : true,
				"bFilter" : false,
				"order" : [ [ 0, "asc" ] ],
				"columnDefs" : [ {
					"width" : "80px",
					"targets" : 4
				}, {
					"width" : "80px",
					"targets" : 5
				} ],
				"ajax" : {
					"url" : "/obigoProject/loginuserlist",
					"data" : {
						"userId" : $("#searchId").val()
					},
					"type" : "POST"
				},
				"columns" : [ {
					"data" : "userId"
				}, {
					"data" : "password",
					"visible" : false
				}, {
					"data" : "name"
				}, {
					"data" : "eMail"
				}, {
					"data" : "phone"
				}, {
					"data" : "roleName"
				}, {
					"data" : "date"
				} ]
			});

			// table의 row를 클릭했을 때 해당된는 row의 User ID에 대한 Login 통계를 보여주는 함수
			$("#myTable tbody").on("click", "tr", function() {
				if ($(this).hasClass("selected")) {
					$(this).removeClass("selected");

					$.ajax({
						type : "post",
						url : "/obigoProject/countuserlogin",
						dataType : "json",
						data : {
							"userId" : "",
							"selectYear":$('#selectYear option:selected').val()
						},
						success : function(data) {
							$("#hero-bar").empty();
							$("#head-userid").text("[All]");
							setUp(data);
						},
						error : function(e) {
							console.log(e);
						}
					});

				} else {
					table.$("tr.selected").removeClass("selected");
					$(this).addClass("selected");
					var userId = $(this).find("td:eq(0)").text();

					// 선택한 User ID의 월별 Login Count를 얻어오는 AJAX
					$.ajax({
						type : "post",
						url : "/obigoProject/countuserlogin",
						dataType : "json",
						data : {
							"userId" : userId,
							"selectYear":$('#selectYear option:selected').val()
						},
						success : function(data) {
							if (userId != "No data available in table") {
								$("#hero-bar").empty();
								$("#head-userid").text("[ID: " + userId + "]");
								setUp(data);
							}
						},
						error : function(e) {
							console.log(e);
						}
					});
				}
			});

			$("#hero-bar").empty();
			$("#head-userid").text("[All]");
			searchUserId();
			
		});

		function changeYear() {
			document.getElementById("frmSelectYear").submit();
		}

		// Text에 입력한 문자열을 포함하는 User ID의 List를 테이블로 보여준다.
		function searchUserId() {

			// Check if table object exists and needs to be flushed
			if (table) { 
				// For new version use table.destroy();
				table.destroy(); 
				// empty in case the columns change
				// table thead에 값이 출력되지 않아서 아래줄을 주석처리 했더니 잘 나옴
				//$('#myTable').empty(); 
			}

			// datatables 라이브러리는 사용하는데 table을 사용하기 위해서 initialize 해주는 작업
			table = $("#myTable").DataTable({
				"processing" : true,
				// 				"bDestroy" : true,
				"destroy" : true,
				"bFilter" : false,
				"order" : [ [ 0, "asc" ] ],
				"columnDefs" : [ {
					"width" : "80px",
					"targets" : 4
				}, {
					"width" : "80px",
					"targets" : 5
				} ],
				"ajax" : {
					"url" : "/obigoProject/loginuserlist",
					"data" : {
						"userId" : $("#searchId").val()
					},
					"type" : "POST"
				},
				"columns" : [ {
					"data" : "userId"
				}, {
					"data" : "password",
					"visible" : false
				}, {
					"data" : "name"
				}, {
					"data" : "eMail"
				}, {
					"data" : "phone"
				}, {
					"data" : "roleName"
				}, {
					"data" : "date"
				} ]
			});

			// table의 row를 클릭했을 때 해당된는 row의 User ID에 대한 Login 통계를 보여주는 함수
			$("#myTable tbody").on("click", "tr", function() {
				if ($(this).hasClass("selected")) {
					$(this).removeClass("selected");

					$.ajax({
						type : "post",
						url : "/obigoProject/countuserlogin",
						dataType : "json",
						data : {
							"userId" : "",
							"selectYear":$('#selectYear option:selected').val()
						},
						success : function(data) {
							$("#hero-bar").empty();
							$("#head-userid").text("[All]");
							setUp(data);
						},
						error : function(e) {
							console.log(e);
						}
					});

				} else {
					table.$("tr.selected").removeClass("selected");
					$(this).addClass("selected");
					var userId = $(this).find("td:eq(0)").text();

					// 선택한 User ID의 월별 Login Count를 얻어오는 AJAX
					$.ajax({
						type : "post",
						url : "/obigoProject/countuserlogin",
						dataType : "json",
						data : {
							"userId" : userId,
							"selectYear":$('#selectYear option:selected').val()
						},
						success : function(data) {
							if (userId != "No data available in table") {
								$("#hero-bar").empty();
								$("#head-userid").text("[ID: " + userId + "]");
								setUp(data);
							}
						},
						error : function(e) {
							console.log(e);
						}
					});
				}
			});

			if ($("#searchId").val() == "") {
				$.ajax({
					type : "post",
					url : "/obigoProject/countuserlogin",
					dataType : "json",
					data : {
						"userId" : "",
						"selectYear":$('#selectYear option:selected').val()
					},
					success : function(data) {
						$("#hero-bar").empty();
						$("#head-userid").text("[All]");
						setUp(data);
					},
					error : function(e) {
						console.log(e);
					}
				});
			}
		}

		// User Login 통계 그래프를 보여주는 함수
		function setUp(data) {
			$(function() {
				Morris.Bar({
					element : 'hero-bar',
					resize : true,
					data : [ {
						device : 'JAN',
						geekbench : data[0]
					}, {
						device : 'FEB',
						geekbench : data[1]
					}, {
						device : 'MAR',
						geekbench : data[2]
					}, {
						device : 'APR',
						geekbench : data[3]
					}, {
						device : 'MAY',
						geekbench : data[4]
					}, {
						device : 'JUN',
						geekbench : data[5]
					}, {
						device : 'JUL',
						geekbench : data[6]
					}, {
						device : 'AUG',
						geekbench : data[7]
					}, {
						device : 'SEP',
						geekbench : data[8]
					}, {
						device : 'OCT',
						geekbench : data[9]
					}, {
						device : 'NOV',
						geekbench : data[10]
					}, {
						device : 'DEC',
						geekbench : data[11]
					}, ],
					xkey : 'device',
					ykeys : [ 'geekbench' ],
					labels : [ 'Geekbench' ],
					barRatio : 0.4,
					xLabelAngle : 0,
					hideHover : 'auto',
					barColors : [ '#6883a3' ]
				});
			});
		};
	</script>
</body>
</html>