<%@page import="com.tech.blog.dao.Userdao"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page import="com.tech.blog.entities.User"%>
<%@ page session="true" %>

<%
    String uidStr = request.getParameter("uid");
    User sessionUser = (User) session.getAttribute("currentUser");
    int uid = Integer.parseInt(uidStr);

    Userdao dao = new Userdao(ConnectionProvider.getConnection());
    User user = dao.getUserByUserId(uid);

    boolean isOwnProfile = (sessionUser != null && sessionUser.getId() == user.getId());
%>

<img src="Pics/<%= user.getProfile()%>" class="img-fluid rounded-circle" style="width: 170px; height: 160px; border: 2px solid blue;">
<h5 class="mt-3"><%= user.getName()%></h5>

<div id="profile-details">
    <table class="table table-striped">
        <tr><th>User-ID</th><td><%= user.getId()%></td></tr>
        <tr><th>Email</th><td><%= user.getEmail()%></td></tr>
        <tr><th>Gender</th><td><%= user.getGender()%></td></tr>
        <tr><th>Status</th><td><%= user.getAbout()%></td></tr>
        <tr><th>Registered</th><td><%= user.getDateTime()%></td></tr>
    </table>
</div>

<% if (isOwnProfile) { %>
<div id="profile-edit">
    <!-- Your edit form here (same as original modal) -->
</div>
<% }%>
