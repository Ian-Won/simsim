<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<jsp:include page="/jsp/header/header.jsp"></jsp:include>

	<section id="main-content">
		<section class="wrapper site-min-height">
			<!-- page start-->
			<section class="panel">
				<div class="panel-body">
					<div class="adv-table editable-table ">
						<div class="clearfix">
							</div>
							<div class="btn-group pull-right">
								<button class="btn dropdown-toggle" data-toggle="dropdown">
									Tools <i class="fa fa-angle-down"></i>
								</button>
								<ul class="dropdown-menu pull-right">
									<li><a href="#">Print</a></li>
									<li><a href="#">Save as PDF</a></li>
									<li><a href="#">Export to Excel</a></li>
								</ul>
							</div>
						</div>
						<div class="space15"></div>

						<div class="table-responsive">

							<table class="table table-striped table-hover table-bordered"
								id="editable-sample">
								<thead>
									<tr>
										<th>Username</th>
										<th>Model Name</th>
										<th>Vin</th>
										<th>Location</th>
										<th>Accept</th>
										<th>Reject</th>
									</tr>
								</thead>
								<tbody>

									<c:forEach var="k" items="${userRequestList}" begin="0">
										<tr class="">
											<td>${k.userId}</td>
											<td>${k.modelCode}</td>
											<td>${k.vin}</td>
											<td class="center">${k.location}</td>
											<td><a class="Accept" href="javascript:accept(${k.userRequestNumber });">Accept</a></td>
											<td><a class="Reject" href="javascript:reject(${k.userRequestNumber });">Reject</a></td>
										</tr>
									</c:forEach>

								</tbody>
							</table>

						</div>
					</div>
				</div>
			</section>
			<!-- page end-->
		</section>
	</section>
	<jsp:include page="/jsp/header/footer.jsp"></jsp:include>
	<!-- js placed at the end of the document so the pages load faster -->
	<script src="/obigoProject/js/jquery.js"></script>
	<script src="/obigoProject/js/jquery-ui-1.9.2.custom.min.js"></script>
	<script src="/obigoProject/js/jquery-migrate-1.2.1.min.js"></script>
	<script src="/obigoProject/js/bootstrap.min.js"></script>
	<script class="include" type="text/javascript"
		src="/obigoProject/js/jquery.dcjqaccordion.2.7.js"></script>
	<script src="/obigoProject/js/jquery.scrollTo.min.js"></script>
	<script src="/obigoProject/js/jquery.nicescroll.js" type="text/javascript"></script>
	<script type="text/javascript"
		src="/obigoProject/assets/data-tables/jquery.dataTables.js"></script>
	<script type="text/javascript" src="/obigoProject/assets/data-tables/DT_bootstrap.js"></script>
	<script src="/obigoProject/js/respond.min.js"></script>

	<!--right slidebar-->
	<script src="/obigoProject/js/slidebars.min.js"></script>

	<!--common script for all pages-->
	<script src="/obigoProject/js/common-scripts.js"></script>

	<!--script for this page only-->
	<script src="/obigoProject/js/editable-table.js"></script>

	<!-- END JAVASCRIPTS -->
	<script>
		jQuery(document).ready(function() {
			EditableTable.init();
		});
	</script>
	
	<script type="text/javascript">
	
	function accept(data){
		$.ajax({
			type : "post",
			url : "/obigoProject/acceptrequest",
			dataType : "json",
			data : {
				"userRequestNumber" : data
			},
			success : function(data) {
				location.reload();
			}
		});
		
	}
	function reject(data){
		$.ajax({
			type : "post",
			url : "/obigoProject/rejectrequest",
			dataType : "json",
			data : {
				"userRequestNumber" : data
			},
			success : function(data) {
				location.reload();
			}
		});
		
	}
	
	</script>

</body>
</html>