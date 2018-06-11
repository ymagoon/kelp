import React from 'react';
import Agency from './filters/Agency';

class Filters extends React.Component {
  handleChange = (e) => {
    this.props.addFilter(e.target.value)
    // this.setState({ filters: e.target.value})
  }
  handleSubmit = (e) => {
    e.preventDefault();
    alert('this form was submitted');
  }

  render() {
    {console.log(this.props.filterState)}
    return (
      <form id="filters">
        <input type="text" value='smd' onChange={this.handleChange} />
        <input type="submit" value="Submit" />

      </form>
    )
  }
}

export default Filters;
// <Agency addFilter={this.props.addFilter} />
