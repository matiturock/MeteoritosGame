extends Area2D
class_name Proyectil


var velocidad: Vector2 = Vector2.ZERO
var damage: float


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += velocidad * delta


func constructor(posicion: Vector2,
				 direccion: float,
				 velocidad_p: float,
				 danio_proyectil: int) -> void:
	position = posicion
	rotation = direccion + (PI / 2)
	velocidad = Vector2(velocidad_p, 0).rotated(direccion)


func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()
