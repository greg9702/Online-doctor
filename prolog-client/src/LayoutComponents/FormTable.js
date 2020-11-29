import React from 'react';
import './LayoutComponent.css';
import YesNoQuestion from './../QuestionComponents/YesNoQuestion.js';

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
    let dataToSend = {'PositiveSymptoms': []};

    for (var x of data) {
      if (this.state.symptomList.includes(x[0]) ) {
        if (x[1] === 'yes') {
          dataToSend['PositiveSymptoms'].push(x[0])
        }
      } else {
        console.log('Do nothiung');
        // dataToSend[x[0]] = x[1]
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

    // TODO
    let resultName = "XXXXX";
    console.log('resultName before:', resultName);
    fetch(this.state.serverAddress + this.state.postApi, requestOptions)
    .then((response) => {
      if (response.status === 200) {
        response.json().then(data => {
          console.log('received response: ', data);
          if (data['diagnose']) {
            resultName = data['diagnose'][0];
            this.props.handler(resultName);
          } else {
            this.props.handler(null);
          }
        });
      } else {
        throw Error(response.statusText)
      }
    }).catch(error => {
      this.props.errorHanlder();
      console.log("Error sending request")
    })
    console.log('resultName after:', resultName);
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
      this.props.errorHanlder();
      console.log("Error sending request")
    })
  }

  componentDidMount() {
    // fetch api here
    this.sendGetAllSymptoms();
  }

  componentWillUnmount() {
    this.setState({symptomList: []});
  }

  render() {
    return (
      <div className="table">
        <form onSubmit={this.handleSubmit}>
          <div className="table-title">
            <h1 className="table-title-text">Odpowiedz na pytania</h1>
          </div>
          <div className="header-spacing">
          </div>
          {/* <div className="row-wrapper" >
            <label className="row-wrapper-text">Aasdas asdfa</label>
            <input className="row-answer-text" type="text" name="wiek"></input>
          </div> */}
          
          {this.state.symptomList.map((item, index) => {
              return <YesNoQuestion item={item} index={index}/>
            } 
          )}

          <button className="table-button">Send</button>
        </form>
      </div>
    );
  }
}

export default FormTable;