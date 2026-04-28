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
          
            margin: 0;
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
            width: 90%;
            margin: 30px auto;
            padding: 20px;
           
            background: white;
            border-radius: 10px;
            box-shadow: 0px 0px 40px #d4a762;
            text-align: left;
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
        let rows = document.querySelectorAll("#userTable tr");

        rows.forEach((row, index) => {
            if (index === 0) return; // Skip table header

            let firstName = row.cells[1].textContent.toLowerCase();
            let lastName = row.cells[2].textContent.toLowerCase();
            let email = row.cells[3].textContent.toLowerCase();

            if (firstName.includes(input) || lastName.includes(input) || email.includes(input)) {
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
      <a href='admindashboard.jsp' class='back'>back</a>
    <h2>Customer Information</h2>
    </div>

<div class="container">
 <div class="search-container">
    <input type="text" id="searchInput" onkeyup="searchQuery()" placeholder="🔍 Search by email or name...">
</div>
 
    <table id="userTable">

        <tr>
            <th>ID</th>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Email</th>
            <th>Password</th>
            <th>DOB</th>
            <th>Mobile</th>
            <th>Gender</th>
            <th>Location</th>
            <th>Pincode</th>
            <th>Profile</th>
            <th>Status</th>
        </tr>
        <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/event", "root", "root");
            PreparedStatement pst = conn.prepareStatement("select * from register");
            ResultSet rs = pst.executeQuery();
            
            while (rs.next()) {
                int id = rs.getInt("id");
                String firstname = rs.getString("firstname");
                String lastname = rs.getString("lastname");
                String email = rs.getString("email");
                String password = rs.getString("password");
                String DOB = rs.getString("DOB");
                Long mobile = rs.getLong("mobile");
                String gender = rs.getString("gender");
                String Loc = rs.getString("Loc");
                String Pincode = rs.getString("Pincode");
                String profile = rs.getString("profile");
                String status = rs.getString("status");
        %>
        <tr>
            <td><%= id %></td>
            <td><%= firstname %></td>
            <td><%= lastname %></td>
            <td><%= email %></td>
            <td><%= password %></td>
            <td><%= DOB %></td>
            <td><%= mobile %></td>
            <td><%= gender %></td>
            <td><%= Loc %></td>
            <td><%= Pincode %></td>
           <td><img src="img/<%= profile %>" alt="Profile Picture" width="200px" height="200px"></td>
            <td> <a href="status.html" ><%= status %></a></td>
          
         
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