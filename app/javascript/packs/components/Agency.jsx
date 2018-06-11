import React from 'react';

class Agency extends React.Component {
  render() {
    return (
       <input type="text" value='smd' onChange={this.handleChange} />
       <input type="submit" value="Submit" />
    )
  }
}

export default Agency;
