tool
extends Spatial
class_name FixCollisionShape,"res://addons/FixPhysics/icon/FixCollisionShape.png"

const FixCollisionShapeBase = preload("res://addons/FixPhysics/src/FixNodeBase/FixCollisionShapeBase.cs")
var _base :FixCollisionShapeBase = load("res://addons/FixPhysics/src/FixNodeBase/FixCollisionShapeBase.cs").new(self)


#==================属性======================
#形状设置器,形状设置通过这个属性进行访问
export var shape :Shape setget _set_shape, _get_shape
func _set_shape(v:Shape)->void : 
	_base.set_Shape(v)
	update_configuration_warning()
func _get_shape()->Shape : return _base.get_Shape()

#是否使能
export var disabled:bool setget _set_disabled, _get_disabled
func _set_disabled(v:bool)->void: _base.set_Disabled(v)
func _get_disabled()->bool : return _base.get_Disabled()

#是否显示碰撞区域（用于调试）
#全局参数，将对所有FixCollisionShape生效
export var show_collision_area:bool setget _set_show_collision_area , _get_show_collision_area
func _set_show_collision_area(v:bool)->void : _base.set_ShowCollisionArea(v)
func _get_show_collision_area()->bool:return _base.get_ShowCollisionArea()


#================内部===================
#获取器
func _GetShapeBase()->Reference: return _base._GetShapeBase()
#构造调试网格
func _ConstructDegudMesh(): _base._GetShapeBase()._ConstructDegudMesh()
#节点警告
func _get_configuration_warning()->String:
	if not get_parent() or  not get_parent() is FixCollisionObject:
		return "FixCollisionShape 必须是 FixArea、FixRigidBody、FixStaticBody 或 FixKinematicBody 的子节点。"
	if not _get_shape() :
		return "必须为该节点设置Shape。" 
	return ""
	
