extends Spatial


var Bounty_Pos = Vector3(0, 1000, 0)
var Random_NumGen = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func generate_bounty():
	Random_NumGen.randomize()
	var Bounty_PosX = Random_NumGen.randf_range(-10.0, 10.0) # for the bounties X position
	Random_NumGen.randomize()
	var Bounty_PosZ = Random_NumGen.randf_range(-89.4, 89.4) # for the bounties Z position
	
	Bounty_Pos = Vector3(Bounty_PosX, 0.5, Bounty_PosZ)
	self.translation = Bounty_Pos # sets the bounties position to the Bounty_Pos variable
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	if (Input.is_action_just_pressed("interact")):
#		generate_bounty()
