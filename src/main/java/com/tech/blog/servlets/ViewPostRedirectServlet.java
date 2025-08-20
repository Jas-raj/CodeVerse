/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.tech.blog.servlets;

import com.tech.blog.entities.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author Harleen
 */
public class ViewPostRedirectServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String postId = request.getParameter("id");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("currentUser");

        if (user != null) {
            // Logged in → show the full post
            response.sendRedirect("show_blog_page.jsp?post_id=" + postId);
        } else {
            // Not logged in → Save destination and redirect to login/register
            session.setAttribute("redirectAfterLogin", "show_blog_page.jsp?post_id=" + postId);
            response.sendRedirect("login_page.jsp");  // or "register_page.jsp" if you prefer
        }
    }
}


