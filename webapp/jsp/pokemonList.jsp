<%@ page import="java.util.List" %>
<%@ page import="com.pokegohub.model.Pokemon" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Lista de Pokémon</title>
    <link rel="stylesheet" href="../styles.css">
</head>
<body>
    <h1>Lista de Pokémon</h1>
    <table>
        <thead>
            <tr>
                <th>Nombre</th>
                <th>Base Attack</th>
                <th>Base Defense</th>
                <th>Base Stamina</th>
            </tr>
        </thead>
        <tbody>
            <%
                List<Pokemon> pokemonList = (List<Pokemon>) request.getAttribute("pokemonList");
                if (pokemonList != null) {
                    for (Pokemon p : pokemonList) {
            %>
                <tr>
                    <td><%= p.getName() %></td>
                    <td><%= p.getBaseAttack() %></td>
                    <td><%= p.getBaseDefense() %></td>
                    <td><%= p.getBaseStamina() %></td>
                </tr>
            <%
                    }
                }
            %>
        </tbody>
    </table>
</body>
</html>
