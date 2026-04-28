<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Users</title>

    <style>
        body {
            font-family: Arial, sans-serif;
          
            padding: 0;
        }
         .header {
         background: linear-gradient(to right, #d4a762, #f5c885);

            color:black;
            padding: 20px;
            text-align: left;
            font-size: 18px;
            font-weight: bold;
            position: relative;
        }
           .search-container {
    text-align: left;
    margin-bottom: 20px;
    color: black;
}

.search-container input {
    width: 20%;
    padding: 10px;
    border: 1px solid #d4a762;
    border-radius: 5px;
    font-size: 14px;
    background: white;
}
        
        .container {
            width: 80%;
            margin: 30px auto;
            padding: 20px;
            background: white;
           border-radius: 10px;
            box-shadow: 0px 0px 40px #d4a762;
            text-align: center;
              border: 3px solid #d4a762;
        }
        h2 {
            color:white;
            text-align: center;
        }
        table {
            width: 100%;
              border: 2px solid #d4a762;
           
            margin-top: 20px;
             border-radius: 10px;
  overflow: hidden;
        }
        th, td {
            padding: 12px;
            border: 1px solid  #d4a762;
            text-align: center;
        }
        th {
            background-color: #d4a762 ;
            color: white;
             
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        img {
            width: 80px;
            height: 80px;
            border-radius: 5px;
        }
        .back{
  background: white;
    color: black;
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
function searchQuery() {
    let input = document.getElementById("searchInput").value.toLowerCase();
    let table = document.getElementById("userTable");
    let rows = table.getElementsByTagName("tr");

    for (let i = 1; i < rows.length; i++) { // Skip header row
        let cells = rows[i].getElementsByTagName("td");

        // Columns to include in search: Event ID (1), Event Date (2), Event Location (3), Email (5), Status (6)
        let eventID = cells[1].textContent.toLowerCase();
        let eventDate = cells[2].textContent.toLowerCase();
        let eventLocation = cells[3].textContent.toLowerCase();
        let email = cells[5].textContent.toLowerCase();
        let status = cells[6].textContent.toLowerCase();

        if (eventID.includes(input) || eventDate.includes(input) || eventLocation.includes(input) || email.includes(input) || status.includes(input)) {
            rows[i].style.display = ""; // Show row
        } else {
            rows[i].style.display = "none"; // Hide row
        }
    }
}
</script>
</head>
<body>
<div class="header">
      <a href='admindashboard.jsp' class='back'>back</a>
    <h2>Customer Bookings</h2>
    </div>

<div class="container">
   
    <div class="search-container">
    <input type="text" id="searchInput" onkeyup="searchQuery()" placeholder="🔍 Search by email or name...">
</div>
 
    <table id="userTable">
        <tr>
         <th>bookingid</th>
            <th>eventid</th>
            <th>eventdate</th>
            <th>eventlocation</th>
            <th>NumberOfAttendees</th>
            <th>email</th>
            <th>status</th>
          
        </tr>
        <%
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/event", "root", "root");
            PreparedStatement pst = conn.prepareStatement("select * from bookevent");
            ResultSet rs = pst.executeQuery();
            
            while (rs.next()) {  
            	int bookingid = rs.getInt("bookingid");
            	
                int eventid = rs.getInt("eventid");
                String eventdate = rs.getString("eventdate");
                String eventlocation = rs.getString("eventlocation");
         int NumberOfAttendees= rs.getInt("NumberOfAttendees");
                String email = rs.getString("email");
                
                String status = rs.getString("status");
        %>
        <tr>
         <td><%= bookingid %></td>
            <td><%= eventid %></td>
            <td><%= eventdate %></td>
            <td><%= eventlocation %></td>
            <td><%= NumberOfAttendees %></td>
            <td><%= email %></td>
           
           <td> <a href="action.jsp?id=<%= bookingid %>"><%= status %></a></td>

          
         
        </tr>
       
        
        <%
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<tr><td colspan='11' style='color: red;'>Database Error!</td></tr>");
        }
        %>
       
    </table>
    
</div>

</body>
</html>