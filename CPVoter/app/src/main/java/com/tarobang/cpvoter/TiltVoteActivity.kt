package com.tarobang.cpvoter

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.content.Context
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorManager
import android.hardware.SensorEventListener
import android.opengl.Visibility
import android.view.View
import android.widget.ImageView
import android.widget.TextView
import kotlin.math.PI
import kotlin.math.acos
import kotlin.math.sqrt
import android.util.Log
import android.view.WindowManager

class TiltVoteActivity : BaseActivity(), SensorEventListener {

    var vote: Vote = Vote.NONE

    lateinit var textView: TextView
    lateinit var arrow: ImageView

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_tilt_vote)

        val sensorManager = getSystemService(Context.SENSOR_SERVICE) as SensorManager
        val sensor: Sensor? = sensorManager.getDefaultSensor(Sensor.TYPE_GRAVITY)

        textView = findViewById(R.id.tilt_text_view)
        arrow = findViewById(R.id.arrow_image_view)

        this.arrow.visibility = View.INVISIBLE
        this.textView.visibility = View.VISIBLE

        getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);


        sensor?.let { sensor ->
            sensorManager.registerListener(this, sensor, SensorManager.SENSOR_DELAY_GAME)
        }
    }

    override fun onDestroy() {
        Log.v("tilt", "DESTROY!")
        super.onDestroy()
        getWindow().clearFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)

        val sensorManager = getSystemService(Context.SENSOR_SERVICE) as SensorManager
        sensorManager.unregisterListener(this)
    }

    override fun onAccuracyChanged(p0: Sensor?, p1: Int) {
        // TODO: Implement me
    }

    override fun onSensorChanged(p0: SensorEvent?) {
        p0?.let { event ->
            this.handleGravity(event.values[0], event.values[1], event.values[2])
        }
    }

    fun updateVote(x: Vote) {
        if (x != this.vote) {
            this.vote = x
            FirebaseManager.instance.voteDirection(this.vote)
        }
    }

    fun handleGravity(x: Float, y: Float, z: Float) {




        // For some reason the length of the vector is 10 instead of 1.
        // We're going to 'normalize' the vector so that it has length
        // of 1 so it makes some calculations a bit easier...

        val originalLength = sqrt(x*x + y*y + z*z)
        val uX = x/originalLength
        val uY = y/originalLength
        val uZ = z/originalLength

//        Log.v("tilt", "(x: " + uX + ", y: " + uY + ", z: " + uZ + ")")

        // Now check to see if Z is within the range needed

        // We want uZ to be between sqrt(0.5) and 0 or it's not upright enough

        val isTiltedGood = (uZ >= 0.0) && (uZ <= sqrt(0.5))

        if (isTiltedGood == false) {

            Log.v("tilt", "Too tilty!")

            this.arrow.visibility = View.INVISIBLE
            this.textView.visibility = View.VISIBLE
            updateVote(Vote.NONE)
            return
        }

        this.textView.visibility = View.GONE

        // Ignore the Z component and normalize the (X,Y) Vector

        val length = sqrt(uX*uX + uY*uY)

        val nX = uX/length
        val nY = uY/length

        // Get the angle between (nX, nY) and straight down

        val cosineAngle = nY
        val radians = acos(cosineAngle)

        if (radians <= 0.3) {
            // TODO: Bail out they're not voting
            Log.v("tilt", "No votey")
            updateVote(Vote.NONE)
            this.arrow.visibility = View.INVISIBLE
            return
        }

        Log.v("tilt", "nX = " + nX)

        if (nX < 0.0) {
            updateVote(Vote.RIGHT)
            this.arrow.visibility = View.VISIBLE
            this.arrow.rotation = (-radians / PI * 180).toFloat() + 180
        } else {
            updateVote(Vote.LEFT)
            this.arrow.visibility = View.VISIBLE
            this.arrow.rotation = (radians / PI * 180).toFloat()
        }
    }

}
