using Godot;
using static Godot.GD;


namespace FixPhysics.NodeBase
{
	[Tool]
	public class FixCollisionShapeBase : Godot.Reference
	{
		private FixCollisionShapeHolder holder ;
        public FixCollisionShapeHolder _GetShapeBase() => holder._GetShapeHolder();
		public bool ShowCollisionArea
		{
			get => holder.ShowCollisionArea;
			set => holder.ShowCollisionArea = value;
		}
		public Godot.Shape Shape
		{
			get => holder.Shape;
			set => holder.Shape = value;
		}

		public bool Disabled
		{
			get => holder.Disabled;
			set => holder.Disabled = value;
		}

		/// <summary>
		/// 构造器
		/// </summary>
		public FixCollisionShapeBase(Godot.Spatial owner)
		{
			holder = new FixCollisionShapeHolder(owner);
		}

		/// <summary> Godot用 </summary>
		private FixCollisionShapeBase(){}
		
		public override string ToString() { return string.Format("[FixCollisionShape:{0}]",base.GetInstanceId()) ;}

	}
}	