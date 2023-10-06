package com.fssa.leavemanagement.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fssa.leavemanagement.exceptions.DAOException;
import com.fssa.leavemanagement.exceptions.InvalidRoleException;
import com.fssa.leavemanagement.model.Role;
import com.fssa.leavemanagement.service.RoleService;

/**
 * Servlet implementation class DeleteRoleServlet
 */
@WebServlet("/DeleteRoleServlet")
public class DeleteRoleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public DeleteRoleServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String name = request.getParameter("name");
		if (name != null) {

			Role role = new Role(name);
			try {
				RoleService.deleteRole(role);
				request.setAttribute("successMsg", "Successfully Deleted Role");
			} catch (InvalidRoleException | SQLException | DAOException e) {
				e.printStackTrace();
			}
		}
		request.getRequestDispatcher("EmployeeRoleServlet1").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}
