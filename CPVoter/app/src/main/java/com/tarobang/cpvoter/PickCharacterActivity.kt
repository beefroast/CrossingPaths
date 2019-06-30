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
import android.view.LayoutInflater
import android.widget.TextView

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
            val character = characterData[position]
            FirebaseManager.instance.voteForCharacter(character.name)
        }

    }


    private class CharacterAdapter(private val context: Context,
                                   private val dataSource: Array<CharacterData>): BaseAdapter() {

        private val inflater: LayoutInflater
                = context.getSystemService(Context.LAYOUT_INFLATER_SERVICE) as LayoutInflater

        override fun getCount(): Int {
            return dataSource.size
        }

        override fun getItem(position: Int): Any {
            return dataSource[position]
        }

        override fun getItemId(position: Int): Long {
            return position.toLong()
        }

        override fun getView(position: Int, convertView: View?, parent: ViewGroup): View {

            val rowView = inflater.inflate(R.layout.character_item, parent, false)
            val character = dataSource[position]

            val name = rowView.findViewById<TextView>(R.id.character_name)
            val imgView = rowView.findViewById<ImageView>(R.id.character_image_view)

            name.text = character.name
            imgView.setImageResource(character.img)



            return rowView
        }


    }

    private class CharacterData(val name: String, val img: Int)
}
