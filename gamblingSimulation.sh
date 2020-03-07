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

function playForMonth()
{
	echo Playing For Month
	expectedGoalForMonth=$(($stakesAmount*$monthDays))
	for (( i=1; i<=$monthDays; i++ ))
	do
		play
		totalAmount=$(($totalAmount+$stakesAmount))
	done
	if [[ $totalAmount -lt $expectedGoalForMonth ]]
	then
		echo "Gambler Lose by $(($expectedGoalForMonth-$totalAmount))$"
	elif [[ $totalAmount -gt $expectedGoalForMonth ]]
	then
		echo "Gambler Won by $(($totalAmount-$expectedGoalForMonth))$"
	else
		echo Gambler Achieved Goal
	fi
}

function play()
{
	stakesAmount=100
      while [[ $stakesAmount -gt $resignLimit && $stakesAmount -lt $playingGoal ]]
      do
         if [[ $((RANDOM%2)) -eq 1 ]]
         then
            stakesAmount=$(($stakesAmount+$bet))
         else
            stakesAmount=$(($stakesAmount-$bet))
         fi
      done
#	echo $stakesAmount
}

playForMonth
