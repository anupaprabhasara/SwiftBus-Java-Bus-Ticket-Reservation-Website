package com.swiftbus.servlet;

import com.swiftbus.model.Booking;
import com.swiftbus.service.BookingService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/booking")
public class BookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private BookingService bookingService;

    @Override
    public void init() throws ServletException {
        bookingService = new BookingService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        try {
            List<Booking> bookings = bookingService.getAllBookings();
            request.setAttribute("bookings", bookings);
            request.getRequestDispatcher("/admin/bookings/index.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to load bookings.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        String action = request.getParameter("action");

        if ("update".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                String status = request.getParameter("status");

                Booking booking = new Booking();
                booking.setBookingId(id);
                booking.setStatus(status);

                boolean success = bookingService.updateBooking(booking);
                if (success) {
                    response.sendRedirect(request.getContextPath() + "/admin/booking");
                } else {
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to update booking.");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing update.");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action.");
        }
    }
}