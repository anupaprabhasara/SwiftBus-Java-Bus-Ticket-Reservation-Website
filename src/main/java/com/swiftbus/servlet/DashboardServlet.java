package com.swiftbus.servlet;

import com.swiftbus.service.DashboardService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/dashboard")
public class DashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private DashboardService dashboardService;

    @Override
    public void init() throws ServletException {
        dashboardService = new DashboardService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        request.setAttribute("totalUsers", dashboardService.getTotalUsers());
        request.setAttribute("totalBuses", dashboardService.getTotalBuses());
        request.setAttribute("totalRoutes", dashboardService.getTotalRoutes());
        request.setAttribute("totalBookings", dashboardService.getTotalBookings());
        request.setAttribute("latestBookings", dashboardService.getLatestBookings());

        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }
}