# PrototypeGame

A small prototype of a game for MacOSX.
I built this prototype mostly during a vacation to help practice Swift and learn Apple's SpriteKit.

## Concept

The game is a "capture point" (similar to "control point") style strategy game where the objective is to capture all the bases on the map before your opponent does. While the prototype is not a complete version of this concept, it does have some of the features.

![Prototype screen explained](https://raw.githubusercontent.com/tcool86/PrototypeGame/master/Screens/game-prototype-screen.png)

### Map

The game uses CoreData to store information about the map. In this prototype, you can place bases ("Stars") on the map by clicking on the screen. As bases are put on the map, the map will dynamically resize, and you can see these changes occur on the minimap.

![Plotting bases](https://github.com/tcool86/PrototypeGame/blob/master/Screens/plotting-stars.gif)

### Player

The player moves around the map in four directions using the arrow keys. By pressing space-bar, you can activate the player's "aura" (SpriteKit particle effects) to capture a base. While the player aura is activated, energy is used, and the health of bases within the capture range will decrease. Once a base health is 0, the base is captured.

![Capturing bases](https://github.com/tcool86/PrototypeGame/blob/master/Screens/capture-stars.gif)

## Notes

Written in Swift v3.2 using Xcode 9, and deployed initially to MacOSX 10.12 (Sierra)

Update 12/18/2020: 
I'm no longer developing this project, but the concept has carried over to another project I'm creating using web technologies (BabylonJS)

I'll eventually post more details on my website: [timcool.me](https://www.timcool.me)
