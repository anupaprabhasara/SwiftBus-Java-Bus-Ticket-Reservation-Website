package com.swiftbus.servlet;

import com.swiftbus.model.Bus;
import com.swiftbus.service.BusService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/bus")
public class BusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BusService busService;

    @Override
    public void init() throws ServletException {
        busService = new BusService();
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
                // List all buses
                request.setAttribute("buses", busService.getAllBuses());
                request.getRequestDispatcher("/admin/buses/index.jsp").forward(request, response);

            } else if ("create".equals(action)) {
                // Show create form
                request.getRequestDispatcher("/admin/buses/create.jsp").forward(request, response);

            } else if ("edit".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Bus bus = busService.getBus(id);
                if (bus != null) {
                    request.setAttribute("bus", bus);
                    request.getRequestDispatcher("/admin/buses/update.jsp").forward(request, response);
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Bus not found.");
                }

            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                busService.deleteBus(id);
                response.sendRedirect(request.getContextPath() + "/admin/bus");

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
                String busNumber = request.getParameter("bus_number");
                int totalSeats = Integer.parseInt(request.getParameter("total_seats"));

                Bus bus = new Bus();
                bus.setBusNumber(busNumber);
                bus.setTotalSeats(totalSeats);

                if (busService.createBus(bus)) {
                    response.sendRedirect(request.getContextPath() + "/admin/bus");
                } else {
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to create bus.");
                }

            } else if ("update".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                String busNumber = request.getParameter("bus_number");
                int totalSeats = Integer.parseInt(request.getParameter("total_seats"));

                Bus bus = new Bus();
                bus.setBusId(id);
                bus.setBusNumber(busNumber);
                bus.setTotalSeats(totalSeats);

                if (busService.updateBus(bus)) {
                    response.sendRedirect(request.getContextPath() + "/admin/bus");
                } else {
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to update bus.");
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