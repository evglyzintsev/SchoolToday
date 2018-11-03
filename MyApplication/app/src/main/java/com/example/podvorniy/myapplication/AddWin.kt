package com.example.podvorniy.myapplication
import android.content.Intent
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import kotlinx.android.synthetic.main.activity_add_new.*
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.util.Base64
import com.esafirm.imagepicker.features.ImagePicker
import com.esafirm.imagepicker.model.Image
import com.esafirm.imagepicker.features.ReturnMode
import java.io.ByteArrayOutputStream

class AddWin : AppCompatActivity() {
    var ImageStr : String = ""
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_add_new)
        add_photo.setOnClickListener {
            ImagePicker.create(this).single().start()
        }
        pub.setOnClickListener {

            val r = khttp.post("http://5.63.159.177:5000/api/achivments/add", data = mapOf("date" to "23123",
                    "place" to "21", "class" to "na", "short_description" to des.text.toString().slice(IntRange(0, 9)) + des.text.toString(),
                    "description" to (des.text.toString() + add_des.text.toString()).slice(IntRange(0, 9)) + des.text.toString() + add_des.text.toString(),
                    "image" to ImageStr))
            println(des.text.toString())
            println(des.text.toString() + add_des.text.toString())
            println(r)
            println(r.text)
        }


    }
    public override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        val images = ImagePicker.getFirstImageOrNull(data)
        val bm = BitmapFactory.decodeFile(images.getPath())
        val resizedBitmap = Bitmap.createScaledBitmap(
                bm, 375, 375 * (bm.height / bm.width), false)
        val baos = ByteArrayOutputStream()
        resizedBitmap.compress(Bitmap.CompressFormat.JPEG, 90, baos)
        val imageBytes = baos.toByteArray()
        var str =  com.example.podvorniy.myapplication.Base64.encodeBytes(baos.toByteArray())

        val imageBytess = Base64.decode(str, 0)
        val image = BitmapFactory.decodeByteArray(imageBytess, 0, imageBytess.size)
        println(str)
        str = "/9j/4AAQSk" + str
        ImageStr = str
    }
}
