package com.tarobang.cpvoter

import android.util.Log
import com.google.firebase.database.*


class FirebaseManager : ValueEventListener {

    companion object {
        val instance = FirebaseManager()
    }

    var roomReference: DatabaseReference? = null

    fun startListeningTo(session: String) {

        val root: DatabaseReference = FirebaseDatabase.getInstance().reference

        roomReference?.let {
            it.removeEventListener(this)
        }

        this.roomReference = root.child(session)

        roomReference?.let {
            it.addValueEventListener(this)
        }
    }

    override fun onCancelled(p0: DatabaseError) {
        Log.w("FB", "Cancelled")
    }

    override fun onDataChange(p0: DataSnapshot) {
        Log.w("FB", p0.toString())
    }

}