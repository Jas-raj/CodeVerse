<%@page import="com.tech.blog.entities.Message"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page - CodeVerse</title>

        <!-- CSS Dependencies -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
        <link href="CSS/style.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <style>
            body {
                margin: 0;
                padding: 0;
                background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                position: relative;
                overflow-x: hidden;
            }

            .clip-background {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                z-index: 0;
                background: rgba(255, 255, 255, 0.1);
                clip-path: polygon(0 0, 100% 0, 80% 100%, 0% 100%);
            }

            main {
                height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                position: relative;
                z-index: 1;
            }

            .card {
                border: none;
                border-radius: 20px;
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
                background: #ffffff;
            }

            .card-header {
                background: transparent;
                border-bottom: none;
            }

            .card-header h2 {
                color: #343a40;
                font-weight: bold;
            }

            .form-control {
                border-radius: 10px;
            }

            .btn-primary {
                background: #6a11cb;
                border: none;
                border-radius: 10px;
            }

            .btn-primary:hover {
                background: #2575fc;
            }

            label {
                font-weight: 500;
            }
        </style>
    </head>
    <body>

        <!-- Navbar -->
        <%@include file="Normal_navbar.jsp" %>

        <!-- Background Shape -->
        <div class="clip-background"></div>

        <!-- Login Form -->
        <main>
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-md-5">
                        <div class="card p-4">
                            <div class="card-header text-center">
                                <span class="fa fa-user-circle-o fa-3x mb-2" style="color: #6a11cb;"></span>
                                <h2>Login Here</h2>
                            </div>

                            <%

                                Message m = (Message) session.getAttribute("msg");
                                if (m != null) {
                            %>
                            <div class="alert <%= m.getCssClass()%>" role="alert">
                                <%= m.getContent()%>

                            </div>
                            <%
                                    session.removeAttribute("msg");
                                }

                            %>

                            <div class="card-body">
                                <form action="LoginServlet" method="POST">
                                    <div class="mb-3">
                                        <label for="exampleInputEmail1" class="form-label">Email address</label>
                                        <input required name="email" type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
                                        <div id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</div>
                                    </div>

                                    <div class="mb-3">
                                        <label for="exampleInputPassword1" class="form-label">Password</label>
                                        <input type="password" class="form-control" id="exampleInputPassword1" required name="password">
                                    </div>

                                    <div class="mb-3 form-check">
                                        <input type="checkbox" class="form-check-input" id="exampleCheck1">
                                        <label class="form-check-label" for="exampleCheck1">Remember Me</label>
                                    </div>

                                    <div class="d-grid">
                                        <button type="submit" class="btn btn-primary">Login</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <!-- JS Dependencies -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="https://code.jquery.com/jquery-3.7.1.min.js" crossorigin="anonymous"></script>
        <script src="js/myjs.js" type="text/javascript"></script>
    </body>
</html>
