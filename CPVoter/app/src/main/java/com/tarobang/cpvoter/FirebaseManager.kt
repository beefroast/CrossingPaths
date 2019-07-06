package com.tarobang.cpvoter

import android.content.Intent
import android.util.Log
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.database.*
import android.app.ProgressDialog



enum class Vote {
    NONE, LEFT, RIGHT
}

class FirebaseManager : ValueEventListener {

    companion object {
        val instance = FirebaseManager()
    }

    var roomReference: DatabaseReference? = null
    var currentActivity: BaseActivity? = null
    var enterSessionActivity: EnterSessionActivity? = null

    fun startListeningTo(session: String, fromActivity: EnterSessionActivity) {

        val root: DatabaseReference = FirebaseDatabase.getInstance().reference

        stopListening()

        this.roomReference = root.child(session)
        this.enterSessionActivity = fromActivity

        roomReference?.let {
             it.child("status").addValueEventListener(this)
        }
    }

    fun stopListening() {
        roomReference?.let {
            it.child("status").removeEventListener(this)
        }
        this.roomReference = null
    }

    fun goBackToRoomEntryScreen() {
        this.stopListening()
        this.currentActivity?.let {
            val intent = Intent(it, EnterSessionActivity::class.java)
            intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            intent.addFlags(Intent.FLAG_ACTIVITY_NO_HISTORY);
            it.startActivity(intent)
            it.finish()
        }
    }

    fun voteForCharacter(name: String) {

        val userId = FirebaseAuth.getInstance().currentUser?.uid

        if (userId == null) { return }

        roomReference?.let {
            it.child("characterVotes")
                .child(userId)
                .setValue(name)
        }

    }

    fun voteDirection(vote: Vote) {

        val userId = FirebaseAuth.getInstance().currentUser?.uid

        if (userId == null) { return }

        roomReference?.let {
            it.child("leftRightVotes")
                .child(userId)
                .setValue(stringFor(vote))
        }
    }

    fun stringFor(vote: Vote): String {
         when(vote) {
            Vote.NONE -> return "none"
            Vote.LEFT -> return "left"
            Vote.RIGHT -> return "right"
         }
    }



    override fun onCancelled(p0: DatabaseError) {
        Log.w("FB", "Cancelled")
    }



    override fun onDataChange(p0: DataSnapshot) {

        // Get the status of the screening

        val status = p0.getValue(String::class.java)

        if (status == null) {
            // There's no status, so we should stop listening
            stopListening()

            this.enterSessionActivity?.let {
                it.stopSpinningAndReportError("A session with that name does not exist")
            }
            this.enterSessionActivity = null

            return

        } else if (status == "waiting") {

            this.currentActivity?.let {
                val intent = Intent(it, WaitingToBeginActivity::class.java)
                intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
                intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                intent.addFlags(Intent.FLAG_ACTIVITY_NO_HISTORY);
                it.startActivity(intent)
                it.finish()
            }

        } else if (status == "picking") {

            this.currentActivity?.let {
                val intent = Intent(it, PickCharacterActivity::class.java)
                intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
                intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                intent.addFlags(Intent.FLAG_ACTIVITY_NO_HISTORY);
                it.startActivity(intent)
                it.finish()
            }

        } else if (status == "playing") {

            this.currentActivity?.let {
                val intent = Intent(it, TiltVoteActivity::class.java)
                intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
                intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                intent.addFlags(Intent.FLAG_ACTIVITY_NO_HISTORY);
                it.startActivity(intent)
                it.finish()
            }

        } else if (status == "finished") {

            this.currentActivity?.let {
                val intent = Intent(it, CreditActivity::class.java)
                intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
                intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                intent.addFlags(Intent.FLAG_ACTIVITY_NO_HISTORY);
                it.startActivity(intent)
                it.finish()
            }
        }



    }

}