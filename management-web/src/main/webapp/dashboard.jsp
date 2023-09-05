<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Fresh Leave</title>
<link rel="stylesheet" href="./assets/css/dashboard.css">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<link href="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.css"
	rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link rel="stylesheet" href="./asserts/css/header.css">
<link
	href="https://fonts.googleapis.com/css2?family=Poppins&family=Roboto&display=swap"
	rel="stylesheet">

</head>

<body>
	<header>
		<div>
			<h1>Fresh Leave</h1>
		</div>
		<div>
			<button class="signout">sign out</button>
		</div>
	</header>
	<aside>
		<ul>
			<button type="button" class="btn btn-light">
				<a href="#">Dashboard</a>
			</button>
			<button type="button" class="btn btn-light">
				<a href="./assets/pages/apply.html">Apply</a>
			</button>
			<button type="button" class="btn btn-light">Holidays</button>
			<button type="button" class="btn btn-light">Policies</button>
			<button type="button" class="btn btn-light">Requests</button>
		</ul>
	</aside>
	<main>
		<div class="leaveInsights">
			<h1>Leave Insights</h1>
			<button>Apply</button>
		</div>
		<div class="barsTitles">
			<h1>Leave Statistics</h1>
			<h1>Batches</h1>
		</div>
		<div class="bars">
			<canvas id="myChart"
				style="display: block; width: 55px; height: 55px;"></canvas>
			<canvas id="doughnutChart"
				style="display: block; width: 55px; height: 55px;"></canvas>
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
				<tr>
					<td>Casual Leave</td>
					<td>2022/06/02</td>
					<td>2022/06/06</td>
					<td>Pending</td>
					<td>view all</td>
				</tr>
				<tr>
					<td>Casual Leave</td>
					<td>2022/06/02</td>
					<td>2022/06/06</td>
					<td>Pending</td>
					<td>view all</td>
				</tr>
				<tr>
					<td>Casual Leave</td>
					<td>2022/06/02</td>
					<td>2022/06/06</td>
					<td>Pending</td>
					<td>view all</td>
				</tr>
				<tr>
					<td>Casual Leave</td>
					<td>2022/06/02</td>
					<td>2022/06/06</td>
					<td>Pending</td>
					<td>view all</td>
				</tr>
				<tr>
					<td>Casual Leave</td>
					<td>2022/06/02</td>
					<td>2022/06/06</td>
					<td>Pending</td>
					<td>view all</td>
				</tr>
			</table>
		</div>

	</main>
	<style>
body {
	background-color: #f9f7f7;
	overflow-x: hidden;
	font-family: "Roboto", sans-serif;
}

.bars {
	width: 110%;
	height: 50vh;
	display: grid;
	grid-template-areas: 'boxchart doughnutChart';
}

.bars>canvas {
	margin-right: 10%;
	margin-left: 10%;
	/* background-color: white; */
	/* width: 210px; */
}

#myChart {
	grid-area: boxchart;
}

#doughnutChart {
	grid-area: doughnutChart;
}

table {
	margin-top: 2%;
	width: 150%;
}

th, td {
	padding: 17px;
	font-size: large;
	border-bottom: 2px solid black;
	margin: 0px;
}

.pendingReqTitle {
	margin-top: 5%;
	margin-left: 1%;
	color: #424874;
}

.pendingReq {
	margin-left: 10%;
	width: 50%;
}

.barsTitles {
	display: flex;
	justify-content: space-around;
	color: #424874;
}

.leaveInsights {
	display: flex;
	justify-content: space-between;
	background-color: white;
	margin-bottom: 1%;
	padding: 1%;
}

.leaveInsights>h1 {
	margin-left: 5%;
}

.leaveInsights>button {
	margin-right: 5%;
	padding-left: 1%;
	padding-right: 1%;
}
</style>


	<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.js"></script>
	<script>
		const ctx = document.getElementById('myChart');
		const doughnutChart = document.getElementById("doughnutChart");

		new Chart(ctx, {
			type : 'bar',
			data : {
				labels : [ 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun' ],
				datasets : [ {
					label : '# of Votes',
					data : [ 12, 19, 3, 5, 2, 3 ],
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
					label : 'My First Dataset',
					data : [ 10, 5, 10 ],
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