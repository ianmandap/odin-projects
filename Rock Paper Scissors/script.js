// Establish global variables
let playerWins = 0;
let playerLoses = 0;
let computerWins = 0;
let computerLoses = 0;
let gamesPlayed = 0;
let bestOf = 5;
let outcomeText = "";
let outcomeDescText = ""; 

// Establish selectors
const pw = document.querySelector('#pw');
const pl = document.querySelector('#pl');
const gp = document.querySelector('#gp');
const cw = document.querySelector('#cw');
const cl = document.querySelector('#cl');

const simulation = document.querySelector('.simulation');
const s1 = document.querySelector('#s1');
const s2 = document.querySelector('#s2');
const outcome = document.querySelector('.outcome');
const outcomeDesc = document.querySelector('.outcome-desc');

const centerLeft = document.querySelector('.center-left');
const centerRight = document.querySelector('.center-right');

// Toggle class upon game
function toggleClass() {
    toggleClass = function(){}; // kill after it is called;
    simulation.classList.toggle('hide');
}

// Establish button events
const choicesNodeList = document.querySelectorAll(".choice");
choicesNodeList[0].addEventListener('click', function(e) {
    playRound(0, computerPlay())
    checkWinner();
});

choicesNodeList[1].addEventListener('click', function(e) {
    playRound(1, computerPlay())
    checkWinner();
});

choicesNodeList[2].addEventListener('click', function(e) {
    playRound(2, computerPlay())
    checkWinner();
});

function playRound(playerSelection, computerSelection) {
    // outputs win/lose on a game of rock-paper-scissors

    // Check first if draw
    if (playerSelection === computerSelection) {
        gamesPlayed += 1;
        outcomeText = "Draw!";
        outcomeDescText = "Choose again.";
    }

    // Check outcome
    else if (playerSelection == 0 && computerSelection == 1) {
        playerLoses += 1;
        computerWins += 1;
        gamesPlayed += 1;
        outcomeText = "You Lose!";
        outcomeDescText = "Rock is beaten by Paper";
    }

    else if (playerSelection == 0 && computerSelection == 2) {
        playerWins += 1;
        computerLoses += 1;
        gamesPlayed += 1;
        outcomeText = "You Win!";
        outcomeDescText = "Rock beats Scissors";
    }

    else if (playerSelection == 1 && computerSelection == 0) {
        playerWins += 1;
        computerLoses += 1;
        gamesPlayed += 1;
        outcomeText = "You Win!";
        outcomeDescText = "Paper beats Rock";
    }

    else if (playerSelection == 1 && computerSelection == 2) {
        playerLoses += 1;
        computerWins += 1;
        gamesPlayed += 1;
        outcomeText = "You Lose!";
        outcomeDescText = "Paper is beaten by Scissors";
    }

    else if (playerSelection == 2 && computerSelection == 0) {
        playerLoses += 1;
        computerWins += 1;
        gamesPlayed += 1;
        outcomeText = "You Lose!"; 
        outcomeDescText = "Scissors is beaten by Rock";
    }

    else if (playerSelection == 2 && computerSelection == 1) {
        playerWins += 1;
        computerLoses += 1;
        gamesPlayed += 1;
        outcomeText = "You Win!";
        outcomeDescText = "Scissors beats Paper";
    }

    else {
        outcomeText = "";
        outcomeDescText = "Error! Something bad occurred.";
    }

    toggleClass();

    pw.textContent = playerWins;
    pl.textContent = playerLoses;
    gp.textContent = gamesPlayed;
    cw.textContent = computerWins;
    cl.textContent = computerLoses;
    s1.textContent = emojify(playerSelection);
    s2.textContent = emojify(computerSelection);

    outcome.textContent = outcomeText;
    outcomeDesc.textContent = outcomeDescText;
}

function computerPlay() {
    // generates a number from 0 to 2 (inclusive)
    return Math.floor((Math.random()*3));
}

function checkWinner() {
    if (playerWins == bestOf) {
        outcome.textContent = "You are the overall Winner!";
        outcomeDesc.textContent = "";
        simulation.classList.toggle('hide');
        for (let i = 0; i < choicesNodeList.length; i++) {
            choicesNodeList[i].disabled = "true";
        }
        centerLeft.style.border = "5px solid gold";

    }

    if (computerWins == bestOf) {
        outcome.textContent = "Computer is the overall Winner!";
        outcomeDesc.textContent = "";
        simulation.classList.toggle('hide');
        for (let i = 0; i < choicesNodeList.length; i++) {
            choicesNodeList[i].disabled = "true";
        }
        centerRight.style.border = "5px solid gold";
    }
}

function emojify(num) {
    if (num === 0) {return "🗿"}
    else if (num === 1) {return "📃"}
    else {return "✂️"};
}