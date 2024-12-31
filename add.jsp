<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>To-Do List</title>
  <link rel="stylesheet" href="styles.css">
  <script src="script.js" defer></script>
</head>
<body>
<%
    // Check if form is submitted
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        // Get form data
        String status = request.getParameter("status");
        String description = request.getParameter("description");
        String createdate = request.getParameter("createdate");  
        String duedate = request.getParameter("duedate");
        // JDBC variables
        Connection conn = null;
        PreparedStatement stmt = null;
        String url = "jdbc:mysql://localhost:3306/todolist";  // Change with your DB info
        String dbUser = "root";  // Change with your DB username
        String dbPassword = "";  // Change with your DB password

        try {
            // Load MySQL JDBC Driver (for newer versions of MySQL)
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Establish connection
            conn = DriverManager.getConnection(url, dbUser, dbPassword);

            // Prepare SQL query to insert task data
            String sql = "INSERT INTO tasks (description, status, createdate, duedate) VALUES (?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);

            // Set parameters (example values, you can update them based on your task form)
            stmt.setString(1, description); // task description
            stmt.setString(2, status); // status
            stmt.setString(3, createdate); // status
            stmt.setString(4, duedate); // status
            // Execute the query
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                out.println("<h3>Task added successfully!</h3>");
            } else {
                out.println("<h3>Failed to add the task.</h3>");
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

  <!-- Navbar -->
  <nav>
    <div class="container">
      <h1 class="logo">My To-Do List</h1>
      <ul class="navbar-links">
        <li><a href="#register">Register</a></li>
        <li><a href="#login">Login</a></li>
      </ul>
    </div>
  </nav>

  <!-- Main content -->
  <div class="container">
    <h2>Welcome to the To-Do List App</h2>

    <div class="todo-container">
      <!-- Task form -->
      <form method="POST" action="view.jsp">
        <input type="text" id="description" name="description" placeholder="Description" required />
        <input type="text" id="status" name="status" placeholder="Status" required />
        <input type="text" id="createdate" name="createdate" placeholder="Date" required />
        <input type="text" id="duedate" name="duedate" placeholder="Due date" required />
        
        
        
        <button type="submit" id="add-task-btn">Add Task</button>
      </form>

      <!-- Task List -->
      <ul id="task-list">
        <c:forEach var="task" items="${taskList}">
          <li class="task">${task}</li>
        </c:forEach>
      </ul>
    </div>
  </div>

  <!-- Modal for Register -->
  <div id="register" class="modal">
    <div class="modal-content">
      <h2>Register</h2>
      <form id="register-form">
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required />
        
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required />
        
        <button type="submit">Register</button>
      </form>
      <button class="close-modal">Close</button>
    </div>
  </div>

  <!-- Modal for Login -->
  <div id="login" class="modal">
    <div class="modal-content">
      <h2>Login</h2>
      <form id="login-form">
        <label for="login-username">Username:</label>
        <input type="text" id="login-username" name="username" required />
        
        <label for="login-password">Password:</label>
        <input type="password" id="login-password" name="password" required />
        
        <button type="submit">Login</button>
      </form>
      <button class="close-modal">Close</button>
    </div>
  </div>

  <style>
    /* Basic styles for the page */
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 0;
      background-color: #f4f4f4;
    }

    .container {
      width: 80%;
      margin: 0 auto;
    }

    nav {
      background-color: #333;
      padding: 10px;
      color: #fff;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .navbar-links {
      list-style-type: none;
      margin: 0;
      padding: 0;
      display: flex;
    }

    .navbar-links li {
      margin-left: 20px;
    }

    .navbar-links a {
      color: #fff;
      text-decoration: none;
      font-size: 18px;
    }

    .todo-container {
      background-color: #fff;
      padding: 20px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      margin-top: 30px;
    }

    #task-list {
      margin-top: 20px;
    }

    .task {
      background-color: #e1e1e1;
      padding: 10px;
      margin-bottom: 10px;
      border-radius: 4px;
    }

    .modal {
      display: none;
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-color: rgba(0, 0, 0, 0.5);
      justify-content: center;
      align-items: center;
    }

    .modal-content {
      background-color: #fff;
      padding: 20px;
      border-radius: 4px;
      width: 300px;
      text-align: center;
    }

    .close-modal {
      margin-top: 10px;
      background-color: #333;
      color: #fff;
      padding: 5px 10px;
      border: none;
      cursor: pointer;
    }

    .close-modal:hover {
      background-color: #555;
    }
  </style>

 
</body>
</html>
