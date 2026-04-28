<%@page import="java.sql.*"%>
<%@page import="javax.servlet.http.*"%>
<%@page import="javax.servlet.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String email = request.getParameter("email");
        String message = request.getParameter("message");

        if (email != null && message != null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/event", "root", "root");

                // Correct SQL Statement
                PreparedStatement pst = conn.prepareStatement("INSERT INTO notification(email, message) VALUES (?, ?)");
                pst.setString(1, email);
                pst.setString(2, message);
                
                int i = pst.executeUpdate();
                conn.close();

                if (i == 1) {
%>
                    <script>
                        alert('Notification sent successfully!');
                        window.location.href = 'admindashboard.jsp';
                    </script>
<%
                } else {
%>
                    <script>
                        alert('Failed to send notification!');
                        window.location.href = 'sendnotification.jsp';
                    </script>
<%
                }
            } catch (Exception e) {
                e.printStackTrace();
%>
                <script>
                    alert('Database error! Please try again.');
                    window.location.href = 'sendnotification.jsp';
                </script>
<%
            }
        } else {
%>
            <script>
                alert('Invalid input!');
                window.location.href = 'sendnotification.jsp';
            </script>
<%
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Send Notification</title>
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
    box-shadow: 0px 0px 40px #d4a762;
        
              border: 3px solid #d4a762;
    width: 300px;
    text-align: center;
}
h2 {
    margin-bottom: 20px;
    text-align: center;
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
    background: green;
}
 .back{
  background:  #d4a762;
    color: white;
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    text-decoration: none;
    font-size: 16px;
    cursor: pointer;
    transition: background 0.3s ease;
  }
  .back:hover{
      background: green;
  }
</style>
</head>
<body>

<div class="form-container">

    <h2>Send Notification</h2>
    <form action="" method="post"> <!-- Keep action empty to submit to the same page -->
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required>

        <label for="message">Message:</label>
        <input type="text" id="message" name="message" required>

        <button type="submit">Send</button><br><br>
        <a href="admindashboard.jsp" class='back'>Back</a>
        
    </form>
</div>

</body>
</html>
