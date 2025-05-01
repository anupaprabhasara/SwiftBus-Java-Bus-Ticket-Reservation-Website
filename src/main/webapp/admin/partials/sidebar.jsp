<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<aside
	class="w-60 hidden md:flex flex-col bg-gray-800 border-r border-gray-700 shadow-md min-h-screen">
	<!-- Logo -->
	<div class="p-6 text-center border-b border-gray-700">
		<h1 class="text-2xl font-bold text-green-400">SwiftBus</h1>
	</div>

	<!-- Navigation Links -->
	<nav class="flex-1 px-4 py-6 space-y-2">
		<a href="${pageContext.request.contextPath}/admin/dashboard"
			class="flex items-center p-3 rounded hover:bg-green-600/20 transition text-gray-300 hover:text-white">
			<i class="fas fa-home mr-3"></i> Dashboard
		</a>

		<a href="${pageContext.request.contextPath}/admin/bus"
			class="flex items-center p-3 rounded hover:bg-green-600/20 transition text-gray-300 hover:text-white">
			<i class="fas fa-bus mr-3"></i> Buses
		</a>

		<a href="${pageContext.request.contextPath}/admin/route"
			class="flex items-center p-3 rounded hover:bg-green-600/20 transition text-gray-300 hover:text-white">
			<i class="fas fa-road mr-3"></i> Routes
		</a>

		<a href="${pageContext.request.contextPath}/admin/schedule"
			class="flex items-center p-3 rounded hover:bg-green-600/20 transition text-gray-300 hover:text-white">
			<i class="fas fa-clock mr-3"></i> Schedules
		</a>

		<a href="${pageContext.request.contextPath}/admin/booking"
			class="flex items-center p-3 rounded hover:bg-green-600/20 transition text-gray-300 hover:text-white">
			<i class="fas fa-ticket-alt mr-3"></i> Bookings
		</a>

		<a href="${pageContext.request.contextPath}/admin/admin"
			class="flex items-center p-3 rounded hover:bg-green-600/20 transition text-gray-300 hover:text-white">
			<i class="fas fa-users-cog mr-3"></i> Admins
		</a>
		
		<a href="${pageContext.request.contextPath}/admin/user"
			class="flex items-center p-3 rounded hover:bg-green-600/20 transition text-gray-300 hover:text-white">
			<i class="fas fa-user mr-3"></i> Users
		</a>
	</nav>

	<!-- Logout Button -->
	<div class="p-4 border-t border-gray-700">
		<button onclick="logout()"
			class="w-full flex items-center justify-center text-red-400 hover:text-red-500 font-semibold transition">
			<i class="fas fa-sign-out-alt mr-2"></i> Logout
		</button>
	</div>
</aside>