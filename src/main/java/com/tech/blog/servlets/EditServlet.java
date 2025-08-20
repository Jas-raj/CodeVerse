package com.tech.blog.servlets;

import com.tech.blog.dao.Userdao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Helper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

@MultipartConfig
public class EditServlet extends HttpServlet {

    private boolean isStrongPassword(String password) {
        // Password must be at least 8 characters, 1 uppercase, 1 lowercase, and 1 digit/special char
        return password != null && password.matches("^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9@#$%^&+=!]).{8,}$");
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();

        try (PrintWriter out = response.getWriter()) {
            // Get form inputs
            String userEmail = request.getParameter("user_email");
            String username = request.getParameter("user_name");
            String userPassword = request.getParameter("user_password");
            String userAbout = request.getParameter("user_about");
            Part part = request.getPart("image");
            String imageName = part != null ? part.getSubmittedFileName() : null;

            // Fetch current user
            User currentUser = (User) session.getAttribute("currentUser");

            if (currentUser == null) {
                response.sendRedirect("login_page.jsp");
                return;  
            }

            // Check if email is already used by another user
            Userdao userDao = new Userdao(ConnectionProvider.getConnection());
            User userByEmail = userDao.getUserByEmail(userEmail);

            if (userByEmail != null && userByEmail.getId() != currentUser.getId()) {
                session.setAttribute("msg", new Message("Email already in use, please try another.", "danger", "alert-danger"));
                response.sendRedirect("Profile.jsp");
                return;
            }

            // Validate password
            if (!isStrongPassword(userPassword)) {
                session.setAttribute("msg", new Message(
                        "Password must be at least 8 characters long, include uppercase, lowercase, and a number or special character.",
                        "danger",
                        "alert-danger"));
                response.sendRedirect("Profile.jsp");
                return;
            }

            // Prepare for update
            String oldImage = currentUser.getProfile();

            currentUser.setEmail(userEmail);
            currentUser.setName(username);
            currentUser.setPassword(userPassword);
            currentUser.setAbout(userAbout);

            if (imageName != null && !imageName.isEmpty()) {
                currentUser.setProfile(imageName);
            }

            boolean updated = userDao.updateUser(currentUser);

            if (updated) {
                // Save new image if provided
                if (imageName != null && !imageName.isEmpty()) {
                    String uploadPath = getServletContext().getRealPath("/") + "Pics" + File.separator + imageName;
                    String oldImagePath = getServletContext().getRealPath("/") + "Pics" + File.separator + oldImage;

                    Helper.deleteFile(oldImagePath);

                    if (Helper.saveFile(part.getInputStream(), uploadPath)) {
                        session.setAttribute("msg", new Message("Profile updated successfully.", "success", "alert-success"));
                    } else {
                        session.setAttribute("msg", new Message("Profile updated but image upload failed.", "warning", "alert-warning"));
                    }
                } else {
                    session.setAttribute("msg", new Message("Profile updated successfully.", "success", "alert-success"));
                }
            } else {
                session.setAttribute("msg", new Message("Failed to update profile. Try again!", "danger", "alert-danger"));
            }

            response.sendRedirect("Profile.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("msg", new Message("An error occurred while updating Profile.", "danger", "alert-danger"));
            response.sendRedirect("Profile.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
