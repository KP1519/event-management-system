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
          background:buttonhighlight;
            margin: 0;
            padding: 0;
        }
         .header {
         background: linear-gradient(to right, #d4a762, #f5c885);

            color:black;
            padding: 30px;
            text-align: center;
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
            width: 90%;
            margin: 80px auto;
            padding: 20px;
            background: white;
              border-radius: 8px;
    box-shadow: 0px 0px 40px #d4a762;
            text-align: left;
              border: 3px solid #d4a762;
        }
        h2 {
            color:black;
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
             border-radius: 10px;
  overflow: hidden;
        }
        th, td {
            padding: 12px;
            border: 1px solid #d4a762;
            text-align: center;
        }
        th {
            background-color: #d4a762;
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
  background: #d4a762;
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
   
        function searchQuery() {
            let input = document.getElementById("searchInput").value.toLowerCase();
            let rows = document.querySelectorAll("#queryTable tr");

            rows.forEach((row, index) => {
                if (index === 0) return; // Skip table header

                let email = row.cells[1].textContent.toLowerCase();
                let query = row.cells[2].textContent.toLowerCase();

                if (email.includes(input) || query.includes(input)) {
                    row.style.display = "";
                } else {
                    row.style.display = "none";
                }
            });
        }
    </script>
</head>
<body>
 <div class="header">
        <% 
            String username = (String) session.getAttribute("username"); 
            if (username != null) { 
        %>
           <marquee>Welcome, <%= username %>!</marquee>
        <% } else { %>
            <div class="marquee">Welcome, Admin!</div>
        <% } %>
    </div>
<div class="container">
      <a href='admindashboard.jsp' class='back'>back</a>
    <h2>FEEDBACK</h2>
     <div class="search-container">
    <input type="text" id="searchInput" onkeyup="searchQuery()" placeholder="🔍 Search by email...">
</div>
 
    <table id="queryTable">
        <tr>
            <th>ID</th>
           
            <th>Email</th>
            
            <th>Feedback</th>
        </tr>
        <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/event", "root", "root");
            PreparedStatement pst = conn.prepareStatement("select * from feedback");
            ResultSet rs = pst.executeQuery();
            
            while (rs.next()) {
                int id = rs.getInt("id");
               
                String email = rs.getString("email");
              
                String feedback = rs.getString("feedback");
        %>
        <tr>
            <td><%= id %></td>
            
            <td><%= email %></td>
           
            <td><%= feedback %></td>
          
          
         
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