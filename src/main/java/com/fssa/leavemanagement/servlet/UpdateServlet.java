package com.fssa.leavemanagement.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fssa.leavemanagement.exceptions.DAOException;
import com.fssa.leavemanagement.exceptions.InvalidEmployeeException;
import com.fssa.leavemanagement.model.Employee;
import com.fssa.leavemanagement.service.EmployeeService;

/**
 * Servlet implementation class UpdateServlet
 */
@WebServlet("/UpdateServlet")
public class UpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public UpdateServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
//		PrintWriter out = response.getWriter();
//		out.println("helloworld");
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String manager = request.getParameter("manager");
		String password = request.getParameter("password");
		Employee employee = new Employee();
		employee.setManager(manager);
		employee.setEmail(email);
		employee.setName(name);
		employee.setPassword(password);

		try {
			EmployeeService.updateEmployee(employee);

		} catch (InvalidEmployeeException | DAOException e) {
			e.printStackTrace();
		}
		doGet(request, response);
	}

}
