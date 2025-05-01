package com.swiftbus.servlet;

import com.swiftbus.model.Route;
import com.swiftbus.service.RouteService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/route")
public class RouteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private RouteService routeService;

    @Override
    public void init() throws ServletException {
        routeService = new RouteService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Session Check
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        String action = request.getParameter("action");

        try {
            if (action == null) {
                // List all routes
                request.setAttribute("routes", routeService.getAllRoutes());
                request.getRequestDispatcher("/admin/routes/index.jsp").forward(request, response);

            } else if ("create".equals(action)) {
                // Show create form
                request.getRequestDispatcher("/admin/routes/create.jsp").forward(request, response);

            } else if ("edit".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Route route = routeService.getRoute(id);
                if (route != null) {
                    request.setAttribute("route", route);
                    request.getRequestDispatcher("/admin/routes/update.jsp").forward(request, response);
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Route not found.");
                }

            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                routeService.deleteRoute(id);
                response.sendRedirect(request.getContextPath() + "/admin/route");

            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Session Check
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        String action = request.getParameter("action");

        try {
            if ("create".equals(action)) {
                String startLocation = request.getParameter("start_location");
                String endLocation = request.getParameter("end_location");
                double ticketPrice = Double.parseDouble(request.getParameter("ticket_price"));

                Route route = new Route();
                route.setStartLocation(startLocation);
                route.setEndLocation(endLocation);
                route.setTicketPrice(ticketPrice);

                if (routeService.createRoute(route)) {
                    response.sendRedirect(request.getContextPath() + "/admin/route");
                } else {
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to create route.");
                }

            } else if ("update".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                String startLocation = request.getParameter("start_location");
                String endLocation = request.getParameter("end_location");
                double ticketPrice = Double.parseDouble(request.getParameter("ticket_price"));

                Route route = new Route();
                route.setRouteId(id);
                route.setStartLocation(startLocation);
                route.setEndLocation(endLocation);
                route.setTicketPrice(ticketPrice);

                if (routeService.updateRoute(route)) {
                    response.sendRedirect(request.getContextPath() + "/admin/route");
                } else {
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to update route.");
                }

            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while processing your request.");
        }
    }
}