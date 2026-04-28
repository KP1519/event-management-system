<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Event Booking</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
            body {
   
   background-color:#d4a762;
    background-size: cover; /* Ensures the image covers the screen */
    background-position: left center; /* Aligns image correctly with sidebar */
    background-attachment: fixed; /* Keeps image fixed when scrolling */
    background-repeat: no-repeat; /* Prevent repeating */
}


        /* 🔹 Header Styling */
        .header {
            background-color: buttonhighlight; /* Dark background */
            color: white;
            padding: 15px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 1000;
        }
        .header h1 {
            font-size: 24px;
            margin: 0;
            text-transform: uppercase;
        }
        .header .welcome {
            font-size: 25px;
            color: black;
        }
        .header .user-section {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .user-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: skyblue;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 20px;
            font-weight: bold;
            color: white;
        }
        .logout-btn {
            background:gray;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            font-size: 16px;
            cursor: pointer;
            transition: 0.3s ease;
        }
        .logout-btn:hover {
            background: darkred;
        }
 .search-container {
            text-align: center;
            margin: 20px 0;
        }
        .search-container input {
            width: 40%;
            padding: 10px;
            border: 2px solid #d4a762;
            border-radius: 5px;
            font-size: 16px;
        }
        /* 🔹 Event Section */
        .event-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 60px;
            padding: 20px;
            max-width: 1600px;
            margin: auto;
        }
        .event-card {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            text-align: center;
            width: 300px;
            display: flex;
            flex-direction: column;
            align-items: center;
            transition: transform 0.3s ease;
        }
        .event-card:hover {
            transform: scale(1.05);
        }
        .event-image {
            width: 100%;
            height: 200px;
            background-size: cover;
            background-position: center;
            border-radius: 10px;
            margin-bottom: 15px;
        }
        .event-details {
            text-align: left;
            width: 100%;
            flex-grow: 1;
        }
        .book-now {
            background: #d4a762;
            color: white;
            border: none;
            padding: 10px;
            width: 100%;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: background 0.3s ease;
            margin-top: auto;
        }
        .book-now:hover {
            background: #b58b4c;
        }
       
  .header .user-section {
    display: flex;
    align-items: center;
    gap: 15px;
}

.user-icon {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 50px;
    height: 50px;
    border-radius: 50%;
    background-color: skyblue;
    color: white;
    font-size: 20px;
    font-weight: bold;
    border: 2px solid white;
}

.logout-btn {
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

.logout-btn:hover {
    background: darkgray;
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
      <script>
        function searchEvents() {
            let input = document.getElementById("searchInput").value.toLowerCase();
            let eventCards = document.querySelectorAll(".event-card");

            eventCards.forEach((card) => {
                let eventName = card.querySelector("h2").textContent.toLowerCase();
                let location = card.querySelector(".event-details p:nth-child(1)").textContent.toLowerCase();
                let capacity = card.querySelector(".event-details p:nth-child(2)").textContent.toLowerCase();
                let organizer = card.querySelector(".event-details p:nth-child(4)").textContent.toLowerCase();

                if (eventName.includes(input) || location.includes(input) || capacity.includes(input) || organizer.includes(input)) {
                    card.style.display = "";
                } else {
                    card.style.display = "none";
                }
            });
        }
    </script>
</head>
<body>

<%
    String username = (String) session.getAttribute("username");
    if (username == null) username = "Guest";
%>

<!-- 🔹 Header with background color -->
<div class="header">
  <a href='customerdashboard.jsp' class='back'>Back</a>
   
    <div class="welcome">Welcome, <%= username %></div>
    <div class="user-section">
        <a href="viewcustomerprofile.jsp">
            <div class="user-icon">U</div>
        </a>
        <a href="home.html" class="logout-btn">Logout</a>
    </div>
</div>

<h1 style="text-align:center; margin-top: 20px;">Available Events</h1>
<div class="search-container">
    <input type="text" id="searchInput" onkeyup="searchEvents()" placeholder="🔍 Search by Event Name, Location...">
</div>

<div class="event-container">
    <%
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/event", "root", "root");
            pst = conn.prepareStatement("SELECT * FROM createevent ORDER BY eventid DESC");
            rs = pst.executeQuery();

            boolean hasEvents = false;
            while (rs.next()) {
                hasEvents = true;
                int eventid = rs.getInt("eventid");
                String eventname = rs.getString("eventname");
                String eventlocation = rs.getString("eventlocation");
                String organizername = rs.getString("organizername");
                long mobile = rs.getLong("mobile");
                int capacity = rs.getInt("capacity");
                int applicationfee = rs.getInt("applicationfee");
                String imageurl = rs.getString("image");
    %>

    <div class="event-card">
        <h2><%= eventname %></h2>
        <div class="event-image" style="background-image: url('<%= imageurl %>');"></div>
        <div class="event-details">
            <p><strong>Event ID:</strong> <%= eventid %></p>
            <p><strong>Location:</strong> <%= eventlocation %></p>
            <p><strong>Capacity:</strong> <%= capacity %> people</p>
            <p><strong>Fee:</strong> $<%= applicationfee %></p>
            <p><strong>Contact:</strong></p>
            <p>Organizer: <%= organizername %></p>
            <p>Mobile: <%= mobile %></p>
        </div>
    <a href="bookevent.jsp?id=<%= eventid %>&name=<%= eventname %>&location=<%= eventlocation %>&image=<%= imageurl %>" class="book-now">Book Now</a>

    </div>

    <%
            }
            if (!hasEvents) {
                out.println("<p>No events found.</p>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p style='color: red;'>Database Error!</p>");
        } 
    %>
</div>

</body>
</html>
