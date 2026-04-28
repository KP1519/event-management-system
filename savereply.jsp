<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<%
    String messageId = request.getParameter("messageId");
    String replyText = request.getParameter("replyText");

    if (messageId != null && replyText != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/event", "root", "root");

            PreparedStatement pst = conn.prepareStatement("UPDATE notification SET answer = ? WHERE id = ?");
            pst.setString(1, replyText);
            pst.setInt(2, Integer.parseInt(messageId));
            int rowsUpdated = pst.executeUpdate();

            conn.close();

            if (rowsUpdated > 0) {
                response.sendRedirect("viewnotification.jsp"); // Redirect back to the notifications page
            } else {
                out.println("Failed to update reply!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("Database Error!");
        }
    } else {
        out.println("Invalid input!");
    }
%>
