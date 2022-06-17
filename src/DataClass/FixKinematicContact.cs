using Godot;

public class FixKinematicContact:Reference
{
    public Node Collider {get;} 
    public Vector3 Position {get;} 
    public Vector3 Normal {get;} 
    public Vector3 ColliderVelocity {get;} 
    public Vector3 RelativeVelocity {get;} 
    public float NormalImpulse {get;}
    public float FrictionImpulse {get;} 

    public FixKinematicContact(Node collider , Vector3 position, Vector3 normal ,
            Vector3 colliderVelocity, Vector3 relativeVelocity,
            float normalImpulse , float frictionImpulse)
    {
        Collider = collider; 
        Position = position; 
        Normal = normal; 
        ColliderVelocity = colliderVelocity; 
        RelativeVelocity = relativeVelocity; 
        NormalImpulse = normalImpulse; 
        FrictionImpulse = frictionImpulse; 
    }
}
