/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import React from 'react';
import { render } from 'react-dom';

import 'typeahead';
import './autocomplete';
import Router from './components/Router';

// find another way to do this without turning off caching. this makes another
// request to the DB
$.ajaxSetup({cache: false})

if (document.querySelector('#test') != null) {
  render(<Router />, document.querySelector('#test'));
}
