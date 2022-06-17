using Godot;
using FixMath.NET;
using static Godot.GD;


namespace FixPhysics.NodeBase
{
	public class FixKinematicBodyBase : Reference ,IFixCollisionObject
	{	
		
		internal FixEntity _GetFixEntity() => kinematicBodyEntity;

		// internal int MaxSlides {get => kinematicBodyEntity.MaxSlides; set => kinematicBodyEntity.MaxSlides = value; }
        internal Godot.Vector3 LinearVelocity {get => kinematicBodyEntity.LinearVelocity; set => kinematicBodyEntity.LinearVelocity = value;}
        internal bool StopOnSlope {get => kinematicBodyEntity.StopOnSlope; set => kinematicBodyEntity.StopOnSlope = value;}
        internal float FloorMaxAngleDegrees {get => (float)kinematicBodyEntity.FloorMaxAngleDegrees; set => kinematicBodyEntity.FloorMaxAngleDegrees = (Fix64)value;}
        internal Godot.Vector3 Snap { get => kinematicBodyEntity.Snap ; set => kinematicBodyEntity.Snap = value;} 
        internal Godot.Vector3 UpDirection { get => kinematicBodyEntity.UpDirection ; set => kinematicBodyEntity.UpDirection = value;} 




		public uint CollisionLayer 
		{
			get => kinematicBodyEntity.Layer;
			set => kinematicBodyEntity.Layer =  value;
		}
		public uint CollisionMask 
		{
			get => kinematicBodyEntity.Mask;	
			set => kinematicBodyEntity.Mask = value;
		}

        FixEntity IFixCollisionObject.FixEntity => kinematicBodyEntity ;


		// 实体
		private KinematicBodyEntity kinematicBodyEntity ; // 实体引用
	
		// 构造
        public FixKinematicBodyBase(Godot.Spatial owner)
		{		
			kinematicBodyEntity = new KinematicBodyEntity(owner) ;
		}
        private FixKinematicBodyBase(){}


#region PhysicsBody兼容性API
		public void AddCollisionExceptionWith(Node body) => kinematicBodyEntity.BodyMate.AddCollisionExceptionWith( body);
		public void RemoveCollisionExceptionWith(Node body) => kinematicBodyEntity.BodyMate.RemoveCollisionExceptionWith( body);
		public Godot.Collections.Array GetCollisionExceptions() => kinematicBodyEntity.BodyMate.GetCollisionExceptions();
		public bool GetCollisionLayerBit(int bit) => kinematicBodyEntity.BodyMate.GetCollisionLayerBit(bit);
		public bool GetCollisionMaskBit(int bit) => kinematicBodyEntity.BodyMate.GetCollisionMaskBit(bit);
		public void SetCollisionLayerBit(int bit ,bool value) => kinematicBodyEntity.BodyMate.SetCollisionLayerBit( bit , value);
		public void SetCollisionMaskBit(int bit ,bool value) =>kinematicBodyEntity.BodyMate.SetCollisionMaskBit(bit , value);
#endregion
#region 兼容性API
        public bool GetAxisLock(PhysicsServer.BodyAxis axis) => kinematicBodyEntity.GetAxisLock(ref axis);
        public Vector3 GetFloorNormal() => kinematicBodyEntity.GetFloorNormal();
        public Vector3 GetFloorVelocity() => kinematicBodyEntity.GetFloorVelocity();

		// 返回包含 FixKinematicContact.gd的数组
        public Godot.Collections.Array GetContactsForGds(int slideIdx) => kinematicBodyEntity.GetContactsForGds();
		public int GetContactCount() => kinematicBodyEntity.GetContactCount();
        public bool IsOnCeiling() => kinematicBodyEntity.IsOnCeiling;
        public bool IsOnFloor() => kinematicBodyEntity.IsOnFloor;
        public bool IsOnWall() => kinematicBodyEntity.IsOnWall;

        public void SetAxisLock(PhysicsServer.BodyAxis axis , bool @lock) => kinematicBodyEntity.SetAxisLock(ref axis,ref @lock);
        public void MoveAndSlide() => kinematicBodyEntity.MoveAndSlide();
       
#endregion


   	}
}
