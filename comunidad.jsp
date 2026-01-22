<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --accent: #00d4ff;
            --accent-purple: #7000ff;
            --bg: #0b0f1a;
            --card-bg: #1e293b;
        }

        body { 
            font-family: 'Poppins', sans-serif; 
            background: var(--bg); 
            background-image: radial-gradient(circle at 0% 0%, #161e31 0%, #0b0f1a 100%);
            color: white; 
            padding: 40px 20px; 
            margin: 0;
            min-height: 100vh;
        }

        .container { max-width: 1200px; margin: auto; }

        header { text-align: center; margin-bottom: 50px; }
        h2 { 
            font-size: 2.5rem;
            color: var(--accent); 
            margin-bottom: 10px; 
            text-transform: uppercase; 
            letter-spacing: -1px;
            font-weight: 800;
            background: linear-gradient(to right, #00d4ff, #7000ff);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .subtitle { color: #94a3b8; font-size: 1.1rem; }

        .community-grid { 
            display: grid; 
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr)); 
            gap: 30px; 
        }

        /* Tarjeta mejorada */
        .comm-card { 
            background: var(--card-bg); 
            border: 1px solid rgba(255, 255, 255, 0.05);
            padding: 30px; 
            border-radius: 24px; 
            display: flex;
            flex-direction: column;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            box-shadow: 0 20px 40px rgba(0,0,0,0.3);
            position: relative;
            overflow: hidden;
        }

        .comm-card::before {
            content: ""; position: absolute; top: 0; left: 0; width: 100%; height: 4px;
            background: linear-gradient(90deg, var(--accent), var(--accent-purple));
            opacity: 0.5;
        }

        .comm-card:hover { 
            transform: translateY(-10px);
            border-color: var(--accent);
            box-shadow: 0 30px 60px rgba(0, 212, 255, 0.15);
        }

        .header-card {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .author { 
            font-weight: 700;
            color: #f8fafc;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .region-tag { 
            background: rgba(0, 212, 255, 0.1); 
            color: var(--accent);
            padding: 5px 14px; 
            border-radius: 10px; 
            font-size: 0.75rem; 
            font-weight: 700;
            border: 1px solid rgba(0, 212, 255, 0.2);
        }

        .build-info { margin-bottom: 15px; }
        .build-type {
            font-size: 0.8rem;
            color: var(--accent-purple);
            text-transform: uppercase;
            font-weight: 800;
            letter-spacing: 1px;
        }
        .build-title { font-size: 1.4rem; margin: 5px 0; font-weight: 700; }

        /* Estilo de la lista de Pokémon */
        .pokes { 
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px;
            margin: 15px 0;
        }

        .poke-tag {
            background: #0f172a;
            padding: 10px;
            border-radius: 12px;
            font-size: 0.85rem;
            text-align: center;
            border: 1px solid rgba(255,255,255,0.05);
            color: #cbd5e1;
            transition: 0.3s;
        }
        .poke-tag:hover { background: #1e293b; color: white; border-color: var(--accent); }

        /* Estilo de las notas */
        .notes-box {
            background: rgba(112, 0, 255, 0.05);
            border-left: 3px solid var(--accent-purple);
            padding: 12px;
            border-radius: 0 12px 12px 0;
            margin-top: auto;
            font-size: 0.85rem;
            color: #94a3b8;
            font-style: italic;
        }

        .empty-state {
            grid-column: 1/-1;
            text-align: center;
            padding: 100px;
            color: #475569;
        }

        .btn-new {
            display: inline-block;
            margin-top: 20px;
            padding: 12px 25px;
            background: var(--accent);
            color: var(--bg);
            text-decoration: none;
            border-radius: 12px;
            font-weight: 700;
            transition: 0.3s;
        }
        .btn-new:hover { transform: scale(1.05); background: white; }
    </style>
</head>
<body>

<div class="container">
    <header>
        <h2>HUB comunitario</h2>
        <p class="subtitle">Estrategias y equipos de la red de entrenadores pokemon </p>
        <a href="creacion.html" class="btn-new">+ Compartir Mi Equipo</a>
    </header>

    <div class="community-grid">
    <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/poke_gabo", "root", "n0m3l0");
            
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM equipos WHERE autor != 'Gabo' ORDER BY id DESC");
            
            boolean hayDatos = false;
            while(rs.next()){
                hayDatos = true;
                String[] pokes = rs.getString("pokemon_nombres").split(",");
                String notas = rs.getString("notas");
    %>
        <div class="comm-card">
            <div class="header-card">
                <span class="author">👤 <%= rs.getString("autor") %></span>
                <span class="region-tag">📍 <%= rs.getString("region") %></span>
            </div>
            
            <div class="build-info">
                <span class="build-type"><%= rs.getString("tipo_equipo") %></span>
                <h4 class="build-title">Estrategia de Team</h4>
            </div>
            
            <div class="pokes">
                <% for(String p : pokes) { 
                    if(!p.trim().isEmpty()) { %>
                    <div class="poke-tag">🌕 <%= p.trim() %></div>
                <% } } %>
            </div>

            <% if(notas != null && !notas.trim().isEmpty()) { %>
            <div class="notes-box">
                <strong>Estrategia:</strong> "<%= notas %>"
            </div>
            <% } %>
        </div>
    <% 
            }
            if(!hayDatos) {
    %>
        <div class="empty-state">
            <p>Aún no hay equipos registrados.</p>
            <p>¡Inaugura la comunidad compartiendo el tuyo!</p>
        </div>
    <%
            }
            con.close();
        } catch(Exception e) { 
            out.print("<div class='empty-state'>Error al cargar: " + e.getMessage() + "</div>"); 
        }
    %>
    </div>
</div>

</body>
</html>