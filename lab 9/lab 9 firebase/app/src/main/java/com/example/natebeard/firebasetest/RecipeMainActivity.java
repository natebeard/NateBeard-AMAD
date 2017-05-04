package com.example.natebeard.firebasetest;

import android.app.Dialog;
import android.content.Context;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.ContextMenu;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;

import java.util.ArrayList;
import java.util.List;

public class RecipeMainActivity extends AppCompatActivity {

    // 1. create reference to database
    FirebaseDatabase database = FirebaseDatabase.getInstance();
    DatabaseReference ref = database.getReference();

    List recipes = new ArrayList<>();
    ArrayAdapter<RecipeItem>listAdapter;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_recipe_main);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);


        // 5. use floating action button to add recipes to database/listView
        FloatingActionButton fab = (FloatingActionButton) findViewById(R.id.fab);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
//                Snackbar.make(view, "Replace with your own action", Snackbar.LENGTH_LONG)
//                        .setAction("Action", null).show();
                // create variable to hold dialog (popup view that tells user to enter name of recipe and url)
                final Dialog dialog = new Dialog(RecipeMainActivity.this);
                dialog.setContentView(R.layout.dialog);
                dialog.setTitle("Add New Recipe");
                dialog.setCancelable(true); // creates cancel option
                final EditText nameEditText = (EditText)dialog.findViewById(R.id.editTextName);
                final EditText urlEditText = (EditText) dialog.findViewById(R.id.editTextURL);
                Button addButton = (Button)dialog.findViewById(R.id.addButton);
                // onClick above is for Floating action button
                // this onClick is for the addButton in the Dialog box/action that comes up
                addButton.setOnClickListener(new View.OnClickListener(){
                    @Override
                    public void onClick(View v) {
                        // get text from edit text fields and store in var
                        String recipeName = nameEditText.getText().toString();
                        String recipeURL = urlEditText.getText().toString();
                        if (recipeName.trim().length()>0){
                            RecipeItem newRecipe = new RecipeItem(recipeName, recipeURL);
                            recipes.add(newRecipe);
                            listAdapter.notifyDataSetChanged();
                            ref.child(recipeName).setValue(newRecipe);
                            dialog.dismiss();
                        } else {
                            Context context = getApplicationContext();
                            CharSequence text = getString(R.string.add_recipe_toast);
                            int duration = Toast.LENGTH_SHORT;

                            Toast toast = Toast.makeText(context, text, duration);
                            toast.show();
                        }
                    }
                });
                dialog.show();
            }
        });
        // can't check for a string in java so use "trim" method?

        // 2. create listView/ListAdapter onCreate
        ListView recipeList = (ListView) findViewById(R.id.listView);
        listAdapter = new ArrayAdapter<RecipeItem>(this, android.R.layout.simple_list_item_1, recipes);
        recipeList.setAdapter(listAdapter);

        // 3. populate ListView with data from firebase
        // read from database and "onDataChanged" to populate the list when we add or delete a recipe
        ValueEventListener firebaseListener = new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                // method called whenever data is updated

                // empty arraylist
                recipes.clear();
                // then loop through the entire database (called Datasnapshot) and grab children
                // children = "Banana Blueberry Bread, Pizza, bread, etc.
                // This stores the datasnapshot in one string called "snapshot"?
                for(DataSnapshot snapshot : dataSnapshot.getChildren()){
                    // create new RecipeItem object (http://www.json.org/ "name" = "key")
                    // object = unordered key/value pair = "newRecipe"
                    RecipeItem newRecipe = snapshot.getValue(RecipeItem.class);
                    // add new recipe to array
                    recipes.add(newRecipe);
                    // check data for debugging purposes:
                    Log.d("data", "Value is: " + newRecipe.getName() + newRecipe.getUrl());
                }
                // initiate/update adapter
                listAdapter.notifyDataSetChanged();
            }

            @Override
            public void onCancelled(DatabaseError error) {
                // Failed to read value:
                Log.w("onCreate", "Failed to read value.", error.toException());
            }
        };

        // 4. add listener to our database reference... why?
        // closing ValueEventListener above
        ref.addValueEventListener(firebaseListener);
        registerForContextMenu(recipeList);


    }

    @Override
    public void onCreateContextMenu(ContextMenu menu, View view, ContextMenu.ContextMenuInfo menuInfo){
        super.onCreateContextMenu(menu, view, menuInfo);
        // cast as adapterView b/c using adapter list
        AdapterView.AdapterContextMenuInfo adapterContextMenuInfo = (AdapterView.AdapterContextMenuInfo) menuInfo;
        String recipename = ((TextView) adapterContextMenuInfo.targetView).getText().toString();
        menu.setHeaderTitle("Delete " + recipename);
        menu.add(1,1,1, "Yas");
        menu.add(2,2,2, "No");
    }

    @Override
    public boolean onContextItemSelected(MenuItem item){
        int itemID = item.getItemId();
        if (itemID == 1){
            AdapterView.AdapterContextMenuInfo info = (AdapterView.AdapterContextMenuInfo) item.getMenuInfo();
            String recipename = ((TextView) info.targetView).getText().toString();
            recipes.remove(info.position);
            listAdapter.notifyDataSetChanged();
            ref.child(recipename).removeValue();
        }
        return true;
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_recipe_main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }


}
