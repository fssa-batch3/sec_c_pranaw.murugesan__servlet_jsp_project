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

import com.fssa.leavemanagement.dao.EmployeeDao;
import com.fssa.leavemanagement.exceptions.DAOException;
import com.fssa.leavemanagement.exceptions.InvalidEmployeeException;
import com.fssa.leavemanagement.model.Employee;
import com.fssa.leavemanagement.service.EmployeeService;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public LoginServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		String enteredPassword = request.getParameter("password");
		String enteredEmail = request.getParameter("email");
		String userType = request.getParameter("user-type");
		final String error = "error";
		final String invalidUser = "Invalid email or password";
		final String loginRedirection = "login.jsp";
		Employee user = null;
		if ("employee".equals(userType)) {

			try {
				user = EmployeeService.findEmployeeByEmail(enteredEmail);
			} catch (DAOException | SQLException | InvalidEmployeeException e) {
				e.printStackTrace();
			}

			if (user != null) {
				String hashedEnteredPassword = null;
				try {
					hashedEnteredPassword = EmployeeDao.hashPassword(enteredPassword);
				} catch (InvalidEmployeeException e) {
					e.printStackTrace();
				}

				if (hashedEnteredPassword.equals(user.getPassword())) {
					// Passwords match; user is authenticated
					// Redirect to a protected resource or set a session attribute, etc.
					session.setAttribute("loggedInEmail", enteredEmail);
					response.sendRedirect("Dashboard");
				} else {
					// Passwords do not match; authentication failed
					// Handle authentication failure (e.g., show an error message)
					request.setAttribute(error, invalidUser);
					request.getRequestDispatcher(loginRedirection).forward(request, response);
				}
			} else {
				// User not found in the database; authentication failed
				// Handle authentication failure (e.g., show an error message)
				request.setAttribute(error, invalidUser);
				request.getRequestDispatcher(loginRedirection).forward(request, response);
			}
		} else {

			if ("admin@FRESH2023".equals(enteredPassword) && "admin@freshworks.com".equals(enteredEmail)) {

				session.setAttribute("loggedInEmail", enteredEmail);
				session.setMaxInactiveInterval(10);
				RequestDispatcher rd = request.getRequestDispatcher("EmployeeServlet1");
				rd.forward(request, response);
			} else {
				request.setAttribute(error, invalidUser);
				request.getRequestDispatcher(loginRedirection).forward(request, response);
			}
		}
	}

}
