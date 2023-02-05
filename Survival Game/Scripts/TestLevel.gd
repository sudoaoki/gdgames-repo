extends Spatial

# Buildings
var placable_buildings = {
	"block": load("res://Scenes/BuildableStructures/BlockBuilding.tscn")
}
var template_instance = placable_buildings["block"].instance()

func _ready():
	# Building if there
	add_child(template_instance)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# Building
	if Input.is_action_just_pressed("placebuilding"):
		var instance = placable_buildings["block"].instance()
		add_child(instance)
		instance.translation = $Player/Head/BuildingPlacement.get_collision_point() # placing the building where the BuildingPlacement hits the ground
		instance.translation.y = 0 # Placing the building at ground height
	

	
	template_instance.translation = $Player/Head/BuildingPlacement.get_collision_point()
	template_instance.translation.y = 0
