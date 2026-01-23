package com.pokegohub.model;

public class Pokemon {
    private final int id;
    private final String name;
    private final int baseAttack;
    private final int baseDefense;
    private final int baseStamina;

    public Pokemon(int id, String name, int baseAttack, int baseDefense, int baseStamina) {
        this.id = id;
        this.name = name;
        this.baseAttack = baseAttack;
        this.baseDefense = baseDefense;
        this.baseStamina = baseStamina;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public int getBaseAttack() {
        return baseAttack;
    }

    public int getBaseDefense() {
        return baseDefense;
    }

    public int getBaseStamina() {
        return baseStamina;
    }
}
