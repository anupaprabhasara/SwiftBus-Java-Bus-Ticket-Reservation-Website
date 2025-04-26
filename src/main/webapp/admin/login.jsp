<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SwiftBus | Admin Login</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/swiftbus/assets/favicon.png" type="image/x-icon">

    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>

    <!-- Font Awesome CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
</head>

<body class="bg-gray-900 flex items-center justify-center min-h-screen px-4">
    <div class="w-full max-w-md p-8 space-y-6 bg-gray-800 shadow-2xl rounded-3xl">

        <!-- Title -->
        <h2 class="text-4xl font-bold text-center text-white">SwiftBus Admin Login</h2>
        <p class="text-center text-gray-400 text-sm mb-6">Please enter your username or email to access the system.</p>

        <!-- Error Message -->
        <%
            String error = (String) request.getAttribute("error");
            if (error != null) {
        %>
            <div class="w-full bg-red-600/20 border border-red-600 text-red-400 px-4 py-3 rounded-lg text-center text-sm" role="alert">
                <i class="fas fa-exclamation-circle mr-2"></i>
                <%= error %>
            </div>
        <%
            }
        %>

        <!-- Login Form -->
        <form class="space-y-5" action="${pageContext.request.contextPath}/admin/login" method="POST">
            
            <!-- Username or Email -->
            <div class="relative">
                <label for="username" class="block mb-1 text-gray-300 font-medium">Username or Email</label>
                <div class="flex items-center relative">
                    <input id="username" name="username" type="text" required
                        class="w-full pl-10 pr-4 py-2 rounded-lg bg-gray-700 border border-gray-600 text-white focus:ring-2 focus:ring-green-500 focus:outline-none"
                        placeholder="Enter your username or email">
                    <i class="fas fa-user absolute left-3 text-gray-400"></i>
                </div>
            </div>

            <!-- Password -->
            <div class="relative">
                <label for="password" class="block mb-1 text-gray-300 font-medium">Password</label>
                <div class="flex items-center relative">
                    <input id="password" name="password" type="password" required
                        class="w-full pl-10 pr-10 py-2 rounded-lg bg-gray-700 border border-gray-600 text-white focus:ring-2 focus:ring-green-500 focus:outline-none"
                        placeholder="Enter your password">
                    <i class="fas fa-lock absolute left-3 text-gray-400"></i>
                    <button type="button" onclick="togglePassword()" class="absolute right-3 text-gray-400 focus:outline-none">
                        <i id="eyeIcon" class="fas fa-eye"></i>
                    </button>
                </div>
            </div>

            <!-- Submit Button -->
            <div>
                <button type="submit"
                    class="w-full px-4 py-2 text-white bg-green-600 hover:bg-green-700 font-semibold rounded-lg shadow-md transition duration-200">
                    Sign In
                </button>
            </div>
        </form>

        <!-- Footer Note -->
        <p class="text-center text-gray-500 text-xs mt-6">SwiftBus - Secure Reservation Management System</p>

    </div>

    <!-- Password Toggle Script -->
    <script>
        function togglePassword() {
            const passwordInput = document.getElementById("password");
            const eyeIcon = document.getElementById("eyeIcon");

            if (passwordInput.type === "password") {
                passwordInput.type = "text";
                eyeIcon.classList.remove("fa-eye");
                eyeIcon.classList.add("fa-eye-slash");
            } else {
                passwordInput.type = "password";
                eyeIcon.classList.remove("fa-eye-slash");
                eyeIcon.classList.add("fa-eye");
            }
        }
    </script>

</body>
</html>