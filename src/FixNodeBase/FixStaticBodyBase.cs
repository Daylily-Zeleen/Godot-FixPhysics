using Godot;
using static Godot.GD;

namespace FixPhysics.NodeBase
{
	public class FixStaticBodyBase :Reference ,IFixCollisionObject
	{	
		
		internal FixEntity _GetFixEntity() => staticBodyEntity;
		public PhysicsMaterial PhysicsMaterialOverride
        {
            get => staticBodyEntity.PhysicsMaterialOverride; 
            set => staticBodyEntity.PhysicsMaterialOverride = value;
		}
        public Godot.Vector3 ConstantLinearVelocity
        {
            get => staticBodyEntity.ConstantLinearVelocity; 
            set => staticBodyEntity.ConstantLinearVelocity = value; 
        }
        public Godot.Vector3 ConstantAngularVelocity
        {
            get => staticBodyEntity.ConstantAngularVelocity; 
            set => staticBodyEntity.ConstantAngularVelocity = value; 
        }
    

		public uint CollisionLayer 
		{
			get => staticBodyEntity.Layer;
			set => staticBodyEntity.Layer =  value;
		}
		public uint CollisionMask 
		{
			get => staticBodyEntity.Mask;
			set => staticBodyEntity.Mask = value;
		}

        FixEntity IFixCollisionObject.FixEntity => staticBodyEntity;
		
		private StaticBodyEntity staticBodyEntity;


        public FixStaticBodyBase(Godot.Spatial owner)
		{
			staticBodyEntity = new FixPhysics.StaticBodyEntity(owner);
		}
		private FixStaticBodyBase(){}

#region PhysicsBody兼容性API
		public void AddCollisionExceptionWith(Node body) => staticBodyEntity.BodyMate.AddCollisionExceptionWith(body);
		public void RemoveCollisionExceptionWith(Node body) => staticBodyEntity.BodyMate.RemoveCollisionExceptionWith(body);
		public Godot.Collections.Array GetCollisionExceptions() => staticBodyEntity.BodyMate.GetCollisionExceptions();
		public bool GetCollisionLayerBit(int bit) => staticBodyEntity.BodyMate.GetCollisionLayerBit(bit);
		public bool GetCollisionMaskBit(int bit) => staticBodyEntity.BodyMate.GetCollisionMaskBit(bit);
		public void SetCollisionLayerBit(int bit ,bool value) => staticBodyEntity.BodyMate.SetCollisionLayerBit(bit , value);
		public void SetCollisionMaskBit(int bit ,bool value) =>staticBodyEntity.BodyMate.SetCollisionMaskBit(bit , value);
#endregion
	}
}
