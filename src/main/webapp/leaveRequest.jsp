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
<link rel="stylesheet" href="./assets/css/employeeHeader.css">
<style>
main {
	padding-top: 100px;
}

.container {
	display: flex;
	justify-content: flex-start;
	flex-wrap: wrap; /* Allow cards to wrap to the next line */
}

.leaveRequestsCard {
	border: 1px solid #ccc;
	width: 300px;
	padding: 20px;
	margin: 10px;
	cursor: pointer;
	background-color: #f9f9f9;
	border-radius: 10px;
	transition: background-color 0.3s, transform 0.3s;
}

.leaveRequestsCard:hover {
	background-color: #e0e0e0;
	transform: scale(1.02);
}

.leaveRequestsCard h2 {
	margin-top: 0;
	font-size: 1.5rem;
}

.leaveRequestsCard p {
	margin: 10px 0;
}

/* View Button */
.view-button {
	background-color: #007bff;
	color: #fff;
	border: none;
	padding: 8px 16px;
	border-radius: 5px;
	cursor: pointer;
	margin-top: 10px;
	transition: background-color 0.3s;
}

.view-button:hover {
	background-color: #0056b3;
}

/* Popup Container */
#popupContainer {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.5);
	display: none;
	justify-content: center;
	align-items: center;
	z-index: 999;
}

/* Popup Content */
#popupContent {
	background-color: #fff;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.5);
	max-width: 400px;
	text-align: left;
}

#popupContent h2 {
	margin-top: 0;
	font-size: 1.5rem;
}

#popupContent p {
	margin: 10px 0;
}

#popupContent textarea {
	width: 100%;
	height: 100px;
	padding: 5px;
	margin-top: 10px;
}

/* Accept and Reject Buttons in Popup */
.accept-button, .reject-button, #closePopup {
	background-color: #28a745;
	color: #fff;
	border: none;
	padding: 8px 16px;
	border-radius: 5px;
	cursor: pointer;
	margin-top: 10px;
	width: 45%;
	margin-right: 10px;
	transition: background-color 0.3s;
}

.reject-button {
	background-color: #dc3545;
}

#closePopup {
	background-color: #adb5bd;
}

.accept-button:hover, .reject-button:hover {
	filter: brightness(1.2);
}

.nothing {
	color: red;
	margin-left: 10%;
}

.nothingContainer {
	display: flex;
	flex-direction: column;
}

#loader {
	display: block;
	position: fixed;
	z-index: 999;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(255, 255, 255, 0.7);
}

#loader span {
	display: block;
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	font-size: 24px;
	font-weight: bold;
	color: #333;
}
</style>
</head>
<body>
	<jsp:include page="employeeHeader.jsp"></jsp:include>
	<main>
		<h1>Leave Request</h1>
		<!-- LOADING TEXT -->
		<div id="loader">
			<span>Loading...</span>
		</div>
		<div class="container">
			<%
			List<EmployeeLeaveDetails> leaveRequest = (List<EmployeeLeaveDetails>) request.getAttribute("leaveRequests");

			if (leaveRequest != null) {
				for (EmployeeLeaveDetails e : leaveRequest) {
					if (e.getStatus().equals("PENDING")) {
				
			%>
			<div class="leaveRequestsCard">
				<h2><%=e.getName()%></h2>
				<p><%=e.getLeaveReason()%></p>
				<button class="view-button"
					data-leave-details='<%=e.getName()%>,<%=e.getLeaveType()%>,<%=e.getLeaveReason()%>,<%=e.getNoOfDays()%>,<%=e.getStartDate()%>,<%=e.getEndDate()%>,<%=e.getId()%>,<%=e.getEmployeeId()%>'
					data-employee-id='<%=e.getId()%>'>View</button>
			</div>

			<%
			}
			%>
			<%
			}
			} else {
			%>
			<div class="nothingContainer">
				<img src="./assets/img/man.png"> <br>
				<h1 class="nothing">Nothing Here</h1>
			</div>
			<%
			}
			%>
		</div>

		<!-- Popup container -->
		<div id="popupContainer">
			<div id="popupContent">

				<h2 id="popupName"></h2>
				<p id="popupLeaveType"></p>
				<p id="popupLeaveReason"></p>
				<p id="popupNoOfDays"></p>
				<p id="popupStartDate"></p>
				<p id="popupEndDate"></p>
				<textarea required id="comments"
					placeholder="Enter Comments (Optional)" name="comments"></textarea>

				<button class="accept-button">Accept</button>
				<button class="reject-button">Reject</button>
				<button id="closePopup">Close</button>

			</div>
		</div>
	</main>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<script>
	let employeeId =0;
	let leaveType ="";
	let noOfDays =0;
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
	    const loader = document.getElementById("loader");
	    loader.style.display="none";
	    // Add event listeners to "Accept" and "Reject" buttons
	    const acceptButton = document.querySelector(".accept-button");
	    const rejectButton = document.querySelector(".reject-button");

	    // Add event listeners to each "View" button
	    viewButtons.forEach((button) => {
	        button.addEventListener("click", () => {
	            const leaveDetails = button.getAttribute("data-leave-details").split(",");
	            popupName.textContent = leaveDetails[0];
	            popupLeaveType.textContent = `Leave Type : `+leaveDetails[1];
	            leaveType = leaveDetails[1];
	            popupLeaveReason.textContent = `Leave Reason : `+leaveDetails[2];
	            popupNoOfDays.textContent = `No of Days : `+leaveDetails[3];
	            noOfDays = leaveDetails[3];
	            popupStartDate.textContent = `Start Date: ` + leaveDetails[4];
	            popupEndDate.textContent = `End Date: ` + leaveDetails[5];
	            popupContainer.style.display = "flex"; 
	            acceptButton.setAttribute("data-id",leaveDetails[6]);
	             rejectButton.setAttribute("data-id",leaveDetails[6]);
	             employeeId = leaveDetails[7];
	             console.log(employeeId)
 	        });
	    });

	    // Close the popup when the close button is clicked
	    closePopupButton.addEventListener("click", () => {
	        popupContainer.style.display = "none"; // Hide the popup
	    });



	    acceptButton.addEventListener("click", () => {
	        // Retrieve the employeeId from the clicked "Accept" button
	        const employeeId = acceptButton.getAttribute("data-id");
	        accept(employeeId, 'APPROVED');
	        popupContainer.style.display = "none"; // Hide the popup
	    });

	    rejectButton.addEventListener("click", () => {
	        // Retrieve the employeeId from the clicked "Reject" button
	        const employeeId = rejectButton.getAttribute("data-id");
	        accept(employeeId, 'REJECTED');
	        popupContainer.style.display = "none"; // Hide the popup
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
	    loader.style.display="block";
	    // Send a POST request using Axios
	    axios.post("http://localhost:8080/leavemanagement-web/ManageLeaveRequest?id="+id+"&status="+status+"&comments="+comments+"&employeeId="+employeeId+"&leaveType="+leaveType+"&noOfDays="+noOfDays)
	    .then(function (response) {
	        // Handle the server's response here
	        
	        console.log("Request sent successfully");
	        swal("Success!",`Succesfully ${status} the leave !!`, "success");
	        window.location.reload();
	    })
	    .catch(function (error) {
	        // Handle any errors that occurred during the request
	        console.error("Error:", error);
	    });
	}


</script>

</body>
</html>
