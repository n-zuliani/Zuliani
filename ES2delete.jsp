<%@ page contentType="text/html"%>
<%@ page pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*,java.text.*"%>

<%
       
           String output = "";
           String connectionUrl = "jdbc:sqlserver://213.140.22.237\\SQLEXPRESS:1433;databaseName=XFactor;user=zuliani.nicolo;password=xxx123#";

           Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

           Connection connection = DriverManager.getConnection(connectionUrl);
	       
	       if(request.getParameter("remove")!=null && request.getParameter("username")!=null){
	           
	           PreparedStatement stmt = connection.prepareStatement("SELECT * FROM Comunicazione where Comunicazione.IDE = ? AND Comunicazione.IDU = (select id from Cittadino where username = ?)");
			
               stmt.setInt(1, Integer.parseInt(request.getParameter("remove")));
               stmt.setString(2, request.getParameter("username"));
	   
	           ResultSet rs = stmt.executeQuery();
	           
	           
 	           if(rs.next()){
 	               PreparedStatement dstmt = connection.prepareStatement("DELETE FROM Evento where ID = ?");
 	               dstmt.setInt(1, Integer.parseInt(request.getParameter("remove")));
 	               dstmt.executeUpdate();
 	               
 	                 sql = "SELECT * FROM Evento inner join Comunicazione on Evento.ID = Comunicazione.IDE inner join Cittadino on Comunicazione.IDE = Cittadino.ID where Cittadino.username = ?";
                stmt = connection.prepareStatement(sql);
               stmt.setString(1, request.getParameter("username"));
               rs = stmt.executeQuery();
               
               output="<table>";
               while(rs.next()){
                 output+="<tr><td><a href=\"ES1delete.jsp?remove="+rs.getInt("ID")+"&user="+request.getParameter("username")+"\">"+rs.getString("nome")+"</a></td><td>"+rs.getString("data")+"</td></tr>";  
               }
               output+="</table>";
 	           }else{
 	               output = "Non puoi eliminare eventi che non hai inserito tu";
 	           }
 	       }
	         
             

 	       
 	       
       
	   
      %>
      <%= output %>