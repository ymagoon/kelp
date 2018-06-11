import React from 'react';
import Agency from './filters/Agency';

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

  // componentDidMount() {
  //   console.log('mounted');
  //   $.getJSON('/search', (response) => { this.props.addDiveCenters(response) });
  // }
// this.setState({ items: response })
  render() {
    return (
      <form id="filters" onSubmit={this.handleSubmit}>
        <Agency handleChange={this.handleChange} trainingOrganizations={this.props.filters.training_organizations} isChecked={this.props.filters.training_organizations} />
      { /*
        <input type="text" placeholder="smd" onChange={this.handleChange} />
        <input type="submit" value="Submit" />
        <Agency addFilters={this.props.addFilters} /> */ }
      </form>
    )
  }
}

export default Filters;
//
