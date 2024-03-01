<!-- index.jsp -->

<%-- 
    Document   : index
    Created on : 02-Oct-2023, 9:56:09 am
    Author     : NATTAR
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="style.css" />
    <title>All about cinema</title>
    <style>
        /* Styles for the navigation bar */
        .navbar {
            position: fixed;
            top: 0;
            left: -25%;
            height: 100%;
            width: 25%;
            background-color: #333;
            transition: left 0.3s;
            overflow-x: hidden;
        }

        .navbar.show {
            left: 0;
        }

        .navbar p {
            color: white;
            text-align: center;
            padding: 20px;
            margin: 0;
        }

        .navbar ul {
            padding: 0;
            margin: 0;
            list-style: none;
            text-align: center;
        }

        .navbar ul li {
            margin: 20px 0;
        }

        .navbar ul li a {
            color: white;
            text-decoration: none;
            display: block;
        }

        .navbar ul li a:hover {
            text-decoration: underline;
        }

        .navbar-toggle {
            position: fixed;
            top: 10px;
            left: 10px;
            cursor: pointer;
            color: white;
            font-size: 20px;
        }

        /* Styles for the close button */
        .close-button {
            position: absolute;
            top: 10px;
            right: 10px;
            cursor: pointer;
            color: white;
            font-size: 20px;
        }
        button{
            background-color: #333;
            color: whitesmoke;
            width: 25%;
            padding: 0.3rem;
            
            
        }
    </style>
</head>
<body>
<header>
    <img src="mo logo.png" alt="Movies logo" height="40px" width="110px">
    <h1>ALL ABOUT CINEMA</h1>
    <div class="navbar-toggle" onclick="toggleNavbar()">
        ☰
    </div>
    <form id="form">
        <input type="text" placeholder="Search" id="search" class="search" />
    </form>
</header>
<main id="main"></main>
<footer class="footer">
    <center><p>
        We use the TMDb API
        </p></center>
</footer>
<div class="navbar">
    <span class="close-button" onclick="toggleNavbar()">&times;</span>
    <p>Welcome</p>
    <ul>
        <li><a href="liked_movies.jsp">Favourites</a></li>
        <li><button id="logout-button">Logout</button></li>
    </ul>
</div>
<script src="script.js"></script>
<script>
    // JavaScript code for logout functionality
    const logout = () => {
        // Clear session storage
        sessionStorage.clear();

        // Redirect to the login page
        window.location.href = "login.jsp"; // Replace with your login page URL
    };

    const logoutButton = document.getElementById("logout-button");

    if (logoutButton) {
        logoutButton.addEventListener("click", () => {
            logout();
        });
    }
</script>
<script>
    // JavaScript to toggle the navbar
    function toggleNavbar() {
        const navbar = document.querySelector(".navbar");
        navbar.classList.toggle("show");
    }
</script>
</body>
</html>
