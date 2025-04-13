using Godot;
using System;
using System.ComponentModel.DataAnnotations;

public partial class SettingsMenu : Node
{
	[Signal] public delegate void BackToMainEventHandler();
	[Export] Slider volumeSlider;
	private ConfigFile config = new ConfigFile();
	private float maxVolume = 5;

	public override void _Ready()
	{
		volumeSlider.ValueChanged += OnSliderValueChanged;

		// Load data from a file.
		Error err = config.Load("user://settings.cfg");

		// If the file didn't load, ignore it.
		if (err != Error.Ok)
		{
			int busIndex = AudioServer.GetBusIndex("Master"); // Replace with your bus name
			float volumeDb = AudioServer.GetBusVolumeDb(busIndex);
			float linear = Mathf.DbToLinear(volumeDb);
			volumeSlider.Value = (linear / maxVolume) * volumeSlider.MaxValue;

			return;
		}

		float savedVolume = (float)config.GetValue("settings", "volume");
		volumeSlider.Value = (savedVolume / maxVolume) * volumeSlider.MaxValue;
		SetVolume(savedVolume);
	}

	private void OnSliderValueChanged(double value)
	{
		double sliderPercentage = value / volumeSlider.MaxValue;
		float currentVolume = maxVolume * (float)sliderPercentage;
		SetVolume(currentVolume);
	}

	private void SetVolume(float value){
		float db = Mathf.LinearToDb(value);
		AudioServer.SetBusVolumeDb(0, db);

		config.SetValue("settings", "volume", value);
		config.Save("user://settings.cfg");
	}

	public void OnBackToMainMenu()
	{
		EmitSignal(SignalName.BackToMain);
	}
}
