<%@page
	import="com.fssa.leavemanagement.service.EmployeeLeaveDetailsService"%>
<%@page import="com.fssa.leavemanagement.service.EmployeeService"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.fssa.leavemanagement.model.*"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Fresh Leave</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link rel="stylesheet" href="./assets/css/employeeHeader.css">
<link rel="stylesheet" href="./assets/css/dashboard.css">
<link
	href="https://fonts.googleapis.com/css2?family=Poppins&family=Roboto&display=swap"
	rel="stylesheet">

</head>

<body>
	<jsp:include page="employeeHeader.jsp"></jsp:include>
	<%
	EmployeeLeaveBalance elb = (EmployeeLeaveBalance) request.getAttribute("leaveBalance");
	Employee e = null;
	String email = (String) session.getAttribute("loggedInEmail");
	if (email != null) {
		e = EmployeeService.findEmployeeByEmail(email);
	} else {
		// Redirect the user to the login page if not logged in
		response.sendRedirect("login.jsp");
	}
	%>

	<main>

		<%
		if (e != null && e.getName() != null) {
		%>
		<h1 id="displayName">
			Hi
			<%=e.getName()%>
			!!
		</h1>
		<%
		}
		%>

		<div class="leaveInsights">
			<h1>Leave Insights</h1>
			<button class="apply-button">
				<a href="apply.jsp">Apply</a>
			</button>
		</div>
		<div class="barsTitles">
			<h1>Leave Balance</h1>
			<h1>Leave Balance</h1>
		</div>
		<div class="bars">
			<canvas id="myChart"
				style="display: block; width: 55px; height: 55px;"></canvas>
			<canvas id="doughnutChart"
				style="display: block; width: 15px; height: 15px;"></canvas>
		</div>

		<div class="pendingReq">
			<h1 class="pendingReqTitle">Pending Leave Requests</h1>
			<table>
				<tr>
					<th>Leave Type</th>
					<th>Request on</th>
					<th>Leave Duration</th>
					<th>Status</th>
					<th></th>
				</tr>
				<%
				List<EmployeeLeaveDetails> eldArray = (List<EmployeeLeaveDetails>) request.getAttribute("leaveRequest");
				if (!eldArray.isEmpty() && eldArray != null) {
				%>

				<%
				for (EmployeeLeaveDetails leaveDetail : eldArray) {
				%>
				<tr>
					<td><%=leaveDetail.getLeaveType()%></td>
					<td><%=leaveDetail.getStartDate()%></td>
					<td><%=leaveDetail.getEndDate()%></td>
					<td><%=leaveDetail.getStatus()%></td>
					<td>view all</td>
				</tr>
				<%
				}
				%>
			</table>
		</div>
		<%
		} else {
		%>
		<h1 class="pendingReqTitle">No Pending Leave Requests</h1>
		<%
		}
		%>





	</main>



	<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.js"></script>
	<script>
		const ctx = document.getElementById('myChart');
		const doughnutChart = document.getElementById("doughnutChart");

		new Chart(ctx, {
			type : 'bar',
			data : {
				labels : [ 'Casual', 'Sick', 'Earned' ],
				datasets : [ {
					label : '# of Votes',
					data : [
	<%=elb.getCasualLeaveBalance()%>
		,
	<%=elb.getSickLeaveBalance()%>
		,
	<%=elb.getEarnedLeaveBalance()%>
		, ],
					backgroundColor : [ 'rgba(255, 99, 132, 0.2)',
							'rgba(255, 159, 64, 0.2)',
							'rgba(255, 205, 86, 0.2)',
							'rgba(75, 192, 192, 0.2)',
							'rgba(54, 162, 235, 0.2)',
							'rgba(153, 102, 255, 0.2)' ],
					borderColor : [ 'rgb(255, 99, 132)', 'rgb(255, 159, 64)',
							'rgb(255, 205, 86)', 'rgb(75, 192, 192)',
							'rgb(54, 162, 235)', 'rgb(153, 102, 255)',
							'rgb(201, 203, 207)' ],
					borderWidth : 1
				} ]
			},
			options : {
				scales : {
					y : {
						beginAtZero : true
					}
				}
			}
		});
		new Chart(doughnutChart, {
			type : 'doughnut',
			data : {
				labels : [ 'Casual', 'Sick', 'Earned' ],
				datasets : [ {
					label : 'Leave Balance',

					data : [
	<%=elb.getCasualLeaveBalance()%>
		,
	<%=elb.getSickLeaveBalance()%>
		,
	<%=elb.getEarnedLeaveBalance()%>
		],
					backgroundColor : [ 'rgb(255, 99, 132)',
							'rgb(54, 162, 235)', 'rgb(255, 205, 86)' ],
					hoverOffset : 4
				} ]
			},
			options : {
				scales : {
					y : {
						beginAtZero : true
					}
				}
			}
		});
	</script>
</body>

</html>