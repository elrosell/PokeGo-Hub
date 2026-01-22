<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        body { 
            font-family: 'Poppins', sans-serif; 
            background: #0f172a; 
            color: white; 
            padding: 30px; 
            line-height: 1.6;
        }

        .back-btn { 
            color: #00d4ff; 
            text-decoration: none; 
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: 0.3s;
            margin-bottom: 20px;
        }
        .back-btn:hover { color: #ff1f1f; transform: translateX(-5px); }

        h2 { font-size: 2rem; margin-bottom: 30px; border-left: 5px solid #ff1f1f; padding-left: 15px; }

        /* Contenedor de las 4 opciones principales */
        .grid-teams { 
            display: grid; 
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); 
            gap: 20px; 
            margin-bottom: 40px;
        }

        .team-card { 
            background: rgba(30, 41, 59, 0.7); 
            padding: 25px; 
            border-radius: 20px; 
            cursor: pointer;
            border: 1px solid rgba(255,255,255,0.05);
            border-bottom: 4px solid #ff1f1f; 
            transition: all 0.3s ease;
            text-align: center;
        }

        .team-card:hover { 
            transform: translateY(-5px); 
            background: #1e293b; 
            box-shadow: 0 10px 20px rgba(0,0,0,0.3);
            border-color: #00d4ff;
        }

        .team-card h3 { font-size: 1.1rem; margin-bottom: 10px; color: #f8fafc; }
        .team-card p { font-size: 0.8rem; color: #94a3b8; }

        /* Área donde aparecen los 6 Pokémon */
        .pokes-display-area { margin-top: 40px; min-height: 200px; }

        .pokes-container { 
            display: none; 
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr)); 
            gap: 15px; 
            background: rgba(255, 255, 255, 0.03); 
            padding: 30px; 
            border-radius: 25px;
            border: 1px solid rgba(255,255,255,0.05);
            animation: fadeIn 0.5s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .poke-mini-card {
            background: #1e293b; 
            padding: 20px; 
            border-radius: 15px;
            text-align: center; 
            border: 1px solid rgba(255,255,255,0.05); 
            transition: 0.3s;
            cursor: pointer;
        }

        .poke-mini-card:hover { 
            background: #00d4ff; 
            color: #0f172a; 
            transform: scale(1.05);
        }

        .poke-mini-card img { width: 50px; margin-bottom: 10px; filter: drop-shadow(0 0 5px rgba(255,255,255,0.2)); }

        .active { display: grid !important; }

        /* Colores por tipo de equipo */
        .card-Fuego { border-bottom-color: #ff4d4d; }
        .card-Agua { border-bottom-color: #4d94ff; }
        .card-Planta { border-bottom-color: #4dff88; }
        .card-Competitivo { border-bottom-color: #ff00ff; }
    </style>

    <script>
        function toggleTeam(id) {
          
            document.querySelectorAll('.pokes-container').forEach(el => el.classList.remove('active'));
         
            const target = document.getElementById('pokes-' + id);
            if(target) target.classList.add('active');
        
            target.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
        }

        function showInfo(nombre) {
         
            alert("Abriendo análisis de Gabo para: " + nombre);
        }
    </script>
</head>
<body>
    <a href="regiones.html" class="back-btn">← Volver a Regiones</a>
    
    <% String regionName = request.getParameter("region"); %>
    <h2>Master Teams: <%= regionName %></h2>

    <div class="grid-teams">
    <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
          
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/poke_gabo", "root", "n0m3l0");
            
            PreparedStatement ps = con.prepareStatement("SELECT * FROM equipos WHERE region=? AND autor='Gabo'");
            ps.setString(1, regionName);
            ResultSet rs = ps.executeQuery();
            
            while(rs.next()){
                int id = rs.getInt("id");
                String tipo = rs.getString("tipo_equipo");
                String[] pokes = rs.getString("pokemon_nombres").split(",");
    %>
        <div class="team-card card-<%=tipo%>" onclick="toggleTeam(<%=id%>)">
            <div style="font-size: 2rem; margin-bottom: 10px;">
                <%= tipo.equals("Fuego") ? "🔥" : tipo.equals("Agua") ? "💧" : tipo.equals("Planta") ? "🌿" : "🏆" %>
            </div>
            <h3>Build <%= tipo %></h3>
            <p>Ver alineación de 6</p>
        </div>
    <% 
            } 
    %>
    </div>

    <div class="pokes-display-area">
    <%
            rs.beforeFirst(); 
            while(rs.next()){
                int id = rs.getInt("id");
                String[] pokes = rs.getString("pokemon_nombres").split(",");
    %>
        <div id="pokes-<%=id%>" class="pokes-container">
            <% for(String p : pokes) { %>
                <div class="poke-mini-card" onclick="showInfo('<%=p.trim()%>')">
                    <img src="https://img.icons8.com/color/96/pokeball--v1.png" alt="poke">
                    <div><strong><%= p.trim() %></strong></div>
                    <small style="opacity: 0.7;">Ver Stats</small>
                </div>
            <% } %>
        </div>
    <% 
            } 
            con.close();
        } catch(Exception e) { 
            out.print("<div class='team-card'>No hay equipos oficiales registrados para esta región.</div>"); 
        }
    %>
    </div>

</body>
</html>