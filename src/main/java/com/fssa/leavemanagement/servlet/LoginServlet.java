package com.fssa.leavemanagement.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		String enteredPassword = request.getParameter("password");
		String enteredEmail = request.getParameter("email");

		Employee user = null;
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
				response.sendRedirect("dashboard.jsp");
			} else {
				// Passwords do not match; authentication failed
				// Handle authentication failure (e.g., show an error message)
				request.setAttribute("error", "Invalid password");
				request.getRequestDispatcher("login.jsp").forward(request, response);
			}
		} else {
			// User not found in the database; authentication failed
			// Handle authentication failure (e.g., show an error message)
			request.setAttribute("error", "User not found");
			request.getRequestDispatcher("login.jsp").forward(request, response);
		}
	}

}