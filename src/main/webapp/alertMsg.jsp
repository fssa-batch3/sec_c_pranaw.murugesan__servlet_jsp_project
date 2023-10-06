<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
<%String errorMsg = (String) request.getAttribute("errorMsg");
String successMsg = (String) request.getAttribute("successMsg");
String path = (String) request.getAttribute("path");

System.out.println("Successmsg : " + successMsg + " errormsg :" + errorMsg + " Path :" + path);

if (errorMsg != null) {%>
		console.log("<%=errorMsg%>");

		swal("Failed!"," <%=errorMsg%>", "error");
		<%if (path != null) {%>
		setTimeout(() => {
			window.location.href="<%=path%>";
		}, 3000);
		
	<%}
}%>
		
		<%if (successMsg != null) {%>
		console.log("<%=successMsg%>");
		swal("Success!"," <%=successMsg%>", "success");
		<%if (path != null) {%>
		setTimeout(() => {
			
			window.location.href="<%=path%>";
		}, 1);
		<%}
}%>
</script>