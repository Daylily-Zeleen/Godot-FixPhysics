tool
extends FixCollisionObject 

class_name FixArea , "res://addons/FixPhysics/icon/FixArea.png"

#=============信号===============

signal area_entered(fix_area) #FixArea
signal area_exited(fix_area) #FixArea
signal body_entered(fix_body) #FixPhysicsBody
signal body_exited(fix_body) #FixPhysicsBody



enum SpaceOverride{
	DISABLED,
	COMBINE ,
	COMBINE_REPLACE ,
	REPLACE ,
	REPLACE_COMBINE 
}

#=================属性==================
#各项属性参考Godot原版物理
#空间覆写
export(SpaceOverride) var space_override :int setget _set_space_override, _get_space_override
func _set_space_override(v:int)->void: _base.SpaceOverride = v
func _get_space_override()->int :return _base.SpaceOverride

#点重力
export var gravity_point :bool setget _set_gravity_point, _get_gravity_point
func _set_gravity_point(v:bool)->void: _base.GravityPoint = v
func _get_gravity_point()->bool: return _base.GravityPoint 

#点重力衰减比例
export var gravity_distance_scale :float setget _set_gravity_distance_scale, _get_gravity_distance_scale
func _set_gravity_distance_scale(v:float)->void: _base.GravityDistanceScale = v
func _get_gravity_distance_scale(): return _base.GravityDistanceScale

#重力方向
export var gravity_vec :Vector3 setget _set_gravity_vec , _get_gravity_vec
func _set_gravity_vec(v:Vector3)->void : _base.GravityVec = v
func _get_gravity_vec()->Vector3: return _base.GravityVec
	
#重力大小
export var gravity :float setget _set_gravity ,_get_gravity
func _set_gravity(v:float)->void: _base.set_Gravity(v)
func _get_gravity()->float: return _base.get_Gravity()

#线速度阻尼
export(float, 0, 1, 0.001) var linear_damp :float setget _set_linear_damp , _get_linear_damp
func _set_linear_damp(v:float)->void: _base.set_LinearDamp(v)
func _get_linear_damp() -> float: return _base.get_LinearDamp()

#角速度阻尼
export(float, 0, 1, 0.001) var angular_damp :float setget _set_angular_damp , _get_angular_damp
func _set_angular_damp(v:float)->void: _base.set_AngularDamp(v)
func _get_angular_damp()->float: return _base.get_AngularDamp()

#空间覆写优先级
export var priority:int setget _set_priority, _get_priority
func _set_priority(v :int)->void :_base.set_Priority(v)
func _get_priority()->int: return _base.get_Priority()

#可检测
export var monitoring :bool setget _set_monitoring , _get_monitoring
func _set_monitoring(v:bool)->void : _base.set_Monitoring(v)
func _get_monitoring()->bool : return _base.get_Monitoring()

#可被检测
export var monitorable :bool setget _set_monitorable , _get_monitorable
func _set_monitorable(v:bool)->void :_base.set_Monitorable(v)
func _get_monitorable()->bool : return _base.get_Monitorable()


#====================方法================================
#参考Godot原版方法
func get_overlappint_areas() -> Array : return _base.GetOverlappingAreas()
func get_overlapping_bodies() -> Array: return _base.GetOverlappingBodies()
func overlaps_area(area:Node) -> bool : return _base.OverlapsArea(area)
func overlaps_body(body:Node)->bool :return _base.OverlapsBody(body)




#==================内部==================
func _to_string()-> String: return "[FixArea:%d]" % get_instance_id() 
func _init_():
	_base = (load("res://addons/FixPhysics/src/FixNodeBase/FixAreaBase.cs") as CSharpScript).new(self)
