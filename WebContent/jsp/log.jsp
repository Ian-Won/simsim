<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="shortcut icon" type="image/ico" href="/obigoProject/img/favicon.ico">

<style type="text/css">
td {
	white-space: nowrap;
	text-overflow: ellipsis;
	overflow: hidden;
}

.select_box_group {
	margin-left: 800px;
	width: 28em;
}

#loading {
	border: 0;
	display: none;
	text-align: center;
	filter: alpha(opacity = 60);
	opacity: alpha*0.6;
	filter: alpha(opacity = 60);
}
</style>
<meta charset="UTF-8">
<title>Log</title>
</head>
<body>

	<!--header start-->
	<jsp:include page="/jsp/header/header.jsp"></jsp:include>
	<!--header end-->

	<!-- 메일 전송하는 동안 띄워줄 이미지 -->
	<div id="loading">
		<img src="/obigoProject/img/loading.gif" />
	</div>

	<section id="container" class="">
		<!--main content start-->
		<section id="main-content">
			<section class="wrapper site-min-height">
				<!-- page start-->
				<section class="panel">
					<header class="panel-heading"> Log </header>
					<div class="panel-body">
						<div class="clearfix">
							<div class="btn-group">
								<a class="btn btn-success" data-toggle="modal" href="javascript:deleteLog();"> Delete All Log <i class="fa fa-minus"></i>
								</a>
							</div>

							<!-- -------------- Log Modal start -------------- -->
							<div class="modal fade " id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
											<h4 class="modal-title">Returned Api</h4>
										</div>
										<div class="modal-body">
											<form class="form-signin" id="form-insertapi" action="/obigoProject/insertapi" onsubmit="return check();" method="POST">
												<div class="login-wrap">
													<div class="form-group">
														<span class="label label-primary">URL</span>
														<input type="text" name="apiUrl" id="apiUrl" class="form-control" readonly="readonly">
													</div>
													<div class="form-group">
														<span class="label label-primary">BODY</span>
														<input type="text" name="apiBody" id="apiBody" class="form-control" readonly="readonly">
													</div>
													<div class="form-group">
														<span class="label label-primary">Date Time</span>
														<input type="text" name="apiDateTime" id="apiDateTime" class="form-control" readonly="readonly">
													</div>
													<div class="form-group">
														<span class="label label-primary">RETRUNED</span>
														<textarea name="returned" id="returned" class="form-control" placeholder="Response To Send" rows="15" cols="45" readonly="readonly" style="font-size: 11px; text-align: left;"></textarea>
													</div>
												</div>
											</form>
										</div>
										<div class="modal-footer">
											<button data-dismiss="modal" class="btn btn-default" type="button">Close</button>
										</div>
									</div>
								</div>
							</div>
							<!-- -------------- Log Modal end -------------- -->

							<!-- -------------- PDF 관련 Dropdown Button start -------------- -->
							<div class="btn-group pull-right">
								<button class="btn dropdown-toggle" data-toggle="dropdown">
									PDF flie <i class="fa fa-angle-down"></i>
								</button>
								<ul class="dropdown-menu pull-right">
									<li><a href="javascript:viewPdf();" target="_blank">View on PDF</a></li>
									<!--                            <li><a href="/obigoProject/pdfmail">Send an Email to Admin</a></li> -->
									<li><a href='javascript:void(0);' onclick="mailToAdmin();">Send an Email to Admin</a></li>
								</ul>
							</div>
							<!-- -------------- PDF 관련 Dropdown Button end -------------- -->
						</div>
						<br>
						<div class="btn-group pull-right">
							<!-- ----- Select Box(Category) start ----- -->
							&nbsp;&nbsp;&nbsp; <label>Year : </label> <select id="selectYear" name="selectYear">
								<option value="%">Select Year</option>
								<option value="16">2016</option>
								<option value="17">2017</option>
							</select>
							<!-- ----- Select Box(Category) end ----- -->

							<!-- ----- Select Box(Location) start ----- -->
							&nbsp;&nbsp;&nbsp; <label>Month : </label> <select id="selectMonth" name="selectMonth">
								<option value="%">Select Month</option>
								<option value="01">01</option>
								<option value="02">02</option>
								<option value="03">03</option>
								<option value="04">04</option>
								<option value="05">05</option>
								<option value="06">06</option>
								<option value="07">07</option>
								<option value="08">08</option>
								<option value="09">09</option>
								<option value="10">10</option>
								<option value="11">11</option>
								<option value="12">12</option>
							</select>
							<!-- ----- Select Box(Location) end ----- -->
						</div>

						<!-- table 자동정렬해주는 javascript 파일에서 어느 항목의 table인지 구분하기 위한 hidden -->
						<input type="hidden" id="hidden-log">
						<div class="space15"></div>

						<!-- -------------- Log Table start -------------- -->
						<div class="panel-body">
							<section id="flip-scroll">
								<table id="target" class="table table-bordered table-striped table-condensed cf" style="table-layout: fixed; word-break: break-all;">
									<thead class="cf">
										<tr>
											<th>Url</th>
											<th>Body</th>
											<th>Date Time</th>
											<th style="width: 800px;">Return</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="l" items="${logList}" begin="0" varStatus="status">
											<c:set var="error" value="${l.url}" />
											<c:choose>
												<c:when test="${error eq '/api/errorlog' }">
													<tr class="" style="color: red">
												</c:when>
												<c:otherwise>
													<tr class="">
												</c:otherwise>
											</c:choose>
											<td id="url${status.index}" onclick="javascript:showModal(${status.index});" style="cursor: pointer;">${l.url}</td>
											<td id="body${status.index}" class="center" onclick="javascript:showModal(${status.index});" style="cursor: pointer;">${l.body}</td>
											<td id="datetime${status.index}" class="center" onclick="javascript:showModal(${status.index});" style="cursor: pointer;">${l.dateTime}</td>
											<td id="returned${status.index}" class="center" onclick="javascript:showModal(${status.index});" style="cursor: pointer;">${l.returned}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</section>
						</div>
						<!-- -------------- Log Table end -------------- -->
					</div>
				</section>
				<!-- page end-->

				<div class="text-center">
					<!-- -------- log 검색 start -------- -->
					<form id="searchlog-frm" action="/obigoProject/log" method="get">
						<input name="page" type="hidden" value="1">
						<input name="query" type="text">
						<button type="submit">Search</button>
					</form>
					<!-- -------- log 검색 end -------- -->

					<!-- -------- log table paging start -------- -->
					<ul class="pagination">
						<li><a href="javascript:frontButton('${endPageNum}', '${param.query}')">«</a></li>
						<c:forEach var="l" items="${pageList}" begin="0" varStatus="status">
							<li id="page${status.index}" value="${l}"><a href="javascript:movePage('${l}', '${param.query}')">${l}</a></li>
						</c:forEach>
						<li><a href="javascript:backButton('${endPageNum}', '${param.query}')">»</a></li>
					</ul>
					<!-- -------- log table paging end -------- -->
				</div>
			</section>
		</section>
		<!--main content end-->

		<!--footer start-->
		<jsp:include page="/jsp/header/footer.jsp"></jsp:include>
		<!--footer end-->
	</section>

	<!-- js placed at the end of the document so the pages load faster -->
	<script src="/obigoProject/js/jquery.js"></script>
	<script src="/obigoProject/js/bootstrap.min.js"></script>
	<script class="include" type="text/javascript" src="/obigoProject/js/jquery.dcjqaccordion.2.7.js"></script>
	<script src="/obigoProject/js/jquery.scrollTo.min.js"></script>
	<script src="/obigoProject/js/respond.min.js"></script>
	<script src="/obigoProject/js/jquery.nicescroll.js" type="text/javascript"></script>

	<!--right slidebar-->
	<script src="/obigoProject/js/slidebars.min.js"></script>

	<!--common script for all pages-->
	<script src="/obigoProject/js/common-scripts.js"></script>
	<!--script for this page only-->
	<script src="/obigoProject/js/gritter.js" type="text/javascript"></script>
	<script src="/obigoProject/js/pulstate.js" type="text/javascript"></script>

	<script type="text/javascript">
	
	
		// Log 테이블의 한 row를 클릭시 해당 Log를 Modal로 자세히 볼 수 있다 
		function showModal(status) {
			$("#apiUrl").val($("#url" + status).text());
			$("#apiBody").val($("#body" + status).text());
			$("#apiDateTime").val($("#datetime" + status).text());
			$("#returned").val($("#returned" + status).text());
			$("#myModal").modal();
		}
	
		// Log 삭제여부를 확인하고 true=삭제 false=취소
		function deleteLog() {
			if (confirm("전체 로그를 정말 삭제하시겠습니까?") == true) { //확인
				$.ajax({
					type : "post",
					url : "/obigoProject/deletelog",
					dataType : "json",
					data : {},
					success : function(data) {
						location.reload();
					}
				});
			} else { //취소
				return;
			}
		}
	
		// Admin mail 주소로 Email 발송 true=성공, false=실패 
		function mailToAdmin() {
			$.ajax({
				type : "post",
				url : "/obigoProject/pdfmail",
				dataType : "json",
				async : true,
				data : {
					"year" : $('#selectYear').val(),
					"month" : $('#selectMonth').val()
				},
				success : function(data) {
					if (data.flag == true)
						alert("이메일 보내기 성공");
					else
						alert("이메일 보내기 실패");
				},
				beforeSend : function() {
					//통신을 시작할때 처리
					$('#loading').css('position', 'absolute');
					$('#loading').css('left', $('#target').offset().left);
					$('#loading').css('top', $('#target').offset().top);
					$('#loading').css('width', $('#target').css('width'));
					$('#loading').css('height', $('#target').css('height'));
					$('#loading').show().fadeIn('fast');
				},
				complete : function() {
					//통신이 완료된 후 처리
					$('#loading').fadeOut();
				}
			});
	
		}
	
		function movePage(page, query) {
			if (query == null)
				document.location.href = "/obigoProject/log?page=" + page;
			else
				document.location.href = "/obigoProject/log?page=" + page + "&query=" + query;
	
		}
	
		function frontButton(endNum, query) {
			if (endNum > 9) {
				var val = $("#page0").val() - 10;
				if (val < 1)
					val = 1;
				$("#page0").val(val);
	
				for (var i = 0; i < 10; i++) {
	
					document.getElementById("page" + i).innerHTML = "<a href=\"javascript:movePage(" + (val + i) + ", '" + query + "')\">" + (val + i) + "</a>"
	
				}
	
			}
		}
		function backButton(endNum, query) {
			if (endNum > 9) {
				var val = $("#page0").val() + 10;
				if (val > endNum - 9) {
					$("#page0").val(endNum - 9);
					var a = 0;
					for (var i = 9; i >= 0; i--) {
						document.getElementById("page" + a++).innerHTML = "<a href=\"javascript:movePage(" + (endNum - i) + ", '" + query + "')\">" + (endNum - i) + "</a>"
					}
	
				} else {
					$("#page0").val(val);
	
					for (var i = 0; i < 10; i++) {
						document.getElementById("page" + i).innerHTML = "<a href=\"javascript:movePage(" + (val + i) + ", '" + query + "')\">" + (val + i) + "</a>"
					}
	
				}
			}
		}
		function viewPdf() {
			var newWindow = window.open("about:blank");
			newWindow.location.href = "/obigoProject/viewpdf?year=" + $('#selectYear').val() + "&month=" + $('#selectMonth').val();
		}
	</script>

</body>
</html>