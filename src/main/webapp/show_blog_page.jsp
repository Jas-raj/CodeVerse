

<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="com.tech.blog.dao.Userdao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.entities.Category"%>
<%@page import="com.tech.blog.entities.Category"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page errorPage="error_page.jsp" %>
<%
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("login_page.jsp");
        return;
    }
%>

<%
    int postId = Integer.parseInt(request.getParameter("post_id"));
    PostDao d = new PostDao(ConnectionProvider.getConnection());

    Post p = d.getPostByPostId(postId);
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title><%= p.getpTitle()%> || CodeVerse</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link href="WEB-INF/CSS/style.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
        <link href="https://fonts.googleapis.com/css2?family=Fira+Code&display=swap" rel="stylesheet">

        <style>
            .post-title{
                font-weight: 500;
                font-size: 30px;

            }
            .post-content{
                font-weight: 100;
                font-size: 20px;
                font-family: sans-serif;
            }
            .post-date{
                font-style:  italic;
                font-weight: 400;
            }
            .post-uer-info{
                font-size: 20px;
                font-weight: 300;
            }
            .row-user{
                border: 1px solid #e2e2e2;
                padding-top: 15px;
            }
            body {
                background: linear-gradient(to right, #3f51b5, #5c6bc0);
                color: #fff;
                min-height: 100vh;
            }

            .blog-post {
                background-color: #ffffff;
                border-radius: 6px;
                overflow: hidden;
                margin-bottom: 30px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            }

            .post-header {
                background-color: #007bff;
                color: white;
                padding: 14px 20px;
                font-size: 1.2rem;
                font-weight: 600;
            }

            .post-content {
                padding: 16px 20px;
                color: #333;
            }

            .btn-primary {
                background-color: #007bff;
                border: none;
            }
            pre {
                border: 1px solid #444;
                background-color: #111;
            }
            /* Enhanced visibility for info-outline buttons */
            .btn-glow {
                color: #00e5ff;
                background-color: rgba(0, 229, 255, 0.08);
                border: 2px solid #00e5ff;
                border-radius: 50px;
                padding: 10px 24px;
                font-weight: 500;
                box-shadow: 0 0 10px rgba(0, 229, 255, 0.3);
                transition: all 0.3s ease-in-out;
            }

            .btn-glow i {
                color: #00e5ff;
            }

            .btn-glow:hover {
                background-color: #00e5ff;
                color: #101010;
                box-shadow: 0 0 15px rgba(0, 229, 255, 0.7), 0 0 30px rgba(0, 229, 255, 0.5);
            }

            .btn-glow:hover i {
                color: #101010;
            }
            /* Liked glowing style */
            .btn-glow-liked {
                color: #101010 !important;
                background-color: #00e5ff !important;
                border: 2px solid #00e5ff !important;
                border-radius: 50px;
                padding: 10px 24px;
                font-weight: 500;
                box-shadow: 0 0 15px rgba(0, 229, 255, 0.7), 0 0 30px rgba(0, 229, 255, 0.5);
                transition: all 0.3s ease-in-out;
            }

            .btn-glow-liked i {
                color: #101010 !important;
            }

        </style>
        <!-- Prism.js Dark Theme CSS -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/prism/1.28.0/themes/prism-tomorrow.min.css" rel="stylesheet"/>
        <!-- Prism CSS -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/prism/1.29.0/themes/prism-tomorrow.min.css" rel="stylesheet" />



    </head>
    <!--    for code formatting -->
    <%!
        public String escapeHTML(String str) {
            if (str == null) {
                return null;
            }
            return str.replaceAll("&", "&amp;")
                    .replaceAll("<", "&lt;")
                    .replaceAll(">", "&gt;")
                    .replaceAll("\"", "&quot;")
                    .replaceAll("'", "&#39;");
        }
    %>



    <body>
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
        
       <!--start of main content of body -->
       <div class="container-fluid py-5">
    <div class="row justify-content-center">
        <div class="col-lg-10">

            <!-- Title -->
            <h1 class="text-white fw-bold mb-3" style="font-size: 2.5rem;"><%= p.getpTitle()%></h1>

            <!-- Blog Image -->
                    <%
                        String pic = p.getpPic();
                        if (pic == null || pic.trim().equals("")) {
                            pic = "default.jpg";
                        }
                    %>
            <img src="<%= request.getContextPath()%>/blog_pic/<%= pic%>"
                 alt="Post Image"
                 onerror="this.onerror=null; this.src='<%= request.getContextPath()%>/blog_pic/default2.jpg';"
                 class="img-fluid rounded-3 shadow mb-4"
                 style="width: 100%; max-height: 500px; object-fit: cover;" />

                    <%
                        Userdao dao = new Userdao(ConnectionProvider.getConnection());
                    %>
            <!-- Meta Info -->
            <div class="d-flex justify-content-between align-items-center text-light small mb-4 px-1" style="opacity: 0.85;">
                <span>📌 Posted by: 
                    <a href="Profile.jsp?uid=<%= p.getUserid()%>" class="text-info text-decoration-underline" >
                        <b><%= dao.getUserByUserId(p.getUserid()).getName()%></b>
    </a>
</span>
                <span><i class="bi bi-clock-history"></i> <%= p.getpDate().toString()%></span>
            </div>

            <!-- Content -->

                       <div class="p-4 text-white" style="white-space: pre-wrap;font-size: 1.1rem;"><%=p.getFormattedContent()%>
</div>




            <!-- Code Section (if any) -->
                    <% if (p.getpCode() != null && !p.getpCode().trim().equals("")) {%>
    <h4 class="text-info mt-5 mb-3 border-bottom pb-1">💻 Code:</h4>
    <pre class="language-html"><code class="language-html"><%= escapeHTML(p.getpCode())%></code></pre>
                        <% }%>

            <!-- Action Buttons -->

                    <%
                        LikeDao ld = new LikeDao(ConnectionProvider.getConnection());
                    %>
                    <%
                        boolean isLiked = ld.isPostLikedByUser(p.getPid(), user.getId());
                        String btnClass = isLiked ? "btn-glow-liked" : "btn-glow";
                    %>
        <div class="mt-5 d-flex justify-content-center gap-3">
    <!-- Like button (unchanged) -->
    <a href="#!" 
       onclick="doLike(<%= p.getPid()%>, <%= user.getId()%>, this)" 
       class="btn px-4 rounded-pill <%= btnClass%>">
        <i class="bi bi-hand-thumbs-up-fill me-1"></i> 
        <span class="like-counter"><%= ld.countLikeOnPost(p.getPid())%></span>
    </a>

    <!-- Comment count button (Disqus) -->
   <a href="#disqus_thread" 
       class="btn btn-glow px-4 rounded-pill">
        <i class="bi bi-chat-left-text-fill me-1"></i>
        <span class="disqus-comment-count" 
              data-disqus-identifier="post_<%= p.getPid()%>">0</span>
    </a>

    <!-- Back button -->
    <a href="Profile.jsp" class="btn btn-glow px-4 rounded-pill">
        <i class="bi bi-arrow-left-circle me-1"></i> Back to Profile
    </a>
</div>


        </div> <!-- col-lg-10 -->
    </div> <!-- row -->
</div> 
     
    
    <!-- Disqus Thread (put this BELOW your footer) -->
<div id="disqus_thread"></div>
<script>
            var disqus_config = function () {
                // The exact URL of the current post
        this.page.url = 'http://localhost:8080/CodeVerse/show_blog.jsp?pid=<%= p.getPid()%>';

                // A unique identifier for the post (based on pid)
        this.page.identifier = 'post_<%= p.getPid()%>';
            };

            (function () {
                var d = document, s = d.createElement('script');
                s.src = 'https://codeverse-blogs-1.disqus.com/embed.js';  // your shortname
                s.setAttribute('data-timestamp', +new Date());
                (d.head || d.body).appendChild(s);
            })();
                                    </script>
<noscript>Please enable JavaScript to view the 
  <a href="https://disqus.com/?ref_noscript">comments powered by Disqus.</a>
</noscript>

<noscript>Please enable JavaScript to view the 
  <a href="https://disqus.com/?ref_noscript">comments powered by Disqus.</a>
</noscript>

<!-- Count script (place once per page, usually in footer.jsp just before </body>) -->
<script id="dsq-count-scr" src="//codeverse-blogs-1.disqus.com/count.js" async></script>
       <!--end of main content of body -->
    
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
            <script src="js/myjs.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
 
    <!-- SweetAlert2 CDN -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
   
<script src="https://cdnjs.cloudflare.com/ajax/libs/prism/1.28.0/prism.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/prism/1.29.0/components/prism-javascript.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/prism/1.29.0/components/prism-java.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/prism/1.29.0/components/prism-python.min.js"></script>
  <!-- Prism JS -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/prism/1.29.0/prism.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/prism/1.29.0/components/prism-html.min.js"></script>

        
        <!-- Script to add like and dislike -->
        <script>
    function doLike(pid, uid, element) {
        $.ajax({
            url: "LikeServlet",
            type: "POST",
            data: {uid: uid, pid: pid},
            success: function (data) {
                let counter = $(element).find(".like-counter");
                let c = parseInt(counter.html());

                if (data.trim() === "liked") {
                    counter.html(c + 1);

                    // for card style


                    // for glow style
                    $(element).removeClass("btn-glow").addClass("btn-glow-liked");
                } else if (data.trim() === "disliked") {
                    counter.html(c - 1);

                    // for card style
                    $(element).removeClass("btn-liked").addClass("btn-outline-light");

                    // for glow style
                    $(element).removeClass("btn-glow-liked").addClass("btn-glow");
                }
            }
        });
    }

        </script>

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
