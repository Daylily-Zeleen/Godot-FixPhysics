using Godot;
using BEPUutilities;
using FixMath.NET;
using static Godot.GD;
using FixPhysics;


namespace FixPhysics.NodeBase
{
	[Tool]
	public class FixAreaBase :Reference ,IFixCollisionObject
	{	
		public FixEntity _GetFixEntity() => areaEntity;
		
		#region Areaprop
		public Godot.Area.SpaceOverrideEnum SpaceOverride 
		{
			get => areaEntity.AreaProps.SpaceOverride;
			set => areaEntity.AreaProps.SpaceOverride = value;
		}

		///<summary>
        /// 是否启用点重力
        ///</summary>
		public bool GravityPoint
		{
			get => areaEntity.AreaProps.GravityPoint;
			set => areaEntity.AreaProps.GravityPoint = value;
		}
		///<summary>
        /// 重力衰减因数
        ///</summary>
        public float GravityDistanceScale
		{
			get => (float)areaEntity.AreaProps.GravityDistanceScale;
			set => areaEntity.AreaProps.GravityDistanceScale = MathHelper.Clamp((Fix64)value , F64.C0 , 1024);
		}
		///<summary>
        /// 开启点重力时重力点的局部位置,关闭时为重力方向
        ///</summary>
		public Godot.Vector3 GravityVec
		{
			get => areaEntity.AreaProps.GravityVec;
			set => areaEntity.AreaProps.GravityVec = value;
		}		
		///<summary>
        /// 重力大小
        ///</summary>
		public float Gravity 
		{
			get => (float)areaEntity.AreaProps.Gravity;
			set => areaEntity.AreaProps.Gravity = MathHelper.Clamp((Fix64)value , -1024 , 1024) ;
		}		

		///<summary>
        /// 线速度阻尼
        ///</summary>
		public float LinearDamp
		{
			get => (float)areaEntity.AreaProps.LinearDamp;
			set => areaEntity.AreaProps.LinearDamp = MathHelper.Clamp((Fix64)value , F64.C0 , F64.C1);
		}	

		///<summary>
        /// 角速度阻尼
        ///</summary>
		public float AngularDamp 
		{
			get => (float)areaEntity.AreaProps.AngularDamp;
			set => areaEntity.AreaProps.AngularDamp = MathHelper.Clamp((Fix64)value , F64.C0 , F64.C1);
		}	

		//优先级 
		public int Priority 
		{
			get => areaEntity.AreaProps.Priority;
			set => areaEntity.AreaProps.Priority = value;
		}

		// 可检测其他Area和Body
		public bool Monitoring 
		{ 
			get => areaEntity.AreaProps.Monitoring ;
			set => areaEntity.AreaProps.Monitoring = value;
		}
		
		//可被其他Area检测
		public bool Monitorable 
		{ 
			get => areaEntity.AreaProps.Monitorable ;
			set => areaEntity.AreaProps.Monitorable = value;
		}		

		private Godot.Collections.Array OverlappingAreas => areaEntity.AreaProps.overlappingAreas;
		private Godot.Collections.Array OverlappingBodies => areaEntity.AreaProps.overlappingBodies;

		#endregion

		public uint CollisionLayer 
		{
			get => areaEntity.Layer;
			set => areaEntity.Layer =  value;
		}
		public uint CollisionMask 
		{
			get => areaEntity.Mask;
			set => areaEntity.Mask = value;
		}

        FixEntity IFixCollisionObject.FixEntity => areaEntity;
		
		// 实体
		internal AreaEntity areaEntity ;


		#region Arae兼容性API
		public bool GetCollisionLayerBit(int bit) => areaEntity.GetCollisionLayerBit(bit);
		public bool GetCollisionMaskBit(int bit) => areaEntity.GetCollisionMaskBit(bit); 
		public void SetCollisionLayerBit(int bit , bool value) => areaEntity.SetCollisionLayerBit(bit , value);

		public void SetCollisionMaskBit(int bit , bool value) => areaEntity.SetCollisionMaskBit(bit , value);

		public Godot.Collections.Array GetOverlappingAreas() => areaEntity.GetOverlappingAreas();
		public Godot.Collections.Array GetOverlappingBodies() => areaEntity.GetOverlappingBodies();
		public bool OverlapsArea(Node area) => areaEntity.OverlapsArea(area);
		public bool OverlapsBody(Node body) => areaEntity.OverlapsBody(body);
		#endregion


		
		/// 构造
		public FixAreaBase(Spatial owner) { areaEntity = new FixPhysics.AreaEntity(owner); }
		private FixAreaBase() { }

        public override string ToString() => string.Format("[FixArea:{0}]",base.GetInstanceId()) ;
	}
}
