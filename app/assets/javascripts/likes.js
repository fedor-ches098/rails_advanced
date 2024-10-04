$(document).on('turbolinks:load', function() {
  function updateVoteDisplay(data, isVoting) {
    var voteClass = '.' + data.klass + '-' + data.id;
    $(voteClass + ' .rating').html(data.rating);
    
    if (isVoting) {
      $(voteClass + ' .voting').addClass('hidden');
      $(voteClass + ' .revoke-link').removeClass('hidden');
    } else {
      $(voteClass + ' .revoke-link').addClass('hidden');
      $(voteClass + ' .voting').removeClass('hidden');
    }
  }

  $('.vote .voting').on('ajax:success', function(e) {
    var data = e.detail[0];
    updateVoteDisplay(data, true);
  });

  $('.vote .revoke').on('ajax:success', function(e) {
    var data = e.detail[0];
    updateVoteDisplay(data, false);
  });
});
