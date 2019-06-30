package com.tarobang.cpvoter

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import com.google.firebase.auth.FirebaseAuth
import android.content.Intent




class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val auth = FirebaseAuth.getInstance()

        val x = auth.signInAnonymously().addOnCompleteListener {
            val activityChangeIntent = Intent(this@MainActivity, EnterSessionActivity::class.java)
            startActivity(activityChangeIntent)
        }


    }
}
