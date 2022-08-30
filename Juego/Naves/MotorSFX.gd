extends AudioStreamPlayer2D
class_name Motor


export var tiempo_de_transicion: float = 0.6
export var volumen_apagado: float = -30.0

onready var tween_sonido: Tween = $Tween


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
