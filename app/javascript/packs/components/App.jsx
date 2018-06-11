import React from 'react';
import ReactDom from 'react-dom';
import Filters from './Filters';

class App extends React.Component {
  state = {
    filters: {
      agency: {},
      rating: {},
      city: {},
      language: {},
      misc: {}
    }
  };

  addFilter = (filter) => {
    console.log(filter);
    // 1. take a copy of existing state because you never want to mutate it
    const filters = {...this.state.filters}
    // 2. add our filter to our new filters variable
    filters.agency = filter
    // 3. set the new fishes object to state
    this.setState({
      filters: filters
    });
  }

  render() {
    {console.log(this.state)}

    return (
      <Filters addFilter={this.addFilter} filterState={this.state.filters} />
    )
  }
}

export default App;
