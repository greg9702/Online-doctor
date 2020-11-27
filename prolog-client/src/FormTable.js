import React from 'react';
import './FormTable.css';

class FormTable extends React.Component {
  constructor() {
    super();
    this.handleSubmit = this.handleSubmit.bind(this);
    this.state = {
      serverAddress: 'http://localhost:8080',
      postApi: '/api/diagnose',
      getApi: '/api/symptoms',
      questionPrefix: 'Czy ma Pan/Pani ',
      symptomList: [],
    }
  }

  handleSubmit(event) {

    const data = new FormData(event.target);

    let dataToSend = {'positive_symptoms': []};

    for (var x of data) {
      if (this.state.symptomList.includes(x[0]) ) {
        if (x[1] === 'yes') {
          dataToSend['positive_symptoms'].push(x[0])
        }
      } else {
        dataToSend[x[0]] = x[1]
      }
    }

    console.log(dataToSend);

    const requestOptions = {
      method: 'POST',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(dataToSend),
    };

    fetch(this.state.serverAddress + this.state.postApi, requestOptions)
    .then((response) => {
      if (response.status === 200) {
        response.json().then(data => {
          console.log('received response: ', data);
        });
      } else {
        throw Error(response.statusText)
      }
    }).catch(error => {
      console.log("Error sending request")
    })

    event.preventDefault();
  }

  sendGetAllSymptoms = () => {

    fetch(this.state.serverAddress + this.state.getApi)
    .then((response) => {
      if (response.status === 200) {
        response.json().then(data => {
          console.log(data);
          this.setState({ symptomList: data["all_symptoms"] });
        });
      } else {
        throw Error(response.statusText)
      }
    }).catch(error => {
      console.log("Error sending request")
    })
    
  }

  componentDidMount() {
    // fetch api here
    this.sendGetAllSymptoms();
    console.log('Form Table loaded');
  }

  componentWillUnmount() {
    // this.setState({symptomList: []});
    console.log('Form Table unloaded');
  }

  render() {
    return (
      <div className="questions-table">
        <form onSubmit={this.handleSubmit}>
          <div className="questions-table-title">
            <h1 className="questions-table-title-text">Odpowiedz na pytania</h1>
          </div>
          <div className="header-spacing">
          </div>
          <div className="question-wrapper" >
            <label className="question-wrapper-text">Aasdas asdfa</label>
            <input className="questions-answer-text" type="text" name="wiek"></input>
          </div>
          
          { this.state.symptomList.map((item, index) => (
            <div className="question-wrapper" key={ index }>
              <label className="question-wrapper-text">Do you agree { item }</label>
              <span className="question-answer-checkbox">
                <span className="question-answer-checkbox-label">Tak</span>
                <input className="checkbox-bullet" type="radio" name={ item } value="yes"/>
                <span className="question-answer-checkbox-label">Nie</span>
                <input className="checkbox-bullet" type="radio" name={ item } value="no"/>
              </span>
            </div>
            )
          )}
          <button className="questions-table-send-button">Send</button>
        </form>
      </div>
    );
  }
}

export default FormTable;