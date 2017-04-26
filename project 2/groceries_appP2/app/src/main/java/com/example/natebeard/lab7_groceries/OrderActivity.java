package com.example.natebeard.lab7_groceries;

import android.app.Activity;
import android.os.Bundle;

public class OrderActivity extends Activity  {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_order);

        //get reference to the grocery item detail fragment
        //get the id passed in the intent
        //pass the groceries id to the fragment




//        ActionBar actionBar = getActionBar();
//        actionBar.setDisplayHomeAsUpEnabled(true);

    }

//    public void orderButtonAction (View view){
//        Button orderButton = (Button)findViewById(R.id.order_button);
//        Uri uri = Uri.parse("http://www.google.com/#q=groceries");
//        Intent intent = new Intent(Intent.ACTION_VIEW, uri);
//        startActivity(intent);
//    }
//
//    public void mapButtonAction (View view){
//        Button mapButton = (Button)findViewById(R.id.map_button);
//        Intent mapIntent = new Intent(this, MapsActivity.class);
//        startActivity(mapIntent);
//    }

//    public boolean onCreateOptionsMenu(Menu menu){
//        // 10) create a menu and menu icon for ordering by inflating menu and adding items to the action bar
//        getMenuInflater().inflate(R.menu.menu_main, menu);
//        return super.onCreateOptionsMenu(menu);
//    }
//
//    public boolean onOptionsItemSelected(MenuItem item){
//        // 11) create item ID and start order activity
//        switch (item.getItemId()){
//            case R.id.go_to_map:
//                Intent intent = new Intent(this, OrderActivity.class);
//                startActivity(intent);
//                return true;
//            default:
//                return super.onOptionsItemSelected(item);
//        }
//    }
}



