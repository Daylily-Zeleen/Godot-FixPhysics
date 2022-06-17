using Godot;
using BEPUutilities;
using FixMath.NET;
using System;
using static Godot.GD;

namespace FixPhysics.NodeBase
{
    public class FixRigidBodyBase : Reference, IFixCollisionObject
    {

        internal FixEntity _GetFixEntity() => rigidBodyEntity;

        public RigidBody.ModeEnum Mode
        {
            get => rigidBodyEntity.Mode;
            set => rigidBodyEntity.Mode = value;
        }


        public float Mass
        {
            get => (float)rigidBodyEntity.tmpMass ;
            set 
            {
                if(value == 0) rigidBodyEntity.tmpMass = Fix64.One;
                else 
                    rigidBodyEntity.tmpMass = MathHelper.Clamp((Fix64)value, F64.C0p01, 65535);
                if (rigidBodyEntity.Mode != RigidBody.ModeEnum.Static && rigidBodyEntity.Mode != RigidBody.ModeEnum.Kinematic)
                    rigidBodyEntity.Mass = rigidBodyEntity.tmpMass;
            }
        }
        public float Weight
        {
            get => (float)(rigidBodyEntity.Mass * FixPhysicsManager.DefaultGravity);
            set => rigidBodyEntity.Mass = (MathHelper.Clamp((Fix64)value, F64.C0p01, 65535) / FixPhysicsManager.DefaultGravity);
        }
        public PhysicsMaterial PhysicsMaterialOverride
        {
            get => rigidBodyEntity.PhysicsMaterialOverride;
            set => rigidBodyEntity.PhysicsMaterialOverride = value;
        }
        public float GravityScale
        {
            get => (float)rigidBodyEntity.GravityScale;
            set => rigidBodyEntity.GravityScale = MathHelper.Clamp((Fix64)value, -128, 128);
        }
        public bool ContinuousCd
        {
            get => rigidBodyEntity.ContinuousCd;
            set => rigidBodyEntity.ContinuousCd = value;
        }
        public int ContactsReported
        {
            get => rigidBodyEntity.ContactsReported;
            set => rigidBodyEntity.ContactsReported = Math.Abs(value);
        }
        public bool ContactMonitor
        {
            get => rigidBodyEntity.ContactMonitor;
            set => rigidBodyEntity.ContactMonitor = value;
        }
        public bool Sleeping
        {
            get => rigidBodyEntity.Sleeping;
            set => rigidBodyEntity.Sleeping = value;
        }
        public bool CanSleep
        {
            get => rigidBodyEntity.CanSleep;
            set => rigidBodyEntity.CanSleep = value;
        }
        public Godot.Vector3 LinearVelocity { get => rigidBodyEntity.LinearVelocity; set => rigidBodyEntity.LinearVelocity = value; }
        public Godot.Vector3 AngularVelocity { get => rigidBodyEntity.AngularVelocity; set => rigidBodyEntity.AngularVelocity = value; }
        public float LinearDamp 
        { 
            get 
            {
                if(rigidBodyEntity.LinearDamp == Fix64.MinusOne) return -1f;
                else if (rigidBodyEntity.LinearDamp == Fix64.Zero) return 0f;
                else return (float)rigidBodyEntity.LinearDamp;
            }
            set 
            {
                if(value == -1) rigidBodyEntity.LinearDamp = Fix64.MinusOne;
                else if(value == 0) rigidBodyEntity.LinearDamp = Fix64.Zero;
                else rigidBodyEntity.LinearDamp = (Fix64)value;
            }
        }
        public float AngularDamp 
        { 
            get 
            {
                if(rigidBodyEntity.AngularDamp == Fix64.MinusOne) return -1f;
                else if (rigidBodyEntity.AngularDamp == Fix64.Zero) return 0f;
                else return (float)rigidBodyEntity.AngularDamp;
            }
            set 
            {
                if(value == -1) rigidBodyEntity.AngularDamp = Fix64.MinusOne;
                else if(value == 0) rigidBodyEntity.AngularDamp = Fix64.Zero;
                else rigidBodyEntity.AngularDamp = (Fix64)value;
            }
        }





        public uint CollisionLayer
        {
            get => rigidBodyEntity.Layer;
            set => rigidBodyEntity.Layer = value;
        }
        public uint CollisionMask
        {
            get => rigidBodyEntity.Mask;
            set => rigidBodyEntity.Mask = value;
        }

        FixEntity IFixCollisionObject.FixEntity => rigidBodyEntity;


        // 实体
        private RigidBodyEntity rigidBodyEntity; // 实体引用

        // 构造
        public FixRigidBodyBase(Godot.Spatial ownerNode)
        {
            rigidBodyEntity = new RigidBodyEntity(ownerNode);
        }
        private FixRigidBodyBase(){}

        #region PhysicsBody兼容性API
        public void AddCollisionExceptionWith(Node body) => rigidBodyEntity.BodyMate.AddCollisionExceptionWith(body);
        public void RemoveCollisionExceptionWith(Node body) => rigidBodyEntity.BodyMate.RemoveCollisionExceptionWith(body);
        public Godot.Collections.Array GetCollisionExceptions() => rigidBodyEntity.BodyMate.GetCollisionExceptions();
        public bool GetCollisionLayerBit(int bit) => rigidBodyEntity.BodyMate.GetCollisionLayerBit(bit);
        public bool GetCollisionMaskBit(int bit) => rigidBodyEntity.BodyMate.GetCollisionMaskBit(bit);
        public void SetCollisionLayerBit(int bit, bool value) => rigidBodyEntity.BodyMate.SetCollisionLayerBit(bit, value);
        public void SetCollisionMaskBit(int bit, bool value) => rigidBodyEntity.BodyMate.SetCollisionMaskBit(bit, value);
        #endregion
        #region 兼容性API
        public void ApplyCentralImpulse(Godot.Vector3 impulse) => rigidBodyEntity.ApplyCentralImpulse(impulse);

        public void ApplyTorqueImpulse(Godot.Vector3 impulse) => rigidBodyEntity.ApplyTorqueImpulse(impulse);

        public void ApplyImpulse(Godot.Vector3 position, Godot.Vector3 impulse) => rigidBodyEntity.ApplyImpulse(position, impulse);

        public Godot.Collections.Array GetCollidingBodies() => rigidBodyEntity.GetCollidingBodies();

        #endregion

	}
}
