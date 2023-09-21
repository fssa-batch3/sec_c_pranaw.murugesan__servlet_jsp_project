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

import com.fssa.leavemanagement.dao.EmployeeDao;
import com.fssa.leavemanagement.exceptions.DAOException;
import com.fssa.leavemanagement.exceptions.InvalidEmployeeException;
import com.fssa.leavemanagement.model.EmployeeLeaveDetails;
import com.fssa.leavemanagement.service.EmployeeLeaveDetailsService;
import com.fssa.leavemanagement.service.EmployeeService;

/**
 * Servlet implementation class Dashboard
 */
@WebServlet("/Dashboard")
public class Dashboard extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Dashboard() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();
			String email = (String) session.getAttribute("loggedInEmail");
			if (email == null) {
				response.sendRedirect("login.jsp");
			} else {

				List<EmployeeLeaveDetails> eldArray = EmployeeLeaveDetailsService.getLeaveRequestsByEmail(email);
				request.setAttribute("leaveReques", eldArray);
				RequestDispatcher rd = request.getRequestDispatcher("dashboard.jsp");
				rd.forward(request, response);
			}
		} catch (SQLException | DAOException | InvalidEmployeeException e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
