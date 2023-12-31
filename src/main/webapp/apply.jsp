<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.time.LocalDate"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Fresh Leave</title>
<link rel="stylesheet" href="./assets/css/header.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link rel="stylesheet" href="./assets/css/employeeHeader.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/gh/suryaumapathy2812/notify__js/notify.css">
<link
	href="https://fonts.googleapis.com/css2?family=Poppins&family=Roboto&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="./assets/css/apply.css">




</head>
<body>
	<jsp:include page="employeeHeader.jsp"></jsp:include>
	<main>
		<%
		String EXCEEDS_LEAVE_BALANCE = "Number of days exceeds the leave balance";
		String success = (String) request.getAttribute("successMsg");
		%>

		<h1 id="title">Apply for Leave</h1>
		<%
		String error = (String) request.getAttribute("error");
		if (error != null) {
			if (EXCEEDS_LEAVE_BALANCE.equals(error)) {
		%>
		<h2 id="errMsg">
			<%=error%>
			, Check your Balance <a id="checkHere" href="Dashboard">Here!</a>
		</h2>
		<%
		} else {
		%>
		<h2 id="errMsg">
			<%=error%>
		</h2>
		<%
		}
		}
		%>
		<form action="ApplyLeave" method="post">
			<label for="leaveType">Leave Type</label> <select name="leaveType"
				id="leaveType">
				<option value="CASUAL">Casual Leave</option>
				<option value="SICK">Sick Leave</option>
				<option value="EARNED">Earned Leave</option>
			</select> <label for="startDate">Start Date</label> <input type="date"
				name="startDate" id="startDate" class="date" required> <label
				for="endDate">End Date</label> <input type="date" name="endDate"
				id="endDate" class="date" required> <label for="noOfDays">No
				of Days:</label> <label style="color: red;">If it is a half day,
				change accordingly (ex. 0.5)</label> <input type="text" name="noOfDays"
				id="noOfDays" required readonly> <label for="reason">Reason</label>
			<textarea name="reason" id="reason" cols="30" rows="10" required
				placeholder="Type Reason"></textarea>
			<br>
			<button id="sumbit" type="submit">Submit</button>
		</form>
	</main>
	<script
		src="https://cdn.jsdelivr.net/gh/suryaumapathy2812/notify__js/notify.js">
		
	</script>
	<script type="text/javascript" src="./assets/js/apply.js"></script>
	<jsp:include page="./alertMsg.jsp"></jsp:include>
</body>

</html>
