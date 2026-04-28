
  <!DOCTYPE html>
  <html lang="en">
  <head>
  <style type="text/css">
  body {
              font-family: Arial, sans-serif;
              display: flex;
              justify-content: center;
              align-items: center;
              height: 100vh;
              margin: 0;
              background-color:white;
              color: #e0e0e0;
          }
          .container {
              background-color:silver;
              padding: 2rem;
              border-radius: 15px;
              box-shadow: 0 4px 6px rgba(0, 0, 0, 0.3);
              text-align: center;
          }
          h1 {
              margin-bottom: 1rem;
              color: #ffffff;
          }
          .otp-input {
              display: flex;
              justify-content: center;
              margin-bottom: 1rem;
          }
          .otp-input input {
              width: 40px;
              height: 40px;
              margin: 0 5px;
              text-align: center;
              font-size: 1.2rem;
              border: 1px solid #444;
              border-radius: 4px;
              background-color: silver;
              color: silver;
          }
          .otp-input input::-webkit-outer-spin-button,
          .otp-input input::-webkit-inner-spin-button {
              -webkit-appearance: none;
              margin: 0;
          }
          .otp-input input[type=number] {
              -moz-appearance: textfield;
          }
          button {
              background-color: #4CAF50;
              color: white;
              border: none;
              padding: 10px 20px;
              font-size: 1rem;
              border-radius: 4px;
              cursor: pointer;
              margin: 5px;
          }
          button:hover {
              background-color: #45a049;
          }
          button:disabled {
              background-color: #cccccc;
              color: #666666;
              cursor: not-allowed;
          }
          #timer {
              font-size: 1.2rem;
              margin-bottom: 1rem;
              color: #ff9800;
          }
  
  </style>
  
  
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>OTP Verification</title>
     
  </head>
  <body>
  
  
  <form action="validateOtp.jsp">
  
      <div class="container">
          <h1>OTP Verification</h1>
          <p>Enter the 6-digit code sent to your device</p>
          <div id="timer">Time remaining: 3:00</div>
          <div >
              <input type="number" name="number"  required>
              
          </div>
          <button onclick="verifyOTP()">Verify</button>
          <button id="resendButton" onclick="resendOTP()" disabled>Resend Code</button>
      </div>
      
      <script>
      
      const inputs = document.querySelectorAll('.otp-input input');
      const timerDisplay = document.getElementById('timer');
      const resendButton = document.getElementById('resendButton');
      let timeLeft = 180; // 3 minutes in seconds
      let timerId;

      function startTimer() {
          timerId = setInterval(() => {
              if (timeLeft <= 0) {
                  clearInterval(timerId);
                  timerDisplay.textContent = "Code expired";
                  resendButton.disabled = false;
                  inputs.forEach(input => input.disabled = true);
              } else {
                  const minutes = Math.floor(timeLeft / 60);
                  const seconds = timeLeft % 60;
                  timerDisplay.textContent = `Time remaining: ${minutes}:${seconds.toString().padStart(2, '0')}`;
                  timeLeft--;
              }
          }, 1000);
      }

      function resendOTP() {
          // Here you would typically call your backend to resend the OTP
          alert("New OTP sent!");
          timeLeft = 180;
          inputs.forEach(input => {
              input.value = '';
              input.disabled = false;
          });
          resendButton.disabled = true;
          inputs[0].focus();
          clearInterval(timerId);
          startTimer();
      }

      inputs.forEach((input, index) => {
          input.addEventListener('input', (e) => {
              if (e.target.value.length > 1) {
                  e.target.value = e.target.value.slice(0, 1);
              }
              if (e.target.value.length === 1) {
                  if (index < inputs.length - 1) {
                      inputs[index + 1].focus();
                  }
              }
          });

          input.addEventListener('keydown', (e) => {
              if (e.key === 'Backspace' && !e.target.value) {
                  if (index > 0) {
                      inputs[index - 1].focus();
                  }
              }
              if (e.key === 'e') {
                  e.preventDefault();
              }
          });
      });

      function verifyOTP() {
          const otp = Array.from(inputs).map(input => input.value).join('');
          if (otp.length === 6) {
              if (timeLeft > 0) {
            	  alert('Verifying OTP: ${otp}');
                  // Here you would typically send the OTP to your server for verification
              } else {
                  alert('OTP has expired. Please request a new one.');
              }
          } else {
            //  alert('OTP Verified sucessfull');
          }
      }

      startTimer();
      </script>
      
      </form>
  </body>
  </html>