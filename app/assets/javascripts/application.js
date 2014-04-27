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
    this.controllerData = {
        start_loc: "",
        end_loc: "",
        unique_piece_id: ""
    }
}

Player.prototype.getPlayerMoves = function() {
    var that = this;
    $('.board-cell').click(function() {
        var selected_position = $(this).attr('id');
        var pieceId = $(".board-cell > div").attr('id');

        that.controllerData.unique_piece_id = pieceId;

        if (that.clickHolder.length === 0) {
            that.clickHolder.push(selected_position)
            $("#" + that.clickHolder[0]).html("");

            // var cell_unique_id = $(that).attr('id');
            that.controllerData.start_loc = selected_position;

        } else if (that.clickHolder.length === 1) {
            that.clickHolder.push(selected_position)
            $("#" + that.clickHolder[1]).html("<div class='piece " + that.pieceColor + "\'></div>");

            that.controllerData.end_loc = selected_position;
            console.log("cd.. " + that.controllerData)
        }
    })
}

Game = {
    winner: "",
    loser: "",
    players: [],
    over: false,
    init: function() {
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

            //cue movement
            that.startRound(that.validateMove);

        });
    },
    startRound: function(callback) {
        this.players[0].getPlayerMoves();
        // var data = this.players[0].controllerData;

        //checking if server gives correct response
        var data = {
            start_loc: "51",
            end_loc: "40",
            unique_piece_id: "B1"
        }

        //next line needs to wait until there's data to send before executing
        if (!data.end_loc == "") {
            console.log(data)
            callback(data);
        }

    },
    validateMove: function(data) {
        $.post("/make_move", data, function(response) {
            console.log(responose)
        });
    }

}




$(document).ready(function() {
    // $('.board').hide();
    Game.init();



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