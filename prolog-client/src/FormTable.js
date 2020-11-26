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

    const requestOptions = {
      method: 'POST',
      body: JSON.stringify(data)
    };

    fetch(this.state.serverAddress + this.state.postApi, requestOptions)
    .then((response) => {
      if (response.status === 200) {
        response.json().then(data => {
          console.log(data);
          this.setState({ data });
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
    console.log("XDDD");
  }

  componentWillUnmount() {
    // this.setState({symptomList: []});
  }

  render() {
    return (
      <div className="table">
        <form onSubmit={this.handleSubmit}>
          <h1 className="table-title">TITLE</h1>

          <div className="question-wrapper">
            <label>Ile masz lat</label>
            <input type="text" name="wiek"></input>
          </div>
          
          { this.state.symptomList.map((item, index) => (
            <div className="question-wrapper" key={ index }>
              <label>Do you agree { item }</label>
              <input type="radio" name={ item } value="yes"/>
              <input type="radio" name={ item } value="no"/>
            </div>
            )
          )}
          <button>Send</button>
        </form>
      </div>
    );
  }
}

export default FormTable;