#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

# Declare an associative array
declare -A TEAMS_ARRAY

# Function to insert or get team ID
INSERT_OR_GET() {
  local TEAM_NAME=$1

  # Check if team already in the array
  if [[ -n "${TEAMS_ARRAY["$TEAM_NAME"]}" ]]
  then
    echo "${TEAMS_ARRAY["$TEAM_NAME"]}"
  else
    # Check if team exists in the database
    TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$TEAM_NAME'")
    
    # If not found, insert it
    if [[ -z $TEAM_ID ]]
    then
      TEAM_ID=$($PSQL "INSERT INTO teams(name) VALUES('$TEAM_NAME') RETURNING team_id" | grep -oE '^[0-9]+')
    fi

    # Cache in the array and return
    TEAMS_ARRAY["$TEAM_NAME"]=$TEAM_ID
    echo $TEAM_ID
  fi
}



# Read CSV and process
$PSQL "TRUNCATE teams, games"

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != "year" ]]
  then
    WINNER_ID=$(INSERT_OR_GET "$WINNER")
    OPPONENT_ID=$(INSERT_OR_GET "$OPPONENT")
    
    if [[ -n $WINNER_ID && -n $OPPONENT_ID ]]
    then
      $PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)"
      echo "Processed: $WINNER: $WINNER_ID vs $OPPONENT: $OPPONENT_ID ($YEAR)"
    else
      echo "Failed to process: $WINNER vs $OPPONENT ($YEAR)"
    fi
  fi
done