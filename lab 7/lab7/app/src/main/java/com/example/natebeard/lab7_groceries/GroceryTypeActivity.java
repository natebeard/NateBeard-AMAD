package com.example.natebeard.lab7_groceries;

import android.app.ListActivity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListView;

public class GroceryTypeActivity extends ListActivity {

    private String groceryType;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        // Bring groceries food array into list view
        Intent i = getIntent();
        groceryType = i.getStringExtra("groceryType");
        // 7) get list view and define array adapter
        ListView listGroceries = getListView();
        ArrayAdapter<Groceries>listAdapter;

        // 8) intialize array adapter with the right list of grocery types
        switch (groceryType){
            case "Food":
                listAdapter = new ArrayAdapter<Groceries>(this, android.R.layout.simple_list_item_1, Groceries.food);
                break;
            case "Drinks":
                listAdapter = new ArrayAdapter<Groceries>(this, android.R.layout.simple_list_item_1, Groceries.drinks);
                break;
            case "Personal Stuff":
                listAdapter = new ArrayAdapter<Groceries>(this, android.R.layout.simple_list_item_1, Groceries.misc);
                break;
            default: listAdapter = null;

        }
        listGroceries.setAdapter(listAdapter);
    }

    @Override
    public void onListItemClick(ListView listView, View view, int position, long id){
        Intent intent = new Intent(GroceryTypeActivity.this, GroceryItemActivity.class);
        intent.putExtra("groceryid", (int) id);
        intent.putExtra("groceryType", groceryType);
        startActivity(intent);
    }


    public boolean onCreateOptionsMenu(Menu menu){
        // 10) create a menu and menu icon for ordering by inflating menu and adding items to the action bar
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return super.onCreateOptionsMenu(menu);
    }

    public boolean onOptionsItemSelected(MenuItem item){
        // 11) create item ID and start order activity
        switch (item.getItemId()){
            case R.id.create_order:
                Intent intent = new Intent(this, OrderActivity.class);
                startActivity(intent);
                return true;
            default:
                return super.onOptionsItemSelected(item);
        }
    }

}
