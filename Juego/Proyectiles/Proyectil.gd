extends Area2D
class_name Proyectil


var velocidad: Vector2 = Vector2.ZERO
var danio: float = 3


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


# Metodos custom
func daniar(otro_cuerpo:CollisionObject2D) -> void:
	if otro_cuerpo.has_method("recibir_danio"):
		otro_cuerpo.recibir_danio(danio)
	
	self.queue_free()


# Signals internas
func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()


func _on_Proyectil_area_entered(area: Area2D) -> void:
	print(area.name)
	print(area.owner.name)
	daniar(area)


func _on_Proyectil_body_entered(body: Node) -> void:
	daniar(body)
