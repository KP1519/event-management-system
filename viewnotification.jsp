<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notification</title>
    <style>
        body {                 
            font-family: Arial, sans-serif;
          
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            width: 50%;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px #d4a762;
            text-align: left;
        }
        h2 {
            color: #d4a762 ;
            text-align: center;
        }
        .box {
            border: 2px solid #000;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 15px;
        }
        .label {
            font-weight: bold;
        }
        .send-button {
            display: block;
            width: 100px;
            text-align: center;
            background: #007bff;
            color: white;
            padding: 10px;
            border-radius: 5px;
            text-decoration: none;
            margin-top: 10px;
        }
        .send-button:hover {
            background: #0056b3;
        }
          .back{
  background: black;
    color: white;
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    text-decoration: none;
    font-size: 16px;
    cursor: pointer;
    transition: background 0.3s ease;
  }
       
    </style>
</head>
<body>
    <div class="container">
    <button class='back' onclick=window.location.href='customerdashboard.jsp'>back</button>
        <h2>Notifications</h2>
        
        <% 
            String username = (String) session.getAttribute("username");
            if (username == null) {
                response.sendRedirect("login.jsp");
                return;
            }
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/event", "root", "root");
                PreparedStatement pst = conn.prepareStatement("SELECT id, message, answer,date FROM notification WHERE email = ?");
                pst.setString(1, username);
                ResultSet rs = pst.executeQuery();
                
                while (rs.next()) {
                    int messageId = rs.getInt("id");
                    String message = rs.getString("message");
                    String answer = rs.getString("answer");
                    String date = rs.getString("date");
        %>
        
        <div class="box">
            <p><span class="label">From:</span> Admin</p>
            <p><span class="label">To:</span> <%= username %></p>
            <p><span class="label">Date:</span> <%= date %></p>
            <p><span class="label">Message:</span> <%= message %></p>
            <p><span class="label">Reply:</span> <%= (answer != null && !answer.isEmpty()) ? answer : "No reply yet" %></p>
            
            <form action="savereply.jsp" method="post">
                <input type="hidden" name="messageId" value="<%= messageId %>">
                <textarea name="replyText" required></textarea>
                <button type="submit">Submit Reply</button>
            </form>
        </div>

        <% 
                }
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
                out.println("Database Error!");
            }
        %>
    </div>
</body>
</html>
