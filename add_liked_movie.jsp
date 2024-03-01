<%-- 
    Document   : add_liked_movie
    Created on : 02-Oct-2023, 12:24:04 pm
    Author     : NATTAR
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%> <!-- Import the necessary Java SQL classes -->

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
</head>
<body>
    <%
        // Retrieve the movie title from the query parameter
        String movieTitle = request.getParameter("movieTitle");
        
        // JDBC URL, driver class, username, and password
        String url = "jdbc:mysql://localhost:3306/cinema?zeroDateTimeBehavior=CONVERT_TO_NULL";
        String driverClass = "com.mysql.cj.jdbc.Driver";
        String username = "root";
        String password = "Bala@150304";
        String m=(String)session.getAttribute("likedtbname");
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        
        try {
            // Load the JDBC driver
            Class.forName(driverClass);
            
            // Establish a database connection
            connection = DriverManager.getConnection(url, username, password);
            
            // SQL query to insert the movie title into the 'liked' table
            String insertQuery = "INSERT INTO "+m+" (movie_name,liked) VALUES (?,1)";
            
            // Create a PreparedStatement
            preparedStatement = connection.prepareStatement(insertQuery);
            
            // Set the movie title as a parameter
            preparedStatement.setString(1, movieTitle);
            
            // Execute the insert query
            int rowsInserted = preparedStatement.executeUpdate();
            
            if (rowsInserted > 0) {
                out.println("<p>Movie title added successfully!</p>");
            } else {
                out.println("<p>Failed to add movie title.</p>");
            }
        } catch (Exception e) {
            out.println("<p>An error occurred: " + e.getMessage() + "</p>");
        } finally {
            // Close resources
            if (preparedStatement != null) {
                preparedStatement.close();
            }
            if (connection != null) {
                connection.close();
            }
        }
        response.sendRedirect("index.jsp");
    %>
</body>
</html>
