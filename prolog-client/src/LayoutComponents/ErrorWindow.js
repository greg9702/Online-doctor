import React from 'react';
import './LayoutComponent.css';

class ResultWindow extends React.Component {

  render() {
    return (
      <div className="table">
        <div className="table-title">
          <h1 className="table-title-text">Błąd</h1>
        </div>
        <div className="header-spacing">
        </div>
        <div className="row-wrapper" >
          <label className="row-wrapper-text">Wystąpił błąd, proszę spróbować ponownie</label>
        </div>
        <button className="table-button" onClick={this.props.handler}>Back</button>
      </div>
    )}
}

export default ResultWindow;