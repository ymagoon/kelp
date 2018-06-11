import React from 'react';
import { BrowserRouter, browserHistory, Route, Switch } from 'react-router-dom';
import App from './App';

const Router = () => (
  <BrowserRouter>
    <Switch>
      {/*<Route exact path="/" component={StorePicker} /> */}
      <Route path="/search" component={App} />
      {/*<Route component={NotFound} />*/}
    </Switch>
  </BrowserRouter>
)

export default Router;
