<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>
<%@ page import="com.fssa.leavemanagement.model.EmployeeLeaveDetails"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Leave Request</title>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<link rel="stylesheet" href="./asserts/css/employeeHeader.css">
<style>
main {
	padding-top: 100px;
}

.container {
	display: flex;
}

#popupContainer {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.5);
	display: none; /* Initially hidden */
	justify-content: center;
	align-items: center;
}

#popupContent {
	background-color: #fff;
	padding: 20px;
	border-radius: 5px;
	box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.5);
}

#popupContent p {
	padding: 2%;
}

#closePopup {
	background-color: #ff0000;
	color: #fff;
	border: none;
	padding: 5px 10px;
	border-radius: 3px;
	cursor: pointer;
	margin-top: 10px;
}

.leaveRequestsCard {
	border: 1px solid black;
	width: fit-content;
	padding: 1%;
	margin: 10px;
	cursor: pointer;
}

.leaveRequestsCard:hover {
	background-color: #f0f0f0;
}

.view-button {
	background-color: #007bff;
	color: #fff;
	border: none;
	padding: 5px 10px;
	border-radius: 3px;
	cursor: pointer;
	margin-top: 10px;
}

.view-button:hover {
	background-color: #0056b3;
}

.leave-details {
	margin-top: 10px;
}

textarea {
	width: 100%;
	height: 100px;
	padding: 5px;
	margin-top: 10px;
}

.accept-button, .reject-button {
	background-color: #28a745;
	color: #fff;
	border: none;
	padding: 5px 10px;
	border-radius: 3px;
	cursor: pointer;
	margin-top: 10px;
	width: 100%;
}

.reject-button {
	background-color: #dc3545;
}
</style>
</head>
<body>
	<jsp:include page="employeeHeader.jsp"></jsp:include>
	<main>
		<h1>Leave Request</h1>
		<div class="container">
			<%
			int employeeId = 0;
			List<EmployeeLeaveDetails> leaveRequest = (List<EmployeeLeaveDetails>) request.getAttribute("leaveRequests");

			if (leaveRequest != null) {
				for (EmployeeLeaveDetails e : leaveRequest) {
					employeeId = e.getId();
			%>
			<div class="leaveRequestsCard">
				<h2><%=e.getName()%></h2>
				<p><%=e.getLeaveReason()%></p>
				<button class="view-button"
					data-leave-details='<%=e.getName()%>,<%=e.getLeaveType()%>,<%=e.getLeaveReason()%>,<%=e.getNoOfDays()%>,<%=e.getStartDate()%>,<%=e.getEndDate()%>,<%=e.getId()%>'
					data-employee-id='<%=e.getId()%>'>View</button>
			</div>
			<%
			}
			} else {
			%>
			<h1>No Requests Here</h1>
			<%
			}
			%>
		</div>

		<!-- Popup container -->
		<div id="popupContainer">
			<div id="popupContent">
				<!-- Popup content will be filled dynamically from JavaScript -->

				<h2 id="popupName"></h2>
				<p id="popupLeaveType"></p>
				<p id="popupLeaveReason"></p>
				<p id="popupNoOfDays"></p>
				<p id="popupStartDate"></p>
				<p id="popupEndDate"></p>
				<p id="id"></p>
				<textarea required id="comments" placeholder="Enter Comments"
					name="comments"></textarea>

				<button class="accept-button"
					onclick="accept(<%=employeeId%>, 'ACCEPTED')">Accept</button>
				<button class="reject-button"
					onclick="accept(<%=employeeId%>, 'REJECTED')">Reject</button>
				<button id="closePopup">Close</button>

			</div>
		</div>
	</main>

	<script>
	document.addEventListener("DOMContentLoaded", function() {
	    const viewButtons = document.querySelectorAll(".view-button");
	    const popupContainer = document.getElementById("popupContainer");
	    const closePopupButton = document.getElementById("closePopup");
	    const popupName = document.getElementById("popupName");
	    const popupLeaveType = document.getElementById("popupLeaveType");
	    const popupLeaveReason = document.getElementById("popupLeaveReason");
	    const popupNoOfDays = document.getElementById("popupNoOfDays");
	    const popupStartDate = document.getElementById("popupStartDate");
	    const popupEndDate = document.getElementById("popupEndDate");
	    const idparagraph = document.getElementById("id");
	    let id;

	    // Add event listeners to each "View" button
	    viewButtons.forEach((button) => {
	        button.addEventListener("click", () => {
	            const leaveDetails = button.getAttribute("data-leave-details").split(",");
	            popupName.textContent = leaveDetails[0];
	            popupLeaveType.textContent = `Leave Type : `+leaveDetails[1];
	            popupLeaveReason.textContent = `Leave Reason : `+leaveDetails[2];
	            popupNoOfDays.textContent = `No of Days : `+leaveDetails[3];
	            popupStartDate.textContent = `Start Date: ` + leaveDetails[4];
	            popupEndDate.textContent = `End Date: ` + leaveDetails[5];
	            idparagraph.textContent = `id : `+ leaveDetails[6];
	            id = leaveDetails[6];
	            popupContainer.style.display = "flex"; // Show the popup
	        });
	    });

	    // Close the popup when the close button is clicked
	    closePopupButton.addEventListener("click", () => {
	        popupContainer.style.display = "none"; // Hide the popup
	    });

	    // Add event listeners to "Accept" and "Reject" buttons
	    const acceptButton = document.querySelector(".accept-button");
	    const rejectButton = document.querySelector(".reject-button");

	    acceptButton.addEventListener("click", () => {
	        // Retrieve the employeeId from the clicked "Accept" button
	        const employeeId = acceptButton.getAttribute("data-employee-id");
	        accept(employeeId, 'ACCEPTED');
	    });

	    rejectButton.addEventListener("click", () => {
	        // Retrieve the employeeId from the clicked "Reject" button
	        const employeeId = rejectButton.getAttribute("data-employee-id");
	        accept(employeeId, 'REJECTED');
	    });
	});

	function accept(id, status) {
	    let comments = document.getElementById("comments").value;
	    console.log(id);
	    console.log(comments);
	    console.log(status);

	    // Define the data to send in the request
	    const data = {
	        id: id,
	        status: status,
	        comments: comments,
	    };

	    // Send a POST request using Axios
	    axios.post("http://localhost:8080/leavemanagement-web/ManageLeaveRequest?id="+data.id+"&status="+data.status+"&comments="+data.comments)
	    .then(function (response) {
	        // Handle the server's response here
	        console.log("Request sent successfully");
	    })
	    .catch(function (error) {
	        // Handle any errors that occurred during the request
	        console.error("Error:", error);
	    });
	}


</script>
</body>
</html>
