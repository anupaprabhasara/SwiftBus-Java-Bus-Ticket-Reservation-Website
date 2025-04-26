package com.swiftbus.servlet;

import com.swiftbus.model.Admin;
import com.swiftbus.service.AdminService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/login")
public class AdminLoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private AdminService adminService = new AdminService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String usernameOrEmail = request.getParameter("username");
        String password = request.getParameter("password");

        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("admin") != null) {
            response.sendRedirect(request.getContextPath() + "/admin/admin");
            return;
        }

        // Authenticate admin
        Admin admin = authenticateAdmin(usernameOrEmail, password);

        if (admin != null) {
            session = request.getSession(true);
            session.setAttribute("admin", admin);
            session.setAttribute("adminId", admin.getAdminId());
            session.setAttribute("username", admin.getUsername());
            session.setAttribute("email", admin.getEmail());
            session.setMaxInactiveInterval(30 * 60); // 30 minutes

            response.sendRedirect(request.getContextPath() + "/admin/admin");
        } else {
            request.setAttribute("error", "Incorrect username/email or password!");
            request.getRequestDispatcher("/admin/login.jsp").forward(request, response);
        }
    }

    private Admin authenticateAdmin(String usernameOrEmail, String password) {
        List<Admin> admins = adminService.getAllAdmins();
        for (Admin admin : admins) {
            if ((admin.getUsername().equalsIgnoreCase(usernameOrEmail) || admin.getEmail().equalsIgnoreCase(usernameOrEmail))
                    && admin.getPassword().equals(password)) {
                return admin;
            }
        }
        return null;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("admin") != null) {
            response.sendRedirect(request.getContextPath() + "/admin/admin");
        } else {
            request.getRequestDispatcher("/admin/login.jsp").forward(request, response);
        }
    }
}