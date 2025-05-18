extends Node2D

# Prefabs
var groundGrassAtlas : CompressedTexture2D = preload("res://MapGen/Sprites/Grass/IsoGrass.png")
var grassDetailsArray : Array[CompressedTexture2D] = [
	preload("res://MapGen/Sprites/Grass/Grass2.png"),
	preload("res://MapGen/Sprites/Grass/Tree.png")
]

var grassWaveShader : Shader = preload("res://Shaders/Terrain/Grass/GrassWave.gdshader")

var mapWidth : int = 12
var mapHeight : int = 12

var tileSize : int = 32

 
func _ready():
	return
	GenerateMap()
	
func GenerateMap():
	for yPos in mapHeight:
		for xPos in mapWidth:
			var newAtlasTexture : AtlasTexture = AtlasTexture.new()
			newAtlasTexture.atlas = groundGrassAtlas
			newAtlasTexture.region = Rect2(
				Vector2(randi_range(0, 0), randi_range(0,0)) * tileSize,
				Vector2(tileSize, tileSize)
				)
			
			var newTile : Sprite2D = Sprite2D.new()
			newTile.position = Vector2(tileSize * xPos, (tileSize / 2 / 2) * yPos)
			if yPos % 2 == 0:
				print(yPos)
				newTile.position = Vector2(
					(tileSize * xPos) + tileSize/2, (tileSize / 2 / 2) * yPos
					)
					

			newTile.texture = newAtlasTexture
			#newTile.rotation_degrees = randi_range(0, 3) * 90
			$GroundTiles.add_child(newTile)
			if yPos < mapHeight - 4 and xPos > 0 and xPos < mapWidth:
				AddGroundDetail(newTile.position)
			
func AddGroundDetail(tilePos : Vector2):
	match randi_range(0, 5):
		0: # Add nothing
			for i in range(1):
				var newTexture : Texture2D = Texture2D.new()
				newTexture = grassDetailsArray[
					randi_range(0, len(grassDetailsArray) - 1)
				]
				
				var newDetail : Sprite2D = Sprite2D.new()
				newDetail.position = Vector2(
					tilePos.x + randi_range(-tileSize/4, tileSize/4),
					tilePos.y - randi_range(-tileSize/4, tileSize/4)
					)
				newDetail.texture = newTexture
				#if randi_range(0, 1) == 1: newDetail.flip_h = true
				newDetail.material = ShaderMaterial.new()
				newDetail.material.shader = grassWaveShader
				#newDetail.material.set_shader_parameter("windSpeed", randf_range(1.0, 8.0))
				$GroundDetails.add_child(newDetail)
