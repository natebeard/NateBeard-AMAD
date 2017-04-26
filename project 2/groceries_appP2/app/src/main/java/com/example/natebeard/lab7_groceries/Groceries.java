package com.example.natebeard.lab7_groceries;

import android.content.Context;
import android.content.SharedPreferences;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by NateBeard on 4/16/17.
 */

public class Groceries {


    private String itemName;

    private ArrayList<String> groceryItems = new ArrayList<>();

    // constructor
    private Groceries(String newname, ArrayList<String> newID){
        this.itemName = newname;
        this.groceryItems = new ArrayList<String>(newID);
    }

    public static final Groceries[] groceries = {
            new Groceries("Food", new ArrayList<String>()),
            new Groceries("Drinks", new ArrayList<String>()),
            new Groceries("Other stuff", new ArrayList<String>()),
            //new Groceries("Everything", new ArrayList<String>())

            //new Groceries("feed", new ArrayList<String>(Arrays.asList("Pizza", "Burgers", "Fried Chicken", "Green Lantern", "Ice Cream", "Hot Sauce"))),
            //new Groceries("drank", new ArrayList<String>(Arrays.asList("Orange Juice", "Milk", "Beer"))),
            //new Groceries("drank", new ArrayList<String>(Arrays.asList("Toothpaste", "Toilet Paper"))),
    };

    public void storeItems(Context context, long groceryID){
        //get access to a shared preferences file
        SharedPreferences sharedPrefs = context.getSharedPreferences("Groceries", Context.MODE_PRIVATE);
        //create an editor to write to the shared preferences file
        SharedPreferences.Editor editor = sharedPrefs.edit();
        //create a set
        Set<String> set = new HashSet<String>();
        //add heroes to the set
        set.addAll(groceries[(int) groceryID].getGroceryItems());
        //pass the key/value pair to the shared preference file
        editor.putStringSet(groceries[(int) groceryID].getItemName(), set);
        //save changes
        editor.commit();
    }

    public void loadGroceries(Context context, int groceryID){
        //get access to a shared preferences file
        SharedPreferences sharedPrefs = context.getSharedPreferences("Groceries", Context.MODE_PRIVATE);
        //create an editor to read from the shared preferences file
        SharedPreferences.Editor editor = sharedPrefs.edit();
        //create a set with the hero list
        Set<String> set =sharedPrefs.getStringSet(groceries[groceryID].getItemName(), null);
        //if there was a saved list add it to the heroes array
        if (set != null){
            Groceries.groceries[groceryID].groceryItems.addAll(set);
        }
        //if no hero list was saved, use the defaults
        else {
            switch (groceryID) {
                case 0:
                    Groceries.groceries[0].groceryItems.addAll(Arrays.asList("Pizza", "Burgers", "Fried Chicken", "Green Lantern", "Ice Cream", "Hot Sauce"));
                    break;
                case 1:
                    Groceries.groceries[1].groceryItems.addAll(Arrays.asList("Orange Juice", "Milk", "Beer"));
                    break;
                case 2:
                    Groceries.groceries[2].groceryItems.addAll(Arrays.asList("Toothpaste", "Toilet Paper"));
                    break;
//                case 3:
//                    boolean addAll = Groceries.groceries[3].groceryItems.addAll(Arrays.<String>asList(groceries[0], groceries[1], groceries[2]));
//
                default:
                    break;
            }
        }
    }


    public String getItemName(){
        return itemName;
    }

    public ArrayList<String>getGroceryItems(){
        return groceryItems;
    }

    public String toString(){
        return this.itemName;
    }

}
