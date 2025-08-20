<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Contact Us | TechBlog</title>

    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Bootstrap Icons (optional for icons) -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    
    <style>
        body {
            background-color: #0d1117; /* Matches your theme */
            color: #ffffff;
        }

        .contact-container {
            background-color: #161b22;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 0 10px rgba(23, 162, 184, 0.3);
        }

        .form-control {
            background-color: #0d1117;
            border: 1px solid #30363d;
            color: white;
        }

        .form-control:focus {
            background-color: #0d1117;
            color: white;
            border-color: #17a2b8;
            box-shadow: 0 0 0 0.2rem rgba(23, 162, 184, 0.25);
        }

        .form-label {
            color: #c9d1d9;
        }
    </style>
</head>
<body>

<div class="container-fluid py-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="contact-container">
                <h2 class="text-center fw-bold text-info mb-4">Get in Touch</h2>

                <form action="ContactServlet" method="post">
                    <div class="mb-3">
                        <label for="name" class="form-label">Your Name</label>
                        <input type="text" id="name" name="name" class="form-control rounded-pill px-4" required>
                    </div>

                    <div class="mb-3">
                        <label for="email" class="form-label">Your Email</label>
                        <input type="email" id="email" name="email" class="form-control rounded-pill px-4" required>
                    </div>

                    <div class="mb-3">
                        <label for="subject" class="form-label">Subject</label>
                        <input type="text" id="subject" name="subject" class="form-control rounded-pill px-4" required>
                    </div>

                    <div class="mb-4">
                        <label for="message" class="form-label">Message</label>
                        <textarea id="message" name="message" rows="5" class="form-control px-4 py-3 rounded-4" required></textarea>
                    </div>

                    <div class="d-flex justify-content-center gap-3">
                        <button type="submit" class="btn btn-outline-info px-4 rounded-pill">
                            <i class="bi bi-send-fill me-1"></i> Send
                        </button>

                        <a href="Profile.jsp" class="btn btn-outline-info px-4 rounded-pill">
                            <i class="bi bi-arrow-left-circle me-1"></i> Back to Profile
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
