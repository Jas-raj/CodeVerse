<%@page import="com.tech.blog.entities.User"%>
<%@page import="com.tech.blog.dao.LikeDao"%>
<!--its content goes to profile's post's container-->


<%@page import="java.util.List"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

<%
    User user = (User) session.getAttribute("currentUser");

%>
<style>
    .card {
        min-height: 450px;
        display: flex;
        flex-direction: column;
    }

    .card-body {
        flex-grow: 1;
        display: flex;
        flex-direction: column;
    }
    .btn-primary {
        background: #6a11cb;
        border: none;
        border-radius: 10px;
    }

    .btn-primary:hover {
        background: #2575fc;
    }
    .btn-liked {
        background-color: white !important;
        color: black !important;  /* text/icon will be visible */
        border: 1px solid white !important;
    }
    .btn-disliked {
        background: linear-gradient(to right, #417787 0%, #414ae7 100%);
        color: white;
        border: none;
    }

</style>

<div class="row">
    <%//        Thread.sleep(1000);
        PostDao d = new PostDao(ConnectionProvider.getConnection());

        int cid = Integer.parseInt(request.getParameter("cid"));
        List<Post> posts = null;
        if (cid == 0) {
            posts = d.getAllPosts();
        } else {
            posts = d.getPostByCatId(cid);
        }
        if (posts.size() == 0) {
//            out.println("<h3 class ='display-3 text-center'> No Posts in this Category...</h3?");
            out.println(
                    "<div class='container d-flex justify-content-center align-items-center' style='height: 60vh;'>"
                    + "<div class='text-center'>"
                    + "<img src='https://cdn-icons-png.flaticon.com/512/4076/4076549.png' alt='No Posts' style='width:150px; opacity:0.6;'>"
                    + "<h2 class='mt-4 text-muted'>No Posts Found</h2>"
                    + "<p class='text-secondary' style='color: white !important;'>There are no blog posts in this category yet. Please check back later or explore other categories.</p>"
                    + "</div>"
                    + "</div>"
            );

            return;
        }
        for (Post p : posts) {
    %>
    <div class="col-md-6 mt-2">
        <div class="card h-100 d-flex flex-column shadow-sm">

            <!-- Image -->
            <%
                String pic = p.getpPic();
                if (pic == null || pic.trim().equals("")) {
                    pic = "default.jpg";
                }
            %>
            <img src="<%= request.getContextPath()%>/blog_pic/<%= pic%>"
                 class="card-img-top"
                 alt="Post Image"
                 onerror="this.onerror=null; this.src='<%= request.getContextPath()%>/blog_pic/default2.jpg';"
                 style="height: 200px; object-fit: cover;">

            <!-- Card Body -->
            <div class="card-body flex-grow-1 d-flex flex-column">
                <b class="mb-2"><%= p.getpTitle()%></b>

                <!-- Content -->
                <p class="card-text">
                    <%= p.getpContent().length() > 100 ? p.getpContent().substring(0, 100) + "..." : p.getpContent()%>
                </p>
            </div>

            <!-- Aligned Card Footer -->
            <% if (p.getpContent().length() > 100) {%>
            <div class="card-footer border-top text-center"
                 style="background: linear-gradient(135deg, #2c3e50 0%, #4ca1af 100%);">

                <!-- Read More -->
                <a href="show_blog_page.jsp?post_id=<%= p.getPid()%>" class="btn btn-sm btn-outline-light rounded-pill me-2 px-3">
                    <i class="bi bi-eye-fill me-1"></i> Read More
                </a>

                <!-- Like -->

                <%
                    LikeDao ld = new LikeDao(ConnectionProvider.getConnection());
                %>

                <%
                    boolean isLiked = ld.isPostLikedByUser(p.getPid(), user.getId());
                    String btnClass = isLiked ? "btn-liked" : "btn-outline-light";   // use Bootstrap outline-light for default
                %>

                <a href="#!" class="btn btn-sm rounded-pill me-2 px-3 <%= btnClass%>" 
                   onclick="doLike(<%= p.getPid()%>,<%= user.getId()%>, this)">
                    <i class="bi bi-hand-thumbs-up-fill me-1"></i> 
                    <span class="like-counter"><%= ld.countLikeOnPost(p.getPid())%></span>
                </a>



                <!-- Comments -->
                <a href="show_blog_page.jsp?post_id=<%= p.getPid()%>#disqus_thread" 
                   class="btn btn-sm btn-outline-light rounded-pill px-3">
                    <i class="bi bi-chat-left-dots-fill me-1"></i>
                    <span class="disqus-comment-count" data-disqus-identifier="post_<%= p.getPid()%>">0</span>
                </a>

                <script id="dsq-count-scr" src="//codeverse-blogs-1.disqus.com/count.js" async></script>

            </div>
            <% } %>

        </div>
    </div>

    <%
        }
    %>
</div>

<!-- Script to add like and dislike -->
<script>
    function doLike(pid, uid, element) {
        $.ajax({
            url: "LikeServlet",
            type: "POST",
            data: {uid: uid, pid: pid},
            success: function (data) {
                console.log("Server response:", data);
                let counter = $(element).find(".like-counter");
                let c = parseInt(counter.html());

                if (data.trim() === "liked") {
                    counter.html(c + 1);
                    $(element).removeClass("btn-outline-light").addClass("btn-liked");
                } else if (data.trim() === "disliked") {
                    counter.html(c - 1);
                    $(element).removeClass("btn-liked").addClass("btn-outline-light");
                }

            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log("Error:", textStatus, errorThrown);
                console.log("Response:", jqXHR.responseText);
            }
        });
    }



</script>



