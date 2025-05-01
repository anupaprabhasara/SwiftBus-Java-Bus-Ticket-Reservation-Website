<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en" class="dark">
<head>
  <meta charset="UTF-8">
  <title>SwiftBus | Dashboard</title>
  <link rel="shortcut icon" href="https://ui-avatars.com/api/?name=${sessionScope.username}&background=22c55e&color=fff&rounded=true" type="image/x-icon">
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
</head>

<body class="bg-gray-900 text-white min-h-screen flex">

  <!-- Sidebar -->
  <%@ include file="./partials/sidebar.jsp" %>

  <!-- Main Content -->
  <div class="flex-1 flex flex-col md:ml-60">

    <!-- Topbar -->
    <%@ include file="./partials/header.jsp" %>

    <!-- Dashboard Content -->
    <main class="p-6 space-y-6">
      <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
        
        <!-- Total Users -->
        <div class="bg-gray-800 p-6 rounded-lg shadow-md flex items-center gap-4">
          <i class="fas fa-user text-2xl text-green-400"></i>
          <div>
            <p class="text-sm text-gray-400">Total Users</p>
            <h2 class="text-xl font-bold">${totalUsers}</h2>
          </div>
        </div>

        <!-- Total Buses -->
        <div class="bg-gray-800 p-6 rounded-lg shadow-md flex items-center gap-4">
          <i class="fas fa-bus text-2xl text-blue-400"></i>
          <div>
            <p class="text-sm text-gray-400">Total Buses</p>
            <h2 class="text-xl font-bold">${totalBuses}</h2>
          </div>
        </div>

        <!-- Total Routes -->
        <div class="bg-gray-800 p-6 rounded-lg shadow-md flex items-center gap-4">
          <i class="fas fa-road text-2xl text-yellow-400"></i>
          <div>
            <p class="text-sm text-gray-400">Total Routes</p>
            <h2 class="text-xl font-bold">${totalRoutes}</h2>
          </div>
        </div>

        <!-- Total Bookings -->
        <div class="bg-gray-800 p-6 rounded-lg shadow-md flex items-center gap-4">
          <i class="fas fa-ticket-alt text-2xl text-red-400"></i>
          <div>
            <p class="text-sm text-gray-400">Total Bookings</p>
            <h2 class="text-xl font-bold">${totalBookings}</h2>
          </div>
        </div>

      </div>
      
      <!-- Latest Bookings Table -->
	  <div class="bg-gray-800 rounded-lg shadow-md p-6">
	    <h2 class="text-xl font-semibold mb-4">Latest 3 Bookings</h2>
	    <div class="overflow-x-auto">
	      <table class="w-full text-sm text-left text-gray-300">
	        <thead class="text-xs uppercase bg-gray-700 text-gray-300">
	          <tr>
	            <th class="px-4 py-3">User</th>
	            <th class="px-4 py-3">Route</th>
	            <th class="px-4 py-3">Date</th>
	            <th class="px-4 py-3">Status</th>
	          </tr>
	        </thead>
	        <tbody>
	          <c:forEach var="b" items="${latestBookings}">
	            <tr class="border-b border-gray-700 hover:bg-gray-700/50">
	              <td class="px-4 py-3">
	                ${b.userName}<br>
	                <span class="text-xs text-gray-400">${b.userEmail}</span>
	              </td>
	              <td class="px-4 py-3">
	                ${b.busNumber} — ${b.startLocation} → ${b.endLocation}<br>
	                <span class="text-xs text-gray-400">Rs. ${b.ticketPrice}</span>
	              </td>
	              <td class="px-4 py-3">${b.travelDate}</td>
	              <td class="px-4 py-3">
	                <span class="text-xs px-2 py-1 rounded bg-gray-700 text-white">${b.status}</span>
	              </td>
	            </tr>
	          </c:forEach>
	        </tbody>
	      </table>
	    </div>
	  </div>
    </main>
  </div>

</body>
</html>