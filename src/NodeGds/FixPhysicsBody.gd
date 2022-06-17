tool
extends FixCollisionObject

class_name FixPhysicsBody,"res://addons/FixPhysics/icon/FixCollisionObject.png"
const FixCollisionObject = preload("res://addons/FixPhysics/src/NodeGds/FixCollisionObject.gd")

#API
#参考Godot自带物理，注意这里的均继承自FixCollisionObject
func add_collision_exception_with(body:FixCollisionObject) ->void :_base.AddCollisionExceptionWith(body)
func remove_collision_exception_with(body:FixCollisionObject) ->void :_base.RemoveCollisionExceptionWith(body)
func get_collision_exceptions() ->Array : return _base.GetCollisionExceptions()

