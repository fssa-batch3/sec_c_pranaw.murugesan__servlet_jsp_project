package com.fssa.leavemanagement.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;

import com.fssa.leavemanagement.exceptions.DAOException;
import com.fssa.leavemanagement.exceptions.InvalidEmployeeException;
import com.fssa.leavemanagement.model.Employee;
import com.fssa.leavemanagement.service.EmployeeService;
import com.fssa.leavemanagement.util.Logger;

/**
 * Servlet implementation class FindEmployeeByNameServlet
 */
@WebServlet("/FindEmployeeByNameServlet")
public class FindEmployeeByNameServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public FindEmployeeByNameServlet() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String employeeName = request.getParameter("searchname");
		System.out.println(employeeName);
		try {
			Employee employee = EmployeeService.findEmployeeByName(employeeName);
			if (employee != null) {
				// Convert the employee object to JSON
				JSONArray json = new JSONArray(employee);
				String employeeJson = json.toString();

				// Set response content type to JSON
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");

				// Send the JSON response
				response.getWriter().write(employeeJson);
			} else {
				// Handle the case when the employee is not found
				response.sendError(HttpServletResponse.SC_NOT_FOUND, "Employee not found");
			}
		} catch (InvalidEmployeeException | DAOException | SQLException e) {
			Logger.info(e.getMessage());
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error fetching employee details");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
