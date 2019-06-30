package com.tarobang.cpvoter

import android.content.Intent
import android.util.Log
import com.google.firebase.database.*


class FirebaseManager : ValueEventListener {

    companion object {
        val instance = FirebaseManager()
    }

    var roomReference: DatabaseReference? = null

    fun startListeningTo(session: String) {

        val root: DatabaseReference = FirebaseDatabase.getInstance().reference

        stopListening()

        this.roomReference = root.child(session)

        roomReference?.let {
            it.addValueEventListener(this)
        }
    }

    fun stopListening() {
        roomReference?.let {
            it.removeEventListener(this)
        }
    }

    override fun onCancelled(p0: DatabaseError) {
        Log.w("FB", "Cancelled")
    }

    override fun onDataChange(p0: DataSnapshot) {

        // Get the status of the screening

        val status = p0.child("status").getValue(String::class.java)

        if (status == null) {
            // There's no status, so we should stop listening
            stopListening()
            return

        } else if (status == "waiting") {

//            val intent = Intent(null, WaitingToBeginActivity::class.java)
//            intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
//            startActivity(intent)

        }

        Log.w("FB", status)



    }

}