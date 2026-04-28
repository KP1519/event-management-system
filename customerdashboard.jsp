<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Menu</title>
    <style>
       
            body {
  
   background-color:#d4a762;
   
}
       
       

       .header {
           width: 100%;
           background: buttonhighlight;
           color: black;
           padding: 3px 20px;
           position: fixed;
           top: 0;
           left: 0;
           display: flex;
           justify-content: space-between;
           align-items: center;
           box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
           z-index: 1000;
       }

       .container {
           display: flex;
           margin-top: 100px;
           justify-content: center;
       }

       .sidebar {
           width: 320px;
           padding: 20px;
           background: white;
           border: solid 2px rgba(212, 167, 98, 1);
           border-radius: 10px;
           box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
           position: relative;
           left: 0;
           top: 20px;
           height: auto;
           text-align: center;
       }
       .sidebar {
    margin-top: 50px; /* Adjust this value to move it further down */
}
       

       .sidebar h2 {
           text-align: center;
           font-size: 25px;
           font-weight: bold;
           text-transform: uppercase;
           text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
           color: black;
       }

       .menu {
           list-style: none;
           padding: 0;
           margin: 0;
       }

       .menu li {
           margin: 12px 0;
       }

       .menu a {
           text-decoration: none;
           color: Black;
           padding: 15px;
           display: block;
           font-size: 18px;
           text-align: center;
           background: rgba(212, 167, 98, 1);
           border: 2px solid rgba(212, 167, 98, 1);
           border-radius: 8px;
           transition: 0.3s;
           font-weight: bold;
       }

       .menu a:hover {
           background: white;
           color: rgba(212, 167, 98, 1);
           border-color: rgba(212, 167, 98, 1);
       }

       .main-content {
           flex: 1;
           padding: 20px;
           margin-left: 20px;
       }
        .avatar{  overflow:hidden;   }

.user-icon{
  font-size:0.5em;  /* change font size should change size of icon */
  float:left; margin:1em;  /* remove this line to avoid float/margin */
}
.user-icon{
  border-radius:4em; border:1px solid skyblue;
  height:6em; width:6em;  
  background:none;padding:0.1em;  
}

.user-icon::before{
  content:" "; display:block;
  height:2em; width:2em;
  background:skyblue;
  position:relative; left:2em;top:0.8em;
  border-radius:2em;
}
       .user-icon::after{
  content:" "; display:block;
  height:2em;width:4em;
  background:skyblue;
  position:relative; left:1em;top:1em;
  border-radius:2em 2em 0 0;
}
       

       .logout-btn {
           background: black;
           color: white;
           padding: 10px 50px;
           border: none;
           border-radius: 5px;
           text-decoration: none;
           font-size: 16px;
           cursor: pointer;
       }
         .slideshow-container {
            position: absolute;
            top: 60%;
            left: 60%;
            transform: translate(-50%, -50%);
            width: 75vw;
            height: 77vh;
            overflow: hidden;
            border-radius: 10px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .slides {
            display: none;
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 10px;
        }
    </style>
</head>
<body>
     <% 
        HttpSession httpSession = request.getSession(); 
        String username = (String) httpSession.getAttribute("username"); 
    %>

    <!-- Header Section -->
    <div class="header">
        <h1><i>eventsmarket</i> <br> 
           <marquee> <span style="color: border-color: ;">Welcome</span> 
            <span style="color: black;"><%= username %></span></marquee>
        </h1>
         
        
        <h2>Welcome to the Customer Dashboard</h2>
        <a href="viewcustomerprofile.jsp">
        
        <div class="avatar">
  <div class="user-icon"><span></span>
  </div>
</div>
        
        
        </a>
                     <a href="home.html" class="logout-btn">Logout</a>

    </div>

    <div class="container">
        <div class="sidebar">
            <h2>DASHBOARD</h2>
            <ul class="menu">
                <li><a href="viewevent.jsp">view&book</a></li>
             
                <li><a href="customerbooking.jsp">View Bookings / Cancel Event</a></li>
                <li><a href="viewnotification.jsp">View Notifications</a></li>
                <li><a href="sendquery.jsp">Send Query</a></li>
                <li><a href="viewresponse.jsp">View Response</a></li>
                <li><a href="feedback.jsp">Feedback</a></li>
            </ul>
        </div>
        <div class="main-content">
        </div>
    </div>
     <div class="slideshow-container">
            <img class="slides" src="img/hd1.jpg" alt="Slide 1">
            <img class="slides" src="img/hd2.jpg" alt="Slide 2">
            
               <img class="slides" src="img/hd5.jpg" alt="Slide 3">
        </div>
          <script>
        let slideIndex = 0;
        function showSlides() {
            let slides = document.getElementsByClassName("slides");
            for (let i = 0; i < slides.length; i++) {
                slides[i].style.display = "none";
            }
            slideIndex++;
            if (slideIndex > slides.length) { slideIndex = 1; }
            slides[slideIndex - 1].style.display = "block";
            setTimeout(showSlides, 3000); // Change image every 3 seconds
        }
        showSlides();
    </script>
</body>
</html>
