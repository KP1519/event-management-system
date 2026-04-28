



<%
    // Get parameters safely
    String eventid = request.getParameter("id");
    String eventname = request.getParameter("name");
    String eventlocation = request.getParameter("location");
    String imageurl = request.getParameter("image");
    HttpSession s = request.getSession();
    String email = (String) s.getAttribute("username");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Event</title>
    <style>
   
body {
  margin: 0;
  min-height: 100vh;
  display: grid;
  place-content: center;
  background:#d4a762;
}


body {
  margin: 0;
  min-height: 100vh;
  display: grid;
  place-content: center;
  background: #aabbfb;
}
        body {
            font-family: Arial, sans-serif;
            background-color: #d4a762;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        
        .container {
            display: flex;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 600px;
            max-width: 90%;
            align-items: center;
        }

        .image-container {
            flex: 1;
            padding-right: 20px;
        }

        .image-container img {
            width: 100%;
            height: auto;
            border-radius: 8px;
        }

        .form-container {
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        h2 {
            margin-bottom: 20px;
            color: #333;
            text-align: center;
        }

        form {
            display: flex;
            flex-direction: column;
        }

        label {
            font-weight: bold;
            margin-top: 10px;
        }

        input {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        button {
            width: 100%;
            margin-top: 15px;
            padding: 10px;
            background:  #d4a762;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }

        button:hover {
            background: #218838;
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 10px;
            color: #007bff;
            text-decoration: none;
        }

        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>


<div class="container">
    <!-- ✅ Image Section -->
    <div class="image-container">
        <% if (imageurl != null && !imageurl.isEmpty()) { %>
            <img src="<%= imageurl %>" alt="Event Image">
        <% } %>
    </div>

    <!-- ✅ Form Section -->
    <div class="form-container">
        <h2>Book Event</h2>
       <form action="processBooking.jsp" method="post">
    <label for="event-id">Event Id:</label>
    <input type="text" id="event-id" name="id" value="<%= eventid != null ? eventid : "" %>" readonly>

    <label for="event-name">Event Name:</label>
    <input type="text" id="event-name" name="eventname" value="<%= eventname != null ? eventname : "" %>" readonly>

    <label for="event-location">Location:</label>
    <input type="text" id="event-location" name="location" value="<%= eventlocation != null ? eventlocation : "" %>" readonly>

    <label for="event-date">Event Date:</label>
    <input type="date" id="event-date" name="date" required>

    <label for="attendees">Attendees:</label>
    <input type="number" id="attendees" name="attendees" min="1" required>

    <label for="email">Registered Email:</label>
  <input type="email" id="email" name="email" value="<%= email != null ? email : "" %>" readonly>


    <!-- ✅ Hidden field to pass image URL -->
    <input type="hidden" name="image" value="<%= imageurl %>">

    <button type="submit">Book Event</button>
    <a href="viewevent.jsp" class="back-link">Back</a>
</form>

        
    </div>
</div>

</body>
</html>
