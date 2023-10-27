package com.fssa.leavemanagement.servlet;

import java.io.IOException;
import java.sql.SQLException;

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
		
		String enteredPassword = request.getParameter("password");
		String enteredEmail = request.getParameter("email");
		String userType = request.getParameter("user-type");
		final String error = "errorMsg";
		final String invalidUser = "Invalid email or password";
		final String loginRedirection = "login.jsp";
		Employee user = null;
		if ("employee".equals(userType)) {

			try {
				user = EmployeeService.findEmployeeByEmail(enteredEmail);
			} catch (DAOException | SQLException | InvalidEmployeeException e) {
				e.printStackTrace();
			}

			if (user != null && user.isStatus()) {
				String hashedEnteredPassword = null;
				try {
					hashedEnteredPassword = EmployeeDao.hashPassword(enteredPassword);
					if (hashedEnteredPassword.equals(user.getPassword())) {
						// Passwords match; user is authenticated
						HttpSession session = request.getSession();
						session.setAttribute("loggedInEmail", enteredEmail);
						request.setAttribute("successMsg", "Successfully Logged in !!");
						request.setAttribute("path", "Dashboard");
						request.getRequestDispatcher("./login.jsp").forward(request, response);
					} else {
						// Passwords do not match; authentication failed
						request.setAttribute(error, invalidUser);
						request.setAttribute("path", loginRedirection);
						request.getRequestDispatcher(loginRedirection).forward(request, response);
					}
				} catch (InvalidEmployeeException e) {
					e.printStackTrace();
				}

			} else {
				// User not found in the database; authentication failed
				request.setAttribute(error, invalidUser);
				request.setAttribute("path", loginRedirection);
				request.getRequestDispatcher(loginRedirection).forward(request, response);
			}
		} else {

			if (System.getenv("ADMIN_PASSWORD").equals(enteredPassword) && System.getenv("ADMIN_EMAIL").equals(enteredEmail)) {
				HttpSession session = request.getSession();
				session.setAttribute("loggedInEmail", enteredEmail);
				int sNo = 0;
				session.setAttribute("sNo", sNo);
				request.setAttribute("successMsg", "Successfully Logged in !!");
				request.setAttribute("path", "EmployeeServlet1");
				request.getRequestDispatcher(loginRedirection).forward(request, response);
			} else {
				request.setAttribute(error, invalidUser);
				request.setAttribute("path", loginRedirection);
				request.getRequestDispatcher(loginRedirection).forward(request, response);
			}
		}
	}

}
