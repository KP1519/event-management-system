<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Queries</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: buttonhighlight;
            margin: 0;
            padding: 0;
        }

        /* Header Styling */
        .header {
            background: linear-gradient(to right, #d4a762, #f5c885);
            color: black;
            padding: 20px;
            text-align: center;
            font-size: 18px;
            font-weight: bold;
            text-align: left;
        }

        .container {
            width: 80%;
            margin: 100px auto;
            padding: 20px;
            background: white;
            border-radius: 10px;
            box-shadow: 0px 0px 40px #d4a762;
            text-align: left;
              border: 3px solid #d4a762;
        }

        h2 {
            color: white;
            text-align: center;
        }

        /* Search Bar Styling */
        .search-container {
            display: flex;
            align-items: center;
            gap: 5px;
            margin-bottom: 20px;
            color: black;
        }

        .search-icon {
            font-size: 18px;
            color: #d4a762;
        }

        .search-container input {
            width: 20%;
            padding: 10px;
            border: 1px solid #d4a762;
            border-radius: 5px;
            font-size: 14px;
            background: white;
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

        input[type="text"] {
            width: 90%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        button {
            padding: 8px 15px;
            border: none;
            background-color: #d4a762;
            color: white;
            border-radius: 5px;
            cursor: pointer;
        }

        button:hover {
            background-color: #0056b3;
        }

        .back {
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

    <!-- Header Section with Scrolling Username -->
    <div class="header">
     <a href="admindashboard.jsp" class='back'>Back</a>
        <h2>QUERIES</h2>
       
    </div>

    <div class="container">
       

        <!-- Search Bar -->
        <div class="search-container">
            <span class="search-icon">🔍</span>
            <input type="text" id="searchInput" onkeyup="searchQuery()" placeholder="Search by email or query...">
        </div>

        <table id="queryTable">
            <tr>
                <th>ID</th>
                <th>Email</th>
                <th>Query</th>
                <th>Response</th>
                <th>Action</th>
            </tr>
            <%
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/event", "root", "root");
                    PreparedStatement pst = conn.prepareStatement("SELECT * FROM query");
                    ResultSet rs = pst.executeQuery();

                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String email = rs.getString("email");
                        String query = rs.getString("query");
                        String responses = rs.getString("responses"); // Assuming "responses" column exists
            %>
            <tr>
                <td><%= id %></td>
                <td><%= email %></td>
                <td><%= query %></td>
                <td>
                    <form action="updateResponse.jsp" method="post">
                        <input type="hidden" name="eventid" value="<%= id %>">
                        <input type="hidden" name="email" value="<%= email %>">
                        <input type="hidden" name="query" value="<%= query %>">
                        <input type="text" name="responses" value="<%= responses != null ? responses : "" %>" placeholder="Enter response">
                </td>
                <td>
                        <button type="submit">Submit</button>
                    </form>
                </td>
            </tr>
            <%
                    }
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<tr><td colspan='5' style='color: red;'>Database Error!</td></tr>");
                }
            %>
        </table>
    </div>

</body>
</html>
