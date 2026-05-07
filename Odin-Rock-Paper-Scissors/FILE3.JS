// Test

// get computer selection
function computerPlay() {

   // generate a random value between 0 and 2
   let seed = Math.floor((Math.random() * 3));
   return seed;
}

// get user selection
function playerPlay() {

      // it lacks implementation for user error
      let userSelection = prompt("Enter your choice: rock, paper or scissors: ");
   return userSelection;
}

// get winner of a round
function playRound(playerSelection, computerSelection, gameValues) {

   // check playerSelection against computerSelection, case-insensitive.
   // Game rules: paper wins over rock, rock wins over scissors, scissors wins over paper
   
   gameRules = [ [0, -1, 1], [1, 0, -1], [-1, 1, 0]];
   let user = gameValues.indexOf(playerSelection.toLowerCase());
   let computer = gameValues.indexOf(computerSelection.toLowerCase());
   //console.log(user, computer);

   return gameRules[user][computer];
}
   
// play a game of 5 rounds
function game() { 

   const gameValues = ["rock", "paper", "scissors"];
   let computerSelection = "",
       playerSelection = "",
       result = 0,
       scorePlayer = 0,
       scoreComputer = 0 ;
   
   for (let i = 0; i < 5; i++) {
   
      //get computer selection
      computerSelection = gameValues[computerPlay()];
      
      //get user selection
      playerSelection = playerPlay();
      
      //console.log(playerSelection, computerSelection);
      //console.log(playRound(playerSelection, computerSelection, gameValues));
      
      result = playRound(playerSelection, computerSelection, gameValues);
      switch(result) {
         case 1:
            console.log(`You win! ${playerSelection} beats ${computerSelection}`);
            scorePlayer++;
            break;
         case 0:
            console.log("It's a tie!");
            break;
         case -1:
            console.log(`You lose! ${playerSelection} lose agains ${computerSelection}`);
            scoreComputer++
            break;
      }
   }
       if (scorePlayer > scoreComputer) {
         console.log('You win the round!')
       }else if (scorePlayer == scoreComputer){
         console.log("It's a tie")
       }else {
         console.log('You lose the round!')
       }
}

//game(); 
