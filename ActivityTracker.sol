// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract ActivityTracker {

    struct Workout {
        string ExerciseType;
        uint256 Time; 
        uint256 calories;
        uint256 timestamp;
    }

    mapping(address => Workout[]) public userWorkouts;
    mapping(address => uint256) public totalTime;
    mapping(address => uint256) public workoutCount;

    event WorkoutLogged(
        address indexed user,
        string ExerciseType,
        uint256 time,
        uint256 calories
    );

    event GoalReached(
        address indexed user,
        string goalType,
        uint256 value
    );

    function logWorkout(string memory _type, uint256 _time, uint256 _calories) public {
        require(_span > 0, "Time must be greater than zero");

        userWorkouts[msg.sender].push(Workout(_type, _time, _calories, block.timestamp));
        totalTime[msg.sender] += _time;
        workoutCount[msg.sender] += 1;

        emit WorkoutLogged(msg.sender, _type, _time, _calories);

        if (workoutCount[msg.sender] == 10) {
            emit GoalReached(msg.sender, "10 Workouts", workoutCount[msg.sender]);
        }
        if (totalSpan[msg.sender] >= 500) {
            emit GoalReached(msg.sender, "500 Minutes", totalTime[msg.sender]);
        }
    }
    

    function getUserWorkouts(address user) public view returns (Workout[] memory) {
        return userWorkouts[user];
    }
}
