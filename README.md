# Wolfenstein-Thomas

## Ce jeu est réalisé avec Godot.

### Comme son nom l’indique, c’est un jeu inspiré de *Wolfenstein*.

## Voici les tutoriels que j’ai utilisés :

### Pour réaliser la base du jeu :
### Pour faire les explosions :

## Les modifications que j’ai apportées :

### J’ai ajouté un gestionnaire pour l’audio :
#### J’avais un problème avec le son : deux sons ne voulaient pas se déclencher à la même frame. Le gestionnaire audio stocke les sons dans une liste, puis les lance à chaque frame. Il me permet aussi de gérer la position et le volume du son.

### J’ai créé de nouveaux niveaux :
#### J’en ai ajouté quelques-uns, mais je préfère développer de nouvelles mécaniques avant d’en créer davantage, pour éviter la répétition.

### J’ai ajouté un système de loot à la mort des ennemis :
#### À chaque fois qu’un ennemi meurt, il a une chance sur six de faire apparaître un kit de soin, et cinq chances sur six de faire apparaître des munitions.

### Je suis en train de créer un boss :
#### Pour l’instant, il a deux types d’attaque : une à distance et une au corps à corps.
##### Au corps à corps, il dash et donne des coups de mâchoire.
##### À distance, il tire des lasers.