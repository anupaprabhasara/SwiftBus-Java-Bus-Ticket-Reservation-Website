<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%
    String uri = request.getRequestURI();
    String pageTitle = "Dashboard Overview";

    if (uri.contains("/admin/admin")) {
        pageTitle = "Admins Management";
    } else if (uri.contains("/admin/user")) {
        pageTitle = "Users Management";
    } else if (uri.contains("/admin/buses")) {
        pageTitle = "Buses Management";
    } else if (uri.contains("/admin/routes")) {
        pageTitle = "Routes Management";
    } else if (uri.contains("/admin/schedules")) {
        pageTitle = "Schedules Management";
    } else if (uri.contains("/admin/bookings")) {
        pageTitle = "Bookings Management";
    }

    request.setAttribute("pageTitle", pageTitle);
%>

<header class="flex justify-between items-center p-4 bg-gray-800 shadow-sm">
	<h2 class="text-xl font-bold text-white">${pageTitle}</h2>
	<div class="flex items-center space-x-4">
		<div class="text-right text-sm">
			<p class="text-white">${sessionScope.username}</p>
			<p class="text-gray-400 text-xs">${sessionScope.email}</p>
		</div>
		<img
			src="https://ui-avatars.com/api/?name=${sessionScope.username}&background=22c55e&color=fff"
			alt="Profile" class="w-10 h-10 rounded-full shadow-md">
	</div>
</header>