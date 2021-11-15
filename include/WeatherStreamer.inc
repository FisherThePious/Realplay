#define WEATHER_AREA_NONE 0
#define WEATHER_AREA_LOS_SANTOS 1
#define WEATHER_AREA_LAS_VENTURAS 2
#define WEATHER_AREA_BONE_COUNTY 3
#define WEATHER_AREA_TIERRA_ROBADA 4
#define WEATHER_AREA_SAN_FIERRO 5
#define WEATHER_AREA_RED_COUNTY 6
#define WEATHER_AREA_FLINT_COUNTY 7
#define WEATHER_AREA_WHETSTONE 8

forward OnPlayerEnterWeatherArea(playerid, areaid, weatherid);

stock SetAreaWeather(areaid, weatherid)
{
	return CallRemoteFunction("SetAreaWeather", "dd", areaid, weatherid);
}

stock GetAreaWeather(areaid)
{
	return CallRemoteFunction("GetAreaWeather", "d", areaid);
}

stock GetPlayerWeatherArea(playerid)
{
	return CallRemoteFunction("GetPlayerWeatherArea", "d", playerid);
}

stock GetPlayerWeather(playerid)
{
	return CallRemoteFunction("GetPlayerWeather", "d", playerid);
}