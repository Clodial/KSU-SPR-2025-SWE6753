using Godot;
using System;

public partial class SceneManager : Node
{
	private static Node CurrentScene;

	public void SetCurrentScene(Node scene){
		if (scene == null){
			GD.Print("Cannot set current scene. The scene argument is null.");
			return;
		}
		GD.Print("Current scene set: " + scene.Name);
		CurrentScene = scene;
	}

	public static void RestartScene(){
		GD.Print("Restart Scene!");
		if (CurrentScene == null){
			GD.Print("Cannot restart current scene. The current scene is null.");
			return;
		}
			
		if (!CurrentScene.IsInsideTree()){
			GD.Print("Cannot restart current scene. The current scene is not inside a SceneTree.");
			return;
		}
			
		CurrentScene.GetTree().ReloadCurrentScene();
	}
}
