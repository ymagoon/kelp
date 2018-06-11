import React from 'react';
import Agency from './filters/Agency';

class Filters extends React.Component {
  handleChange = (e) => {
    this.setState({ filters: e.target.value})
  }
  handleSubmit = (e) => {
    e.preventDefault();
    alert('this form was submitted');
  }

  render() {
    {console.log(this.props.filterState)}
    return (
      <form id="filters">
       <Agency addFilter={this.props.addFilter} />
      </form>
    )
  }
}

export default Filters;
