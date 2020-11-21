import React from 'react';
import './App.css';

class App extends React.Component {

  state = {
    serverUrl: "http://localhost:8080",
    symptomList: null,
    initialized : false,
  }

  sendGetAllSymptoms = () => {
    fetch(this.state.serverUrl + "/api/symptoms")
    .then((response) => {
      if (response.status === 200) {
        response.json().then(data => {
          console.log(data);
          this.setState({ symptomList: response["all_symptoms"] });
        });
      } else {
        throw Error(response.statusText)
      }
    }).catch(error => {
      console.log("Error sending request")
    })
  }

  render() {
    return (
      <div>
      <button onClick={this.sendGetAllSymptoms} >
        Start
      </button>
    </div>
    )
  }

}

export default App;
