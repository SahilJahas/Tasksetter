<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Student Records</title>
</head>
<body>

<h2>Task Records</h2>

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
        Class.forName("com.mysql.jdbc.Driver");

        // Establish connection
        conn = DriverManager.getConnection(url, dbUser, dbPassword);

        // Create SQL query to fetch task data
        String sql = "SELECT * FROM tasks";
        stmt = conn.createStatement();
        rs = stmt.executeQuery(sql);

        // Display task records in a table
        out.println("<table border='1' cellpadding='5' cellspacing='0' style='border-collapse: collapse;'>");
        out.println("<tr><th>ID</th><th>Description</th><th>Status</th><th>Create Date</th><th>Due Date</th></tr>");

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
<a href="add.jsp">Add New Task</a>

</body>
</html>
