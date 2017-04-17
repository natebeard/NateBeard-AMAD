package com.example.natebeard.lab7_groceries;

/**
 * Created by NateBeard on 4/16/17.
 */

public class Groceries {
    private String name;
    private int imageResourceID;

    // 5) constructor - initializes list view object without returning a value
    private Groceries(String newname, int newID){
        this.name = newname;
        this.imageResourceID = newID;
    }

    // create an array with image and list name
    public static final Groceries[] food = {
            new Groceries("Pizza", R.drawable.pizzacatspace),
            new Groceries("Burgers", R.drawable.burgercat),
            new Groceries("Fried Chicken", R.drawable.friedchickenspacecat),
            new Groceries("Ice Cream", R.drawable.icecreamdogspace),
            new Groceries("Hot Sauce", R.drawable.hotsauce),
    };

    public static final Groceries[] drinks = {
            new Groceries("Orange Juice", R.drawable.orangepulp),
            new Groceries("Milk", R.drawable.milkandcookies),
            new Groceries("Beer", R.drawable.dalespaleale),
    };

    public static final Groceries[] misc = {
            new Groceries("Toothpaste", R.drawable.toothpaste),
            new Groceries("Toilet Paper", R.drawable.trumptp),
    };

    // 6) get resources and strings and attach them to food list?
    public String getName(){
        return name;
    }

    public int getImageResourceID(){
        return imageResourceID;
    }

    public String toString(){
        return this.name;
    }

}
