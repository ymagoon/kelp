$(document).ready(function(){
  let dcs = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.whitespace,
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    remote: {
      url: '/dive_center/autocomplete?query=%QUERY',
      wildcard: '%QUERY'
    }
  });
  $('#search').typeahead(null, {
    source: dcs
  });
})
