<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Task Record</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEJ03Ruq7l6p1JIH4I6EIZT5T0htn4w0wEx8c24VJgS1IHVdBoPXAYWVh9v5p" crossorigin="anonymous">
</head>
<body class="bg-light">

<div class="container mt-5">
    <h2 class="text-center mb-4">Add Task Record</h2>

    <%
        // Check if form is submitted
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            // Get form data
            String description = request.getParameter("description");
            String status = request.getParameter("status");
            String createdate = request.getParameter("createdate");
            String duedate = request.getParameter("duedate");

            // JDBC variables
            Connection conn = null;
            PreparedStatement stmt = null;
            String url = "jdbc:mysql://localhost:3306/todolist?useUnicode=true&characterEncoding=UTF-8";  // Updated URL for encoding
            String dbUser = "root";  // Your database username
            String dbPassword = "";  // Your database password

            try {
                // Load MySQL JDBC Driver (for MySQL 8 and above)
                Class.forName("com.mysql.cj.jdbc.Driver");  // Corrected driver class for MySQL 8.0+

                // Establish connection
                conn = DriverManager.getConnection(url, dbUser, dbPassword);

                // Prepare SQL query to insert task data
                String sql = "INSERT INTO tasks (description, status, createdate, duedate) VALUES (?, ?, ?, ?)";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, description);
                stmt.setString(2, status);
                stmt.setString(3, createdate);
                stmt.setString(4, duedate);

                // Execute the query
                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    out.println("<div class='alert alert-success text-center'>Task record added successfully!</div>");
                } else {
                    out.println("<div class='alert alert-danger text-center'>Failed to add the task record.</div>");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<div class='alert alert-danger text-center'>Error: " + e.getMessage() + "</div>");
            } finally {
                try {
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException se) {
                    se.printStackTrace();
                }
            }
        }
    %>

    <!-- Task Form -->
    <form action="add.jsp" method="POST">
        <div class="card p-4 shadow-sm">
            <div class="mb-3">
                <label for="description" class="form-label">Description:</label>
                <input type="text" class="form-control" id="description" name="description" required>
            </div>

            <div class="mb-3">
                <label for="status" class="form-label">Status:</label>
                <select class="form-select" id="status" name="status" required>
                    <option value="Completed">Completed</option>
                    <option value="Pending">Pending</option>
                </select>
            </div>

            <div class="mb-3">
                <label for="createdate" class="form-label">Created Date:</label>
                <input type="date" class="form-control" id="createdate" name="createdate" required>
            </div>

            <div class="mb-3">
                <label for="duedate" class="form-label">Due Date:</label>
                <input type="date" class="form-control" id="duedate" name="duedate" required>
            </div>

            <div class="d-grid">
                <button type="submit" class="btn btn-primary">Add Task</button>
            </div>
        </div>
    </form>

    <br>
    <a href="view.jsp" class="btn btn-link">View All Tasks</a>
</div>

<!-- Bootstrap JS and dependencies -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz4fnFO9gybT1XVdXf4f7yTOtW5e6r6EOv8hCZ1Go5lEjc3Ut98g8u7FqG" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js" integrity="sha384-pzjw8f+ua7Kw1TIq0sy0vUqkk9BzF1Eq3nv/p6uWHEoOBXxYs7X57tH0VrlPbX3S" crossorigin="anonymous"></script>

</body>
</html>
