extends Node

#***************
# 定点物理空间：
#	该物理引擎内部完全由定点数控制，能够保证物理的跨平台确定性
#	但 GDscript 不支持定点数运算，目前从gds中直接输入到定点物理相关的参数除了整数和布尔外均为浮点数
#	因此从控制逻辑上讲仍然不具备跨平台确定性，暂时不建议用于正式开发中
#	如果要用于正式开发，请对所有输入的浮点数据进行适当处理，在输入到定点物理引擎中会自动转换为定点数
#
#	目前为测试阶段，下一步是为 gds 添加 定点数学支持
#	顺利的话会逐渐完善相关的帧同步开发套件
#	注意：
#		由于 基于 C# 实现， 定点数计算 ，并且 经过C# 与 Gds 的转换，因此不要过分期待定点物理引擎的性能
#		在正式使用时请尽量减少对定点物理的依赖
#***************

const FixPhysicsSpaceBase = preload("res://addons/FixPhysics/src/FixNodeBase/FixPhysicsSpaceBase.cs")
var _base:FixPhysicsSpaceBase = load("res://addons/FixPhysics/src/FixNodeBase/FixPhysicsSpaceBase.cs").new()

#=============信号================
signal fix_physics_updated()#定点物理帧更新完毕


#=============属性================
#是否启用自动更新，默认启用自动更新
var auto_update:bool = true setget _set_auto_update, is_auto_update
func _set_auto_update(v:bool):
	auto_update = v
	if v: enable_auto_update()
	else : disable_auto_update()
func is_auto_update()->bool :return auto_update

#定点物理帧长
var fix_physics_process_delta_time:float = 1.0/self.physics_fps setget _read_only, get_fix_physics_process_delta_time
func _read_only(v:float)->void: pass
func get_fix_physics_process_delta_time()->float: return fix_physics_process_delta_time

#默认60
var physics_fps :int setget _set_physics_fps, _get_physics_fps
func _set_physics_fps(v:int) -> void: 
	fix_physics_process_delta_time = 1.0 / v
	_base.set_PhysicsFps(v)
func _get_physics_fps() -> int: return _base.get_PhysicsFps()

#默认重力大小
var default_gravity: float setget _set_default_gravity, _get_default_gravity
func _set_default_gravity(v:float)->void : _base.set_DefaultGravity(v)
func _get_default_gravity()->float: return _base.get_DefaultGravity()
	
#默认重力方向
var default_gravity_vector:Vector3 setget _set_default_gravity_vector, _get_default_gravity_vector
func _set_default_gravity_vector(v:Vector3)->void: _base.set_DefaultGravityVector(v)
func _get_default_gravity_vector()->Vector3 :return _base.get_DefaultGravityVector() 

#默认线速度阻尼
var default_linear_damp:float setget _set_default_linear_damp, _get_default_linear_damp
func _set_default_linear_damp(v:float)->void: _base.set_DefaultLinearDamp(v)
func _get_default_linear_damp()->float : return _base.get_DefaultLinearDamp() 

#默认角速度阻尼
var default_angular_damp :float setget _set_default_angular_damp, _get_default_angular_damp
func _set_default_angular_damp(v:float)->void : _base.set_DefaultAngularDamp(v)
func _get_default_angular_damp()->float: return _base.get_DefaultAngularDamp()

#=============方法================
#手动更新物理世界,按FPS所设定的帧长进行更新
func update_fix_space() -> void: 
	_base.UpdateFixSpace()

# <summary>
# 射线测试
# </summary>
# <param name="from">起点坐标</param>
# <param name="to">终点坐标</param>
# <param name="exclude">需要排除的对象</param>
# <param name="collisionMask">碰撞遮罩</param>
# <param name="collideWithBodies">与物体交互</param>
# <param name="collideWithAreas">与区域交互</param>
# <returns> 测试结果字典
#     "collider"：检测到的对象 -> FixCollisionObject 
#     "normal": 击中点在被检测对象上的 法向方向 -> Vector3
#     "position": 击中点的全局坐标
# </returns>
func intersect_ray(from:Vector3 , to:Vector3 , exclude:Array, collision_mask: int = 0x7FFFFFFF , collide_with_bodies:bool = true, collide_with_areas:bool = false)->Dictionary:
	return _base.IntersectRay(from, to, exclude, collision_mask, collide_with_bodies, collide_with_areas)


# 开启自动更新物理世界, 同时会设置FPS
# 但在之后设置FPS不会改变自动更新物理世界的更新频率
# 如果需要改变自动更新频率，需要再次调用该方法
func enable_auto_update(fix_physics_fps :int = self.physics_fps)-> void:
	self.physics_fps = fix_physics_fps
	if auto_update_timer != null:
		auto_update_timer.queue_free()
		auto_update_timer = null
	auto_update_timer = Timer.new()
	auto_update_timer.one_shot = false
	auto_update_timer.process_mode = Timer.TIMER_PROCESS_PHYSICS
	auto_update_timer.autostart = false
	auto_update_timer.connect("timeout",self,"update_fix_space")
	add_child(auto_update_timer)
	auto_update_timer.start(1.0/fix_physics_fps)
	


# 禁用自动更新物理世界
func disable_auto_update()->void:
	auto_update_timer.queue_free()
	auto_update_timer = null





#=============内部================
func _init():
	_base.connect("_space_updated", self,"_on_signal_received")
func _ready():
	if auto_update : enable_auto_update()
	
func _on_signal_received():
	emit_signal("fix_physics_updated")
var auto_update_timer:Timer 
