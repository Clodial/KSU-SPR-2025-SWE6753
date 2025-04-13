using Godot;
using System;
using System.Collections.Generic;

public partial class SceneManager : Node
{
	/*
	[Export] PackedScene level1_1;
	string level1_1_code = "level1_1";
	[Export] PackedScene level1_2;
	string level1_2_code = "level1_2";
	[Export] PackedScene level1_3;
	string level1_3_code = "level1_3";
	[Export] PackedScene level1_4;
	string level1_4_code = "level1_4";
	[Export] PackedScene level1_5;
	string level1_5_code = "level1_5";
*/

	[Export] PackedScene[] levels;
	Dictionary<string, PackedScene> levelDictionary {get;} = new Dictionary<string, PackedScene>();


	private static Node CurrentScene;

	public override void _Ready(){
		for(int i = 0; i < levels.Length; i++){
			string levelName = "level" + ((i / 5)+1) + "_" + ((i % 5)+1);
			GD.Print("Levels: " + levelName);
			levelDictionary.Add(levelName, levels[i]);
		}
	}

	public PackedScene GetScene(string levelCode){
		return levelDictionary[levelCode];
	}

	public Node GetCurrentScene()
	{
		return CurrentScene;
	}

	public void SetCurrentScene(Node scene)
	{
		if (scene == null){
			GD.Print("Cannot set current scene. The scene argument is null.");
			return;
		}
		GD.Print("Current scene set: " + scene.Name);
		CurrentScene = scene;
	}

	public static void RestartScene()
	{
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
