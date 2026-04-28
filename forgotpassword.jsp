<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Reset Password</title>
<style>
    body {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        background-color: #f4f4f4;
        margin: 0;
    }
    .container {
        background: white;
        padding: 30px;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        width: 350px;
        text-align: center;
    }
    .input-box {
        display: flex;
        flex-direction: column;
        text-align: left;
    }
    label {
        font-weight: bold;
        margin-top: 10px;
    }
    input {
        width: 100%;
        padding: 10px;
        margin-top: 5px;
        border: 1px solid #ccc;
        border-radius: 5px;
    }
    button {
        width: 100%;
        padding: 10px;
        background-color: #0056b3;
        color: white;
        border: none;
        border-radius: 5px;
        font-size: 16px;
        cursor: pointer;
        margin-top: 15px;
    }
    button:hover {
        background-color: #003d80;
    }
</style>
</head>
<body>

<div class="container">
    <h2>Reset Password</h2>

    <!-- Password Reset Form -->
    <form method="post">
        <div class="input-box">
            <label>Email</label>
            <input type="email" name="email" placeholder="Enter email" required />

            <label>New Password</label>
            <input type="password" name="password" placeholder="Enter password" required />

            <button type="submit">Submit</button>
        </div>
    </form>

    <%
        // Fetch email and password from form submission
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Proceed only if email and password are provided
        if (email != null && password != null) {
            try {
                // Load MySQL JDBC Driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Establish Connection
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/event", "root", "root");

                // SQL query to update the password
                String sql = "UPDATE register SET password=? WHERE email=?";
                PreparedStatement pst = conn.prepareStatement(sql);
                pst.setString(1, password); // Set new password
                pst.setString(2, email);    // Match the email

                // Execute the update query
                int i = pst.executeUpdate();

                // Close resources
                pst.close();
                conn.close();

                // Redirect or show message based on result
                if (i == 1) {
                    out.println("<p style='color:green;'>Password updated successfully!</p>");
                    response.sendRedirect("Login.html"); // Redirect to login page
                } else {
                    out.println("<p style='color:red;'>No account found with this email.</p>");
                }

            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p style='color:red;'>An error occurred. Please try again later.</p>");
            }
        }
    %>
</div>

</body>
</html>
