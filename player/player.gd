extends KinematicBody2D

#Enum don't work on export
#enum STATE{
#	WAIT,
#	RUN,
#	DEAD
#}

#Use dictionnary to manage states
#could have used constant int instead
const STATE={
	"WAIT":0,
	"RUN":1,
	"DEAD":2
}

export var run_speed=500
export var jump_strength=1500
export var gravity_strength=4000
#same value as parallax.ground_y
export var ground_y=500

signal on_dead

var _velocity=Vector2(0,0)
var _can_jump=true
var _state=STATE.WAIT

onready var sprite_node=get_node("santa_claus")
onready var animator=get_node("AnimationPlayer")

func run():
	_state=STATE.RUN
	set_fixed_process(true)
	
func _fixed_process(delta):
	var pos=get_pos();
	
	if(_state==STATE.RUN):
		#constant run velocity
		_velocity.x=run_speed
	if(_state==STATE.DEAD and abs(_velocity.x)>0):
		#friction
		_velocity.x*=0.8

	#Jump management
	if(_state==STATE.RUN and _can_jump):
		_velocity.y=0
		#see projet parameter controls
		if(Input.is_action_pressed("jump")):
			#Y axis is pointing down
			_velocity.y-=jump_strength
			sprite_node.play("jump")
			_can_jump=false
	else:
		#Player is jumping
		# => gravity integration (acceleration)
		_velocity.y+=delta*gravity_strength

	#wished motion
	var motion = _velocity * delta
	
	#As ground is always at same y
	#we just test position (could have used collision detection instead)
	if(pos.y+motion.y>ground_y):
		#player is on the floor
		motion.y=ground_y-pos.y
		#reset gravity
		_velocity.y=0
		#if player is not dead
		if(_state==STATE.RUN):
			sprite_node.play("run")
			_can_jump=true
		

	motion = move(motion)
	
	if (is_colliding()):
		if(_state==STATE.RUN):
			#see group of bat and rock nodes
			if(get_collider().is_in_group("dead")):
				animator.play("dead")
				emit_signal("on_dead")
				_state=STATE.DEAD
			else:
				#if not enemy it's ground
				#normaly not used here
				_velocity.y=0
				_can_jump=true
				sprite_node.play("run")
		#player can't do wished motion because of collision
		#so he will slide along the normal to get proper position
		#velocity is also updated
		var n = get_collision_normal()
		motion = n.slide(motion)
		_velocity = n.slide(_velocity)
		move(motion)