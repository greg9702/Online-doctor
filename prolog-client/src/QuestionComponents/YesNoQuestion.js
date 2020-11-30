import React from 'react';
import './YesNoQuestion.css';

class YesNoQuestion extends React.Component {

  constructor() {
    super();
    this.state = {
      questionPrefix: 'Czy ma Pan/Pani ',
      questionSufix: '?',
    }
  }

  translateName(name) {
    return name.replaceAll('_', ' ');
  }

  render() {
      return (
        <div className="row-wrapper" key={ this.props.index }>
        <label className="row-wrapper-text"> { this.state.questionPrefix } { this.translateName(this.props.item) }{ this.state.questionSufix }</label>
        <span className="question-answer-checkbox">
        <span className="question-answer-checkbox-label">Tak</span>
          <input className="checkbox-bullet" type="radio" name={ this.props.item } value="yes"/>
          <span className="question-answer-checkbox-label">Nie</span>
          <input className="checkbox-bullet" type="radio" name={ this.props.item } value="no"/>
        </span>
        </div>
      );
  }
}

export default YesNoQuestion;
