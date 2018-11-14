package com.example.podvorniy.myapplication

import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import kotlinx.android.synthetic.main.activity_photo.*
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
import kotlinx.android.synthetic.main.activity_main.*
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
import com.esafirm.imagepicker.features.ImagePicker
import com.esafirm.imagepicker.features.ReturnMode
import com.esafirm.imagepicker.model.Image
import android.util.Base64.encodeToString
import java.io.ByteArrayOutputStream
import java.io.File
import com.android.volley.VolleyLog
import com.android.volley.VolleyError
import com.android.volley.toolbox.JsonObjectRequest
import com.android.volley.RequestQueue

import com.justinnguyenme.base64image.*

class Photo : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_photo)
        add_photo.setOnClickListener {
            ImagePicker.create(this).start()
        }
        var list = mutableListOf<Model>()
        val policy = StrictMode.ThreadPolicy.Builder().permitAll().build()

        StrictMode.setThreadPolicy(policy)
        val r = khttp.get("http://5.63.159.177:5000/api/photos")
        var obj: JSONObject = r.jsonObject
        var lObg: JSONArray = obj["data"] as JSONArray
        for (i in 0..lObg.length() - 1) {
            var objj: JSONObject = lObg[i] as JSONObject
            println(objj["image"])
            var str: String = objj["image" +
                    ""] as String
            val imageBytes = Base64.decode(str, 0)
            val image = BitmapFactory.decodeByteArray(imageBytes, 0, imageBytes.size)
            println(image)
            list.add(Model(image))
        }
        listView.adapter = MyListAdapter(this, R.layout.row, list)
    }

    public override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        val images = ImagePicker.getImages(data)
        for (i in 0..images.size - 1)
        {
            val bm = BitmapFactory.decodeFile(images[i].getPath())
            val resizedBitmap = Bitmap.createScaledBitmap(
                    bm, 375, 375 * (bm.height / bm.width), false)
            val baos = ByteArrayOutputStream()
            resizedBitmap.compress(Bitmap.CompressFormat.PNG, 90, baos)
            val imageBytes = baos.toByteArray()
            var str =  com.example.podvorniy.myapplication.Base64.encodeBytes(baos.toByteArray())

            val imageBytess = Base64.decode(str, 0)
            val image = BitmapFactory.decodeByteArray(imageBytess, 0, imageBytess.size)
            println(str)
            val r = khttp.post("http://5.63.159.177:5000/api/photos/add", data= mapOf("date" to str))
        }
    }
}




