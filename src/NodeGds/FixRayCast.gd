tool
extends Spatial

class_name FixRayCast,"res://addons/FixPhysics/icon/FixRayCast.png"

const FixRayCastBase = preload("res://addons/FixPhysics/src/FixNodeBase/FixRayCastBase.cs")
var _base :FixRayCastBase = load("res://addons/FixPhysics/src/FixNodeBase/FixRayCastBase.cs").new(self)

#**********************
# 射线结果在定点物理帧模更新
#**********************

#============属性==============
#使能
var enable :bool setget _set_enable, _get_enable
func _set_enable(v:bool)->void : _base.set_Enable(v)
func _get_enable()->bool :return _base.get_Enable()

#投射的方向与大小
var cast_to: Vector3 setget _set_cast_to , _get_cast_to
func _set_cast_to(v:Vector3)->void : _base.set_CastTo(v)
func _get_cast_to()->Vector3 : return _base.get_CastTo()

#是否排除直接父节点
var exculde_parent :bool setget _set_exculde_parent , _get_exculde_parent
func _set_exculde_parent(v:bool) -> void :_base.set_ExculdeParent(v)
func _get_exculde_parent() -> bool: return _base.get_ExculdeParent()

#碰撞遮罩
var collision_mask :int setget _set_collision_mask, _get_collision_mask
func _set_collision_mask(v:int) -> void : _base.set_CollisionMask(v)
func _get_collision_mask() -> int : return _base.get_CollisionMask()

#是否与物体交互
var collision_with_bodies :bool setget _set_collision_with_bodies, _get_collision_with_bodies
func _set_collision_with_bodies(v:bool) -> void : _base.set_CollisionWithBodies(v)
func _get_collision_with_bodies() -> bool :return _base.get_CollisionWithBodies()

#是否与区域交互
var collision_with_areas :bool setget _set_collision_with_areas, _get_collision_with_areas
func _set_collision_with_areas(v:bool) -> void: _base.set_CollisionWithAreas(v)
func _get_collision_with_areas() -> bool : return _base.get_CollisionWithAreas()


#===============方法===============
#参考Godot物理
func add_exception(object: FixCollisionObject) -> void: _base.AddException(object)
func clear_exceptions() -> void : _base.ClearExceptionS()
func get_collision_mask_bit(bit :int) ->bool: return _base.GetCollisionMaskBit(bit)
func is_colliding()->bool :return _base.IsColliding()
func force_raycast_update()->void: _base.ForceRaycastUpdate()
func remove_exception(object:FixCollisionObject)->void: _base.RemoveException(object)
func get_collider()->FixCollisionObject: return _base.GetCollider()
func get_collision_normal()->Vector3 :return _base.GetCollisionNormal()
func get_collision_point()->Vector3 :return _base.GetCollisionPoint()
func get_collision_travel()->float :return _base.GetCollisionTravel()
