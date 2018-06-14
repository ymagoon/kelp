import React from 'react';
class DiveCenterType extends React.Component {
  constructor(props) {
    super(props);
    console.log(this.props.diveCenterTypes);
  }
  render() {
    const diveCenterTypes = this.props.diveCenterTypes;

    // Loop through the keys of each dive center type and display a checkbox for each
    const filters = Object.keys(diveCenterTypes).map((type) => {
      return (
        <input name={type}
               key={type}
               type="checkbox"
               checked={diveCenterTypes[type].checked || false}
               onChange={(e) => this.props.handleChange("dive_center_types", e)} />
      )
    });

    return filters;
  }
}

export default DiveCenterType;
