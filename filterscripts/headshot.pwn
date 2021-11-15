//<============================================================================>
//<============================================================================>
//<=======================[INSTANT HEADSHOT KILL]==============================>
//<=======================[    FILTERSCRIPT     ]==============================>
//<============================================================================>
//<============================================================================>
#include <a_samp>
//<============================================================================>
#define SERVER_MAX_PLAYERS 24 //Change to max players of your server
//<===============================[Chat Colours]===============================>
#define COLOUR_DEFAULT     		0x80FF80FF //(All Chat and Text In Game Colour)
#define COLOUR_GLOBAL      		0x80FF80FF // Global Chat Colour
#define COLOUR_HEADER      		0x56FE5FFF // Header Chat Colour
#define COLOUR_LOCAL       		0xDFFFDFFF // Local  Chat Colour
#define COLOUR_OTHER       		0xA4FFA4FF // Other  Texts
//<============================================================================>

new RecentlyShot[SERVER_MAX_PLAYERS];

public OnFilterScriptInit()
{
	print("\n---------------------------------------");
	print("   Instant Kill With Headshot Loaded     ");
	print("------------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	print("\n---------------------------------------");
	print("   Instant Kill With Headshot Unloaded   ");
	print("------------------------------------------\n");
	return 1;
}

public OnPlayerConnect(playerid)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{

	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys & KEY_FIRE && newkeys & KEY_HANDBRAKE) {
	    if(RecentlyShot[playerid] == 0) {
	        RecentlyShot[playerid] = 1;
	        SetTimerEx("AntiSpam", 1000, false, "d", playerid);
			if(GetPlayerWeapon(playerid) == 34) {
		        new Float:blahx, Float:blahy, Float:blahz;
				HeadshotCheck(playerid, blahx, blahy, blahz);
		        return 1;
		    }
			return 1;
		}
		return 1;
 	}
	return 1;
}

forward AntiSpam(playerid);
public AntiSpam(playerid) {
	RecentlyShot[playerid] = 0;
	return 1;
}

stock PlayerName(playerid) {
	new name[24];
	GetPlayerName(playerid, name, sizeof(name));
	return name;
}

stock HeadshotCheck(playerid, &Float:x, &Float:y, &Float:z)
{
	new Float:fx,Float:fy,Float:fz;
	GetPlayerCameraFrontVector(playerid, fx, fy, fz);

 	new Float:cx,Float:cy,Float:cz;
 	GetPlayerCameraPos(playerid, cx, cy, cz);

	for(new Float:i = 0.0; i < 50; i = i + 0.5)
	{
 		x = fx * i + cx;
		y = fy * i + cy;
		z = fz * i + cz;

		#if defined SHOWPATH
		CreatePickup(1239, 4, x, y, z, -1);
		#endif

		for(new player = 0; player < SERVER_MAX_PLAYERS; player ++)
		{
		    if(IsPlayerConnected(playerid))
		    {
		    	if(player != playerid)
				{
		    		if(GetPlayerSpecialAction(player) == SPECIAL_ACTION_DUCK) //CROUCHING
					{
		        		if(IsPlayerInRangeOfPoint(player, 0.3, x, y, z))
		        		{
		        		    new string[128];
							SendClientMessage(playerid, COLOUR_HEADER, "You hear a gunshot");
							format(string, sizeof(string), "You shoot and hit %s in the head instantly killing them", PlayerName(player));
							SendClientMessage(player, COLOUR_HEADER, string);
		            		SetPlayerHealth(player, 0.0);
		            		CallRemoteFunction("OnPlayerDeath", "ddd", player, playerid, 34);
		        		}
					}
					else //NOT CROUCHING
					{
		    			if(IsPlayerInRangeOfPoint(player, 0.3, x, y, z - 0.7))
						{
		        		    new string[128];
							SendClientMessage(playerid, COLOUR_HEADER, "You hear a gunshot");
							format(string, sizeof(string), "You shoot and hit %s in the head instantly killing them", PlayerName(player));
							SendClientMessage(player, COLOUR_HEADER, string);
		            		SetPlayerHealth(player, 0.0);
		            		CallRemoteFunction("OnPlayerDeath", "ddd", player, playerid, 34);
						}
					}
				}
			}
		}
	}
	return 1;
}


