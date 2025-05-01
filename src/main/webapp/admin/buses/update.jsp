<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en" class="dark">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>SwiftBus | Edit Bus</title>
  <link rel="shortcut icon" href="https://ui-avatars.com/api/?name=${sessionScope.username}&background=22c55e&color=fff&rounded=true" type="image/x-icon">

  <!-- Tailwind CSS -->
  <script src="https://cdn.tailwindcss.com"></script>
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
</head>

<body class="bg-gray-900 text-gray-100 min-h-screen flex">

  <!-- Sidebar (fixed) -->
  <%@ include file="../partials/sidebar.jsp" %>

  <!-- Main Content Area with Sidebar Margin -->
  <div class="flex-1 flex flex-col md:ml-60">

    <!-- Topbar -->
    <%@ include file="../partials/header.jsp" %>

    <!-- Main Area -->
    <main class="flex-1 p-6 space-y-6">

      <!-- Edit Bus Form -->
      <form action="${pageContext.request.contextPath}/admin/bus" method="POST" class="bg-gray-800 shadow-lg rounded-lg p-8 w-full">

        <input type="hidden" name="action" value="update">
        <input type="hidden" name="id" value="${bus.busId}">

        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
          
          <!-- Bus Number -->
          <div class="space-y-4">
            <div>
              <label class="block text-sm font-medium mb-1" for="bus_number">Bus Number</label>
              <input type="text" id="bus_number" name="bus_number" required
                value="${bus.busNumber}"
                class="w-full px-4 py-2 rounded-lg border border-gray-600 bg-gray-700 text-white focus:ring-2 focus:ring-green-500 focus:outline-none">
            </div>
          </div>

          <!-- Total Seats -->
          <div class="space-y-4">
            <div>
              <label class="block text-sm font-medium mb-1" for="total_seats">Total Seats</label>
              <input type="number" id="total_seats" name="total_seats" min="1" required
                value="${bus.totalSeats}"
                class="w-full px-4 py-2 rounded-lg border border-gray-600 bg-gray-700 text-white focus:ring-2 focus:ring-green-500 focus:outline-none">
            </div>
          </div>

        </div>

        <!-- Submit Button -->
        <div class="mt-8 flex justify-end">
          <button type="submit" class="flex items-center gap-2 px-6 py-2 bg-green-600 hover:bg-green-700 text-white rounded-lg font-semibold transition">
            <i class="fas fa-save"></i> Update Bus
          </button>
        </div>

      </form>

    </main>
  </div>

  <!-- JavaScript -->
  <%@ include file="../partials/script.jsp" %>

</body>
</html>