package com.tech.blog.servlets;

import com.tech.blog.dao.Userdao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class LoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LoginServlet</title>");
            out.println("</head>");
            out.println("<body>");

            //Fetch username and password from fetch
            String userEmail = request.getParameter("email");
            String userPassword = request.getParameter("password");

            Userdao dao = new Userdao(ConnectionProvider.getConnection());

            User u = dao.getuserByEmailAndPassword(userEmail.trim(), userPassword.trim());

            if (u == null) {
                //login Error message

                Message msg = new Message("Invalid Credentials. Try Again!", "error", "alert-danger");

                HttpSession s = request.getSession();    // Set the session first
                s.setAttribute("msg", msg);              // Store the message
                response.sendRedirect("login_page.jsp"); // Then redirect
            } else {
                // Successful login
                HttpSession s = request.getSession();
                s.setAttribute("currentUser", u);

                // 🔁 Redirection after login (if came from Read More)
                String redirectUrl = (String) s.getAttribute("redirectAfterLogin");
                if (redirectUrl != null) {
                    s.removeAttribute("redirectAfterLogin");
                    response.sendRedirect(redirectUrl);
                } else {
                    response.sendRedirect("Profile.jsp");
                }
            }

            out.println("</body>");
            out.println("</html>");
        }
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
