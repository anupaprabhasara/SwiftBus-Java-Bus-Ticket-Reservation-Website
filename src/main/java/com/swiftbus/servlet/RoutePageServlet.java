package com.swiftbus.servlet;

import com.swiftbus.model.Route;
import com.swiftbus.service.RouteService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/routes")
public class RoutePageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private RouteService routeService;

    @Override
    public void init() throws ServletException {
        routeService = new RouteService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Load all routes
        List<Route> routes = routeService.getAllRoutes();
        request.setAttribute("routes", routes);

        // 2. Check login status
        HttpSession session = request.getSession(false);
        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);
        request.setAttribute("isLoggedIn", isLoggedIn);

        // 3. Forward to route.jsp
        request.getRequestDispatcher("/client/route.jsp").forward(request, response);
    }
}