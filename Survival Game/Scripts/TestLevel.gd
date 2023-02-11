extends Spatial

# Buildings
var placable_buildings = {
	"block": load("res://Scenes/BuildableStructures/BlockBuilding.tscn")
}
var template_instance = placable_buildings["block"].instance()
var Bounty_Pos = Vector3()
var Random_NumGen = RandomNumberGenerator.new()

func _ready():
	# Building if there
	add_child(template_instance)


func generate_bounty():
	Random_NumGen.randomize()
	var Bounty_PosX = Random_NumGen.randf_range(-10.0, 10.0) # for the bounties X position
	Random_NumGen.randomize()
	var Bounty_PosZ = Random_NumGen.randf_range(-89.4, 89.4) # for the bounties Z position
	
	Bounty_Pos = Vector3(Bounty_PosX, 0.5, Bounty_PosZ)
	$Bounty.translation = Bounty_Pos # sets the bounties position to the Bounty_Pos variable
	 



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# Building
	if Input.is_action_just_pressed("placebuilding"):
		var instance = placable_buildings["block"].instance()
		add_child(instance)
		instance.translation = $Player/Head/BuildingPlacement.get_collision_point() # placing the building where the BuildingPlacement hits the ground
		instance.translation.y = 0 # Placing the building at ground height
	
	if $Player/Head/InteractCast.is_colliding():
		var Colliding_With = $Player/Head/InteractCast.get_collider()
		var Colliding_Name = Colliding_With.name
		
		if (Colliding_Name == "BountyBoard") and (Input.is_action_just_pressed("interact")):
			generate_bounty()
		
	

	
	template_instance.translation = $Player/Head/BuildingPlacement.get_collision_point()
	template_instance.translation.y = 0
