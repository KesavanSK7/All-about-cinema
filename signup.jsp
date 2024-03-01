<%-- 
    Document   : signup
    Created on : 02-Sept-2023, 2:57:09 pm
    Author     : NATTAR
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,java.util.*"%>
<% Class.forName("com.mysql.cj.jdbc.Driver");%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Signup</title>
    <link rel="stylesheet" href="signup_style.css">
    <script>
        function validateInput() {
            var sta_id = document.getElementById("sta_id");
            var inputValue = sta_id.value.trim();
            var pattern = /^[A-Za-z_][A-Za-z0-9_]*$/;
            if (pattern.test(inputValue)) {
                return true;
            } else {
                alert("Please enter a valid Staff id starting with alphabets and containing no special characters if you want use underscore instead.");
                sta_id.focus();
                return false;
            }
        }
    </script>
</head>
<style>
    *{
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

.bgimg{
    background-image: url(background.jpg);
    height: 100%;
    background-position: center;
    background-repeat: no-repeat;
    background-size: cover;
}

.heads{
    margin-bottom: 5rem;
    margin-left: 1rem;
    margin-right: 1rem;
    padding:1rem;
    color:whitesmoke;
    background-color: darkslategrey;
    display: flex;
    justify-content: center;
    align-items: center;
    border-radius: 25px;
    box-shadow: 2px;
}

.fl{
    display: flex;
    justify-content: center;
    align-items: center;
}
.log{
    width: 40%;
    padding:2rem;
    margin-bottom: 1rem;
    background-color: rgba(245, 245, 245, 0.5);
    border-radius: 25px;
    text-align: center;
    box-shadow: 20px;
}

body,html{
    height:100%;
}

input:focus{
    outline:none;
}

.log input[type=text], input[type=password], input[type=email]{
    width: 100%;
    padding: 12px 20px;
    border-radius: 25px;
    margin: 8px 0;
    display: inline-block   ;
    border: 1px solid #ccc;
    box-sizing: border-box;
}

.log input[type=submit]{
    border:none;
    cursor:pointer;
    color:white;
    background-color: #555;
    border-radius: 25px;
}

.log input[type=submit]:hover{
    background-color:white;
    color:black;
}

.log input::placeholder{
    text-align: center;
}

@media screen and (max-width: 780px){
    .log{
        width:60%;
    }
}

@media screen and (max-width: 520px){
    .log{
        width:70%;
    }
}
@media screen and (max-width: 450px){
    .log{
        width:80%;
    }
}

@media screen and (max-width: 390px){
    .log{
        width:90%;
    }
}

</style>
<body>
    <div class="bgimg">
        <br>
    <div class="heads">
        <h2>ALL ABOUT CINEMA</h2>
    </div>
    <div class="fl">
    <div class="log">
    <form action="login.jsp" method="post" onsubmit="return validateInput()">
        <h2>Sign Up</h2><br><br>
            <input type="text" name="staffid" placeholder="Create Username" id="sta_id" required><br><br>
            <input type="email" name="email" placeholder="Enter email" required><br><br>
            <input type="password" name="password" placeholder="Create Password" required><br><br>
            
            <div class="but"><input type="submit" value="Register" style="height: 30px; width: 100px;"></div><br><br>
    </form>
    </div>
</div>
</div>
</body>
</html>
