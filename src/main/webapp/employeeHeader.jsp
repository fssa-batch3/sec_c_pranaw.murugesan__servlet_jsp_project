<%@ page import="java.util.*"%>
<%@ page import="com.fssa.leavemanagement.model.EmployeeLeaveDetails"%>
<%@ page
	import="com.fssa.leavemanagement.service.EmployeeLeaveDetailsService"%>
<header>
	<div>

		<h1 id="webTitle">
			<img src="./assets/img/freshicon.png" alt="freshIcon" id="freshIcon"
				style="width: 30px; margin-right: 10px;">Fresh Leave
		</h1>
	</div>
	<div>
		<button class="signout">

			<a href="Logout">Logout<img src="./assets/img/logout.png"></a>
		</button>
	</div>
</header>
<aside>
	<ul>
		<button type="button" class="btn btn-light">
			<a href="Dashboard">Dashboard</a>
		</button>
		<button type="button" class="btn btn-light">
			<a href="apply.jsp">Apply</a>
		</button>
		<%
		String email = (String) session.getAttribute("loggedInEmail");
		if (email != null) {
			List<EmployeeLeaveDetails> arr = EmployeeLeaveDetailsService.getLeaveRequestsByManagerEmail(email);
			if (arr != null) {
		%>

		<button type="button" class="btn btn-light">
			<a href="LeaveRequest">Request</a>
		</button>
		<%
		}
		}
		%>
		<button type="button" class="btn btn-light">
			<a href="policy.jsp">Policies</a>
		</button>

	</ul>
</aside>