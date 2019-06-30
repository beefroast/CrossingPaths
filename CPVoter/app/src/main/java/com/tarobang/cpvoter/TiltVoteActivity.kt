package com.tarobang.cpvoter

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.content.Context
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorManager
import android.hardware.SensorEventListener
import kotlin.math.acos
import kotlin.math.sqrt

class TiltVoteActivity : BaseActivity(), SensorEventListener {

    var vote: Vote = Vote.NONE

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_tilt_vote)

        val sensorManager = getSystemService(Context.SENSOR_SERVICE) as SensorManager
        val sensor: Sensor? = sensorManager.getDefaultSensor(Sensor.TYPE_GRAVITY)

        sensor?.let { sensor ->
            sensorManager.registerListener(this, sensor, SensorManager.SENSOR_DELAY_GAME)
        }
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

        if (z <= 0.0 && z >= -sqrt(0.5) == false) {

            // TODO: Handle not being on the correct tilt
            updateVote(Vote.NONE)
        }

        // Ignore the Z component and normalize the (X,Y) Vector

        val length = sqrt(x*x + y*y)

        val nX = x/length
        val nY = y/length

        // Get the angle between (nX, nY) and straight down

        val cosineAngle = nY * -1.0
        val radians = acos(cosineAngle)

        if (radians <= 0.3) {
            // TODO: Bail out they're not voting
            updateVote(Vote.NONE)
        }


        if (nX < 0.0) {
            updateVote(Vote.LEFT)
        } else {
            updateVote(Vote.RIGHT)
        }
    }

}
