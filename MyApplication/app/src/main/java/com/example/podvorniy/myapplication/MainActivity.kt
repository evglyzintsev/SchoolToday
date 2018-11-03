package com.example.podvorniy.myapplication

import android.content.Intent
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.os.StrictMode
import kotlinx.android.synthetic.main.activity_main.*
import com.android.volley.Response
import com.android.volley.toolbox.Volley
import com.android.volley.Request
import com.android.volley.toolbox.StringRequest
import com.google.gson.Gson
import com.google.gson.GsonBuilder
import com.google.gson.reflect.TypeToken
import khttp.post

class MainActivity : AppCompatActivity() {
    val url = "http://5.63.159.177:5000/api/login"
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        enter.setOnClickListener {
            val policy = StrictMode.ThreadPolicy.Builder().permitAll().build()

            StrictMode.setThreadPolicy(policy)
            val r = khttp.post(url, data = mapOf("login" to login.text.toString(), "password" to password.text.toString()))
            val s : Boolean = r.jsonObject["successfull"] as Boolean
            if (s == true)
            {
                val i = Intent(this, Main2Activity::class.java)
                startActivity(i)
            }

        }
    }
}
data class Person(val successfull: Boolean, val id: Int, val status: String) {
}