package com.example.natebeard.lab7_groceries;


import android.os.Bundle;
import android.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;


/**
 * A simple {@link Fragment} subclass.
 */
public class OrderListFragment extends Fragment  {

    private ArrayAdapter<String> adapter;

    //private ButtonClickListener listener;

    //private long groceryID;

//    public void setGroceries(long id){
//        this.groceryID = id;
//    }

    public OrderListFragment() {
        // Required empty public constructor
    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        if (savedInstanceState != null){
            // Bring totalGroceries list in
        }
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_order_list, container, false);
    }


}
