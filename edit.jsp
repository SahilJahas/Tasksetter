<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Task</title>

    <!-- Bootstrap CSS (CDN) -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css">

    <!-- Optional Bootstrap JS (CDN) for interactivity like buttons, modals, etc. -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>

<div class="container mt-4">
    <h2>Edit Task</h2>

    <%
        // JDBC variables
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String url = "jdbc:mysql://localhost:3306/todolist";  // Change with your DB info
        String dbUser = "root";  // Change with your DB username
        String dbPassword = "";  // Change with your DB password
        int taskId = Integer.parseInt(request.getParameter("id")); // Get the ID of the task to edit

        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish connection
            conn = DriverManager.getConnection(url, dbUser, dbPassword);

            // Fetch the task details using the ID
            String sql = "SELECT * FROM tasks WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, taskId); // Set the ID in the query
            rs = stmt.executeQuery();

            if (rs.next()) {
                // Get task details from the database
                String description = rs.getString("description");
                String status = rs.getString("status");
                String createdate = rs.getString("createdate");
                String duedate = rs.getString("duedate");
    %>

    <!-- Task Edit Form -->
    <form action="update.jsp" method="post">
        <input type="hidden" name="id" value="<%= taskId %>" />
        
        <div class="mb-3">
            <label for="description" class="form-label">Description</label>
            <input type="text" class="form-control" id="description" name="description" value="<%= description %>" required />
        </div>
        
         <div class="mb-3">
                <label for="status" class="form-label">Status:</label>
                <select class="form-select" id="status" name="status" required>
                    <option value="Completed">Completed</option>
                    <option value="Pending">Pending</option>
                </select>
            </div>
        <div class="mb-3">
            <label for="createdate" class="form-label">Create Date</label>
            <input type="text" class="form-control" id="createdate" name="createdate" value="<%= createdate %>" disabled />
        </div>
        
        <div class="mb-3">
            <label for="duedate" class="form-label">Due Date</label>
            <input type="date" class="form-control" id="duedate" name="duedate" value="<%= duedate %>" required />
        </div>

        <button type="submit" class="btn btn-primary">Update Task</button>
    </form>

    <%
            } else {
                out.println("<h3>No task found with the given ID.</h3>");
            }
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
    <a href="view.jsp" class="btn btn-secondary">Back to Task List</a>
</div>

</body>
</html>
