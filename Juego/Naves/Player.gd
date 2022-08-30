class_name Player
extends RigidBody2D

# Enums
enum ESTADO {SPAWN, VIVO, INVENCIBLE, MUERTO}

# Atributos export
export var potencia_motor: int = 20
export var potencia_rotacion: int = 280
export var estela_maxima: int = 150
export var hitpoints: float = 15.0

# Atributos
var empuje: Vector2 = Vector2.ZERO
var direccion_rotacion: int = 0
var estado_actual: int = ESTADO.SPAWN

# Atributos Onready
onready var canion: Canion = $Canion
onready var laser: RayoLaser = $LaserBeam2D
onready var estela: Estela = $EstelaPuntoInicio/Trail2D
onready var motorSFX: Motor = $MotorSFX
onready var colisionador: CollisionShape2D = $CollisionShape2D


# Metodos
func _unhandled_input(event: InputEvent) -> void:
	if not esta_input_activo():
		return
	
	# Disparo rayo laser
	if event.is_action_pressed("disparo_secundario"):
		laser.set_is_casting(true)
	
	if event.is_action_released("disparo_secundario"):
		laser.set_is_casting(false)
	
	# Control estela y motorSFX
	if event.is_action_pressed("mover_adelante"):
		estela.set_max_points(estela_maxima)
		motorSFX.sonido_on()
	elif event.is_action_pressed("mover_atras"):
		estela.set_max_points(0)
		motorSFX.sonido_on()
	
	if (event.is_action_released("mover_adelante") or event.is_action_released("mover_atras")):
		motorSFX.sonido_off()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	controlador_estados(estado_actual)


func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	apply_central_impulse(empuje.rotated(rotation))
	apply_torque_impulse(direccion_rotacion * potencia_rotacion)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	player_input()


func player_input() -> void:
	if not esta_input_activo():
		return
	
	# empuje
	empuje = Vector2.ZERO
	if Input.is_action_pressed("mover_adelante"):
		empuje = Vector2(potencia_motor, 0)
	elif Input.is_action_pressed("mover_atras"):
		empuje = Vector2(-potencia_motor, 0)
	
	# rotacion
	direccion_rotacion = 0
	if Input.is_action_pressed("girar_horario"):
		direccion_rotacion -= 1
	elif Input.is_action_pressed("girar_antihorario"):
		direccion_rotacion += 1
	
	# disparar
	if Input.is_action_just_pressed("disparo_principal"):
		canion.set_esta_disparando(true)
	elif Input.is_action_just_released("disparo_principal"):
		canion.set_esta_disparando(false)


# Metodos Custom
func controlador_estados(nuevo_estado: int) -> void:
	match nuevo_estado:
		ESTADO.SPAWN:
			#colisionador.set_deferred() esta linea, reemplace cambiando la propiedad directamente, probar si anda correcto
			colisionador.disabled = true
			canion.set_puede_disparar(false)
		ESTADO.VIVO:
			colisionador.disabled = false
			canion.set_puede_disparar(true)
		ESTADO.INVENCIBLE:
			colisionador.disabled = true
		ESTADO.MUERTO:
			colisionador.disabled = true
			canion.set_puede_disparar(false)
			Eventos.emit_signal("nave_destruida", self.global_position, 3)
			self.queue_free()
		_:
			printerr('Error de estado')

	estado_actual = nuevo_estado


func esta_input_activo() -> bool:
	if estado_actual in [ESTADO.MUERTO, ESTADO.SPAWN]:
		return false
	
	return true


func destruir() -> void:
	controlador_estados(ESTADO.MUERTO)


func recibir_danio(danio: float) -> void:
	hitpoints -= danio
	if hitpoints <= 0:
		self.destruir()


# Seniales Internas
func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "spawn":
		controlador_estados(ESTADO.VIVO)
