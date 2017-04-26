package com.example.natebeard.lab7_groceries;


import android.app.Dialog;
import android.app.Fragment;
import android.content.Context;
import android.os.Bundle;
import android.view.ContextMenu;
import android.view.LayoutInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;

import java.util.ArrayList;

/**
 * A simple {@link Fragment} subclass.
 */
public class GroceryItemFragment extends Fragment implements View.OnClickListener {

    private ArrayAdapter<String> adapter;

    private ButtonClickListener listener;

    private long groceryID;

    public void setGroceries(long id){
        this.groceryID = id;
    }

    public GroceryItemFragment() {
        // Required empty public constructor
    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        if (savedInstanceState != null) {
            groceryID = savedInstanceState.getLong("groceryID");
        }

        // 4) if the grocery list is empty, load groceries
        if (Groceries.groceries[0].getGroceryItems().size() == 0) {
            Groceries.groceries[0].loadGroceries(getActivity(), 0);
        }
        if (Groceries.groceries[1].getGroceryItems().size() == 0) {
            Groceries.groceries[1].loadGroceries(getActivity(), 1);
        }


        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_grocery_item, container, false);
    }

    @Override public void onStart(){
        super.onStart();

        View view = getView();
        ListView listItems = (ListView) view.findViewById(R.id.itemListView);

        // get grocery data
        ArrayList<String> itemlist = new ArrayList<String>();
        itemlist = Groceries.groceries[(int)groceryID].getGroceryItems();

        //set array adapter
        adapter = new ArrayAdapter<String>(getActivity(), android.R.layout.simple_list_item_1, itemlist);

        //bind array adapter to the list view
        listItems.setAdapter(adapter);

        Button addButton = (Button) view.findViewById(R.id.addButton);
        addButton.setOnClickListener(this);

        registerForContextMenu(listItems);

    }

    // for turning the phone, then above put if savedInstanceState to check
    @Override public void onSaveInstanceState(Bundle savedInstanceState){
        savedInstanceState.putLong("groceryID", groceryID);
    }

    interface ButtonClickListener{
        void addItemclicked(View view);
    }

    @Override public void onAttach(Context context){
        super.onAttach(context);
        //attaches the context to the listener
        listener = (ButtonClickListener)context;
    }

    @Override public void onClick(View view){
        if (listener !=null){
            listener.addItemclicked(view);
        }
    }

    public void addItem(){
        final Dialog dialog = new Dialog(getActivity());
        dialog.setContentView(R.layout.dialog);
        dialog.setTitle("Add Item");
        dialog.setCancelable(true);
        final EditText editText = (EditText) dialog.findViewById(R.id.editTextItem);
        Button button = (Button) dialog.findViewById(R.id.addButton);
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String itemName = editText.getText().toString();
                // add hero
                Groceries.groceries[(int) groceryID].getGroceryItems().add(itemName);
                //refresh the list view
                GroceryItemFragment.this.adapter.notifyDataSetChanged();
                //Groceries.groceries[(int) groceryID].storeItem(getActivity(), groceryID);
                dialog.dismiss();
            }
        });
        dialog.show();
    }

    @Override public void onCreateContextMenu(ContextMenu menu, View view, ContextMenu.ContextMenuInfo menuInfo){
        super.onCreateContextMenu(menu, view, menuInfo);
        //cast ContextMenu.ContextMenuInfo to AdapterView.AdapterContextMenuInfo since we're using an adapter
        AdapterView.AdapterContextMenuInfo adapterContextMenuInfo = (AdapterView.AdapterContextMenuInfo) menuInfo;
        //get hero name that was pressed
        String heroname = adapter.getItem(adapterContextMenuInfo.position);
        //set the menu title
        menu.setHeaderTitle("Delete " + heroname);
        //add the choices to the menu
        menu.add(1, 1, 1, "Yes");
        menu.add(2, 2, 2, "No");
    }

    @Override public boolean onContextItemSelected(MenuItem item){
        //get the id of the item
        int itemId = item.getItemId();
        if (itemId == 1) { //if yes menu item was pressed
            //get the position of the menu item
            AdapterView.AdapterContextMenuInfo info = (AdapterView.AdapterContextMenuInfo) item.getMenuInfo();
            //remove the hero
            Groceries.groceries[(int) groceryID].getGroceryItems().remove(info.position);
            //refresh the list view
            GroceryItemFragment.this.adapter.notifyDataSetChanged();
            //Groceries.groceries[(int) groceryID].storeGroceries(getActivity(), groceryID);
        }
        return true;
    }



}
