using Godot;

namespace FixPhysics.NodeBase
{
    public class FixRayCastBase:Reference
    {
        private FixRay fixRay;

        /// <summary>
        /// 使能
        /// </summary>
        public bool Enable
        {
            get => fixRay.Enable;
            set => fixRay.Enable = value;
        }
        /// <summary>
        /// 投射方向长度（局部）
        /// </summary>
        public Vector3 CastTo
        {
            get => fixRay.CastTo;
            set => fixRay.CastTo = value;
        }
        /// <summary>
        /// 是否排除直接父级（仅该物理内的对象）
        /// </summary>
        public bool ExculdeParent
        {
            get => fixRay.ExculdeParent;
            set => fixRay.ExculdeParent = value;
        }
        /// <summary>
        /// 碰撞遮罩
        /// </summary>
        public uint CollisionMask 
        { 
            get => fixRay.CollisionMask; 
            set => fixRay.CollisionMask = value; 
        }

        /// <summary>
        /// 是否与物体交互
        /// </summary>
        public bool CollisionWithBodies 
        { 
            get => fixRay.CollisionWithBodies; 
            set => fixRay.CollisionWithBodies = value; 
        }

        /// <summary>
        /// 是否与区域交互
        /// </summary>
        public bool CollisionWithAreas 
        { 
            get => fixRay.CollisionWithAreas; 
            set => fixRay.CollisionWithAreas = value; 
        }


        public FixRayCastBase(Godot.Spatial owenr)
        {
            fixRay = new FixRay(owenr);
        }
        private FixRayCastBase(){}


    #region API
        public void AddException(Godot.Node obj) => fixRay.AddException(obj);
        public void ClearExceptions() => fixRay.ClearExceptions();
        public bool GetCollisionMaskBit(int bit) => fixRay.GetCollisionMaskBit(bit);
        public Godot.Node GetCollider() => fixRay.GetCollider();
        public Vector3 GetCollisionNormal() => fixRay.GetCollisionNormal();
        public Vector3 GetCollisionPoint() => fixRay.GetCollisionPoint();
        public float GetCollisionTravel() => (float)fixRay.GetCollisionTravel();
        public bool IsColliding() => fixRay.IsColliding();
        public void ForceRaycastUpdate() => fixRay.ForceRaycastUpdate();
        public void RemoveException(Godot.Node obj) => fixRay.RemoveException(obj);
    #endregion


    }


}