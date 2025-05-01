<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en" class="dark">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>SwiftBus | Edit Schedule</title>
  <link rel="shortcut icon" href="https://ui-avatars.com/api/?name=${sessionScope.username}&background=22c55e&color=fff&rounded=true" type="image/x-icon">

  <!-- Tailwind CSS -->
  <script src="https://cdn.tailwindcss.com"></script>

  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
</head>

<body class="bg-gray-900 text-gray-100 min-h-screen flex">

  <!-- Sidebar -->
  <%@ include file="../partials/sidebar.jsp" %>

  <!-- Main Content -->
  <div class="flex-1 flex flex-col md:ml-60">

    <!-- Topbar -->
    <%@ include file="../partials/header.jsp" %>

    <!-- Main Area -->
    <main class="flex-1 p-6 space-y-6">

      <form action="${pageContext.request.contextPath}/admin/schedule" method="POST" class="bg-gray-800 shadow-lg rounded-lg p-8 w-full">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="id" value="${schedule.scheduleId}">

        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
        
          <!-- Bus Dropdown -->
          <div class="space-y-4">
            <div>
              <label class="block text-sm font-medium mb-1" for="bus_id">Select Bus</label>
              <select name="bus_id" id="bus_id" required
                class="w-full px-4 py-2 rounded-lg border border-gray-600 bg-gray-700 text-white focus:ring-2 focus:ring-green-500 focus:outline-none">
                <option value="" disabled>Select a bus</option>
                <c:forEach var="bus" items="${buses}">
                  <option value="${bus.busId}" <c:if test="${bus.busNumber eq schedule.busNumber}">selected</c:if>>
                    ${bus.busNumber}
                  </option>
                </c:forEach>
              </select>
            </div>

            <!-- Start Time -->
            <div>
              <label class="block text-sm font-medium mb-1" for="start_time">Start Time</label>
              <input type="time" id="start_time" name="start_time" required
                value="${schedule.startTime}"
                class="w-full px-4 py-2 rounded-lg border border-gray-600 bg-gray-700 text-white focus:ring-2 focus:ring-green-500 focus:outline-none">
            </div>
          </div>

          <!-- Route Dropdown and Arrival Time -->
          <div class="space-y-4">
            <div>
              <label class="block text-sm font-medium mb-1" for="route_id">Select Route</label>
              <select name="route_id" id="route_id" required
                class="w-full px-4 py-2 rounded-lg border border-gray-600 bg-gray-700 text-white focus:ring-2 focus:ring-green-500 focus:outline-none">
                <option value="" disabled>Select a route</option>
                <c:forEach var="route" items="${routes}">
                  <option value="${route.routeId}" <c:if test="${route.startLocation eq schedule.startLocation && route.endLocation eq schedule.endLocation}">selected</c:if>>
                    ${route.startLocation} → ${route.endLocation}
                  </option>
                </c:forEach>
              </select>
            </div>

            <!-- Arrival Time -->
            <div>
              <label class="block text-sm font-medium mb-1" for="arrival_time">Arrival Time</label>
              <input type="time" id="arrival_time" name="arrival_time" required
                value="${schedule.arrivalTime}"
                class="w-full px-4 py-2 rounded-lg border border-gray-600 bg-gray-700 text-white focus:ring-2 focus:ring-green-500 focus:outline-none">
            </div>
          </div>
        </div>

        <!-- Submit -->
        <div class="mt-8 flex justify-end">
          <button type="submit" class="flex items-center gap-2 px-6 py-2 bg-green-600 hover:bg-green-700 text-white rounded-lg font-semibold transition">
            <i class="fas fa-save"></i> Update Schedule
          </button>
        </div>
      </form>

    </main>
  </div>

  <%@ include file="../partials/script.jsp" %>

</body>
</html>