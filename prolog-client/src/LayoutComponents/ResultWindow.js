import React from 'react';
import './LayoutComponent.css';

class ResultWindow extends React.Component {

  translateName(name) {
    if (name) {
      return name.replaceAll('_', ' ');
    }
    return name;
  }

  render() {
    return (
      <div className="table">
        <div className="table-title">
          <h1 className="table-title-text">Wynik</h1>
        </div>
        <div className="header-spacing">
        </div>
        <div className="row-wrapper" >
          {this.props.result
          ? <label className="row-wrapper-text">Moja diagnoza to { this.translateName(this.props.result) }</label>
          : <label className="row-wrapper-text">Nie udało się postawić diagnozy</label>
          }
        </div>
        <button className="table-button" onClick={this.props.handler}>Back</button>
      </div>
    )}
}

export default ResultWindow;