<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.servlet.RequestDispatcher"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>User Status Verification</title>
</head>
<body>
    <center>
        <br><br>
        <h1>User Status Verification</h1>

        <%
            String bookingid = request.getParameter("id");

            if (bookingid != null) {
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/event", "root", "root");            
                    
                    String sql = "UPDATE bookevent SET status='Accepted' WHERE bookingid=?";
                    PreparedStatement pst = conn.prepareStatement(sql);
                    pst.setInt(1, Integer.parseInt(bookingid));
                    int i = pst.executeUpdate();
                    
                    // Close resources
                    pst.close();
                    conn.close();

                

                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<p style='color:red;'>Database Error!</p>");
                }
            } else {
                out.println("<p style='color:red;'>Invalid request. No booking ID provided.</p>");
            }
        %>

    </center>
</body>
</html>
