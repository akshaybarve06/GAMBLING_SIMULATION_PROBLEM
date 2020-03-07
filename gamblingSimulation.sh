#!/bin/bash -x

# @Description: Gambling Simulation Problem
# @Author: Akshay Dhananjay Barve
# @Version: 18.04.3 lts
# @Since: 07 March 2020 / Saturday

stakesAmount=100
bet=1
playingGoal=150
resignLimit=50
totalAmount=0
monthDays=20

declare -A winCount
declare -A loseCount

function playForMonth()
{
	echo "Playing For Month.."
	expectedGoalForMonth=$(($stakesAmount*$monthDays))

	for (( i=1; i<=$monthDays; i++ ))
	do
		stakesAmount=100
		while [[ $stakesAmount -gt $resignLimit && $stakesAmount -lt $playingGoal ]]
		do
			if [[ $((RANDOM%2)) -eq 1 ]]
		 	then
			    	stakesAmount=$(($stakesAmount+$bet))
					winCount[$i]=$((${winCount[$i]}+1))
		 	else
			    	stakesAmount=$(($stakesAmount-$bet))
					loseCount[$i]=$((${loseCount[$i]}+1))
		 	fi
		done
		totalAmount=$(($totalAmount+$stakesAmount))
	done

		if [[ $totalAmount -lt $expectedGoalForMonth ]]
		then
				echo "Gambler Lose by $(($expectedGoalForMonth-$totalAmount))$"
				unluckyDay
		elif [[ $totalAmount -gt $expectedGoalForMonth ]]
		then
				echo "Gambler Won by $(($totalAmount-$expectedGoalForMonth))$"
				luckyDay
		else
				echo "Gambler Neither Won or Loose Neutral Achieved Goal"
		fi
}

function luckyDay()
{
	winnings=${winCount["1"]}
	for k in ${!winCount[@]}
	do
		if [[ $winnings -lt ${winCount["$k"]} ]]
		then
			winnings=${winCount["$k"]}
			luckyDay=$k
		fi
	done
	echo "Lucky Day is $luckyDay & no. of Winnings $winnings"
}

function unluckyDay()
{
	losings=${loseCount["1"]}
	for k in ${!loseCount[@]}
	do
		if [[ $losings -lt ${loseCount["$k"]} ]]
		then
			losings=${loseCount["$k"]}
			unluckyDay=$k
		fi
	done
	echo "Unlucky Day is $unluckyDay & no. of losings $losings"
}

playForMonth
