<%@ page import="java.sql.*, java.io.*, java.net.*, java.util.List, java.util.ArrayList" %>
<%@ page import="org.json.simple.*, org.json.simple.parser.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%!
    String getClassByRate(double vote){
        if (vote >= 7.5) return "green";
        else if (vote >= 5) return "orange";
        else return "red";
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Liked Movies</title>
    <link rel="stylesheet" href="style.css">

    <style>
        a{
            text-decoration: none;
            color:whitesmoke;
        }
        a:hover{
            color:grey;
        }
    .movie-container {
        display: flex;
        flex-wrap: wrap;
        justify-content: space-evenly;
    }

    .movie {
        background-color: #3498db;
        padding: 10px;
        border-radius: 5px;
        position: relative;
    }

    .movie img {
        max-width: 100%;
        height: auto;
    }

    .movie .overview {
        position: absolute;
        top: 100%;
        left: 0;
        right: 0;
        background-color: rgba(0, 0, 0, 0.8);
        color: white;
        padding: 10px;
        border-radius: 5px;
        z-index: 1;
        opacity: 0; /* Initially hidden */
        visibility: hidden; /* Initially hidden */
        transition: opacity 0.3s, visibility 0.3s; /* Smooth transition */
    }

    .movie:hover .overview {
        opacity: 1; /* Show on hover */
        visibility: visible; /* Show on hover */
    }
</style>
</head>
<body>
    <header>
        <img src="Movie logo.jpg" alt="Movies logo" height="40px" width="110px">
        <h1>ALL ABOUT CINEMA</h1>
        <a href="index.jsp">Home</a>
    </header>
    <main id="main">
        <div class="movie-container">
            <%
                // JDBC URL, driver class, username, and password
                String url = "jdbc:mysql://localhost:3306/cinema?zeroDateTimeBehavior=CONVERT_TO_NULL";
                String driverClass = "com.mysql.cj.jdbc.Driver";
                String username = "root";
                String password = "Bala@150304";
                String likedtbname = (String) session.getAttribute("likedtbname");

                Connection connection = null;
                PreparedStatement preparedStatement = null;
                ResultSet resultSet = null;

                try {
                    // Load the JDBC driver
                    Class.forName(driverClass);

                    // Establish a database connection
                    connection = DriverManager.getConnection(url, username, password);

                    // SQL query to retrieve liked movies from the 'liked' table
                    String selectQuery = "SELECT movie_name FROM " + likedtbname;

                    // Create a PreparedStatement
                    preparedStatement = connection.prepareStatement(selectQuery);

                    // Execute the select query
                    resultSet = preparedStatement.executeQuery();

                    while (resultSet.next()) {
                        String movieName = resultSet.getString("movie_name");

                        // Prepare the API URL to search for movie details by title
                        String apiKey = "3fd2be6f0c70a2a598f084ddfb75487c"; // Replace with your TMDB API key
                        String searchUrl = "https://api.themoviedb.org/3/search/movie?"
                            + "api_key=" + apiKey + "&query=" + URLEncoder.encode(movieName, "UTF-8");

                        // Open a connection to the API
                        URL urlObj = new URL(searchUrl);
                        HttpURLConnection apiConnection = (HttpURLConnection) urlObj.openConnection();
                        apiConnection.setRequestMethod("GET");

                        // Read the API response
                        BufferedReader reader = new BufferedReader(new InputStreamReader(apiConnection.getInputStream()));
                        String inputLine;
                        StringBuilder apiResponseStr = new StringBuilder();

                        while ((inputLine = reader.readLine()) != null) {
                            apiResponseStr.append(inputLine);
                        }
                        reader.close();

                        // Parse the API response to get movie details
                        JSONParser parser = new JSONParser();
                        JSONObject apiResponse = (JSONObject) parser.parse(apiResponseStr.toString());
                        JSONArray movies = (JSONArray) apiResponse.get("results");

                        // Add the first movie (if any) to the likedMoviesList
                        if (movies != null && !movies.isEmpty()) {
                            JSONObject movie = (JSONObject) movies.get(0);
                            String title = (String) movie.get("title");
                            String posterPath = (String) movie.get("poster_path");
                            double voteAverage = (double) movie.get("vote_average");
                            String overview = (String) movie.get("overview");
            %>
            <div class="movie">
                <img src="<%= "https://image.tmdb.org/t/p/w1280" + posterPath %>" alt="<%= title %>" />
                <div class="movie-info">
                    <h3><%= title %></h3>
                    <span class="<%= getClassByRate(voteAverage) %>"><%= voteAverage %></span>
                </div>
                <div class="overview">
                    <h3>Overview</h3>
                    <%= overview %>
                </div>
            </div>
            <%
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    // Close resources
                    if (resultSet != null) {
                        resultSet.close();
                    }
                    if (preparedStatement != null) {
                        preparedStatement.close();
                    }
                    if (connection != null) {
                        connection.close();
                    }
                }
            %>
        </div>
    </main>
    <footer class="footer">
        <center><p>We use the TMDb API</p></center>
    </footer>
</body>
</html>
