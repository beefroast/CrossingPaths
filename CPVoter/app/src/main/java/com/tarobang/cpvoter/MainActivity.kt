package com.tarobang.cpvoter

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import com.google.firebase.auth.FirebaseAuth
import android.content.Intent
import android.os.Handler


class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)


        Handler().postDelayed({
            signInAndMoveToFirstScreen()
        }, 2000)

    }

    fun signInAndMoveToFirstScreen() {
        val auth = FirebaseAuth.getInstance()
        auth.signInAnonymously().addOnCompleteListener {
            val intent = Intent(this@MainActivity, EnterSessionActivity::class.java)
            intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            intent.addFlags(Intent.FLAG_ACTIVITY_NO_HISTORY);
            startActivity(intent)
            finish()
        }
    }
}
