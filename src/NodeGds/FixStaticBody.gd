tool
extends FixPhysicsBody

class_name FixStaticBody,"res://addons/FixPhysics/icon/FixStaticBody.png"

#==================属性====================
#参考Godot自带静态体方法
#物理材质覆写
export var physics_material_override :PhysicsMaterial setget _set_physics_material_override, _get_physics_material_override
func _set_physics_material_override(v:PhysicsMaterial): _base.set_PhysicsMaterialOverride(v)
func _get_physics_material_override()->PhysicsMaterial :return _base.get_PhysicsMaterialOverride()

#恒定线速度,仅影响接触的 RigidBody(Rigid 模式下)
export var constant_linear_velocity :Vector3 setget _set_constant_linear_velocity, _get_constant_linear_velocity
func _set_constant_linear_velocity(v:Vector3): _base.set_ConstantLinearVelocity(v)
func _get_constant_linear_velocity()->Vector3: return _base.get_ConstantLinearVelocity()

#恒定角速度，仅影响接触的 RigidBody(Rigid 模式下)
export var constant_angular_velocity :Vector3 setget _set_constant_angular_velocity, _get_constant_angular_velocity
func _set_constant_angular_velocity(v:Vector3): _base.set_ConstantAngularVelocity(v)
func _get_constant_angular_velocity() ->Vector3: return _base.get_ConstantAngularVelocity()




#==================内部========================
func _to_string()-> String: return "[FixStaticBody:%d]" % get_instance_id() 
func _init_():
	_base = load("res://addons/FixPhysics/src/FixNodeBase/FixStaticBodyBase.cs").new(self)
