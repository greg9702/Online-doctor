import React from 'react';
import './App.css';
import FormTable from './LayoutComponents/FormTable.js';
import ResultWindow from './LayoutComponents/ResultWindow.js';
import ErrorWindow from './LayoutComponents/ErrorWindow.js';

const stageEnum = {
  ERROR: 'error',
  FORM: 'form',
  RESULT: 'result',
}

class App extends React.Component {

  constructor() {
    super();

    this.state = {
      stage: stageEnum.FORM,
      result: null,
    };

    this.setStartHanlder = this.setStartStageHandle.bind(this);
    this.setResultHanlder = this.setResultStageHandle.bind(this);
    this.setErrorHanlder = this.setErrorStageHandle.bind(this);
  }

  setStartStageHandle() {
    this.setState({result: null});
    this.setState({stage: stageEnum.FORM});
  }

  setResultStageHandle(result) {
    console.log(result);
    this.setState({result: result});
    this.setState({stage: stageEnum.RESULT});
  }

  setErrorStageHandle() {
    this.setState({stage: stageEnum.ERROR});
  }

  render() {
    let appContent;

    if (this.state.stage === stageEnum.FORM) {
      appContent = <FormTable handler={this.setResultHanlder} errorHanlder={this.setErrorHanlder}/>
    } else if (this.state.stage === stageEnum.RESULT){
      appContent = <ResultWindow result={this.state.result} handler={this.setStartHanlder} />
    } else {
      appContent = <ErrorWindow handler={this.setStartHanlder} />
    }

    return (
      <div>
        {appContent}
      </div>
    )
  }
}

export default App;
