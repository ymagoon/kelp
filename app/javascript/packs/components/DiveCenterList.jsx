import React from 'react';
import DiveCenter from './DiveCenter';

class DiveCenterList extends React.Component {
  render() {
    // Loop through the keys of each dive center and pass it to DiveCenter component
    const diveCenterList = Object.keys(this.props.diveCenters).map((dc) => {
      return (
        <DiveCenter diveCenter={this.props.diveCenters[dc]} />
      )
    });

    return diveCenterList;
  }
}

export default DiveCenterList;
