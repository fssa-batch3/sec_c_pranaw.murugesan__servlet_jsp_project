package com.fssa.leavemanagement.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fssa.leavemanagement.exceptions.DAOException;
import com.fssa.leavemanagement.exceptions.ValidatorException;
import com.fssa.leavemanagement.model.EmployeeLeaveBalance;
import com.fssa.leavemanagement.model.LeaveTypes;
import com.fssa.leavemanagement.service.EmployeeLeaveDetailsService;

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
		request.getRequestDispatcher("LeaveRequest").forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int id = Integer.parseInt(request.getParameter("id"));
		int employeeId = Integer.parseInt(request.getParameter("employeeId"));
		String status = request.getParameter("status");
		String comments = request.getParameter("comments");
		String leaveType = request.getParameter("leaveType");
		double noOfDays = Double.parseDouble(request.getParameter("noOfDays"));
		LeaveTypes leave = LeaveTypes.valueOf(leaveType);
		try {
			EmployeeLeaveBalance elb = EmployeeLeaveDetailsService.getLeaveBalanceByEmployeeId(employeeId);
			EmployeeLeaveDetailsService.updateLeaveRequest(status, id, comments, elb, employeeId, leave, noOfDays);
		} catch (SQLException | DAOException e) {
			e.printStackTrace();
		}
		request.setAttribute("successMsg", "Succesfully " + status + " the leave !!");

		doGet(request, response);
	}

}
