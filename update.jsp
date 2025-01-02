<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Task</title>

    <!-- Bootstrap CSS (CDN) -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css">

    <!-- Optional Bootstrap JS (CDN) for interactivity like buttons, modals, etc. -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>

<div class="container mt-4">
    <h2>Update Task</h2>

    <%
        // JDBC variables
        Connection conn = null;
        PreparedStatement stmt = null;
        String url = "jdbc:mysql://localhost:3306/todolist";  // Change with your DB info
        String dbUser = "root";  // Change with your DB username
        String dbPassword = "";  // Change with your DB password

        // Get the task ID and form data from the request
        int taskId = Integer.parseInt(request.getParameter("id"));
        String description = request.getParameter("description");
        String status = request.getParameter("status");
        String duedate = request.getParameter("duedate");

        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish connection
            conn = DriverManager.getConnection(url, dbUser, dbPassword);

            // SQL to update the task
            String sql = "UPDATE tasks SET description = ?, status = ?, duedate = ? WHERE id = ?";
            stmt = conn.prepareStatement(sql);

            // Set the parameters for the update query
            stmt.setString(1, description);
            stmt.setString(2, status);
            stmt.setString(3, duedate);
            stmt.setInt(4, taskId);

            // Execute the update query
            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
    %>
                <div class="alert alert-success" role="alert">
                    Task updated successfully!
                </div>
                <a href="view.jsp" class="btn btn-secondary">Back to Task List</a>
    <%
            } else {
    %>
                <div class="alert alert-danger" role="alert">
                    Error: Unable to update task. Please try again.
                </div>
                <a href="view.jsp" class="btn btn-secondary">Back to Task List</a>
    <%
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
    %>
            <div class="alert alert-danger" role="alert">
                Error: <%= e.getMessage() %>
            </div>
            <a href="view.jsp" class="btn btn-secondary">Back to Task List</a>
    <%
        } finally {
            // Close the database resources
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
    %>
</div>

</body>
</html>
