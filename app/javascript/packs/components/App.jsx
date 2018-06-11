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

  }

  render() {
    {console.log(this.state)}

    return (
      <Filters addFilter={this.addFilter} filterState={this.state.filters} />
    )
  }
}

export default App;
