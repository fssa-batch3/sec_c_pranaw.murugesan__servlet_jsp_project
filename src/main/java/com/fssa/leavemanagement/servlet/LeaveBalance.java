package com.fssa.leavemanagement.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fssa.leavemanagement.model.EmployeeLeaveBalance;
import com.fssa.leavemanagement.service.EmployeeLeaveDetailsService;

/**
 * Servlet implementation class LeaveBalance
 */
@WebServlet("/LeaveBalance")
public class LeaveBalance extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public LeaveBalance() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<EmployeeLeaveBalance> elb = EmployeeLeaveDetailsService.getAllLeaveBalance();
		request.setAttribute("leaveBalance",elb);
		RequestDispatcher rd = request.getRequestDispatcher("adminLeaveBalance.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		doGet(request, response);
	}

}
