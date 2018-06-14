import React from 'react';
import { BrowserRouter, browserHistory, Route, Switch } from 'react-router-dom';
import App from './App';
import Main from './App2';

const Router = () => (
  <BrowserRouter>
    <Switch>
      {/*<Route exact path="/" component={StorePicker} /> */}
      <Route path="/search" component={Main} />
      {/*<Route component={NotFound} />*/}
    </Switch>
  </BrowserRouter>
)

export default Router;
