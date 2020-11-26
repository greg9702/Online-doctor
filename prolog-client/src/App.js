import React from 'react';
import './App.css';
import FormTable from './FormTable.js';

class App extends React.Component {

  state = {
  }

  sorter(checkedItem){
    this.setState({checked:checkedItem});
  }

  render() {
    return (
      <div>
        <FormTable />
      </div>
    )
  }
}

export default App;
