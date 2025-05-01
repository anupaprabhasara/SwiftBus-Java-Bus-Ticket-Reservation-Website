<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en" class="dark">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>SwiftBus | Create Admin</title>
  <link rel="shortcut icon" href="https://ui-avatars.com/api/?name=${sessionScope.username}&background=22c55e&color=fff&rounded=true" type="image/x-icon">

  <!-- Tailwind CSS -->
  <script src="https://cdn.tailwindcss.com"></script>
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
</head>

<body class="bg-gray-900 text-gray-100 min-h-screen flex">

  <!-- Sidebar (fixed) -->
  <%@ include file="../partials/sidebar.jsp" %>

  <!-- Main Content with Sidebar Margin -->
  <div class="flex-1 flex flex-col md:ml-60">

    <!-- Topbar -->
    <%@ include file="../partials/header.jsp" %>

    <!-- Main Area -->
    <main class="flex-1 p-6 space-y-6">

      <!-- Admin Create Form -->
      <form action="${pageContext.request.contextPath}/admin/admin" method="POST" class="bg-gray-800 shadow-lg rounded-lg p-8 w-full">
        <input type="hidden" name="action" value="create">

        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
          
          <!-- Left Side -->
          <div class="space-y-4">
            <div>
              <label class="block text-sm font-medium mb-1" for="username">Username</label>
              <input type="text" id="username" name="username" required
                class="w-full px-4 py-2 rounded-lg border border-gray-600 bg-gray-700 text-white focus:ring-2 focus:ring-green-500 focus:outline-none">
            </div>

            <div>
              <label class="block text-sm font-medium mb-1" for="email">Email</label>
              <input type="email" id="email" name="email" required
                class="w-full px-4 py-2 rounded-lg border border-gray-600 bg-gray-700 text-white focus:ring-2 focus:ring-green-500 focus:outline-none">
            </div>
          </div>

          <!-- Right Side -->
          <div class="space-y-4">
            <div>
              <label class="block text-sm font-medium mb-1" for="password">Password</label>
              <input type="password" id="password" name="password" required
                class="w-full px-4 py-2 mb-2 rounded-lg border border-gray-600 bg-gray-700 text-white focus:ring-2 focus:ring-green-500 focus:outline-none"
                oninput="validatePassword()">
              
              <!-- Password Validation Info -->
              <div class="text-sm space-y-1" id="passwordCriteria">
                <p id="length" class="text-red-500">At least 8 characters</p>
                <p id="uppercase" class="text-red-500">At least 1 uppercase letter</p>
                <p id="number" class="text-red-500">At least 1 number</p>
                <p id="special" class="text-red-500">At least 1 special character</p>
              </div>
            </div>
          </div>

        </div>

        <!-- Submit Button -->
        <div class="mt-8 flex justify-end">
          <button id="submitButton" type="submit" class="flex items-center gap-2 px-6 py-2 bg-green-600 hover:bg-green-700 text-white rounded-lg font-semibold transition" disabled>
            <i class="fas fa-save"></i> Save Admin
          </button>
        </div>
      </form>

    </main>
  </div>

  <!-- JavaScript -->
  <%@ include file="../partials/script.jsp" %>

  <script>
    function validatePassword() {
      const password = document.getElementById('password').value;
      const length = document.getElementById('length');
      const uppercase = document.getElementById('uppercase');
      const number = document.getElementById('number');
      const special = document.getElementById('special');
      const submitButton = document.getElementById('submitButton');

      const isLengthValid = password.length >= 8;
      const isUppercaseValid = /[A-Z]/.test(password);
      const isNumberValid = /[0-9]/.test(password);
      const isSpecialValid = /[!@#$%^&*]/.test(password);

      length.className = isLengthValid ? "text-green-400" : "text-red-500";
      uppercase.className = isUppercaseValid ? "text-green-400" : "text-red-500";
      number.className = isNumberValid ? "text-green-400" : "text-red-500";
      special.className = isSpecialValid ? "text-green-400" : "text-red-500";

      submitButton.disabled = !(isLengthValid && isUppercaseValid && isNumberValid && isSpecialValid);
    }
  </script>

</body>
</html>