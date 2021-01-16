import React from 'react';
import './LayoutComponent.css';
import YesNoQuestion from './../QuestionComponents/YesNoQuestion.js';
import TextQuestion from './../QuestionComponents/TextQuestion.js';
import Switch from './Switch.js';

const pythonPort = 5000;
const prologPort = 8080;

class FormTable extends React.Component {
  constructor() {
    super();
    this.handleSubmit = this.sendSubmitDiagnose.bind(this);
    this.handleToggle = this.toogleState.bind(this);
    this.state = {
      serverAddress: 'http://localhost:',
      serverPort: prologPort,
      postApi: '/api/diagnose',
      getApi: '/api/symptoms',
      symptomList: []
    }
  }

  async toogleState() {
    if (this.state.serverPort === pythonPort) {
      await this.setState({serverPort: prologPort});
    } else {
      await this.setState({serverPort: pythonPort});
    }
    this.sendGetAllSymptoms();
  }

  sendSubmitDiagnose(event) {
    const data = new FormData(event.target);
    let dataToSend = {'objawy': []};
    let xd = this.state.symptomList;
    for (var x of data) {
      if (this.state.symptomList.includes(x[0]) ) {
        if (x[1] === 'yes') {
          dataToSend['objawy'].push(x[0]);
        }
      } else {
        dataToSend[x[0]] = x[1];
      }
    }

    const requestOptions = {
      method: 'POST',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(dataToSend),
    };

    let resultName = null;
    
    fetch(this.state.serverAddress + this.state.serverPort + this.state.postApi, requestOptions)
    .then((response) => {
      if (response.status === 200) {
        response.json().then(data => {
          console.log('received response: ', data);
          if (data['diagnose']) {
            resultName = data['diagnose'][0];
            this.props.handler(resultName);
          } else {
            // no diagnose found
            this.props.handler(null);
          }
        });
      } else {
        // error occured
        throw Error(response.statusText)
      }
    }).catch(error => {
      this.props.errorHanlder();
      console.log("Error sending request")
    })
    event.preventDefault();
  }

  sendGetAllSymptoms() {
    fetch(this.state.serverAddress + this.state.serverPort + this.state.getApi)
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

          <div className="server-switch">
            <span className="server-switch-element">Prolog</span>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span></span>
            <span className="server-switch-element">Python</span>
            <div className="server-switch-element-spacing"></div>
            <Switch handleToggle={this.handleToggle}/>
          </div>

          <TextQuestion name={"wiek"}/>
          <TextQuestion name={"temperatura"}/>
          
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