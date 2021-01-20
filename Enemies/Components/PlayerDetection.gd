extends Area2D

var players = null
var player = null setget ,get_player
func get_player():
	if player.is_dead:
		player = null
		return null
	else:
		return player

func can_see_player():
	if player == null || player.stats.health <= 0:
		players = get_overlapping_bodies()
		if players.size() > 0:
			player = players[0]
		
	return player != null



func _on_PlayerDetection_area_entered(area):
	print("Uh oh. This is unhandled. PlayerDetection.gd")
	print(area)
	
