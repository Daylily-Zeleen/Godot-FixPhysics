# FixPhysics--定点物理插件

## 概述

1. 该物理引擎内部完全由定点数控制，能够保证物理的跨平台确定性
   但 GDscript 不支持定点数运算，目前从gds中直接输入到定点物理相关的参数除了整数和布尔外均为浮点数， 因此从控制逻辑上讲仍然不具备跨平台确定性，暂时不建议用于正式开发中， 如果要用于正式开发，请对所有输入的浮点数据进行适当处理，在输入到定点物理引擎中会自动转换为定点数。
   
2. 由于 基于 C# 实现， 定点数计算 ，并且 经过C# 与 Gds 的转换，因此不要过分期待定点物理引擎的性能，在正式使用时请尽量减少对定点物理的依赖。

## 如何使用

1. 必须使用mono版本。
2. 像普通插件一样将插件置于 addons 文件夹下。
3. 生成解决方案后将 “res:\\\addons\FixPhysics\FixPhysics.dll" 添加到项目引用并重新生成项目。
4. 像普通插件一样启用即可。


## 与Godot自带物理引擎相比的一些明显差异

1. FixKinematicBody:

   - 一个linear_velocity受重力影响FPS胶囊体人物(FixKinematicBody)，可以站在一个方块(Rigid模式下的 FixRigidBody)上，（此时is_on_floor() == true）。而在Godot中，胶囊体人物立于方块上时(is_on_floor()==false)会直接把（Rigid模式下的RigidBody）弹开，使得胶囊体人物能站在真正的地面上
   - move_and_slide() 是按帧生效的，在一帧里调用多次也只会生效一次。
   
2. FixCollisionShape:

   - BoxShape, CapsuleShape, CylinderShape,  SphereShape 的缩放不会生效（无论是局部缩放还是世界缩放）
   - HeightMap, RayShape, PlaneShape 均未实现
   - 在编辑器中显示的形状不能被选中，也没有Gizemo来进行修改，只能修改Shape的属性
   - 如果要在运行时显示调试网格，设置FixCollisionShape.show_collision_area 为 true 即可（这是一个全局属性，仅需在1个FixCollisionShape中进行设置）

## 接下来的计划

1. 为GDscrpit添加定点数学支持，虽然能实现但是实用性无法保证，原因如下：

  - gds不支持自定义数据结构，只能用自定义类实现，实际使用时创建和回收造成的性能消耗影响不好估量（考虑池化）。
  - gds不支持运算符重载，在实际使用时所有定点运算都只能通过调用方法实现。
  - 4.0 gds语法改变，过多在gds上创建功能升级4.0可能会造成很多麻烦。
2. 在实现定点数支持后，将定点物理对象的变换更新改为手动设置 ，目前是在帧前检测空间变换，如果改变了将自动同步到定点物理空间中。准备通过手动设置定点数变换来改变对象在定点物理空间中的变换，防止引入浮点误差。
3. 可能会删减一些不常用不实用的功能，以提升性能，如：

  - FixKinematicBody中获取帧末接触接触状态。
  - FixAreaBody的点重力功能。
  - FixStaticBody影响所接触 FixRigidBody 恒定速度的功能。
4. 添加回滚的功能，正式成为Godot 帧同步工具的一环。


## 

​		目前为测试阶段。请大家多多测试发现bug。

如果没人反馈的可能就不会进行这个计划了，一个人扛太久会坚持不下去的~~

