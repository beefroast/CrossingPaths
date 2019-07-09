




import React from 'react';

import characterA from '../img/CharacterStills_A.png'
import characterB from '../img/CharacterStills_B.png'
import characterC from '../img/CharacterStills_C.png'
import characterD from '../img/CharacterStills_D.png'
import characterE from '../img/CharacterStills_E.png'
import characterF from '../img/CharacterStills_F.png'
import characterG from '../img/CharacterStills_G.png'
import characterH from '../img/CharacterStills_H.png'
import characterI from '../img/CharacterStills_I.png'
import characterJ from '../img/CharacterStills_J.png'
import characterK from '../img/CharacterStills_K.png'
import characterL from '../img/CharacterStills_L.png'

import './index.css';

class SelectCharacterScreen extends React.Component {

  constructor(props) {
    super(props)
    this.state = {value: ''};

    this.characterData = this.characterData.bind(this);
    this.cells = this.cells.bind(this);
    this.onCellClick = this.onCellClick.bind(this);
    this.state = { selectedIndex: -1 }
  }

  characterData() {
    return [
      { name: "Dunc", image: characterA },
      { name: "Zoe", image: characterB },
      { name: "Ryan", image: characterC },
      { name: "Ness", image: characterD },
      { name: "Poe", image: characterE },
      { name: "Ed", image: characterF },
      { name: "Mandy", image: characterG },
      { name: "Ruby", image: characterH },
      { name: "Bella", image: characterI },
      { name: "Lena", image: characterJ },
      { name: "Ricky", image: characterK },
      { name: "Kelsie", image: characterL }
    ]
  }

  cells() {
    return this.characterData().map((item, key) =>
      <div>
        <CharacterCell
          name={item.name}
          img={item.image}
          index={key}
          isSelected={key === this.state.selectedIndex}
          onClick={this.onCellClick} />
      </div>
    );
  }

  onCellClick(event, idx) {

    event.preventDefault();

    if (this.state.selectedIndex == idx) {
      this.setState({ selectedIndex: -1 });
    } else {
      this.setState({ selectedIndex: idx });
    }
  }

  render() {
    return (
      <div>
        <div>
          <h1>Select a path...</h1>
        </div>
        {this.cells()}
      </div>
    )
  }

}




export default SelectCharacterScreen;

class CharacterCell extends React.Component {

  constructor(props) {
    super(props)

    this.state = {
      'colorClass': "color-" + (this.props.index % 4)
    }
  }

  render() {
    return (
      <a href="#" onClick={(event) => this.props.onClick(event, this.props.index)}>
        <div class={this.state.colorClass}>
          <div class="character-cell">
            <img class="character-avatar" src={this.props.img} />
            <h3 class="character-name">{this.props.name}</h3>
            <p>{this.props.isSelected ? "true" : "false"}</p>
          </div>
        </div>
      </a>
    )
  }

}
