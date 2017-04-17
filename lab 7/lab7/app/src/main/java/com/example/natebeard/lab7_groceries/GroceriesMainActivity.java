package com.example.natebeard.lab7_groceries;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;

public class GroceriesMainActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_groceries_main);
        // 1) create a listener b/c list view isn't subclassed under button
        AdapterView.OnItemClickListener itemClickListener = new AdapterView.OnItemClickListener(){
          public void onItemClick(AdapterView<?> listView, View view, int position, long id){
              String groceryType = (String) listView.getItemAtPosition(position);
              // 2) create new intent
              Intent intent = new Intent(GroceriesMainActivity.this, GroceryTypeActivity.class);
              // 3) add groceryType to intent and start activity
              intent.putExtra("groceryType", groceryType);
              startActivity(intent);
          }
        };
        // 4) get list view and add listener to it
        ListView groceryListView = (ListView) findViewById(R.id.listView);
        groceryListView.setOnItemClickListener(itemClickListener);
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
