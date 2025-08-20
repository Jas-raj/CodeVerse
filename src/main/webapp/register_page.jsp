<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Page - CodeVerse</title>

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
                min-height: 100vh;
            }

            .clip-background {
                position: absolute;
                top: 0;
                left: 0;
                height: 100%;
                width: 100%;
                z-index: 0;
                clip-path: polygon(0 0, 100% 0, 85% 100%, 0 100%);
                background: rgba(255, 255, 255, 0.15);
            }

            main {
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 4rem 1rem;
                position: relative;
                z-index: 1;
            }

            .card {
                border: none;
                border-radius: 20px;
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
                background: #ffffff;
                width: 100%;
                max-width: 650px;
                padding: 2rem;
            }

            .card-header {
                background: transparent;
                border-bottom: none;
            }

            .card-header h2 {
                color: #343a40;
                font-weight: bold;
            }

            .form-control,
            textarea {
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

            textarea {
                width: 100%;
                min-height: 100px;
                resize: vertical;
                padding: 10px;
                border: 1px solid #ccc;
            }
        </style>


    </head>
    <body>

        <%@include file="Normal_navbar.jsp" %>

        <div class="clip-background"></div>

        <main>
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-md-6">
                        <div class="card p-4">
                            <div class="card-header text-center">
                                <span class="fa fa-users fa-3x mb-2" style="color: #6a11cb;"></span>
                                <h2>Register here</h2>
                            </div>
                            <div class="card-body">
                                <form action="RegisterServlet" method="POST" id="reg_form">


                                    <div class="mb-3">
                                        <label for="user_email" class="form-label">Email address</label>
                                        <input type="email" name="user_email" class="form-control" id="user_email" placeholder="email">
                                        <div id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</div>
                                    </div>

                                    <div class="mb-3">
                                        <label for="username" class="form-label">Enter your name</label>
                                        <input type="text" name="user_name" class="form-control" id="user_name" placeholder="Full Name">
                                    </div>

                                    <div class="mb-3">
                                        <label for="user_password" class="form-label">Password(Password must contain one uppercase, one lowercase, one digit and one special character. It must be minimum 8 characters)</label>
                                        <input type="password" name="user_password" class="form-control" id="user_password" placeholder="Enter password">
                                    </div>

                                    <div class="mb-3">
                                        <label>Select Gender</label><br>
                                        <input type="radio" name="gender" value="male"> Male
                                        <input type="radio" name="gender" value="female"> Female
                                    </div>

                                    <div class="mb-3">
                                        <label>About You</label>
                                        <textarea name="about" id="about" placeholder="Tell us about your experience"></textarea>
                                    </div>

                                    <div class="mb-3 form-check">
                                        <input name="check" type="checkbox" class="form-check-input" id="exampleCheck1" value="checked">
                                        <label class="form-check-label" for="exampleCheck1">Agree to terms and conditions</label>
                                    </div>

                                    <div class="text-center" id="loader" style="display: none;">
                                        <span class="fa fa-refresh fa-spin fa-2x text-primary"></span>
                                        <h5>Please Wait...</h5>
                                    </div>

                                    <div class="d-grid">
                                        <button id="submit-btn" type="submit" class="btn btn-primary">Sign-up</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <!-- JS & Plugins -->
        <script src="https://code.jquery.com/jquery-3.7.1.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="js/myjs.js" type="text/javascript"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

        <!-- Form Validation & Ajax -->
        <script>
            $(document).ready(function () {
                $('#reg_form').on('submit', function (event) {
                    event.preventDefault();

                    let isValid = true;
                    let errorMessage = "";

                    let password = $('#user_password').val();
                    const passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$/;

                    $('#reg_form input[type="text"], #reg_form input[type="email"], #reg_form input[type="password"]').each(function () {
                        if ($(this).val().trim() === "") {
                            isValid = false;
                            errorMessage = "All fields must be filled!";
                            return false;
                        }
                    });

                    if (!$('#exampleCheck1').is(':checked')) {
                        isValid = false;
                        errorMessage = "You must agree to the terms and conditions!";
                    }

                    if (!passwordPattern.test(password)) {
                        isValid = false;
                        errorMessage = "Password must be at least 8 characters long, include uppercase, lowercase, number, and special character.";
                    }

                    if (!isValid) {
                        Swal.fire({
                            icon: "warning",
                            title: "Validation Error",
                            text: errorMessage,
                        });
                        return;
                    }

                    let form = new FormData(this);
                    $("#submit-btn").hide();
                    $("#loader").show();

                    $.ajax({
                        url: "RegisterServlet",
                        type: 'POST',
                        data: form,
                        processData: false,
                        contentType: false,
                        success: function (data) {
                            $("#submit-btn").show();
                            $("#loader").hide();

                            data = data.trim();

                            if (data === "Box not checked") {
                                Swal.fire({
                                    icon: "error",
                                    title: "Oops...",
                                    text: "You must agree to the terms and conditions!",
                                });
                            } else if (data === "Email already exists") {
                                Swal.fire({
                                    icon: "error",
                                    title: "Duplicate Email",
                                    text: "The email address you entered is already registered.",
                                });
                            } else if (data === "Data saved Succesfully") {
                                Swal.fire({
                                    title: "Registration Successful!",
                                    text: "Redirecting to login...",
                                    icon: "success"
                                }).then(() => {
                                    window.location = "login_page.jsp";
                                });
                            } else {
                                Swal.fire({
                                    icon: "error",
                                    title: "Oops...",
                                    text: "An error occurred! Please try again.",
                                });
                            }
                        },
                        error: function () {
                            $("#submit-btn").show();
                            $("#loader").hide();
                            Swal.fire({
                                icon: "error",
                                title: "Oops...",
                                text: "Something went wrong! Please try again.",
                            });
                        }
                    });
                });
            });
        </script>


    </body>
</html>
