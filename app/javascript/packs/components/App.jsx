import React from 'react';
import ReactDom from 'react-dom';
import Filters from './Filters';

class App extends React.Component {
  state = {
    centers: [],
    filters: {
      training_organizations: {},
      rating: {},
      city: {},
      language: {},
      misc: {}
    }
  };

  // Builds filters when the page is first loaded
  buildFilters = (filter, value) => {
    // take copy of existing filters
    const filters = {...this.state.filters}
    // merge existing filters with new filters
    const newFilters = {...filters, ...filter}

    // set everything to false
    // for(let category in newFilters) {
    //     if(newFilters.hasOwnProperty(category)){
    //       console.log(category);
    //       console.log(category.typeof);
    //         // var foundLabel = findObjectByLabel(obj[i], label);
    //         // if(foundLabel) { return foundLabel; }
    //     }
    // }


    this.setState({
      filters: newFilters
    });
  }

  // Adds or removes a filter based on the user input
  addFilters = (filter, value) => {
    const filters = {...this.state.filters}
    filters.training_organizations[filter] = value

    this.setState({
      filters: filters
    });
  }

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
  }

  render() {
    return (
      <Filters addFilters={this.addFilters} addDiveCenters={this.addDiveCenters} filters={this.state.filters} />
    )
  }
}

export default App;
