import React from 'react';
import './YesNoQuestion.css';

class YesNoQuestion extends React.Component {
  constructor() {
      super();
    }

  componentDidMount() {
    // fetch api here
    console.log("DDDDDDDDDDDDDDDD");
  }

  render() {
      return (
          <div>
            { this.props.value }
          </div>
      );
  }
}


export default YesNoQuestion;
