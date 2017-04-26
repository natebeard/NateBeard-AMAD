package com.example.natebeard.lab7_groceries;

import android.app.ActionBar;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;

public class GroceriesItemActivity extends Activity implements GroceryItemFragment.ButtonClickListener {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_groceries_item);

        //get reference to the grocery item detail fragment
        GroceryItemFragment groceriesItemFragment = (GroceryItemFragment) getFragmentManager().findFragmentById(R.id.fragment_container);
        //get the id passed in the intent
        int groceryID = (int) getIntent().getExtras().get("id");
        //pass the groceries id to the fragment
        groceriesItemFragment.setGroceries(groceryID);

        ActionBar actionBar = getActionBar();
        actionBar.setDisplayHomeAsUpEnabled(true);
    }

    @Override public void addItemclicked(View view){
        GroceryItemFragment fragment = (GroceryItemFragment) getFragmentManager().findFragmentById(R.id.fragment_container);
        fragment.addItem();
    }

    public boolean onCreateOptionsMenu(Menu menu){
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return super.onCreateOptionsMenu(menu);
    }

    public boolean onOptionsItemSelected(MenuItem item){
        switch (item.getItemId()){
            case R.id.go_to_map:
                Intent intent = new Intent(this, OrderActivity.class);
                startActivity(intent);
                return true;
            default:
                return super.onOptionsItemSelected(item);
        }
    }

}
