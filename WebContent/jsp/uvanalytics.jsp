<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="Mosaddek">
<meta name="keyword" content="FlatLab, Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">
<link rel="shortcut icon" type="image/ico" href="/obigoProject/img/favicon.ico">

<title>User Vehicle Analytics</title>
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


<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<style type="text/css">
#loading {
	border: 0;
	display: none;
	text-align: center;
	filter: alpha(opacity = 60);
	opacity: alpha*0.6;
	z-index: 5;
}
</style>
</head>
<body>

	<!--header start-->
	<jsp:include page="/jsp/header/header.jsp"></jsp:include>
	<!--header end-->
	
	<!-- 메일 전송하는 동안 띄워줄 이미지 -->
	<div id="loading">
		<img style="width: 380px; height: 380px;" src="/obigoProject/img/loading.gif" />
	</div>

	<section id="container" class="">
		<section id="main-content">
			<section class="wrapper site-min-height">
				<section id="mysection" class="panel" style="width: 800px; margin-left: auto; margin-right: auto;">
					<div id="target" class="panel-body">
						<!-- -------------- 통계 캡처 이미지 Email 발송 Button start -------------- -->
						<div class="btn-group pull-right">
							<button class="btn dropdown-toggle" style="color: white; border-color: #FF6C60; background-color: #FF6C60;" onclick="capture();">
								Email
								<i class="fa fa-envelope"></i>
							</button>
						</div>
						<!-- -------------- 통계 캡처 이미지 Email 발송 Button end -------------- -->
						<!-- User Vehicle에 등록된 Model 비율 통계 Graph -->
						<div id="container-graph" style="min-width: 310px; height: 400px; max-width: 600px; margin: 0 auto">
							<div id="hero-graph" class="graph"></div>
						</div>
					</div>
				</section>
			</section>
		</section>

		<!--footer start-->
		<jsp:include page="/jsp/header/footer.jsp"></jsp:include>
		<!--footer end-->
	</section>


	<!-- js placed at the end of the document so the pages load faster -->
	<script src="/obigoProject/js/jquery.js"></script>
	<!--<script src="js/jquery-1.8.3.min.js"></script>-->
	<script src="/obigoProject/js/bootstrap.min.js"></script>
	<script class="include" type="text/javascript" src="/obigoProject/js/jquery.dcjqaccordion.2.7.js"></script>
	<script src="/obigoProject/js/jquery.scrollTo.min.js"></script>
	<script src="/obigoProject/js/jquery.nicescroll.js" type="text/javascript"></script>
	<script src="/obigoProject/assets/morris.js-0.4.3/morris.min.js" type="text/javascript"></script>
	<script src="/obigoProject/assets/morris.js-0.4.3/raphael-min.js" type="text/javascript"></script>
	<script src="/obigoProject/js/respond.min.js"></script>

	<script src="/obigoProject/assets/flot/jquery.flot.js"></script>
	<script src="/obigoProject/assets/flot/jquery.flot.resize.js"></script>
	<script src="/obigoProject/assets/flot/jquery.flot.pie.js"></script>
	<script src="/obigoProject/assets/flot/jquery.flot.stack.js"></script>
	<script src="/obigoProject/assets/flot/jquery.flot.crosshair.js"></script>

	<!--right slidebar-->
	<script src="/obigoProject/js/slidebars.min.js"></script>

	<!--common script for all pages-->
	<script src="/obigoProject/js/common-scripts.js"></script>

	<!-- 이미지 캡처 -->
	<script src="/obigoProject/js/html2canvas.js"></script>

	<script type="text/javascript">
		// AJAX로 얻어온 Data를 기반으로 Graph를 생성하는 함수 
		function makeChart(data1) {
			Highcharts.chart(
				'container-graph',
				{
					chart : {
						plotBackgroundColor : null,
						plotBorderWidth : null,
						plotShadow : false,
						type : 'pie'
					},
					title : {
						text : 'User Vehicle Analytics'
					},
					credits:{
						enabled:false
					},
					tooltip : {
						pointFormat : '{series.name}: <b>{point.percentage:.1f}%</b>'
					},
					plotOptions : {
						pie : {
							allowPointSelect : false,
							cursor : 'pointer',
							dataLabels : {
								enabled : true,
								format : '<b>{point.name}</b>: {point.percentage:.1f} %',
								style : {
									color : (Highcharts.theme && Highcharts.theme.contrastTextColor)
											|| 'black'
								}
							}
						}
					},
					exporting : false,
					series : [ {
						name : 'Model',
						colorByPoint : true,
						data : data1
					} ]
				});
		}

		// User Vehicle에 등록된 차종 비율 Data를 AJAX로 얻어오는 함수
		$(function() {
			$.ajax({
				type : "post",
				url : "/obigoProject/countingbymodel",
				dataType : "json",
				success : function(data) {
					// 				alert(data[0].label);
					// 그래프로 출력해주기 위해서 Json data를 함수의 인자로 보내준다.
					makeChart(data);
				},
				error : function(e) {
					console.log(e);
				}
			});
		});

		// 통계 그래프를 캡쳐한 이미지를 관리자 이메일로 전송하는 함수
		function capture() {
			if (confirm("이메일을 전송하시겠습니까?") == true) {
				html2canvas($("#mysection"), {
					onrendered : function(canvas) {
						document.body.appendChild(canvas);
						//alert(canvas.toDataURL("image/png"));
						var img = canvas.toDataURL("image/png")

						$.ajax({
							type : "post",
							data : {
								"imgSrc" : img,
							},
							url : "/obigoProject/emailanalytics",
							error : function(a, b, c) {
								alert("이메일 보내기 실패");
							},
							success : function(data) {
								if (data.flag == true) {
									alert("이메일 보내기 성공");
								} else {
									alert("이메일 보내기 실패");
								}
							},
							beforeSend : function() {
								//통신을 시작할때 처리
								$('#loading').css('position', 'absolute');
								$('#loading').css('left',
										$('#target').offset().left);
								$('#loading').css('top',
										$('#target').offset().top);
								$('#loading').css('width',
										$('#target').css('width'));
								$('#loading').css('height',
										$('#target').css('height'));
								$('#loading').show().fadeIn('fast');
							},
							complete : function() {
								//통신이 완료된 후 처리
								$('#loading').fadeOut();
							}
						});
					}
				});
			} else {
				return;
			}
		}
	</script>

</body>
</html>