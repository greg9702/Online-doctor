import React from 'react';
import './App.css';
import FormTable from './LayoutComponents/FormTable.js';
import ResultWindow from './LayoutComponents/ResultWindow.js';

const stageEnum = {
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

  render() {

    let appContent;

    if (this.state.stage === stageEnum.FORM) {
      appContent = <FormTable handler={this.setResultHanlder}/>
    } else {
      appContent = <ResultWindow result={this.state.result} handler={this.setStartHanlder} />
    }

    return (
      <div>
        {appContent}
      </div>
    )
  }
}

export default App;
