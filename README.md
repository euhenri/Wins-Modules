
# Wins_modules Documentation

## Overview
This system was developed for the project called **Wins**, with a focus on **FiveM**. It tracks and displays combat statistics between players, logging hits, categorizing by weapon type, and generating a detailed report of outgoing and incoming damage for individual players in a match.

## Main Features
- **Hit Logging**: Logs hits between players, including damage amount, weapon used, and location of the hit (head, chest, or legs).
- **Weapon Categorization**: Uses a predefined list of weapons to categorize the hits.
- **Combat Reports**: Displays detailed combat statistics for each player, including outgoing and incoming damage, hit locations, and weapons used.
- **UI Integration**: Uses FiveM native functions such as `DrawText` and `DrawRect` to display combat reports on screen.

## Code Breakdown

### hit Function
The `hit` function is responsible for recording a hit between two players during a match. The function receives the following parameters:
- **shooterId**: The ID of the player who fired the shot.
- **targetId**: The ID of the player who was hit.
- **damage**: The amount of damage dealt by the hit.
- **weaponId**: The ID of the weapon used in the hit, matched to a predefined weapon list.
- **hitLocation**: The location where the player was hit (head, chest, or legs).
- **matchId**: The ID of the current match.

The hit is then stored in the round data for the current match, including all the details such as shooter, target, damage, and weapon used.

### ShowCombatStats Function
This function displays a detailed report of the combat statistics for a specific player in a match. It shows:
- **Outgoing Damage**: The total damage dealt by the player.
- **Incoming Damage**: The total damage received by the player.
- **Hit Locations**: A breakdown of the locations where the player hit others or was hit (head, chest, or legs).
- **Weapon Used**: The weapon used in the last recorded hit.

### DrawTextUI Function
The `DrawTextUI` function is used to display text on the screen during the combat report. It sets up the font, color, and position for the text to be drawn.

## Example Usage
The combat system continuously displays the combat statistics for player 10 in the "matchmaking-01" match using the `ShowCombatStats` function.

```lua
CreateThread(function()
    while true do
        local sleep = 0
        ShowCombatStats(10, "matchmaking-01") -- Shows the stats for player 10
        Wait(sleep)
    end
end)
```

Hits can be simulated using the `hit` function:

```lua
CreateThread(function()
    hit(10, 6, 150, 95, 1, 'matchmaking-01') -- Player 10 hits player 6 with damage 150
    hit(6, 10, 40, 95, 2, 'matchmaking-01')  -- Player 6 hits player 10 with damage 40
    hit(1, 10, 90, 95, 3, 'matchmaking-01')  -- Player 1 hits player 10 with damage 90
end)
```

This script provides a flexible system for tracking combat data in a **FiveM** server and generating detailed player statistics reports.
