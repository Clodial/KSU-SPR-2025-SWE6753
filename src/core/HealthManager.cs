using Godot;
using System;

public partial class HealthManager : Node
{
	const int maxLives = 3;
	static int currentLives = maxLives;

	public void AddLife(){
		if(currentLives < maxLives){
			currentLives++;
		}
	}

	public void SubtractLife(){
		if(currentLives > 0){
			currentLives--;
		}

		if(currentLives == 0){
			// Reset
			GD.Print("Reset!");
		}
	}
}
