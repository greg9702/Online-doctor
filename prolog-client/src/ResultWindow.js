import React from 'react';

class ResultWindow extends React.Component {

  render() {
    return (
      <div>
        <div>
          Result: {this.props.result}
        </div>
        <button onClick={this.props.handler}>Back</button>
      </div>
    )}
}

export default ResultWindow;