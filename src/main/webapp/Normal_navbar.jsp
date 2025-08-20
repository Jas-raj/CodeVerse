
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<nav class="navbar navbar-expand-lg shadow-sm sticky-top px-3" style="background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);">
    <div class="container-fluid">
        <!-- Logo and Brand -->
        <a class="navbar-brand fw-bold d-flex align-items-center gap-2 text-white" style="font-size: 1.3rem;">
            <img src="https://cdn-icons-png.flaticon.com/512/3039/3039396.png" width="36" height="36" alt="Logo" style="border-radius: 8px;">
            <span style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;">CodeVerse</span>
        </a>

        <!-- Toggler -->
        <button class="navbar-toggler bg-white" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Navbar Items -->
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0" style="font-size: 0.95rem;">
                <li class="nav-item">
                    <a class="nav-link text-white" aria-current="page" href="index.jsp"><i class="fa fa-home me-1"></i> Home</a>
                </li>

<!--                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle text-white" href="#" onclick="getPost(0, this)" id="navbarDropdown" role="button"
                       data-bs-toggle="dropdown" aria-expanded="false">
                        Categories
                    </a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="#">HTML/CSS/</a></li>
                        <li><a class="dropdown-item" href="#">Java/Python/C/C++</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="#">Data Structures</a></li>
                    </ul>
                </li>-->




                <li class="nav-item">
                    <a class="nav-link text-white" href="ContactUS.jsp"><i class="fa fa-phone"></i> Contact US!</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link text-white" href="login_page.jsp"><i class="fa fa-user-circle-o me-1"></i> Login</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link text-white" href="register_page.jsp"><i class="fa fa-users me-1"></i> Sign-up</a>
                </li>
            </ul>

            <!-- Search Form -->
            <!--            <form class="d-flex" role="search">
                            <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
                            <button class="btn btn-light" type="submit">Search</button>
                        </form>-->
        </div>
    </div>
</nav>

