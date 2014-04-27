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

function Player() {
    this.name = ""
    this.pieceColor = ""
    this.piecesLeft = 12
    this.clickHolder = []
}

Player.prototype.getPlayerMoves = function() {
    var that = this;
    $('.board-cell').click(function() {
        var selected_position = $(this).attr('id');

        if (that.click_holder.length == 1) {
            that.click_holder.push(selected_position)
            $("#" + that.click_holder[0]).html("");

            var cell_unique_id = $(that).attr('id');
            console.log(that.click_holder)
            console.log(cell_unique_id)

        } else if (that.click_holder.length == 2) {
            that.click_holder.push(selected_position)
            $("#" + that.click_holder[1]).html("<div class='piece" + that.pieceColor + "\'></div>");
            console.log(that.click_holder)
            console.log(cell_unique_id)
        }
    })
}

Game = {
    winner: "",
    loser: "",
    players: [],
    over: false,
    playersReadyToMove: false,
    makePlayers: function() {
        var that = this;
        $('.game-menu').submit(function(event) {
            event.preventDefault();

            console.log(that);
            var player1 = new Player();
            player1.name = $('input[name="player1"]').val();
            player1.pieceColor = "red";
            that.players.push(player1);


            var player2 = new Player();
            player2.name = $('input[name="player2"]').val();
            player2.pieceColor = "black";
            that.players.push(player2);

            //show board and display pieces
            $('.board').show();
            $('.game-menu').hide();
            that.playersReadyToMove = true;
        });
    }
}

    $(document).ready(function() {
            // $('.board').hide();
            Game.makePlayers();

            console.log('before while loop')

            if (Game.playersReadyToMove === true ) {
                console.log("THISH HSHSH")
                    while (Game.over === false) {
                    console.log('during while loop')
                        alert('Player 1 make your move');
                        Game.players[0].getPlayerMoves();

                        alert('Player 2 make your move');
                        Game.players[1].getPlayerMoves();
                        Game.over = true;
                }

            }

            //passing data back to game logic controller -

            //calls controller to validate position
            // $.post("/game/position", data, function(response) {
            // });

            // var response = true;
            // if (response) {
            //     click_holder = [];
            //     alert('Awesome Move! Next player\'s turn');
            // } else {
            //     alert('Illegal Move! Try Again!');
            //     $("#" + click_holder[0]).html("<div class='piece black'></div>");
            //     click_holder = [];
            // }
    });
