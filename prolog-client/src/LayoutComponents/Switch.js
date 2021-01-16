import React from 'react';
import './Switch.css';

const Switch = ({handleToggle}) => {
  return (
    <>
      <input
        className="react-switch-checkbox"
        onChange={handleToggle}
        id={`react-switch-new`}
        type="checkbox"
      />
      <label
        className="react-switch-label"
        htmlFor={`react-switch-new`}
      >
        <span className={`react-switch-button`} />
      </label>
    </>
  );
};

export default Switch;