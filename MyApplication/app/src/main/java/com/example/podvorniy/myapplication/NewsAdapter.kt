package com.example.podvorniy.myapplication

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ArrayAdapter
import android.widget.ImageView
import android.widget.TextView

class NewsListAdapter(var mCtx:Context , var resource:Int,var items:List<NewsModell>)
    :ArrayAdapter<NewsModell>( mCtx , resource , items ){




    override fun getView(position: Int, convertView: View?, parent: ViewGroup?): View {

        val layoutInflater :LayoutInflater = LayoutInflater.from(mCtx)

        val view : View = layoutInflater.inflate(resource , null )
        val imageView :ImageView = view.findViewById(R.id.iconIv)
        val tV: TextView = view.findViewById(R.id.newsT)


        var person : NewsModell = items[position]

        imageView.setImageBitmap(person.photo)
        tV.text = person.text
        return view
    }

}