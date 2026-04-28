<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<%
  
//  HttpSession hs= request.getSession();
// String otp=(String)   hs.getAttribute("GenerateOtp");
 String otp=  request.getParameter("number");
    
 try{
	 Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
		Connection conn=	DriverManager.getConnection("jdbc:mysql://localhost:3306/event","root","root");
	PreparedStatement pst=	conn.prepareStatement("select *from register where otp='"+otp+"'");	
		 
 ResultSet rs=	pst.executeQuery();
	 
      if(rs.next()){
    	  out.println("<script>");
 			out.println("alert('OTP verified sucessful');");
 			out.println("window.location.href='customerdashboard.jsp';");
 			out.println("</script>");
    	 // response.sendRedirect("parentpane.html");
      }
      else{
    	  out.println("<script>");
 			out.println("alert('Invalid OTP');");
 			out.println("window.location.href='verifyotp.jsp';");
 			out.println("</script>");
      }
 
 
 }
 catch(Exception e)
 {
	 e.printStackTrace();
 }
 
 

%>
   
     
</body>
</html>