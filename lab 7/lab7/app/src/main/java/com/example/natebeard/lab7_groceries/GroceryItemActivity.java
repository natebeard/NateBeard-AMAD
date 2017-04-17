package com.example.natebeard.lab7_groceries;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.ImageView;
import android.widget.TextView;

public class GroceryItemActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_grocery_item);

        // 9) get grocery data from intents to display in text and image views
        int groceryNum = (Integer)getIntent().getExtras().get("groceryid");
        String type = (String)getIntent().getExtras().get("groceryType");
        switch (type){
            case "Food":
                Groceries groceryItem = Groceries.food[groceryNum];
                ImageView groceryImage = (ImageView)findViewById(R.id.groceryImageView);
                groceryImage.setImageResource(groceryItem.getImageResourceID());
                TextView groceryName = (TextView)findViewById(R.id.grocery_item_name);
                groceryName.setText(groceryItem.getName());
                break;
            case "Drinks":
                groceryItem = Groceries.drinks[groceryNum];
                groceryImage = (ImageView)findViewById(R.id.groceryImageView);
                groceryImage.setImageResource(groceryItem.getImageResourceID());
                groceryName = (TextView)findViewById(R.id.grocery_item_name);
                groceryName.setText(groceryItem.getName());
                break;
            case "Personal Stuff":
                groceryItem = Groceries.misc[groceryNum];
                groceryImage = (ImageView)findViewById(R.id.groceryImageView);
                groceryImage.setImageResource(groceryItem.getImageResourceID());
                groceryName = (TextView)findViewById(R.id.grocery_item_name);
                groceryName.setText(groceryItem.getName());
                break;
            default: groceryItem=null;
        }
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
