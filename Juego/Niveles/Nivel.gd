extends Node2D
class_name Nivel


onready var contenedor_proyectiles: Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	conectar_signals()
	crear_contenedor()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func conectar_signals() -> void:
	Eventos.connect("disparo", self, "_on_disparo")


func crear_contenedor() -> void:
	contenedor_proyectiles = Node.new()
	contenedor_proyectiles.name = "ContendorProyectiles"
	add_child(contenedor_proyectiles)


func _on_disparo(proyectil: Proyectil) -> void:
	contenedor_proyectiles.add_child(proyectil)
