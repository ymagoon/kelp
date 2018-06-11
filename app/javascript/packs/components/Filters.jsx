import React from 'react';
import TrainingOrganization from './filters/TrainingOrganization';

class Filters extends React.Component {
  handleChange = (e) => {
    const target = e.target;
    const value = target.type === 'checkbox' ? target.checked : target.value;
    const name = target.name;

    this.props.addFilters(name, value)
  }
  handleSubmit = (e) => {
    e.preventDefault();
    alert('this form was submitted');
  }

  render() {
    return (
      <form id="filters" onSubmit={this.handleSubmit}>
        <TrainingOrganization handleChange={this.handleChange} trainingOrganizations={this.props.filters.training_organizations} />
      </form>
    )
  }
}

export default Filters;
//
