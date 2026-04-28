<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Send Feedback</title>

<style>
body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin: 0;
}

.form-container {
    background: white;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    width: 300px;
    text-align: center;
}

h2 {
    margin-bottom: 20px;
}

form {
    display: flex;
    flex-direction: column;
}

label {
    text-align: left;
    margin-top: 10px;
}

input {
    padding: 8px;
    margin-top: 5px;
    border: 1px solid #ccc;
    border-radius: 4px;
}

button {
    margin-top: 15px;
    padding: 10px;
    background: #d4a762;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

button:hover {
    background: #218838;
}

a {
    text-decoration: none;
    color: blue;
    font-size: 14px;
}
   .form-container {
            width: 50%;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px #d4a762;
            text-align: center;
        }
</style>
</head>
<body>

<%
    // Retrieve email from session
    String email = (String) session.getAttribute("username");

    // If email is null, redirect to login page
    if (email == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<div class="form-container">
    <h2>Send Feedback</h2>

    <form method="post" action="">
        <label for="email">Email:</label>
        <input type="text" id="email" name="email" value="<%= email %>" readonly>

        <label for="feedback">Feedback:</label>
        <input type="text" id="feedback" name="feedback" required>

        <button type="submit" >Submit</button>
        <br><br>
        <a href="customerdashboard.jsp" class='back'>Back</a>
    </form>
</div>

<%
    // Only execute when form is submitted
    if (request.getMethod().equalsIgnoreCase("POST")) {
        String feedback = request.getParameter("feedback");

        if (feedback != null && !feedback.trim().isEmpty()) {
            try {
                // Load JDBC Driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Establish connection
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/event", "root", "root");

                // Prepare SQL statement
                PreparedStatement pst = conn.prepareStatement("INSERT INTO feedback(email, feedback) VALUES (?, ?)");

                pst.setString(1, email); // Use email from session
                pst.setString(2, feedback);

                int i = pst.executeUpdate();
                pst.close();
                conn.close();

                if (i == 1) {
%>
                    <script>
                        alert("Feedback sent successfully!");
                        window.location.href = "customerdashboard.jsp";
                    </script>
<%
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
%>

</body>
</html>
