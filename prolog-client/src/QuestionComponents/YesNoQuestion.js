import React from 'react';
import './YesNoQuestion.css';

class YesNoQuestion extends React.Component {

  render() {
      console.log('prop:', this.props.index)

      return (
        <div className="row-wrapper" key={ this.props.index }>
        <label className="row-wrapper-text">Do you agree { this.props.item }</label>
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
