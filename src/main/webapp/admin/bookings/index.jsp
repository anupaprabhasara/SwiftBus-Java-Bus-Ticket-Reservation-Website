<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en" class="dark">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>SwiftBus | Bookings</title>
  <link rel="shortcut icon" href="https://ui-avatars.com/api/?name=${sessionScope.username}&background=22c55e&color=fff&rounded=true" type="image/x-icon">

  <!-- Tailwind CSS -->
  <script src="https://cdn.tailwindcss.com"></script>
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
</head>

<body class="bg-gray-900 text-gray-100 min-h-screen flex">

  <!-- Sidebar (fixed) -->
  <%@ include file="../partials/sidebar.jsp" %>

  <!-- Main Content -->
  <div class="flex-1 flex flex-col md:ml-60">

    <!-- Topbar -->
    <%@ include file="../partials/header.jsp" %>

    <!-- Main Area -->
    <main class="flex-1 p-6 space-y-6">

      <!-- Actions: Search (Right Aligned) -->
	  <div class="flex flex-col md:flex-row md:justify-end md:items-center space-y-4 md:space-y-0">
	
	    <div class="relative w-full md:w-1/3">
	      <input id="search" type="text" placeholder="Search bookings..."
	        class="w-full pl-10 pr-4 py-2 rounded-lg bg-gray-700 border border-gray-600 focus:ring-2 focus:ring-green-500 focus:outline-none text-white">
	      <i class="fas fa-search absolute left-3 top-3 text-gray-400"></i>
	    </div>
	
	  </div>

      <!-- Data Table -->
      <div class="overflow-x-auto bg-gray-800 shadow-lg rounded-lg">
        <table class="w-full text-sm text-left">
          <thead class="text-xs uppercase bg-gray-700 text-gray-300">
            <tr>
              <th class="px-6 py-4">ID</th>
              <th class="px-6 py-4">User</th>
              <th class="px-6 py-4">Route</th>
              <th class="px-6 py-4">Travel Date</th>
              <th class="px-6 py-4">Seats</th>
              <th class="px-6 py-4">Status</th>
            </tr>
          </thead>
          <tbody id="table" class="text-gray-300">
            <c:choose>
              <c:when test="${not empty bookings}">
                <c:forEach var="b" items="${bookings}">
                  <tr class="border-b border-gray-700 hover:bg-gray-700/50">
                    <td class="px-6 py-4">${b.bookingId}</td>
                    <td class="px-6 py-4">
                      ${b.userName}<br/>
                      <span class="text-xs text-gray-400">${b.userEmail}</span>
                    </td>
                    <td class="px-6 py-4">
                      ${b.busNumber} | ${b.startLocation} → ${b.endLocation}<br/>
                      <span class="text-xs text-gray-400">Rs. ${b.ticketPrice}</span>
                    </td>
                    <td class="px-6 py-4">${b.travelDate}</td>
                    <td class="px-6 py-4">${b.numberOfSeats}</td>

                    <!-- Inline Status Update Form -->
                    <td class="px-6 py-4">
                      <form action="${pageContext.request.contextPath}/admin/booking" method="post" class="inline">
                        <input type="hidden" name="action" value="update" />
                        <input type="hidden" name="id" value="${b.bookingId}" />
                        <select name="status" onchange="this.form.submit()"
                          class="bg-gray-700 border border-gray-600 text-white text-sm rounded px-2 py-1 focus:ring-2 focus:ring-green-500">
                          <option value="Pending" ${b.status == 'Pending' ? 'selected' : ''}>Pending</option>
                          <option value="Confirmed" ${b.status == 'Confirmed' ? 'selected' : ''}>Confirmed</option>
                          <option value="Cancelled" ${b.status == 'Cancelled' ? 'selected' : ''}>Cancelled</option>
                        </select>
                      </form>
                    </td>
                    
                  </tr>
                </c:forEach>
              </c:when>
              <c:otherwise>
                <tr>
                  <td colspan="7" class="px-6 py-4 text-center text-gray-400">
                    No bookings found.
                  </td>
                </tr>
              </c:otherwise>
            </c:choose>
          </tbody>
        </table>
      </div>

    </main>
  </div>

  <!-- JavaScript -->
  <%@ include file="../partials/script.jsp" %>

</body>
</html>