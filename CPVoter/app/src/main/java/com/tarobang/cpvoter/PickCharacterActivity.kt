package com.tarobang.cpvoter

import android.media.Image
import android.os.Bundle
import android.view.View
import android.view.ViewGroup
import android.widget.ListView
import android.widget.ArrayAdapter
import android.widget.BaseAdapter
import android.content.Context
import android.view.LayoutInflater
import android.widget.TextView

class PickCharacterActivity : BaseActivity() {

    lateinit var listView: ListView

    private val characterData = arrayOf(
        CharacterData("Dunc"),
        CharacterData("Zoe"),
        CharacterData("Ryan"),
        CharacterData("Ness"),
        CharacterData("Poe"),
        CharacterData("Ed"),
        CharacterData("Mandy"),
        CharacterData("Ruby"),
        CharacterData("Bella"),
        CharacterData("Lena"),
        CharacterData("Ricky"),
        CharacterData("Kelsie")
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

            name.text = character.name

            return rowView
        }


    }

    private class CharacterData(val name: String)
}
