package com.swiftbus.servlet;

import com.swiftbus.model.Route;
import com.swiftbus.service.RouteService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/home")
public class HomePageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private RouteService routeService;

    @Override
    public void init() throws ServletException {
        routeService = new RouteService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Load top 6 routes
        List<Route> popularRoutes = routeService.getTopRoutes(6);
        request.setAttribute("routes", popularRoutes);

        // 2. Check if user is logged in
        HttpSession session = request.getSession(false);
        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);
        request.setAttribute("isLoggedIn", isLoggedIn);

        // 3. Forward to home.jsp
        request.getRequestDispatcher("/client/home.jsp").forward(request, response);
    }
}