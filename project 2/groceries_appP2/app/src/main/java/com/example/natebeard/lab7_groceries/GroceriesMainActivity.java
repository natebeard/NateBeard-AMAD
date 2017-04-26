package com.example.natebeard.lab7_groceries;

import android.app.Activity;
import android.app.FragmentTransaction;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;


public class GroceriesMainActivity extends Activity implements GroceryTypeListFragment.GroceryTypeListListener, GroceryItemFragment.ButtonClickListener {



    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_groceries_main);
    }

    @Override public void itemClicked(long id){

        View fragmentContainer = findViewById(R.id.fragment_container);
        if (fragmentContainer != null) {
            //create new fragment instance
            GroceryItemFragment frag = new GroceryItemFragment();
            //create new fragment transaction
            FragmentTransaction ft = getFragmentManager().beginTransaction();
            //set the id of the universe selected
            frag.setGroceries(id);
            //replace the fragment in the fragment container
            ft.replace(R.id.fragment_container, frag);
            //add fragment to the back stack
            ft.addToBackStack(null);
            //set the transition animation-optional
            ft.setTransition(FragmentTransaction.TRANSIT_FRAGMENT_FADE);
            //commit the transaction
            ft.commit();
        } else {
            Intent intent = new Intent(this, GroceriesItemActivity.class);
            intent.putExtra("id", (int) id);

            startActivity(intent);
        }
    }

    // handle back button presses
    @Override public void onBackPressed() {
        if (getFragmentManager().getBackStackEntryCount() > 0 ){
            getFragmentManager().popBackStack();
        } else {
            super.onBackPressed();
        }
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
                Intent intent = new Intent(this, MapsActivity.class);
                startActivity(intent);
                return true;
            default:
                return super.onOptionsItemSelected(item);
        }
    }
}
