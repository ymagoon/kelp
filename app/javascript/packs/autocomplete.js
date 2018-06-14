$(document).ready(function(){
  const data = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.whitespace,
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    limit: 5,
    remote: {
      url: '/dive_centers/autocomplete?query=%QUERY',
      wildcard: '%QUERY'
      // transform: (response) => {
      //   console.log(response);
      // }
    }
  });

  const locations = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.whitespace,
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    limit: 5,
    remote: {
      url: '/dive_centers/autocomplete?query=%QUERY',
      wildcard: '%QUERY'
    }
  });

  $('#search').typeahead(null, {
    source: data,
    hint: true,
    templates: {
      suggestion: function (data) {
        return '<p><strong>' + data.name + '</strong> - '+ data.rent_computer +'</p>';
      }
    },

  });
})


// $('#multiple-datasets .typeahead').typeahead({
//   highlight: true
// },
// {
//   name: 'nba-teams',
//   display: 'team',
//   source: nbaTeams,
//   templates: {
//     header: '<h3 class="league-name">NBA Teams</h3>'
//   }
// },
// {
//   name: 'nhl-teams',
//   display: 'team',
//   source: nhlTeams,
//   templates: {
//     header: '<h3 class="league-name">NHL Teams</h3>'
//   }
// });


// var myData;

// $.get('http://some.url/get_my_data', function(data){
//   myData = data;  // capture the data from your remote call so you can use local data sources.

//   // create your bloodhound data sources for each of your data sets using LOCAL sources
//   var dataSource1 = new Bloodhound({
//                     datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
//                     queryTokenizer: Bloodhound.tokenizers.whitespace,
//                     local: myData.dataset1,  // set this to the first data set coming back from your remote source
//                     limit:3
//                 });
//   var dataSource2 = new Bloodhound({
//                     datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
//                     queryTokenizer: Bloodhound.tokenizers.whitespace,
//                     local: myData.dataset2, // set this to the second data set coming back from your remote source
//                     limit:3
//                 });

//   // declare typeahead as you normally would for multiple data sets
//   $('#my-typeahead').typeahead({
//                     highlight: true,
//                 },
//                 {
//                     name: 'dataset-1',
//                     displayKey: 'value',
//                     source: dataSource1.ttAdapter()
//                 },
//                 {
//                     name: 'dataset-2',
//                     displayKey: 'value',
//                     source: dataSource2.ttAdapter()
//                 });
// });
