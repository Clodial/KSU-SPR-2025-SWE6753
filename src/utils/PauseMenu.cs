using Godot;
using System;

public partial class PauseMenu : Node
{
	[Signal] public delegate void ExitGameEventHandler();
	[Signal] public delegate void LevelSelectEventHandler();
	[Signal] public delegate void SettingsEventHandler();
	[Export] private SceneManager sceneManager;
	[Export] private CanvasLayer hud;

	public override void _Ready()
	{
		// Ensures this node keeps processing even when the tree is paused
		ProcessMode = Node.ProcessModeEnum.Always;
		hud.Hide();
	}

	public override void _Input(InputEvent @event)
	{
		if (@event is InputEventKey eventKey && eventKey.Pressed)
		{
			if (eventKey.Keycode == Key.Escape) // Check if Escape is pressed
			{
				TogglePause();
			}
		}
	}

	private void TogglePause()
	{
		if(sceneManager.GetCurrentScene() == null)
			return;

		if(sceneManager.GetCurrentScene().ProcessMode == Node.ProcessModeEnum.Pausable)
		{
			GetTree().Paused = !GetTree().Paused;
			
			if(GetTree().Paused){
				GetParent().Call("pause_level_music");
				hud.Show();
			}
			else{
				GetParent().Call("play_level_music");
				hud.Hide();
			}
		}
	}

	public void OnContinueGame(){
		TogglePause();
	}

	public void OnExitGame()
	{
		EmitSignal("ExitGame");
	}

	public void OnLevelSelect(){
		hud.Hide();
		GetTree().Paused = false;
		EmitSignal("LevelSelect");
	}

	public void OnSettings(){
		hud.Hide();
		EmitSignal("Settings");
	}
}
