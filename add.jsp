<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Task Record</title>
</head>
<body>

<h2>Add Task Record</h2>

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
            Class.forName("com.mysql.jdbc.Driver");  // Corrected driver class for MySQL 8.0+

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
                out.println("<h3>Task record added successfully!</h3>");
            } else {
                out.println("<h3>Failed to add the task record.</h3>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h3>Error: " + e.getMessage() + "</h3>");
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

<form action="add.jsp" method="POST">
    <table>
        <tr>
            <th colspan="2">Enter Task Details</th>
        </tr>
        <tr>
            <td>Description:</td>
            <td><input type="text" name="description" required></td>
        </tr>
        <tr>
            <td>Status:</td>
            <td><input type="text" name="status" required></td>
        </tr>
        <tr>
            <td>Created Date:</td>
            <td><input type="text" name="createdate" required></td>
        </tr>
        <tr>
            <td>Due Date:</td>
            <td><input type="text" name="duedate" required></td>
        </tr>
    </table>
    <br>
    <button type="submit">Add Record</button>
</form>

<br>
<a href="view.jsp">View All Tasks</a>

</body>
</html>
