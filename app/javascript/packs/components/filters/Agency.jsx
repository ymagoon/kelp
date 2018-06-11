import React, { Fragment } from 'react';

class Agency extends React.Component {
  render() {
    return (
      <Fragment>
        <input name="padi"
               type="checkbox"
               checked={this.props.isChecked['padi'] || false}
               onChange={this.props.handleChange} />
        <input name="ssi"
               type="checkbox"
               checked={this.props.isChecked['ssi'] || false}
               onChange={this.props.handleChange} />
      </Fragment>
    )
  }
}

export default Agency;
