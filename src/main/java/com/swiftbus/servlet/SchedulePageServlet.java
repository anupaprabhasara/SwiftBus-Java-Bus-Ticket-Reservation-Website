package com.swiftbus.servlet;

import com.swiftbus.model.Schedule;
import com.swiftbus.model.Booking;
import com.swiftbus.model.User;
import com.swiftbus.service.ScheduleService;
import com.swiftbus.service.BookingService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/schedules")
public class SchedulePageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ScheduleService scheduleService;
    private BookingService bookingService;

    @Override
    public void init() throws ServletException {
        scheduleService = new ScheduleService();
        bookingService = new BookingService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Schedule> schedules = scheduleService.getAllSchedules();
        request.setAttribute("schedules", schedules);

        HttpSession session = request.getSession(false);
        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);
        request.setAttribute("isLoggedIn", isLoggedIn);

        request.getRequestDispatcher("/client/schedule.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            int scheduleId = Integer.parseInt(request.getParameter("scheduleId"));
            String travelDate = request.getParameter("travelDate");
            int numberOfSeats = Integer.parseInt(request.getParameter("numberOfSeats"));
            int userId = ((User) session.getAttribute("user")).getUserId();

            Booking booking = new Booking();
            booking.setUserId(userId);
            booking.setScheduleId(scheduleId);
            booking.setTravelDate(travelDate);
            booking.setNumberOfSeats(numberOfSeats);
            booking.setStatus("Pending");

            boolean booked = bookingService.createBooking(booking);
            if (booked) {
                request.setAttribute("success", "Booking successful!");
            } else {
                request.setAttribute("error", "Booking failed. Please try again.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Invalid input or internal error.");
        }

        doGet(request, response);
    }
}