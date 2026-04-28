<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
String email=  request.getParameter("un");
String password=  request.getParameter("pass");
String wait="Waiting";
String autho="Authorized";


try {
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/event","root", "root");
	
	
	
	
	
	PreparedStatement pst=	 conn.prepareStatement("select status from register where email='"+email+"' and password='"+password+"'  ");
	 ResultSet rs= pst.executeQuery();	 
	
		  HttpSession s = request.getSession();
		   		      s.setAttribute("username", email);
		while (rs.next()) {
    String columnValue = rs.getString("status");  // Get the data from a specific column
    if (autho.equals(columnValue)) {  // Compare with a string (e.g., "someString")
        // Do something if they are equal
        out.println("<script>");
    
    
			out.println("alert('authorized Successfull');");
			out.println("window.location.href='loginpane.html';");
			
			out.println("</script>");
    
    } else {
        // Do something else if they don't match
        out.print("you are not authorized user wait for some time ");
    }
}
        	
        
		}

 catch (Exception e) {
	// TODO: handle exception
	e.printStackTrace();
}





%>
</body>
</html>