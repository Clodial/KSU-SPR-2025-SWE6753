using Godot;
using System;
using System.ComponentModel.Design;

public partial class Enemy : CharacterBody2D
{
	[Export] public int Speed = 400;

	private bool moveRight = true;
	private bool collisionNotLocked = true;


	private Vector2 rayStart = Vector2.Zero;
	private Vector2 rayRight = new Vector2(100, 0);
	private Vector2 rayLeft = new Vector2(-100, 0);
	private bool hitSomething = false;
	[Export] private NodePath raycastNodePathRight;
	[Export] private NodePath raycastNodePathLeft;

	private RayCast2D _rayCastRight;
	private RayCast2D _rayCastLeft;
	private float horizontalDirection = 1f;

	private float FallAcceleration = 20f;
	private float TerminalGravity = 500f;

	private float JumpImpulse = 300f;

	public override void _Ready()
	{
		GD.Print("Test Enemy");
		_rayCastRight = GetNode<RayCast2D>(raycastNodePathRight);
		_rayCastLeft = GetNode<RayCast2D>(raycastNodePathLeft);
	}

	public override void _Process(double delta)
	{
		
	}

	public override void _PhysicsProcess(double delta)
	{

		if (!IsOnFloor()){
			Velocity += new Vector2(0, FallAcceleration);
			if (Velocity.Y > TerminalGravity)
			{
				Velocity = new Vector2(Velocity.X, TerminalGravity);
			}
		}
		else
		{
			Velocity -= new Vector2(Velocity.X,JumpImpulse);
		}


		if (_rayCastRight.IsColliding() && collisionNotLocked)
		{
			hitSomething = true;
			// The object that was hit (TileMap, StaticBody2D, etc.)
			object collider = _rayCastRight.GetCollider();

			if(collider.ToString().Contains("TileMapLayer")){
				collisionNotLocked = false;
				horizontalDirection = -1f;
			}
		}
		else if(_rayCastLeft.IsColliding() && collisionNotLocked)
		{
			hitSomething = true;
			// The object that was hit (TileMap, StaticBody2D, etc.)
			object collider = _rayCastLeft.GetCollider();

			if(collider.ToString().Contains("TileMapLayer")){
				collisionNotLocked = false;
				horizontalDirection = 1f;
			}
		}
		else{
			collisionNotLocked = true;
			hitSomething = false;
		}

		//QueueRedraw(); // Request re-draw to update visualization

		HandleMovement(delta);
	}

	private void HandleMovement(double delta){

		Velocity = new Vector2(Speed * horizontalDirection, Velocity.Y);
		
		// Attempt to move and check if a collision occurs
		MoveAndSlide();
	}

	public override void _Draw()
	{
		Color rayColor = hitSomething ? Colors.Red : Colors.Green; // Red if hit, Green if not
		//DrawLine(rayStart, rayRight, rayColor, 2); // Draw the ray
		//DrawLine(rayStart, rayLeft, rayColor, 2); // Draw the ray
	}

}
