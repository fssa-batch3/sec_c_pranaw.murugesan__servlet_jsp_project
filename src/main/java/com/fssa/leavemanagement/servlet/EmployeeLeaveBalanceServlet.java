package com.fssa.leavemanagement.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fssa.leavemanagement.exceptions.DAOException;
import com.fssa.leavemanagement.exceptions.InvalidEmployeeException;
import com.fssa.leavemanagement.model.EmployeeLeaveBalance;
import com.fssa.leavemanagement.service.EmployeeLeaveDetailsService;

@WebServlet("/EmployeeLeaveBalanceServlet")
public class EmployeeLeaveBalanceServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public EmployeeLeaveBalanceServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		String email = (String) session.getAttribute("loggedInEmail");
		try {
			EmployeeLeaveBalance elb = EmployeeLeaveDetailsService.getLeaveBalanceByEmail(email);
			request.setAttribute("leaveBalance", elb);
			RequestDispatcher rd = request.getRequestDispatcher("employeeLeaveBalance.jsp");
			rd.forward(request, response);

		} catch (InvalidEmployeeException | SQLException | DAOException e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
