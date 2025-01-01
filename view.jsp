<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Student Records</title>

    <!-- Bootstrap CSS (CDN) -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css">

    <!-- Optional Bootstrap JS (CDN) for interactivity like buttons, modals, etc. -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>

<div class="container mt-4">
    <h2 class="mb-4">Task Records</h2>

    <%
        // JDBC variables
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        String url = "jdbc:mysql://localhost:3306/todolist";  // Change with your DB info
        String dbUser = "root";  // Change with your DB username
        String dbPassword = "";  // Change with your DB password

        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish connection
            conn = DriverManager.getConnection(url, dbUser, dbPassword);

            // Create SQL query to fetch task data
            String sql = "SELECT * FROM tasks";
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);

            // Display task records in a table
            out.println("<table class='table table-bordered table-striped'>");
            out.println("<thead class='table-dark'><tr><th>ID</th><th>Description</th><th>Status</th><th>Create Date</th><th>Due Date</th></tr></thead>");
            out.println("<tbody>");

            while (rs.next()) {
                int id = rs.getInt("id");
                String description = rs.getString("description");
                String status = rs.getString("status");
                String createdate = rs.getString("createdate");
                String duedate = rs.getString("duedate");

                out.println("<tr>");
                out.println("<td>" + id + "</td>");
                out.println("<td>" + description + "</td>");
                out.println("<td>" + status + "</td>");
                out.println("<td>" + createdate + "</td>");
                out.println("<td>" + duedate + "</td>");
                out.println("</tr>");
            }

            out.println("</tbody>");
            out.println("</table>");

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            out.println("<h3>Error: " + e.getMessage() + "</h3>");
        } finally {
            // Close the database resources
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
    %>

    <br>
    <a href="add.jsp" class="btn btn-primary">Add New Task</a>
</div>

</body>
</html>
