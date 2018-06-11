import React, { Fragment } from 'react';

class TrainingOrganization extends React.Component {
  render() {
    const trainingOrganizations = this.props.trainingOrganizations;

    // Loop through the keys of each training organization and display a checkbox for each
    const filters = Object.keys(trainingOrganizations).map((agency) => {
      return (
        <input name={agency}
               key={agency}
               type="checkbox"
               checked={trainingOrganizations[agency] || false}
               onChange={this.props.handleChange} />
      )
    });

    return filters;
  }
}

export default TrainingOrganization;
