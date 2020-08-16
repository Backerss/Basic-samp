stock ToggleVehicleEngine(vehicleid, bool:enginestate)
{
	new engine, lights, alarm, doors, bonnet, boot, objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	SetVehicleParamsEx(vehicleid, enginestate, lights, alarm, doors, bonnet, boot, objective);
	return 1;
}

stock ResetVehicle(vehicleid)
{
	VehicleData[vehicleid][VehicleDBID] = 0;
	VehicleData[vehicleid][VehicleModel] = 0;
	VehicleData[vehicleid][VehicleColor][0] = 0;
	VehicleData[vehicleid][VehicleColor][1] = 0;

	for(new i = 0; i < 3;i++)
	{
		VehicleData[vehicleid][VehicleParkPos][i] = 0;
	}

	VehicleData[vehicleid][VehicleParkWorld] = 0;
	VehicleData[vehicleid][VehicleFaction] = 0;
	VehicleData[vehicleid][VehicleAdminSpawn] = false;

	return 1;
}