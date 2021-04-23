// Establish global variables
let playerWins = 0;
let playerLoses = 0;
let computerWins = 0;
let computerLoses = 0;
let gamesPlayed = 0;
let bestOf = 3;
let gameStatus = 0;


function computerPlay() {
    // generates a number from 1 to 3 (inclusive)
    // 1 (Rock), 2 (Paper), 3 (Scissors)
    return Math.floor((Math.random()*3)+1);
}

function playRound(playerSelection, computerSelection) {
    // outputs win/lose on a game of rock-paper-scissors

    // Check first if draw
    if (playerSelection == computerSelection) {
        gamesPlayed += 1;
        return "Draw! Choose again.";
    }

    // Check outcome
    if (playerSelection == 1 && computerSelection == 2) {
        playerLoses += 1;
        computerWins += 1;
        gamesPlayed += 1;
        return "You Lose! Rock is beaten by Paper"
    }

    else if (playerSelection == 1 && computerSelection == 3) {
        playerWins += 1;
        computerLoses += 1;
        gamesPlayed += 1;
        return "You Win! Rock beats Scissors"
    }

    else if (playerSelection == 2 && computerSelection == 1) {
        playerWins += 1;
        computerLoses += 1;
        gamesPlayed += 1;
        return "You Win! Paper beats Rock"
    }

    else if (playerSelection == 2 && computerSelection == 3) {
        playerLoses += 1;
        computerWins += 1;
        gamesPlayed += 1;
        return "You Lose! Paper is beaten by Scissors"
    }

    else if (playerSelection == 3 && computerSelection == 1) {
        playerLoses += 1;
        computerWins += 1;
        gamesPlayed += 1;
        return "You Lose! Scissors is beaten by Rock"
    }

    else if (playerSelection == 3 && computerSelection == 2) {
        playerWins += 1;
        computerLoses += 1;
        gamesPlayed += 1;
        return "You Win! Scissors beats Paper"
    }

    else {
        return "Please enter a valid number."
    }
}

function game() {
    // Plays a game and checks if there is a winner
    const playerSelection = prompt("Choose. 1: Rock, 2: Paper, 3: Scissors");
    const computerSelection = computerPlay();
    console.log(playRound(playerSelection, computerSelection));

    if (playerWins == bestOf) {
        console.log("You are the overall Winner!");
        gameStatus = 1;
    }

    if (computerWins == bestOf) {
        console.log("Computer is the overall Winner!");
        gameStatus = 1;
    }
}

// while (gameStatus == 0) {
//     game();
// }
