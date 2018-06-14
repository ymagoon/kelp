import React, { Fragment } from 'react';

class DiveCenter extends React.Component {
  render() {
    const dc = this.props.diveCenter
    return (
      <Fragment>
        <li>
          <p>{dc.name}</p>
          <p>{dc.primary_phone}</p>
          <p>{dc.email}</p>
          <p>{dc.website}</p>
          <p>{dc.dive_center_type}</p>
        </li>
        <p>---------------------</p>
      </Fragment>
    )
  }
}

export default DiveCenter;
