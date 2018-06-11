import React from 'react';
import ReactDom from 'react-dom';
import Filters from './Filters';

class App extends React.Component {
  state = {
    centers: [],
    filters: {
      agency: {},
      rating: {},
      city: {},
      language: {},
      misc: {}
    }
  };

  addFilter = (filter, value) => {
    // 1. take a copy of existing state because you never want to mutate it
    const filters = {...this.state.filters}
    // 2. add our filter to our new filters variable
    filters.agency[filter] = value
    // 3. set the new fishes object to state
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

  render() {
    return (
      <Filters addFilter={this.addFilter} addDiveCenters={this.addDiveCenters} agencyState={this.state.filters.agency} />
    )
  }
}

export default App;
