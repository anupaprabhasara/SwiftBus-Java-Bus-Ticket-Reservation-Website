<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en" class="dark">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>SwiftBus | Schedules</title>
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

      <!-- Actions: Create & Search -->
      <div class="flex flex-col md:flex-row md:justify-between md:items-center space-y-4 md:space-y-0">

        <a href="${pageContext.request.contextPath}/admin/schedule?action=create"
          class="flex items-center gap-2 px-5 py-2 bg-green-600 hover:bg-green-700 text-white rounded-lg font-semibold transition">
          <i class="fas fa-plus"></i> Create New Schedule
        </a>

        <div class="relative w-full md:w-1/3">
          <input id="search" type="text" placeholder="Search schedules..."
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
              <th class="px-6 py-4">Bus Number</th>
              <th class="px-6 py-4">Route</th>
              <th class="px-6 py-4">Ticket Price</th>
              <th class="px-6 py-4">Start Time</th>
              <th class="px-6 py-4">Arrival Time</th>
              <th class="px-6 py-4 text-center">Actions</th>
            </tr>
          </thead>
          <tbody class="text-gray-300">
            <c:choose>
              <c:when test="${not empty schedules}">
                <c:forEach var="schedule" items="${schedules}">
                  <tr class="border-b border-gray-700 hover:bg-gray-700/50">
                    <td class="px-6 py-4">${schedule.scheduleId}</td>
                    <td class="px-6 py-4">${schedule.busNumber}</td>
                    <td class="px-6 py-4">${schedule.startLocation} → ${schedule.endLocation}</td>
                    <td class="px-6 py-4">Rs. ${schedule.ticketPrice}</td>
                    <td class="px-6 py-4">${schedule.startTime}</td>
                    <td class="px-6 py-4">${schedule.arrivalTime}</td>
                    <td class="px-6 py-4 text-center space-x-3">
                      <a href="${pageContext.request.contextPath}/admin/schedule?action=edit&id=${schedule.scheduleId}" class="text-green-400 hover:text-green-500">
                        <i class="fas fa-edit"></i>
                      </a>
                      <a href="${pageContext.request.contextPath}/admin/schedule?action=delete&id=${schedule.scheduleId}" onclick="return confirmDelete(this.href);" class="text-red-400 hover:text-red-500">
                        <i class="fas fa-trash"></i>
                      </a>
                    </td>
                  </tr>
                </c:forEach>
              </c:when>
              <c:otherwise>
                <tr>
                  <td colspan="7" class="px-6 py-4 text-center text-gray-400">No schedules found.</td>
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