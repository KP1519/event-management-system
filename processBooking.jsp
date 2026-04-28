<%@ page import="java.sql.*, java.io.*, java.text.SimpleDateFormat, java.util.Date" %>
<%
    String eventid = request.getParameter("id");
    String eventdate = request.getParameter("date");
    String eventlocation = request.getParameter("location");
    String numberOfAttendees = request.getParameter("attendees");
    String imageUrl = request.getParameter("image"); // Retrieve image URL
    HttpSession s = request.getSession();
    String email = (String) s.getAttribute("username");

    Connection conn = null;
    PreparedStatement checkExistingBooking = null;
    PreparedStatement pst = null;
    ResultSet existingBookingRs = null;

    try {
        // Validate input
        if (eventid == null || eventdate == null || eventlocation == null || numberOfAttendees == null) {
            throw new Exception("Invalid input. Please fill all fields.");
        }

        int attendees = Integer.parseInt(numberOfAttendees);

        // Convert event date to a proper format
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        java.util.Date eventBookingDate = sdf.parse(eventdate);

        // Get today's date without time (only YYYY-MM-DD format)
        java.util.Date today = new java.util.Date();
        String todayStr = sdf.format(today);
        java.util.Date todayDate = sdf.parse(todayStr); // Convert back to Date for comparison

        // ❌ If event date is in the past, throw an error
        if (eventBookingDate.before(todayDate)) {
            throw new Exception("Invalid Date! You cannot book an event for a past date.");
        }

        // Database connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/event", "root", "root");

        // Step 1: Check if any booking already exists for this date, 1 day before, or 2 days before at the same location
        checkExistingBooking = conn.prepareStatement(
            "SELECT COUNT(*) AS totalBookings FROM bookevent WHERE eventlocation = ? " +
            "AND (eventdate = ? OR eventdate = DATE_SUB(?, INTERVAL 1 DAY) OR eventdate = DATE_SUB(?, INTERVAL 2 DAY))"
        );
        checkExistingBooking.setString(1, eventlocation);
        checkExistingBooking.setString(2, eventdate);
        checkExistingBooking.setString(3, eventdate);
        checkExistingBooking.setString(4, eventdate);
        existingBookingRs = checkExistingBooking.executeQuery();

        if (existingBookingRs.next() && existingBookingRs.getInt("totalBookings") > 0) {
            throw new Exception("Booking unavailable! An event is already booked at this location on this date or the two previous days.");
        }

        // Step 2: Insert new booking into bookevent table
        pst = conn.prepareStatement("INSERT INTO bookevent(eventid, eventdate, eventlocation, NumberOfAttendees, email, image, status) VALUES (?, ?, ?, ?, ?, ?, ?)");
        pst.setInt(1, Integer.parseInt(eventid));
        pst.setString(2, eventdate);
        pst.setString(3, eventlocation);
        pst.setInt(4, attendees);
        pst.setString(5, email);
        pst.setString(6, imageUrl); // Insert image URL
        pst.setString(7, "pending");

        int i = pst.executeUpdate();
        if (i == 1) {
            response.sendRedirect("payment.html");
        } else {
            throw new Exception("Booking failed. Please try again.");
        }

    } catch (NumberFormatException e) {
        out.println("<script>alert('Invalid number format.'); window.history.back();</script>");
    } catch (Exception e) {
        out.println("<script>alert('" + e.getMessage() + "'); window.history.back();</script>");
    } finally {
        if (conn != null) conn.close();
        if (pst != null) pst.close();
        if (checkExistingBooking != null) checkExistingBooking.close();
        if (existingBookingRs != null) existingBookingRs.close();
    }
%>
