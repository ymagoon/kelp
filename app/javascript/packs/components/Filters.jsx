import React from 'react';
import TrainingOrganization from './filters/TrainingOrganization';
import DiveCenterType from './filters/DiveCenterType';

class Filters extends React.Component {
  handleChange = (category, e) => {
    const target = e.target;
    const value = target.type === 'checkbox' ? target.checked : target.value;
    const name = target.name;

    this.props.addFilters(name, category, value, () => {
      $.getJSON(`/search?${this.props.query}`, (response) => {
        this.props.addDiveCenters(response.centers);
      });
    });
  }
  handleSubmit = (e) => {
    e.preventDefault();
    alert('this form was submitted');
  }

  render() {
    const filters = this.props.filters;

    return (
      <form id="filters" onSubmit={this.handleSubmit}>
        <TrainingOrganization handleChange={this.handleChange} trainingOrganizations={filters.training_organizations} />
        <DiveCenterType handleChange={this.handleChange} diveCenterTypes={filters.dive_center_types} />
      </form>
    )
  }
}

export default Filters;
