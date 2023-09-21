package com.fssa.leavemanagement.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fssa.leavemanagement.exceptions.DAOException;
import com.fssa.leavemanagement.exceptions.InvalidEmployeeException;
import com.fssa.leavemanagement.model.EmployeeLeaveDetails;
import com.fssa.leavemanagement.service.EmployeeLeaveDetailsService;

/**
 * Servlet implementation class LeaveRequest
 */
@WebServlet("/LeaveRequest")
public class LeaveRequest extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public LeaveRequest() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		String email = (String) session.getAttribute("loggedInEmail");
		try {
			List<EmployeeLeaveDetails> arr = EmployeeLeaveDetailsService.getLeaveRequestsByManagerEmail(email);
			request.setAttribute("leaveRequests", arr);
			RequestDispatcher rd = request.getRequestDispatcher("leaveRequest.jsp");
			rd.forward(request, response);
		} catch (InvalidEmployeeException e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
