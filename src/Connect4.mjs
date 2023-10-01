/******************************************
 * 
 * Fabian Kirberg 
 * 
 *****************************************/

import { exit } from 'node:process';      // Provides the exit method (if you need it)
import * as readline from 'node:readline';


// I put this here because, in my opinion, the entire program should use the same io object.\
const io = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
  });

// Make the Connect4 class available externally.
// You are not required to use an OO design.  You can use any reasonable structure you like
// You can also change the exports if you like.
export default class Connect4 {

    // Use private instance variables where appropriate
    #numRows;
    #numCols;
    #winLength;
    #board;
    

    constructor(numRows, numCols, winLength) {  
        this.#numRows = numRows;
        this.#numCols = numCols;
        this.#winLength = winLength;
        this.#board = new Array(this.#numRows);
        console.log(`Constructor ${numRows}  ${numCols}  ${winLength}`)   

    }

    header() {
        return 'A B C D E F G H I J K L M O P'.substring(0, this.#numCols*2);
    }

    makeBoard() {
        // I was just playing around with different ideas.  Feel free to delete this
        // if you don't like it.
        // this.#board = Array(this.#numRows).fill(1).map(() => Array(this.#numCols).fill(-1));
    
        for(let i = 0; i < this.#numRows; i++) {
            this.#board[i] = new Array(this.#numCols);
            for(let j = 0; j < this.#numCols; j++) {
               this.#board[i][j] = 0;
            }
         }
    }

    // Prints the formatted board.
    printBoard() {
        for(let i = 0; i < this.#numRows; i++) {
            console.log(...this.#board[i]);
        }
        console.log(this.header());
    }

    // Get user input using asynchronous I/O and callback.
    fetchColumn(player, callback) {
        io.question(`Player ${player}, which Column? `, line => {
            console.log(`You requested "${line}"`);
            callback(player, line);  // Your callback will probably take parameters.
           });
    }

    // Helper method to close io stream and exit.
    quit() {
        console.log("Goodbye.");
        io.close();
        exit();
    }

    // Helper method to place token in lowest possible row of selected column.
    makeMove(player, column) {
        column = column.charCodeAt(0)-"A".charCodeAt(0);
        for (let i = this.#numRows-1; i >= 0; i--) {
            if (this.#board[i][column] == 0) {
                this.#board[i][column] = player;
                break;
            }
        }
        this.printBoard();
    }

    // Check for win condition. 
    xInARow(player) {
        // Loop through every value of board.
        for(let i = 0; i < this.#numRows; i++) {
            for(let j = 0; j < this.#numCols; j++) {
                let upRightCounter = 1;
                let downRightCounter = 1;
                let horizontalCounter = 1;
                let verticalCounter = 1;
    
                // Only check for win if current board value is a player's token.
                if (this.#board[i][j] == player) {
                    // Up Right Diagonal Check. Only runs if board has enough room for a win.
                    if (i >= this.#winLength-1) {
                        while((upRightCounter < this.#winLength) && this.#board[i][j] == player && this.#board[i - upRightCounter][j + upRightCounter] == player)
                            upRightCounter++;
                    }
                    // Down Right Diagonal and Vertical Check. Only runs if board has enough room for a win.
                    if (i <= (this.#numRows - this.#winLength)) {
                        while((downRightCounter < this.#winLength) && this.#board[i][j] == player && this.#board[i + downRightCounter][j + downRightCounter] == player)
                            downRightCounter++;
                        while((verticalCounter < this.#winLength) && this.#board[i][j] == player && this.#board[i + verticalCounter][j] == player)
                            verticalCounter++;
                    }
                    // Horizontal Check
                    while((horizontalCounter < this.#winLength) && this.#board[i][j] == player && this.#board[i][j + horizontalCounter] == player)
                        horizontalCounter++;
                }

                //If any of the directional checks reached the winLength, declare a winner and end the game.
                if(upRightCounter == this.#winLength || downRightCounter == this.#winLength || horizontalCounter == this.#winLength || verticalCounter == this.#winLength) {
                    console.log("Congratulations, Player "+player+". You win.");
                    io.close();
                    exit();
                }
            }
        }
    }
    
    // Player column selection loop.
    placeToken(player, column) {
        column = column.toUpperCase();

        //If user inputs "q" or "Q", quit.
        if (column == 'Q') {
            this.quit();
        }

        // If character chosen is within the bounds of the game
        if (column.charCodeAt(0) > 64 && column.charCodeAt(0) <= 64+this.#numCols) {
            if (this.#board[0][column.charCodeAt(0) - "A".charCodeAt(0)] != 0) {
                console.log("This column is full, please select another.");
                this.fetchColumn(player, this.placeToken.bind(this));
                return;
            }
            // Place the token, print the board, and check for a win.
            this.makeMove(player, column);
            this.printBoard();
            this.xInARow(player);
        }
        // If character chosen is invalid.
        if (column.charCodeAt(0) <= 64 || column.charCodeAt(0) > 64+this.#numCols || column == "") {
            console.log("Invalid input, please try again.");
            this.fetchColumn(player, this.placeToken.bind(this));
            return;
        }

        // If a player successfully places their token, swap players and request new input.
        if (player == 1)
            this.fetchColumn(2, this.placeToken.bind(this));
        else
            this.fetchColumn(1, this.placeToken.bind(this));
    }

    playGame() {
        // Construct the inital board.
        this.makeBoard();
        // Print the initial board.
        this.printBoard();
        // Get first user input to begin game loop.
        this.fetchColumn(1, this.placeToken.bind(this));
    }
}
