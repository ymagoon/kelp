import React, { Component } from 'react';
import { ReactiveBase,
         DataSearch,
         ResultList
       }
       from '@appbaseio/reactivesearch';
// import { MultiDataList, DateRange, ResultCard, TextField } from '@appbaseio/reactivesearch';

class Main extends React.Component {
  render() {
    return (
      <div className="main-container">
        <ReactiveBase
          app="dive_centers_development_20180615145932138"
          url="http://localhost:9200">

          <DataSearch
            componentId="mainSearch"
            dataField={["country.search",
                        "country.raw",
                        "city.search",
                        "city.raw",
                        "state.search",
                        "state.raw",]}
            className="search-bar"
            queryFormat="and"
            placeholder="Discover your next dive destination..."
            fuzziness={1} // when a user types
            defaultSuggestions={[{label: "Philippines", value: "Philippines"},
                                 {label: "Indonesia", value: "Indonesia"},
                                 {label: "Mexico", value: "Mexico"},
                                 {label: "Bahamas", value: "Bahamas"}]}
            autosuggest={true}
            showClear={true}
          />

          <ResultList
            componentId="searchResult"
            dataField={"country"}
            size={10}
            className="result-list-container"
            noResults="No dive centers found..."
            Loader="Loading..."
            react={{
              and: 'mainSearch',
            }}
            onData={this.dcList}
          />
        </ReactiveBase>
      </div>
    );
  }
  dcList(data) {
    // console.log(data);
    return {
      title: <div className="dive-center-name" dangerouslySetInnerHTML={{ __html: data.name }} />,
      description: (
        <div className="flex column justify-space-between">
          <div>
            <div><span className="email">http://{data.website}</span></div>
            <div><span className="email">{data.email}</span></div>
            <div><span className="fb">{data.fb}</span> </div>
            <div>city: <span className="fb">{data.city}</span> </div>
            <div>state:<span className="fb">{data.state}</span> </div>
            <div>country:<span className="fb">{data.country}</span> </div>
            <div className="ratings-list flex align-center">
             {/* <span className="stars">
                {
                  Array(data.average_rating_rounded).fill('x')
                    .map((item, index) => <i className="fas fa-star" key={index} />) // eslint-disable-line
                }
              </span>*/}
              <span className="phone">{data.phone_number}</span>
            </div>
          </div>
        </div>
      )
    };
  }
}
export default Main;
