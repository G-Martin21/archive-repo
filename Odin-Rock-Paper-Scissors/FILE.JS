/* 
computerPlay return computer answer
   1. values[] = {rock, paper, scissors}
   1. generate a random value between 0 and 2
   let seed = Math.floor((Math.random() * 3));
   2. return values[random value]
   return gameValues[seed];

playerPlay()

let userSelection = prompt("Enter your choice: rock, paper or scissors: ");
return userSelection;

playRound returns the winner of a round
playRound(playerSelection, ComputerSelection)
   // check playerSelection against computerSelection, case-insensitive.
   // rules: paper wins over rock, rock wins over scissors, scissors wins over paper
   3. playerSelection.tolowercase, computerSelection.tolowercase
   4. if playerSelection equals computerSelection, return "It is a tie!"
   5. else
      if playerSelection wins return "You win! x beats y"
      else return "You lose! x beats y"

game() play a game of 5 rounds

   const gameValues = ["rock", "paper", "scissors"];
   for (let i = 0; i < 5; i++) {
      //get computer selection
      let computerSelection = computerPlay().toLowerCase;
      //get user selection
      let playerSelection = playerPlay().toLowerCase;
      // get winner of the round
      let winner = playRound(playerSelection, computerSelection);
      update score
      console out the result
   }

   check score and declare a winner
   console out the winner

