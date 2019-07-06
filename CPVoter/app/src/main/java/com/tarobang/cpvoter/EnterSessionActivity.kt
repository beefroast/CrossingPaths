package com.tarobang.cpvoter

import android.os.Bundle
import android.util.Log
import android.widget.Button
import android.widget.EditText
import com.google.android.material.snackbar.Snackbar
import androidx.appcompat.app.AppCompatActivity;
import com.google.firebase.database.*

import kotlinx.android.synthetic.main.activity_enter_session.*
import android.content.Intent
import android.net.Uri
import android.view.View
import android.widget.ProgressBar


class EnterSessionActivity : BaseActivity() {

    lateinit var txtRoomName: EditText
    lateinit var enterRoomButton: Button
    lateinit var facebookButton: Button
    lateinit var creditsButton: Button
    lateinit var spinner: ProgressBar

    override fun onCreate(savedInstanceState: Bundle?) {

        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_enter_session)

        this.txtRoomName = findViewById<EditText>(R.id.room_name)
        this.enterRoomButton = findViewById<Button>(R.id.btn_enter_room)
        this.facebookButton = findViewById<Button>(R.id.btn_facebook)
        this.creditsButton = findViewById<Button>(R.id.btn_credits)
        this.spinner = findViewById<ProgressBar>(R.id.progress_bar)

        enterRoomButton.setOnClickListener {

            enterRoomButton.visibility = View.INVISIBLE
            spinner.visibility = View.VISIBLE
            txtRoomName.isEnabled = false

            val roomName = txtRoomName.text.toString()
            FirebaseManager.instance.startListeningTo(roomName, this)

        }

        facebookButton.setOnClickListener {

            val browserIntent = Intent(
                Intent.ACTION_VIEW,
                Uri.parse("https://www.facebook.com/crossingpathsfilm/")
            )
            startActivity(browserIntent)

        }

        creditsButton.setOnClickListener {
            val intent = Intent(this, CreditActivity::class.java)
            startActivity(intent)
        }

    }

    fun stopSpinningAndReportError(message: String) {
        this.spinner.visibility = View.INVISIBLE
        this.enterRoomButton.visibility = View.VISIBLE
        this.txtRoomName.error = message
        this.txtRoomName.isEnabled = true
    }

}
