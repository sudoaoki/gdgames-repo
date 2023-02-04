extends Spatial

# Buildings
var placable_buildings = {
	"block": load("res://Scenes/BuildableStructures/BlockBuilding.tscn")
}



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# Building
	if Input.is_action_just_pressed("placebuilding"):
		var instance = placable_buildings["block"].instance()
		add_child(instance)
		instance.translation = $Player/Head/BuildingPlacement.get_collision_point()
		instance.translation.y = 0
