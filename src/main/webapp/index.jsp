<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Home | CodeVerse</title>
        <meta charset="UTF-8">

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link href="CSS/style.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <style>
            :root {
                --primary-gradient: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
                --light-bg: #eef2f7;
                --card-bg: #ffffff;
            }

            body {
                background-color: var(--light-bg);
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            .banner-background {
                background: var(--primary-gradient);
                color: white;
                clip-path: polygon(50% 0%, 81% 0, 100% 0, 100% 100%, 84% 90%, 47% 100%, 9% 91%, 0 100%, 0% 35%, 0 0);
            }

            .card {
                transition: transform 0.2s ease-in-out;
            }

            .card:hover {
                transform: translateY(-5px);
            }
            .card-title {
                background-image: linear-gradient(to right, #414ae7 0%, #414ae7 100%);
                color: white;
                padding: 10px;
                border-radius: 5px 5px 0 0;
            }
            post-header {
                background-color: #007bff;
                width: 100%;
                color: white;
                font-size: 1.1rem;
                font-weight: 500;
                margin: 0;
                border-top-left-radius: 5px;
                border-top-right-radius: 5px;
            }

            .card {
                border-radius: 5px;
                overflow: hidden; /* ⬅ ensures title and body edges are clean */
            }
        </style>
    </head>
    <body>

        <%@include file="Normal_navbar.jsp" %>

        <div class="container-fluid d-flex justify-content-center align-items-center min-vh-50 banner-background py-5">
            <div class="text-center">
                <h1 class="display-4 fw-bold">Welcome To CodeVerse</h1>
                <p class="lead">Explore the latest trends in tech and programming. Stay informed and inspired daily!</p>
                <p class="lead">Learn the foundations of programming languages, explore concepts from syntax to semantics, and discover how languages evolve with computing architectures.</p>
                <div class="mt-4">
                    <a href="register_page.jsp" class="btn btn-outline-light rounded-pill px-4 py-2 me-2 shadow">
                        <span class="fa fa-rocket fa-spin"></span> Start It's Free!
                    </a>
                    <a href="login_page.jsp" class="btn btn-outline-light rounded-pill px-4 py-2 shadow">
                        <span class="fa fa-sign-in fa-spin"></span> Login
                    </a>
                </div>
            </div>
        </div>

        <div class="container py-5">
            <div class="row g-4">
                <%
                    Connection con = ConnectionProvider.getConnection();
                    PostDao dao = new PostDao(con);
                    List<Post> posts = dao.getAllPostsForCardView();

                    if (posts != null && !posts.isEmpty()) {
                        for (Post post : posts) {
                %>
                <div class="col-md-4">
                    <div class="card h-100 shadow-sm">
                        <div class="post-header text-white fw-semibold px-3 py-2"  style="background-image: linear-gradient(to right, #414ae7 0%, #414ae7 100%);">
                            <h5 class="card-title"><%= post.getpTitle()%></h5>
                        </div>
                        <div class="card-body bg-white rounded">


                            <p class="card-text">
                                <%
                                    String content = post.getpContent();
                                    content = (content == null) ? "" : content;
                                    out.print(content.length() > 100 ? content.substring(0, 100) + "..." : content);
                                %>
                            </p>
                            <a href="ViewPostRedirectServlet?id=<%= post.getPid()%>" class="btn btn-primary">Read More...</a>
                        </div>
                    </div>
                </div>
                <%
                    }
                } else {
                %>
                <div class="col-12">
                    <p class="text-danger fw-bold">No posts found.</p>
                </div>
                <%
                    }
                %>
            </div>
        </div></body>
</html>
