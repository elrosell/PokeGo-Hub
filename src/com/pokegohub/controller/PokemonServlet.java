package com.pokegohub.controller;

import com.pokegohub.model.DatabaseConnection;
import com.pokegohub.model.Pokemon;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PokemonServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Pokemon> pokemonList = new ArrayList<>();
        try (Connection connection = DatabaseConnection.getConnection()) {
            String sql = "SELECT * FROM pokemon";
            try (Statement stmt = connection.createStatement();
                 ResultSet rs = stmt.executeQuery(sql)) {
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String name = rs.getString("name");
                    int baseAttack = rs.getInt("base_attack");
                    int baseDefense = rs.getInt("base_defense");
                    int baseStamina = rs.getInt("base_stamina");
                    pokemonList.add(new Pokemon(id, name, baseAttack, baseDefense, baseStamina));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("pokemonList", pokemonList);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/pokemonList.jsp");
        dispatcher.forward(request, response);
    }
}
