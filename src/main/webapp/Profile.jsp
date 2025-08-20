<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.entities.Category"%>
<%--<%@page import="java.util.ArrayList"%>--%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.entities.Message"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page errorPage="error_page.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("login_page.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Welcome to Profile</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link href="WEB-INF/CSS/style.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    </head>
    <body style="background:  linear-gradient(to right, #3f51b5, #5c6bc0)">

        <!-- Navbar Start -->
        <nav class="navbar navbar-expand-lg shadow-sm sticky-top px-3" style="background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);">
            <a class="navbar-brand fw-bold d-flex align-items-center gap-2 text-white" style="font-size: 1.3rem;">
                <img src="https://cdn-icons-png.flaticon.com/512/3039/3039396.png" width="36" height="36" alt="Logo" style="border-radius: 8px;">
                <span>CodeVerse</span>
            </a>
            <button class="navbar-toggler bg-white" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link text-white" href="Profile.jsp"><i class="fa fa-home me-1"></i> Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="ContactUS.jsp"><i class="fa fa-phone"></i> Contact US!</a>
                    </li>

<!--                    <li class="nav-item">
                        <a class="nav-link text-white" href="Profile.jsp"><i class="fa fa-bell-o me-1"></i> Updates</a>
                    </li>-->
                    <li class="nav-item">
                        <a class="nav-link text-white" href="#" data-bs-toggle="modal" data-bs-target="#add-post-modal"><i class="fa fa-file-text"></i> Do Post</a>
                    </li>
                </ul>

                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link text-white" data-bs-toggle="modal" data-bs-target="#profile-modal" style="cursor: pointer;">
                            <i class="fa fa-user-circle"></i> <%= user.getName()%>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="LogoutServlet"><i class="fa fa-sign-out"></i> Logout</a>
                    </li>
                </ul>
            </div>
        </nav>
        <!-- navar End -->


        <!-- Message Alert -->
        <%
            Message msg = (Message) session.getAttribute("msg");
            if (msg != null) {
        %>
        <div id="alertMsg" class="alert <%= msg.getCssClass()%> alert-dismissible fade show" role="alert">
            <strong><%= msg.getType().toUpperCase()%>:</strong> <%= msg.getContent()%>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <%
                session.removeAttribute("msg");
            }
        %>

        <!--Start of main body of the page -->
        <main>
            <div class="container">
                <div class="row mt-4">
                    <!--first column-->

                    <div class="col-md-4">
                        <!--shows list of all categories-->
                        <div class="list-group">
                            <a href="#" onclick="getPost(0, this)" class="c-link list-group-item list-group-item-action">
                                All Posts
                            </a>

                            <%            PostDao d = new PostDao(ConnectionProvider.getConnection());
                                ArrayList<Category> list1 = d.getAllCategories();
                                for (Category cc : list1) {
                            %>
                            <a href="#" onclick="getPost(<%= cc.getCid()%>, this)" class="c-link list-group-item list-group-item-action">
                                <%= cc.getName()%>
                            </a>
                            <% }%>
                        </div>
                    </div>

                    <!--Second column-->
                    <div class="col-md-8">

                        <!--show all the posts (dynamically)-->
                        <div class="cotainer text-center" id="loader">
                            <i class="fa fa-refresh fa-5x fa-spin"></i>
                            <h3 class="mt-2">loading....</h3>

                        </div>

                        <div class="container-fluid" id="post-container"></div>
                    </div>

                </div>
            </div>
        </main>
        <!-- End of main body of the page-->


        <!-- Profile Modal Start -->
        <div class="modal fade" id="profile-modal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header bg-primary text-white">
                        <h5 class="modal-title">CodeVerse</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body text-center">
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

                        <div id="profile-edit" style="display: none;">
                            <h3 class="mt-2">Edit Your Details</h3>
                            <form action="EditServlet" method="POST" enctype="multipart/form-data">
                                <table class="table">
                                    <tr><th>User-ID</th><td><%= user.getId()%></td></tr>
                                    <tr><th>Email</th><td><input type="email" class="form-control" name="user_email" value="<%= user.getEmail()%>"></td></tr>
                                    <tr><th>Name</th><td><input type="text" class="form-control" name="user_name" value="<%= user.getName()%>"></td></tr>
                                    <tr><th>Password</th><td><input type="password" class="form-control" name="user_password" value="<%= user.getPassword()%>"></td></tr>
                                    <tr><th>Gender</th><td><%= user.getGender()%></td></tr>
                                    <tr><th>New Profile Picture</th><td><input type="file" name="image" class="form-control"></td></tr>
                                    <tr><th>About</th><td><textarea class="form-control" name="user_about" rows="3"><%= user.getAbout()%></textarea></td></tr>
                            </table>
                            <div class="text-center">
                                <button type="submit" class="btn btn-primary">Save Changes</button>
                            </div>
                        </form>
                    </div>

                </div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button id="edit-profile-button" class="btn btn-primary">Edit</button>
                </div>
            </div>
        </div>
    </div>                      
        <!-- Profile Modal End -->

        <!-- Add Post Modal -->
        <div class="modal fade" id="add-post-modal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title w-100 text-center">Post Your Blog</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <div class="modal-body">
                <form action="AddPostServlet" method="post" enctype="multipart/form-data" id="add-post-form">

                    <div class="container-fluid">
                        <div class="row justify-content-center">
                            <div class="col-12">

                                <!-- Select Category -->
                                <div class="form-group mb-3">
                                    <select class="form-control" name="cid" required>
                                        <option value="" selected disabled>---- Select Category ----</option>
                                                <%
                                                    PostDao postd = new PostDao(ConnectionProvider.getConnection());
                                                    ArrayList<Category> list = postd.getAllCategories();
                                                    for (Category c : list) {
                                                %>
                                            <option value="<%=c.getCid()%>"><%=c.getName()%></option>
                                                <%
                                                    }
                                                %>
                                    </select>
                                </div>

                                <!-- Blog Title -->
                                <div class="form-group mb-3">
                                    <input type="text" name="pTitle" placeholder="Enter Blog Title" class="form-control" required>
                                </div>

                                <!-- Blog Content -->
                                <div class="form-group mb-3">
                                    <textarea name="pContent" placeholder="Enter Blog Content" class="form-control" style="height: 200px;" required></textarea>
                                </div>

                                <!-- Blog Code -->
                                <div class="form-group mb-3">
                                    <textarea name="pCode" placeholder="Enter Code (optional)" class="form-control" style="height: 200px;"></textarea>
                                </div>

                                <!-- Upload Picture -->
                                <div class="form-group mb-3">
                                    <label for="pic">Upload Picture</label>
                                    <input type="file" name="pic" class="form-control">
                                </div>

                                <!-- Submit Button -->
                                <div class="form-group text-center mt-4">
                                    <button type="submit" class="btn btn-primary px-5">Post</button>
                                </div>

                            </div>
                        </div>
                    </div>
                </form>
            </div>

        </div>
    </div>
</div>
        <!-- Add Post Modal End -->

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <!-- SweetAlert2 CDN -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="js/myjs.js"></script>
    

         <script>
                               $(document).ready(function () {
                                   let editStatus = false;
                                   $('#edit-profile-button').click(function () {
                                       if (!editStatus) {
                                           $("#profile-details").hide();
                                           $("#profile-edit").show();
                                           $(this).text("Back");
                                       } else {
                                           $("#profile-details").show();
                                           $("#profile-edit").hide();
                                           $(this).text("Edit");
                                       }
                                       editStatus = !editStatus;
                                   });
                                   // Alert auto dismiss
                                   setTimeout(function () {
                                       var alertMsg = document.getElementById('alertMsg');
                                       if (alertMsg) {
                                           alertMsg.classList.remove('show');
                                           alertMsg.classList.add('fade');
                                           setTimeout(() => alertMsg.remove(), 500);
                                       }
                                   }, 5000);
                               });
                     </script>

            <!--Add Post form submission via AJAX-->
            <script>
            $(document).ready(function () {

                $("#add-post-form").on("submit", function (event) {
                    // This code is called when form is submitted
                    event.preventDefault();
                    console.log("submitted");
                    let form = new FormData(this);
                    // Now requesting and sending form details to server
                    $.ajax({
                        url: "AddPostServlet",
                        type: 'POST',
                        data: form,
                        processData: false,
                        contentType: false,
                        success: function (data, textStatus, jqXHR) {
                            console.log(data);
                            if (data.trim() === 'done') {
                                Swal.fire({
                                    title: "Done!",
                                    text: "Data Posted Successfully!",
                                    icon: "success"
                                });
                            } else {
                                Swal.fire({
                                    title: "Error",
                                    text: "We couldn't process your request. Try again later!",
                                    icon: "error"
                                });
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            Swal.fire({
                                title: "Error",
                                text: "Something went wrong. Please try again later!",
                                icon: "error"
                            });
                        }
                    });
                });
            });
</script>
            <!-- end of Add Post form submission script -->


            <!--Loading post using AJAX-->
            <script>
            function getPost(catId, temp) {
                $("#loader").show();
                $("#post-container").hide();

                // Remove 'active' from all links
                $(".c-link").removeClass("active");

                // Set 'active' on the clicked link
                if (temp) {
                    $(temp).addClass("active");
                }

                $.ajax({
                    url: "load_post.jsp",
                    data: {cid: catId},
                    success: function (data, textStatus, jqXHR) {
                        $("#loader").hide();
                        $("#post-container").show().html(data);
                    },
                    error: function (xhr, status, error) {
                        $("#loader").hide();
                        $("#post-container").show().html("<p>Error loading posts.</p>");
                        console.error("AJAX Error:", error);
                    }
                });
            }

            // Load all posts by default on page load and set 'active' class
            $(document).ready(function () {
                let firstLink = $(".list-group .c-link").first();
                getPost(0, firstLink.get(0)); // pass DOM element of 'All Posts'
            });
                                            </script>
            <!--end of loading Post using AJAX-->



</body>
</html>
