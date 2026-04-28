<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Booking Details</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #d4a762;
            margin: 0;
            padding: 0;
        }
        .header {
            background: buttonhighlight;
            color: black;
            padding: 30px;
            text-align: center;
            font-size: 20px;
            position: relative;
        }
        .back-btn {
            position: absolute;
            left: 20px;
            top: 50%;
            transform: translateY(-50%);
            background: black;
            color: white;
            padding: 8px 15px;
            border-radius: 5px;
            text-decoration: none;
            font-weight: bold;
        }
        .back-btn:hover {
            background: gray;
        }
        .container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 60px;
            padding: 20px;
            max-width: 1600px;
            margin: auto;
        }
        .booking-card {
            background: #fff;
            padding: 15px;
            margin: 15px 0;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        .booking-card img {
            width: 100%;
            height: 200px;
            background-size: cover;
            background-position: center;
            border-radius: 10px;
            margin-bottom: 15px;
        }
        .cancel-btn {
            display: inline-block;
            background: black;
            color: white;
            padding: 8px 15px;
            border-radius: 5px;
            text-decoration: none;
            font-weight: bold;
        }
        .cancel-btn:hover {
            background: darkred;
        }
    </style>
</head>
<body>

<div class="header">
    <a class="back-btn" href="customerdashboard.jsp">Back</a>
    Booking Details
</div>

<div class="container">
<%@ page import="java.sql.*, java.text.SimpleDateFormat, java.util.Date" %>
<%
    // Get username from session
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.html"); // Redirect if not logged in
        return;
    }

    // Get today's date in YYYY-MM-DD format
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    String todayStr = sdf.format(new Date());

    try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/event", "root", "root")) {
        
        // Step 1: Update status of past events to "Completed"
        PreparedStatement updateStatusPst = conn.prepareStatement(
            "UPDATE bookevent SET status = 'Completed' WHERE eventdate < ? AND status != 'Cancelled' AND status != 'Completed'"
        );
        updateStatusPst.setString(1, todayStr);
        updateStatusPst.executeUpdate();

        // Step 2: Retrieve booking details
        PreparedStatement pst = conn.prepareStatement("SELECT * FROM bookevent WHERE email = ?");
        pst.setString(1, username);
        try (ResultSet rs = pst.executeQuery()) {
            while (rs.next()) {
                int bookingid = rs.getInt("bookingid");
                int eventid = rs.getInt("eventid");
                String eventdate = rs.getString("eventdate");
                String eventlocation = rs.getString("eventlocation");
                int NumberOfAttendees = rs.getInt("NumberOfAttendees");
                String email = rs.getString("email");
                String image = rs.getString("image");
                String status = rs.getString("status");
%>
    <div class="booking-card">
        <h3>Booking ID: <%= bookingid %></h3>
        <img src="<%= image %>" alt="Event Image">
        <p><strong>Event ID:</strong> <%= eventid %></p>
        <p><strong>Event Date:</strong> <%= eventdate %></p>
        <p><strong>Location:</strong> <%= eventlocation %></p>
        <p><strong>Number of Attendees:</strong> <%= NumberOfAttendees %></p>
        <p><strong>Email:</strong> <%= email %></p>
        <p><strong>Status:</strong> <%= status %></p>
        <% if (status.equalsIgnoreCase("Completed")) { %>
            <span style="color: green;">Event Completed</span>
        <% } else if (!status.equalsIgnoreCase("Cancelled")) { %>
            <a class="cancel-btn" href="updatecancelevent.jsp?bookingid=<%= bookingid %>">Cancel</a>
        <% } else { %>
            <span style="color: gray;">Cancelled</span>
        <% } %>
    </div>
<%
            }
        }
    } catch (Exception e) {
        out.println("<p style='color:red;'>Something went wrong. Please try again later.</p>");
        e.printStackTrace();
    }
%>
</div>

</body>
</html>
