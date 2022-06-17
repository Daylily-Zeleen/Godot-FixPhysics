tool
extends FixPhysicsBody

class_name FixRigidBody,"res://addons/FixPhysics/icon/FixRigidBody.png"

#===============信号=================
signal body_entered(fix_body) #FixPhysicsBody
signal body_exited(fix_body) #FixPhysicsBody
signal sleeping_state_changed()

enum Mode{
	RIGID ,
	STATIC ,
	CHARACTER , #未实现，暂时用RIGID 模式代替
	KINEMATIC 
}


#====================属性=======================
#模式
export(Mode) var mode :int setget _set_mode, _get_mode
func _set_mode(v:int): _base.set_Mode(v)
func _get_mode()->int :return _base.get_Mode()

#质量(不像Godot自带刚体会在监视器里同步改变重力，须手动刷新)
export(float, EXP, 0.01, 65535)var mass :float setget _set_mass, _get_mass
func _set_mass(v:float): 
	_base.set_Mass(v)
func _get_mass()->float: return _base.get_Mass()

#重量(不像Godot自带刚体会在监视器里同步改变质量，须手动刷新)
export(float, EXP, 0.1, 65535) var weight:float setget _set_weight , _get_weight
func _set_weight(v:float) :
	_base.set_Weight(v)
func _get_weight()->float : return _base.get_Weight()

#物理材质覆写
export var physics_material_override :PhysicsMaterial setget _set_physics_material_override ,_get_physics_material_override
func _set_physics_material_override(v:PhysicsMaterial) : _base.set_PhysicsMaterialOverride(v)
func _get_physics_material_override()->PhysicsMaterial: return _base.get_PhysicsMaterialOverride()

#所受重力比例
export(float ,EXP,-128,128 , 0.001) var gravity_scale:float setget _set_gravity_scale, _get_gravity_scale
func _set_gravity_scale(v:float) :_base.set_GravityScale(v)
func _get_gravity_scale() -> float : return _base.get_GravityScale()

#连续位置检测
export var continuous_cd:bool setget _set_continuous_cd ,_get_continuous_cd
func _set_continuous_cd(v:bool) :_base.set_ContinuousCd(v)
func _get_continuous_cd() -> bool : return _base.get_ContinuousCd()

#接触报告次数（暂未实现）
export var contact_reported :int setget _set_contact_reported, _get_contact_reported
func _set_contact_reported(v:int): _base.set_ContactsReported(v)
func _get_contact_reported()->int : return _base.get_ContactsReported()
	
#接触检测
export var contact_monitor :bool setget _set_contact_monitor, _get_contact_monitor
func _set_contact_monitor(v:bool ) :_base.set_ContactMonitor(v)
func _get_contact_monitor()->bool : return _base.get_ContactMonitor()

#是否睡眠中（可强制睡眠，但不可强制唤醒）
export var sleeping :bool setget _set_sleeping , _get_sleeping
func _set_sleeping( v:bool ) : pass# _base.set_Sleeping(v)
func _get_sleeping()->bool : return _base.get_Sleeping()

#是否可睡眠（可强制保持唤醒）
export var can_sleep :bool setget _set_can_sleep , _get_can_sleep
func _set_can_sleep(v:bool ): _base.set_CanSleep(v)
func _get_can_sleep()->bool :return _base.get_CanSleep()

#自身线速度
export var linear_velocity :Vector3 setget _set_linear_velocity,_get_linear_velocity
func _set_linear_velocity( v:Vector3): _base.set_LinearVelocity(v)
func _get_linear_velocity()-> Vector3 : return _base.get_LinearVelocity()

#自身线性阻尼    
export(float ,-1 ,1, 0.001)var linear_damp :float setget _set_linear_damp, _get_linear_damp
func _set_linear_damp(v:float) :_base.set_LinearDamp(v)
func _get_linear_damp()->float :return  _base.get_LinearDamp()

#自身角速度
export var angular_velocity :Vector3 setget _set_angular_velocity,_get_angular_velocity
func _set_angular_velocity(v:Vector3): _base.set_AngularVelocity(v)
func _get_angular_velocity()->Vector3: return _base.get_AngularVelocity()

#自身旋转阻尼    
export(float ,-1 ,1, 0.001) var angular_damp :float setget _set_angular_damp, _get_angular_damp
func _set_angular_damp(v:float) :_base.set_AngularDamp(v)
func _get_angular_damp()->float :return  _base.get_AngularDamp()


#=================方法=======================
func applay_central_impulse(impulse:Vector3) ->void : _base.ApplyCentralImpulse(impulse)
func apply_troque_impulse(impulse:Vector3) -> void: _base.ApplyTorqueImpulse(impulse)
func apply_impulse(position:Vector3, impulse:Vector3) -> void : _base.ApplyImpulse(position,impulse)
func get_colliding_bodies()->Array :return _base.GetCollidingBodies() #由FixPhysicsBody组成




#=================内部====================
func _to_string()-> String: return "[FixRigidBody:%d]" % get_instance_id() 
func _init_():
	_base = load("res://addons/FixPhysics/src/FixNodeBase/FixRigidBodyBase.cs").new(self)

