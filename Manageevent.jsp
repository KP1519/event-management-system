<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Event Details</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #84fab0, #4FA3D1);
            margin: 0;
            padding: 0;
        }
        .container {
            width: 80%;
            margin: 30px auto;
            padding: 20px;
            background: white;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
            text-align: center;
        }
        h2 {
            color: #007bff;
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            border: 1px solid #000;
            text-align: center;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        img {
            width: 100px;
            height: 100px;
            border-radius: 5px;
        }
    </style>
</head>
<body>

<div class="container">
    <a href="admindashboard.jsp">Back</a>
    <h2>Event Details</h2>
    <table>
        <tr>
            <th>Event ID</th>
            <th>Event Name</th>
            <th>Event Location</th>
            <th>Organizer Name</th>
            <th>Mobile</th>
            <th>Capacity</th>
            <th>Application Fee</th>
            <th>Image</th>
            <th>action</th>
        </tr>
        <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/event", "root", "root");
            PreparedStatement pst = conn.prepareStatement("SELECT * FROM createevent");
            ResultSet rs = pst.executeQuery();
            
            while (rs.next()) {
                int eventid = rs.getInt("eventid");
                String eventname = rs.getString("eventname");
                String eventlocation = rs.getString("eventlocation");
                String organizername = rs.getString("organizername");
                long mobile = rs.getLong("mobile");
                int capacity = rs.getInt("capacity");
                int applicationfee = rs.getInt("applicationfee");
                String imageUrl = rs.getString("image");  
                String action = rs.getString("action"); 
                // Fetch image URL from DB
        %>
        <tr>
            <td><%= eventid %></td>
            <td><%= eventname %></td>
            <td><%= eventlocation %></td>
            <td><%= organizername %></td>
            <td><%= mobile %></td>
            <td><%= capacity %></td>
            <td><%= applicationfee %></td>
            <td>
                <% if (imageUrl != null && !imageUrl.isEmpty()) { %>
                    <img src="<%= imageUrl %>" alt="Event Image">
                <% } else { %>
                    No Image
                <% } %>
            </td>
            <td><%=action %></td>
        </tr>
        <%
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<tr><td colspan='8' style='color: red;'>Database Error!</td></tr>");
        }
        %>
    </table>
</div>

</body>
</html>
