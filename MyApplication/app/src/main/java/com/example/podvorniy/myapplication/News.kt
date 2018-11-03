package com.example.podvorniy.myapplication

import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.R.attr.bitmap
import android.content.Intent
import android.graphics.drawable.BitmapDrawable
import android.graphics.drawable.Drawable
import android.graphics.BitmapFactory
import android.graphics.Bitmap
import android.util.Base64
import com.android.volley.Request
import com.android.volley.Response
import com.android.volley.toolbox.StringRequest
import com.android.volley.toolbox.Volley
import com.github.kittinunf.fuel.Fuel
import com.github.kittinunf.fuel.core.response
import com.google.gson.Gson
import kotlinx.android.synthetic.main.activity_newss.*
import com.github.kittinunf.fuel.httpGet
import com.github.kittinunf.fuel.httpPost
import android.os.StrictMode
import com.github.kittinunf.forge.core.JSON
import com.github.kittinunf.fuel.android.core.Json
import com.github.kittinunf.fuel.android.extension.responseJson
import khttp.get
import org.json.JSONArray
import org.json.JSONObject
import android.util.Base64.decode
class News : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_newss)
        var list = mutableListOf<NewsModell>()
        val policy = StrictMode.ThreadPolicy.Builder().permitAll().build()
        add.setOnClickListener {
            val iii = Intent(this, AddNew::class.java)
            startActivity(iii)
        }
        StrictMode.setThreadPolicy(policy)
        val r = khttp.get("http://5.63.159.177:5000/api/school-events")
        var obj: JSONObject = r.jsonObject
        var lObg : JSONArray = obj["data"] as JSONArray
        for (i in 0..lObg.length() - 1)
        {
            var objj : JSONObject  = lObg[i] as JSONObject
            println(objj["image"])
            var str : String  = objj["image"] as String
            val imageBytes = Base64.decode(str, 0)
            val image = BitmapFactory.decodeByteArray(imageBytes, 0, imageBytes.size)
            println(image)
            val text = objj["long"] as String
            println(text)
            list.add(NewsModell(image, text))
        }
        listView.adapter = NewsListAdapter(this,R.layout.row_news,list)
    }
}




