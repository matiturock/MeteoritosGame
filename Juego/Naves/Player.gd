extends RigidBody2D
class_name Player

export(int) var potencia_motor: int = 20
export(int) var potencia_rotacion: int = 280

var empuje: Vector2 = Vector2.ZERO
var direccion_rotacion: int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	apply_central_impulse(empuje.rotated(rotation))
	apply_torque_impulse(direccion_rotacion * potencia_rotacion)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	player_input()


func player_input() -> void:
	empuje = Vector2.ZERO
	if Input.is_action_pressed("mover_adelante"):
		empuje = Vector2(potencia_motor, 0)
	elif Input.is_action_pressed("mover_atras"):
		empuje = Vector2(-potencia_motor, 0)
	
	
	direccion_rotacion = 0
	if Input.is_action_pressed("girar_horario"):
		direccion_rotacion -= 1
	elif Input.is_action_pressed("girar_antihorario"):
		direccion_rotacion += 1
