tool
extends EditorPlugin
	
func _enter_tree():
	add_autoload_singleton("FixPhysicsSpace","res://addons/FixPhysics/src/FixPhysicsSpace.gd")
	
	connect("scene_changed" , self , "_on_scene_changed")
	
	add_custom_type("FixArea","Spatial",
			preload("res://addons/FixPhysics/src/NodeGds/FixArea.gd"),
			preload("res://addons/FixPhysics/icon/FixArea.png"))
	add_custom_type("FixKinematicBody","Spatial",
			preload("res://addons/FixPhysics/src/NodeGds/FixKinematicBody.gd"),
			preload("res://addons/FixPhysics/icon/FixKinematicBody.png"))
	add_custom_type("FixRigidBody","Spatial",
			preload("res://addons/FixPhysics/src/NodeGds/FixRigidBody.gd"),
			preload("res://addons/FixPhysics/icon/FixRigidBody.png"))
	add_custom_type("FixStaticBody","Spatial",
			preload("res://addons/FixPhysics/src/NodeGds/FixStaticBody.gd"),
			preload("res://addons/FixPhysics/icon/FixStaticBody.png"))
	add_custom_type("FixCollisionShape","Spatial",
			preload("res://addons/FixPhysics/src/NodeGds/FixCollisionShape.gd"),
			preload("res://addons/FixPhysics/icon/FixCollisionShape.png"))
	add_custom_type("FixRayCast","Spatial",
			preload("res://addons/FixPhysics/src/NodeGds/FixRayCast.gd"),
			preload("res://addons/FixPhysics/icon/FixRayCast.png"))
	
	
func _exit_tree():
	remove_autoload_singleton("FixPhysicsSpace")
	remove_custom_type("FixStaticBody")
	remove_custom_type("FixRigidBody")
	remove_custom_type("FixKinematicBody")
	remove_custom_type("FixArea")
	remove_custom_type("FixCollisionShape")

func _iterator_return_children(node:Node)->Array:
	var children:Array
	if node.get_child_count() >0 :
		children.append_array(node.get_children())
		for c in node.get_children():
			children.append_array(_iterator_return_children(c))
	return children
	
const FixCollisionShape =preload("res://addons/FixPhysics/src/NodeGds/FixCollisionShape.gd")
func _on_scene_changed(scene_root:Node)->void:
	if not scene_root: return  
	var all_node :Array =  _iterator_return_children(scene_root)
	for n in all_node:
		if n is FixCollisionShape:
			n._ConstructDegudMesh()
