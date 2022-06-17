extends Reference

class_name FixKinematicContact

# 只读的数据结构
# 与 KinematicCollision 相似，当有明显不同
# 从 FixKinematicBody 中获取，属于对应的 FixKinematicBody 接触信息


# ============属性=============
# 碰撞对象
var collider : FixCollisionObject setget _readonly
# 接触位置
var position : Vector3 setget _readonly
# 接触法线
var normal : Vector3 setget _readonly
# 碰撞对象的速度(线速度 和 角速度 的 合速度)
var collider_velocity : Vector3 setget _readonly
# 相对速度
var relative_velocity : Vector3 setget _readonly
# 法向冲量
var normal_impulse :float setget _readonly
# 摩擦力冲量
var friction_impulse :float setget _readonly



#==============内部==================
func _init(_collider :Node , _position:Vector3 , _normal : Vector3 , 
	_collider_velocity :Vector3 , _relative_velocity :Vector3 ,
	_normal_impulse:float , _friction_impulse:float):
	collider = _collider
	position = _position
	normal = _normal
	collider_velocity = _collider_velocity
	relative_velocity = _relative_velocity
	normal_impulse = _normal_impulse
	friction_impulse = _friction_impulse


func _readonly(v)->void: pass
