import React from 'react';
import TrainingOrganization from './filters/TrainingOrganization';

class Filters extends React.Component {
  handleChange = (e) => {
    const target = e.target;
    const value = target.type === 'checkbox' ? target.checked : target.value;
    const name = target.name;

    this.props.addFilters(name, value, () => {
      $.getJSON(`/search?${this.props.query}`, (response) => {
            console.log(`/search?${this.props.query}`)
            console.log(response);

        });
    });
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

// setQueryParams = (param = null, value = null,callback) => {
//     const query = this.state.query;
//     // get current location
//     const location = this.props.location.search;

//     // Set params based on whether component mount or filter change
//     const params = param ? new URLSearchParams(query) : new URLSearchParams(location);

//     if (param) {
//       params.set(param, value);
//     }

//     this.setState({
//       query: params.toString()
//     },callback);

//     console.log(this.state.query); // doesn't display anything!
//   }
