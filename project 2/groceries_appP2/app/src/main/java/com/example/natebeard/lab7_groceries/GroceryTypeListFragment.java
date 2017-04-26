package com.example.natebeard.lab7_groceries;


import android.app.Fragment;
import android.content.Context;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;


/**
 * A simple {@link Fragment} subclass.
 */
public class GroceryTypeListFragment extends Fragment implements AdapterView.OnItemClickListener {


    public GroceryTypeListFragment() {
        // Required empty public constructor
    }

    private GroceryTypeListListener listener;

    // create interface in order to separate the activities more from the fragments
    interface GroceryTypeListListener{
        void itemClicked(long id);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_grocery_type_list, container, false);
    }

    // Need to setOnItemClickListener before onItemClick?
    @Override public void onItemClick(AdapterView<?> parent, View view, int position, long id){
        if (listener != null){
            //tells the listener an item was clicked
            listener.itemClicked(id);
            //Log.i("clicked!");

        }
    }



    // called when an item is attached to an activity
    @Override public void onAttach(Context context){
        super.onAttach(context);
        //attaches the context to the listener
        listener = (GroceryTypeListListener) context;
    }

    @Override
    public void onStart(){
        super.onStart();

        View view = getView();
        if (view != null){

            ListView listGroceries = (ListView) view.findViewById(R.id.listView);
            listGroceries.setOnItemClickListener(this);
            // define array adaptor:
            ArrayAdapter<Groceries> listAdaptor = new ArrayAdapter<Groceries>(getActivity(), android.R.layout.simple_list_item_1, Groceries.groceries);
            //set array adaptor to list view
            listGroceries.setAdapter(listAdaptor);
            //Log.e("groceries!", String.valueOf(listGroceries.getId()));
            //Log.i("groceries!", String.valueOf(listGroceries.getId()));


        }
    }





}
