# Core Project Document

Group GD\_04: Team Amethyst

# Theme and interpretation

The theme we have selected is “The forgotten elements”, we will interpret this to make an elemental magic game, perhaps having a plot around a fifth “forgotten” element.

# Game Idea in about 100 words

We will make a 3D game where exploration and combat are centrally tied together with a short but good plot. The player will use elemental magic to face enemies and solve puzzles. The enemies will have elemental weaknesses and strength, so using different spells is key. Other elements and spells are unlocked with bossfights, these are also necessary for unlocking certain areas of the game (metroid-vania style). The final element needs to be destroyed, as it is undoubtedly evil.

**Roles to divide:**  
**Lead designer, lead artist, lead programmer, worldbuilding, gameplay & testing, production**

| Name | Email | Necessary roles |
| :---- | :---- | :---- |
| **Joris** | jjjheijnen@student.tudelft.nl | World builder  |
| **Dennis** | d.visser-5@student.tudelft.nl | Lead designer |
| **Bram** | bmovanwayenbur@student.tudelft.nl | Lead artist, production |
| **Nikita** | n.a.soshnin@student.tudelft.nl | Lead programmer |

# Features to implement

**Computer graphics:**

| Feature | Level | Explanation |
| :---- | :---- | :---- |
| Custom Animated textures | **★★** | For our 2d character, custom animated textures are a must. |
| Particle system | **★★** | To make our magic have juice, good particles of all shapes and sizes will be a must |
| Play with lights and shadows | **★** | To add juice, it makes sense to play around with light and shadows |
| Use post-processing | **★** | We will use a post-processing filter to give our game artistic identity |
| Have self-made music for the game | **★★** | We will make a custom soundtrack with at least a few songs in the game. |

**AI:**

| Feature | Level | Explanation |
| :---- | :---- | :---- |
| Advanced AI | **★★** | The monsters in our game will need to choose between different decisions |
| Pathfinding | **★★** | We will implement a simple pathfinding algorithm for our enemies, which switches from goals based on health,  |
| Intelligently control groups of agent | **★★** | To have multiple monsters on screen and not have them merge into eachother, they will have to keep distance with some kind of algorithm. |

**Web-based**

| Feature | Level | Explanation |
| :---- | :---- | :---- |
| Create remote server for storing data | **★★★** | We will have a remote server to store high scores and maybe save data. |
| Save relevant information from your game during play | **★** | We will have save states in our game as it is a linear experience. |
| Collect and show highscores (remotely) | **★** | We can have a speedrun mode in the game, and have a scoreboard that displays top times. |
| Level heatmap, showing where certain events happen most frequently |  ★★  | We can track where in the map players die to see if some areas are too difficult or too easy. We can also keep track of general position of players so we can see if there are some areas that players don’t manage to find or maybe long paths that players take that might make sense to replace with portals/fast travel |

**Programming**

| Feature | Level | Explanation |
| :---- | :---- | :---- |
| Dynamic environment (hazards) | ★★ | Some areas are guarded by stronger and more enemies then others |
| FPS independent | **★** | This feels like a necessity for good game design |
| Use physics materials to create surfaces that respond differently | **★** | We can have different environments in the game, for example icy areas where the player and enemies slide around, or desert areas where you move slower |
| Emulate real-world physical effects (e.g. fire spread, fluid draining, gas  spread, water state changes)  | **★★** | We can have some interaction between the elemental spells and environment, for example fire spreads in forest-like environments or melts icy obstacles |
| Basic menus (including main menu) | ★★ | We want to have a REALLY FANCY main menu |
| High scores  | ★ | We will have a speedrun system, so we will also add a scoreboard UI for it |
| Self-made UI animations | ★ | We feels like this is worth for adding to UX. |
| Dynamic music | ★★ | We want music to change depending on the area you are in, with different instruments in different environments. |




