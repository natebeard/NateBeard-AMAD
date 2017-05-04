package com.example.natebeard.firebasetest;

import com.google.firebase.database.Exclude;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by NateBeard on 4/27/17.
 */

public class RecipeItem {
    private String name;
    private String url;

    // from firebase getting started doc:
    public RecipeItem(){
        // default constructor calls DataSnapshot.getValue
    }

    public RecipeItem(String newName, String newURL){
        name = newName;
        url = newURL;
    }

    public String getName(){
        return name;
    }

    public String getUrl(){
        return url;
    }

    // writing to firebase:
    // takes strings and creates objects (key/value pairs)
    @Exclude
    public Map<String, Object> toMap(){
        HashMap<String, Object> result = new HashMap<>();
        // HashMap is an unordered key value pair (like a dictionary, but java doesn't have dictionaries)
        result.put("name", name);
        result.put("url", url);
        return result;

    }

    public String toString(){
        return this.name;
    }


}
