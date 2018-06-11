import React from 'react'
import ReactDOM from 'react-dom'

class Testing extends React.Component {
  render() {
    return (
      <ul className="centers">
      sup
        {/*{Object.keys(this.state.fishes).map(key => <Fish key={key} details={this.state.fishes[key]} index={key} addToOrder={this.addToOrder} /> )}*/}
      </ul>
    )
  }
}


// document.addEventListener('DOMContentLoaded', () => {
//   const node = document.getElementById('dive_center_data');
//   const data = JSON.parse(node.getAttribute('data'));
//   ReactDOM.render(
//     <Hello name="React" />,
//     document.body.appendChild(document.createElement('div')),
//   )
// })

export default Testing;
