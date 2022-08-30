extends Node2D


var hitpoints: float = 10.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Canion.set_esta_disparando(true)


func _on_Area2D_body_entered(body: Node) -> void:
	if body is Player:
		body.destruir()


func recibir_danio(danio: float) -> void:
	hitpoints -= danio
	if hitpoints <= 0.0:
		queue_free()
