package com.fssa.leavemanagement.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fssa.leavemanagement.exceptions.DAOException;
import com.fssa.leavemanagement.service.EmployeeLeaveDetailsService;
import com.fssa.leavemanagement.service.EmployeeService;

/**
 * Servlet implementation class ManageLeaveRequest
 */
@WebServlet("/ManageLeaveRequest")
public class ManageLeaveRequest extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ManageLeaveRequest() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
//		int id = Integer.parseInt(request.getParameter("id"));
		String status = request.getParameter("status");
		String comments = request.getParameter("comments");
		try {
			EmployeeLeaveDetailsService.updateLeaveRequest(status, 10, comments);

		} catch (SQLException | DAOException e) {
			e.printStackTrace();
		}
		response.sendRedirect("LeaveRequest");
		doGet(request, response);
	}

}
