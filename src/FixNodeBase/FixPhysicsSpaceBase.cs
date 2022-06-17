using Godot;
using Godot.Collections;
using FixMath.NET;
using static Godot.GD;

namespace FixPhysics.NodeBase
{
    public class FixPhysicsSpaceBase : Reference
    {
        [Signal]
        delegate void _space_before_update();
        [Signal]
        delegate void _space_updated();
        [Signal]
        delegate void _updated_finished();


        public static float DefaultGravity
        {
            get => (float)FixPhysics.FixPhysicsManager.DefaultGravity;
            set => FixPhysics.FixPhysicsManager.DefaultGravity = (Fix64)value;
        }
        public static Vector3 DefaultGravityVector
        {
            get => FixPhysics.FixPhysicsManager.DefaultGravityVector;
            set => FixPhysics.FixPhysicsManager.DefaultGravityVector = value;
        }
        public static float DefaultLinearDamp
        {
            get => (float)FixPhysics.FixPhysicsManager.DefaultLinearDamp;
            set => FixPhysics.FixPhysicsManager.DefaultLinearDamp = (Fix64)value;
        }
        public static float DefaultAngularDamp
        {
            get => (float)FixPhysics.FixPhysicsManager.DefaultAngularDamp;
            set => FixPhysics.FixPhysicsManager.DefaultAngularDamp = (Fix64)value;
        }
        public static uint PhysicsFps
        {
            get => FixPhysics.FixPhysicsManager.PhysicsFps;
            set => FixPhysics.FixPhysicsManager.PhysicsFps = value;
        }


        /// <summary>
        /// 射线测试
        /// </summary>
        /// <param name="from">起点坐标</param>
        /// <param name="to">终点坐标</param>
        /// <param name="exclude">需要排除的对象</param>
        /// <param name="collisionMask">碰撞遮罩</param>
        /// <param name="collideWithBodies">与物体交互</param>
        /// <param name="collideWithAreas">与区域交互</param>
        /// <returns> 测试结果字典
        ///     "collider"：检测到的对象 -> FixCollisionObject 
        ///     "normal": 击中点在被检测对象上的 法向方向 -> Vector3
        ///     "position": 击中点的全局坐标
        /// </returns>
        static Dictionary IntersectRay(Vector3 from , Vector3 to , Array exclude = null, int collisionMask = 0x7FFFFFFF, bool collideWithBodies = true, bool collideWithAreas = false)
            => FixPhysics.FixPhysicsManager.IntersectRayForGds(from, to , exclude, collisionMask, collideWithBodies, collideWithAreas);


        static void UpdateFixSpace() => FixPhysics.FixPhysicsManager.UpdateSpace();
        FixPhysicsSpaceBase()
        {
            FixPhysics.FixPhysicsManager.SpaceBeforeUpdate += ()=> EmitSignal(nameof(_space_before_update));
            FixPhysics.FixPhysicsManager.SpaceUpdated += ()=> EmitSignal(nameof(_space_updated));
            FixPhysics.FixPhysicsManager.UpdatedFinished += ()=> EmitSignal(nameof(_updated_finished));
                
        }

    }

}