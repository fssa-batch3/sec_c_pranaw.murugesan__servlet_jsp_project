package com.fssa.leavemanagement.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fssa.leavemanagement.exceptions.DAOException;
import com.fssa.leavemanagement.exceptions.InvalidEmployeeException;
import com.fssa.leavemanagement.exceptions.InvalidRoleException;
import com.fssa.leavemanagement.model.Employee;
import com.fssa.leavemanagement.model.Role;
import com.fssa.leavemanagement.service.EmployeeService;
import com.fssa.leavemanagement.service.RoleService;

/**
 * Servlet implementation class EmployeeServlet1
 */
@WebServlet("/EmployeeServlet1")
public class EmployeeServlet1 extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public EmployeeServlet1() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher rd = null;

		String action = request.getParameter("action");
		String employeeName = request.getParameter("searchname");
		System.out.println(employeeName);

		try {
			List<Role> roles = RoleService.getAllRole();
			request.setAttribute("ROLE_LIST", roles);
			List<Employee> employeeList = EmployeeService.getAllEmployee();
			if (employeeName != null) {
				Employee e = EmployeeService.findEmployeeByName(employeeName);
				employeeList.clear();
				employeeList.add(e);
			}

			request.setAttribute("EMPLOYEE_LIST", employeeList);

		} catch (DAOException | SQLException | InvalidRoleException | InvalidEmployeeException e) {
			e.printStackTrace();
		}

		if ("edit".equals(action)) {

			String email = request.getParameter("email");
			Employee emp;
			try {
				emp = EmployeeService.findEmployeeByEmail(email);
				request.setAttribute("employee", emp);

			} catch (InvalidEmployeeException | DAOException | SQLException e) {

				e.printStackTrace();
			}
		}

		rd = request.getRequestDispatcher("./employeeList.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		/**
		 * Writing in do post method to add employee
		 */

		Employee employee = new Employee();
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String manager = request.getParameter("manager");
		String role = request.getParameter("role");
		employee.setName(name);
		employee.setEmail(email);
		employee.setPassword(password);
		employee.setManager(manager);
		try {

			EmployeeService.addEmployee(employee, role);
			request.setAttribute("successMsg", "Added Successfully");

		} catch (InvalidEmployeeException | DAOException | SQLException e) {
			request.setAttribute("errorMsg", e.getMessage());
			e.printStackTrace();
		}
		doGet(request, response);

	}

}
