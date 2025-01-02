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
    
    <!-- Custom Styles for Color and Size -->
    <style>
        body {
            background-color: #f0f8ff; /* Light Blue Background */
        }
        .container {
            max-width: 1263px;  /* Increased width */
            margin-top: 10px;
        }
        h2 {
            color: #ff6347; /* Tomato Color */
            font-size: 2rem; /* Slightly smaller heading */
        }
        .card {
            background-color: #f9f9f9;
            border: 10px solid #4caf50;
            border-radius: 12px;  /* Larger border-radius */
            box-shadow: 0 8px 12px rgba(0, 0, 0, 0.1); /* Larger shadow */
            padding: 15px; /* Reduced padding for a shorter form */
            width: 100%;
            box-sizing: border-box; /* Ensure padding is inside the border */
        }
        .form-label {
            color: #2c3e50; /* Dark Blue */
            font-size: 1.3rem;  /* Slightly smaller font size for labels */
        }
        .form-control, .form-select {
            border-radius: 12px;
            border: 1px solid #3498db; /* Blue Border */
            font-size: 1rem;  /* Slightly smaller text inside fields */
            padding: 10px; /* Reduced padding */
            width: 100%;  /* Ensure all form fields have the same width */
            box-sizing: border-box; /* Prevent overflow */
        }
        .btn-primary {
            background-color: #3498db;
            border-color: #2980b9;
            font-size: 1.1rem;  /* Slightly smaller button font */
            padding: 12px 22px; /* Reduced button size */
        }
        .btn-primary:hover {
            background-color: #2980b9;
            border-color: #3498db;
        }
        .alert {
            border-radius: 15px;
            padding: 15px;
        }
        .alert-success {
            background-color: #28a745;
            color: white;
            font-size: 1.1rem;
        }
        .alert-danger {
            background-color: #e74c3c;
            color: white;
            font-size: 1.1rem;
        }
        .btn-link {
            color: #8e44ad; /* Purple Color */
            font-size: 1.2rem;  /* Larger font size */
        }
        .btn-link:hover {
            color: #9b59b6; /* Darker Purple on Hover */
        }
    </style>
</head>
<body>

<div class="container">
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
        <div class="card p-3 shadow-sm">
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

            <div class="d-grid gap-2">
                <button type="submit" class="btn btn- btn-lg">Add Task</button>
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
