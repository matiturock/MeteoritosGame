extends Node2D
class_name Canion


export var proyectil: PackedScene = null
export var cadencia_disparo: float = 0.6
export var velocidad_proyectil: int = 100
export var danio_proyectil: int = 1

onready var timer_emfriamiento: Timer = $TimerEnfriamiento
onready var audio_disparoSFX: AudioStreamPlayer2D = $AudioDisparoSFX
onready var esta_enfriado: bool = true
onready var esta_disparando: bool = false setget set_esta_disparando
onready var puede_disparar: bool = false setget set_puede_disparar, get_puede_disparar

var puntos_disparo: Array = []


# getters and setters
func set_esta_disparando(disparando: bool) -> void:
	esta_disparando = disparando


func set_puede_disparar(value: bool) -> void:
	puede_disparar = value


func get_puede_disparar() -> bool:
	return puede_disparar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	almacenar_puntos_de_disparo()
	timer_emfriamiento.wait_time = cadencia_disparo


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if esta_disparando and esta_enfriado:
		disparar()


func almacenar_puntos_de_disparo() -> void:
	for nodo in get_children():
		if nodo is Position2D:
			puntos_disparo.append(nodo)


func disparar() -> void:
	esta_enfriado = false
	audio_disparoSFX.play()
	timer_emfriamiento.start()
	
	for punto_de_disparo in puntos_disparo:
		var new_proyectil: Proyectil = proyectil.instance()
		new_proyectil.constructor(
			punto_de_disparo.global_position,
			get_owner().rotation,
			velocidad_proyectil,
			danio_proyectil
		)
		Eventos.emit_signal("disparo", new_proyectil)


func _on_TimerEnfriamiento_timeout() -> void:
	esta_enfriado = true
