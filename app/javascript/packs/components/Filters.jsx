import React from 'react';
import Agency from './filters/Agency';

class Filters extends React.Component {
  handleChange = (e) => {
    const target = e.target;
    const value = target.type === 'checkbox' ? target.checked : target.value;
    const name = target.name;

    this.props.addFilter(name, value)
  }
  handleSubmit = (e) => {
    e.preventDefault();
    alert('this form was submitted');
  }

  render() {
    return (
      <form id="filters" onSubmit={this.handleSubmit}>
        <Agency handleChange={this.handleChange} isChecked={this.props.agencyState} />
      { /*
        <input type="text" placeholder="smd" onChange={this.handleChange} />
        <input type="submit" value="Submit" />
        <Agency addFilter={this.props.addFilter} /> */ }
      </form>
    )
  }
}

export default Filters;
//
