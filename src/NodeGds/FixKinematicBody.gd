tool
extends FixPhysicsBody

class_name FixKinematicBody,"res://addons/FixPhysics/icon/FixKinematicBody.png"

#与其他物理节点不同,FixKinematicBody 的属性方法是参考Godot 4.0设计的#
#****
# 注意：
#	FixKinematicBody 和 FixRigidBody 的互动行为与 KinematicBody 和 RigidBody 的互动有明显差异。
#	例如:
#		一个linear_velocity受重力影响FPS胶囊体人物(FixKinematicBody)，可以站在一个方块(Rigid模式下的 FixRigidBody)上，（此时is_on_floor() == true）。
#		而在Godot中，胶囊体人物立于方块上时(is_on_floor()==false)会直接把（Rigid模式下的RigidBody）弹开，使得胶囊体人物能站在真正的地面上
#****


#====================属性=======================
#线速度，设置该属性不会移动 FixKinematicBody
#调用move_and_slide 并且 在定点世界更新时才会移动 
#该属性会根据与其他定点物理体的碰撞而产生改变
export var linear_velocity :Vector3 setget _set_linear_velocity, _get_linear_velocity
func _set_linear_velocity(v:Vector3)->void: _base.set_LinearVelocity(v)
func _get_linear_velocity()->Vector3: return _base.get_LinearVelocity()

#是否在斜坡停止
export var stop_on_slope :bool setget _set_stop_on_slope,_get_stop_on_slope
func _set_stop_on_slope(v:bool)->void: _base.set_StopOnSlope(v)
func _get_stop_on_slope()->bool :return _base.get_StopOnSlope()

# 地板最大角度(角度制)
# 用于判定 is_on_floor()
export(float, 0, 90 , 0.001 ) var floor_max_angle_degrees :float setget _set_floor_max_angle_degrees ,_get_floor_max_angle_degrees 
func _set_floor_max_angle_degrees(v:float)->void: _base.set_FloorMaxAngleDegrees(v)
func _get_floor_max_angle_degrees()->float : return _base.get_FloorMaxAngleDegrees()

#吸附值
# 如果 snap 近似为 Vector3.Zero 将不起作用
#	在定点帧末会移动尝试将 FixKinematicBody 按增量移动 snap
#	如果接触到地板，则会吸附到地板上 
export var snap :Vector3 setget _set_snap, _get_snap
func _set_snap(v:Vector3)->void: _base.set_Snap(v)
func _get_snap() ->Vector3: return _base.get_Snap()

#上参考方向
#用于判定 is_on_floor() is_on_wall() is_on_ceiling()
export var up_direction :Vector3 setget _set_up_direction , _get_up_direction
func _set_up_direction(v:Vector3) ->void:_base.set_UpDirection(v)
func _get_up_direction()->Vector3 :return _base.get_UpDirection()


#====================方法=======================
#参考Godot物理
func get_axis_lock(axis :int)->bool :return _base.GetAxisLock(axis)
func get_floor_normal()->Vector3:return _base.GetFloorNormal()
func get_floor_velocity()->Vector3 :return _base.GetFloorVelocity()
func set_axix_lock(axis:int ,lock:bool): _base.SetAxisLock(axis,lock)
# 返回一个由 FixKinematicContact 组成的数组
# 帧末的所有接触信息，每帧末更新
func get_contacts()->Array :return _base.GetContactsForGds()

func is_on_ceiling()->bool :return _base.IsOnCeiling()
func is_on_floor()->bool :return _base.IsOnFloor()
func is_on_wall()->bool :return _base.IsOnWall()

#注意：与Godot不同,该方法在一帧内调用多次也只会执行一次
func move_and_slide()->void: _base.MoveAndSlide() 






#====================内部=========================
func _to_string()-> String: return "[FixKinematicBody:%d]" % get_instance_id() 
func _init_():
	_base = load("res://addons/FixPhysics/src/FixNodeBase/FixKinematicBodyBase.cs").new(self)
