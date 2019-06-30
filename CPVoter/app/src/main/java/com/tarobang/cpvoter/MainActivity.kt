package com.tarobang.cpvoter

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import com.google.firebase.auth.FirebaseAuth
import android.content.Intent
import android.os.Handler
import android.view.WindowManager
import android.os.Build
import android.view.View

class MainActivity : BaseActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        // If the Android version is lower than Jellybean, use this call to hide
        // the status bar.
        if (Build.VERSION.SDK_INT < 16) {
            window.setFlags(
                WindowManager.LayoutParams.FLAG_FULLSCREEN,
                WindowManager.LayoutParams.FLAG_FULLSCREEN
            )
        }




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
