


import React from 'react';
import arrowRight from '../img/Right.jpg'

import './index.css';

class VoteLeftRightScreen extends React.Component {

  constructor(props) {
    super(props);
    this.handleLeft = this.handleLeft.bind(this);
    this.handleRight = this.handleRight.bind(this);
    this.update = this.update.bind(this);

    this.state = {
      'voting': 'none'
    };

  }

  update(direction) {
    if (this.state.voting == direction) {
      this.setState({ 'voting': 'none' })
    } else {
      this.setState({ 'voting': direction })
    }

    console.log(this.state.voting);
  }

  handleLeft(event) {
    event.preventDefault();
    this.update('left');
  }

  handleRight(event) {
    event.preventDefault();
    this.update('right');
  }


  render() {
    return (
      <div class="black-container">
        <div class="button-container">
          <a href="#" onClick={this.handleLeft}>
            <img class="button-image" src={arrowRight} />
          </a>
        </div>
        <div class="button-container">
          <a href="#" onClick={this.handleRight}>
            <img class="button-image" src={arrowRight} />
          </a>
        </div>
      </div>
    )
  }



}


export default VoteLeftRightScreen;
