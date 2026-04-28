<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Update Profile</title>

<style>
body {
    font-family: Arial, sans-serif;
    background-color:white;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin: 0;
}
.container {
    background:white;
   
  
    
    padding: 20px;
    border-radius: 10px;
    box-shadow:0 0 35px #d4a762;
    width: 400px;
    text-align: center;
}
input {
    width: 100%;
    
    padding: 10px;
    margin: 5px 0;
    border: 1px solid #ccc;
    border-radius: 5px;
}
label {
    display: block;
    text-align: left;
    margin-top: 10px;
    font-weight: bold;
}
button {
    background-color:  #d4a762;
    color: white;
    border: none;
    padding: 10px 15px;
    font-size: 16px;
    border-radius: 5px;
    cursor: pointer;
    margin-top: 10px;
}
button:hover {
    background-color:black;
}
</style>
</head>
<body>

<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("Login.html");
        return;
    }
    
    String firstName = "", lastName = "", email = "", phone = "", dob = "", location = "", pincode = "";
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/event", "root", "root");
        PreparedStatement pst = conn.prepareStatement("SELECT * FROM register WHERE email = ?");
        pst.setString(1, username);
        ResultSet rs = pst.executeQuery();
        
        if (rs.next()) {
            firstName = rs.getString("firstname");
            lastName = rs.getString("lastname");
            email = rs.getString("email");
            phone = rs.getString("mobile");
            dob = rs.getString("dob");
            location = rs.getString("loc");
            pincode = rs.getString("pincode");
        }
        rs.close();
        pst.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
    
    if (request.getMethod().equals("POST")) {
        firstName = request.getParameter("firstname");
        lastName = request.getParameter("lastname");
        email = request.getParameter("email");
        phone = request.getParameter("phone");
        dob = request.getParameter("dob");
        location = request.getParameter("location");
        pincode = request.getParameter("pincode");
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/event", "root", "root");
            PreparedStatement pst = conn.prepareStatement("UPDATE register SET firstname=?, lastname=?, email=?, mobile=?, dob=?, loc=?, pincode=? WHERE email=?");
            pst.setString(1, firstName);
            pst.setString(2, lastName);
            pst.setString(3, email);
            pst.setString(4, phone);
            pst.setString(5, dob);
            pst.setString(6, location);
            pst.setString(7, pincode);
            pst.setString(8, username);
            pst.executeUpdate();
            conn.close();
            session.setAttribute("username", email); // Update session email
            out.println("<script>alert('Profile updated successfully!'); window.location='viewcustomerprofile.jsp';</script>");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>

<div class="container">
  <button type="submit" onclick="window.location.href='viewcustomerprofile.jsp'">Back</button>
    <h2>Update Profile</h2>
    <form method="POST">
        <label for="firstname">First Name:</label>
        <input type="text" id="firstname" name="firstname" value="<%= firstName %>" required>
        
        <label for="lastname">Last Name:</label>
        <input type="text" id="lastname" name="lastname" value="<%= lastName %>" required>
        
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" value="<%= email %>" required>
        
        <label for="phone">Phone Number:</label>
        <input type="text" id="phone" name="phone" value="<%= phone %>" required>
        
        <label for="dob">Date of Birth:</label>
        <input type="date" id="dob" name="dob" value="<%= dob %>" required>
        
        <label for="location">Location:</label>
        <input type="text" id="location" name="location" value="<%= location %>" required>
        
        <label for="pincode">Pincode:</label>
        <input type="text" id="pincode" name="pincode" value="<%= pincode %>" required>
        
        <button type="submit">Update</button>
      
    </form>
</div>

</body>
</html>