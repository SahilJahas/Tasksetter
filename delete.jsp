<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Task</title>
</head>
<body>

<%
    // JDBC variables
    Connection conn = null;
    PreparedStatement stmt = null;
    String url = "jdbc:mysql://localhost:3306/todolist";  // Change with your DB info
    String dbUser = "root";  // Change with your DB username
    String dbPassword = "";  // Change with your DB password
    int taskId = Integer.parseInt(request.getParameter("id")); // Get the task ID to delete

    try {
        // Load MySQL JDBC Driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish connection
        conn = DriverManager.getConnection(url, dbUser, dbPassword);

        // Create SQL query to delete task
        String sql = "DELETE FROM tasks WHERE id = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, taskId); // Set the task ID for deletion

        int rowsAffected = stmt.executeUpdate();

        if (rowsAffected > 0) {
            response.sendRedirect("view.jsp"); // Redirect back to the task list page
        } else {
            out.println("<h3>Error: Task not found.</h3>");
        }

    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
        out.println("<h3>Error: " + e.getMessage() + "</h3>");
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

</body>
</html>
