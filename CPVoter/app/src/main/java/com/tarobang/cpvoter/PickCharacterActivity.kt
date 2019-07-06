package com.tarobang.cpvoter

import android.media.Image
import android.os.Bundle
import android.view.View
import android.view.ViewGroup
import android.widget.ListView
import android.widget.ArrayAdapter
import android.widget.BaseAdapter
import android.widget.ImageView
import android.content.Context
import android.graphics.Color
import android.graphics.drawable.Drawable
import android.opengl.Visibility
import android.util.Log
import android.view.LayoutInflater
import android.widget.TextView
import com.jackandphantom.circularimageview.CircleImage

class PickCharacterActivity : BaseActivity() {

    lateinit var listView: ListView

    private val characterData = arrayOf(
        CharacterData("Dunc", R.drawable.a),
        CharacterData("Zoe", R.drawable.b),
        CharacterData("Ryan", R.drawable.c),
        CharacterData("Ness", R.drawable.d),
        CharacterData("Poe", R.drawable.e),
        CharacterData("Ed", R.drawable.f),
        CharacterData("Mandy", R.drawable.g),
        CharacterData("Ruby", R.drawable.h),
        CharacterData("Bella", R.drawable.i),
        CharacterData("Lena", R.drawable.j),
        CharacterData("Ricky", R.drawable.k),
        CharacterData("Kelsie", R.drawable.l)
    )

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_pick_character)

        this.listView = findViewById<ListView>(R.id.list_view)


        val adapter = CharacterAdapter(this, characterData)
        listView.adapter = adapter

        listView.setOnItemClickListener { _, _, position, _ ->

            if (position > 0) {

                val idx = position-1

                if (idx == adapter.pickedIndex) {
                    adapter.pickedIndex = null
                    FirebaseManager.instance.voteForCharacter("None")
                } else {
                    adapter.pickedIndex = idx
                    val character = characterData[idx]
                    FirebaseManager.instance.voteForCharacter(character.name)
                }

                adapter.notifyDataSetChanged()
            }
        }

        val col = resources.getColor(R.color.cpYellow)
        listView.setBackgroundColor(col)
    }


    private class CharacterAdapter(private val context: Context,
                                   private val dataSource: Array<CharacterData>): BaseAdapter() {

        var pickedIndex: Int? = null

        private val inflater: LayoutInflater
                = context.getSystemService(Context.LAYOUT_INFLATER_SERVICE) as LayoutInflater

        override fun getCount(): Int {
            return dataSource.size + 1
        }

        override fun getItem(position: Int): Any {
            return dataSource[position-1]
        }

        override fun getItemId(position: Int): Long {
            return position.toLong()
        }

        override fun getView(position: Int, convertView: View?, parent: ViewGroup): View {


            if (position == 0) {
                return inflater.inflate(R.layout.pick_character_header, parent, false)
            }

            val idx = position-1

            val rowView = inflater.inflate(R.layout.character_item, parent, false)

            val character = dataSource[idx]

            val name = rowView.findViewById<TextView>(R.id.character_name)
            val imgView = rowView.findViewById<CircleImage>(R.id.character_image_view)
            val tickView = rowView.findViewById<ImageView>(R.id.character_selected)

            name.text = character.name
            imgView.setImageResource(character.img)


            tickView.visibility = View.INVISIBLE
            pickedIndex?.let {
                if (idx == it) {
                    tickView.visibility = View.VISIBLE
                }
            }

            val color = getColorFor(idx)

            rowView.setBackgroundColor(color)
            imgView.setBackgroundColor(color)

            return rowView
        }

        fun getColorFor(idx: Int): Int {
            val r = idx % 4
            if (r == 0) {
                return Color.parseColor("#DCA4C2")
            } else if (r == 1) {
                return Color.parseColor("#E9EDB1")
            } else if (r == 2) {
                return Color.parseColor("#C7CCF4")
            } else {
                return Color.parseColor("#B0F0C8")
            }
        }


    }







    private class CharacterData(val name: String, val img: Int)
}
