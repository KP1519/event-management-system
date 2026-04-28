<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="java.sql.*, java.text.SimpleDateFormat, java.util.Date" %>

<%
    // Get the booking ID from the request
    String bookingIdParam = request.getParameter("bookingid");

    if (bookingIdParam == null || bookingIdParam.trim().isEmpty()) {
        out.println("<script>alert('Error: Booking ID is missing or invalid.'); window.history.back();</script>");
        return;
    }

    int bookingid = Integer.parseInt(bookingIdParam);

    try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/event", "root", "root")) {
        // Check event date before allowing cancellation
        PreparedStatement checkDatePst = conn.prepareStatement("SELECT eventdate FROM bookevent WHERE bookingid = ?");
        checkDatePst.setInt(1, bookingid);
        ResultSet rs = checkDatePst.executeQuery();
        
        if (rs.next()) {
            String eventDateStr = rs.getString("eventdate");
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date eventDate = sdf.parse(eventDateStr);
            Date currentDate = new Date();
            
            long diffInMillies = eventDate.getTime() - currentDate.getTime();
            long daysDifference = diffInMillies / (1000 * 60 * 60 * 24);
            
            if (daysDifference < 4) {
                out.println("<script>");
                out.println("alert('Cancellation is only allowed at least 4 days before the event date.');");
                out.println("window.location.href='customerbooking.jsp';");
                out.println("</script>");
            } else {
                // Proceed with cancellation (update status instead of delete)
                PreparedStatement pst = conn.prepareStatement("UPDATE bookevent SET status = 'Cancelled' WHERE bookingid = ?");
                pst.setInt(1, bookingid);
                int rowsAffected = pst.executeUpdate();
                
                if (rowsAffected > 0) {
                    out.println("<script>");
                    out.println("alert('Event cancelled successfully.');");
                    out.println("window.location.href='customerbooking.jsp';");
                    out.println("</script>");
                } else {
                    response.sendRedirect("customerbooking.jsp?msg=Error+Cancelling+Event");
                }
            }
        } else {
            response.sendRedirect("customerbooking.jsp?msg=Booking+ID+not+found");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("customerbooking.jsp?msg=Error+Cancelling+Event");
    }
%>
