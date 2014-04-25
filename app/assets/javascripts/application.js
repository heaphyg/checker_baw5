// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require websocket_rails/main
//= require_tree .

click_holder = []

Game = {
    init: [],
}

$(document).ready(function() {
    // $('.board').hide();

    $('.game-menu').submit(function(event){
      event.preventDefault();
      var p1name = $('input[name="player1"]').val();
      var p2name = $('input[name="player2"]').val();

        console.log(p1name);
        console.log(p2name);

        //show board and display pieces
        $('.board').show();
        // $('#00').html("<div class='piece black'></div>");
        $('.game-menu').hide()
        alert('Player 1 make your move');

    });

    //passing data back to game logic controller -
    $('.board-cell').click(function() {
        var selected_position = $(this).attr('id');
        if (click_holder.length < 2) {
            click_holder.push(selected_position)

            $("#" + click_holder[0]).html("");
            $("#" + click_holder[1]).html("<div class='piece black'></div>");
            var cell_unique_id = $(this).attr('id');
            console.log(click_holder)
            console.log(cell_unique_id)
        }

        // $.post("/game/position", data, function(response){
        //what to do with the response
        // });

        var response = true;

        if (response) {
            click_holder = [];
            alert('Awesome Move! Next player\'s turn');
        } else {
            alert('Illegal Move! Try Again!');
            $("#" + click_holder[0]).html("<div class='piece black'></div>");
            click_holder = [];
        }

    });

});
