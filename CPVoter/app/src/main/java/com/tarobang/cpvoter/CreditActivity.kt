package com.tarobang.cpvoter

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button

class CreditActivity : BaseActivity() {



    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_credit)

        val creditsButton = findViewById<Button>(R.id.end_credits_button)

        creditsButton.setOnClickListener {
            FirebaseManager.instance.goBackToRoomEntryScreen()
        }

    }
}
