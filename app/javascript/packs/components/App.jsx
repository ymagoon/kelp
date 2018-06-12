import React, { Fragment } from 'react';
import ReactDom from 'react-dom';
import Filters from './Filters';
import DiveCenterList from './DiveCenterList';

class App extends React.Component {
  state = {
    centers: [],
    filters: {
      training_organizations: {},
      rating: {},
      city: {},
      language: {},
      misc: {}
    },
    query: ''
  };

  // Set the query parameters on page load
  setQueryParams = (param = null, value = null) => {
    const query = this.state.query;
    console.log(query);
    // get current location
    const location = this.props.location.search;

    // Set params based on whether component mount or filter change
    const params = param ? new URLSearchParams(query) : new URLSearchParams(location);

    if (param) {
      params.set(param, value);
    }

    this.setState({
      query: params.toString()
    });
  }

  // Builds filters when the page is first loaded
  buildFilters = (filter, value) => {
    const filters = {...this.state.filters}

    // filters passed as 'PADI:<number>', changing to PADI: {checked: false, num: <number>}
    Object.keys(filter.training_organizations).forEach(key => {
      filter.training_organizations[key] = {checked: false, total: filter.training_organizations[key]}
    });

    // merge existing filters with new filters
    const newFilters = {...filters, ...filter}

    this.setState({
      filters: newFilters
    });
  }

  // Adds or removes a filter based on the user input
  addFilters = (filter, value) => {
    const filters = {...this.state.filters}
    filters.training_organizations[filter].checked = value

    this.setState({
      filters: filters
    });

    this.setQueryParams(filter, value);
  }

  // Adds or removes a dive center from state
  addDiveCenters = (newDiveCenters) => {
    const diveCenters = {...this.state};
    diveCenters.centers = newDiveCenters;

    this.setState({
      centers: diveCenters.centers
    });
  }

  componentDidMount() {
    $.getJSON('/search?search=cebu', (response) => {
      this.addDiveCenters(response.centers)
      this.buildFilters(response.filters, false)
    });

    this.setQueryParams();
  }

  render() {
    return (
      <Fragment>
        <Filters addFilters={this.addFilters} addDiveCenters={this.addDiveCenters} filters={this.state.filters} />
        <DiveCenterList diveCenters={this.state.centers} />
      </Fragment>
    )
  }
}

export default App;
