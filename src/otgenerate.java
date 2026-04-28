import java.io.IOException;
import java.io.PrintWriter;
import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class otpGenerate
 */
@WebServlet("/otgenerate")
public class otgenerate extends HttpServlet {
		protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
			

		String otp;
		
String mobile=	 request.getParameter("number");


		
		PrintWriter out=	 response.getWriter();
			
			
			if(checkdbMobile(mobile)) {
		
			 otp=GenerateOTP(6);
		HttpSession httpSession=	 request.getSession();
		httpSession.setAttribute("GenerateOtp", otp);
			  if(storeOtp(mobile, otp)) {
					out.println("Generate Otp  :"+otp);
					
				  response.sendRedirect("verifyotp.jsp");
				  
			  }
			
			
			}
			else {
				out.print("Not register mobile number");
			}
				
				}				
				//generateotp
				   private static String GenerateOTP(int j) {
					   
					   SecureRandom random=new SecureRandom();
					   StringBuilder otp=new StringBuilder();
					   for(int i=0;i<j;i++) {
						   
						   otp.append(random.nextInt(10));
					   }
					   return otp.toString();
				   }

				   
				   
				   //checkmobile
				   private boolean checkdbMobile(String mobile) {
					   boolean existingmobile=false;
					   try {
						   Class.forName("com.mysql.cj.jdbc.Driver");
					Connection conn=	   DriverManager.getConnection("jdbc:mysql://localhost:3306/event","root", "root");
			PreparedStatement pst=		 conn.prepareStatement("select *from  register where mobile='"+mobile+"'");	   
					
			         //  pst.setString(1, mobile);
			          
			           
			        ResultSet rs=   pst.executeQuery();
			
			          while(rs.next()) {
			        	  existingmobile=true;
			          }
			        
			
			
					} catch (Exception e) {
						// TODO: handle exception
						e.printStackTrace();
					}
					   
					 return existingmobile;  
					   
				   }
				   
				   
				   
				   //storeotp
				   private boolean storeOtp(String mobile,String otp) {
					    boolean StoreOtp=false;
					try {
						
						Class.forName("com.mysql.cj.jdbc.Driver");
						Connection conn=	   DriverManager.getConnection("jdbc:mysql://localhost:3306/event","root", "root");
		 PreparedStatement pst= conn.prepareStatement("update register set otp=? where mobile='"+mobile+"'");
		          pst.setString(1, otp);
//		          pst.setString(2, mobile);
		          
		       int i=   pst.executeUpdate();
				if(i!=0) {
					return StoreOtp =true;
				}
		 
		 
					}
					catch (Exception e) {
						// TODO: handle exception
						e.printStackTrace();
					}
					return StoreOtp;
					   

	}




			
			
		}   



