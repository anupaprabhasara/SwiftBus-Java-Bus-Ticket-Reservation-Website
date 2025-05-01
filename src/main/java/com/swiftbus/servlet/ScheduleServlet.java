package com.swiftbus.servlet;

import com.swiftbus.model.Schedule;
import com.swiftbus.model.Bus;
import com.swiftbus.model.Route;
import com.swiftbus.service.ScheduleService;
import com.swiftbus.service.BusService;
import com.swiftbus.service.RouteService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@SuppressWarnings("unused")
@WebServlet("/admin/schedule")
public class ScheduleServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private ScheduleService scheduleService;
    private BusService busService;
    private RouteService routeService;

    @Override
    public void init() throws ServletException {
        scheduleService = new ScheduleService();
        busService = new BusService();
        routeService = new RouteService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Session check
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        String action = request.getParameter("action");

        try {
            if (action == null) {
                // List all schedules
                request.setAttribute("schedules", scheduleService.getAllSchedules());
                request.getRequestDispatcher("/admin/schedules/index.jsp").forward(request, response);

            } else if ("create".equals(action)) {
                // Load form with buses and routes
                request.setAttribute("buses", busService.getAllBuses());
                request.setAttribute("routes", routeService.getAllRoutes());
                request.getRequestDispatcher("/admin/schedules/create.jsp").forward(request, response);

            } else if ("edit".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Schedule schedule = scheduleService.getScheduleById(id);
                if (schedule != null) {
                    request.setAttribute("schedule", schedule);
                    request.setAttribute("buses", busService.getAllBuses());
                    request.setAttribute("routes", routeService.getAllRoutes());
                    request.getRequestDispatcher("/admin/schedules/update.jsp").forward(request, response);
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Schedule not found.");
                }

            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                scheduleService.deleteSchedule(id);
                response.sendRedirect(request.getContextPath() + "/admin/schedule");

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
        // Session check
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        String action = request.getParameter("action");

        try {
            int busId = Integer.parseInt(request.getParameter("bus_id"));
            int routeId = Integer.parseInt(request.getParameter("route_id"));
            String startTime = request.getParameter("start_time");
            String arrivalTime = request.getParameter("arrival_time");

            Schedule schedule = new Schedule();
            schedule.setBusId(busId);
            schedule.setRouteId(routeId);
            schedule.setStartTime(startTime);
            schedule.setArrivalTime(arrivalTime);

            if ("create".equals(action)) {
                if (scheduleService.createSchedule(schedule)) {
                    response.sendRedirect(request.getContextPath() + "/admin/schedule");
                } else {
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to create schedule.");
                }

            } else if ("update".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                schedule.setScheduleId(id);
                if (scheduleService.updateSchedule(schedule)) {
                    response.sendRedirect(request.getContextPath() + "/admin/schedule");
                } else {
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to update schedule.");
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