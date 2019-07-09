


import React from 'react';

class VoteLeftRightScreen extends React.Component {

  constructor(props) {
    super(props);
    this.handleLeft = this.handleLeft.bind(this);
    this.handleRight = this.handleRight.bind(this);
  }

  handleLeft(event) {
    event.preventDefault();
  }

  handleRight(event) {
    event.preventDefault();
  }

  render() {
    return (
      <div>
        <a href="#" onClick={this.handleLeft}>Left</a>
        <a href="#" onClick={this.handleRight}>Right</a>
      </div>
    )
  }



}


export default VoteLeftRightScreen;
