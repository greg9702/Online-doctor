import React from 'react';
import './TextQuestion.css';


class TextQuestion extends React.Component {

  constructor() {
    super();
    this.state = {
      questionPrefix: 'Czy ma Pan/Pani ',
      questionSufix: '?',
    }
  }

  translationDictionary = {
    'age' : 'Ile ma Pan/Pani lat?',
    'temperature': 'Jaką ma Pan/Pani temperaturę?',
  }

  translateName(name) {
    // TODO add checks
    return this.translationDictionary[name];
  }

  render() {
      let toRender;

      if (this.translationDictionary[this.props.name]) {
        toRender = (
          <div className="row-wrapper">
              <label className="row-wrapper-text"> {this.translateName(this.props.name)} </label>
              <input className="row-answer-text" type="text" name={this.props.name} required></input>
          </div>
        )
      }
        
      return (
        <div>
          {toRender}
        </div>
      );
  }
}

export default TextQuestion;
