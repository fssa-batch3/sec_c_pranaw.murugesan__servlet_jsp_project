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

import com.fssa.leavemanagement.exceptions.DAOException;
import com.fssa.leavemanagement.exceptions.InvalidRoleException;
import com.fssa.leavemanagement.model.Role;
import com.fssa.leavemanagement.service.RoleService;

/**
 * Servlet implementation class EmployeeRoleServlet1
 */
@WebServlet("/EmployeeRoleServlet1")
public class EmployeeRoleServlet1 extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public EmployeeRoleServlet1() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			List<Role> roles = RoleService.getAllRole();
			request.setAttribute("ROLE_LIST", roles);
			RequestDispatcher rd = request.getRequestDispatcher("./roles.jsp");
			rd.forward(request, response);
		} catch (InvalidRoleException | SQLException | DAOException e) {
			e.printStackTrace();
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
