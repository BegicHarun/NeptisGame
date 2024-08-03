

# NeptisGame


NeptisGame is an engaging and competitive iOS mobile game that challenges users to guess recipe tags against an opponent. Designed to be interactive and fun

### NeptisGame App Description
Game Objective
The objective of NeptisGame is for users to compete in a guessing game involving recipe tags. Each player tries to correctly guess tags associated with recipe names. Players earn points for each correct guess, and the player with the highest score at the end of the game wins. Each game consists of 10 attempts per player.


## Deployment

To use and test this project:

1. Open Xcode
2. Choose "Clone Git Repository"
3. Paste the link below

```bash
  https://github.com/BegicHarun/NeptisGame.git
```
4. In Xcode hit <i> Command + R </i> for running iOS Simualtor and running the app
## Features

<ul>
    <li><strong>User Authentication:</strong>
        <ul>
            <li><strong>Login:</strong> Utilizes the DummyJSON Auth API to provide secure user authentication. Users log in with their username and password.</li>
            <li><strong>Register:</strong> New users can register by providing their first name, last name, age, username, and password using the DummyJSON Users API.</li>
        </ul>
    </li>
    <li><strong>Home Screen:</strong>
        <ul>
            <li>Displays a list of users sorted by ID fetched from the DummyJSON Users API.</li>
            <li>Users can select an opponent to challenge from the list.</li>
            <li>Upon selecting a user, a prompt appears asking if the user wants to play a game with the selected opponent.</li>
        </ul>
    </li>
    <li><strong>Game Screen:</strong>
        <ul>
            <li>Displays current scores: "You vs [Opponent's Name]".</li>
            <li>Shows the number of attempts out of 10.</li>
            <li>Presents a randomly selected recipe name from the DummyJSON Recipes API.</li>
            <li>Allows users to manually enter their tag guess for the displayed recipe.</li>
            <li>Simulates the opponent's guess automatically by randomly selecting a tag from the DummyJSON Recipes Tags API.</li>
            <li>Updates scores based on correct guesses.</li>
        </ul>
    </li>
    <li><strong>Game Completion:</strong>
        <ul>
            <li>After 10 attempts, the game compares scores to determine the winner.</li>
            <li>Displays a popup message declaring the result: "You won! Congrats!" or "You lost! More luck next time…".</li>
            <li>The game ends with a simple OK button to acknowledge the result.</li>
        </ul>
    </li>
</ul>

## Gameplay Flow

<ul>
    <li><strong>Authentication:</strong>
        <ul>
            <li>Users log in using their credentials or register for a new account.</li>
            <li>Upon successful login, users are redirected to the home screen.</li>
        </ul>
    </li>
    <li><strong>Select Opponent:</strong>
        <ul>
            <li>Users browse a list of other players.</li>
            <li>A confirmation prompt is displayed when a user selects an opponent to start a game.</li>
        </ul>
    </li>
    <li><strong>Gameplay:</strong>
        <ul>
            <li>Each player gets 10 attempts to guess the tags for the presented recipe names.</li>
            <li>Players score points for each correct tag guessed.</li>
        </ul>
    </li>
    <li><strong>Results:</strong>
        <ul>
            <li>At the end of 10 attempts, scores are compared, and the winner is announced.</li>
            <li>Users receive feedback on their performance via a popup message.</li>
        </ul>
    </li>
</ul>

## Screenshots

### Login Screen
<img width="344" alt="Login" src="https://github.com/user-attachments/assets/ce76eed0-9530-4be8-a935-407daa4b534e">


### Registration Screen
<img width="344" alt="Register" src="https://github.com/user-attachments/assets/70c38ce6-ac56-45b6-8c10-581d2cb07e66">


### Home Screen 
<img width="344" alt="HomeS" src="https://github.com/user-attachments/assets/fea07362-b3b3-4c50-9c29-07807cd504bc">

## Home Screen (Choose Opponent)
<img width="344" alt="ChoosingOpponent" src="https://github.com/user-attachments/assets/e317d907-8eb0-4a79-a2f9-468abcc91809">


### Game Screen
<img width="344" alt="GameScreen" src="https://github.com/user-attachments/assets/7321acb4-91f1-4373-87e3-996937c7ef2b">


### Game Screen - User Wins
<img width="344" alt="Pobjeda" src="https://github.com/user-attachments/assets/fb74235e-0a45-42c0-b18c-bb9d161cd3f2">


### Game Screen - Opponent Wins
<img width="344" alt="poraz" src="https://github.com/user-attachments/assets/6d651b4b-718d-4124-9c69-9cccd2e9e6b9">


### Game Screen - Tie
<img width="344" alt="nerjeseno" src="https://github.com/user-attachments/assets/1099cd42-d5b6-4e0c-ae65-c45ea072d506">



