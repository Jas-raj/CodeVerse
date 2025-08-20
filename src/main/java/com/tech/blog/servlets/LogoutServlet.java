package com.tech.blog.servlets;

import com.tech.blog.entities.Message;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class LogoutServlet extends HttpServlet {

    // Handles both GET and POST using this method
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        session.removeAttribute("currentUser");  // Typo fixed: currentUSer -> currentUser
        Message m = new Message("Logout Successfully", "success", "alert-success");
        session.setAttribute("msg", m);
        response.sendRedirect("login_page.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);  // Now handles GET properly
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);  // Optional for POST handling
    }

}
