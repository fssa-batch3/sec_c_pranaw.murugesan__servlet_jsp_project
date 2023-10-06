package com.fssa.leavemanagement.servlet;

import java.io.IOException;

import java.sql.SQLException;
import java.time.LocalDate;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fssa.leavemanagement.dao.EmployeeDao;
import com.fssa.leavemanagement.exceptions.DAOException;
import com.fssa.leavemanagement.exceptions.ValidatorException;
import com.fssa.leavemanagement.model.EmployeeLeaveDetails;
import com.fssa.leavemanagement.model.LeaveTypes;
import com.fssa.leavemanagement.service.EmployeeLeaveDetailsService;

/**
 * Servlet implementation class ApplyLeave
 */
@WebServlet("/ApplyLeave")
public class ApplyLeave extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ApplyLeave() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		String email = (String) session.getAttribute("loggedInEmail");
		String leaveReason = request.getParameter("reason");
		String leaveType = request.getParameter("leaveType");
		String startDate = request.getParameter("startDate");
		LocalDate startLocalDate = LocalDate.parse(startDate);
		String endDate = request.getParameter("endDate");
		LocalDate endLocalDate = LocalDate.parse(endDate);
		String noOfDays = (String) request.getParameter("noOfDays");
		double days = Double.parseDouble(noOfDays);

		EmployeeLeaveDetails eld = new EmployeeLeaveDetails();
		try {
			eld.setEmployeeId(EmployeeDao.getEmployeeIdByEmail(email));
			eld.setLeaveReason(leaveReason);
			eld.setLeaveType(LeaveTypes.valueOf(leaveType));
			eld.setManagerId(EmployeeDao.getEmployeeIdByEmail(EmployeeDao.getManagerEmailByEmployeeEmail(email)));
			eld.setStartDate(startLocalDate);
			eld.setEndDate(endLocalDate);
			eld.setNoOfDays(days);

			EmployeeLeaveDetailsService.applyLeave(eld, email);
			request.setAttribute("successMsg", "Applied Successfully");

		} catch (SQLException | DAOException | ValidatorException e) {
			request.setAttribute("errorMsg", e.getMessage());
			e.printStackTrace();
		}
		RequestDispatcher rd = request.getRequestDispatcher("apply.jsp");
		rd.forward(request, response);
		doGet(request, response);
	}

}
