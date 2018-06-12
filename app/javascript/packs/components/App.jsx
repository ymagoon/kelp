import React, { Fragment } from 'react';
import ReactDom from 'react-dom';
import Filters from './Filters';
import DiveCenterList from './DiveCenterList';

class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
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
  }

  // Set the query parameters on page load
  setQueryParams = (param = null, value = null) => {
    const query = this.state.query;
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
  addFilters = (filter, value, callback) => {
    const filters = {...this.state.filters}
    filters.training_organizations[filter].checked = value

    this.setQueryParams(filter, value);

    this.setState({
      filters: filters
    }, callback);
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
    this.setQueryParams();

    // $.ajax({
    //   dataType: "json",
    //   url: `/search${this.props.location.search}`,
    //   cache: false,
    //   success: function (response) {
    //     console.log(response.filters);
    //     // this.addDiveCenters(response.centers)
    //     this.buildFilters(response.filters, false)
    //   }
    // });

    $.getJSON(`/search${this.props.location.search}`, (response) => {
      this.addDiveCenters(response.centers)
      this.buildFilters(response.filters, false)
    });
  }

  render() {
    return (
      <Fragment>
        <Filters addFilters={this.addFilters} addDiveCenters={this.addDiveCenters} filters={this.state.filters} query={this.state.query} />
        <div id="dc-container">
          <DiveCenterList diveCenters={this.state.centers} />
        </div>
      </Fragment>
    )
  }
}

export default App;
