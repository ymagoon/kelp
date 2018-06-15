  <DataSearch
            componentId="mainSearch"
            dataField={["original_title.search"]}
            className="search-bar"
            queryFormat="and"
            placeholder="Search for movies..."
          />
          <MultiList
            componentId="genres-list"
            dataField="genres_data.raw"
            className="genres-filter"
            size={20}
            sortBy="asc"
            queryFormat="or"
            selectAllLabel="All Genres"
            showCheckbox={true}
            showCount={true}
            showSearch={true}
            placeholder="Search for a Genre"
            react={{
                and: [
                    "mainSearch",
                    "results",
                    "date-filter",
                    "RangeSlider",
                    "language-list",
                    "revenue-list"
                ]
            }}
            showFilter={true}
            filterLabel="Genre"
            URLParams={false}
            innerClass={{
                label: "list-item",
                input: "list-input"
            }}
          />

             <SingleRange
              componentId= "revenue-list"
              dataField= "ran_revenue"
              className= "revenue-filter"
              data={[
                { start: 0, end: 1000, label: "< 1M" },
                { start: 1000, end: 10000, label: "1M-10M" },
                { start: 10000, end: 500000, label: "10M-500M" },
                { start: 500000, end: 1000000, label: "500M-1B" },
                { start: 1000000, end: 10000000, label: "> 1B" }
              ]}
              showRadio={true}
              showFilter={true}
              filterLabel="Revenue"
              URLParams={false}
              innerClass= {{
                label: "revenue-label",
                radio: "revenue-radio"
              }}
          />
          <RangeSlider
            componentId="RangeSlider"
            dataField="vote_average"
            className="review-filter"
            title="ratings"
            range={{
              start: 0,
              end: 10
            }}
            rangeLabels={{
              start: "0",
              end: "10"
            }}
            react={{
              and: [
                "mainSearch",
                "results",
                "language-list",
                "date-Filter",
                "genres-list",
                "revenue-list"
              ]
            }}
          />
          <MultiDataList
            componentId="language-list"
            dataField="original_language.raw"
            className="language-filter"
            title="language"
            size={100}
            sortBy="asc"
            queryFormat="or"
            selectAllLabel="All Languages"
            showCheckbox={true}
            showSearch={true}
            placeholder="Search for a language"
            react={{
              and: [
                "mainSearch",
                "results",
                "date-filter",
                "RangeSlider",
                "genres-list",
                "revenue-list"
              ]
            }}
            data={[
              {
                label: "English",
                value: "English"
              },
              {
                label: "Chinese",
                value: "Chinese"
              },
              {
                label: "Hindi",
                value: "Hindi"
              }
            ]}
            showFilter={true}
            filterLabel="Language"
            URLParams={false}
            innerClass={{
              label: "list-item",
              input: "list-input"
            }}
          />
          <DateRange
            componentId="date-filter"
            dataField="release_date"
            className="datePicker"
          />

            <ResultCard
            componentId="results"
            dataField="original_title"
            pagination={true}
            paginationAt="bottom"
            pages={5}
            size={12}
            Loader="Loading..."
            showResultStats={true}
            noResults="No results were found..."
            sortOptions={[
              {
                dataField: "revenue",
                sortBy: "desc",
                label: "Sort by Revenue(High to Low)"
              },
              {
                dataField: "popularity",
                sortBy: "desc",
                label: "Sort by Popularity(High to Low)"
              },
              {
                dataField: "vote_average",
                sortBy: "desc",
                label: "Sort by Ratings(High to Low)"
              },
              {
                dataField: "original_title.raw",
                sortBy: "asc",
                label: "Sort by Title(A-Z)"
              }
            ]}
            className="Result_card"
            innerClass={{
              title: "result-title",
              listItem: "result-item",
              list: "list-container",
              sortOptions: "sort-options",
              resultStats: "result-stats",
              resultsInfo: "result-list-info",
              poweredBy: "powered-by"
            }}
            react={{
              and: [
                "mainSearch",
                "RangeSlider",
                "language-list",
                "date-filter",
                "genres-list",
                "revenue-list"
              ]
            }}
            onData={function(res) {
              return {
                description: (
                  <div className="main-description">
                    <div className="ih-item square effect6 top_to_bottom">
                      <a
                        target="#"
                        href={"http://www.imdb.com/title/" + res.imdb_id}
                      >
                        <div className="img">
                          <img
                            src={
                              "https://image.tmdb.org/t/p/w500" +
                              res.poster_path
                            }
                            alt={res.original_title}
                            className="result-image"
                          />
                        </div>
                        <div className="info colored">
                          <h3 className="overlay-title">
                            {res.original_title}
                          </h3>

                          <div className="overlay-description">
                            {res.tagline}
                          </div>

                          <div className="overlay-info">
                            <div className="rating-time-score-container">
                              <div className="sub-title Rating-data">
                                <b>
                                  Imdb
                                  <span className="details">
                                    {" "}
                                    {res.vote_average}/10{" "}
                                  </span>
                                </b>
                              </div>
                              <div className="time-data">
                                <b>
                                  <span className="time">
                                    <i className="fa fa-clock-o" />{" "}
                                  </span>{" "}
                                  <span className="details">
                                    {res.time_str}
                                  </span>
                                </b>
                              </div>
                              <div className="sub-title Score-data">
                                <b>
                                  Score:
                                  <span className="details">
                                    {" "}
                                    {res.score}
                                  </span>
                                </b>
                              </div>
                            </div>
                            <div className="revenue-lang-container">
                              <div className="revenue-data">
                                <b>
                                  <span>Revenue:</span>{" "}
                                  <span className="details">
                                    {" "}
                                    ${res.or_revenue}
                                  </span>{" "}
                                </b>
                              </div>

                              <div className="sub-title language-data">
                                <b>
                                  Language:
                                  <span className="details">
                                    {" "}
                                    {res.original_language}
                                  </span>
                                </b>
                              </div>
                            </div>
                          </div>
                        </div>
                      </a>
                    </div>
                  </div>
                ),
                url: "http://www.imdb.com/title/" + res.imdb_id
              };
            }}
          />
