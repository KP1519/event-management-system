<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User Profile</title>

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


.profile-container {
    background: white;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    width: 350px;
    text-align: center;
}

.profile-pic {
    width: 100px;
    height: 100px;
    border-radius: 50%;
    object-fit: cover;
    margin-bottom: 10px;
    border: 3px  solid  #d4a762 ;
}

h2 {
    margin-bottom: 10px;
    color: #333;
}

.user-info {
    text-align: left;
    margin-top: 10px;
}

.user-info p {
    margin: 10px 0;
    font-size: 14px;
    padding: 10px;
    background: buttonhighlight;
    border-radius: 5px;
    font-weight: bold;
}

.user-info span {
    font-weight: normal;
    float: right;
    color: #555;
}

.button-container {
    margin-top: 20px;
}

button {
    background-color: #d4a762;
    color: white;
    border: none;
    padding: 10px 15px;
    font-size: 16px;
    border-radius: 5px;
    cursor: pointer;
}

button:hover {
    background-color: black;
}
.update-btn{
 background-color: #d4a762;
    color: white;
    border: none;
    gap:10px;
    padding: 10px 15px;
    font-size: 16px;
    border-radius: 5px;
    cursor: pointer;
}
.update-btn:hover {
 background-color:black;
}

.logout-btn {
    background-color: #d4a762;
    color: white;
   
    padding: 10px;
    font-size: 14px;
    margin-top: 10px;
    width: 100%;
}

.logout-btn:hover {
    background-color: black;
}
.profile-container {
           
            border-radius: 10px;
            box-shadow: 0px 0px 10px #d4a762;
           
        }
</style>

</head>
<body>

<%
    // Get username from session
    String username = (String) session.getAttribute("username");

    if (username == null) {
        out.println("<h3 style='text-align:center;'>No user logged in.</h3>");
        return;
    }

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/event", "root", "root");
        PreparedStatement pst = conn.prepareStatement("SELECT * FROM register WHERE email = ?");
        pst.setString(1, username);
        ResultSet rs = pst.executeQuery();

        if (rs.next()) {
            String profileImage = rs.getString("profile"); // Get profile image filename
            String imagePath = (profileImage != null && !profileImage.isEmpty()) ? "img/" + profileImage : "default-profile.png";
%>

<div class="profile-container">
    <img src="<%= imagePath %>" alt="Profile Picture" class="profile-pic">
    <h2><%= rs.getString("firstname") %> <%= rs.getString("lastname") %></h2>

    <div class="user-info">
        <p>Email: <span><%= rs.getString("email") %></span></p>
        <p>Phone: <span><%= rs.getString("mobile") %></span></p>
        <p>DOB: <span><%= rs.getString("dob") %></span></p>
        <p>Location: <span><%= rs.getString("loc") %></span></p>
        <p>Pincode: <span><%= rs.getString("pincode") %></span></p>
    </div>

    <div class="button-container">
        <button onclick="window.location.href='customerdashboard.jsp'">Back</button>
        <button class="update-btn" onclick="window.location.href='profileupdate.jsp'">update</button>
        <button class="logout-btn" onclick="window.location.href='Login.html'">Logout</button>
    </div>
</div>

<%
        } else {
            out.println("<h3 style='text-align:center;'>User not found.</h3>");
        }
        rs.close();
        pst.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

</body>
</html>
