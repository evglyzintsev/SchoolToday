package com.example.podvorniy.myapplication

import android.content.Intent
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import kotlinx.android.synthetic.main.activity_main2.*
class Main2Activity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main2)
        photo.setOnClickListener {
            val i = Intent(this, Photo::class.java)
            startActivity(i)
        }
        news.setOnClickListener{
            val ii = Intent(this, News::class.java)
            startActivity(ii)
        }
        Winss.setOnClickListener{
            val iii = Intent(this, Wins::class.java)
            startActivity(iii)
        }
        Lessonn.setOnClickListener{
            val iiii = Intent(this,  Lessons::class.java)
            startActivity(iiii)
        }
    }
}
