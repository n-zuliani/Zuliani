<%@ page contentType="text/html"%>
<%@ page pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*,java.text.*"%>

<%
       String output = "";
       if(request.getParameter("username")==null || request.getParameter("username").isEmpty()){
          output += "Devi inserire il tuo username<br>"; 
       }
       
       if(request.getParameter("password")==null || request.getParameter("password").isEmpty()){
          output += "Devi inserire la tua password<br>"; 
       }
        
       if(output.isEmpty()){
           String connectionUrl = "jdbc:sqlserver://213.140.22.237\\SQLEXPRESS:1433;databaseName=XFactor;user=zuliani.nicolo;password=xxx123#";

           Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

           Connection connection = DriverManager.getConnection(connectionUrl);
           
           String sql = "SELECT * FROM Cittadino WHERE username = ? AND password = ?";
		
	       PreparedStatement stmt = connection.prepareStatement(sql);
			
           stmt.setString(1, request.getParameter("username"));
           stmt.setString(2, request.getParameter("password"));
	   
	       ResultSet rs = stmt.executeQuery();
	   
	       if(rs.next()){
	         
               %>
               
               
              <form action="ES2delete.jsp" method="get">
              <input type="number" name="remove">
              <input type="subimit" value="cancella">
              </form>
               
               <%

 	       }else{
 	         output="Username o password non corretti!";  
 	       }
 	       
       }
	   
      %>
      <%= output %>