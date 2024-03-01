<%-- 
    Document   : index
    Created on : 02-Sept-2023, 2:55:34 pm
    Author     : NATTAR
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,java.util.*"%>
<%Class.forName("com.mysql.cj.jdbc.Driver");%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="login_style.css">
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

.log input[type=text], input[type=password]{
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

a{
    color:blue;
    text-decoration: none;
}
a:hover{
    color:rgba(15, 33, 196, 0.575);
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
    <form action="login.jsp" method="post">
        <h2>Login</h2><br><br>
            <input type="text" name="staffid_check" placeholder="Enter Username" required><br><br>
            <input type="password" name="password_check" placeholder="Enter Password" required><br><br>
            <div class="but"><input type="submit" value="Login" style="height: 30px; width: 100px;"></div><br><br>
        <h3>Is this your first time?&nbsp;&nbsp;&nbsp;<a href="signup.jsp">Register</a></h3>
    </form>
        <br>
        <%
            String origin=request.getParameter("email");
            if (origin!=null){
            String id=request.getParameter("staffid");
            String mail=request.getParameter("email");
            String pass=request.getParameter("password");
            
            try
            {
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cinema?zeroDateTimeBehavior=CONVERT_TO_NULL", "root", "Bala@150304");
                Statement st=con.createStatement();
                int i=st.executeUpdate("insert into users(staffid,email,password)values('"+id+"','"+mail+"','"+pass+"')");
                int j=st.executeUpdate("create table "+id+"_liked"+"(movie_name varchar(100) unique not null ,liked int)");
                
                out.println("<h4>Registered Successfully</h4>");
            }
            catch(Exception e)
            {
                out.print("<h4>"+e.getMessage()+"</h4>");
            }
            
            }
            else if (request.getMethod().equalsIgnoreCase("POST")) {
        String id_check = request.getParameter("staffid_check");
        String pass_check = request.getParameter("password_check");
        session.setAttribute("tabletoaddsubject_name", id_check);
        int staffIdFound = 0;
        String passwords = null;

        try {
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cinema?zeroDateTimeBehavior=CONVERT_TO_NULL", "root", "Bala@150304");
            String checkQuery = "SELECT 1 FROM users WHERE staffid = ?";
            PreparedStatement checkStatement = con.prepareStatement(checkQuery);
            checkStatement.setString(1, id_check);
            ResultSet checkResultSet = checkStatement.executeQuery();

            if (checkResultSet.next()) {
                staffIdFound = 1;

                String passwordQuery = "SELECT password FROM users WHERE staffid = ?";
                PreparedStatement passwordStatement = con.prepareStatement(passwordQuery);
                passwordStatement.setString(1, id_check);
                ResultSet passwordResultSet = passwordStatement.executeQuery();

                if (passwordResultSet.next()) {
                    passwords = passwordResultSet.getString("password");
                }

                passwordResultSet.close();
                passwordStatement.close();
            }

            checkResultSet.close();
            checkStatement.close();
            con.close();

            if (staffIdFound == 1 && passwords != null && passwords.equals(pass_check)) {
                response.sendRedirect("index.jsp");
            } else {
                out.println("<h4>Invalid Login</h4>");
            }
        } catch (Exception e) {
            out.println("An error occurred: " + e.getMessage());
        }
        session.setAttribute("likedtbname",(id_check+"_liked"));
    }
    %>

    </div>
</div>
</div>
</body>
</html>
