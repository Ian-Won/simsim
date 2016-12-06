<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Resource Management Page</title>
</head>
<body>
	<jsp:include page="/jsp/header/header.jsp"></jsp:include>
	<section id="container" class="">
		<!--main content start-->
		<section id="main-content">
			<section class="wrapper site-min-height">
				<!-- page start-->
				<section class="panel">
					<header class="panel-heading"> RESOURCE </header>
					<div class="panel-body">
						<div class="adv-table editable-table ">
							<div class="clearfix">
								<div class="btn-group">
									<button id="Add" class="btn green" data-toggle="modal" href="#addModal">
										Add Resource <i class="fa fa-plus"></i>
									</button>
								</div>
								<!--modal start-->
								<!-- Add Resource 눌렀을때 모달창 -->
								<!-- Modal -->
								<div class="modal fade " id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
												<h4 class="modal-title">Add Resource</h4>
											</div>
											<div class="modal-body">
												<form id="form-addresource" action="/obigoProject/insertresource" class="form-signin" onsubmit="addresource()" method="POST">
													<div class="login-wrap">
														<input type="text" name="resourceName" class="form-control" placeholder="ResourceName" autofocus required="required">
														<input type="text" name="path" id="bundleversion" class="form-control" placeholder="Path" autofocus required="required">
														<input type="text" name="resourceVersion" class="form-control" placeholder="ResourceVersion" autofocus required="required">
													</div>
												</form>
											</div>
											<div class="modal-footer">
												<button data-dismiss="modal" class="btn btn-default" type="button">Close</button>
												<input class="btn btn-success" type="submit" form="form-addresource" value="Registration">
											</div>
										</div>
									</div>
								</div>
								<!-- modal -->
								<!--
								edit눌렀을때 모달창
								  -->
								<div class="modal fade " id="editModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
												<h4 class="modal-title">Update Bundle</h4>
											</div>
											<div class="modal-body">
												<form id="form-update" class="form-signin" action="/obigoProject/updatebundle" method="POST">
													<div class="login-wrap">
														<input type="text" name="bundleName" id="editbundlename" class="form-control" autofocus>
														<input type="text" name="bundleVersion" id="editbundleversion" class="form-control" autofocus readonly="readonly" value="${bundleVersion}">
													</div>
												</form>
											</div>
											<div class="modal-footer">
												<button data-dismiss="modal" class="btn btn-default" type="button">Close</button>
												<input class="btn btn-success" type="submit" form="form-update" value="Update">
											</div>
										</div>
									</div>
								</div>
								<!-- modal -->
								<!-- Modal -->
							</div>
							<br>
							<div class="space15"></div>
							<div class="bundleList">
								<select id=selectbundle onchange="showresource()">
									<option value="default">Select BundleVersion</option>
									<c:forEach var="b" items="${bundleList}" begin="0">
										<option value="${b.bundleKey}">Bundle Name : ${b.bundleName}, Bundle Version : ${b.bundleVersion}</option>
									</c:forEach>
								</select>
							</div>
							<div class="table-responsive">
								<table class="table table-striped table-hover table-bordered" id="editable-sample">
									<thead>
										<tr>
											<th>RESOURCENAME</th>
											<th>PATH</th>
											<th>RESOURCEVERSION</th>
											<th>BUNDLEKEY</th>
											<th>EDIT</th>
										</tr>
									</thead>
									<tbody id="resource_table">
									</tbody>
								</table>

							</div>
						</div>
					</div>
				</section>
				<!-- page end-->
			</section>
		</section>
		<!-- modal -->
		<!--main content end-->
		<!--footer start-->
		<jsp:include page="/jsp/header/footer.jsp"></jsp:include>
		<!--footer end-->
	</section>
	<script type="text/javascript">
		//추가모달창
		function addresource() {
			var select = $("#selectbundle").val();
			var text = "";
			text += "<input type='hidden' name='bundleKey' value=" + select + ">";
			$("#form-addresource").append(text);
		}
		//수정모달창
		function update(bundleName, bundleVersion) {
			$("#editbundlename").val(bundleName);
			$("#editbundleversion").val(bundleVersion);
			$("#editModal").modal();
		}
	
		 function resdel(data) {
			if (confirm("선택한 리소스를 삭제하시겠습니까?") == true) {
				$.ajax({
					type : "post",
					url : "/obigoProject/deleteresource",
					dataType : "json",
					async : false,
					data : {
						"resourceNumber" : data
					},
					success : function(resource) {
						if (resource.flag == true) {
							alert("삭제되었습니다.");
							location.reload();
						}
						else
							alert("삭제를 실패하였습니다.");
					}
				})
			}
		}
		/* 
		번들을 선택했을 때 관련된 리소스 보여주기
		*/
		function showresource() {
			var select = $("#selectbundle").val();
			$.ajax({
				type : "post",
				url : "/obigoProject/selectresource",
				dataType : "json",
				async : false,
				data : {
					"bundleKey" : select
				},
				success : function(resource) {
					test = resource.resourceList;
					var text = "";
					$.each(test, function(index, resource) {
						text += "<tr class=''>";
						text += "<td>" + resource.resourceName + "</td>";
						text += "<td>" + resource.path + "</td>";
						text += "<td>" + resource.resourceVersion + "</td>";
						text += "<td>" + resource.bundleKey + "</td>";
						text += "<td><a href=javascript:resupdate(" + resource + ")>Edit</a></td>";
						text += "<td><a href=javascript:resdel(" + resource.resourceNumber + ")>Delete</a></td>";
						text += "</tr>";
					});
					$("#resource_table").html(text);
				}
			});
		}
	</script>

	<!-- js placed at the end of the document so the pages load faster -->
	<script src="/obigoProject/js/jquery.js"></script>
	<script src="/obigoProject/js/jquery-ui-1.9.2.custom.min.js"></script>
	<script src="/obigoProject/js/jquery-migrate-1.2.1.min.js"></script>
	<script src="/obigoProject/js/bootstrap.min.js"></script>
	<script class="include" type="text/javascript" src="/obigoProject/js/jquery.dcjqaccordion.2.7.js"></script>
	<script src="/obigoProject/js/jquery.scrollTo.min.js"></script>
	<script src="/obigoProject/js/jquery.nicescroll.js" type="text/javascript"></script>
	<script type="text/javascript" src="/obigoProject/assets/data-tables/jquery.dataTables.js"></script>
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


</body>
</html>
