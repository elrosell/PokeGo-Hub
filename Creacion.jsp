<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
  
    request.setCharacterEncoding("UTF-8");

    String aut = request.getParameter("autor");
    String reg = request.getParameter("region");
    String tip = request.getParameter("tipo");
    String pok = request.getParameter("pokes");
    // Si usas el campo de notas que añadimos en el diseño anterior:
    String not = request.getParameter("notas"); 

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        
       
        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/poke_gabo", "root", "n0m3l0")) {
            
            // Si no tienes la columna 'notas', quita 'notas' y el quinto '?'
            String sql = "INSERT INTO equipos (region, tipo_equipo, pokemon_nombres, autor, notas) VALUES (?, ?, ?, ?, ?)";
            
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, reg);
                ps.setString(2, tip);
                ps.setString(3, pok);
                ps.setString(4, aut);
                ps.setString(5, not != null ? not : ""); // Evita nulos
                
                ps.executeUpdate();
            }
        }
        
       
        response.sendRedirect("comunidad.jsp");
        
    } catch(Exception e) { 
     
        out.print("❌ Error al guardar el equipo: " + e.getMessage()); 
    }
%>