extends AudioStreamPlayer2D
class_name Motor


export var tiempo_de_transicion: float = 0.6
export var volumen_apagado: float = -30.0

onready var tween_sonido: Tween = $Tween

var volumen_original: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	volumen_original = volume_db
	volume_db = volumen_apagado


func sonido_on() -> void:
	if not playing:
		play()
	
	efecto_transicion(volume_db, volumen_original)


func sonido_off() -> void:
	efecto_transicion(volume_db, volumen_apagado)


func efecto_transicion(desde_volumen: float, hasta_volumen: float) -> void:
	tween_sonido.interpolate_property(
		self,
		"volume_db",
		desde_volumen,
		hasta_volumen,
		tiempo_de_transicion,
		Tween.TRANS_LINEAR,
		Tween.EASE_OUT_IN
	)
