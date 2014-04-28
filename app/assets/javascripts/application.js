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


//Helper Functions
function trimClass(class_text) {
    var re = /\s.+$/;
    var thing = re.exec(class_text);
    return $.trim(thing)
}


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

        //validates initial move is the right color for player
        var clicked_position_first_child = $(this).find(':first-child');
        var pieceId = $(clicked_position_first_child).attr('id');
        var pieceClass = $(clicked_position_first_child).attr('class');

        //get color of second cell
        var clicked_position_class = $(this).attr('class');

        console.log(selected_position + " " + pieceId + " " + pieceClass);

        var initialPieceColor = trimClass(pieceClass);


        if (that.clickHolder.length === 0) {

            if (initialPieceColor == that.pieceColor) {
                that.controllerData.unique_piece_id = pieceId;
                that.clickHolder.push(selected_position);
                $("#" + that.clickHolder[0]).html("");
                that.controllerData.start_loc = selected_position;
            } else {
                alert("Wrong color moron. Try again!");
            }

        } else if (that.clickHolder.length === 1) {
            var trimmed_clicked_position_class = trimClass(clicked_position_class);

            if (trimmed_clicked_position_class == "red") {
                that.clickHolder.push(selected_position);
                $("#" + that.clickHolder[1]).html("<div class='piece " + that.pieceColor + "\'></div>");
                that.controllerData.end_loc = selected_position;
            } else {
                alert('Ehh, so you\'ve never played checkers before. Try again!');
            }
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

            //cue movement, that.validateMove
            that.startRound();

        });
    },
    startRound: function() {
        this.players[0].getPlayerMoves();
        // var data = this.players[0].controllerData;

        //checking if server gives correct response
        var data = {
            start_loc: "51",
            end_loc: "40",
            unique_piece_id: "B1"
        }

        var new_data = JSON.stringify(data)

        //next line needs to wait until there's data to send before executing
        // if (!data.end_loc == "") {
        console.log(data)
        // callback(new_data);
        // }

    },
    validateMove: function(data) {
        $.post("/make_move", data, function(response) {
            console.log(response);
        });
    }

}



$(document).ready(function() {

    Game.init();

});