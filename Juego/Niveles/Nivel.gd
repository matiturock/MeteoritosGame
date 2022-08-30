class_name Nivel
extends Node2D

onready var contenedor_proyectiles: Node

# Atributos export
export var explosion: PackedScene = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	conectar_signals()
	crear_contenedor()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

# Metodos custom
func conectar_signals() -> void:
	Eventos.connect("disparo", self, "_on_disparo")
	Eventos.connect("nave_destruida", self, "_on_nave_destruida")


func crear_contenedor() -> void:
	contenedor_proyectiles = Node.new()
	contenedor_proyectiles.name = "ContendorProyectiles"
	add_child(contenedor_proyectiles)


func _on_disparo(proyectil: Proyectil) -> void:
	contenedor_proyectiles.add_child(proyectil)


func _on_nave_destruida(posicion: Vector2, cantidad_explosiones: int):
	for i in range (cantidad_explosiones):
		var new_explosion: Node2D = explosion.instance()
		new_explosion.global_position = posicion
		self.add_child(new_explosion)
		yield(get_tree().create_timer(0.3), "timeout")
