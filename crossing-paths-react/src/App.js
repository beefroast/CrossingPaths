import React from 'react';
import logo from './logo.svg';
import './App.css';

import EnterViewingSession from './EnterViewingSession/index.js';
import WaitingToBeginScreen from './WaitingToBeginScreen/index.js';
import VoteLeftRightScreen from './VoteLeftRightScreen/index.js';
import SelectCharacterScreen from './SelectCharacterScreen/index.js';


function App() {
  return (
    <SelectCharacterScreen />
  );
}

export default App;
