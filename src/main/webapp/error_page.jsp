<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page isErrorPage="true" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sorry! Something went wrong...</title>

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="CSS/style.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <style>
            body {
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                background-color: #f8f9fa;
                margin: 0;
            }
            .error-container {
                text-align: center;
                padding: 40px;
                background: #ffffff;
                box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.1);
                border-radius: 12px;
                max-width: 500px;
                width: 90%;
            }
            .error-container img {
                width: 150px;
                margin-bottom: 20px;
            }
            .error-container h3 {
                color: #dc3545;
                margin-bottom: 15px;
            }
            .home-btn {
                background-color: #007bff;
                color: white;
                padding: 10px 25px;
                text-decoration: none;
                border-radius: 6px;
                display: inline-block;
                margin-top: 20px;
            }
            .home-btn:hover {
                background-color: #0056b3;
            }
            .error-msg {
                color: #6c757d;
            }
        </style>
    </head>
    <body>

        <div class="error-container">
            <img src="img/error.png" alt="Error Image" class="img-fluid">
            <h3 class="display-6">Sorry! Something went wrong...</h3>
            <p class="error-msg"><%= exception%></p>
            <a href="Profile.jsp" class="home-btn">Back to Home</a>
        </div>

    </body>
</html>
