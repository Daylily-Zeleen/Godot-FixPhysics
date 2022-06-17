tool
extends Spatial

class_name FixCollisionObject,"res://addons/FixPhysics/icon/FixCollisionObject.png"

#===============属性================
#碰撞层
export(int, LAYERS_3D_PHYSICS) var collision_layer :int setget _set_collision_layer ,_get_collision_layer
func _set_collision_layer(v:int) ->void: _base.set_CollisionLayer(v)
func _get_collision_layer()->int : return _base.get_CollisionLayer()

#碰撞遮罩
export(int, LAYERS_3D_PHYSICS) var collision_mask :int setget _set_collision_mask ,_get_collision_mask
func _set_collision_mask(v:int) ->void:_base.set_CollisionMask(v)
func _get_collision_mask()->int: return _base.get_CollisionMask()

#================方法================
#参考Godot自带物理
func get_collision_layer_bit(bit:int) -> bool: return _base.GetCollisionLayerBit(bit)
func get_collision_mask_bit(bit:int) -> bool: return _base.GetCollisionMaskBit(bit)
func set_collision_layer_bit(bit:int , value:bool) -> void: _base.SetCollisionLayerBit(bit,value)
func set_collision_mask_bit(bit:int , value:bool) -> void: _base.SetCollisionMaskBit(bit,value)

#获取定点物理空间，等价于调取AutoLoad FixPhysicsSpace
func get_fix_space() : return null if not get_node("/root/FixPhysicsSpace") else get_node("/root/FixPhysicsSpace")




#*****再每次定点物理帧更新结束时被调用*******
func _fix_physics_process(fix_delta:float) -> void:
	pass
#*****用于重写，类比 _physics_process(delta) **********






#========================内部==========================
#节点警告
func _get_configuration_warning():
	for c in get_children():
		if (c as Node).has_method("_GetShapeBase"):
			return ""
	return "至少必须有一个 FixCollisionShape 作为子节点。"

#构造器
func _init():
	_init_()
	if not _base :
		printerr("FixCollisionObject 与 FixPhysicsBody 不能被直接实例化")
		queue_free()
		
func _ready():
	if not Engine.editor_hint:
		get_node("/root/FixPhysicsSpace").connect("fix_physics_updated", self, "_on_fix_physics_updated",[get_node("/root/FixPhysicsSpace").fix_physics_process_delta_time])
		
#用于子类重写
func _init_():
	_base = null

#内部获取器
func _GetFixBase(): return _base
var _base :Reference

func _process(delta):
	if Engine.editor_hint:
		scale = Vector3(1,1,1)

func _on_fix_physics_updated(fix_delta:float)->void:
	_fix_physics_process(fix_delta)
