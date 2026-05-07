// Test

// computerPlay return computer selection
function computerPlay() {

   // generate a random value between 0 and 2
   let seed = Math.floor((Math.random() * 3));
   return seed;
}

// get user selection
function playerPlay() {

   let userSelection = prompt("Enter your choice: rock, paper or scissors: ");
   return userSelection;
}

// play a game of 5 rounds
function game() { 

   const gameValues = ["rock", "paper", "scissors"];
   
   for (let i = 0; i < 5; i++) {
      //get computer selection
      let computerSelection = gameValues[computerPlay()];
      //get user selection
      let playerSelection = playerPlay();
      console.log(computerSelection, playerSelection);
   }
}

game(); 
