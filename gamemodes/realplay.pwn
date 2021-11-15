//<============================================================================>
//<============================================================================>
//<===========================[  ZEST REALPLAY  ]==============================>
//<============================================================================>
//<============================================================================>
//<===========================[    INCLUDES     ]==============================>
//<============================================================================>
#include <a_samp>
#include <a_vehicles>
#include <a_objects>
#include <a_players>
#include <dcmd>
#include <dutils>
#include <dini>
#include <dudb>
#include <utils>
#include <core>
#include <float>
#include <SCVM>
#include <CPS>
#include <md5>
#include <streamer>
#include <JunkBuster>
#include <SpikeStrip>
#include <WeatherStreamer>
//<============================================================================>
//<===============================[DEFINES]====================================>
//<============================================================================>
#define COLOUR_ADMINRED 		0xFB0000FF
#define COLOUR_AQUAGREEN		0x00CACAFB
#define COLOUR_BLUE        		0x0000BBAA
#define COLOUR_BLACK       		0x00000000
#define COLOUR_BRIGHTRED   		0xFF0000AA
#define COLOUR_BROWN       		0x993300AA
#define COLOUR_DARKGREEN   		0x008040FF
#define COLOUR_DARKRED     		0x660000AA
#define COLOUR_GRAD1       		0xB4B5B7FF
#define COLOUR_GRAD2       		0xBFC0C2FF
#define COLOUR_GOLD        		0xB8860BAA
#define COLOUR_GREEN       		0x33AA33AA
#define COLOUR_GREY        		0xAFAFAFAA
#define COLOUR_LIGHTBLUE   		0x1482DCFF
#define COLOUR_LIGHTGREEN 		0x38FF06FF
#define COLOUR_DARKPINK	    	0xE100E1FF
#define COLOUR_LIGHTRED 		0xFF8080FF
#define COLOUR_NICESKY 	    	0x99FFFFAA
#define COLOUR_ORANGE      		0xFF9900AA
#define COLOUR_PINK        		0xFF66FFAA
#define COLOUR_PURPLE      		0x800080AA
#define COLOUR_RED         		0xAA3333AA
#define COLOUR_RED1        		0xFF0000AA
#define COLOUR_VIOLET      		0xEE82EEFF
#define COLOUR_VIOLETDARK  		0x9400D3AA
#define COLOUR_YELLOW      		0xFFFF00AA
#define COLOUR_WHITE       		0xFFFFFFFF
//<===============================[Chat Colours]===============================>
#define COLOUR_DEFAULT     		0x80FF80FF //(All Chat and Text In Game Colour)
#define COLOUR_GLOBAL      		0x80FF80FF // Global Chat Colour
#define COLOUR_HEADER      		0x56FE5FFF // Header Chat Colour
#define COLOUR_LOCAL       		0xDFFFDFFF // Local  Chat Colour
#define COLOUR_OTHER       		0xA4FFA4FF // Other  Texts
//<=============================[Team Colours]=================================>
#define COLOUR_GECKO          0x00E1E1FF
#define COLOUR_FORELLI          0xB3AA97FF
#define COLOUR_THELOST  	0x6C0000FF
#define COLOUR_NORTHSIDE  		0x9400D3AA
//<=============================[Team Defines]=================================>
#define TEAM_CIVILLIAN 0     	// Civillian Team
#define TEAM_COP       1     	// Police    Team
#define TEAM_FORELLI   2 	 	// Lzarwisa
#define TEAM_LOST      3 	 	// Scotty
#define TEAM_GECKO   4 	 	// Beyondless
#define TEAM_NORTHSIDE 5 	 	// Fisher
//<===============================[Gate Edits]=================================>
#define TOLERANCE 10
#define OPENSPEED 3
#define CLOSESPEED 3
#define TIMERSPEED 1500
//<===============================[House Edits]================================>
#define MAX_HOUSES              100     // Max houses allowed to be created
#define PTP_RADIUS              2.0     // Radius of PlayerToPoint Function
//<================================[Car Edits]=================================>
#define MAX_PLAYERCAR           100
//<===============================[Login Edits]================================>
#define LOGIN_BEFORE_SPAWN
//<=============================[Car Name Edits]===============================>
#define SLOTS 25
//<===============================[Skin Edits]=================================>
#define MinSkinPrice 50
#define MaxSkinPrice 100
//<===============================[Fuel Edits]=================================>
#define CAR_AMOUNT 700   //Change it to your Amount
#define GasMax 100  	 //Don´t change this
#define RefuelWait 8000  //Refuel Time
#define RunOutTime 15000
//<============================================================================>
#pragma tabsize 0
#define dcmd(%1,%2,%3) if (!strcmp((%3)[1], #%1, true, (%2)) && ((((%3)[(%2) + 1] == '\0') && (dcmd_%1(playerid, ""))) || (((%3)[(%2) + 1] == ' ') && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1
#define SendFormattedMessage(%0,%1,%2) do{new _str[128]; format(_str,128,%2); SendClientMessage(%0,%1,_str);}while(FALSE)
//<============================================================================>
//<===============================[VARIABLES]==================================>
//<============================================================================>
const GateNum = 6; //number of gates present (defines other arrays)
const MiscObjNum = 1;
enum Info
{
	AdminLevel,
	Clan,
	Password[128],
	Cash,
	Bank,
	pTeam,
	pVehicle,
	pLevel,
	jLevel,
	pExp,
	jExp,
	pJob,
	pHouse,
	GangRank,
	JobRank,
	DLicense,
	Cannabis,
	Cocaine,
	Crack,
	Ecstasy,
	Firearms,
	Imported,
	Kevlar,
	Weapon1,
	Weapon2,
	Weapon3,
	Weapon4,
	Weapon5,
	Weapon6,
	Weapon7,
	Weapon8,
	Ammo1,
	Ammo2,
	Ammo3,
	Ammo4,
	Ammo5,
	Ammo6,
	Ammo7,
	Ammo8,
	Playerskin,
	Boughtskin,
	Warns,
	Jail,
	Custody,
	Logged,
	Mute,
	Float:SpawnX,
	Float:SpawnY,
	Float:SpawnZ,
	CustomSpawn,
	SpawnInt,
	GangOffer,
	JobOffer,
	OrderedPizza,
	OffererID,
	OfferedItem,
    OfferedAmount,
    OfferedPrice,
	WarnReason1[128],
	WarnReason2[128],
	WarnReason3[128],
	IP[20],
};
enum hInfo
{
	hName[24],
	hSellable,
	hSell,
	hLevel,
	hPickup,
	Float:hExitX,
	Float:hExitY,
	Float:hExitZ,
	hVirtualWorld,
	hLocked
};
enum cInfo
{
	cOwner[24],
	cModelid,
	cColour1,
	cColour2,
	Float:vposX,
	Float:vposY,
	Float:vposZ,
	Float:vposA,
	Mod0,
	Mod1,
	Mod2,
	Mod3,
	Mod4,
	Mod5,
	Mod6,
	Mod7,
	Mod8,
	Mod9,
	Mod10,
	Mod11,
	Mod12,
	Mod13,
	cLocked,
	cCarID
};
//<============================================================================>
enum MAPZONE_MAIN {
	ZNAME[28],
	Float:MAPZONE_AREA[6]
}
//<============================================================================>
enum SavePlayerPosEnum
{
Float:LastX,
Float:LastY,
Float:LastZ
};
//<============================================================================>
new IsInShop[MAX_PLAYERS];
new countvalue[MAX_PLAYERS];
new HasBoughtNewSkin[MAX_PLAYERS];
new KeyTimer[MAX_PLAYERS];
new wait[MAX_PLAYERS];
new Text:TextDraw[MAX_PLAYERS];
new Text:TestDirections;
new TextDrawString[MAX_PLAYERS][128];
new TextdrawActive[MAX_PLAYERS];
new Skin[MAX_PLAYERS];
new LastSkin[MAX_PLAYERS];
new AvailableSkins[] =
{
	0, 1, 2, 7, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19,
	20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33,
	34, 35, 36, 37, 38, 39, 40, 41, 43, 44, 45, 46, 47, 48,
	49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62,
	63, 66, 67, 68, 69, 70, 71, 72, 73, 75, 76, 77, 78,
	79, 80, 81, 82, 83, 84, 85, 87, 88, 89, 90, 91, 92, 93,
	94, 95, 96, 97, 98, 99, 101, 105,
	106, 107, 108, 109, 110, 111, 112,114, 115, 116,
	122, 123, 128,
	129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139,
	140, 141, 142, 143, 144, 145, 146, 147, 148, 150, 151,
	153, 154, 155, 156, 157, 158, 159, 160, 161, 162,
	163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173,
	174, 175, 176, 177, 178, 179, 180, 182, 183, 184,
	188, 189, 190, 191, 192, 193, 194, 195,
	196, 197, 198, 199, 200, 202, 203, 204, 205, 206,
	207, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218,
	219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229,
	230, 231, 232, 233, 234, 235, 236, 237, 238, 239, 240,
	241, 242, 243, 244, 245, 246, 250, 251,
	252, 253, 254, 255, 257, 258, 259, 260, 261, 262,
	263, 264, 268, 269, 270, 271, 272, 274,
	275, 276, 277, 278, 279, 282, 284,
	287, 288, 290, 291, 292, 293, 294, 295, 297,
	298
};
new SkinPrices[sizeof(AvailableSkins)];
new TotalSkins = sizeof(AvailableSkins);
//<============================================================================>
new Aeroplane;
new Truck;
new Boat;
new PoliceDropOff;
new TheLostDropOff;
new ForelliDropOff;
new GeckoDropOff;
new NorthsideDropOff;
//<============================================================================>
new EBrefuel1;
//new EBrefuel2;
new TSrefuel1;
//new TSrefuel2;
new JHrefuel1;
new JHDrivethru;
new GDrivethru;
//<============================================================================>
new Test1, Test2, Test3, Test4, Test5, Test6, Test7, Test8, Test9, Test10, Test11;
//<============================================================================>
new LostMain;
new LostMistys;
new LostTow;
//<============================================================================>
new counter;
new JailCountTimer;
new checkgastimer;
new stoppedvehtimer;
new PetrolUpdatetimer;
new Gas[CAR_AMOUNT];
new Refueling[MAX_PLAYERS];
new gGasBiz[MAX_PLAYERS];
new SavePlayerPos[MAX_PLAYERS][SavePlayerPosEnum];
new UpdateSeconds = 1;
new SpeedMode = 1;
new RoadBlockDeployed[MAX_PLAYERS];
new PlayerRB[MAX_PLAYERS];
//<============================================================================>
new HouseTimer[1];
//<============================================================================>
new VehNames[212][] = {	// Vehicle Names - Betamaster
	{"Landstalker"}, {"Bravura"}, {"Buffalo"}, {"Linerunner"},{"Perrenial"},{"Sentinel"},
	{"Dumper"},{"Firetruck"},{"Trashmaster"},{"Stretch"},{"Manana"},{"Infernus"},
	{"Voodoo"},{"Pony"},{"Mule"},{"Cheetah"},{"Ambulance"},{"Leviathan"},{"Moonbeam"},
    {"Esperanto"},{"Taxi"},{"Washington"},{"Bobcat"},{"Mr Whoopee"},{"BF Injection"},
	{"Hunter"},{"Premier"},	{"Enforcer"},{"Securicar"},{"Banshee"}, {"Predator"},
	{"Bus"},{"Rhino"},{"Barracks"},{"Hotknife"},{"Trailer 1"}, //artict1
	{"Previon"},{"Coach"},{"Cabbie"},{"Stallion"},{"Rumpo"},{"RC Bandit"},{"Romero"},
	{"Packer"},{"Monster"},{"Admiral"},{"Squalo"},{"Seasparrow"},{"Pizzaboy"},{"Tram"},
	{"Trailer 2"}, //artict2
    {"Turismo"},{"Speeder"},{"Reefer"},{"Tropic"},{"Flatbed"},{"Yankee"},{"Caddy"},
	{"Solair"},{"Berkley's RC Van"},{"Skimmer"},{"PCJ-600"},{"Faggio"},{"Freeway"},
	{"RC Baron"},{"RC Raider"},{"Glendale"},{"Oceanic"},{"Sanchez"},{"Sparrow"},
	{"Patriot"},{"Quad"},{"Coastguard"},{"Dinghy"},{"Hermes"},{"Sabre"},{"Rustler"},
	{"ZR-350"},{"Walton"},{"Regina"},{"Comet"},{"BMX"},{"Burrito"},{"Camper"},{"Marquis"},
	{"Baggage"},{"Dozer"},{"Maverick"},{"News Chopper"},{"Rancher"},{"FBI Rancher"},{"Virgo"},
	{"Greenwood"},{"Jetmax"},{"Hotring"},{"Sandking"},{"Blista Compact"},{"Police Maverick"},
	{"Boxville"},{"Benson"},{"Mesa"},{"RC Goblin"},{"Hotring Racer A"}, //hotrina
	{"Hotring Racer B"}, //hotrinb
    {"Bloodring Banger"},{"Rancher"},{"Super GT"},{"Elegant"},{"Journey"},{"Bike"},
	{"Mountain Bike"},{"Beagle"},{"Cropdust"},{"Stunt"},{"Tanker"}, //petro
	{"Roadtrain"},{"Nebula"},{"Majestic"},{"Buccaneer"},{"Shamal"},{"Hydra"},{"FCR-900"},
	{"NRG-500"},{"HPV1000"},{"Cement Truck"},{"Tow Truck"},{"Fortune"},{"Cadrona"},{"FBI Truck"},
	{"Willard"},{"Forklift"},{"Tractor"},{"Combine"},{"Feltzer"},{"Remington"},{"Slamvan"},
	{"Blade"},{"Freight"},{"Streak"},{"Vortex"},{"Vincent"},{"Bullet"},{"Clover"},{"Sadler"},
	{"Firetruck LA"}, //firela
	{"Hustler"},{"Intruder"},{"Primo"},{"Cargobob"},{"Tampa"},{"Sunrise"},{"Merit"},
	{"Utility"},{"Nevada"},{"Yosemite"},{"Windsor"},{"Monster A"}, //monstera
	{"Monster B"}, //monsterb
	{"Uranus"},{"Jester"},{"Sultan"},{"Stratum"},{"Elegy"},{"Raindance"},{"RC Tiger"},
	{"Flash"},{"Tahoma"},{"Savanna"},{"Bandito"},{"Freight Flat"},{"Streak Carriage"},
	{"Kart"},{"Mower"},{"Duneride"},{"Sweeper"},{"Broadway"},{"Tornado"},{"AT-400"},
	{"DFT-30"},{"Huntley"},{"Stafford"},{"BF-400"},{"Newsvan"},{"Tug"},{"Trailer 3"}, //petrotr
	{"Emperor"},{"Wayfarer"},{"Euros"},{"Hotdog"},{"Club"},{"Freight Carriage"}, //freibox
	{"Trailer 3"}, //artict3
	{"Andromada"},{"Dodo"},{"RC Cam"},{"Launch"},{"Police Car (LSPD)"},{"Police Car (SFPD)"},
    {"Police Car (LVPD)"},{"Police Ranger"},{"Picador"},{"S.W.A.T. Van"},{"Alpha"},
	{"Phoenix"},{"Glendale"},{"Sadler"},{"Luggage Trailer A"},{"Luggage Trailer B"}, //bagboxb
	{"Stair Trailer"}, {"Boxville"},{"Farm Plow"},{"Utility Trailer"} //utiltr1
};
//<============================================================================>
new WeapNames[][32] = {//           |- Weapon ID -|
	{"Unarmed (Fist)"}, 				// 0
	{"Brass Knuckles"}, 				// 1
	{"Golf Club"},      				// 2
	{"Night Stick"},    				// 3
	{"Knife"},          				// 4
	{"Baseball Bat"},   				// 5
	{"Shovel"},         				// 6
	{"Pool Cue"},       				// 7
	{"Katana"},         				// 8
	{"Chainsaw"},       				// 9
	{"Purple Dildo"},		    		// 10
	{"Big White Vibrator"},     		// 11
	{"Medium White Vibrator"}, 			// 12
	{"Small White Vibrator"}, 			// 13
	{"Flowers"},			  		    // 14
	{"Cane"},    						// 15
	{"Grenade"}, 						// 16
	{"Teargas"}, 						// 17
	{"Molotov"}, 						// 18
	{" "},       						// 19
	{" "},       						// 20
	{" "},       						// 21
	{"Colt 45"}, 						// 22
	{"Colt 45(Silenced)"},				// 23
	{"Deagle"},           				// 24
	{"Normal Shotgun"},   				// 25
	{"Sawnoff Shotgun"},  				// 26
	{"Combat Shotgun"},   				// 27
	{"Micro Uzi(Mac 10)"},				// 28
	{"SMG(MP5)"},         				// 29
	{"AK47"},             				// 30
	{"M4"},               				// 31
	{"Tec9"},             				// 32
	{"Country Rifle"},    				// 33
	{"Sniper Rifle"},     				// 34
	{"Rocket Launcher"},  	    		// 35
	{"Heat-Seeking Rocket Launcher"}, 	// 36
	{"Flamethrower"},     				// 37
	{"Minigun"},          				// 38
	{"Satchel Charge"},   				// 39
	{"Detonator"},        				// 40
	{"Spray Can"},        				// 41
	{"Fire Extinguisher"},				// 42
	{"Camera"},           				// 43
	{"Night Vision Goggles"},   		// 44
	{"Infrared Vision Goggles"}, 		// 45
	{"Parachute"},        				// 46
	{"Fake Pistol"}       				// 47
};
//<============================================================================>
new Float:ArrestJail[4][3] = {
    {215.4228,110.1929,999.0156},
    {219.4615,110.1877,999.0156},
    {223.3741,110.1803,999.0156},
    {227.3712,110.1818,999.0156}
};
//<============================================================================>
new Float:BankTill[3][3] = {
    {2316.6184,-10.1074,26.7422},
    {2316.6204,-12.7420,26.7422},
    {2316.6182,-15.4363,26.7422}
};
//<============================================================================>
new Float:gGasStationLocations[13][3] = {
{1004.0070,-939.3102,42.1797},   // LS
{1944.3260,-1772.9254,13.3906},  // LS
{-90.5515,-1169.4578,2.4079},    // LS
{-1609.7958,-2718.2048,48.5391}, // LS
{-2029.4968,156.4366,28.9498},	 // SF
{-2408.7590,976.0934,45.4175}, 	 // SF
{-2243.9629,-2560.6477,31.8841}, // LS -> SF
{-1676.6323,414.0262,6.9484}, 	 // LS -> SF
{2202.2349,2474.3494,10.5258}, 	 // LV
{614.9333,1689.7418,6.6968}, 	 // LV
{-1328.8250,2677.2173,49.7665},  // LV
{70.3882,1218.6783,18.5165}, 	 // LV
{2113.7390,920.1079,10.5255} 	 // LV
};
//<============================================================================>
new HouseInfo[MAX_HOUSES][hInfo];
new CarInfo[MAX_PLAYERCAR][cInfo];
new Float:HousesCoords[13][3] = {
{222.9534, 1287.7649, 1082.1406},   // Sml - 1 bedroom
{261.0827, 1284.6899, 1080.2578},   // Sml - 1 bedroom
{260.6734, 1237.7909, 1084.2578},   // Sml - 1 bedroom
{376.7426, 1417.3226, 1081.3281},   // Sml - 1 bedroom
{295.2874, 1473.2769, 1080.2578},   // Med - 2 bedroom
{327.9431, 1478.3801, 1084.4375}, // Med - 2 bedroom
{2270.1050, -1210.3917, 1047.5625},   // Med - 2 bedroom
{447.1211, 1397.8444, 1084.3047},   // Med - 2 bedroom
{2196.0063, -1204.6326, 1049.0234}, // Lrg - 3 bedroom
{235.3416, 1187.2882, 1080.2578},   // Lrg - 3 bedroom
{490.9987, 1399.4164, 1080.2578},   // Lrg - 3 bedroom
{227.1212, 1114.1840, 1080.9972},   // Lrg - 4 bedroom
{225.6624, 1022.5345, 1084.0145}    // Xlrg - 4 bedrooms
};
//<============================================================================>
new HousesLevels[13][2] = {
{1, 2000},    // Sml - 1 bedroom
{4, 4500},    // Sml - 1 bedroom
{9, 7000},    // Sml - 1 bedroom
{15, 10000},  // Sml - 1 bedroom
{15, 17000},  // Med - 2 bedroom
{15, 23000},  // Med - 2 bedroom
{10, 34000},  // Med - 2 bedroom
{2, 62000},   // Med - 2 bedroom
{6, 102000},  // Lrg - 3 bedroom
{3, 156000},  // Lrg - 3 bedroom
{2, 188000},  // Lrg - 3 bedroom
{5, 235000},   // Lrg - 4 bedroom
{7, 295000}   // Xlrg - 4 bedrooms
};
//<============================================================================>
new VehicleNames[212][] = {                             // Displays The Vehicle Name
   "Landstalker",  "Bravura",  "Buffalo", "Linerunner", "Perennial", "Sentinel",
   "Dumper",  "Firetruck" ,  "Trashmaster" ,  "Stretch",  "Manana",  "Infernus",
   "Voodoo", "Pony",  "Mule", "Cheetah", "Ambulance",  "Leviathan",  "Moonbeam",
   "Esperanto", "Taxi",  "Washington",  "Bobcat",  "Mr Whoopee", "BF Injection",
   "Hunter", "Premier",  "Enforcer",  "Securicar", "Banshee", "Predator", "Bus",
   "Rhino",  "Barracks",  "Hotknife",  "Trailer",  "Previon", "Coach", "Cabbie",
   "Stallion", "Rumpo", "RC Bandit",  "Romero", "Packer", "Monster",  "Admiral",
   "Squalo", "Seasparrow", "Pizzaboy", "Tram", "Trailer",  "Turismo", "Speeder",
   "Reefer", "Tropic", "Flatbed","Yankee", "Caddy", "Solair","Berkley's RC Van",
   "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron","RC Raider","Glendale",
   "Oceanic", "Sanchez", "Sparrow",  "Patriot", "Quad",  "Coastguard", "Dinghy",
   "Hermes", "Sabre", "Rustler", "ZR-350", "Walton",  "Regina",  "Comet", "BMX",
   "Burrito", "Camper", "Marquis", "Baggage", "Dozer","Maverick","News Chopper",
   "Rancher", "FBI Rancher", "Virgo", "Greenwood","Jetmax","Hotring","Sandking",
   "Blista Compact", "Police Maverick", "Boxville", "Benson","Mesa","RC Goblin",
   "Hotring Racer", "Hotring Racer", "Bloodring Banger", "Rancher",  "Super GT",
   "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropdust", "Stunt",
   "Tanker", "RoadTrain", "Nebula", "Majestic", "Buccaneer", "Shamal",  "Hydra",
   "FCR-900","NRG-500","HPV1000","Cement Truck","Tow Truck","Fortune","Cadrona",
   "FBI Truck", "Willard", "Forklift","Tractor","Combine","Feltzer","Remington",
   "Slamvan", "Blade", "Freight", "Streak","Vortex","Vincent","Bullet","Clover",
   "Sadler",  "Firetruck", "Hustler", "Intruder", "Primo", "Cargobob",  "Tampa",
   "Sunrise", "Merit","Utility Truck","Nevada","Yosemite", "Windsor", "Monster",
   "Monster","Uranus","Jester","Sultan","Stratum","Elegy","Raindance","RCTiger",
   "Flash","Tahoma","Savanna", "Bandito", "Freight", "Trailer", "Kart", "Mower",
   "Dune", "Sweeper", "Pimp-Mobile", "Tornado", "AT-400",  "DFT-30", "Huntley",
   "Stafford", "BF-400", "Newsvan","Tug","Trailer","Emperor","Wayfarer","Euros",
   "Hotdog", "Club", "Trailer", "Trailer","Andromada","Dodo","RC Cam", "Launch",
   "Police Car (LSPD)", "Police Car (SFPD)","Police Car (LVPD)","Police Ranger",
   "Picador",   "S.W.A.T. Van",  "Alpha",   "Phoenix",   "Glendale",   "Sadler",
   "Luggage Trailer","Luggage Trailer","Stair Trailer", "Boxville", "Farm Plow",
   "Utility Trailer"
};
//<============================================================================>
new Msg;
new Announcements[4][128] = {
"[Zestie]: Welcome To The Zest Gaming Roleplay Server ",
"[Zestie]: Our Script is almost finished just waiting for Fisher to stop being lazy",
"[Zestie]: If you're new to the server type (/tutorial)",
"[Zestie]: Visit us @ www.Zestgames.co.uk "
};
//<============================================================================>
new blackmark1, blackmark2;
new Tram1;
new Train1, Train2;
new BIAir;
new BITruck;
new BITrailer;
new BIBoat;
new Wango1, Wango2, Wango3, Wango4, Wango5, Wango6, Wango7;
new Wango1p, Wango2p, Wango3p, Wango4p, Wango5p, Wango6p, Wangbuy, Ottobuy;
new Wang1, Wang2, Wang3, Wang4, Wang5, Wang6, Wang7, Wang8, Wang9,Wang0;
new Wang1p, Wang2p, Wang3p, Wang4p, Wang5p, Wang6p, Wang7p, Wang8p,Wang9p,Wang10p;
new otto1, otto2, otto3, otto4, otto5, otto6, otto7, otto8;
new otto1p, otto2p, otto3p, otto4p, otto5p, otto6p, otto7p, otto8p;
new dsa1, dsa2;
new cop1, cop2, cop3, cop4, cop5, cop6, cop7, cop8, cop9, cop10, cop11, cop12;
new cop13, cop14, cop15, cop16, cop17, cop18, cop19, cop20, cop21, cop22, cop23;
new cop24, cop25, cop26, cop27;
new Civi1, Civi2, Civi3, Civi4, Civi5, Civi6, Civi7, Civi8, Civi9, Civi10;
new Civi11, Civi12, Civi13, Civi14, Civi15, Civi16, Civi17, Civi18,Civi19;
new Civi20, Civi21, Civi22;
new taxi1, taxi2, taxi3, taxi4, taxi5, taxi6, taxi7, taxi8;
new tow1, tow2, tow3, tow4;
new pilot1, pilot2, pilot3, pilot4, pilot5, pilot6, pilot7, pilot8;
new fire1, fire2;
new Ambul1, Ambul2, Ambul3, Ambul4, Ambul5, Ambul6;
new Gecko1, Gecko2, Gecko3, Gecko4, Gecko5, Gecko6, Gecko7, Gecko8, Gecko9, Gecko10;
new Forelli1, Forelli2, Forelli3, Forelli4, Forelli5, Forelli6, Forelli7, Forelli8, Forelli9, Forelli10, Forelli11;
new north1, north2, north3, north4, north5, north6, north7, north8;
new Biker1, Biker2, Biker3, Biker4, Biker5, Biker6, Biker7, Biker8, Biker9;
new pizza1, pizza2, pizza3, pizza4, pizza5, pizza6;
new bmv1, bmv2, bmv3, bmv4, bmv5, bmv6;
new church1,church2,church3,church4,church5,church6,church7;
new Vanjob1, Vanjob2, Vanjob3, Vanjob4;
new Busjob1, Busjob2, Busjob3, Busjob4, Busjob5, Busjob6;
new Buscar1, Buscar2, Buscar3;
new Cleanjob1, Cleanjob2, Cleanjob3, Cleanjob4, Cleanjob5, Cleanjob6, Cleanjob7, Cleanjob8;
new newsjob1, newsjob2, newsjob3, newsjob4, newsjob5;
new AccountInfo[MAX_PLAYERS][Info];
new bool:PMBlock[MAX_PLAYERS];
new gTeam[MAX_PLAYERS];
new Float:GateInfo[GateNum][9]; // Stores the Placement of the gates
new GateState[GateNum];         // Whether Gate is Being Used
new OpenGate[GateNum];          // Decides whether to open gate or not
new GateObject[GateNum];        // Stores what objectid the gate is
new MiscObject[MiscObjNum];     // Stores the id's of created objects
new Float:Tempx, Float:Tempy, Float:Tempz;              //Holds player position during loops
new Float:xtol1, Float:xtol2, Float:ytol1, Float:ytol2; //Holds area bounds during loops
new Timer;             // Allows Killtimer
new CasinoEnter;       // Casino Entrance
new CasinoExit;        // Casino Exit
new CasinoMeeting;     // Meeting Room Upstairs
new CasinoMeetingExit; // Meeting Room Exit
new CasinoCarpark;     // Meeting Room Enter Carpark
new CasinoCarparkExit; // Meeting Room Exit Carpark
new ZIP;			 // Zip Icon
new Shop;         	 // 24/7 Entrance
new ShopExit;     	 // 24/7 Exit
new Hospital;     	 // Hospital Entrance
new HospitalExit;    // Hospital Exit
new HospitalJob;     // Hopsital Job
new HospitalRoof;    // Hospital Roof Entrance
new HospitalRoofExit;// Hospital Roof Exit
new Townhall;     	 // Townhall Entrance
new TownhallExit; 	 // Townhall Exit
new PDUnder;      	 // PD Underground Entrance
new PDUnderExit;  	 // PD Underground Exit
new PDMain;       	 // PD Main Entrance
new PDMainExit;   	 // PD Main Exit
new Jizzys;       	 // Jizzys Downstairs Entrance
new JizzysExit;  	 // Jizzys Downstairs Exit
new JizzysRoof;   	 // Jizzys Roof Entrance
new JizzysRoofExit;  // Jizzys Roof Entrance
new Mistys;       	 // Mistys
new Mistysi;       	 // Mistys Info
new Mistysstaff;     // Mistys Staff
new MistyStaffExit; // Mistys Staff Exit
new MistysExit;   	 // Mistys Exit
new Forelli;         // Warehouse Entrance
new ForelliExit;     // Warehouse Exit
new Gecko;         // Warehouse Entrance
new GeckoExit;     // Warehouse Exit
new Church;          // Entrance to the Church
new ChurchExit;      // Exit from the Church
new TaxiEnter;       // Roadrunners Enter
new TaxiExit;        // Roadrunners Exit
new TaxiJob;         // Roadrunners Entrance
new PizzaJob;     	 // Pizza Job Pickup
new PizzaEnter;      // Pizza Place Entrance
new PizzaExit;       // Pizza Place Exit
new PilotEnter;      // Entrance to pilots lounge
new PilotExit;       // Exit from Pilots Lounge
new PilotJob;        // Getjob icon for pilot
new Gaydar;       	 // Gaydar Pickup
new GaydarExit;   	 // Gaydar Exit
new JobCenterIn;  	 // Jobcenter Entrance
new JobCenterOut; 	 // Jobcenter Exit
new Jobi;         	 // Job Center Information Icon
new NewsIn;          // Entrance to SAN News
new NewsExit;        // Exit from SAN News
new BankIn;          // Bank Entrance
new BankOut;         // Bank Exit
new BankInfo;        // BankInfo
new ApartmentIn;     // Atrium Entrance
new ApartmentOut;    // Atrium Exit
new FireJob;         // /getjob and change for firemen
new PDDuty;       	 // PD Changing Area
new BMGarcia;   	 // BlackMarket in Hasbury
new BMEaster;     	 // BlackMarket in Easter Basin
new SpawnInfo;    	 // Spawn Information Icon
new DrivingTest;     // Test Icon
new Text:Clock;   	 // Text Draw New for the Clock
new Text:Day;     	 // Text Draw New for the Day
//<============================================================================>
//<============================[FORWARDS]======================================>
//<============================================================================>
forward settime();
forward weatherchange();
forward DestroyTextTimer(Text:text);
forward Float:GetDistanceBetweenPlayers(p1,p2);
forward Advertisment(playerid);
forward SendClientMessageForTeam(teamid, text_color, string_text[]);
forward ProxDetector(Float:radi, playerid, str[],col1,col2,col3,col4,col5);
forward ProxDetectorS(Float:radi, playerid, targetid);
forward GateTimer();
forward GlobalAnnouncement();
forward SendClientMessageToAdmins(color,string[],alevel);
forward SendClientMessageToNorthside(color,string[]);
forward SendClientMessageToTheLost(color,string[]);
forward SendClientMessageToForelli(color,string[]);
forward SendClientMessageToGecko(color,string[]);
forward SendClientMessageToPolice(color,string[]);
forward SendClientMessageToRoadRunners(color,string[]);
forward SendClientMessageToPizzaPlace(color,string[]);
forward SendClientMessageToPilots(color,string[]);
forward SendClientMessageToTow(color,string[]);
forward OnPlayerRegister(playerid,password[]);
forward OnPlayerLogin(playerid,password[]);
forward OnPlayerUpdateAccount(playerid);
//forward OnPlayerEnterPlayerVehicle(playerid, vehicleid, ispassenger);
forward PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z);
forward IsPlayerCop(playerid);
forward IsPlayerFourCorners(playerid);
forward IsPlayerPilot(playerid);
forward IsPlayerPermitted(playerid);
forward IsPlayerTow(playerid);
forward IsAtJizzys(playerid);
forward IsAtGaydar(playerid);
forward IsAtGecko(playerid);
forward IsAtMistys(playerid);
forward IsAtWarehouse(playerid);
forward IsAtSFPD(playerid);
forward IsAtOiltruck(playerid);
forward IsAtBank(playerid);
forward IsAtZip(playerid);
forward IsAtSFHospital(playerid);
forward IsAtSFFD(playerid);
forward IsAtBlackMarket(playerid);
forward IsAtRoadRunners(playerid);
forward IsAtPizzaPlace(playerid);
forward IsAtAirTraffic(playerid);
forward IsAtChurch(playerid);
forward BanLog(string[]);
forward KickLog(string[]);
forward VehicleLog(string[]);
forward GateTimer();
forward Float:GetDistanceBetweenPlayerToPoint(p1,Float:px,Float:py,Float:pz);
forward Payday();
forward JailTimer(playerid);
forward Release(playerid);
forward Drugeffect(playerid);
forward NormalWeather(playerid);
forward Tazer(playerid);
forward UpdateLevel(playerid);
forward UpdateJobLevel(playerid);
forward CheckLevel(playerid);
forward SavePlayerHouse(houseid);
forward ReadPlayerHouseData(playerid);
forward PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z);
forward terminarMission(playerid);
forward startMission(playerid);
forward droptrailer(playerid);
forward PetrolUpdate();
forward Fillup();
forward IsAtGasStation(playerid);
forward PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z);
forward Float:GetDistanceBetweenPlayerToPoint(p1,Float:px,Float:py,Float:pz);
forward StoppedVehicle();
forward CheckGas();
forward CheckHealth(playerid);
forward beingrevived(giveplayerid,playerid);
forward reviveddone(giveplayerid,playerid);
forward CheckKeyPress(playerid);
forward ResetWait(playerid);
//<============================================================================>
//<==========================[Load Up Print]===================================>
//<============================================================================>
main()
{
    print("\n -------------------------------------------");
	print(" |------------------------------------------|");
	print(" |   The Script Has Sucessfully Loaded      |");
    print(" |     Synced Clock & Day By Fisher         |");
	print(" |------------------------------------------|");
	print(" |     Fisher's Admin System Has Loaded     |");
	print(" |    This Script was based on SeifAdmin    |");
	print(" |         And Modified for .:Zest::        |");
	print(" |------------------------------------------|");
	print(" -------------------------------------------\n");
	Msg = 0;
	MakeSkinPriceArray();
//<==========================[Setting Timers]==================================>
	Timer = SetTimer("GateTimer", TIMERSPEED, true);
	SetTimer("GlobalAnnouncement",900000,true); // Announcement happens every 15 minutes.
 	SetTimer("Payday", 1800000 , true); // Payday happens every 30 minutes.
	SetTimer("settime",1000,true);
    SetTimer("weatherchange",21600000,true); // 10800000 == 18 hours (original)
	PetrolUpdatetimer = SetTimer("PetrolUpdate", 1, 1000);
	stoppedvehtimer = SetTimer("StoppedVehicle", RunOutTime, 1000);
	checkgastimer = SetTimer("CheckGas", RunOutTime, 60000);
//<===============================[GZONES]=====================================>
	LostMain = GangZoneCreate(-1975.513427, 333.500305, -2263.513427, -82.499694);
	LostMistys = GangZoneCreate(-2379.232, -194.9311, -2139.745, 85.16138);
 	LostTow = GangZoneCreate(-2220.862, -313.28, -1981.375, -33.18756);
//<===========================[Setting Fuel]===================================>
	for(new c=0;c<CAR_AMOUNT;c++)
	{
		Gas[c] = GasMax;
	}
	for(new i = 0; i <= MAX_PLAYERS; i++)
	{
	    HouseTimer[0] = SetTimerEx("ReadPlayerHouseData", 1000, true, "%i", i);
	}
	for(new h = 0; h <= MAX_HOUSES; h++) // Player Homes
	{
	    LoadPlayerHouse(h);
	}
	for(new c = 0; c <= MAX_PLAYERCAR; c++) // Player Homes
	{
	    LoadPlayerCar(c);
	}
//<==========================[Creating Gates]==================================>
//  MakeGate(ObjectID, StartX, StarY, StartZ,  FinishX, FinishY, FinishZ,  CenterX, CenterY, CenterZ, Rotation, GateNumber);
	MakeGate(976,-1571.597,  665.725, 6.349, -1571.597,656.572,6.349,-1571.5579,661.2339  ,7.1875 ,-90.0, 0); 			 // SFPD East
    MakeGate(976,-1701.714965,679.596069,23.969039,-1701.782592,687.591125,24.020229,-1701.4867,683.8854,24.8663,90.0,1);//SFPD Alley Gate
    MakeGate(976, 2236.992, 2448.932, 9.848, 2236.992,2457.979,9.848  , 2236.992 ,2453.1646 ,10.7047, 90.0, 2); 		 // Las Venturas
    MakeGate(976, 1539.658,-1631.631,12.545, 1539.658,-1624.255,12.545, 1539.658 ,-1628.0244,13.3828, 90.0, 3); 	     //Los Santos
    MakeGate(10184,-1631.78 ,   688.24,  8.68, -1631.78 , 688.24,13.68  ,-1631.5636,687.7301  ,7.1875 ,90.00, 4);        // SFPD Shutter
    MakeGate(2933, -2127.3706054688, -80.797035217285, 36.035926818848,  -2119.1108398438, -80.797904968262, 36.035926818848,  -2127.6060,-80.3562,35.3203, 180, 5);
	return 1;
}
//<============================================================================>
//<===============================[STOCKS]=====================================>
//<============================================================================>
stock PlayerToPlayer(playerid, destid, Float:radius)
{
	if(!IsPlayerConnected(playerid)) return -1; // Checks if player is connected
	{
		new Float:X, Float:Y, Float:Z; // Base x, y, z values
		new Float:px, Float:py, Float:pz; //px, py, pz used to express
		GetPlayerPos(playerid, X, Y, Z); //
		GetPlayerPos(destid, px, py, pz); //
		X = floatsub(X, px);
		Y = floatsub(Y, py);
		Z = floatsub(Z, pz);
		if( ( radius > X && X > -radius ) &&
		( radius > Y && Y > -radius ) &&
		( radius > Z && Z > -radius ) ) return 1;
	}
	return 0;
}
stock IsSeatTaken(vehicleid, seatid)
{
    for(new i=0; i<MAX_PLAYERS; i++)
    {
        if(GetPlayerVehicleID(i) == vehicleid && GetPlayerVehicleSeat(i) == seatid)
		return 1;
    }
    return 0;
}
//<============================================================================>
stock GetName(playerid)
{
	new pname[MAX_PLAYER_NAME]; pname="Invalid PlayerID";
	if(IsPlayerConnected(playerid)) {
		GetPlayerName(playerid, pname, sizeof (pname));
	}
	return pname;
}
//<============================================================================>
stock GetVehicleModelIDFromName(vehname[])
{
	for(new i = 0; i < 211; i++)
	{
		if (strfind(VehNames[i], vehname, true) != -1) return i + 400;
	}
	return -1;
}
//<============================================================================>
stock GetWeaponModelIDFromName(weapname[])
{
    for(new i = 0; i < 48; i++)
	{
        if (i == 19 || i == 20 || i == 21) continue;
		if (strfind(WeapNames[i], weapname, true) != -1) return i;
	}
	return -1;
}
//<============================================================================>
stock bigstrtok(const string[], &idx)
{
    new length = strlen(string);
	while ((idx < length) && (string[idx] <= ' '))
	{
		idx++;
	}
	new offset = idx;
	new result[128];
	while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
	{
		result[idx - offset] = string[idx];
		idx++;
	}
	result[idx - offset] = EOS;
	return result;
}
//<============================================================================>
stock Float:GetDistanceBetweenPlayers(p1,p2)
{
new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2;
if (!IsPlayerConnected(p1) || !IsPlayerConnected(p2)) return -1.00;
GetPlayerPos(p1,x1,y1,z1);
GetPlayerPos(p2,x2,y2,z2);
return floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
}
//<============================================================================>
stock GetFileString(string[])
{
	new result[128];
	result[0] = 0;
    if (strfind(string, ":", true) == -1) return result;
    new id = strfind(string, ":", true);
    strmid(result, string, 0, id, 128);
    return result;
}
//<============================================================================>
stock GetFileValue(string[])
{
	new val[128];
	val[0] = 0;
	if (strfind(string , ":", true) == -1) return val;
	new id = strfind(string, ":", true);
	strmid(val, string, id+2, strlen(string), 128);
	return val;
}
//<============================================================================>
MakeGate(z, Float:a, Float:b, Float:c, Float:d, Float:e, Float:f, Float:g, Float:h, Float:i, Float:j, k)
{
	GateInfo[k][0] = a,	GateInfo[k][1] = b,	GateInfo[k][2] = c; //Start
	GateInfo[k][3] = d,	GateInfo[k][4] = e,	GateInfo[k][5] = f; //Finish
	GateInfo[k][6] = g, GateInfo[k][7] = h,	GateInfo[k][8] = i; //Center
	GateState[k] = 0; //Gate Closed
	GateObject[k] = CreateObject(z ,a, b, c, 0.0,0.0,j);
}
//<============================================================================>
MakeSkinPriceArray()
{
	for(new i; i<sizeof(SkinPrices); i++)
	{
	    SkinPrices[i] = (random(MaxSkinPrice-MinSkinPrice)+MinSkinPrice);
	}
}
//<============================================================================>
stock IsPlayerNearGate(pid, tempgate, tolerance)
{
	GetPlayerPos(pid, Tempx, Tempy, Tempz);
	xtol1 = GateInfo[tempgate][6] + tolerance;
	xtol2 = GateInfo[tempgate][6] - tolerance;
	ytol1 = GateInfo[tempgate][7] + tolerance;
	ytol2 = GateInfo[tempgate][7] - tolerance;
	if(Tempx >= xtol2 && Tempx <= xtol1 && Tempy >= ytol2 && Tempy <= ytol1) return 1;
	return 0;
}
//=============================================================================>
stock CreatePlayerHouse(playerid, sellprice, HouseLvl)
{
    if((ReturnNextUnusedHouseID()-1) >= MAX_HOUSES) return SendClientMessage(playerid, COLOUR_WHITE, ".:: [HOUSE]: Maximum amount of houses on the server have been created.");
	new house[64], Float:X, Float:Y, Float:Z; GetPlayerPos(playerid, X, Y, Z);
	new NextHouseID = ReturnNextUnusedHouseID();
	new World = ReturnNextUnusedVirtualWorld();

	format(house, sizeof(house), "/Houses/%d.dini.save", NextHouseID);

	if(!dini_Exists(house)){
		dini_Create(house);
		dini_Set(house, "Name", "None");
		dini_IntSet(house, "For_Sell", 1);
		dini_IntSet(house, "Sell_Price", sellprice);
		dini_IntSet(house, "House_Level", HouseLvl);
 		dini_FloatSet(house,"Exit_Coord:X", X);
  		dini_FloatSet(house,"Exit_Coord:Y", Y);
    	dini_FloatSet(house,"Exit_Coord:Z", Z);
     	dini_IntSet(house, "VirtualWorld", World);
      	dini_IntSet(house, "Status", 0);
      	LoadPlayerHouse(NextHouseID);
       	SendClientMessage(playerid, COLOUR_WHITE, ".:: [HOUSE]: House has been Successfully created.");
	}
	return true;
}
//=============================================================================>
stock CreatePlayerCar(playerid, modelid, colour1, colour2)
{
    if((ReturnNextUnusedPlayerCarID()-1) >= MAX_PLAYERCAR) return SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: Maximum amount of player owned vehicles on the server have been created.");
	new PlayerCar[64], Float:X, Float:Y, Float:Z, Float:Angle;
	new NextPlayerCarID = ReturnNextUnusedPlayerCarID();
	new pname[MAX_PLAYER_NAME]; 
	GetPlayerName(playerid, pname, sizeof (pname));
	format(PlayerCar, sizeof(PlayerCar), "/PlayerCars/%d.dini.save", NextPlayerCarID);
	AccountInfo[playerid][pVehicle] = NextPlayerCarID;
	if(!dini_Exists(PlayerCar)){
		dini_Create(PlayerCar);
		dini_Set(PlayerCar, "Owner", pname);
		dini_IntSet(PlayerCar, "Car Model", modelid);
		dini_IntSet(PlayerCar, "Colour 1", colour1);
		dini_IntSet(PlayerCar, "Colour 2", colour2);
 		dini_FloatSet(PlayerCar,"Spawn_Coord:X", X);
  		dini_FloatSet(PlayerCar,"Spawn_Coord:Y", Y);
    	dini_FloatSet(PlayerCar,"Spawn_Coord:Z", Z);
    	dini_FloatSet(PlayerCar,"Spawn_Coord:A", Angle);
  		dini_IntSet(PlayerCar, "Car Mod 0", 0);
  		dini_IntSet(PlayerCar, "Car Mod 1", 0);
  		dini_IntSet(PlayerCar, "Car Mod 2", 0);
  		dini_IntSet(PlayerCar, "Car Mod 3", 0);
  		dini_IntSet(PlayerCar, "Car Mod 4", 0);
  		dini_IntSet(PlayerCar, "Car Mod 5", 0);
  		dini_IntSet(PlayerCar, "Car Mod 6", 0);
  		dini_IntSet(PlayerCar, "Car Mod 7", 0);
  		dini_IntSet(PlayerCar, "Car Mod 8", 0);
  		dini_IntSet(PlayerCar, "Car Mod 9", 0);
  		dini_IntSet(PlayerCar, "Car Mod 10", 0);
  		dini_IntSet(PlayerCar, "Car Mod 11", 0);
  		dini_IntSet(PlayerCar, "Car Mod 12", 0);
  		dini_IntSet(PlayerCar, "Car Mod 13", 0);
		dini_IntSet(PlayerCar, "Colour 1", colour1);
		dini_IntSet(PlayerCar, "Colour 2", colour2);
      	dini_IntSet(PlayerCar, "Locked", 0);
      	LoadPlayerCar(NextPlayerCarID);
       	SendClientMessage(playerid, COLOUR_WHITE, "[Delivery]: Car has been delivered.");
	}
	return true;
}
//=============================================================================>
stock DestroyPlayerCar(playerid, carid)
{
	new PlayerCar[64];
    format(PlayerCar, sizeof(PlayerCar), "/PlayerCars/%d.dini.save", carid);
    if(dini_Exists(PlayerCar)){
		dini_Remove(PlayerCar);
	} else return printf("[Error]: The given car id does not exist so it cannot be destroyed [Player %d]",playerid);
	return false;
}
//=============================================================================>
stock DestroyPlayerHouse(playerid, houseid)
{
	new house[64];
    format(house, sizeof(house), "/Houses/%d.dini.save", houseid);
    if(dini_Exists(house)){
		dini_Remove(house);
		DestroyPickup(HouseInfo[houseid][hPickup]);
		SendClientMessage(playerid, COLOUR_WHITE, ".:: [HOUSE]: The given house has been destroyed.");
	} else return SendClientMessage(playerid, COLOUR_WHITE, ".:: [ERROR]: The given house id does not exsist so it cannot be destroyed.");
	return false;
}
//=============================================================================>
stock LoadPlayerHouse(houseid)
{
    new house[64]; format(house, sizeof(house), "/Houses/%d.dini.save", houseid);
    if(dini_Exists(house)){
        format(HouseInfo[houseid][hName], MAX_PLAYER_NAME, "%s", dini_Get(house, "Name"));
        HouseInfo[houseid][hSellable]  	  =  dini_Int(house, "For_Sell");
		HouseInfo[houseid][hSell]  	 	  =  dini_Int(house, "Sell_Price");
       	HouseInfo[houseid][hLevel] 		  =  dini_Int(house, "House_Level");
       	HouseInfo[houseid][hExitX]  	  =  dini_Float(house, "Exit_Coord:X");
       	HouseInfo[houseid][hExitY]  	  =  dini_Float(house, "Exit_Coord:Y");
        HouseInfo[houseid][hExitZ]  	  =  dini_Float(house, "Exit_Coord:Z");
       	HouseInfo[houseid][hVirtualWorld] =  dini_Int(house, "VirtualWorld");
       	HouseInfo[houseid][hLocked] 	  =  dini_Int(house, "Status");

       	if(HouseInfo[houseid][hSellable] == 1){
		    HouseInfo[houseid][hPickup] = CreatePickup(1273, 23, HouseInfo[houseid][hExitX], HouseInfo[houseid][hExitY], HouseInfo[houseid][hExitZ]); // not bought
		} else {
		    HouseInfo[houseid][hPickup] = CreatePickup(1239,23, HouseInfo[houseid][hExitX], HouseInfo[houseid][hExitY], HouseInfo[houseid][hExitZ]); // bought
		}
	}
	return true;
}
//=============================================================================>
stock LoadPlayerCar(carid)
{
    new PlayerCar[64]; format(PlayerCar, sizeof(PlayerCar), "/PlayerCars/%d.dini.save", carid);
    if(dini_Exists(PlayerCar))
	{
        format(CarInfo[carid][cOwner], MAX_PLAYER_NAME, "%s", dini_Get(PlayerCar, "Owner"));
        CarInfo[carid][cModelid]  	=  dini_Int(PlayerCar, "Car Model");
		CarInfo[carid][cColour1]  	=  dini_Int(PlayerCar, "Colour 1");
       	CarInfo[carid][cColour2] 	=  dini_Int(PlayerCar, "Colour 2");
       	CarInfo[carid][vposX] 		=  dini_Float(PlayerCar, "Spawn_Coord:X");
       	CarInfo[carid][vposY] 		=  dini_Float(PlayerCar, "Spawn_Coord:Y");
        CarInfo[carid][vposZ] 		=  dini_Float(PlayerCar, "Spawn_Coord:Z");
        CarInfo[carid][vposA]		=  dini_Float(PlayerCar, "Spawn_Coord:A");
        CarInfo[carid][Mod0]		=  dini_Int(PlayerCar, "Car Mod 0");
        CarInfo[carid][Mod1]		=  dini_Int(PlayerCar, "Car Mod 1");
        CarInfo[carid][Mod2]		=  dini_Int(PlayerCar, "Car Mod 2");
        CarInfo[carid][Mod3]		=  dini_Int(PlayerCar, "Car Mod 3");
        CarInfo[carid][Mod4]		=  dini_Int(PlayerCar, "Car Mod 4");
        CarInfo[carid][Mod5]		=  dini_Int(PlayerCar, "Car Mod 5");
        CarInfo[carid][Mod6]		=  dini_Int(PlayerCar, "Car Mod 6");
        CarInfo[carid][Mod7]		=  dini_Int(PlayerCar, "Car Mod 7");
        CarInfo[carid][Mod8]		=  dini_Int(PlayerCar, "Car Mod 8");
        CarInfo[carid][Mod9]		=  dini_Int(PlayerCar, "Car Mod 9");
        CarInfo[carid][Mod10]		=  dini_Int(PlayerCar, "Car Mod 10");
        CarInfo[carid][Mod11]		=  dini_Int(PlayerCar, "Car Mod 11");
        CarInfo[carid][Mod12]		=  dini_Int(PlayerCar, "Car Mod 12");
        CarInfo[carid][Mod13]		=  dini_Int(PlayerCar, "Car Mod 13");
       	CarInfo[carid][cLocked] 	=  dini_Int(PlayerCar, "Locked");
  		CarInfo[carid][cCarID]      =  CreateVehicle(CarInfo[carid][cModelid], CarInfo[carid][vposX], CarInfo[carid][vposY], CarInfo[carid][vposZ], CarInfo[carid][vposA], CarInfo[carid][cColour1], CarInfo[carid][cColour2], 600);		if(CarInfo[carid][Mod0] >= 1000){AddVehicleComponent(CarInfo[carid][cCarID], CarInfo[carid][Mod0]);}
	    if(CarInfo[carid][Mod1] >= 1000){AddVehicleComponent(CarInfo[carid][cCarID], CarInfo[carid][Mod1]);}
	    if(CarInfo[carid][Mod2] >= 1000){AddVehicleComponent(CarInfo[carid][cCarID], CarInfo[carid][Mod2]);}
	    if(CarInfo[carid][Mod3] >= 1000){AddVehicleComponent(CarInfo[carid][cCarID], CarInfo[carid][Mod3]);}
	    if(CarInfo[carid][Mod4] >= 1000){AddVehicleComponent(CarInfo[carid][cCarID], CarInfo[carid][Mod4]);}
	    if(CarInfo[carid][Mod5] >= 1000){AddVehicleComponent(CarInfo[carid][cCarID], CarInfo[carid][Mod5]);}
	    if(CarInfo[carid][Mod6] >= 1000){AddVehicleComponent(CarInfo[carid][cCarID], CarInfo[carid][Mod6]);}
	    if(CarInfo[carid][Mod7] >= 1000){AddVehicleComponent(CarInfo[carid][cCarID], CarInfo[carid][Mod7]);}
	    if(CarInfo[carid][Mod8] >= 1000){AddVehicleComponent(CarInfo[carid][cCarID], CarInfo[carid][Mod8]);}
	    if(CarInfo[carid][Mod9] >= 1000){AddVehicleComponent(CarInfo[carid][cCarID], CarInfo[carid][Mod9]);}
	    if(CarInfo[carid][Mod10] >= 1000){AddVehicleComponent(CarInfo[carid][cCarID], CarInfo[carid][Mod10]);}
	    if(CarInfo[carid][Mod11] >= 1000){AddVehicleComponent(CarInfo[carid][cCarID], CarInfo[carid][Mod11]);}
	    if(CarInfo[carid][Mod12] >= 1000){AddVehicleComponent(CarInfo[carid][cCarID], CarInfo[carid][Mod12]);}
	    if(CarInfo[carid][Mod13] >= 1000){AddVehicleComponent(CarInfo[carid][cCarID], CarInfo[carid][Mod13]);}
    	for(new i = 0; i <= MAX_PLAYERS; i++)
		{
	  		if(PlayerToPoint(10.0, i, -1954.3831,299.7207,35.4688)){SetVehiclePos(CarInfo[carid][cCarID], -1928.6050,273.9043,40.7712);}
	  		if(PlayerToPoint(10.0, i, -1656.6205,1209.9940,7.2500)){SetVehiclePos(CarInfo[carid][cCarID], -1642.3578,1213.7480,6.8314);}
		}
	}
}
//=============================================================================>
stock ReturnNextUnusedHouseID()
{
    new house[64];
	for(new h = 0; h <= MAX_HOUSES; h++){
		format(house, sizeof(house), "/Houses/%d.dini.save", h);
		if(!dini_Exists(house)) return h; }
	return true;
}
//=============================================================================>
stock ReturnNextUnusedPlayerCarID()
{
    new PlayerCars[64];
	for(new c = 0; c <= MAX_PLAYERCAR; c++){
		format(PlayerCars, sizeof(PlayerCars), "/PlayerCars/%d.dini.save", c);
		if(!dini_Exists(PlayerCars)) return c; }
	return true;
}
//=============================================================================>
stock ReturnNextUnusedVirtualWorld()
{
    new house[64]; // Please do not make more then 255 houses because that is the Maximum Virtual Worlds. Or use as many as you want in 0.3
	format(house, sizeof(house), "/Houses/%d.dini.save", ReturnNextUnusedHouseID()-1);
	return dini_Int(house, "VirtualWorld")+1;
}
//=============================================================================>
GetWeekDay(day=0, month=0, year=0)
{
    if (!day) getdate(year, month, day);
    new weekday, j, e;
    if (month <= 2)
    	{
        month += 12;
        --year;
    	}
    j = year % 100;
    e = year / 100;
    switch ((day + (month+1)*26/10 + j + j/4 + e/4 - 2*e) % 7)
    	{
        case 0: weekday = 0 ; //Saturday
        case 1: weekday = 1 ; //Sunday
        case 2: weekday = 2 ; //Monday
        case 3: weekday = 3 ; //Tuesday
        case 4: weekday = 4 ; //Wednesday
        case 5: weekday = 5 ; //Thursday
        case 6: weekday = 6 ; //Friday
    	}
	return weekday;
}
//<============================================================================>
//<===============================[Functions]==================================>
//<============================================================================>
//<=========================[Day and Clock Settings]===========================>
public settime()
{
	new hour,minute,second;
	new string[256];
	gettime(hour,minute,second);
	if (minute <= 9){format(string,25,"%d:0%d",hour,minute);}
	else {format(string,25,"%d:%d",hour,minute);}
	TextDrawSetString(Clock,string);
    SetWorldTime(hour);
	new weekday;
    weekday = GetWeekDay();
	if(weekday == 0){TextDrawSetString(Day,"SaturDay");}
	if(weekday == 1){TextDrawSetString(Day,"SunDay");}
	if(weekday == 2){TextDrawSetString(Day,"MonDay");}
	if(weekday == 3){TextDrawSetString(Day,"TuesDay");}
	if(weekday == 4){TextDrawSetString(Day,"WednesDay");}
	if(weekday == 5){TextDrawSetString(Day,"ThursDay");}
	if(weekday == 6){TextDrawSetString(Day,"FriDay");}
//<===========================[A Test To See If Its Working]===================>
//	new number = weekday;
//	printf("The number is %d.",number);  // The number is the Day of the Week. (FISHER)
//<============================================================================>
	return 1;
//<================================[Weather System]============================>
}
public weatherchange()
{
	new LS, LV, BC, TR, SF, RC, FC, WS;
	new Sunny, Scorching, Dull;
	LS = random(104);
	LV = random(112);
	BC = random(112);
	TR = random(112);
	SF = random(104);
	RC = random(104);
	FC = random(104);
	WS = random(104);
	Scorching = random(2);
	Sunny = random(8);
	Dull = random(5);
	switch(Sunny)
	{
	    case 0: Sunny = 0;
	    case 1: Sunny = 1;
	    case 2: Sunny = 2;
	    case 3: Sunny = 3;
	    case 4: Sunny = 4;
	    case 5: Sunny = 5;
	    case 6: Sunny = 6;
	    case 7: Sunny = 7;
	    case 8: Sunny = 10;
	}
	switch(Scorching)
	{
	    case 0: Scorching = 11;
	    case 1: Scorching = 17;
	    case 2: Scorching = 18;
	}
	switch(Dull)
	{
	    case 0: Dull = 12;
	    case 1: Dull = 13;
	    case 2: Dull = 14;
	    case 3: Dull = 15;
	    case 4: Dull = 20;
	}
	switch(LS)
	{
	    case  0 .. 29:  SetAreaWeather(1,     Sunny);// Blue Skies
	    case 30 .. 50:  SetAreaWeather(1, Scorching);// Scorching
	    case 51 .. 61:  SetAreaWeather(1, 		 32);// Light Mist
	    case 62 .. 72:  SetAreaWeather(1, 		  8);// Stormy
	    case 73 .. 93:  SetAreaWeather(1,      Dull);// Dull/Hazy
	    case 94 .. 104: SetAreaWeather(1,         9);// Heavy Fog
	}
	switch(LV)
	{
	    case   0 .. 40:  SetAreaWeather(3, Scorching);// Scorching
	    case  41 .. 70:  SetAreaWeather(3,     Sunny);// Blue Skies
	    case  71 .. 80:  SetAreaWeather(3, 		   8);// Stormy
	    case  81 .. 101: SetAreaWeather(3,      Dull);// Dull/Hazy
	    case 102 .. 112: SetAreaWeather(3,        19);// Sandstorm
	}
	switch(BC)
	{
	    case   0 .. 40:  SetAreaWeather(3, Scorching);// Scorching
	    case  41 .. 70:  SetAreaWeather(3,     Sunny);// Blue Skies
	    case  71 .. 80:  SetAreaWeather(3, 		   8);// Stormy
	    case  81 .. 101: SetAreaWeather(3,      Dull);// Dull/Hazy
	    case 102 .. 112: SetAreaWeather(3,        19);// Sandstorm
	}
	switch(TR)
	{
	    case   0 .. 40:  SetAreaWeather(3, Scorching);// Scorching
	    case  41 .. 70:  SetAreaWeather(3,     Sunny);// Blue Skies
	    case  71 .. 80:  SetAreaWeather(3, 		   8);// Stormy
	    case  81 .. 101: SetAreaWeather(3,      Dull);// Dull/Hazy
	    case 102 .. 112: SetAreaWeather(3,        19);// Sandstorm
	}
	switch(SF)
	{
	    case  0 .. 29:  SetAreaWeather(1,     Sunny);// Blue Skies
	    case 30 .. 50:  SetAreaWeather(1, Scorching);// Scorching
	    case 51 .. 61:  SetAreaWeather(1, 		 32);// Light Mist
	    case 62 .. 72:  SetAreaWeather(1, 		  8);// Stormy
	    case 73 .. 93:  SetAreaWeather(1,      Dull);// Dull/Hazy
	    case 94 .. 104: SetAreaWeather(1,         9);// Heavy Fog
	}
	switch(RC)
	{
	    case  0 .. 29:  SetAreaWeather(1,     Sunny);// Blue Skies
	    case 30 .. 50:  SetAreaWeather(1, Scorching);// Scorching
	    case 51 .. 61:  SetAreaWeather(1, 		 32);// Light Mist
	    case 62 .. 72:  SetAreaWeather(1, 		  8);// Stormy
	    case 73 .. 93:  SetAreaWeather(1,      Dull);// Dull/Hazy
	    case 94 .. 104: SetAreaWeather(1,         9);// Heavy Fog
	}
	switch(FC)
	{
	    case  0 .. 29:  SetAreaWeather(1,     Sunny);// Blue Skies
	    case 30 .. 50:  SetAreaWeather(1, Scorching);// Scorching
	    case 51 .. 61:  SetAreaWeather(1, 		 32);// Light Mist
	    case 62 .. 72:  SetAreaWeather(1, 		  8);// Stormy
	    case 73 .. 93:  SetAreaWeather(1,      Dull);// Dull/Hazy
	    case 94 .. 104: SetAreaWeather(1,         9);// Heavy Fog
	}
	switch(WS)
	{
	    case  0 .. 29:  SetAreaWeather(1,     Sunny);// Blue Skies
	    case 30 .. 50:  SetAreaWeather(1, Scorching);// Scorching
	    case 51 .. 61:  SetAreaWeather(1, 		 32);// Light Mist
	    case 62 .. 72:  SetAreaWeather(1, 		  8);// Stormy
	    case 73 .. 93:  SetAreaWeather(1,      Dull);// Dull/Hazy
	    case 94 .. 104: SetAreaWeather(1,         9);// Heavy Fog
	}
}
//<===============================[Autogate System]============================>
public GateTimer()
{
	for(new tempgate=0; tempgate<GateNum; tempgate++)
	{
		for(new pid=0; pid<MAX_PLAYERS; pid++)
 		{
  			if(OpenGate[tempgate] == 0 && IsPlayerPermitted(pid) == 1)
			{
			  	OpenGate[tempgate] = IsPlayerNearGate(pid, tempgate, TOLERANCE);
			}
		}
        if(OpenGate[tempgate] == 1) MoveObject(GateObject[tempgate], GateInfo[tempgate][3], GateInfo[tempgate][4], GateInfo[tempgate][5], OPENSPEED), GateState[tempgate] = 1;
	    else MoveObject(GateObject[tempgate], GateInfo[tempgate][0], GateInfo[tempgate][1], GateInfo[tempgate][2], CLOSESPEED), GateState[tempgate] = 0;
	    OpenGate[tempgate] = 0;
		}
}
//<============================================================================>
public Float:GetDistanceBetweenPlayerToPoint(p1,Float:px,Float:py,Float:pz)
{
	new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2;
	if(!IsPlayerConnected(p1) )
	{
		return -1.00;
	}
	GetPlayerPos(p1,x1,y1,z1);
	x2 = px;
	y2 = py;
	z2 = pz;
	return floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
}
//<============================================================================>
public PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z)
{
    if(IsPlayerConnected(playerid))
	{
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		tempposx = (oldposx -x);
		tempposy = (oldposy -y);
		tempposz = (oldposz -z);
		if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
		{
			return 1;
		}
	}
	return 0;
}
//<============================================================================>
public IsAtGasStation(playerid)
{
    if(IsPlayerConnected(playerid))
	{
		if(PlayerToPoint(6.0,playerid,1004.0070,-939.3102,42.1797) || PlayerToPoint(6.0,playerid,1944.3260,-1772.9254,13.3906))
		{//LS
		    return 1;
		}
		else if(PlayerToPoint(6.0,playerid,-90.5515,-1169.4578,2.4079) || PlayerToPoint(6.0,playerid,-1609.7958,-2718.2048,48.5391))
		{//LS
		    return 1;
		}
		else if(PlayerToPoint(6.0,playerid,-2029.4968,156.4366,28.9498) || PlayerToPoint(8.0,playerid,-2408.7590,976.0934,45.4175))
		{//SF
		    return 1;
		}
		else if(PlayerToPoint(5.0,playerid,-2243.9629,-2560.6477,31.8841) || PlayerToPoint(8.0,playerid,-1676.6323,414.0262,6.9484))
		{//Between LS and SF
		    return 1;
		}
		else if(PlayerToPoint(6.0,playerid,2202.2349,2474.3494,10.5258) || PlayerToPoint(10.0,playerid,614.9333,1689.7418,6.6968))
		{//LV
		    return 1;
		}
		else if(PlayerToPoint(8.0,playerid,-1328.8250,2677.2173,49.7665) || PlayerToPoint(6.0,playerid,70.3882,1218.6783,18.5165))
		{//LV
		    return 1;
		}
		else if(PlayerToPoint(8.0,playerid,2113.7390,920.1079,10.5255) || PlayerToPoint(6.0,playerid,-1327.7218,2678.8723,50.0625))
		{//LV
		    return 1;
        }
        else if(PlayerToPoint(8.0,playerid,2146.5759,2750.8442,10.6447) || PlayerToPoint(6.0,playerid,2146.8779,2739.6157,10.6435))
		{//LV2
		    return 1;
        }
        else if(PlayerToPoint(8.0,playerid,1595.3046,2191.1331,10.6454) || PlayerToPoint(6.0,playerid,1596.3274,2206.7070,10.6449))
		{//LV3
		    return 1;
        }
        else if(PlayerToPoint(8.0,playerid,-736.9305,2742.6138,47.0158))
		{//Landtankstelle
		    return 1;
        }
	}
	return 0;
}
//<============================================================================>
public PetrolUpdate()
{
    new string[256];
	for(new i=0; i<MAX_PLAYERS; i++)
	{
    	if(IsPlayerConnected(i))
       	{
			if (!IsPlayerNPC(i))
			{
			    if (!IsPlayerInAirplanes(i) && !IsPlayerInHelicopter(i) && !IsPlayerInBoat(i))
			    {
        			new vehicle = GetPlayerVehicleID(i);
					if(IsPlayerInAnyVehicle(i) == 1)
					{
						if(Gas[vehicle] >= 0 && Gas[vehicle] <= 0)
						{
				      			format(string, sizeof(string), "~r~~n~~n~~n~~n~~n~~n~~n~~n~~n~Fuel:~r~IIIIIIIIII ~w~%d%",Gas[vehicle]);
		 						GameTextForPlayer(i,string,5000,3);
								RemovePlayerFromVehicle(i);
						}
						if(Gas[vehicle] >= 0 && Gas[vehicle] <= 10)
						{
				      			format(string, sizeof(string), "~r~~n~~n~~n~~n~~n~~n~~n~~n~~n~Fuel:~g~I~r~IIIIIIIII ~w~%d%",Gas[vehicle]);
		 						GameTextForPlayer(i,string,5000,3);
						}
						if(Gas[vehicle] >= 10 && Gas[vehicle] <= 20)
						{
				      			format(string, sizeof(string), "~r~~n~~n~~n~~n~~n~~n~~n~~n~~n~Fuel:~g~II~r~IIIIIIII ~w~%d%",Gas[vehicle]);
		 						GameTextForPlayer(i,string,5000,3);
						}
						else if(Gas[vehicle] >= 20 && Gas[vehicle] <= 30)
						{
				      			format(string, sizeof(string), "~r~~n~~n~~n~~n~~n~~n~~n~~n~~n~Fuel:~g~III~r~IIIIIII ~w~%d%",Gas[vehicle]);
		 						GameTextForPlayer(i,string,5000,3);
						}
						else if(Gas[vehicle] >= 30 && Gas[vehicle] <= 40)
						{
				      			format(string, sizeof(string), "~r~~n~~n~~n~~n~~n~~n~~n~~n~~n~Fuel:~g~IIII~r~IIIIII ~w~%d%",Gas[vehicle]);
		 						GameTextForPlayer(i,string,5000,3);
						}
						else if(Gas[vehicle] >= 40 && Gas[vehicle] <= 50)
						{
				      			format(string, sizeof(string), "~r~~n~~n~~n~~n~~n~~n~~n~~n~~n~Fuel:~g~IIIII~r~IIIII ~w~%d%",Gas[vehicle]);
		 						GameTextForPlayer(i,string,5000,3);
						}
						else if(Gas[vehicle] >= 50 && Gas[vehicle] <= 60)
						{
				      			format(string, sizeof(string), "~r~~n~~n~~n~~n~~n~~n~~n~~n~~n~Fuel:~g~IIIIII~r~IIII ~w~%d%",Gas[vehicle]);
		 						GameTextForPlayer(i,string,5000,3);
						}
						else if(Gas[vehicle] >= 60 && Gas[vehicle] <= 70)
						{
				      			format(string, sizeof(string), "~r~~n~~n~~n~~n~~n~~n~~n~~n~~n~Fuel:~g~IIIIIII~r~III ~w~%d%",Gas[vehicle]);
		 						GameTextForPlayer(i,string,5000,3);
						}
						else if(Gas[vehicle] >= 70 && Gas[vehicle] <= 80)
						{
				      			format(string, sizeof(string), "~r~~n~~n~~n~~n~~n~~n~~n~~n~~n~Fuel:~g~IIIIIIII~r~II ~w~%d%",Gas[vehicle]);
		 						GameTextForPlayer(i,string,5000,3);
						}
						else if(Gas[vehicle] >= 80 && Gas[vehicle] <= 90)
						{
				      			format(string, sizeof(string), "~r~~n~~n~~n~~n~~n~~n~~n~~n~~n~Fuel:~g~IIIIIIIII~r~I ~w~%d%",Gas[vehicle]);
		 						GameTextForPlayer(i,string,5000,3);
						}
						else if(Gas[vehicle] >= 90 && Gas[vehicle] <= 100)
						{
				      			format(string, sizeof(string), "~r~~n~~n~~n~~n~~n~~n~~n~~n~~n~Fuel:~g~IIIIIIIIII ~w~%d%",Gas[vehicle]);
		 						GameTextForPlayer(i,string,5000,3);
						}
					}
				}
			}
		}
	}
	return 1;
}
//<============================================================================>
public OnVehicleSpawn(vehicleid)
{
	for(new i = 0; i < GetMaxPlayers(); i++)
    {
		if(vehicleid ==  AccountInfo[i][pVehicle])
		{
			new carid;
			new PlayerCar[64];
			carid = AccountInfo[i][pVehicle];
			format(PlayerCar, sizeof(PlayerCar), "/PlayerCars/%d.dini.save", AccountInfo[i][pVehicle]);
			CarInfo[carid][Mod0]	=  dini_Int(PlayerCar, "Car Mod 0");
		    CarInfo[carid][Mod1]	=  dini_Int(PlayerCar, "Car Mod 1");
		    CarInfo[carid][Mod2]	=  dini_Int(PlayerCar, "Car Mod 2");
		    CarInfo[carid][Mod3]	=  dini_Int(PlayerCar, "Car Mod 3");
	   		CarInfo[carid][Mod4]	=  dini_Int(PlayerCar, "Car Mod 4");
		    CarInfo[carid][Mod5]	=  dini_Int(PlayerCar, "Car Mod 5");
		    CarInfo[carid][Mod6]	=  dini_Int(PlayerCar, "Car Mod 6");
		    CarInfo[carid][Mod7]	=  dini_Int(PlayerCar, "Car Mod 7");
	        CarInfo[carid][Mod8]	=  dini_Int(PlayerCar, "Car Mod 8");
		    CarInfo[carid][Mod9]	=  dini_Int(PlayerCar, "Car Mod 9");
		    CarInfo[carid][Mod10]	=  dini_Int(PlayerCar, "Car Mod 10");
		    CarInfo[carid][Mod11]	=  dini_Int(PlayerCar, "Car Mod 11");
		    CarInfo[carid][Mod12]	=  dini_Int(PlayerCar, "Car Mod 12");
		    CarInfo[carid][Mod13]	=  dini_Int(PlayerCar, "Car Mod 13");
			DestroyVehicle(vehicleid);
			CarInfo[carid][cCarID] =  CreateVehicle(CarInfo[carid][cModelid], CarInfo[carid][vposX], CarInfo[carid][vposY], CarInfo[carid][vposZ], CarInfo[carid][vposA], CarInfo[carid][cColour1], CarInfo[carid][cColour2], 10);
	        if(CarInfo[carid][Mod0] >= 1000){AddVehicleComponent(CarInfo[carid][cCarID], CarInfo[carid][Mod0]);}
			if(CarInfo[carid][Mod1] >= 1000){AddVehicleComponent(CarInfo[carid][cCarID], CarInfo[carid][Mod1]);}
			if(CarInfo[carid][Mod2] >= 1000){AddVehicleComponent(CarInfo[carid][cCarID], CarInfo[carid][Mod2]);}
			if(CarInfo[carid][Mod3] >= 1000){AddVehicleComponent(CarInfo[carid][cCarID], CarInfo[carid][Mod3]);}
			if(CarInfo[carid][Mod4] >= 1000){AddVehicleComponent(CarInfo[carid][cCarID], CarInfo[carid][Mod4]);}
			if(CarInfo[carid][Mod5] >= 1000){AddVehicleComponent(CarInfo[carid][cCarID], CarInfo[carid][Mod5]);}
			if(CarInfo[carid][Mod6] >= 1000){AddVehicleComponent(CarInfo[carid][cCarID], CarInfo[carid][Mod6]);}
			if(CarInfo[carid][Mod7] >= 1000){AddVehicleComponent(CarInfo[carid][cCarID], CarInfo[carid][Mod7]);}
			if(CarInfo[carid][Mod8] >= 1000){AddVehicleComponent(CarInfo[carid][cCarID], CarInfo[carid][Mod8]);}
			if(CarInfo[carid][Mod9] >= 1000){AddVehicleComponent(CarInfo[carid][cCarID], CarInfo[carid][Mod9]);}
			if(CarInfo[carid][Mod10] >= 1000){AddVehicleComponent(CarInfo[carid][cCarID], CarInfo[carid][Mod10]);}
			if(CarInfo[carid][Mod11] >= 1000){AddVehicleComponent(CarInfo[carid][cCarID], CarInfo[carid][Mod11]);}
			if(CarInfo[carid][Mod12] >= 1000){AddVehicleComponent(CarInfo[carid][cCarID], CarInfo[carid][Mod12]);}
			if(CarInfo[carid][Mod13] >= 1000){AddVehicleComponent(CarInfo[carid][cCarID], CarInfo[carid][Mod13]);}
            return 1;
		}
	}
	return 1;
}
public CheckGas()
{
	for(new i=0;i<MAX_PLAYERS;i++)
	{
    	if(IsPlayerConnected(i))
       	{
       	    if(GetPlayerState(i) == PLAYER_STATE_DRIVER)
       	    {
	       		new vehicle = GetPlayerVehicleID(i);
	        	if(Gas[vehicle] >= 1)
		   		{
      			Gas[vehicle]--;
		   		}
			}
    	}
	}
	return 1;
}
//<============================================================================>
public StoppedVehicle()
{
	new Float:x,Float:y,Float:z;
	new Float:distance,value;
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if(IsPlayerInAnyVehicle(i))
			{
				new VID;
				VID = GetPlayerVehicleID(i);
				GetPlayerPos(i, x, y, z);
				distance = floatsqroot(floatpower(floatabs(floatsub(x,SavePlayerPos[i][LastX])),2)+floatpower(floatabs(floatsub(y,SavePlayerPos[i][LastY])),2)+floatpower(floatabs(floatsub(z,SavePlayerPos[i][LastZ])),2));
				value = floatround(distance * 3600);
				if(UpdateSeconds > 1)
				{
					value = floatround(value / UpdateSeconds);
				}
				if(SpeedMode)
				{
	            }
				if(value == 0)
				{
					Gas[VID]++;
				}
				SavePlayerPos[i][LastX] = x;
				SavePlayerPos[i][LastY] = y;
				SavePlayerPos[i][LastZ] = z;
			}
		}
	}
	return 1;
}
public Fillup()
{
	for(new i=0; i<MAX_PLAYERS; i++)
   	{
	   	if(IsPlayerConnected(i))
	   	{
		    new VID;
		    new FillUp;
		    new string[256];
		    GameTextForPlayer(i,"~w~~n~~n~~n~~n~~n~~n~~n~~n~~n~Refuel! Please wait....",2000,3);
		    VID = GetPlayerVehicleID(i);
		    FillUp = GasMax - Gas[VID];
			if(Refueling[i] == 1)
		    {
		        new FillUpPrice = FillUp * 5;
				if(GetPlayerMoney(i) >= FillUpPrice)
				{
					Gas[VID] += FillUp;
				    format(string,sizeof(string),"[Clerk]: That will be $%d dollars please.",FillUpPrice);
				    SendClientMessage(i,COLOUR_WHITE,string);
				    GivePlayerMoney(i,-FillUpPrice);
				    if (FillUpPrice > 0)
				    FillUpPrice = 0;
					Refueling[i] = 0;
					TogglePlayerControllable(i,1);
				}
			   	else
			   	{
			   	    format(string,sizeof(string),"[Clerk]: Sir you do not have enough money, sorry.",FillUpPrice);
				    SendClientMessage(i,COLOUR_WHITE,string);
				    TogglePlayerControllable(i,1);
			   	}
		 	}
		}
	}
	return 1;
}
//<============================================================================>
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    new oldvaluelost = dini_Int("/Gangs/TheLost.ini","Firearms");
    new oldvaluenort = dini_Int("/Gangs/Northside.ini","Firearms");
    new oldvaluesur = dini_Int("/Gangs/Forelli.ini","Firearms");
    new oldvaluerus = dini_Int("/Gangs/Gecko.ini","Firearms");
    new oldvalueH = dini_Int("/Gangs/TheLost.ini","Kevlar");
    new oldvalueN = dini_Int("/Gangs/Northside.ini","Kevlar");
    new oldvalueS = dini_Int("/Gangs/Forelli.ini","Kevlar");
    new oldvalueR = dini_Int("/Gangs/Gecko.ini","Kevlar");
   	new newNmoney, oldNmoney = dini_Int("/Gangs/Northside.ini","Cash");
   	new gang = AccountInfo[playerid][pTeam];
    new string[128];
    switch(dialogid) // Lookup the dialogid
    {
        case 1://Take Weapon Dialog
        {
            if(!response)
            {
                SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You cancelled");
                return 1;
            }
            switch(listitem)
            {
                case 0:
                {
	                new newvaluelost = oldvaluelost - 1, newvaluenort = oldvaluenort - 1, newvaluesur = oldvaluesur - 1, newvaluerus = oldvaluerus - 1;
	                if (newvaluelost < 0 ||newvaluenort < 0 || newvaluesur < 0 || newvaluerus < 0){return 0;}
					if (AccountInfo[playerid][pTeam] == 2){dini_IntSet("/Gangs/TheLost.ini", "Firearms", newvaluelost);}
	                if (AccountInfo[playerid][pTeam] == 3){dini_IntSet("/Gangs/Forelli.ini","Firearms", newvaluesur);}
	                if (AccountInfo[playerid][pTeam] == 4){dini_IntSet("/Gangs/Gecko.ini","Firearms", oldvaluerus);}
	                if (AccountInfo[playerid][pTeam] == 5){dini_IntSet("/Gangs/Northside.ini", "Firearms", newvaluenort);}
					GivePlayerWeapon(playerid,4, 1);
					SendClientMessage(playerid,COLOUR_HEADER,"[Gang]: You have grabbed a Knife");
					return 1;
                }
                case 1:
                {
	                new newvaluelost = oldvaluelost - 1, newvaluenort = oldvaluenort - 1, newvaluesur = oldvaluesur - 1, newvaluerus = oldvaluerus - 1;
	                if (newvaluelost < 0 ||newvaluenort < 0 || newvaluesur < 0 || newvaluerus < 0){return 0;}
					if (AccountInfo[playerid][pTeam] == 2){dini_IntSet("/Gangs/TheLost.ini", "Firearms", newvaluelost);}
	                if (AccountInfo[playerid][pTeam] == 3){dini_IntSet("/Gangs/Forelli.ini","Firearms", newvaluesur);}
	                if (AccountInfo[playerid][pTeam] == 4){dini_IntSet("/Gangs/Gecko.ini","Firearms", oldvaluerus);}
	                if (AccountInfo[playerid][pTeam] == 5){dini_IntSet("/Gangs/Northside.ini", "Firearms", newvaluenort);}
					GivePlayerWeapon(playerid,5, 1);
					SendClientMessage(playerid,COLOUR_HEADER,"[Gang]: You have grabbed a Baseball Bat");
					return 1;
                }
                case 2:
                {
	                new newvaluelost = oldvaluelost - 1, newvaluenort = oldvaluenort - 1, newvaluesur = oldvaluesur - 1, newvaluerus = oldvaluerus - 1;
	                if (newvaluelost < 0 ||newvaluenort < 0 || newvaluesur < 0 || newvaluerus < 0){return 0;}
					if (AccountInfo[playerid][pTeam] == 2){dini_IntSet("/Gangs/TheLost.ini", "Firearms", newvaluelost);}
	                if (AccountInfo[playerid][pTeam] == 3){dini_IntSet("/Gangs/Forelli.ini","Firearms", newvaluesur);}
	                if (AccountInfo[playerid][pTeam] == 4){dini_IntSet("/Gangs/Gecko.ini","Firearms", oldvaluerus);}
	                if (AccountInfo[playerid][pTeam] == 5){dini_IntSet("/Gangs/Northside.ini", "Firearms", newvaluenort);}
					GivePlayerWeapon(playerid,22, 32);
					SendClientMessage(playerid,COLOUR_HEADER,"[Gang]: You have grabbed a 9mm");
					return 1;
                }
                case 3:
                {
					new newvaluelost = oldvaluelost - 1, newvaluenort = oldvaluenort - 1, newvaluesur = oldvaluesur - 1, newvaluerus = oldvaluerus - 1;
	                if (newvaluelost < 0 ||newvaluenort < 0 || newvaluesur < 0 || newvaluerus < 0){return 0;}
					if (AccountInfo[playerid][pTeam] == 2){dini_IntSet("/Gangs/TheLost.ini", "Firearms", newvaluelost);}
	                if (AccountInfo[playerid][pTeam] == 3){dini_IntSet("/Gangs/Forelli.ini","Firearms", newvaluesur);}
	                if (AccountInfo[playerid][pTeam] == 4){dini_IntSet("/Gangs/Gecko.ini","Firearms", oldvaluerus);}
	                if (AccountInfo[playerid][pTeam] == 5){dini_IntSet("/Gangs/Northside.ini", "Firearms", newvaluenort);}
					GivePlayerWeapon(playerid,24, 7);
					SendClientMessage(playerid,COLOUR_HEADER,"[Gang]: You have grabbed a Desert Eagle");
					return 1;
				}
				case 4:
				{
                	new newvaluelost = oldvaluelost - 1, newvaluenort = oldvaluenort - 1, newvaluesur = oldvaluesur - 1, newvaluerus = oldvaluerus - 1;
	                if (newvaluelost < 0 ||newvaluenort < 0 || newvaluesur < 0 || newvaluerus < 0){return 0;}
					if (AccountInfo[playerid][pTeam] == 2){dini_IntSet("/Gangs/TheLost.ini", "Firearms", newvaluelost);}
	                if (AccountInfo[playerid][pTeam] == 3){dini_IntSet("/Gangs/Forelli.ini","Firearms", newvaluesur);}
	                if (AccountInfo[playerid][pTeam] == 4){dini_IntSet("/Gangs/Gecko.ini","Firearms", oldvaluerus);}
	                if (AccountInfo[playerid][pTeam] == 5){dini_IntSet("/Gangs/Northside.ini", "Firearms", newvaluenort);}
					GivePlayerWeapon(playerid,25, 10);
					SendClientMessage(playerid,COLOUR_HEADER,"[Gang]: You have grabbed a Shotty");
					return 1;
				}
				case 5:
				{
                    new newvaluelost = oldvaluelost - 1, newvaluenort = oldvaluenort - 1, newvaluesur = oldvaluesur - 1, newvaluerus = oldvaluerus - 1;
	                if (newvaluelost < 0 ||newvaluenort < 0 || newvaluesur < 0 || newvaluerus < 0){return 0;}
					if (AccountInfo[playerid][pTeam] == 2){dini_IntSet("/Gangs/TheLost.ini", "Firearms", newvaluelost);}
	                if (AccountInfo[playerid][pTeam] == 3){dini_IntSet("/Gangs/Forelli.ini","Firearms", newvaluesur);}
	                if (AccountInfo[playerid][pTeam] == 4){dini_IntSet("/Gangs/Gecko.ini","Firearms", oldvaluerus);}
	                if (AccountInfo[playerid][pTeam] == 5){dini_IntSet("/Gangs/Northside.ini", "Firearms", newvaluenort);}
					GivePlayerWeapon(playerid,28, 100);
					SendClientMessage(playerid,COLOUR_HEADER,"[Gang]: You have grabbed a Micro SMG");
					return 1;
				}
				case 6:
				{
	                new newvaluelost = oldvaluelost - 1, newvaluenort = oldvaluenort - 1, newvaluesur = oldvaluesur - 1, newvaluerus = oldvaluerus - 1;
	                if (newvaluelost < 0 ||newvaluenort < 0 || newvaluesur < 0 || newvaluerus < 0){return 0;}
					if (AccountInfo[playerid][pTeam] == 2){dini_IntSet("/Gangs/TheLost.ini", "Firearms", newvaluelost);}
	                if (AccountInfo[playerid][pTeam] == 3){dini_IntSet("/Gangs/Forelli.ini","Firearms", newvaluesur);}
	                if (AccountInfo[playerid][pTeam] == 4){dini_IntSet("/Gangs/Gecko.ini","Firearms", oldvaluerus);}
	                if (AccountInfo[playerid][pTeam] == 5){dini_IntSet("/Gangs/Northside.ini", "Firearms", newvaluenort);}
					GivePlayerWeapon(playerid,32, 100);
					SendClientMessage(playerid,COLOUR_HEADER,"[Gang]: You have grabbed a Tec9");
					return 1;
				}
				case 7:
				{
	                new newvaluelost = oldvaluelost - 1, newvaluenort = oldvaluenort - 1, newvaluesur = oldvaluesur - 1, newvaluerus = oldvaluerus - 1;
	                if (newvaluelost < 0 ||newvaluenort < 0 || newvaluesur < 0 || newvaluerus < 0){return 0;}
					if (AccountInfo[playerid][pTeam] == 2){dini_IntSet("/Gangs/TheLost.ini", "Firearms", newvaluelost);}
	                if (AccountInfo[playerid][pTeam] == 3){dini_IntSet("/Gangs/Forelli.ini","Firearms", newvaluesur);}
	                if (AccountInfo[playerid][pTeam] == 4){dini_IntSet("/Gangs/Gecko.ini","Firearms", oldvaluerus);}
	                if (AccountInfo[playerid][pTeam] == 5){dini_IntSet("/Gangs/Northside.ini", "Firearms", newvaluenort);}
					GivePlayerWeapon(playerid,30, 100);
					SendClientMessage(playerid,COLOUR_HEADER,"[Gang]: You have grabbed an AK47"), newvaluerus = oldvaluerus - 1;
					return 1;
				}
				case 8:
				{
	                new newvalueH = oldvalueH - 1, newvalueN = oldvalueN - 1, newvalueS = oldvalueS - 1, newvalueR = oldvalueR - 1;
	                if (newvalueH < 0 || newvalueN < 0 || newvalueS < 0 || newvalueR < 0){return 0;}
					if (AccountInfo[playerid][pTeam] == 2){dini_IntSet("/Gangs/TheLost.ini", "Kevlar", newvalueH);}
	                if (AccountInfo[playerid][pTeam] == 3){dini_IntSet("/Gangs/Forelli.ini", "Kevlar", newvalueS);}
	                if (AccountInfo[playerid][pTeam] == 4){dini_IntSet("/Gangs/Gecko.ini","Kevlar", newvalueR);}
	                if (AccountInfo[playerid][pTeam] == 5){dini_IntSet("/Gangs/Northside.ini", "Kevlar", newvalueN);}
					SetPlayerArmour(playerid, 100);
					SendClientMessage(playerid,COLOUR_HEADER,"[Gang]: You have put on a vest");
					return 1;
				}
            }
		}
        case 2://Big Import Dialog
        {
            if(!response)
            {
                SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You cancelled");
                return 1;
            }
            switch(listitem)
            {
                case 0://Boat
                {
					switch(gang)
					{
						case 2:
						{
							ConnectNPC("Rodriguez","BoatBIin");
		                    Boat = CreateDynamicCP(2582.3682,-2206.6831,-0.21882, 3.0, -1, -1, -1, 100.0);
							format(string, sizeof(string), "[Gang]: Get to the Docks in Los Santos");
			  				SendClientMessageToForelli(COLOUR_FORELLI, string);
			  				dini_IntSet("/Gangs/Forelli.ini","Bigimported",1);
		  				    print("Created TP1.");
						}
						case 3:
						{
		     				ConnectNPC("Rodriguez","BoatBIin");
		                    Boat = CreateDynamicCP(2582.3682,-2206.6831,-0.2188, 3.0, -1, -1, -1, 100.0);
		     				format(string, sizeof(string), "[Gang]: Get to the Docks in Los Santos");
			  				SendClientMessageToTheLost(COLOUR_THELOST, string);
			  				dini_IntSet("/Gangs/TheLost.ini","Bigimported",1);
			  				print("Created TP2.");
						}
						case 4:
						{
		     				ConnectNPC("Rodriguez","BoatBIin");
		                    Boat = CreateDynamicCP(2582.3682,-2206.6831,-0.2188, 3.0, -1, -1, -1, 100.0);
		     				format(string, sizeof(string), "[Gang]: Get to the Docks in Los Santos");
			  				SendClientMessageToGecko(COLOUR_THELOST, string);
			  				dini_IntSet("/Gangs/Gecko.ini","Bigimported",1);
			  				print("Created TP3.");
						}
      					case 5:
						{
							ConnectNPC("Rodriguez","BoatBIin");
		                    Boat = CreateDynamicCP(2582.3682,-2206.6831,-0.2188, 3.0, -1, -1, -1, 100.0);
							format(string, sizeof(string), "[Gang]: Get to the Docks in Los Santos");
			  				SendClientMessageToNorthside(COLOUR_NORTHSIDE, string);
			  				dini_IntSet("/Gangs/Northside.ini","Bigimported",1);
			  				print("Created TP4.");
						}
					}
				}
                case 1://Plane
                {
					switch(gang)
					{
						case 2:
						{
							ConnectNPC("Pablo","AirImportIn");
		                    Aeroplane = CreateDynamicCP(418.5016,2499.5305,16.4844, 3.0, -1, -1, -1, 100.0);
							format(string, sizeof(string), "[Gang]: Get to the Airfield for the drop!");
			  				SendClientMessageToForelli(COLOUR_FORELLI, string);
			  				dini_IntSet("/Gangs/Forelli.ini","Bigimported",1);
		  				    print("Created CP1.");
						}
						case 3:
						{
		     				ConnectNPC("Pablo","AirImportIn");
							BIAir = AddStaticVehicle(553, -2966.18, 2977.858, 15, 0, -1, -1); // Big Import Aeroplane
		                    Aeroplane = CreateDynamicCP(418.5016,2499.5305,16.4844, 3.0, -1, -1, -1, 100.0);
							format(string, sizeof(string), "[Gang]: Get to the Airfield for the drop!");
			  				SendClientMessageToTheLost(COLOUR_THELOST, string);
			  				dini_IntSet("/Gangs/TheLost.ini","Bigimported",1);
			  				print("Created CP2.");
						}
						case 4:
						{
		     				ConnectNPC("Pablo","AirImportIn");
							BIAir = AddStaticVehicle(553, -2966.18, 2977.858, 15, 0, -1, -1); // Big Import Aeroplane
		                    Aeroplane = CreateDynamicCP(418.5016,2499.5305,16.4844, 3.0, -1, -1, -1, 100.0);
							format(string, sizeof(string), "[Gang]: Get to the Airfield for the drop!");
			  				SendClientMessageToGecko(COLOUR_GECKO, string);
			  				dini_IntSet("/Gangs/Gecko.ini","Bigimported",1);
			  				print("Created CP2.");
						}
      					case 5:
						{
							ConnectNPC("Pablo","AirImportIn");
							BIAir = AddStaticVehicle(553, -2966.18, 2977.858, 15, 0, -1, -1); // Big Import Aeroplane
		                    Aeroplane = CreateDynamicCP(418.5016,2499.5305,16.4844, 3.0, -1, -1, -1, 100.0);
							format(string, sizeof(string), "[Gang]: Get to the Airfield for the drop!");
			  				SendClientMessageToNorthside(COLOUR_NORTHSIDE, string);
			  				dini_IntSet("/Gangs/Northside.ini","Bigimported",1);
			  				print("Created CP4.");
						}
					}
				}
                case 2://Truck
                {
					switch(gang)
					{
						case 2:
						{
							ConnectNPC("Amy","TruckImportIn");
		                    Truck = CreateDynamicCP(2781.6255,-2455.3284,13.6352, 3.0, -1, -1, -1, 100.0);
							format(string, sizeof(string), "[Gang]: Get to the Warehouse in Los Santos");
			  				SendClientMessageToForelli(COLOUR_FORELLI, string);
			  				dini_IntSet("/Gangs/Forelli.ini","Bigimported",1);
		  				    print("Created TP1.");
						}
						case 3:
						{
							ConnectNPC("Amy","TruckImportIn");
		                    Truck = CreateDynamicCP(2781.6255,-2455.3284,13.6352, 3.0, -1, -1, -1, 100.0);
							format(string, sizeof(string), "[Gang]: Get to the Warehouse in Los Santos");
			  				SendClientMessageToTheLost(COLOUR_THELOST, string);
			  				dini_IntSet("/Gangs/TheLost.ini","Bigimported",1);
			  				print("Created TP2.");
						}
						case 4:
						{
							ConnectNPC("Amy","TruckImportIn");
		                    Truck = CreateDynamicCP(2781.6255,-2455.3284,13.6352, 3.0, -1, -1, -1, 100.0);
							format(string, sizeof(string), "[Gang]: Get to the Warehouse in Los Santos");
			  				SendClientMessageToGecko(COLOUR_GECKO, string);
			  				dini_IntSet("/Gangs/Gecko.ini","Bigimported",1);
			  				print("Created TP2.");
						}
      					case 5:
						{
							ConnectNPC("Amy","TruckImportIn");
		                    Truck = CreateDynamicCP(2781.6255,-2455.3284,13.6352, 3.0, -1, -1, -1, 100.0);
							format(string, sizeof(string), "[Gang]: Get to the Warehouse in Los Santos");
			  				SendClientMessageToNorthside(COLOUR_NORTHSIDE, string);
			  				dini_IntSet("/Gangs/Northside.ini","Bigimported",1);
			  				print("Created TP4.");
						}
					}
				}
            }
        }
		case 3://Login Dialog
		{
			if(response == 1)
			{
				if (!strlen(inputtext))
				{
					ShowPlayerDialog(playerid,3,DIALOG_STYLE_INPUT,"{FF0000}Wrong Password","{FFFFFF}Your Password was incorrect, please try again.","Login","Register");
	                return 0;
				}
				else
				{
					new password[128], user[128], playername[MAX_PLAYER_NAME];
					GetPlayerName(playerid, playername, sizeof(playername));
					format(user, sizeof(user), "/Accounts/%s.user", playername);
					if(!fexist(user))
					{
						ShowPlayerDialog(playerid,3,DIALOG_STYLE_INPUT,"{80FF00}Login Required","{FFFFFF}Welcome to .:Zest:: Roleplay please enter your password.\nIf you are new please click register to make an account.","Login","Register");
					}
					else
					{
		                strmid(password, inputtext, 0, strlen(inputtext), 255);
						OnPlayerLogin(playerid, MD5_Hash(password));
					}
	   			}
			}
			else
			{
				new user[128], playername[MAX_PLAYER_NAME];
				GetPlayerName(playerid, playername, sizeof(playername));
				format(user, sizeof(user), "/Accounts/%s.user", playername);
				new File: hFile = fopen(user, io_read);
			    if (hFile)
				{
					SendClientMessage(playerid, COLOUR_ADMINRED, "[Server]: That name is already taken. Please reconnect using a different username.") && fclose(hFile);
	                Kick(playerid);
					return 1;
				}
				ShowPlayerDialog(playerid, 4, DIALOG_STYLE_MSGBOX, "{80FF00}.:Zest:: Server Rules Agreement", "{FFFFFF}Hello and welcome to Zest.\nAt Zest we pride ourselves on providing a fun environment for our players \nTo maintain this there are certain rules which must be abided by.\n{FF0000}[1]{FFFFFF} No Deathmatching\n{FF0000}[2]{FFFFFF} No Racism\n{FF0000}[3]{FFFFFF} Roleplay Situation\n{FF0000}[4]{FFFFFF} No Glitching\n{FF0000}[5]{FFFFFF} Have Fun.", "Accept", "Decline");
				return 1;
			}
	    }
	    case 4:// Rules Dialog
	    {
		    switch(response)
		    {
				case 0:
				{
					SendClientMessage(playerid,COLOUR_ADMINRED, "[Server]:{FFFFFF} You were kicked for not accepting the rules of our server.");
					Kick(playerid);
				}
				default:
				{
		       		ShowPlayerDialog(playerid,5,DIALOG_STYLE_INPUT,"{80FF00}User Registration","{FFFFFF}To register an account simply type your desired password and click register\nYou may cancel the process at any time simply by pressing Cancel.","Register","Cancel");
				}
			}
		}
		case 5://Register Dialog
	    {
		    switch(response)
		    {
				case 1:
				{
					if(strlen(inputtext) == 1)
					{
						ShowPlayerDialog(playerid,5,DIALOG_STYLE_INPUT,"{80FF00}User Registration","{FFFFFF}Your password was {FF0000}too short{FFFFFF} has to be {FF0000}atleast two characters{FFFFFF} so simply type your desired password and click register\nYou may cancel the process at any time simply by pressing Cancel.","Register","Cancel");
						return 1;
					}
			        new password[128];
					new stringLength = strlen(inputtext);
					printf("The Password is %s and %d characters long.",inputtext,stringLength);
				    strmid(password, inputtext, 0, strlen(inputtext), 255);
					OnPlayerRegister(playerid, MD5_Hash(password));
					return 1;
				}
				default:
				{
					SendClientMessage(playerid, COLOUR_ADMINRED, "[Server]: You cancelled the registration process.");
					ShowPlayerDialog(playerid,3,DIALOG_STYLE_INPUT,"{80FF00}Login Required","{FFFFFF}Welcome to .:Zest:: Roleplay please enter your password.\nIf you are new please click register to make an account.","Login","Register");
				}
			}
		}
		case 6:// Bar Dialog
        {
            if(!response)
            {
                SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You cancelled");
                return 1;
            }
            switch(listitem)
            {
                case 0:
                {
					newNmoney = oldNmoney + 2;
					GivePlayerMoney(playerid, -2);
					SetPlayerDrunkLevel (playerid, 800);
					SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DRINK_BEER);
					dini_IntSet("/Gangs/Northside.ini","Cash",newNmoney);
					ProxDetector(10.0, playerid, "[Bar Tender]: There's your Budweiser sir.",COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER);
				    return 1;
				}
				case 1:
				{
					newNmoney = oldNmoney + 10;
		            GivePlayerMoney(playerid, -10);
		            SetPlayerDrunkLevel (playerid, 1500);
		            SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DRINK_WINE);
					dini_IntSet("/Gangs/Northside.ini","Cash",newNmoney);
					ProxDetector(10.0, playerid, "[Bar Tender]: There's your Captain Morgan's sir.",COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER);
				    return 1;
				}
				case 2:
				{
	  				newNmoney = oldNmoney + 25;
		            GivePlayerMoney(playerid, -25);
		            SetPlayerDrunkLevel (playerid, 1700);
		            SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DRINK_WINE);
					dini_IntSet("/Gangs/Northside.ini","Cash",newNmoney);
					ProxDetector(10.0, playerid, "[Bar Tender]: There's your Jack Daniels sir.",COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER);
				    return 1;
				}
				case 3:
				{
					newNmoney = oldNmoney + 80;
		            GivePlayerMoney(playerid, -80);
		            SetPlayerDrunkLevel (playerid, 3000);
		            SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DRINK_WINE);
					dini_IntSet("/Gangs/Northside.ini","Cash",newNmoney);
					ProxDetector(10.0, playerid, "[Bar Tender]: There's your Hennesey sir.",COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER);
				    return 1;
				}
				case 4:
				{
					newNmoney = oldNmoney + 150;
		            GivePlayerMoney(playerid, -150);
		            SetPlayerDrunkLevel (playerid, 10000);
		            SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DRINK_WINE);
					dini_IntSet("/Gangs/Northside.ini","Cash",newNmoney);
					ProxDetector(10.0, playerid, "[Bar Tender]: There's your Cristal sir, please enjoy your drink.",COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER);
				    return 1;
				}
				case 5:
				{
					newNmoney = oldNmoney + 1000;
		            GivePlayerMoney(playerid, -1000);
		            SetPlayerDrunkLevel (playerid, 10000);
		            SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DRINK_WINE);
					dini_IntSet("/Gangs/Northside.ini","Cash",newNmoney);
					ProxDetector(10.0, playerid, "[Bar Tender]: There's your Vintage Cristal sir, please enjoy your drink.",COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER);
				    return 1;
				}
				case 6:
				{
					newNmoney = oldNmoney + 120;
		            GivePlayerMoney(playerid, -120);
		            SetPlayerSpecialAction(playerid,SPECIAL_ACTION_SMOKE_CIGGY);
					dini_IntSet("/Gangs/Northside.ini","Cash",newNmoney);
					ProxDetector(10.0, playerid, "[Bar Tender]: There's your Cuban sir.",COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER);
				    return 1;
				}
			}
		}
		case 7:
	    {
		    switch(response)
		    {
				case 1:
				{
	 				new Seller = AccountInfo[playerid][OffererID];
	    			new targetname[MAX_PLAYER_NAME], name[MAX_PLAYER_NAME], message[128];
					GetPlayerName(playerid, name, sizeof(name));
	   				GetPlayerName(Seller, targetname, sizeof(targetname));
					format(message, sizeof(message),"[Server]: %s has declined your offer.",name);
					SendClientMessage(playerid,COLOUR_LIGHTBLUE, message);
					format(message, sizeof(message),"[Server]: You have declined %s's offer.",targetname);
					SendClientMessage(playerid,COLOUR_LIGHTBLUE, message);
	                AccountInfo[playerid][OffererID] = 0;
					AccountInfo[playerid][OfferedItem] = 0;
	    			AccountInfo[playerid][OfferedAmount] = 0;
	    			AccountInfo[playerid][OfferedPrice] = 0;
	    			return 1;
				}
				default:
				{
		   			new Seller = AccountInfo[playerid][OffererID];
				    new Amount = AccountInfo[playerid][OfferedAmount];
				    new Cost   = AccountInfo[playerid][OfferedPrice];
			    	new targetname[MAX_PLAYER_NAME], name[MAX_PLAYER_NAME], message[128];
					GivePlayerMoney(playerid,-Cost);
					GivePlayerMoney(Seller,Cost);
					GetPlayerName(playerid, name, sizeof(name));
			   		GetPlayerName(Seller, targetname, sizeof(targetname));
					if(AccountInfo[playerid][OfferedItem] == 1)
					{
				 		new Old    = AccountInfo[playerid][Cannabis], Newvalue = Old + Amount, Nowvalue = Old - Amount;
						AccountInfo[Seller][Cannabis] = Nowvalue;
						AccountInfo[playerid][Cannabis] = Newvalue;
					}
					else if(AccountInfo[playerid][OfferedItem] == 2)
					{
				 		new Old    = AccountInfo[playerid][Cocaine], Newvalue = Old + Amount, Nowvalue = Old - Amount;
						AccountInfo[Seller][Cocaine] = Nowvalue;
						AccountInfo[playerid][Cocaine] = Newvalue;
					}
					else if(AccountInfo[playerid][OfferedItem] == 3)
					{
				 		new Old    = AccountInfo[playerid][Crack], Newvalue = Old + Amount, Nowvalue = Old - Amount;
						AccountInfo[Seller][Crack] = Nowvalue;
						AccountInfo[playerid][Crack] = Newvalue;
					}
					else if(AccountInfo[playerid][OfferedItem] == 4)
					{
				 		new Old    = AccountInfo[playerid][Ecstasy], Newvalue = Old + Amount, Nowvalue = Old - Amount;
						AccountInfo[Seller][Ecstasy] = Nowvalue;
						AccountInfo[playerid][Ecstasy] = Newvalue;
					}
					else if(AccountInfo[playerid][OfferedItem] == 5)
					{
				 		new Old    = AccountInfo[playerid][Firearms], Newvalue = Old + Amount, Nowvalue = Old - Amount;
						AccountInfo[Seller][Firearms] = Nowvalue;
						AccountInfo[playerid][Firearms] = Newvalue;
					}
					format(message, sizeof(message),"[Server]: %s has accepted you offer.",name);
					SendClientMessage(playerid,COLOUR_LIGHTBLUE, message);
	  				format(message, sizeof(message),"[Server]: You have accepted %s's offer.",targetname);
					SendClientMessage(playerid,COLOUR_LIGHTBLUE, message);
			    	return 1;
				}
			}
		}
		case 8:// Northside Relations Dialog
        {
            if(!response)
            {
                SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You cancelled");
                return 1;
            }
            switch(listitem)
            {
                case 0:
                {
               		ShowPlayerDialog(playerid, 12, DIALOG_STYLE_LIST, "The Lost's Stance.","Ally\nNeutral\nHostile","Accept","Cancel");
					return 1;
                }
                case 1:
                {
               		ShowPlayerDialog(playerid, 13, DIALOG_STYLE_LIST, "Red Gecko Tong's Stance.","Ally\nNeutral\nHostile","Accept","Cancel");
					return 1;
                }
                case 2:
                {
               		ShowPlayerDialog(playerid, 14, DIALOG_STYLE_LIST, "Forelli Family Stance.","Ally\nNeutral\nHostile","Accept","Cancel");
					return 1;
				}
            }
        }
		case 9:// Gecko Relations Dialog
        {
            if(!response)
            {
                SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You cancelled");
                return 1;
            }
            switch(listitem)
            {
                case 0:
                {
               		ShowPlayerDialog(playerid, 15, DIALOG_STYLE_LIST, "The Hustlers Stance.","Ally\nNeutral\nHostile","Accept","Cancel");
					return 1;
                }
                case 1:
                {
               		ShowPlayerDialog(playerid, 12, DIALOG_STYLE_LIST, "The Lost's Stance.","Ally\nNeutral\nHostile","Accept","Cancel");
					return 1;
                }
                case 2:
                {
                	ShowPlayerDialog(playerid, 14, DIALOG_STYLE_LIST, "Forelli Family Stance.","Ally\nNeutral\nHostile","Accept","Cancel");
					return 1;
				}
            }
        }
		case 10:// Forelli Relations Dialog
        {
            if(!response)
            {
                SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You cancelled");
                return 1;
            }
            switch(listitem)
            {
                case 0:
                {
               		ShowPlayerDialog(playerid, 15, DIALOG_STYLE_LIST, "The Hustlers Stance.","Ally\nNeutral\nHostile","Accept","Cancel");
					return 1;
                }
                case 1:
                {
              		ShowPlayerDialog(playerid, 12, DIALOG_STYLE_LIST, "The Lost's Stance.","Ally\nNeutral\nHostile","Accept","Cancel");
					return 1;
                }
                case 2:
                {
               		ShowPlayerDialog(playerid, 13, DIALOG_STYLE_LIST, "Red Gecko Tong's Stance.","Ally\nNeutral\nHostile","Accept","Cancel");
					return 1;
				}
            }
        }
		case 11:// The Lost's Relations Dialog
        {
            if(!response)
            {
                SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You cancelled");
                return 1;
            }
            switch(listitem)
            {
                case 0:
                {
                	ShowPlayerDialog(playerid, 15, DIALOG_STYLE_LIST, "The Hustlers Stance.","Ally\nNeutral\nHostile","Accept","Cancel");
					return 1;
                }
                case 1:
                {
                	ShowPlayerDialog(playerid, 13, DIALOG_STYLE_LIST, "Red Gecko Tong's Stance.","Ally\nNeutral\nHostile","Accept","Cancel");
					return 1;
                }
                case 2:
                {
               		ShowPlayerDialog(playerid, 14, DIALOG_STYLE_LIST, "Forelli Family Stance.","Ally\nNeutral\nHostile","Accept","Cancel");
					return 1;
				}
            }
        }
        case 12:
        {
            if(!response)
            {
                SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You cancelled");
                return 1;
            }
            switch(listitem)
            {
                case 0:
                {
		            switch(gang)
		            {
						case 2:
					    {
	          					dini_Set("/Gangs/Forelli.ini", "TheLost", "Allied");
					            return 1;
						}
						case 4:
					    {
					    		dini_Set("/Gangs/Gecko.ini", "TheLost", "Allied");
					            return 1;
						}
						case 5:
					   	{
					    		dini_Set("/Gangs/Northside.ini", "TheLost", "Allied");
					            return 1;
						}
					}
                }
                case 1:
                {
		            switch(gang)
		            {
						case 2:
					    {
	          					dini_Set("/Gangs/Forelli.ini", "TheLost", "Neutral");
					            return 1;
						}
						case 4:
					    {
					    		dini_Set("/Gangs/Gecko.ini", "TheLost", "Neutral");
					            return 1;
						}
						case 5:
					   	{
					    		dini_Set("/Gangs/Northside.ini", "TheLost", "Neutral");
					            return 1;
						}
					}
                }
                case 2:
                {
		            switch(gang)
		            {
						case 2:
					    {
	          					dini_Set("/Gangs/Forelli.ini", "TheLost", "Hostile");
					            return 1;
						}
						case 4:
					    {
					    		dini_Set("/Gangs/Gecko.ini", "TheLost", "Hostile");
					            return 1;
						}
						case 5:
					   	{
					    		dini_Set("/Gangs/Northside.ini", "TheLost", "Hostile");
					            return 1;
						}
					}
                }
            }
        }
        case 13:
        {
            if(!response)
            {
                SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You cancelled");
                return 1;
            }
            switch(listitem)
            {
                case 0:
                {
		            switch(gang)
		            {
						case 2:
					    {
	          					dini_Set("/Gangs/Forelli.ini", "Gecko", "Allied");
					            return 1;
						}
						case 3:
					    {
					    		dini_Set("/Gangs/TheLost.ini", "Gecko", "Allied");
					            return 1;
						}
						case 5:
					   	{
					    		dini_Set("/Gangs/Northside.ini", "Gecko", "Allied");
					            return 1;
						}
					}
                }
                case 1:
                {
		            switch(gang)
		            {
						case 2:
					    {
	          					dini_Set("/Gangs/Forelli.ini", "Gecko", "Neutral");
					            return 1;
						}
						case 3:
					    {
					    		dini_Set("/Gangs/TheLost.ini", "Gecko", "Neutral");
					            return 1;
						}
						case 5:
					   	{
					    		dini_Set("/Gangs/Northside.ini", "Gecko", "Neutral");
					            return 1;
						}
					}
                }
                case 2:
                {
		            switch(gang)
		            {
						case 2:
					    {
	          					dini_Set("/Gangs/Forelli.ini", "Gecko", "Hostile");
					            return 1;
						}
						case 3:
					    {
					    		dini_Set("/Gangs/TheLost.ini", "Gecko", "Hostile");
					            return 1;
						}
						case 5:
					   	{
					    		dini_Set("/Gangs/Northside.ini", "Gecko", "Hostile");
					            return 1;
						}
					}
                }
            }
        }
        case 14:
        {
            if(!response)
            {
                SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You cancelled");
                return 1;
            }
            switch(listitem)
            {
                case 0:
                {
		            switch(gang)
		            {
						case 3:
					    {
	          					dini_Set("/Gangs/TheLost.ini", "Forelli", "Allied");
					            return 1;
						}
						case 4:
					    {
					    		dini_Set("/Gangs/Gecko.ini", "Forelli", "Allied");
					            return 1;
						}
						case 5:
					   	{
					    		dini_Set("/Gangs/Northside.ini", "Forelli", "Allied");
					            return 1;
						}
					}
                }
                case 1:
                {
		            switch(gang)
		            {
						case 3:
					    {
	          					dini_Set("/Gangs/TheLost.ini", "Forelli", "Neutral");
					            return 1;
						}
						case 4:
					    {
					    		dini_Set("/Gangs/Gecko.ini", "Forelli", "Neutral");
					            return 1;
						}
						case 5:
					   	{
					    		dini_Set("/Gangs/Northside.ini", "Forelli", "Neutral");
					            return 1;
						}
					}
                }
                case 2:
                {
		            switch(gang)
		            {
						case 3:
					    {
	          					dini_Set("/Gangs/TheLost.ini", "Forelli", "Hostile");
					            return 1;
						}
						case 4:
					    {
					    		dini_Set("/Gangs/Gecko.ini", "Forelli", "Hostile");
					            return 1;
						}
						case 5:
					   	{
					    		dini_Set("/Gangs/Northside.ini", "Forelli", "Hostile");
					            return 1;
						}
					}
                }
            }
        }
        case 15:
        {
            if(!response)
            {
                SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You cancelled");
                return 1;
            }
            switch(listitem)
            {
                case 0:
                {
		            switch(gang)
		            {
						case 2:
					    {
	          					dini_Set("/Gangs/Forelli.ini", "Northside", "Allied");
					            return 1;
						}
						case 3:
					    {
					    		dini_Set("/Gangs/TheLost.ini", "Northside", "Allied");
					            return 1;
						}
						case 4:
					   	{
					    		dini_Set("/Gangs/Gecko.ini", "Northside", "Allied");
					            return 1;
						}
					}
                }
                case 1:
                {
		            switch(gang)
		            {
						case 2:
					    {
	          					dini_Set("/Gangs/Forelli.ini", "Northside", "Neutral");
					            return 1;
						}
						case 3:
					    {
					    		dini_Set("/Gangs/TheLost.ini", "Northside", "Neutral");
					            return 1;
						}
						case 4:
					   	{
					    		dini_Set("/Gangs/Gecko.ini", "Northside", "Neutral");
					            return 1;
						}
					}
				}
                case 2:
                {
		            switch(gang)
		            {
						case 2:
					    {
	          					dini_Set("/Gangs/Forelli.ini", "Northside", "Hostile");
					            return 1;
						}
						case 3:
					    {
					    		dini_Set("/Gangs/TheLost.ini", "Northside", "Hostile");
					            return 1;
						}
						case 4:
					   	{
					    		dini_Set("/Gangs/Gecko.ini", "Northside", "Hostile");
					            return 1;
						}
					}
				}
            }
		}
		case 16:// Help Dialog
        {
            if(!response)
            {
                SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You cancelled");
                return 1;
            }
            switch(listitem)
            {
                case 0:
                {
                	ShowPlayerDialog(playerid, 17, DIALOG_STYLE_MSGBOX, "Bank Commands.","/deposit [amount] this will put money into your bank account.\n/withdraw [amount] this will take money out of your bank account.\n/balance this will tell you how much money you have in your bank.","Done","Back");
					return 1;
                }
                case 1:
                {
                	ShowPlayerDialog(playerid, 18, DIALOG_STYLE_MSGBOX, "Car Commands","/park this will turn off the engine and park the vehicle\n/start this will turn on the engine and allow the vehicle to move again\n/exit will allow the player to exit a parked vehicle.\n/refuel will refuel the players vehicle if they are at the Petrol Station.\n/eject [playerid] will remove the selected player from your vehicle.","Done","Back");
					return 1;
                }
                case 2:
                {
               		ShowPlayerDialog(playerid, 19, DIALOG_STYLE_MSGBOX, "Chat Commands","/all allows a player to talk to everbody in the server.\n/(s)hout allows a player to shout so people further away can hear you.\n/(w)hisper allows a player to whisper so only player nearby can hear you.\n/pm allows a player to message a player in-game.\n/me allows a player to narate an action so only those nearby can see.\n/meg allows a player narrate an action so all can see it.","Done","Back");
					return 1;
				}
				case 3:
                {
               		ShowPlayerDialog(playerid, 20, DIALOG_STYLE_MSGBOX, "Gang Commands","/storage allows a member to view the gangs inventory.\n/getweapon allows a member to choose a firearm from the storage.\n/leavegang allows a player to leave a gang, but be warned some gangs won't be happy if you leave.\n/g allows a player to talk to their gang.","Done","Back");
					return 1;
				}
				case 4:
                {
               		ShowPlayerDialog(playerid, 21, DIALOG_STYLE_MSGBOX, "Gang Commands","/stats allows you to view your account details.\n/inventory allows you to view what you are carrying.\n/(un)tie allows you to tie a person up.\n/kidnap allows you to force someone into the back of your vehicle.\n/pay allows you to pay another player money.\n/sell allows you to sell drugs firearms to other players.\n/import allows you to ILLEGALY import DRUGS and FIREARMS to sell or give to your gang.","Done","Back");
					return 1;
				}
                case 5:
                {
                	ShowPlayerDialog(playerid, 22, DIALOG_STYLE_MSGBOX, "House Commands.","/houseinfo provides you with the house in question.\n/enter allows you to enter the house.\n/leave allows you to leave the house.\n/buyhouse allows you to buy the selected property.\n/sellhouse allows you to sell your property.\n/(un)lockhouse allows a player to lock or unlock there house for people to come in.","Done","Back");
					return 1;
                }
			}
		}
		case 17 .. 22:// Help Dialog
	    {
	    	if(!response)
			{
   				ShowPlayerDialog(playerid, 16, DIALOG_STYLE_LIST,"Help Categories", "Bank Commands.\nCar Commands.\nChat Commands.\nGang Commands.\nGeneral Commands.\nHouse Commands.", "Accept", "Cancel");
	            return 1;
	        }
	        else
	        {
	            return 1;
			}
		}
		case 23:// Drive Thru
        {
            if(!response)
            {
                SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You cancelled");
                TogglePlayerControllable(playerid,1);
                return 1;
            }
            switch(listitem)
            {
                case 0:
                {
					SetPlayerHealth(playerid, 100);
					GivePlayerMoney(playerid, -20);
					ProxDetector(10.0, playerid, "[Drive-Thru]: Enjoy your Special Meal.",COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER);
					TogglePlayerControllable(playerid,1);
				    return 1;
				}
				case 1:
				{
					new Float:health;
					GetPlayerHealth(playerid, health);
			 		SetPlayerHealth(playerid, health+50);
			 		GivePlayerMoney(playerid, -15);
					ProxDetector(10.0, playerid, "[Drive-Thru]: Enjoy your Chicken Meal.",COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER);
					TogglePlayerControllable(playerid,1);
				    return 1;
				}
				case 2:
				{
					new Float:health;
					GetPlayerHealth(playerid, health);
			 		SetPlayerHealth(playerid, health+25);
					GivePlayerMoney(playerid, -5);
					ProxDetector(10.0, playerid, "[Drive-Thru]: Enjoy your Freedom Fries.",COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER);
					TogglePlayerControllable(playerid,1);
				    return 1;
				}
				case 3:
				{
					new Float:health;
					GetPlayerHealth(playerid, health);
			 		SetPlayerHealth(playerid, health+10);
					GivePlayerMoney(playerid, -4);
					ProxDetector(10.0, playerid, "[Drive-Thru]: Enjoy your Apple Pie.",COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER);
					TogglePlayerControllable(playerid,1);
				    return 1;
				}
				case 4:
				{
					new Float:health;
					GetPlayerHealth(playerid, health);
			 		SetPlayerHealth(playerid, health+5);
					GivePlayerMoney(playerid, -3);
					ProxDetector(10.0, playerid, "[Drive-Thru]: There's your Fanta.",COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER);
					TogglePlayerControllable(playerid,1);
				    return 1;
				}
				case 5:
				{
					new Float:health;
					GetPlayerHealth(playerid, health);
			 		SetPlayerHealth(playerid, health+5);
					GivePlayerMoney(playerid, -3);
					ProxDetector(10.0, playerid, "[Drive-Thru]: There's your Coca Cola.",COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER);
					TogglePlayerControllable(playerid,1);
				    return 1;
				}
				case 6:
				{
					new Float:health;
					GetPlayerHealth(playerid, health);
			 		SetPlayerHealth(playerid, health+5);
					GivePlayerMoney(playerid, -3);
					ProxDetector(10.0, playerid, "[Drive-Thru]: There's your Sprunk.",COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER);
					TogglePlayerControllable(playerid,1);
				    return 1;
				}
			}
		}
		case 24:// Bank Dialog
        {
            if(!response)
            {
                SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You cancelled");
                TogglePlayerControllable(playerid,1);
                return 1;
            }
            switch(listitem)
            {
                case 0:
                {
					ShowPlayerDialog(playerid,25,DIALOG_STYLE_INPUT,"Make a Deposit","How much would you like to deposit into your account.","Deposit","Back");
				    return 1;
				}
				case 1:
				{
					ShowPlayerDialog(playerid,26,DIALOG_STYLE_INPUT,"Make a Withdrawal","How much would you like to withdraw from your account.","Withdraw","Back");
				    return 1;
				}
				case 2:
				{
					new bankmessage[128];
					format(bankmessage, sizeof(bankmessage), "Your current balance stands at $%d dollars.",AccountInfo[playerid][Bank]);
					ShowPlayerDialog(playerid, 27, DIALOG_STYLE_MSGBOX, "Your Balance",bankmessage,"Done","Back");
				    return 1;
				}
			}
		}
		case 25://Deposit Dialog
		{
            if(!response)
			{
				ShowPlayerDialog(playerid, 24, DIALOG_STYLE_LIST,"San Andreas Federal Bank", "Make a Deposit\nMake a Withdrawal\nView your Balance", "Accept", "Cancel");
				return 1;
			}
			else
			{
				new deposit = strval(inputtext);
		        if (deposit > GetPlayerMoney(playerid) || deposit < 1)
		        {
					ShowPlayerDialog(playerid,25,DIALOG_STYLE_INPUT,"Make a Deposit","You Haven't got that much to deposit in your account./nHow much would you like to deposit into your account.","Deposit","Back");
					return 1;
				}
				else
				{
					GivePlayerMoney(playerid,-deposit);
					AccountInfo[playerid][Bank]=deposit+AccountInfo[playerid][Bank];
					TogglePlayerControllable(playerid,1);
					return 1;
				}
			}
		}
		case 26://Withdraw Dialog
		{
            if(!response)
			{
				ShowPlayerDialog(playerid, 24, DIALOG_STYLE_LIST,"San Andreas Federal Bank", "Make a Deposit\nMake a Withdrawal\nView your Balance", "Accept", "Cancel");
				return 1;
			}
			else
			{
				new withdraw = strval(inputtext);
		        if (withdraw > GetPlayerMoney(playerid) || withdraw < 1)
		        {
					ShowPlayerDialog(playerid,26,DIALOG_STYLE_INPUT,"Make a Withdrawal","You Haven't got that much in your account./nHow much would you like to withdraw from your account.","Withdraw","Back");
					return 1;
				}
				else
				{
					GivePlayerMoney(playerid,withdraw);
					AccountInfo[playerid][Bank]=AccountInfo[playerid][Bank]-withdraw;
					TogglePlayerControllable(playerid,1);
					return 1;
				}
			}
		}
		case 27://Balance Dialog
		{
            if(!response)
			{
				ShowPlayerDialog(playerid, 24, DIALOG_STYLE_LIST,"San Andreas Federal Bank", "Make a Deposit\nMake a Withdrawal\nView your Balance", "Accept", "Cancel");
				return 1;
			}
			else
			{
                TogglePlayerControllable(playerid,1);
                return 1;
			}
		}
	    case 28:// SFPD Dialog
	    {
		    switch(response)
		    {
				case 0:
				{
					return 0;
				}
				default:
				{
					AccountInfo[playerid][pTeam] = 1;
					AccountInfo[playerid][GangRank] = 1;
					SetPlayerColor(playerid,COLOUR_LIGHTBLUE);
					return 1;
				}
			}
		}
	    case 29:// Forelli Dialog
	    {
		    switch(response)
		    {
				case 0:
				{
					return 0;
				}
				default:
				{
					AccountInfo[playerid][pTeam] = 2;
					AccountInfo[playerid][GangRank] = 1;
					SetPlayerColor(playerid,COLOUR_FORELLI);
					return 1;
				}
			}
		}
	    case 30:// TheLost Dialog
	    {
		    switch(response)
		    {
				case 0:
				{
					return 0;
				}
				default:
				{
					AccountInfo[playerid][pTeam] = 3;
					AccountInfo[playerid][GangRank] = 1;
					SetPlayerColor(playerid,COLOUR_THELOST);
					return 1;
				}
			}
		}
	    case 31:// Triads Dialog
	    {
		    switch(response)
		    {
				case 0:
				{
					return 0;
				}
				default:
				{
					AccountInfo[playerid][pTeam] = 4;
					AccountInfo[playerid][GangRank] = 1;
					SetPlayerColor(playerid,COLOUR_GECKO);
					return 1;
				}
			}
		}
	    case 32:// Northside Hustlers Dialog
	    {
		    switch(response)
		    {
				case 0:
				{
					return 0;
				}
				default:
				{
					AccountInfo[playerid][pTeam] = 5;
					AccountInfo[playerid][GangRank] = 1;
					SetPlayerColor(playerid,COLOUR_NORTHSIDE);
					return 1;
				}
			}
		}
	}
	return 1;
}
//<============================================================================>
public Payday()
{
	for(new i = 0; i < GetMaxPlayers(); i++)
    {
        new Randomimport = random(5), string[64];
		if(IsPlayerConnected(i))
        {
			new teamrank;
			new joblevel;
			teamrank = AccountInfo[i][GangRank];
			joblevel = AccountInfo[i][jLevel];
			if(GetPlayerTeam(i) == 0)
	   		{
  				AccountInfo[i][Bank] = AccountInfo[i][Bank] + 50;
	   		}
			if(GetPlayerTeam(i) == 1)
	   		{
				if(teamrank == 1){AccountInfo[i][Bank] = AccountInfo[i][Bank] + 150;}
				if(teamrank == 2){AccountInfo[i][Bank] = AccountInfo[i][Bank] + 250;}
				if(teamrank == 3){AccountInfo[i][Bank] = AccountInfo[i][Bank] + 350;}
				if(teamrank == 4){AccountInfo[i][Bank] = AccountInfo[i][Bank] + 450;}
				if(teamrank == 5){AccountInfo[i][Bank] = AccountInfo[i][Bank] + 550;}
			}
			if(GetPlayerTeam(i) == 2)
			{
                new Sniff1  = dini_Int("/Gangs/Forelli.ini","BISniff");
        		new Weed1   = dini_Int("/Gangs/Forelli.ini","BIWeed");
		        new Crack1  = dini_Int("/Gangs/Forelli.ini","BICrack");
		        new Pills1  = dini_Int("/Gangs/Forelli.ini","BIPills");
		        new Guns1   = dini_Int("/Gangs/Forelli.ini","BIFirearms");
		        new Kevlar1 = dini_Int("/Gangs/Forelli.ini","BIKevlar");
		        new WeedValue = Weed1 + 25, PillValue = Pills1 + 25, SniffValue = Sniff1 + 25;
				new CrackValue = Crack1 + 25, FirearmsValue = Guns1 + 25, KevlarValue = Kevlar1 + 25;
				if(Randomimport == 0){dini_IntSet("/Gangs/Forelli.ini", "BIWeed"	, WeedValue);}
				if(Randomimport == 1){dini_IntSet("/Gangs/Forelli.ini", "BIPills"	, PillValue);}
				if(Randomimport == 2){dini_IntSet("/Gangs/Forelli.ini", "BISniff"	, SniffValue);}
				if(Randomimport == 3){dini_IntSet("/Gangs/Forelli.ini", "BICrack"	, CrackValue);}
				if(Randomimport == 4){dini_IntSet("/Gangs/Forelli.ini", "BIFirearms", FirearmsValue);}
				if(Randomimport == 5){dini_IntSet("/Gangs/Forelli.ini", "BIKevlar"	, KevlarValue);}
               	dini_IntSet("/Gangs/Forelli.ini","Bigimported",0);
               	
				if(teamrank == 1){AccountInfo[i][Bank] = AccountInfo[i][Bank] + 200;}
				if(teamrank == 2){AccountInfo[i][Bank] = AccountInfo[i][Bank] + 300;}
				if(teamrank == 3){AccountInfo[i][Bank] = AccountInfo[i][Bank] + 400;}
				if(teamrank == 4){AccountInfo[i][Bank] = AccountInfo[i][Bank] + 500;}
				if(teamrank == 5){AccountInfo[i][Bank] = AccountInfo[i][Bank] + 600;}
			}
			if(GetPlayerTeam(i) == 3)
			{
                new Sniff1  = dini_Int("/Gangs/TheLost.ini","BISniff");
        		new Weed1   = dini_Int("/Gangs/TheLost.ini","BIWeed");
		        new Crack1  = dini_Int("/Gangs/TheLost.ini","BICrack");
		        new Pills1  = dini_Int("/Gangs/TheLost.ini","BIPills");
		        new Guns1   = dini_Int("/Gangs/TheLost.ini","BIFirearms");
		        new Kevlar1 = dini_Int("/Gangs/TheLost.ini","BIKevlar");
		        new WeedValue = Weed1 + 25, PillValue = Pills1 + 25, SniffValue = Sniff1 + 25;
				new CrackValue = Crack1 + 25, FirearmsValue = Guns1 + 25, KevlarValue = Kevlar1 + 25;
				if(Randomimport == 0){dini_IntSet("/Gangs/TheLost.ini", "BIWeed"	, WeedValue);}
				if(Randomimport == 1){dini_IntSet("/Gangs/TheLost.ini", "BIPills"	, PillValue);}
				if(Randomimport == 2){dini_IntSet("/Gangs/TheLost.ini", "BISniff"	, SniffValue);}
				if(Randomimport == 3){dini_IntSet("/Gangs/TheLost.ini", "BICrack"	, CrackValue);}
				if(Randomimport == 4){dini_IntSet("/Gangs/TheLost.ini", "BIFirearms", FirearmsValue);}
				if(Randomimport == 5){dini_IntSet("/Gangs/TheLost.ini", "BIKevlar"	, KevlarValue);}
               	dini_IntSet("/Gangs/TheLost.ini","Bigimported",0);
				
				if(teamrank == 1){AccountInfo[i][Bank] = AccountInfo[i][Bank] + 200;}
				if(teamrank == 2){AccountInfo[i][Bank] = AccountInfo[i][Bank] + 300;}
				if(teamrank == 3){AccountInfo[i][Bank] = AccountInfo[i][Bank] + 400;}
				if(teamrank == 4){AccountInfo[i][Bank] = AccountInfo[i][Bank] + 500;}
				if(teamrank == 5){AccountInfo[i][Bank] = AccountInfo[i][Bank] + 600;}
			}
			if(GetPlayerTeam(i) == 4)
			{
                new Sniff1  = dini_Int("/Gangs/Gecko.ini","BISniff");
        		new Weed1   = dini_Int("/Gangs/Gecko.ini","BIWeed");
		        new Crack1  = dini_Int("/Gangs/Gecko.ini","BICrack");
		        new Pills1  = dini_Int("/Gangs/Gecko.ini","BIPills");
		        new Guns1   = dini_Int("/Gangs/Gecko.ini","BIFirearms");
		        new Kevlar1 = dini_Int("/Gangs/Gecko.ini","BIKevlar");
		        new WeedValue = Weed1 + 25, PillValue = Pills1 + 25, SniffValue = Sniff1 + 25;
				new CrackValue = Crack1 + 25, FirearmsValue = Guns1 + 25, KevlarValue = Kevlar1 + 25;
				if(Randomimport == 0){dini_IntSet("/Gangs/Gecko.ini", "BIWeed"	, WeedValue);}
				if(Randomimport == 1){dini_IntSet("/Gangs/Gecko.ini", "BIPills"	, PillValue);}
				if(Randomimport == 2){dini_IntSet("/Gangs/Gecko.ini", "BISniff"	, SniffValue);}
				if(Randomimport == 3){dini_IntSet("/Gangs/Gecko.ini", "BICrack"	, CrackValue);}
				if(Randomimport == 4){dini_IntSet("/Gangs/Gecko.ini", "BIFirearms", FirearmsValue);}
				if(Randomimport == 5){dini_IntSet("/Gangs/Gecko.ini", "BIKevlar"	, KevlarValue);}
               	dini_IntSet("/Gangs/Gecko.ini","Bigimported",0);

				if(teamrank == 1){AccountInfo[i][Bank] = AccountInfo[i][Bank] + 200;}
				if(teamrank == 2){AccountInfo[i][Bank] = AccountInfo[i][Bank] + 300;}
				if(teamrank == 3){AccountInfo[i][Bank] = AccountInfo[i][Bank] + 400;}
				if(teamrank == 4){AccountInfo[i][Bank] = AccountInfo[i][Bank] + 500;}
				if(teamrank == 5){AccountInfo[i][Bank] = AccountInfo[i][Bank] + 600;}
			}
			if(GetPlayerTeam(i) == 5)
			{
                new Sniff1  = dini_Int("/Gangs/Northside.ini","BISniff");
        		new Weed1   = dini_Int("/Gangs/Northside.ini","BIWeed");
		        new Crack1  = dini_Int("/Gangs/Northside.ini","BICrack");
		        new Pills1  = dini_Int("/Gangs/Northside.ini","BIPills");
		        new Guns1   = dini_Int("/Gangs/Northside.ini","BIFirearms");
		        new Kevlar1 = dini_Int("/Gangs/Northside.ini","BIKevlar");
		        new WeedValue = Weed1 + 25, PillValue = Pills1 + 25, SniffValue = Sniff1 + 25;
				new CrackValue = Crack1 + 25, FirearmsValue = Guns1 + 25, KevlarValue = Kevlar1 + 25;
				if(Randomimport == 0){dini_IntSet("/Gangs/Northside.ini", "BIWeed"	, WeedValue);}
				if(Randomimport == 1){dini_IntSet("/Gangs/Northside.ini", "BIPills"	, PillValue);}
				if(Randomimport == 2){dini_IntSet("/Gangs/Northside.ini", "BISniff"	, SniffValue);}
				if(Randomimport == 3){dini_IntSet("/Gangs/Northside.ini", "BICrack"	, CrackValue);}
				if(Randomimport == 4){dini_IntSet("/Gangs/Northside.ini", "BIFirearms", FirearmsValue);}
				if(Randomimport == 5){dini_IntSet("/Gangs/Northside.ini", "BIKevlar"	, KevlarValue);}
               	dini_IntSet("/Gangs/Northside.ini","Bigimported",0);
				
				if(teamrank == 1){AccountInfo[i][Bank] = AccountInfo[i][Bank] + 200;}
				if(teamrank == 2){AccountInfo[i][Bank] = AccountInfo[i][Bank] + 300;}
				if(teamrank == 3){AccountInfo[i][Bank] = AccountInfo[i][Bank] + 400;}
				if(teamrank == 4){AccountInfo[i][Bank] = AccountInfo[i][Bank] + 500;}
				if(teamrank == 5){AccountInfo[i][Bank] = AccountInfo[i][Bank] + 600;}
			}
//<=================================[Roadrunners Driver]=======================>
			if(AccountInfo[i][pJob] == 1)
			{
				if(joblevel == 1){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 50;}
				if(joblevel == 2){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 100;}
				if(joblevel == 3){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 150;}
				if(joblevel == 4){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 200;}
				if(joblevel == 5){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 250;}
				if(joblevel == 6){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 300;}
				if(joblevel == 7){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 350;}
				if(joblevel == 8){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 400;}
				if(joblevel == 9){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 450;}
				if(joblevel == 10){AccountInfo[i][Bank] = AccountInfo[i][Bank] + 500;}
			}
//<=================================[Pizza Delivery Boy]=======================>
			if(AccountInfo[i][pJob] == 2)
			{
				if(joblevel == 1){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 25;}
				if(joblevel == 2){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 50;}
				if(joblevel == 3){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 75;}
				if(joblevel == 4){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 100;}
				if(joblevel == 5){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 125;}
				if(joblevel == 6){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 150;}
				if(joblevel == 7){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 175;}
				if(joblevel == 8){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 200;}
				if(joblevel == 9){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 225;}
				if(joblevel == 10){AccountInfo[i][Bank] = AccountInfo[i][Bank] + 250;}
			}
//<================================[Juank Airways Pilot]=======================>
			if(AccountInfo[i][pJob] == 3)
			{
				if(joblevel == 1){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 100;}
				if(joblevel == 2){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 200;}
				if(joblevel == 3){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 250;}
				if(joblevel == 4){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 300;}
				if(joblevel == 5){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 500;}
			}
//<===============================[Longs Haulage Driver]=======================>
			if(AccountInfo[i][pJob] == 4)
			{
				if(joblevel == 1){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 100;}
				if(joblevel == 2){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 200;}
				if(joblevel == 3){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 250;}
				if(joblevel == 4){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 300;}
				if(joblevel == 5){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 500;}
			}
//<================================[Church of San Fierro]======================>
			if(AccountInfo[i][pJob] == 5)
			{
				if(joblevel == 1){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 50;}
				if(joblevel == 2){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 150;}
				if(joblevel == 3){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 250;}
				if(joblevel == 4){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 350;}
			}
//<==================================[San Andreas News]========================>
			if(AccountInfo[i][pJob] == 6)
			{
				if(joblevel == 1){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 20;}
				if(joblevel == 2){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 150;}
				if(joblevel == 3){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 250;}
				if(joblevel == 4){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 400;}
				if(joblevel == 5){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 550;}
			}
//<==================================[Fire Department]=========================>
			if(AccountInfo[i][pJob] == 7)
			{
				if(joblevel == 1){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 50;}
				if(joblevel == 2){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 100;}
				if(joblevel == 3){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 150;}
				if(joblevel == 4){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 200;}
				if(joblevel == 5){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 250;}
				if(joblevel == 6){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 300;}
				if(joblevel == 7){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 350;}
				if(joblevel == 8){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 400;}
				if(joblevel == 9){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 450;}
				if(joblevel == 10){AccountInfo[i][Bank] = AccountInfo[i][Bank] + 500;}
			}
//<=====================================[Paramedic]============================>
			if(AccountInfo[i][pJob] == 8)
			{
				if(joblevel == 1){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 50;}
				if(joblevel == 2){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 100;}
				if(joblevel == 3){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 150;}
				if(joblevel == 4){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 200;}
				if(joblevel == 5){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 250;}
				if(joblevel == 6){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 300;}
				if(joblevel == 7){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 350;}
				if(joblevel == 8){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 400;}
				if(joblevel == 9){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 450;}
				if(joblevel == 10){AccountInfo[i][Bank] = AccountInfo[i][Bank] + 500;}
			}
			if(AccountInfo[i][pJob] == 9)
			{
				if(joblevel == 1){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 50;}
				if(joblevel == 2){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 100;}
				if(joblevel == 3){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 150;}
				if(joblevel == 4){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 200;}
				if(joblevel == 5){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 250;}
				if(joblevel == 6){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 300;}
				if(joblevel == 7){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 350;}
				if(joblevel == 8){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 400;}
				if(joblevel == 9){AccountInfo[i][Bank]  = AccountInfo[i][Bank] + 450;}
				if(joblevel == 10){AccountInfo[i][Bank] = AccountInfo[i][Bank] + 500;}
			}
			GameTextForAll("Payday", 6000, 1);
			AccountInfo[i][pExp]++;
			AccountInfo[i][jExp]++;
			AccountInfo[i][Imported] = 0;
			format(string,sizeof(string),"[Payday]: Your Bank Account now stands at $%d dollars.",AccountInfo[i][Bank]);
			SendClientMessage(i,COLOUR_WHITE,string);
			OnPlayerUpdateAccount(i);
			UpdateLevel(i);
			UpdateJobLevel(i);
        }
        else
        {
		}
	}
}
//<=================================[Check Level]=============================>
public CheckLevel(playerid)
{
if(AccountInfo[playerid][pLevel] == 0){SetPlayerScore(playerid,0);}
if(AccountInfo[playerid][pLevel] == 1){SetPlayerScore(playerid,1);}
if(AccountInfo[playerid][pLevel] == 2){SetPlayerScore(playerid,2);}
if(AccountInfo[playerid][pLevel] == 3){SetPlayerScore(playerid,3);}
if(AccountInfo[playerid][pLevel] == 4){SetPlayerScore(playerid,4);}
if(AccountInfo[playerid][pLevel] == 5){SetPlayerScore(playerid,5);}
if(AccountInfo[playerid][pLevel] == 6){SetPlayerScore(playerid,6);}
if(AccountInfo[playerid][pLevel] == 7){SetPlayerScore(playerid,7);}
if(AccountInfo[playerid][pLevel] == 8){SetPlayerScore(playerid,8);}
if(AccountInfo[playerid][pLevel] == 9){SetPlayerScore(playerid,9);}
if(AccountInfo[playerid][pLevel] == 10){SetPlayerScore(playerid,10);}
if(AccountInfo[playerid][pLevel] == 11){SetPlayerScore(playerid,11);}
if(AccountInfo[playerid][pLevel] == 12){SetPlayerScore(playerid,12);}
if(AccountInfo[playerid][pLevel] == 13){SetPlayerScore(playerid,13);}
if(AccountInfo[playerid][pLevel] == 14){SetPlayerScore(playerid,14);}
if(AccountInfo[playerid][pLevel] == 15){SetPlayerScore(playerid,15);}
if(AccountInfo[playerid][pLevel] == 16){SetPlayerScore(playerid,16);}
if(AccountInfo[playerid][pLevel] == 17){SetPlayerScore(playerid,17);}
if(AccountInfo[playerid][pLevel] == 18){SetPlayerScore(playerid,18);}
if(AccountInfo[playerid][pLevel] == 19){SetPlayerScore(playerid,19);}
if(AccountInfo[playerid][pLevel] == 20){SetPlayerScore(playerid,20);}
return 0;
}
//<================================[Update Levels]=============================>
public UpdateLevel(playerid)
{
if(AccountInfo[playerid][pExp] >= 1 && AccountInfo[playerid][pLevel] == 0)
{
AccountInfo[playerid][pExp] = 0;
AccountInfo[playerid][pLevel] = 1;
SetPlayerScore(playerid,1);
SendClientMessage(playerid,COLOUR_WHITE,"[Level]: Well Done you are level 1");
}
if(AccountInfo[playerid][pExp] >= 2 && AccountInfo[playerid][pLevel] == 1)
{
AccountInfo[playerid][pExp] = 0;
AccountInfo[playerid][pLevel] = 2;
SetPlayerScore(playerid,2);
SendClientMessage(playerid,COLOUR_WHITE,"[Level]: Well Done you are level 2");
}
if(AccountInfo[playerid][pExp] >= 3 && AccountInfo[playerid][pLevel] == 2)
{
AccountInfo[playerid][pExp] = 0;
AccountInfo[playerid][pLevel] = 3;
SetPlayerScore(playerid,3);
SendClientMessage(playerid,COLOUR_WHITE,"[Level]: Well Done you are level 3");
}
if(AccountInfo[playerid][pExp] >= 4 && AccountInfo[playerid][pLevel] == 3)
{
AccountInfo[playerid][pExp] = 0;
AccountInfo[playerid][pLevel] = 4;
SetPlayerScore(playerid,4);
SendClientMessage(playerid,COLOUR_WHITE,"[Level]: Well Done you are level 4");
}
if(AccountInfo[playerid][pExp] >= 5 && AccountInfo[playerid][pLevel] == 4)
{
AccountInfo[playerid][pExp] = 0;
AccountInfo[playerid][pLevel] = 5;
SetPlayerScore(playerid,5);
SendClientMessage(playerid,COLOUR_WHITE,"[Level]: Well Done you are level 5");
}
if(AccountInfo[playerid][pExp] >= 6 && AccountInfo[playerid][pLevel] == 5)
{
AccountInfo[playerid][pExp] = 0;
AccountInfo[playerid][pLevel] = 6;
SetPlayerScore(playerid,6);
SendClientMessage(playerid,COLOUR_WHITE,"[Level]: Well Done you are level 6");
}
if(AccountInfo[playerid][pExp] >= 7 && AccountInfo[playerid][pLevel] == 6)
{
AccountInfo[playerid][pExp] = 0;
AccountInfo[playerid][pLevel] = 7;
SetPlayerScore(playerid,7);
SendClientMessage(playerid,COLOUR_WHITE,"[Level]: Well Done you are level 7");
}
if(AccountInfo[playerid][pExp] >= 8 && AccountInfo[playerid][pLevel] == 7)
{
AccountInfo[playerid][pExp] = 0;
AccountInfo[playerid][pLevel] = 8;
SetPlayerScore(playerid,8);
SendClientMessage(playerid,COLOUR_WHITE,"[Level]: Well Done you are level 8");
}//18 hours
if(AccountInfo[playerid][pExp] >= 9 && AccountInfo[playerid][pLevel] == 8)
{
AccountInfo[playerid][pExp] = 0;
AccountInfo[playerid][pLevel] = 9;
SetPlayerScore(playerid,9);
SendClientMessage(playerid,COLOUR_WHITE,"[Level]: Well Done you are level 9");
}//22.30 hours
if(AccountInfo[playerid][pExp] >= 10 && AccountInfo[playerid][pLevel] == 9)
{
AccountInfo[playerid][pExp] = 0;
AccountInfo[playerid][pLevel] = 10;
SetPlayerScore(playerid,10);
SendClientMessage(playerid,COLOUR_WHITE,"[Level]: Well Done you are level 10");
}//27.30
if(AccountInfo[playerid][pExp] >= 10 && AccountInfo[playerid][pLevel] == 10)
{
AccountInfo[playerid][pExp] = 0;
AccountInfo[playerid][pLevel] = 11;
SetPlayerScore(playerid,11);
SendClientMessage(playerid,COLOUR_WHITE,"[Level]: Well Done you are level 11");
}//27.30
if(AccountInfo[playerid][pExp] >= 10 && AccountInfo[playerid][pLevel] == 11)
{
AccountInfo[playerid][pExp] = 0;
AccountInfo[playerid][pLevel] = 12;
SetPlayerScore(playerid,12);
SendClientMessage(playerid,COLOUR_WHITE,"[Level]: Well Done you are level 12");
}//27.30
if(AccountInfo[playerid][pExp] >= 10 && AccountInfo[playerid][pLevel] == 12)
{
AccountInfo[playerid][pExp] = 0;
AccountInfo[playerid][pLevel] = 13;
SetPlayerScore(playerid,13);
SendClientMessage(playerid,COLOUR_WHITE,"[Level]: Well Done you are level 13");
}//27.30
if(AccountInfo[playerid][pExp] >= 10 && AccountInfo[playerid][pLevel] == 13)
{
AccountInfo[playerid][pExp] = 0;
AccountInfo[playerid][pLevel] = 14;
SetPlayerScore(playerid,14);
SendClientMessage(playerid,COLOUR_WHITE,"[Level]: Well Done you are level 14");
}//27.30
if(AccountInfo[playerid][pExp] >= 10 && AccountInfo[playerid][pLevel] == 14)
{
AccountInfo[playerid][pExp] = 0;
AccountInfo[playerid][pLevel] = 15;
SetPlayerScore(playerid,15);
SendClientMessage(playerid,COLOUR_WHITE,"[Level]: Well Done you are level 15");
}//27.30
if(AccountInfo[playerid][pExp] >= 10 && AccountInfo[playerid][pLevel] == 15)
{
AccountInfo[playerid][pExp] = 0;
AccountInfo[playerid][pLevel] = 16;
SetPlayerScore(playerid,16);
SendClientMessage(playerid,COLOUR_WHITE,"[Level]: Well Done you are level 16");
}//27.30
if(AccountInfo[playerid][pExp] >= 10 && AccountInfo[playerid][pLevel] == 16)
{
AccountInfo[playerid][pExp] = 0;
AccountInfo[playerid][pLevel] = 17;
SetPlayerScore(playerid,17);
SendClientMessage(playerid,COLOUR_WHITE,"[Level]: Well Done you are level 17");
}//27.30
if(AccountInfo[playerid][pExp] >= 10 && AccountInfo[playerid][pLevel] == 17)
{
AccountInfo[playerid][pExp] = 0;
AccountInfo[playerid][pLevel] = 18;
SetPlayerScore(playerid,18);
SendClientMessage(playerid,COLOUR_WHITE,"[Level]: Well Done you are level 18");
}//27.30
if(AccountInfo[playerid][pExp] >= 10 && AccountInfo[playerid][pLevel] == 18)
{
AccountInfo[playerid][pExp] = 0;
AccountInfo[playerid][pLevel] = 19;
SetPlayerScore(playerid,19);
SendClientMessage(playerid,COLOUR_WHITE,"[Level]: Well Done you are level 19");
}//27.30
if(AccountInfo[playerid][pExp] >= 10 && AccountInfo[playerid][pLevel] == 19)
{
AccountInfo[playerid][pExp] = 0;
AccountInfo[playerid][pLevel] = 20;
SetPlayerScore(playerid,20);
SendClientMessage(playerid,COLOUR_WHITE,"[Level]: Well Done you are level 20");
}//27.30

return 0;
}
//<============================================================================>
public UpdateJobLevel(playerid)
{
	if(AccountInfo[playerid][pJob] == 0){return 0;}
	if(AccountInfo[playerid][jExp] >= 1 && AccountInfo[playerid][jLevel] == 0)
	{
		AccountInfo[playerid][jExp] = 0;
		AccountInfo[playerid][jLevel] = 1;
		SendClientMessage(playerid,COLOUR_WHITE,"[Level]: Well Done you are job level 1");
	}
	if(AccountInfo[playerid][jExp] >= 2 && AccountInfo[playerid][jLevel] == 1)
	{
		AccountInfo[playerid][jExp] = 0;
		AccountInfo[playerid][jLevel] = 2;
		SendClientMessage(playerid,COLOUR_WHITE,"[Level]: Well Done you are job level 2");
	}
	if(AccountInfo[playerid][jExp] >= 3 && AccountInfo[playerid][jLevel] == 2)
	{
		AccountInfo[playerid][jExp] = 0;
		AccountInfo[playerid][jLevel] = 3;
		SendClientMessage(playerid,COLOUR_WHITE,"[Level]: Well Done you are job level 3");
	}
	if(AccountInfo[playerid][jExp] >= 4 && AccountInfo[playerid][jLevel] == 3)
	{
		AccountInfo[playerid][jExp] = 0;
		AccountInfo[playerid][jLevel] = 4;
		SendClientMessage(playerid,COLOUR_WHITE,"[Level]: Well Done you are job level 4");
	}
	if(AccountInfo[playerid][jExp] >= 5 && AccountInfo[playerid][jLevel] == 4)
	{
		AccountInfo[playerid][jExp] = 0;
		AccountInfo[playerid][jLevel] = 5;
		SendClientMessage(playerid,COLOUR_WHITE,"[Level]: Well Done you are job level 5");
	}
	if(AccountInfo[playerid][jExp] >= 6 && AccountInfo[playerid][jLevel] == 5)
	{
		AccountInfo[playerid][jExp] = 0;
		AccountInfo[playerid][jLevel] = 6;
		SendClientMessage(playerid,COLOUR_WHITE,"[Level]: Well Done you are job level 6");
	}
	if(AccountInfo[playerid][jExp] >= 7 && AccountInfo[playerid][jLevel] == 6)
	{
		AccountInfo[playerid][jExp] = 0;
		AccountInfo[playerid][jLevel] = 7;
		SendClientMessage(playerid,COLOUR_WHITE,"[Level]: Well Done you are job level 7");
	}
	if(AccountInfo[playerid][jExp] >= 8 && AccountInfo[playerid][jLevel] == 7)
	{
		AccountInfo[playerid][jExp] = 0;
		AccountInfo[playerid][jLevel] = 8;
		SendClientMessage(playerid,COLOUR_WHITE,"[Level]: Well Done you are job level 8");
	}
	if(AccountInfo[playerid][jExp] >= 9 && AccountInfo[playerid][jLevel] == 8)
	{
		AccountInfo[playerid][jExp] = 0;
		AccountInfo[playerid][jLevel] = 9;
		SendClientMessage(playerid,COLOUR_WHITE,"[Level]: Well Done you are job level 9");
	}
	if(AccountInfo[playerid][jExp] >= 10 && AccountInfo[playerid][jLevel] == 9)
	{
		AccountInfo[playerid][jExp] = 0;
		AccountInfo[playerid][jLevel] = 10;
		SendClientMessage(playerid,COLOUR_WHITE,"[Level]: Well Done you are job level 10");
	}
	return 0;
}
//<=================================[Jail Release]=============================>
public JailTimer(playerid)
{
	new string[128];
	if(counter > 0)
	{
		format(string, sizeof(string), "You have %d seconds remaining of your sentence.", counter);
		GameTextForPlayer(playerid,string, 1000, 1);
		AccountInfo[playerid][Jail] = 1;
	}
	else
	{
		format(string, sizeof(string),"~n~You have been released from Jail.");
        GameTextForPlayer(playerid,string, 1000, 1);
 		counter = 0;
		KillTimer(JailCountTimer);
		AccountInfo[playerid][Jail] = 0;
	}
	counter--;
	return true;
}
//<=================================[Release]==================================>
public Release(playerid)
{
		SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid,-1605.6774,713.5526,13.4047);
		SetPlayerWantedLevel(playerid,0);
        return 1;
}
//<=================================[Drug Effect]==============================>
public Drugeffect(playerid)
{
        SetPlayerWeather(playerid,-66);
        SetPlayerDrunkLevel(playerid, 50000);
        SetTimerEx("NormalWeather",280000,false,"i",playerid);
        return 1;
}
//<===============================[Normal Weather]=============================>
public NormalWeather(playerid)
{
		new norm;
		norm = GetServerVarAsInt("weather");
		SetWeather(norm);
        return 1;
}
//<================================[Tazered Effect]=============================>
public Tazer(playerid)
{
        SendClientMessage(playerid,COLOUR_HEADER,"You slowly come around from the stun effect.");
		TogglePlayerControllable(playerid,0);
        return 1;
}
//<================================[Prox Detector]=============================>
public ProxDetector(Float:radi, playerid, str[],col1,col2,col3,col4,col5)
{
	if(IsPlayerConnected(playerid))
	{
		new Float:posx, Float:posy, Float:posz;
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		//radi = 2.0; //Trigger Radius
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i))
			{

				GetPlayerPos(i, posx, posy, posz);
				tempposx = (oldposx -posx);
				tempposy = (oldposy -posy);
				tempposz = (oldposz -posz);
				//printf("DEBUG: X:%f Y:%f Z:%f",posx,posy,posz);
				if (((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16)))
				{
					SendClientMessage(i, col1, str);
				}
				else if (((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8)))
				{
					SendClientMessage(i, col2, str);
				}
				else if (((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4)))
				{
					SendClientMessage(i, col3, str);
				}
				else if (((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2)))
				{
					SendClientMessage(i, col4, str);
				}
				else if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
				{
					SendClientMessage(i, col5, str);
				}
			}
		}
	}//not connected
	return 1;
}
//<================================[Announcements]=============================>
public GlobalAnnouncement()
{
	switch (Msg)
	{
	    case 0: {SendClientMessageToAll(COLOUR_ORANGE,Announcements[0]); Msg++;} // first message
	    case 1: {SendClientMessageToAll(COLOUR_ORANGE,Announcements[1]); Msg++;}
        case 2: {SendClientMessageToAll(COLOUR_ORANGE,Announcements[1]); Msg++;}
		case 3: {SendClientMessageToAll(COLOUR_ORANGE,Announcements[2]); Msg = 0;} // last message
	}
	return 1;
}
//<============================================================================>
//<==============================[GameModeInit]================================>
//<============================================================================>
public OnGameModeInit()
{
    StartSystem();
	AllowInteriorWeapons(1);
    EnableStuntBonusForAll(0);
    DisableInteriorEnterExits();
    SetGameModeText("RealPlay");
    weatherchange();
	Day = TextDrawCreate(520.0,9,"----");
	TextDrawAlignment(Day,1);
	TextDrawBackgroundColor(Day,0x000000ff);
	TextDrawFont(Day,3);
	TextDrawLetterSize(Day,0.6, 1.8);
	TextDrawSetOutline(Day,2);
	TextDrawSetProportional(Day,1);
	TextDrawSetShadow(Day,10);
	Clock = TextDrawCreate(547.0, 23, "--:--");
	TextDrawLetterSize(Clock, 0.6, 1.8);
	TextDrawFont(Clock, 3);
    TextDrawSetOutline(Clock, 2);
	TestDirections = TextDrawCreate(318.000000,23.000000,"Exit and Turn Left");
	TextDrawUseBox(TestDirections,1);
	TextDrawBoxColor(TestDirections,0x00000066);
	TextDrawTextSize(TestDirections,-40.000000,179.000000);
	TextDrawAlignment(TestDirections,2);
	TextDrawBackgroundColor(TestDirections,0x00000066);
	TextDrawFont(TestDirections,2);
	TextDrawLetterSize(TestDirections,0.300000,1.500000);
	TextDrawColor(TestDirections,0xffffffff);
	TextDrawSetProportional(TestDirections,1);
    ConnectNPC("Dave","Tram");
    ConnectNPC("Paul","train_sf");
    ConnectNPC("John","train_lv");
//<============================================================================>
//<========================[Refuel CheckPoints]================================>
//<============================================================================>
	EBrefuel1 	= CreateDynamicCP(-1675.9597, 413.2534, 6.8046, 5.0, -1, -1, -1, 50.0);
//	EBrefuel2 	= CreateDynamicCP(-1682.1747, 419.7523, 6.8046, 3.0, -1, -1, -1, 100.0);
	TSrefuel1 	= CreateDynamicCP(-2029.5737, 156.6294,28.4608, 5.0, -1, -1, -1, 50.0);
//	TSrefuel2 	= CreateDynamicCP(-2022.8242, 156.6181,28.4609, 3.0, -1, -1, -1, 100.0);
	JHrefuel1   = CreateDynamicCP(-2407.5769, 976.2983,45.0060, 5.0, -1, -1, -1, 50.0);
	JHDrivethru = CreateDynamicCP(-2345.1421,1021.2883,50.4044, 5.0, -1, -1, -1, 50.0);
	GDrivethru  = CreateDynamicCP(-2349.3037,-154.8526,35.0294, 5.0, -1, -1, -1, 50.0);
	Test1	    = CreateDynamicCP(-2044.1843, -84.7982,34.8732, 5.0, -1, -1, -1, 200.0);
	Test2	    = CreateDynamicCP(-2238.1963, -67.1287,34.8810, 5.0, -1, -1, -1, 200.0);
	Test3	    = CreateDynamicCP(-2248.9004, 307.4102,34.8732, 5.0, -1, -1, -1, 200.0);
	Test4	    = CreateDynamicCP(-2021.2803, 317.8108,34.7247, 5.0, -1, -1, -1, 200.0);
	Test5	    = CreateDynamicCP(-2000.5637, 713.8871,45.0059, 5.0, -1, -1, -1, 200.0);
	Test6	    = CreateDynamicCP(-2125.9465, 734.0135,69.1182, 5.0, -1, -1, -1, 200.0);
	Test7	    = CreateDynamicCP(-2148.8315, 334.8627,34.8809, 5.0, -1, -1, -1, 200.0);
	Test8	    = CreateDynamicCP(-2155.7466, 124.2557,34.8810, 5.0, -1, -1, -1, 200.0);
	Test9	    = CreateDynamicCP(-2020.3517, 105.9053,27.4059, 5.0, -1, -1, -1, 200.0);
	Test10	    = CreateDynamicCP(-2050.0464, -85.3566,34.8732, 5.0, -1, -1, -1, 200.0);
	Test11	    = CreateDynamicCP(-2020.4857, -94.6159,34.8731, 5.0, -1, -1, -1, 200.0);
//<============================================================================>
//<============================================================================>
//<========================[Creating Gang Storage]=============================>
//<============================================================================>
   	dini_Create("/Gangs/TheLost.ini");
   	dini_Create("/Gangs/Northside.ini");
   	dini_Create("/Gangs/Forelli.ini");
   	dini_Create("/Gangs/Gecko.ini");
   	dini_Create("/Import/Plane.ini");
   	dini_Create("/Import/Truck.ini");
   	dini_Create("/Import/Boat.ini");
   	dini_Create("/Server Logs/Local Chat.ini");
   	dini_Create("/Server Logs/Global Chat.ini");
   	dini_Create("/Server Logs/Police Chat.ini");
   	dini_Create("/Server Logs/Deaths.ini");
//<==================================================================================================================================================>
   	dini_Set("/Gangs/TheLost.ini", "Cash"		 , "1000");
   	dini_Set("/Gangs/TheLost.ini", "Cannabis"	 , "100" );
   	dini_Set("/Gangs/TheLost.ini", "Cocaine" 	 , "25"  );
   	dini_Set("/Gangs/TheLost.ini", "Crack"	  	 , "5"	 );
   	dini_Set("/Gangs/TheLost.ini", "Ecstasy" 	 , "50"  );
   	dini_Set("/Gangs/TheLost.ini", "Firearms"	 , "150" );
   	dini_Set("/Gangs/TheLost.ini", "Kevlar" 	 , "25"  );
   	dini_Set("/Gangs/TheLost.ini", "BIWeed" 	 , "50"  );
   	dini_Set("/Gangs/TheLost.ini", "BIPills" 	 , "50"  );
   	dini_Set("/Gangs/TheLost.ini", "BISniff" 	 , "50"  );
   	dini_Set("/Gangs/TheLost.ini", "BICrack" 	 , "50"  );
   	dini_Set("/Gangs/TheLost.ini", "BIFirearms"  , "1000");
   	dini_Set("/Gangs/TheLost.ini", "BIKevlar"    , "50" );
   	dini_Set("/Gangs/TheLost.ini", "IWeed" 		 , "0"  );
   	dini_Set("/Gangs/TheLost.ini", "IPills"		 , "0"  );
   	dini_Set("/Gangs/TheLost.ini", "ISniff"		 , "0"  );
   	dini_Set("/Gangs/TheLost.ini", "ICrack"		 , "0"  );
   	dini_Set("/Gangs/TheLost.ini", "IFirearms"	 , "0"	);
   	dini_Set("/Gangs/TheLost.ini", "IKevlar"  	 , "0"	);
   	dini_Set("/Gangs/TheLost.ini", "Bigimported" , "0"   );
   	dini_Set("/Gangs/TheLost.ini", "Northside"   , "Neutral");
   	dini_Set("/Gangs/TheLost.ini", "Forelli"     , "Neutral");
   	dini_Set("/Gangs/TheLost.ini", "Gecko"     , "Neutral");
//<==================================================================================================================================================>
   	dini_Set("/Gangs/Gecko.ini", "Cash"		 , "1000");
   	dini_Set("/Gangs/Gecko.ini", "Cannabis"	 , "100" );
   	dini_Set("/Gangs/Gecko.ini", "Cocaine" 	 , "25"  );
   	dini_Set("/Gangs/Gecko.ini", "Crack"	  	 , "5"	 );
   	dini_Set("/Gangs/Gecko.ini", "Ecstasy" 	 , "50"  );
   	dini_Set("/Gangs/Gecko.ini", "Firearms"	 , "150" );
   	dini_Set("/Gangs/Gecko.ini", "Kevlar" 	 , "25"  );
   	dini_Set("/Gangs/Gecko.ini", "BIWeed" 	 , "50"  );
   	dini_Set("/Gangs/Gecko.ini", "BIPills" 	 , "50"  );
   	dini_Set("/Gangs/Gecko.ini", "BISniff" 	 , "50"  );
   	dini_Set("/Gangs/Gecko.ini", "BICrack" 	 , "50"  );
   	dini_Set("/Gangs/Gecko.ini", "BIFirearms"  , "1000");
   	dini_Set("/Gangs/Gecko.ini", "BIKevlar"    , "50"  );
   	dini_Set("/Gangs/Gecko.ini", "IWeed" 		 , "0"  );
   	dini_Set("/Gangs/Gecko.ini", "IPills"		 , "0"  );
   	dini_Set("/Gangs/Gecko.ini", "ISniff"		 , "0"  );
   	dini_Set("/Gangs/Gecko.ini", "ICrack"		 , "0"  );
   	dini_Set("/Gangs/Gecko.ini", "IFirearms"	 , "0"	);
   	dini_Set("/Gangs/Gecko.ini", "IKevlar"  	 , "0"	);
   	dini_Set("/Gangs/Gecko.ini", "Bigimported" , "0"   );
   	dini_Set("/Gangs/Gecko.ini", "Bigimported" , "0"   );
   	dini_Set("/Gangs/Gecko.ini", "Northside"   , "Neutral");
   	dini_Set("/Gangs/Gecko.ini", "Forelli"     , "Neutral");
   	dini_Set("/Gangs/Gecko.ini", "TheLost" , "Neutral");
//<==================================================================================================================================================>
   	dini_Set("/Gangs/Northside.ini"	, "Cash"		 , "1000");
   	dini_Set("/Gangs/Northside.ini"	, "Cannabis"	 , "100" );
   	dini_Set("/Gangs/Northside.ini"	, "Cocaine" 	 , "25"  );
   	dini_Set("/Gangs/Northside.ini"	, "Crack"	  	 , "5"	 );
   	dini_Set("/Gangs/Northside.ini"	, "Ecstasy" 	 , "50"  );
   	dini_Set("/Gangs/Northside.ini"	, "Firearms"	 , "150" );
   	dini_Set("/Gangs/Northside.ini"	, "Kevlar" 	 	 , "25"  );
   	dini_Set("/Gangs/Northside.ini"	, "BIWeed" 	 	 , "50"  );
   	dini_Set("/Gangs/Northside.ini"	, "BIPills" 	 , "50"  );
   	dini_Set("/Gangs/Northside.ini"	, "BISniff" 	 , "50"  );
   	dini_Set("/Gangs/Northside.ini"	, "BICrack" 	 , "50"  );
   	dini_Set("/Gangs/Northside.ini"	, "BIFirearms"   , "50"  );
   	dini_Set("/Gangs/Northside.ini"	, "BIKevlar"     , "50"  );
   	dini_Set("/Gangs/Northside.ini" , "IWeed" 		 , "0"  );
   	dini_Set("/Gangs/Northside.ini" , "IPills"		 , "0"  );
   	dini_Set("/Gangs/Northside.ini" , "ISniff"		 , "0"  );
   	dini_Set("/Gangs/Northside.ini" , "ICrack"		 , "0"  );
   	dini_Set("/Gangs/Northside.ini" , "IFirearms"	 , "0"	);
   	dini_Set("/Gangs/Northside.ini" , "IKevlar"  	 , "0"	);
   	dini_Set("/Gangs/Northside.ini"	, "Bigimported"  , "0"   );
   	dini_Set("/Gangs/Northside.ini" , "TheLost"  , "Neutral");
   	dini_Set("/Gangs/Northside.ini" , "Forelli"      , "Neutral");
   	dini_Set("/Gangs/Northside.ini" , "Gecko"      , "Neutral");
   	dini_Set("/Gangs/Forelli.ini"	, "Cash"         , "1000");
   	dini_Set("/Gangs/Forelli.ini"	, "Cannabis"	 , "100" );
   	dini_Set("/Gangs/Forelli.ini"	, "Cocaine" 	 , "25"  );
   	dini_Set("/Gangs/Forelli.ini"	, "Crack"	  	 , "5"	 );
   	dini_Set("/Gangs/Forelli.ini"	, "Ecstasy" 	 , "50"  );
   	dini_Set("/Gangs/Forelli.ini"	, "Firearms"	 , "150" );
   	dini_Set("/Gangs/Forelli.ini"   , "Kevlar" 	 	 , "25"  );
   	dini_Set("/Gangs/Forelli.ini"	, "BIWeed" 	 	 , "50"  );
   	dini_Set("/Gangs/Forelli.ini"	, "BIPills" 	 , "50"  );
   	dini_Set("/Gangs/Forelli.ini"	, "BISniff" 	 , "50"  );
   	dini_Set("/Gangs/Forelli.ini"	, "BICrack" 	 , "50"  );
   	dini_Set("/Gangs/Forelli.ini"	, "BIFirearms"   , "1000");
   	dini_Set("/Gangs/Forelli.ini"	, "BIKevlar"     , "50  ");
   	dini_Set("/Gangs/Forelli.ini" 	, "IWeed" 		 , "0"   );
   	dini_Set("/Gangs/Forelli.ini" 	, "IPills"		 , "0"   );
   	dini_Set("/Gangs/Forelli.ini" 	, "ISniff"		 , "0"   );
   	dini_Set("/Gangs/Forelli.ini" 	, "ICrack"		 , "0"   );
   	dini_Set("/Gangs/Forelli.ini" 	, "IFirearms"	 , "0"	 );
   	dini_Set("/Gangs/Forelli.ini" 	, "IKevlar"  	 , "0"	 );
   	dini_Set("/Gangs/Forelli.ini"	, "Bigimported"  , "0"   );
   	dini_Set("/Gangs/Forelli.ini"   , "TheLost"  , "Neutral");
   	dini_Set("/Gangs/Forelli.ini"   , "Northside"    , "Neutral");
   	dini_Set("/Gangs/Forelli.ini"   , "Gecko"      , "Neutral");
//<============================================================================>
   	dini_Set("/Import/Plane.ini"	, "Cannabis"	 , "0" );
   	dini_Set("/Import/Plane.ini"	, "Cocaine" 	 , "0"  );
   	dini_Set("/Import/Plane.ini"	, "Crack"	  	 , "0"	 );
   	dini_Set("/Import/Plane.ini"	, "Ecstasy" 	 , "0"  );
   	dini_Set("/Import/Plane.ini"	, "Firearms"	 , "0" );
   	dini_Set("/Import/Plane.ini"    , "Kevlar" 	 	 , "0"  );
//<============================================================================>
   	dini_Set("/Import/Truck.ini"	, "Cannabis"	 , "0" );
   	dini_Set("/Import/Truck.ini"	, "Cocaine" 	 , "0"  );
   	dini_Set("/Import/Truck.ini"	, "Crack"	  	 , "0"	 );
   	dini_Set("/Import/Truck.ini"	, "Ecstasy" 	 , "0"  );
   	dini_Set("/Import/Truck.ini"	, "Firearms"	 , "0" );
   	dini_Set("/Import/Truck.ini"    , "Kevlar" 	 	 , "0"  );
//<============================================================================>
   	dini_Set("/Import/Boat.ini"		, "Cannabis"	 , "0" );
   	dini_Set("/Import/Boat.ini"		, "Cocaine" 	 , "0"  );
   	dini_Set("/Import/Boat.ini"		, "Crack"	  	 , "0"	 );
   	dini_Set("/Import/Boat.ini"		, "Ecstasy" 	 , "0"  );
   	dini_Set("/Import/Boat.ini"		, "Firearms"	 , "0" );
   	dini_Set("/Import/Boat.ini"     , "Kevlar" 	 	 , "0"  );
//<============================================================================>
//<============================================================================>
//<==========================[Adding Player Skins]=============================>
//<============================================================================>
    AddPlayerClass(259,-2193.3188,289.4814,35.3203,0.3251,0,0,0,0,0,0);
	AddPlayerClass(101,-2193.3188,289.4814,35.3203,0.3251,0,0,0,0,0,0);
	AddPlayerClass(170,-2193.3188,289.4814,35.3203,0.3251,0,0,0,0,0,0);
	AddPlayerClass(26 ,-2193.3188,289.4814,35.3203,0.3251,0,0,0,0,0,0);
	AddPlayerClass(180,-2193.3188,289.4814,35.3203,0.3251,0,0,0,0,0,0);
	AddPlayerClass(100,-2193.3188,289.4814,35.3203,0.3251,0,0,0,0,0,0);
	AddPlayerClass(188,-2193.3188,289.4814,35.3203,0.3251,0,0,0,0,0,0);
	AddPlayerClass(158,-2193.3188,289.4814,35.3203,0.3251,0,0,0,0,0,0);
	AddPlayerClass(264,-2193.3188,289.4814,35.3203,0.3251,0,0,0,0,0,0);
	AddPlayerClass(29 ,-2193.3188,289.4814,35.3203,0.3251,0,0,0,0,0,0);
	AddPlayerClass(94 ,-2193.3188,289.4814,35.3203,0.3251,0,0,0,0,0,0);
	AddPlayerClass(213,-2193.3188,289.4814,35.3203,0.3251,0,0,0,0,0,0);
	AddPlayerClass(206,-2193.3188,289.4814,35.3203,0.3251,0,0,0,0,0,0);
	AddPlayerClass(21 ,-2193.3188,289.4814,35.3203,0.3251,0,0,0,0,0,0);
	AddPlayerClass(19 ,-2193.3188,289.4814,35.3203,0.3251,0,0,0,0,0,0);
	AddPlayerClass(184,-2193.3188,289.4814,35.3203,0.3251,0,0,0,0,0,0);
	AddPlayerClass(263,-2193.3188,289.4814,35.3203,0.3251,0,0,0,0,0,0);
	AddPlayerClass(259,-2193.3188,289.4814,35.3203,0.3251,0,0,0,0,0,0);
	AddPlayerClass(20 ,-2193.3188,289.4814,35.3203,0.3251,0,0,0,0,0,0);
	AddPlayerClass(22 ,-2193.3188,289.4814,35.3203,0.3251,0,0,0,0,0,0);
	AddPlayerClass(223,-2193.3188,289.4814,35.3203,0.3251,0,0,0,0,0,0);
	AddPlayerClass(227,-2193.3188,289.4814,35.3203,0.3251,0,0,0,0,0,0);
	AddPlayerClass(24 ,-2193.3188,289.4814,35.3203,0.3251,0,0,0,0,0,0);
	AddPlayerClass(25 ,-2193.3188,289.4814,35.3203,0.3251,0,0,0,0,0,0);
	AddPlayerClass(240,-2193.3188,289.4814,35.3203,0.3251,0,0,0,0,0,0);
	AddPlayerClass(28 ,-2193.3188,289.4814,35.3203,0.3251,0,0,0,0,0,0);
	AddPlayerClass(41 ,-2193.3188,289.4814,35.3203,0.3251,0,0,0,0,0,0);
	AddPlayerClass(56 ,-2193.3188,289.4814,35.3203,0.3251,0,0,0,0,0,0);
	AddPlayerClass(98 ,-2193.3188,289.4814,35.3203,0.3251,0,0,0,0,0,0);
	AddPlayerClass(95 ,-2193.3188,289.4814,35.3203,0.3251,0,0,0,0,0,0);
	AddPlayerClass(55 ,-2193.3188,289.4814,35.3203,0.3251,0,0,0,0,0,0);
	AddPlayerClass(72 ,-2193.3188,289.4814,35.3203,0.3251,0,0,0,0,0,0);
	AddPlayerClass(7  ,-2193.3188,289.4814,35.3203,0.3251,0,0,0,0,0,0);
	AddPlayerClass(233,-2193.3188,289.4814,35.3203,0.3251,0,0,0,0,0,0);
	AddPlayerClass(67 ,-2193.3188,289.4814,35.3203,0.3251,0,0,0,0,0,0);
	AddPlayerClass(60 ,-2193.3188,289.4814,35.3203,0.3251,0,0,0,0,0,0);
	AddPlayerClass(46 ,-2193.3188,289.4814,35.3203,0.3251,0,0,0,0,0,0);
	AddPlayerClass(37 ,-2193.3188,289.4814,35.3203,0.3251,0,0,0,0,0,0);
	AddPlayerClass(226,-2193.3188,289.4814,35.3203,0.3251,0,0,0,0,0,0);
	AddPlayerClass(12 ,-2193.3188,289.4814,35.3203,0.3251,0,0,0,0,0,0);
//<============================================================================>
//<============================================================================>
//<============================================================================>
//<===========================[Adding Vehicles]================================>
//<============================================================================>
//=============================[Civilian Cars]==================================
	Civi1 = AddStaticVehicleEx(508, -2235.51  ,293.83  ,35.49  ,359.60  ,90 , 3,600); // Journey
	Civi2 = AddStaticVehicleEx(466, -2167.1702,294.2055,34.9209,2.6872  ,71 ,90,600); // Glendale
	Civi3 = AddStaticVehicleEx(479, -2171.4482,293.6299,34.9224,359.8894,30 ,60,600); // Regina
	Civi4 = AddStaticVehicleEx(445, -2231.16  ,306.45  ,34.99  ,179.26  ,122,90,600); // Admiral
	Civi5 = AddStaticVehicleEx(479, -2162.9170,306.2026,34.9213,181.5363,4  , 0,600); // Regina
	Civi6 = AddStaticVehicleEx(404, -2167.5022,305.9372,34.9212,182.0892,69 ,90,600); // Perenial
	Civi7 = AddStaticVehicleEx(516, -2223.21  ,305.86  ,34.95  ,178.26  ,103,90,600); // Nebula
    Civi8 = AddStaticVehicleEx(458, -2175.7771,305.7611,34.9233,180.0073,53 ,90,600); // Solair
	Civi9 = AddStaticVehicleEx(445, -2214.25  ,293.56  ,34.99  ,0.36    ,119, 0,600); // Admiral
	Civi10 = AddStaticVehicleEx(462, -2209.61  ,292.46  ,34.70  ,359.72  ,126, 0,600); // Faggio
	Civi11 = AddStaticVehicleEx(404, -2167.5022,305.9372,34.9212,182.0892,69 ,90,600); // Perenial
	Civi12 = AddStaticVehicleEx(400, -2180.08  ,293.15  ,34.99  ,359.90  ,36 ,84,600); // Landstalker
	Civi13 = AddStaticVehicleEx(546, -2196.90  ,293.49  ,34.99  ,357.50  ,3  , 0,600); // Intruder
//==================================[CarParks]==================================
	Civi14 = AddStaticVehicleEx(404,-2455.8813,741.5334,34.7498,359.4704,19,13,600);// Perrenial    (24/7)
    Civi15 = AddStaticVehicleEx(479,-2420.9495,741.5356,34.8115,0.3914  ,23,45,600);// Regina       (24/7)
    Civi16 = AddStaticVehicleEx(585,-2407.7810,741.8038,34.7948,0.6174  ,15,8 ,600);// Emperor      (24/7)
    Civi17 = AddStaticVehicleEx(418,-2490.6045,741.6179,34.9456,179.3376,4 ,4 ,600);// Moonbeam     (24/7)
    Civi18 = AddStaticVehicleEx(422,-2429.5500,741.8349,35.0972,359.9526,1 ,13,600);// Bobcat       (24/7)
    Civi19 = AddStaticVehicleEx(404,-2572.6462,632.4944,14.5519,270.7061,55,27,600);// Perrenial  (Hospital)
    Civi20 = AddStaticVehicleEx(400,-2589.5403,647.7088,14.3356,270.4944,76,66,600);// Landstalker(Hospital)
    Civi21 = AddStaticVehicleEx(466,-2589.1121,626.9944,14.3342,87.1501 ,30,89,600);// Glendale   (Hospital)
    Civi22 = AddStaticVehicleEx(466,-2629.3899,1333.9226,6.9395,358.7212,76,66,600); // Glendale Civ Car
//=====================================[Taxi's]=================================
    taxi1 = AddStaticVehicleEx(420,-1633.8743,1293.9457,6.8105,315.0458,6,6,600); // Taxi
    taxi2 = AddStaticVehicleEx(420,-1644.7050,1304.4891,6.8077,315.5268,6,6,600); // Taxi
    taxi3 = AddStaticVehicleEx(420,-1648.3721,1308.0354,6.8095,314.9257,6,6,600); // Taxi
    taxi4 = AddStaticVehicleEx(420,-1651.7747,1311.7744,6.8163,315.0937,6,6,600); // Taxi
	taxi5 = AddStaticVehicleEx(438,-1630.6665,1290.1787,7.0437,314.0649,6,6,600); // Cabbie
    taxi6 = AddStaticVehicleEx(438,-1637.5597,1297.1840,7.0397,316.2944,6,6,600); // Cabbie
    taxi7 = AddStaticVehicleEx(438,-1641.2369,1300.6508,7.0341,315.3490,6,6,600); // Cabbie
    taxi8 = AddStaticVehicleEx(438,-1655.3031,1315.4031,7.0448,315.7346,6,6,600); // Cabbie
//===================================[Tow Trucks]===============================
    tow1 = AddStaticVehicleEx(525,-2151.9548,-164.9832,35.1974,179.8180,0,3,600); // Tow Truck
	tow2 = AddStaticVehicleEx(525,-2143.6467,-164.6079,35.1975,180.8502,0,3,600); // Tow Truck
	tow3 = AddStaticVehicleEx(525,-2135.8872,-164.5229,35.1941,178.6310,0,3,600); // Tow Truck
	tow4 = AddStaticVehicleEx(525,-2128.0083,-164.5576,35.1978,182.6858,0,3,600); // Tow Truck
//==================================[Police Cars]===============================
	cop1 = AddStaticVehicleEx(597,-1611.9727,673.5441,6.9626,181.6085 ,0,1  ,600);  // Squad Car
	cop2 = AddStaticVehicleEx(597,-1594.2646,672.5800,6.9626,176.7416 ,0,1  ,600);  // Squad Car
	cop3 = AddStaticVehicleEx(597,-1593.5822,652.3950,6.9626,1.3140   ,0,1  ,600);  // Squad Car
	cop4 = AddStaticVehicleEx(597,-1616.7960,652.6038,6.9626,0.6196   ,0,1  ,600);  // Squad Car
    cop5 = AddStaticVehicleEx(597,-1628.7367,652.5331,6.9726,0.8455   ,0,1  ,600);  // Squad Car
	cop6 = AddStaticVehicleEx(597,-1636.6252,665.9559,6.9551,267.9916 ,0,1  ,600);  // Squad Car
	cop7 = AddStaticVehicleEx(597,-1604.9026,652.2119,6.9549,4.7139   ,0,1  ,600);  // Squad Car
	cop8 = AddStaticVehicleEx(597,-1588.0156,749.3253,-5.4742,179.6581,0,1  ,600);  // Squad Car
    cop9 = AddStaticVehicleEx(597,-1596.2563,676.1544,-5.4713,0.8785  ,0,1  ,600);  // Squad Car
    cop10 = AddStaticVehicleEx(597,-1628.8418,693.5616,-5.4719,359.3611,0,1  ,600); // Squad Car
    cop11 = AddStaticVehicleEx(597,-1639.8674,686.3918,-5.4722,270.4180,0,1  ,600); // Squad Car
    cop12 = AddStaticVehicleEx(597,-1639.4340,674.2276,-5.4718,269.5993,0,1  ,600); // Squad Car
	cop13 = AddStaticVehicleEx(599,-1612.4427,732.1093,-5.0449,0.5518  ,0,1  ,600); // Ranger
    cop14 = AddStaticVehicleEx(599,-1616.4747,732.1329,-5.0425,359.4299,0,1  ,600); // Ranger
    cop15 = AddStaticVehicleEx(523,-1571.9991,742.8528,-5.6806,87.4612 ,0,1  ,600); // Police Bike
    cop16 = AddStaticVehicleEx(523,-1571.8107,738.5320,-5.6831,92.8608 ,0,1  ,600); // Police Bike
    cop17 = AddStaticVehicleEx(497,-1680.1018,705.8478,30.7789,89.6927 ,0,1  ,600); // Police helicopter
	cop18 = AddStaticVehicleEx(427,-1638.8472,665.8060,-5.1145,271.4060,0,0,600); // S.W.A.T Enforcer
	cop19 = AddStaticVehicleEx(490,-1639.7255,661.9507,-5.1024,270.9244,0,0,600); // S.W.A.T Rancher
	cop20 = AddStaticVehicleEx(597,-1639.4633,657.6455,-5.4978,268.0616,0,0,600); // S.W.A.T Black Squad Car
	cop21 = AddStaticVehicleEx(597,-1639.1738,653.5500,-5.4724,270.6938,0,0,600); // S.W.A.T Black Squad Car
	cop22 = AddStaticVehicleEx(551,-1638.9448,649.7891,-5.4465,270.0314,0,0,600); // S.W.A.T Undercover Car
	cop23 = AddStaticVehicleEx(528,-1623.6002,649.9561,-5.1825,87.1084 ,0,0,600); // S.W.A.T FBI Truck
	cop24 = AddStaticVehicleEx(601,-1622.2554,653.6188,-5.4741,89.3824 ,0,0,600); // S.W.A.T Riot Control
	cop25 = AddStaticVehicleEx(430,-1476.9624,691.8842,-0.2647,180.0807,0,0,600); // Police Boat
	cop26 = AddStaticVehicleEx(415,-1600.1458,676.3489,-5.4717,359.3918,0,1,600); // Pursuit Vehicle (Cheetah)
	cop27 = AddStaticVehicleEx(559,-1612.5770,693.3307,-5.5859,179.6547,0,0,600); // Pursuit Vehicle (Jester)
//===================================[Fire Trucks]==============================
	fire1 = AddStaticVehicleEx(407,-2021.1760,93.0163,28.2432,271.6491,3,3,600); // Firetruck
	fire2 = AddStaticVehicleEx(407,-2020.9305,75.4216,27.8054,275.1901,3,3,600); // Firetruck
//===================================[Ambulances]===============================
    Ambul1 = AddStaticVehicleEx(416,-2543.074951,587.099121,14.604763,270.104522,1,3,600);// Ambulance
    Ambul2 = AddStaticVehicleEx(416,-2543.088134,592.883239,14.602507,269.871795,1,3,600);// Ambulance
    Ambul3 = AddStaticVehicleEx(416,-2543.137695,599.084045,14.602451,274.979431,1,3,600);// Ambulance
    Ambul4 = AddStaticVehicleEx(416,-2543.085937,604.738464,14.602303,274.979431,1,3,600);// Ambulance
    Ambul5 = AddStaticVehicleEx(416,-2543.000000,610.570617,14.602396,274.979431,1,3,600);// Ambulance
	Ambul6 = AddStaticVehicleEx(563,-2675.2112	,532.0216  ,52.0141  ,268.5703  ,1,3,600);// Raindancer
//======================================[Forelli]================================
	Forelli1 = AddStaticVehicleEx(474,-2272.4592,2285.4480,4.5851,269.9830,0,0,600);// Mafia Hermes
	Forelli2 = AddStaticVehicleEx(474,-2252.6165,2291.0605,4.5811,90.4697,0,0,600); // Mafia Hermes
	Forelli3 = AddStaticVehicleEx(566,-2252.2427,2297.1438,4.5951,89.8702,0,0,600); // Mafia Tahoma
	Forelli4 = AddStaticVehicleEx(566,-2252.1824,2305.9556,4.5949,90.3983,0,0,600); // Mafia Tahoma
	Forelli5 = AddStaticVehicleEx(579,-2272.2046,2297.4243,4.7467,89.8654,0,0,600); // Mafia Huntley
	Forelli6 = AddStaticVehicleEx(579,-2271.9285,2306.4224,4.7557,89.9882,0,0,600); // Mafia Huntley
	Forelli7 = AddStaticVehicleEx(534,-2252.2959,2314.9604,4.5362,89.6441,0,0,600); // Mafia Remington
	Forelli8 = AddStaticVehicleEx(534,-2271.9995,2315.3115,4.5445,270.0947,0,0,600);// Mafia Remington
	Forelli9 = AddStaticVehicleEx(409,-2285.3638,2283.4929,4.7677,274.0386,0,0,600);// Mafia Limo
	Forelli10= AddStaticVehicleEx(409,-2285.5276,2284.2180,4.7740,269.6831,0,0,600);// Mafia Limo
	Forelli11= AddStaticVehicleEx(413,-2252.2925,2285.0603,4.9043,89.3485,0,0,600); // Mafia Pony
//======================================[Forelli]================================
	Gecko1  = AddStaticVehicleEx(560,-1950.9915,-2426.6401,30.3239,223.8087,98,0,600); // Gecko Sultan
	Gecko2  = AddStaticVehicleEx(551,-1947.1735,-2423.9104,30.4340,222.2937,98,0,600); // Gecko Merit
	Gecko3  = AddStaticVehicleEx(296,-1936.7159,-2431.7356,31.1829,95.6002 ,98,0,600); // Gecko Huntley
	Gecko4  = AddStaticVehicleEx(566,-1955.3062,-2454.8291,30.4424,46.6683 ,98,0,600); // Gecko Tahoma
	Gecko5  = AddStaticVehicleEx(566,-1960.2284,-2460.7512,30.4484,49.8434 ,98,0,600); // Gecko Tahoma
	Gecko6  = AddStaticVehicleEx(579,-1968.5653,-2430.9436,30.5393,184.7956,98,0,600); // Gecko Huntley
	Gecko7  = AddStaticVehicleEx(426,-1991.5537,-2435.1743,30.3803,81.4548 ,98,0,600); // Gecko Premier
	Gecko8  = AddStaticVehicleEx(426,-2001.1486,-2425.3804,30.3786,192.3915,98,0,600); // Gecko Premier
	Gecko9  = AddStaticVehicleEx(551,-1990.5157,-2424.2231,30.4363,135.7023,98,0,600); // Gecko Merit
	Gecko10 = AddStaticVehicleEx(413,-1959.5181,-2442.1772,30.7175,93.2597 ,98,0,600); // Gecko Pony
//================================[Nortside Hustlers]===========================
	north1 = AddStaticVehicleEx(575,-2618.83,1377.43,6.72,180.0 ,157,157,600); // Broadway
    north2 = AddStaticVehicleEx(575,-2632.80,1377.53,6.71,180.0 ,157,157,600); // Broadway
   	north3 = AddStaticVehicleEx(533,-2625.81,1377.81,6.87,180.0 ,157,157,600); // Feltzer
	north4 = AddStaticVehicleEx(533,-2639.03,1377.91,6.85,180.0 ,157,157,600); // Feltzer
	north5 = AddStaticVehicleEx(409,-2618.56,1418.31,6.90,180.53,157,157,600); // Stretch
	north6 = AddStaticVehicleEx(413,-2645.21,1377.83  ,7.24,0.63 ,157,157,600); // Pony
	north7 = AddStaticVehicleEx(567,-2646.1533,1333.3159,7.0472,0.4864,157,157,600); // Northside Savannah
	north8 = AddStaticVehicleEx(567,-2620.6348,1343.8583,7.0910,226.1721,157,157,600); // Northside Savannah
	AddVehicleComponent(north1,1078);
	AddVehicleComponent(north2,1078);
	AddVehicleComponent(north3,1078);
	AddVehicleComponent(north4,1078);
	AddVehicleComponent(north5,1078);
	AddVehicleComponent(north7,1078);
	AddVehicleComponent(north8,1078);
//=================================[Bikers Bike Spawns]=========================
	Biker1 = AddStaticVehicleEx(468,-2223.18,-143.96,34.83,353.27       ,36,0 ,600); // Sanchez
	Biker2 = AddStaticVehicleEx(468,-2226.13,-143.82,34.85,357.73       ,36,0 ,600); // Sanchez
    Biker3 = AddStaticVehicleEx(463,-2247.1023,-84.8188,34.7117,358.7345,36,0 ,600); // Freeway
	Biker4 = AddStaticVehicleEx(463,-2247.1890,-88.7307,34.7117,358.7344,36,0 ,600); // Freeway
	Biker5 = AddStaticVehicleEx(463,-2247.2703,-92.4017,34.7124,358.7344,36,0 ,600); // Freeway
	Biker6 = AddStaticVehicleEx(463,-2247.3660,-96.7314,34.7122,358.7345,36,0 ,600); // Freeway
	Biker7 = AddStaticVehicleEx(482,-2211.0125,-115.2953,35.4035,89.4935,36,24,600); // Burrito
	Biker8 = AddStaticVehicleEx(434,-2219.7874,-145.1915,35.2882,359.7216,36,24,600);// TheLost Hotknife
	Biker9 = AddStaticVehicleEx(434,-2215.9048,-144.8135,35.3015,0.9808,36,24,600);  // TheLost Hotknife
//===================================[Pizza Vehicles]===========================
    pizza1 = AddStaticVehicleEx(448,-1804.8842,954.2332,24.4901,271.1463,3,6,600); // pizza bikes
    pizza2 = AddStaticVehicleEx(448,-1804.7678,952.2726,24.4898,265.8327,3,6,600); // pizza bikes
    pizza3 = AddStaticVehicleEx(448,-1804.8700,950.6819,24.4766,274.8791,3,6,600); // pizza bikes
    pizza4 = AddStaticVehicleEx(448,-1816.9285,942.1127,24.4687,180.8454,3,6,600); // pizza bikes
    pizza5 = AddStaticVehicleEx(448,-1815.2386,942.1780,24.4598,180.5993,3,6,600); // pizza bikes
    pizza6 = AddStaticVehicleEx(448,-1813.5236,942.0269,24.4506,177.4339,3,6,600); // pizza bikes
//=====================================[Wang Cars]==============================
    Wango1 = AddStaticVehicleEx(483,-1989.0042,275.6362,35.1530, 60.8862,0,  0,600);  // Hippy Van
    Wango2 = AddStaticVehicleEx(549,-1990.3721,270.1722,34.8748, 86.5489,4,  4,600);  // Tampa
    Wango3 = AddStaticVehicleEx(400,-1991.5681,263.8760,35.2677, 87.6833,119,0,600);  // Landstalker
	Wango4 = AddStaticVehicleEx(600,-1990.9050,257.1778,34.8932, 84.9093,0,  0,600);  // Picador
	Wango5 = AddStaticVehicleEx(542,-1992.1013,250.3336,34.9426, 85.4377,41,41,600);  // Clover
	Wango6 = AddStaticVehicleEx(508,-1993.2509,241.6786,35.5606,130.3178,1,  0,600);  // Journey
	Wango7 = AddStaticVehicleEx(494,-1986.3861,303.9937,35.0710,131.6466,116,0,600);  // Hotring
	Wang1  = AddStaticVehicle(418,-1944.3022,274.7121,35.5776,136.2730,54,0); // Moonbeam
	Wang2  = AddStaticVehicle(445,-1944.8452,264.9106,35.3404, 91.3891,30,0); // Admiral
	Wang3  = AddStaticVehicle(467,-1946.6173,256.2777,35.2220, 49.7489, 5,1); // Oceanic
	Wang4  = AddStaticVehicle(405,-1954.1539,256.1392,35.3487,359.9507,55,0); // Sentinel
	Wang5  = AddStaticVehicle(579,-1961.4221,257.2592,35.4050,315.3317, 3,0); // Huntley
	Wang6  = AddStaticVehicle(421,-1962.5509,273.7001,35.3547,207.7041,51,0); // Washington
	Wang7  = AddStaticVehicle(439,-1945.1647,274.1268,40.9419,139.9122, 3,0); // Stallion
	Wang8  = AddStaticVehicle(470,-1945.5297,257.2392,41.0437, 43.1750, 0,0); // Patriot
	Wang9  = AddStaticVehicle(474,-1955.3568,256.2511,40.8118,328.2082,45,0); // Hermes
	Wang0  = AddStaticVehicle(567,-1954.3992,299.8138,40.9148,181.3863,86,0); // Savannah
//==============================================================================
	ChangeVehiclePaintjob(Wango1, 0);
//===================================[Otto's Autos]=============================
    otto1 = AddStaticVehicleEx(402,-1665.1106,1223.1274,20.9896,185.3043,34,0,600); // Buffalo
    otto2 = AddStaticVehicleEx(477,-1667.6086,1205.8601,20.9145,286.1880,3,0,600);  // ZR-350
    otto3 = AddStaticVehicleEx(411,-1655.9354,1204.9839,20.8812,28.9418 ,0,0,600);  // Infernus
    otto4 = AddStaticVehicleEx(559,-1647.2308,1206.2374,20.8125,30.7664 ,16,0,600); // Jester
    otto5 = AddStaticVehicleEx(560,-1664.7313,1224.0365,13.3852,248.0653,103,0,600);// Sultan
    otto6 = AddStaticVehicleEx(580,-1647.1161,1205.6053,13.4743,357.4146,77,0,600); // Stafford
    otto7 = AddStaticVehicleEx(475,-1662.2135,1210.9286,13.4840,307.9904,6,0,600);  // Sabre
    otto8 = AddStaticVehicleEx(565,-1679.0052,1208.4446,13.3000,250.9336,12,0,600); // Flash
//===================================[Driving School]=============================
    dsa1 = AddStaticVehicle(445,-2064.3672,-84.2723,35.0391,359.7130,0,0);         // Admiral
    dsa2 = AddStaticVehicle(445,-2081.2468,-84.1585,35.0391,358.6696,0,0);         // Admiral
//================================[Black Markets]===============================
	blackmark1 = AddStaticVehicleEx(413,-2206.6931,-20.1371,35.3862,183.0809,0,0,600); // Black Market (Garcia)
	blackmark2 = AddStaticVehicleEx(413,-1720.2157,-20.5427, 3.6404,167.3314,0,0,600); // Black Market (Easter Basin)
//==================================[SF Airport]================================
	pilot1	   = AddStaticVehicleEx(407,-1256.4138,65.4977,14.3837,45.6199,1,3,600); 	// position of firetrucks at airport
	pilot2	   = AddStaticVehicleEx(407,-1259.5186,61.3161,14.3834,44.8369,1,3,600); 	// position of firetrucks at airport
	pilot3	   = AddStaticVehicleEx(592,-1255.5455,-106.0180,15.3435,136.6108,1,3,600); 	// position of andromeda at sf air
	pilot4	   = AddStaticVehicleEx(592,-1211.8643,-149.4748,15.3443,136.1659,1,2,600); 	// position of the other andromeda at sf air
	pilot5	   = AddStaticVehicleEx(519,-1362.0784,-495.4224,15.0939,207.7085,1,6,600); 	// position of shamal
	pilot6     = AddStaticVehicleEx(487,-1225.7095,-9.4977,14.3250,46.0032,1,8,600); 	// position of maverick
	pilot7	   = AddStaticVehicleEx(417,-1189.7284,25.5746,14.2862,51.5343,1,1,600); 	// position of leviathan
	pilot8	   = AddStaticVehicleEx(519,-1438.3159,-529.1438,15.0940,207.1161,1,6,600);  // position of the other shamal
	AddStaticVehicleEx(577,-1370.4169,-220.8457,14.0622,149.3344,1,5,600); 	// position of AT-400
	AddStaticVehicleEx(577,-1325.4911,-258.1450,14.0637,126.9970,1,78,600); 		// position of the 2nd AT-400
//====================================[Church]==================================
	church1    = AddStaticVehicleEx(442,-2057.7627,1105.7463,53.1195,269.0670,0,0,600); // Church Romero
	church2    = AddStaticVehicleEx(405,-2058.0164,1109.5166,53.1655,270.9036,0,0,600); // Church Sentinel
	church3    = AddStaticVehicleEx(405,-2058.2026,1113.3282,53.1649,272.3736,0,0,600); // Church Sentinel
	church4    = AddStaticVehicleEx(442,-2057.7839,1118.1797,53.1251,271.9983,0,0,600); // Church Romero
	church5    = AddStaticVehicleEx(409,-2038.8424,1126.3495,53.0653,180.4483,0,0,600); // Church Stretch
	church6    = AddStaticVehicleEx(575,-2039.5145,1113.7698,52.8913, 91.8927,1,0,600); // Church Broadway
	church7    = AddStaticVehicleEx(580,-2038.9758,1106.3325,53.1056, 86.2247,1,0,600); // Church Stafford
//=====================================[Bus]====================================
	Busjob1	   = AddStaticVehicleEx(431,-2692.8418,-24.8755,4.4389,179.9875,0,108,600); // BUS1
	Busjob2	   = AddStaticVehicleEx(431,-2686.4304,-24.8277,4.4406,181.3768,0,108,600); // BUS2
	Busjob3	   = AddStaticVehicleEx(431,-2682.7249,-24.7936,4.4040,179.4492,0,108,600); // BUS3
	Busjob4	   = AddStaticVehicleEx(431,-2676.1526,-24.7558,4.4441,180.4549,0,108,600); // BUS4
	Busjob5	   = AddStaticVehicleEx(437,-2617.4602,-24.4908,4.4620,180.6003,0,108,600); // coach 1
	Busjob6	   = AddStaticVehicleEx(437,-2621.1047,-24.5643,4.4422,179.8984,0,108,600); // coach 2
//===================================[Bus Car]==================================
	Buscar1	   = AddStaticVehicleEx(401,-2633.2820,-55.2481,4.1222,181.6251,0,82,600); // buscar 1
	Buscar2	   = AddStaticVehicleEx(400,-2649.8928,-54.9272,4.4314,357.7898,4,0,600); // buscar 2
	Buscar3	   = AddStaticVehicleEx(489,-2663.5229,-54.4913,4.4836,178.3725,0,65,600); // buscar 3
//===================================[Sweeper]==================================
	Cleanjob1  = AddStaticVehicleEx(574,-2461.2029,-32.1603,33.5419,86.4110,1,0,600);   // sweeper1
	Cleanjob2  = AddStaticVehicleEx(574,-2461.0095,-26.7136,32.5348,88.4223,1,0,600);   // sweeper2
	Cleanjob3  = AddStaticVehicleEx(574,-2461.3206,-20.7497,32.5297,271.7943,1,0,600);  // sweeper3
	Cleanjob4  = AddStaticVehicleEx(574,-2460.9885,-11.4442,27.8023,273.0233,1,0,600);  // sweeper4
	Cleanjob5  = AddStaticVehicleEx(574,-2461.0371,-5.4329,27.6651,85.4907,1,0,600);    // sweeper5
	Cleanjob6  = AddStaticVehicleEx(574,-2461.2449,0.5453,27.6682,267.6063,1,0,600);    // sweeper6
	Cleanjob7  = AddStaticVehicleEx(408,-2453.5369,-55.1349,34.3306,178.3661,1,86,600); // trash1
	Cleanjob8  = AddStaticVehicleEx(408,-2456.9182,4.1570,26.1726,88.8981,1,86,600);    // trash2
//=====================================[News]===================================
	newsjob1   = AddStaticVehicleEx(488,-2499.4170,-638.7217,138.0029,270.6438,14,7,600); // S.A.N Chopper
	newsjob2   = AddStaticVehicleEx(582,-2535.3040,-602.3288,132.6245,359.2579,14,7,600); // newsvan1
	newsjob3   = AddStaticVehicleEx(582,-2527.8582,-603.1528,132.6193,179.4034,14,7,600); // newsvan2
	newsjob4   = AddStaticVehicleEx(582,-2517.1218,-602.1067,132.6192,0.3247  ,14,7,600); // newsvan3
	newsjob5   = AddStaticVehicleEx(582,-2505.6948,-601.9226,132.6213,359.4475,14,7,600); // newsvan4
//=====================================[Trams]==================================
    Tram1  = AddStaticVehicle(449,-2264.6863,526.9558,35.5917,0.4091  ,1,74); // Tram 1
//===================================[Train SF]=================================
    Train1 = AddStaticVehicle(538,-1947.3341,159.3895,25.6148,357.5030,1,74); // Train 1
//===================================[Train LV]=================================
    Train2 = AddStaticVehicle(538,1469.1173,2632.2500,12.1256,270.0000,1,95); // Train 5
//====================================[Imports]=================================
    BIAir     = AddStaticVehicle(553, -2966.18, 2977.858, 15, 0, -1, -1); 		// Big Import Aeroplane
	BITruck   = AddStaticVehicle(403,1053.3502,2187.4104,11.4217,178.2501,0,0); // position of the linerunner
	BIBoat    = AddStaticVehicle(446, 735.7062, -2931.147, 15, 0, -1, -1); 	    // position of the BI Boat
	BITrailer = AddStaticVehicle(403,1053.3502,2187.4104,14.4217,178.2501,0,0); // position of the Trailer
    AttachTrailerToVehicle(BITruck, BITrailer);
//<============================================================================>
//<============================[Adding Pickups]================================>
//<============================================================================>
	CasinoEnter     = CreatePickup(1318,23,-1754.2550,963.5063,24.8828  );  // Casino Entrance
	CasinoMeeting   = CreatePickup(1318,23, 2270.9053,1637.9457,1008.3594); // Casino Meeting
	CasinoCarpark   = CreatePickup(1318,23,-1707.8938,1018.1349,17.9178 );  // Casino Meeting (Carpark)
    Shop         	= CreatePickup(1318,23,-2442.7014,755.4175,35.1719  );  // Shop Entrance
	Townhall     	= CreatePickup(1318,23,-2765.5288,375.6807,6.3359   );  // Townhall Entrance
    Hospital	   	= CreatePickup(1318,23,-2655.0842,640.1654,14.4545  );  // Hospital Entrance
    HospitalExit    = CreatePickup(1318,23,-2676.1946,665.0449,13700.4980);  // Hospital Exit
    HospitalJob     = CreatePickup(1239,23,-2670.9170,639.9852,14.4531  );  // Hospital Job
    HospitalRoof  	= CreatePickup(1318,23,-2665.0945,639.8772,14.4531  );  // Hospital Roof Entrance
	PDMain       	= CreatePickup(1318,23,-1605.5024,711.0540,13.8672  );  // SFPD Main Entrance
    PDUnder     	= CreatePickup(1318,23,-1594.2057,716.2708,-4.9063  );  // SFPD Underground
    Jizzys       	= CreatePickup(1318,23,-2625.1506,1412.2413,7.0938  );  // Jizzys Downstairs Entrance
    JizzysRoof   	= CreatePickup(1318,23,-2660.3210,1420.4579,23.8984 );  // Jizzys Roof Entrance
    Mistys       	= CreatePickup(1318,23,-2242.1494,-88.2409,35.3203  );  // Mistys Entrance
    Mistysstaff     = CreatePickup(1254,23,501.0037,-78.5625,998.7578  );  // Mistys Staff Entrance
    Forelli       	= CreatePickup(1318,23,-2281.9561,2288.2690,4.9740 );  // Forelli Entrance
    Gecko       	= CreatePickup(1318,23,-1972.7019,-2431.7754,30.6250);  // Gecko Entrance
    JobCenterIn  	= CreatePickup(1318,23,-2649.1084,376.0042,6.1593   );  // Job Center Entrance
	BankIn          = CreatePickup(1318,23,-1946.3510,555.0706,35.1719  );  // Bank Entrance
	Gaydar       	= CreatePickup(1318,23,-2551.1799,193.8388,6.2266   );  // Gaydar Entrance
    Church          = CreatePickup(1318,23,-1989.8983,1117.9265,54.4688 );  // Church Entrance
    NewsIn          = CreatePickup(1318,23,-2521.8881835938,-625.30615234375, 132.9779510498); // News Entrance
	ApartmentIn     = CreatePickup(1318,23,-2351.1538,492.5135,30.8166); // Atrium Entrance
	ZIP		   		= CreatePickup(1275,23,-1882.6204,866.1075,35.1719 );  // ZIP Entrance

	CasinoExit      = CreatePickup(1318,23,2233.7939,1714.6837,1012.3828 );  // Casino Exit
	CasinoMeetingExit   = CreatePickup(1318,23,2543.1829,-1304.9855,1054.6406);  // Casino Meeting
	CasinoCarparkExit   = CreatePickup(1318,23,2531.9246,-1285.8855,1054.6406);  // Casino Meeting (Carpark)
	ShopExit     	= CreatePickup(1318,23,-25.8534,-188.2415,1003.5469  ); // Shop Exit
	TownhallExit 	= CreatePickup(1318,23,390.7686,173.8687,1008.3828   ); // Townhall Exit
	PDMainExit   	= CreatePickup(1318,23,246.5343,107.3009,1003.2188   ); // SFPD Main Entrance
    PDUnderExit  	= CreatePickup(1318,23,215.4083,126.7140,1003.2188   ); // SFPD Underground Exit
    JizzysExit      = CreatePickup(1318,23,-2635.9636,1402.4661,906.4609 ); // Jizzys Downstairs Entrance
    JizzysRoofExit  = CreatePickup(1318,23,-2661.4006,1417.4951,922.1953 ); // Jizzys Roof Entrance
	MistysExit   	= CreatePickup(1318,23,501.8561,-67.5637,998.7578    ); // Mistys Entrance
 	MistyStaffExit = CreatePickup(1254,23,495.0427,-79.9127,1007.0469   ); // Mistys Staff Entrance
	ForelliExit     = CreatePickup(1318,23,2525.2832,-1302.2196,1048.2891); // Forelli Jefferson
	GeckoExit     = CreatePickup(1318,23,1418.9016,-46.3043,1000.9288 );  // Gecko Warehouse
	JobCenterOut 	= CreatePickup(1559,23,2324.5024,-1149.0229,1050.7101); // Job Center Exit
	BankOut         = CreatePickup(1318,23,2304.6929,-16.1075,26.7422    ); // Bank Out
    GaydarExit   	= CreatePickup(1559,23,493.8453,-24.8604,1000.6797   ); // Gaydar Exit
    TaxiExit        = CreatePickup(1318,23,1494.3037,1303.5792,1093.2891 ); // Taxi Exit Pickup
	PizzaExit       = CreatePickup(1318,23,372.1841,-133.5100,1001.4922  ); // Pizza Exit Pickup
	PilotExit       = CreatePickup(1318,23,232.8813,1822.7052,7.4141     ); // Pilot Exit Pickup
	ChurchExit      = CreatePickup(1318,23,1963.9922,-349.6283,1092.9454 ); // Church Exit Pickup
	NewsExit        = CreatePickup(1318,23,242.4465,302.7021,999.1343); 	// News Entrance
	ApartmentOut    = CreatePickup(1318,23,1727.0277,-1637.8497,20.2229  ); // Atrium Exit
    HospitalRoofExit= CreatePickup(1318,23,-2686.8105,580.1689,51.2923 );  	// Hospital Roof Exit

	TaxiEnter      	= CreatePickup(1318,23,-1608.7029, 1284.0530,7.1778   ); // Taxi Entrance Pickup
	TaxiJob         = CreatePickup(1239,23,1491.1520,1307.6013,1093.2891  ); // Taxi Job Pickup
	PizzaEnter     	= CreatePickup(1318,23,-1808.7107,  945.9189,24.8906  ); // Pizza Entrance Pickup
	PizzaJob        = CreatePickup(1239,23,369.2611,-119.0535,1001.4922   ); // Pizza getjob Pickup
	PilotEnter      = CreatePickup(1318,23,-1264.7472,40.0365,14.1356	  ); // Pilot enter Pickup
	PilotJob        = CreatePickup(1239,23,213.8598,1816.5664,6.4141	  ); // Pilot Job Pickup
	Mistysi         = CreatePickup(1239,23,496.0625,-75.9281,998.7578     ); // Mistys info Icon
	Jobi         	= CreatePickup(1239,23, 2324.4270,-1140.7649,1050.4922); // Job Center info Icon
    SpawnInfo    	= CreatePickup(1239,23,-2187.6423,  308.2809,35.1172  ); // Spawn Info Icon
    DrivingTest     = CreatePickup(1239,23,-2024.7075,-101.1420,35.1641   ); // Driving Test Icon
    FireJob         = CreatePickup(1239,23,-2026.9402,67.1985,28.6916     ); // Fire Job Info
    BankInfo        = CreatePickup(1274,23,2316.6211,-7.5200,26.7422	  ); // Bank Info Icon
    PDDuty       	= CreatePickup(1247,23,228.0236,111.6193,1003.218     ); // SFPD On Duty

	BMGarcia        = CreatePickup(1279,23,-2206.7803,-16.9651,35.3203);    // BlackMarket (Garcia) Pickup
    BMEaster        = CreatePickup(1279,23,-1719.5497,-17.5210,3.5547);  	// BlackMarket (Easter Basing) Pickup
    
    Wang1p          = CreatePickup(1239,23,-1943.6024,272.9930,35.4739);       	// Moonbeam
    Wang2p          = CreatePickup(1239,23,-1944.8795,262.9288,35.4688);        // Admiral
    Wang3p          = CreatePickup(1239,23,-1947.9940,254.9449,35.4688);      	// Oceanic
    Wang4p          = CreatePickup(1239,23,-1955.6771,256.2823,35.4688);		// Sentinel
    Wang5p          = CreatePickup(1239,23,-1963.1887,258.1035,35.4739);        // Huntley
    Wang6p          = CreatePickup(1239,23,-1961.2693,274.8006,35.4688);        // Washington
	Wang7p          = CreatePickup(1239,23,-1943.1118,273.8531,41.0471);        // Stallion
    Wang8p          = CreatePickup(1239,23,-1946.4486,255.6586,41.0471);        // Patriot
    Wang9p          = CreatePickup(1239,23,-1952.6472,300.0956,41.0471);        // Savannah
    Wang10p         = CreatePickup(1239,23,-1957.2007,256.4920,41.0471);        // Hermes

    Wango1p         = CreatePickup(1239,23,-1990.7673,274.8683,35.1719);       	// Hippy Van
    Wango2p         = CreatePickup(1239,23,-1990.2198,268.4314,35.1719);        // Tampa
    Wango3p         = CreatePickup(1239,23,-1991.1779,262.3132,35.1794);      	// Landstalker
    Wango4p         = CreatePickup(1239,23,-1990.7494,255.4285,35.1719);		// Picador
    Wango5p         = CreatePickup(1239,23,-1991.5999,248.5744,35.1719);        // Clover
	Wango6p         = CreatePickup(1239,23,-1992.7081,239.5899,35.1719);        // Journey

	Wangbuy         = CreatePickup(1239,23,-1954.3831,299.7207,35.4688);        // Purchase Icon At Wangs
	Ottobuy         = CreatePickup(1239,23,-1656.6205,1209.9940,7.2500);        // Purchase Icon At Ottos

    otto1p          = CreatePickup(1239,23,-1663.4556,1224.1251,21.1563);       // Buffalo
    otto2p          = CreatePickup(1239,23,-1668.7993,1207.3263,21.1563);        // ZR-350
    otto3p          = CreatePickup(1239,23,-1657.3053,1203.7053,21.1487);       // Infernus
    otto4p          = CreatePickup(1239,23,-1648.3250,1204.7728,21.1563);       // Jester
    otto5p          = CreatePickup(1239,23,-1664.6471,1222.3032,13.6781);       // Sultan
    otto6p          = CreatePickup(1239,23,-1648.8298,1205.1893,13.6719);       // Stafford
    otto7p          = CreatePickup(1239,23,-1663.1769,1212.4415,13.6719);       // Sabre
    otto8p          = CreatePickup(1239,23,-1678.0078,1209.5834,13.6719);       // Flash
	return 1;
}
//<============================================================================>
//<============================================================================>
//<============================================================================>
//<============================[Player Setup]==================================>
//<============================================================================>
public OnPlayerConnect(playerid)
{
    SetPlayerMapIcon( playerid, 1,-1942.9331, 536.5298 ,209.7901, 52, 0 );// Bank Icon
	SetPlayerMapIcon( playerid, 2,-2659.5190, 623.3381 , 66.0938, 22, 0 );// Hospital Icon
	SetPlayerMapIcon( playerid, 3,-2026.9402, 67.1985  , 28.6916, 20, 0 );// SFFD Icon
	SetPlayerMapIcon( playerid, 4,-1253.7499, 35.8771  , 14.1408,  5, 0 );// Pilots Icon
	SetPlayerMapIcon( playerid, 5,-548.0735 ,-521.5680 , 36.4209, 51, 0 );// Haulage Icon
	SetPlayerMapIcon( playerid, 6,-1035.0332,-675.1257 , 71.3723, 51, 0 );// Haulage Icon
	SetPlayerMapIcon( playerid, 7,-1750.9260, 985.7310 , 95.8438, 25, 0 );// Casino Icon
	SetPlayerMapIcon( playerid, 8,-2543.7983, 192.4014 , 18.3639, 49, 0 );// Gaydar Icon
	SetPlayerMapIcon( playerid, 9,-1605.5024, 711.0540 , 13.8672, 30, 0 );// Police Icon
	SetPlayerMapIcon( playerid,10,-2437.1887, 769.1656 , 48.7510, 17, 0 );// 24/7 Icon
	SetPlayerMapIcon( playerid,11,-2233.5518, -86.5575 , 51.6791, 23, 0 );// Mistys
	SetPlayerMapIcon( playerid,12,-2122.5237,-119.4288 , 55.0685, 11, 0 );// Pro Tow Icon
	SetPlayerMapIcon( playerid,13,-2026.8414,-111.7457 , 39.1098, 36, 0 );// Driving School
	SetPlayerMapIcon( playerid,14,-1952.9894, 293.7396 , 47.8808, 55, 0 );// Wang Cars
	SetPlayerMapIcon( playerid,15,-1657.1553, 1212.3197, 33.0805, 55, 0 );// Otto Cars
	SetPlayerMapIcon( playerid,16,-2649.5386, 1414.5048, 26.6343, 59, 0 );// Jizzys
	SetPlayerMapIcon( playerid,17,-1881.4310,867.8569  , 57.9297, 45, 0 );// ZIP
	TogglePlayerDynamicCP(playerid, EBrefuel1, false);
//	TogglePlayerDynamicCP(playerid, EBrefuel2, false);
	TogglePlayerDynamicCP(playerid, TSrefuel1, false);
//	TogglePlayerDynamicCP(playerid, TSrefuel2, false);
	TogglePlayerDynamicCP(playerid, JHrefuel1, false);
    TogglePlayerDynamicCP(playerid, JHDrivethru, false);
    TogglePlayerDynamicCP(playerid,  GDrivethru, false);
    TogglePlayerDynamicCP(playerid,  Test1, false);
    TogglePlayerDynamicCP(playerid,  Test2, false);
    TogglePlayerDynamicCP(playerid,  Test3, false);
    TogglePlayerDynamicCP(playerid,  Test4, false);
    TogglePlayerDynamicCP(playerid,  Test5, false);
    TogglePlayerDynamicCP(playerid,  Test6, false);
    TogglePlayerDynamicCP(playerid,  Test7, false);
    TogglePlayerDynamicCP(playerid,  Test8, false);
    TogglePlayerDynamicCP(playerid,  Test9, false);
    TogglePlayerDynamicCP(playerid,  Test10, false);
    TogglePlayerDynamicCP(playerid,  Test11, false);
 	IsInShop[playerid] = 0;
	countvalue[playerid] = 0;
	wait[playerid] = 0;
	KeyTimer[playerid] = -1;
	HasBoughtNewSkin[playerid] = 0;
	LastSkin[playerid] = 0;
	TextdrawActive[playerid] = 0;
	Skin[playerid] = 0;
	if (IsPlayerNPC(playerid))
	{
		return 1;
	}
	else
	{
		ClearVars(playerid);
	    SyncCheckpoints(playerid);
	    PMBlock[playerid] = false;
		SetPlayerColor(playerid,0x8F8F8FFF);
		ShowPlayerDialog(playerid,3,DIALOG_STYLE_INPUT,"{80FF00}Login Required","{FFFFFF}Welcome to .:Zest:: Roleplay please enter your password.\nIf you are new please click register to make an account.","Login","Register");
		return 1;
	}
}
//=================================[Players Classes]============================
public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, -1159.0285, 885.6075, 84.6078);
    SetPlayerCameraPos( playerid, -1154.7296, 885.6075, 84.6078 );
    SetPlayerCameraLookAt( playerid, -1164.7296, 885.6075, 84.7823 );
	TogglePlayerControllable(playerid,0);
	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);
	PlayerPlaySound(playerid, 1076, 0.0, 0.0, 0.0);
	if (AccountInfo[playerid][Playerskin] >= 1)
	{
		SetPlayerSkin(playerid, AccountInfo[playerid][Playerskin]);
		return 1;
	}
	return 1;
}
//<============================================================================>
//<=========================[Player Accounts]==================================>
//<============================================================================>
public OnPlayerRegister(playerid, password[])
{
	if(IsPlayerConnected(playerid))
	{
	    new name[MAX_PLAYER_NAME], str[128], ip[15];
	    GetPlayerName(playerid, name, sizeof name);
	    GetPlayerIp(playerid, ip, sizeof ip);
	    format(str, sizeof str, "/Accounts/%s.user", name);
	    new File:account = fopen(str, io_write);
	    if (account)
		{
  			strmid(AccountInfo[playerid][Password], password, 0, strlen(password), 255);
		   	AccountInfo[playerid][Cash] = GetPlayerMoney(playerid);
		   	new file[128];
			{
				format(file, sizeof file, "Password: %s\n\r", AccountInfo[playerid][Password]);
				{	fwrite(account, file); }
				format(file, sizeof file, "AdminLevel: %d\n\r", 0);
				{	fwrite(account, file); AccountInfo[playerid][AdminLevel] = 0; }
				format(file, sizeof file, "In Zest: %d\n\r", 0);
				{	fwrite(account, file); AccountInfo[playerid][Clan] = 0; }
				format(file, sizeof file, "Cash: %d\n\r", AccountInfo[playerid][Cash]);
				{	fwrite(account, file); AccountInfo[playerid][Cash] = 500; }
				format(file, sizeof file, "Cannabis: %d\n\r", AccountInfo[playerid][Cannabis]);
				{	fwrite(account, file); AccountInfo[playerid][Cannabis] = 0; }
				format(file, sizeof file, "Cocaine: %d\n\r", AccountInfo[playerid][Cocaine]);
				{	fwrite(account, file); AccountInfo[playerid][Cocaine] = 0; }
				format(file, sizeof file, "Crack: %d\n\r", AccountInfo[playerid][Crack]);
				{	fwrite(account, file); AccountInfo[playerid][Crack] = 0; }
				format(file, sizeof file, "Ecstasy: %d\n\r", AccountInfo[playerid][Ecstasy]);
				{	fwrite(account, file); AccountInfo[playerid][Ecstasy] = 0; }
				format(file, sizeof file, "Firearms: %d\n\r", AccountInfo[playerid][Firearms]);
				{	fwrite(account, file); AccountInfo[playerid][Firearms] = 0; }
				format(file, sizeof file, "Times Imported: %d\n\r", AccountInfo[playerid][Imported]);
				{	fwrite(account, file); }
				format(file, sizeof file, "Body Armor: %d\n\r", AccountInfo[playerid][Kevlar]);
				{	fwrite(account, file); }
				format(file, sizeof file, "Weapon 1: %d\n\r", AccountInfo[playerid][Weapon1]);
				{	fwrite(account, file); }
				format(file, sizeof file, "Weapon 2: %d\n\r", AccountInfo[playerid][Weapon2]);
				{	fwrite(account, file); }
				format(file, sizeof file, "Weapon 3: %d\n\r", AccountInfo[playerid][Weapon3]);
				{	fwrite(account, file); }
				format(file, sizeof file, "Weapon 4: %d\n\r", AccountInfo[playerid][Weapon4]);
				{	fwrite(account, file); }
				format(file, sizeof file, "Weapon 5: %d\n\r", AccountInfo[playerid][Weapon5]);
				{	fwrite(account, file); }
				format(file, sizeof file, "Weapon 6: %d\n\r", AccountInfo[playerid][Weapon6]);
				{	fwrite(account, file); }
				format(file, sizeof file, "Weapon 7: %d\n\r", AccountInfo[playerid][Weapon7]);
				{	fwrite(account, file); }
				format(file, sizeof file, "Weapon 8: %d\n\r", AccountInfo[playerid][Weapon8]);
				{	fwrite(account, file); }
				format(file, sizeof file, "Weapon 1 Ammo: %d\n\r", AccountInfo[playerid][Ammo1]);
				{	fwrite(account, file); }
				format(file, sizeof file, "Weapon 2 Ammo: %d\n\r", AccountInfo[playerid][Ammo2]);
				{	fwrite(account, file); }
				format(file, sizeof file, "Weapon 3 Ammo: %d\n\r", AccountInfo[playerid][Ammo3]);
				{	fwrite(account, file); }
				format(file, sizeof file, "Weapon 4 Ammo: %d\n\r", AccountInfo[playerid][Ammo4]);
				{	fwrite(account, file); }
				format(file, sizeof file, "Weapon 5 Ammo: %d\n\r", AccountInfo[playerid][Ammo5]);
				{	fwrite(account, file); }
				format(file, sizeof file, "Weapon 6 Ammo: %d\n\r", AccountInfo[playerid][Ammo6]);
				{	fwrite(account, file); }
				format(file, sizeof file, "Weapon 7 Ammo: %d\n\r", AccountInfo[playerid][Ammo7]);
				{	fwrite(account, file); }
				format(file, sizeof file, "Weapon 8 Ammo: %d\n\r", AccountInfo[playerid][Ammo8]);
				{	fwrite(account, file); }
				format(file, sizeof file, "Gang Offered Team: %d\n\r", AccountInfo[playerid][GangOffer]);
				{	fwrite(account, file); AccountInfo[playerid][GangOffer] = 0;}
				format(file, sizeof file, "Spawn Position X: %f\n\r", AccountInfo[playerid][SpawnX]);
				{	fwrite(account, file);}AccountInfo[playerid][SpawnX] = 0;
				format(file, sizeof file, "Spawn Position Y: %f\n\r", AccountInfo[playerid][SpawnY]);
				{	fwrite(account, file);}AccountInfo[playerid][SpawnY] = 0;
				format(file, sizeof file, "Spawn Position Z: %f\n\r", AccountInfo[playerid][SpawnZ]);
				{	fwrite(account, file);}AccountInfo[playerid][SpawnZ] = 0;
				format(file, sizeof file, "Spawn Interior: %d\n\r", AccountInfo[playerid][SpawnInt]);
				{	fwrite(account, file);}AccountInfo[playerid][SpawnInt] = 0;
				format(file, sizeof file, "Custom Spawn: %f\n\r", AccountInfo[playerid][CustomSpawn]);
				{	fwrite(account, file);} AccountInfo[playerid][CustomSpawn] = 0;
				format(file, sizeof file, "Job Offered : %d\n\r", AccountInfo[playerid][JobOffer]);
				{	fwrite(account, file); AccountInfo[playerid][JobOffer] = 0;}
				format(file, sizeof file, "Ordered Pizza: %d\n\r", AccountInfo[playerid][OrderedPizza]);
				{	fwrite(account, file); AccountInfo[playerid][OrderedPizza] = 0; }
				format(file, sizeof file, "Bank: %d\n\r", AccountInfo[playerid][Bank]);
				{	fwrite(account, file); AccountInfo[playerid][Bank] = 0; }
				format(file, sizeof file, "Player Skin ID: %d\n\r", AccountInfo[playerid][Playerskin]);
				{	fwrite(account, file); AccountInfo[playerid][Playerskin] = 0; }
				format(file, sizeof file, "Bought Skin: %d\n\r", AccountInfo[playerid][Playerskin]);
				{	fwrite(account, file); AccountInfo[playerid][Boughtskin] = 0; }
				format(file, sizeof file, "Player Team: %d\n\r", AccountInfo[playerid][pTeam]);
				{	fwrite(account, file); AccountInfo[playerid][pTeam] = 0; }
				format(file, sizeof file, "Player Vehicle: %d\n\r", AccountInfo[playerid][pTeam]);
				{	fwrite(account, file); AccountInfo[playerid][pVehicle] = 256; }
				format(file, sizeof file, "Player Level: %d\n\r", AccountInfo[playerid][pLevel]);
				{	fwrite(account, file); AccountInfo[playerid][pLevel] = 0; }
				format(file, sizeof file, "Player Experience: %d\n\r", AccountInfo[playerid][pExp]);
				{	fwrite(account, file); AccountInfo[playerid][pExp] = 0; }
				format(file, sizeof file, "Job Level: %d\n\r", AccountInfo[playerid][jLevel]);
				{	fwrite(account, file); AccountInfo[playerid][jLevel] = 0; }
				format(file, sizeof file, "Job Experience: %d\n\r", AccountInfo[playerid][jExp]);
				{	fwrite(account, file); AccountInfo[playerid][jExp] = 0; }
				format(file, sizeof file, "Job: %d\n\r", AccountInfo[playerid][pJob]);
				{	fwrite(account, file); AccountInfo[playerid][pJob] = 0; }
				format(file, sizeof file, "Home: %d\n\r", AccountInfo[playerid][pJob]);
				{	fwrite(account, file); AccountInfo[playerid][pJob] = 0; }
				format(file, sizeof file, "Gang Rank: %d\n\r", AccountInfo[playerid][GangRank]);
				{	fwrite(account, file); AccountInfo[playerid][GangRank] = 0; }
				format(file, sizeof file, "Job Rank: %d\n\r", AccountInfo[playerid][JobRank]);
				{	fwrite(account, file); AccountInfo[playerid][JobRank] = 0; }
				format(file, sizeof file, "Driving License: %d\n\r",AccountInfo[playerid][DLicense]);
				{	fwrite(account, file); AccountInfo[playerid][DLicense] = 0; }
				format(file, sizeof file, "Warnings: %d\n\r",AccountInfo[playerid][Warns]);
				{	fwrite(account, file); }
				format(file, sizeof file, "WarnReason1: %s\n\r",AccountInfo[playerid][WarnReason1]);
				{	fwrite(account, file); }
				format(file, sizeof file, "WarnReason2: %s\n\r",AccountInfo[playerid][WarnReason2]);
				{	fwrite(account, file); }
				format(file, sizeof file, "WarnReason3: %s\n\r",AccountInfo[playerid][WarnReason3]);
				{	fwrite(account, file); }
				format(file, sizeof file, "IPAddress: %s\n\r",ip);
				{	fwrite(account, file); }
				format(file, sizeof file, "Logged In: %d\n\r",AccountInfo[playerid][Logged]);
				{   fwrite(account, file); }
			}
			CheckLevel(playerid);
			GameTextForPlayer(playerid,"You were successfully registered",5000,3);
			AccountInfo[playerid][Logged] = 1;
 			if (AccountInfo[playerid][AdminLevel] > 0)
			{
				new pName[MAX_PLAYER_NAME];
	    		new Connect[128];
   				GetPlayerName(playerid, pName, sizeof(pName));
	    		format(Connect, sizeof(Connect), "[Server]: Adminstrator %s has joined the server.", pName);
                SendClientMessageToAll(COLOUR_HEADER, Connect);
				format(str, sizeof str, "[Server]: Welcome Administrator %s ", name);
				SendClientMessage(playerid, COLOUR_HEADER, str);
				AccountInfo[playerid][Logged] = 1;
				GivePlayerMoney(playerid, 500);
				CheckLevel(playerid);
			}
			else if (AccountInfo[playerid][AdminLevel] == 0)
			{
				new pName[MAX_PLAYER_NAME];
	    		new Connect[128];
  				GetPlayerName(playerid, pName, sizeof(pName));

				SendClientMessage(playerid, COLOUR_HEADER, "[Server]: You Have Sucessfully Logged In");
				format(str, sizeof str, "[Server]: Welcome to our server, %s", name);
				SendClientMessage(playerid, COLOUR_HEADER, str);
	    		format(Connect, sizeof(Connect), "[Server]: %s has joined the server.", pName);
	    		SendClientMessageToAll(COLOUR_HEADER, Connect);
	    		AccountInfo[playerid][Logged] = 1;
	    		GivePlayerMoney(playerid, 500);
				CheckLevel(playerid);
				SendDeathMessage(playerid, INVALID_PLAYER_ID, 200);
			}
			fclose(account);
		}
	}
	return 1;
}
//<============================================================================>
public OnPlayerLogin(playerid, password[])
{
    new name[MAX_PLAYER_NAME], str[128];
    GetPlayerName(playerid, name, sizeof name);
	format(str, sizeof str, "/Accounts/%s.user", name);
	new File:account = fopen(str, io_read);
	if (account)
	{
	    new pass[256];
	    new passres[128], value[128];
	    new para1;
	    fread(account, pass, sizeof pass);
	    passres = GetFileString(pass);
	    if (!strcmp("Password", passres))
		{
			value = GetFileValue(pass);
			strmid(AccountInfo[playerid][Password], value, 0, strlen(value)-1, 128);
		}
		if (!strcmp(AccountInfo[playerid][Password], password, true))
		{
		    while (fread(account, pass, 256))
			{
				passres = GetFileString(pass);
				if (strfind(passres, "AdminLevel") != -1)
				{
					value = GetFileValue(pass);
					AccountInfo[playerid][AdminLevel] = strval(value);
				}
				if (strfind(passres, "In Zest") != -1)
				{
					value = GetFileValue(pass);
					AccountInfo[playerid][Clan] = strval(value);
				}
				if (strfind(passres, "Cash") != -1)
				{
					value = GetFileValue(pass);
					AccountInfo[playerid][Cash] = strval(value);
				}
				if (strfind(passres, "Cannabis") != -1)
				{
					value = GetFileValue(pass);
					AccountInfo[playerid][Cannabis] = strval(value);
				}
				if (strfind(passres, "Cocaine") != -1)
				{
					value = GetFileValue(pass);
					AccountInfo[playerid][Cocaine] = strval(value);
				}
				if (strfind(passres, "Crack") != -1)
				{
					value = GetFileValue(pass);
					AccountInfo[playerid][Crack] = strval(value);
				}
				if (strfind(passres, "Ecstasy") != -1)
				{
					value = GetFileValue(pass);
					AccountInfo[playerid][Ecstasy] = strval(value);
				}
				if (strfind(passres, "Firearms") != -1)
				{
					value = GetFileValue(pass);
					AccountInfo[playerid][Cannabis] = strval(value);
				}
				if (strfind(passres, "Times Imported") != -1)
				{
					value = GetFileValue(pass);
					AccountInfo[playerid][Imported] = strval(value);
				}
				if (strfind(passres, "Body Armor") != -1)
				{
					value = GetFileValue(pass);
					AccountInfo[playerid][Kevlar] = strval(value);
				}
				if (strfind(passres, "Weapon Slot 1") != -1)
				{
					value = GetFileValue(pass);
					AccountInfo[playerid][Weapon1] = strval(value);
				}
				if (strfind(passres, "Weapon Slot 2") != -1)
				{
					value = GetFileValue(pass);
					AccountInfo[playerid][Weapon2] = strval(value);
				}
				if (strfind(passres, "Weapon Slot 3") != -1)
				{
					value = GetFileValue(pass);
					AccountInfo[playerid][Weapon3] = strval(value);
				}
				if (strfind(passres, "Weapon Slot 4") != -1)
				{
					value = GetFileValue(pass);
					AccountInfo[playerid][Weapon4] = strval(value);
				}
				if (strfind(passres, "Weapon Slot 5") != -1)
				{
					value = GetFileValue(pass);
					AccountInfo[playerid][Weapon5] = strval(value);
				}
				if (strfind(passres, "Weapon Slot 6") != -1)
				{
					value = GetFileValue(pass);
					AccountInfo[playerid][Weapon6] = strval(value);
				}
				if (strfind(passres, "Weapon Slot 7") != -1)
				{
					value = GetFileValue(pass);
					AccountInfo[playerid][Weapon7] = strval(value);
				}
				if (strfind(passres, "Weapon Slot 8") != -1)
				{
					value = GetFileValue(pass);
					AccountInfo[playerid][Weapon8] = strval(value);
    			}
				if (strfind(passres, "Gang Offered Team") != -1)
				{
					value = GetFileValue(pass);
					AccountInfo[playerid][GangOffer] = strval(value);
    			}
				if (strfind(passres, "Spawn Position X") != -1)
				{
					value = GetFileValue(pass);
					AccountInfo[playerid][SpawnX] = strval(value);
    			}
				if (strfind(passres, "Spawn Position Y") != -1)
				{
					value = GetFileValue(pass);
					AccountInfo[playerid][SpawnY] = strval(value);
    			}
				if (strfind(passres, "Spawn Position Z") != -1)
				{
					value = GetFileValue(pass);
					AccountInfo[playerid][SpawnZ] = strval(value);
    			}
				if (strfind(passres, "Spawn Interior") != -1)
				{
					value = GetFileValue(pass);
					AccountInfo[playerid][SpawnInt] = strval(value);
    			}
				if (strfind(passres, "Custom Spawn") != -1)
				{
					value = GetFileValue(pass);
					AccountInfo[playerid][CustomSpawn] = strval(value);
    			}
				if (strfind(passres, "Job Offered") != -1)
				{
					value = GetFileValue(pass);
					AccountInfo[playerid][JobOffer] = strval(value);
    			}
    			if (strfind(passres, "Ordered Pizza") != -1)
				{
					value = GetFileValue(pass);
					AccountInfo[playerid][OrderedPizza] = strval(value);
    			}
				if (strfind(passres, "Bank") != -1)
				{
					value = GetFileValue(pass);
					AccountInfo[playerid][Bank] = strval(value);
				}
				if (strfind(passres, "Player Skin ID") != -1)
				{
					value = GetFileValue(pass);
					AccountInfo[playerid][Playerskin] = strval(value);
				}
				if (strfind(passres, "Bought Skin") != -1)
				{
					value = GetFileValue(pass);
					AccountInfo[playerid][Boughtskin] = strval(value);
				}
				if (strfind(passres, "Player Team") != -1)
				{
					value = GetFileValue(pass);
					AccountInfo[playerid][pTeam] = strval(value);
				}
				if (strfind(passres, "Player Vehicle") != -1)
				{
					value = GetFileValue(pass);
					AccountInfo[playerid][pVehicle] = strval(value);
				}
				if (strfind(passres, "Player Level") != -1)
				{
					value = GetFileValue(pass);
					AccountInfo[playerid][pLevel] = strval(value);
				}
				if (strfind(passres, "Job Level") != -1)
				{
					value = GetFileValue(pass);
					AccountInfo[playerid][jLevel] = strval(value);
				}
				if (strfind(passres, "Job Experience") != -1)
				{
					value = GetFileValue(pass);
					AccountInfo[playerid][jExp] = strval(value);
				}
				if (strfind(passres, "Player Job") != -1)
				{
					value = GetFileValue(pass);
					AccountInfo[playerid][pJob] = strval(value);
				}
				if (strfind(passres, "Player House") != -1)
				{
					value = GetFileValue(pass);
					AccountInfo[playerid][pHouse] = strval(value);
				}
				if (strfind(passres, "Player Experience") != -1)
				{
					value = GetFileValue(pass);
					AccountInfo[playerid][pExp] = strval(value);
				}
				if (strfind(passres, "Gang Rank") != -1)
    			{
					value = GetFileValue(pass);
					AccountInfo[playerid][GangRank] = strval(value);
				}
				if (strfind(passres, "Job Rank") != -1)
    			{
					value = GetFileValue(pass);
					AccountInfo[playerid][JobRank] = strval(value);
				}
				if (strfind(passres, "Driving License") != -1)
    			{
					value = GetFileValue(pass);
					AccountInfo[playerid][DLicense] = strval(value);
				}
				if (strfind(passres, "Warnings") != -1)
				{
					value = GetFileValue(pass);
					AccountInfo[playerid][Warns] = strval(value);
				}
				if (strfind(passres, "WarnReason1") != -1)
				{
					value = GetFileValue(pass);
					strmid(AccountInfo[playerid][WarnReason1], value, 0, strlen(value)-1, 128);
				}
				if (strfind(passres, "WarnReason2") != -1)
    			{
					value = GetFileValue(pass);
					strmid(AccountInfo[playerid][WarnReason2], value, 0, strlen(value)-1, 128);
				}
				if (strfind(passres, "WarnReason3") != -1)
				{
					value = GetFileValue(pass);
					strmid(AccountInfo[playerid][WarnReason3], value, 0, strlen(value)-1, 128);
				}
    			if (strfind(passres, "Logged In") != -1)
				{
					value = GetFileValue(pass);
					AccountInfo[playerid][Logged] = strval(value);
				}
			}
   			fclose(account);
   			GivePlayerMoney(playerid, AccountInfo[playerid][Cash]);
			para1 = ReturnUser(name);
			printf("%s has logged in", para1);
     		if (AccountInfo[playerid][AdminLevel] > 0)
			{
				new pName[MAX_PLAYER_NAME];
	    		new Connect[128];
   				GetPlayerName(playerid, pName, sizeof(pName));
	    		format(Connect, sizeof(Connect), "[Server]: Adminstrator %s has joined the server.", pName);
                SendClientMessageToAll(COLOUR_HEADER, Connect);
				format(str, sizeof str, "[Server]: Welcome Administrator %s ", name);
				SendClientMessage(playerid, COLOUR_HEADER, str);
				AccountInfo[playerid][Logged] = 1;
				CheckLevel(playerid);
				if (AccountInfo[playerid][Clan] == 1)
				{
                    strins(pName, "[ZG]", 0);
					SetPlayerName(playerid,pName);
				}
			}
			else if (AccountInfo[playerid][AdminLevel] == 0)
			{
				new pName[MAX_PLAYER_NAME];
	    		new Connect[128];
  				GetPlayerName(playerid, pName, sizeof(pName));

				SendClientMessage(playerid, COLOUR_HEADER, "[Server]: You Have Sucessfully Logged In");
				format(str, sizeof str, "[Server]: Welcome to our server, %s", name);
				SendClientMessage(playerid, COLOUR_HEADER, str);
	    		format(Connect, sizeof(Connect), "[Server]: %s has joined the server.", pName);
	    		SendClientMessageToAll(COLOUR_HEADER, Connect);
	    		AccountInfo[playerid][Logged] = 1;
				CheckLevel(playerid);
				if (AccountInfo[playerid][Clan] == 1)
				{
                    strins(pName, "[ZG]", 0);
					SetPlayerName(playerid,pName);
				}
			}
		}
		else
		{
			SendClientMessage(playerid, COLOUR_ADMINRED, "[Server]: Incorrect Password.");
			OnPlayerConnect(playerid);
//	        fclose(account);
	        return 1;
		}
	}
	return 1;
}
//<============================================================================>
public OnPlayerUpdateAccount(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		if(AccountInfo[playerid][Logged] == 1)
		{
			new name[MAX_PLAYER_NAME], str[128];
		    GetPlayerName(playerid, name, sizeof name);
		    format(str, sizeof str, "/Accounts/%s.user", name);
		    new File:account = fopen(str, io_write);
		    if (account)
   			{
			   	AccountInfo[playerid][Cash] = GetPlayerMoney(playerid);
				AccountInfo[playerid][Bank] = AccountInfo[playerid][Bank];
				new file[128];
				{
					format(file, sizeof file, "Password: %s\n\r", AccountInfo[playerid][Password]);
					{	fwrite(account, file); }
					format(file, sizeof file, "AdminLevel: %d\n\r",AccountInfo[playerid][AdminLevel]);
					{	fwrite(account, file); }
					format(file, sizeof file, "In Zest: %d\n\r",AccountInfo[playerid][Clan]);
					{	fwrite(account, file); }
					format(file, sizeof file, "Cash: %d\n\r", AccountInfo[playerid][Cash]);
					{	fwrite(account, file); }
					format(file, sizeof file, "Cannabis: %d\n\r", AccountInfo[playerid][Cannabis]);
					{	fwrite(account, file); }
					format(file, sizeof file, "Cocaine: %d\n\r", AccountInfo[playerid][Cocaine]);
					{	fwrite(account, file); }
					format(file, sizeof file, "Crack: %d\n\r", AccountInfo[playerid][Crack]);
					{	fwrite(account, file); }
					format(file, sizeof file, "Ecstasy: %d\n\r", AccountInfo[playerid][Ecstasy]);
					{	fwrite(account, file); }
					format(file, sizeof file, "Firearms: %d\n\r", AccountInfo[playerid][Firearms]);
					{	fwrite(account, file); }
					format(file, sizeof file, "Times Imported: %d\n\r", AccountInfo[playerid][Imported]);
					{	fwrite(account, file); }
					format(file, sizeof file, "Weapon 1: %d\n\r", AccountInfo[playerid][Weapon1]);
					{	fwrite(account, file); }
					format(file, sizeof file, "Weapon 2: %d\n\r", AccountInfo[playerid][Weapon2]);
					{	fwrite(account, file); }
					format(file, sizeof file, "Weapon 3: %d\n\r", AccountInfo[playerid][Weapon3]);
					{	fwrite(account, file); }
					format(file, sizeof file, "Weapon 4: %d\n\r", AccountInfo[playerid][Weapon4]);
					{	fwrite(account, file); }
					format(file, sizeof file, "Weapon 5: %d\n\r", AccountInfo[playerid][Weapon5]);
					{	fwrite(account, file); }
					format(file, sizeof file, "Weapon 6: %d\n\r", AccountInfo[playerid][Weapon6]);
					{	fwrite(account, file); }
					format(file, sizeof file, "Weapon 7: %d\n\r", AccountInfo[playerid][Weapon7]);
					{	fwrite(account, file); }
					format(file, sizeof file, "Weapon 8: %d\n\r", AccountInfo[playerid][Weapon8]);
					{	fwrite(account, file); }
					format(file, sizeof file, "Weapon 1 Ammo: %d\n\r", AccountInfo[playerid][Ammo1]);
					{	fwrite(account, file); }
					format(file, sizeof file, "Weapon 2 Ammo: %d\n\r", AccountInfo[playerid][Ammo2]);
					{	fwrite(account, file); }
					format(file, sizeof file, "Weapon 3 Ammo: %d\n\r", AccountInfo[playerid][Ammo3]);
					{	fwrite(account, file); }
					format(file, sizeof file, "Weapon 4 Ammo: %d\n\r", AccountInfo[playerid][Ammo4]);
					{	fwrite(account, file); }
					format(file, sizeof file, "Weapon 5 Ammo: %d\n\r", AccountInfo[playerid][Ammo5]);
					{	fwrite(account, file); }
					format(file, sizeof file, "Weapon 6 Ammo: %d\n\r", AccountInfo[playerid][Ammo6]);
					{	fwrite(account, file); }
					format(file, sizeof file, "Weapon 7 Ammo: %d\n\r", AccountInfo[playerid][Ammo7]);
					{	fwrite(account, file); }
					format(file, sizeof file, "Weapon 8 Ammo: %d\n\r", AccountInfo[playerid][Ammo8]);
					{	fwrite(account, file); }
					format(file, sizeof file, "Gang Offered Team: %d\n\r", AccountInfo[playerid][GangOffer]);
					{	fwrite(account, file); }
					format(file, sizeof file, "Spawn Position X: %f\n\r", AccountInfo[playerid][SpawnX]);
					{	fwrite(account, file); }
					format(file, sizeof file, "Spawn Position Y: %f\n\r", AccountInfo[playerid][SpawnY]);
					{	fwrite(account, file); }
					format(file, sizeof file, "Spawn Position Z: %f\n\r", AccountInfo[playerid][SpawnZ]);
					{	fwrite(account, file); }
					format(file, sizeof file, "Spawn Interior: %d\n\r", AccountInfo[playerid][SpawnInt]);
					{	fwrite(account, file); }
					format(file, sizeof file, "Custom Spawn: %d\n\r", AccountInfo[playerid][CustomSpawn]);
					{	fwrite(account, file); }
					format(file, sizeof file, "Job Offered : %d\n\r", AccountInfo[playerid][JobOffer]);
					{	fwrite(account, file); }
					format(file, sizeof file, "Ordered Pizza: %d\n\r", AccountInfo[playerid][OrderedPizza]);
					{	fwrite(account, file); }
					format(file, sizeof file, "Bank: %d\n\r", AccountInfo[playerid][Bank]);
					{	fwrite(account, file); }
					format(file, sizeof file, "Player Skin ID: %d\n\r", AccountInfo[playerid][Playerskin]);
					{	fwrite(account, file); }
					format(file, sizeof file, "Bought Skin: %d\n\r", AccountInfo[playerid][Boughtskin]);
					{	fwrite(account, file); }
					format(file, sizeof file, "Player Team: %d\n\r", AccountInfo[playerid][pTeam]);
					{	fwrite(account, file); }
					format(file, sizeof file, "Player Level: %d\n\r", AccountInfo[playerid][pLevel]);
					{	fwrite(account, file); }
					format(file, sizeof file, "Player Experience: %d\n\r", AccountInfo[playerid][pExp]);
					{	fwrite(account, file); }
					format(file, sizeof file, "Job Level: %d\n\r", AccountInfo[playerid][jLevel]);
					{	fwrite(account, file); }
					format(file, sizeof file, "Job Experience: %d\n\r", AccountInfo[playerid][jExp]);
					{	fwrite(account, file); }
					format(file, sizeof file, "Player Job: %d\n\r", AccountInfo[playerid][pJob]);
					{	fwrite(account, file); }
					format(file, sizeof file, "Player House: %d\n\r", AccountInfo[playerid][pHouse]);
					{	fwrite(account, file); }
					format(file, sizeof file, "Gang Rank: %d\n\r", AccountInfo[playerid][GangRank]);
					{	fwrite(account, file); }
					format(file, sizeof file, "Job Rank: %d\n\r", AccountInfo[playerid][JobRank]);
					{	fwrite(account, file); }
					format(file, sizeof file, "Driving License: %d\n\r", AccountInfo[playerid][DLicense]);
					{	fwrite(account, file); }
					format(file, sizeof file, "Warnings: %d\n\r",AccountInfo[playerid][Warns]);
					{	fwrite(account, file); }
					format(file, sizeof file, "WarnReason1: %s\n\r",AccountInfo[playerid][WarnReason1]);
					{	fwrite(account, file); }
					format(file, sizeof file, "WarnReason2: %s\n\r",AccountInfo[playerid][WarnReason2]);
					{	fwrite(account, file); }
					format(file, sizeof file, "WarnReason3: %s\n\r",AccountInfo[playerid][WarnReason3]);
					{	fwrite(account, file); }
					format(file, sizeof file, "IPAddress: %s\n\r",AccountInfo[playerid][IP]);
					{	fwrite(account, file); }
				}
				fclose(account);
			}
		}
	}
	return 1;
}
//<============================================================================>
public OnPlayerDisconnect(playerid, reason)
{
	new Float:armour, kevlar;
	new weap1, ammo1, weap2, ammo2, weap3, ammo3, weap4, ammo4, weap5, ammo5, weap6, ammo6, weap7, ammo7, weap8, ammo8;
	GetPlayerWeaponData(playerid,1,weap1,ammo1);
	GetPlayerWeaponData(playerid,2,weap2,ammo2);// handgun
	GetPlayerWeaponData(playerid,3,weap3,ammo3);// shotgun
	GetPlayerWeaponData(playerid,4,weap4,ammo4);// SMG
	GetPlayerWeaponData(playerid,5,weap5,ammo5);// AK47 / M4
	GetPlayerWeaponData(playerid,6,weap6,ammo6);// rifle
	GetPlayerWeaponData(playerid,7,weap7,ammo7);// rocket launcher
	GetPlayerWeaponData(playerid,8,weap8,ammo8);
	kevlar = GetPlayerArmour(playerid, armour);
	AccountInfo[playerid][Weapon1] = weap1;
	AccountInfo[playerid][Ammo1]   = ammo1;
	AccountInfo[playerid][Weapon2] = weap2;
	AccountInfo[playerid][Ammo2]   = ammo2;
	AccountInfo[playerid][Weapon3] = weap3;
	AccountInfo[playerid][Ammo3]   = ammo3;
	AccountInfo[playerid][Weapon4] = weap4;
	AccountInfo[playerid][Ammo4]   = ammo4;
	AccountInfo[playerid][Weapon5] = weap5;
	AccountInfo[playerid][Ammo5]   = ammo5;
	AccountInfo[playerid][Weapon6] = weap6;
	AccountInfo[playerid][Ammo6]   = ammo6;
	AccountInfo[playerid][Weapon7] = weap7;
	AccountInfo[playerid][Ammo7]   = ammo7;
	AccountInfo[playerid][Weapon8] = weap8;
	AccountInfo[playerid][Ammo8]   = ammo8;
	AccountInfo[playerid][Kevlar]  = kevlar;
	AccountInfo[playerid][Custody] = 0;
    AccountInfo[playerid][Warns] = 0;
    AccountInfo[playerid][Logged] = 0;
    AccountInfo[playerid][Mute] = 0;
    AccountInfo[playerid][GangOffer] = 0;
    AccountInfo[playerid][OffererID] = 0;
	AccountInfo[playerid][OfferedItem] = 0;
	AccountInfo[playerid][OfferedAmount] = 0;
	AccountInfo[playerid][OfferedPrice] = 0;
	AccountInfo[playerid][OrderedPizza] = 0;
	RoadBlockDeployed[playerid] = 0;
	DestroyObject(PlayerRB[playerid]);
    strmid(AccountInfo[playerid][IP], " ", 0, strlen(" "), 20);
	new pName[MAX_PLAYER_NAME], string[90];
    GetPlayerName(playerid, pName, sizeof(pName));
    OnPlayerUpdateAccount(playerid);
    switch(reason)
    {
        case 0: format(string, sizeof(string), "%s has left the server. (Lost Connection)", pName);
        case 1: format(string, sizeof(string), "%s has left the server. (Leaving)", pName);
        case 2: format(string, sizeof(string), "%s has left the server. (Kicked)", pName);
    }
    SendClientMessageToAll(COLOUR_HEADER, string);
    SendDeathMessage(INVALID_PLAYER_ID, playerid, 201);
	return 1;
}
//<============================================================================>
//<============================================================================>
//<============================================================================>
//<============================================================================>
//<=========================[Player Spawning]==================================>
//<============================================================================>
public OnPlayerRequestSpawn(playerid)
{
	if (IsPlayerNPC(playerid) == 0)
	{
		new savedskin;
		savedskin = AccountInfo[playerid][Playerskin];
		SetPlayerTeam(playerid,  AccountInfo[playerid][pTeam]);
		if (AccountInfo[playerid][pTeam] == 2 && GetPlayerTeam(playerid) == 2)
  	 	{
			gTeam[playerid] = TEAM_FORELLI;
			SetPlayerColor(playerid, COLOUR_FORELLI);
			SetPlayerSkin(playerid, savedskin);
			OnPlayerUpdateAccount(playerid);
		}
		else if (AccountInfo[playerid][pTeam] == 3 && GetPlayerTeam(playerid) == 3)
		{
			gTeam[playerid] = TEAM_LOST;
		    SetPlayerColor(playerid, COLOUR_THELOST);
		    SetPlayerSkin(playerid, savedskin);
		    OnPlayerUpdateAccount(playerid);
		}
		else if (AccountInfo[playerid][pTeam] == 4 && GetPlayerTeam(playerid) == 4)
		{
			gTeam[playerid] = TEAM_GECKO;
		    SetPlayerColor(playerid, COLOUR_GECKO);
		    SetPlayerSkin(playerid, savedskin);
		    OnPlayerUpdateAccount(playerid);
		}
		else if (AccountInfo[playerid][pTeam] == 5 && GetPlayerTeam(playerid) == 5)
		{
			gTeam[playerid] = TEAM_NORTHSIDE;
		    SetPlayerColor(playerid, COLOUR_NORTHSIDE);
		    SetPlayerSkin(playerid, savedskin);
		    OnPlayerUpdateAccount(playerid);
		}
		else
		{
	        gTeam[playerid] = TEAM_CIVILLIAN;
	        SetPlayerColor(playerid, COLOUR_WHITE);
	        OnPlayerUpdateAccount(playerid);
		}
		return 1;
	}
	else
	{
	    return 1;
	}
}
//<============================================================================>
public OnPlayerSpawn(playerid)
{
	TextDrawShowForPlayer(playerid, Clock);
	TextDrawShowForPlayer(playerid, Day);
	PlayerPlaySound(playerid, 1186, 0.0, 0.0, 0.0);
    ShowNameTags(true);
    ShowPlayerMarkers(true);
    new weap1, ammo1, weap2, ammo2, weap3, ammo3, weap4, ammo4, weap5, ammo5, weap6, ammo6, weap7, ammo7, weap8, ammo8;
   	new savedskin;
   	new organisation = AccountInfo[playerid][pTeam];
	weap1 = AccountInfo[playerid][Weapon1];
	ammo1 = AccountInfo[playerid][Ammo1];
	weap2 = AccountInfo[playerid][Weapon2];
	ammo2 = AccountInfo[playerid][Ammo2];
	weap3 = AccountInfo[playerid][Weapon3];
	ammo3 = AccountInfo[playerid][Ammo3];
	weap4 = AccountInfo[playerid][Weapon4];
	ammo4 = AccountInfo[playerid][Ammo4];
	weap5 = AccountInfo[playerid][Weapon5];
	ammo5 = AccountInfo[playerid][Ammo5];
	weap6 = AccountInfo[playerid][Weapon6];
	ammo6 = AccountInfo[playerid][Ammo6];
	weap7 = AccountInfo[playerid][Weapon7];
	ammo7 = AccountInfo[playerid][Ammo7];
	weap8 = AccountInfo[playerid][Weapon8];
	ammo8 = AccountInfo[playerid][Ammo8];
	GivePlayerWeapon(playerid, weap1, ammo1);
	GivePlayerWeapon(playerid, weap2, ammo2);
	GivePlayerWeapon(playerid, weap3, ammo3);
	GivePlayerWeapon(playerid, weap4, ammo4);
	GivePlayerWeapon(playerid, weap5, ammo5);
	GivePlayerWeapon(playerid, weap6, ammo6);
	GivePlayerWeapon(playerid, weap7, ammo7);
	GivePlayerWeapon(playerid, weap8, ammo8);
	SetPlayerArmour(playerid, AccountInfo[playerid][Kevlar]);
	CheckLevel(playerid);
	savedskin = AccountInfo[playerid][Playerskin];
	switch(organisation)
	{
		case 1:
		{
			SetPlayerColor(playerid, COLOUR_WHITE);
			GangZoneShowForPlayer(playerid, LostMain, 0x40000096);
			GangZoneShowForPlayer(playerid, LostMistys, 0x40000096);
	  		GangZoneShowForPlayer(playerid, LostTow, 0x40000096);
		}
		case 2:
		{
			SetPlayerSkin(playerid, savedskin);
			SetPlayerColor(playerid, COLOUR_FORELLI);
			GangZoneShowForPlayer(playerid, LostMain, 0x40000096);
			GangZoneShowForPlayer(playerid, LostMistys, 0x40000096);
	  		GangZoneShowForPlayer(playerid, LostTow, 0x40000096);
		}
		case 3:
		{
			SetPlayerSkin(playerid, savedskin);
			SetPlayerColor(playerid, COLOUR_THELOST);
			GangZoneShowForPlayer(playerid, LostMain, 0x40000096);
			GangZoneShowForPlayer(playerid, LostMistys, 0x40000096);
			GangZoneShowForPlayer(playerid, LostTow, 0x40000096);
		}
		case 4:
		{
			SetPlayerSkin(playerid, savedskin);
			SetPlayerColor(playerid, COLOUR_GECKO);
			GangZoneShowForPlayer(playerid, LostMain, 0x40000096);
			GangZoneShowForPlayer(playerid, LostMistys, 0x40000096);
			GangZoneShowForPlayer(playerid, LostTow, 0x40000096);
		}
  		case 5:
		{
			SetPlayerSkin(playerid, savedskin);
			SetPlayerColor(playerid, COLOUR_NORTHSIDE);
			GangZoneShowForPlayer(playerid, LostMain, 0x40000096);
			GangZoneShowForPlayer(playerid, LostMistys, 0x40000096);
			GangZoneShowForPlayer(playerid, LostTow, 0x40000096);
		}
		default:
		{
			SetPlayerColor(playerid, COLOUR_WHITE);
		}
	}
	if(IsPlayerNPC(playerid)) //Checks if the player that just spawned is an NPC.
    {
        new npcname[MAX_PLAYER_NAME];
        GetPlayerName(playerid, npcname, sizeof(npcname));
        if(!strcmp(npcname, "Dave", true))
        {
            PutPlayerInVehicle(playerid, Tram1, 0);
            SetPlayerSkin( playerid, 255 );
            SetPlayerColor(playerid, 0x00000000);
        }
        if(!strcmp(npcname, "Paul", true))
        {
            PutPlayerInVehicle(playerid, Train1, 0);
            SetPlayerSkin(playerid, 255 );
            SetPlayerColor(playerid, 0x00000000);
        }
        if(!strcmp(npcname, "John", true))
        {
            PutPlayerInVehicle(playerid, Train2, 0);
            SetPlayerSkin(playerid, 253 );
            SetPlayerColor(playerid, 0x00000000);
        }
        if(!strcmp(npcname, "Pablo", true))
        {
            PutPlayerInVehicle(playerid, BIAir, 0);
            SetPlayerSkin( playerid, 61 );
        }
        if(!strcmp(npcname, "Amy", true))
        {
            PutPlayerInVehicle(playerid, BITruck, 0);
            SetPlayerSkin( playerid, 201 );
        }
        if(!strcmp(npcname, "Rodriguez", true))
        {
            PutPlayerInVehicle(playerid, BIBoat, 0);
            SetPlayerSkin( playerid, 108 );
        }
        if(!strcmp(npcname, "Chantelle", true))
        {
            SetPlayerSkin (playerid, 257 );
            SetPlayerColor(playerid, 0x00000000);
        }
        if(!strcmp(npcname, "Driving Instructor", true))
        {
            PutPlayerInVehicle(playerid, Test1, 1);
            SetPlayerSkin( playerid, 187 );
            SetPlayerColor(playerid, 0x00000000);
        }
        return 1;
	}
	if(AccountInfo[playerid][CustomSpawn] == 1)
	{
		SetPlayerPos(playerid,AccountInfo[playerid][SpawnX],AccountInfo[playerid][SpawnY],AccountInfo[playerid][SpawnZ]);
		SetPlayerInterior(playerid,AccountInfo[playerid][SpawnInt]);
	}
	return 1;
}
//<============================================================================>
//<============================================================================>
//<============================================================================>
//<============================================================================>
//<============================================================================>
//<============================================================================>
public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	TogglePlayerDynamicCP(playerid,  EBrefuel1, true);
//	TogglePlayerDynamicCP(playerid,  EBrefuel2, true);
	TogglePlayerDynamicCP(playerid,  TSrefuel1, true);
//	TogglePlayerDynamicCP(playerid,  TSrefuel2, true);
	TogglePlayerDynamicCP(playerid, JHrefuel1, true);
    TogglePlayerDynamicCP(playerid, JHDrivethru, true);
    TogglePlayerDynamicCP(playerid,  GDrivethru, true);
//<=============================[Wangs]===================================>
	if(vehicleid == Wang0 || vehicleid == Wang1 || vehicleid == Wang2 || vehicleid == Wang3 || vehicleid == Wang4 || vehicleid == Wang5 || vehicleid == Wang6 || vehicleid == Wang7 || vehicleid == Wang8  || vehicleid == Wang9)
	{
		SetVehicleParamsForPlayer(vehicleid, playerid, 0, 1);
	}
//<=============================[Wangs]===================================>
	if(vehicleid == Wango1 || vehicleid == Wango2 || vehicleid == Wango3 || vehicleid == Wango4 || vehicleid == Wango5 || vehicleid == Wango6 || vehicleid == Wango7)
	{
		SetVehicleParamsForPlayer(vehicleid, playerid, 0, 1);
	}
//<=============================[Ottos]===================================>
	if(vehicleid == otto1 || vehicleid == otto2 || vehicleid == otto3 || vehicleid == otto4 || vehicleid == otto5 || vehicleid == otto6 || vehicleid == otto7 || vehicleid == otto8)
	{
		SetVehicleParamsForPlayer(vehicleid, playerid, 0, 1);
	}
//<=============================[Driving School]===================================>
	if(vehicleid == dsa1 || vehicleid == dsa2)
	{
		SetVehicleParamsForPlayer(vehicleid, playerid, 0, 1);
	}
//<=============================[Blackmarket Vans]===================================>
	if(vehicleid == blackmark1 || vehicleid == blackmark2)
	{
        SetVehicleParamsForPlayer(vehicleid, playerid, 0, 1);
	}
//<==============================[Civi Cars]===================================>
	if(vehicleid == Civi1 || vehicleid == Civi2 || vehicleid == Civi3 || vehicleid == Civi4 || vehicleid == Civi5 || vehicleid == Civi6 || vehicleid == Civi7 || vehicleid == Civi8 || vehicleid == Civi9 || vehicleid == Civi10 || vehicleid == Civi11 || vehicleid == Civi12 || vehicleid == Civi13 || vehicleid == Civi14 || vehicleid == Civi15 || vehicleid == Civi16 || vehicleid == Civi17 || vehicleid == Civi18 || vehicleid == Civi19 || vehicleid == Civi20 || vehicleid == Civi21 || vehicleid == Civi22)
	{
        SetVehicleParamsForPlayer(vehicleid, playerid, 0, 0);
	}
//<================================[Taxi]======================================>
	if(vehicleid == taxi1 || vehicleid == taxi2 || vehicleid == taxi3 || vehicleid == taxi4 || vehicleid == taxi5 || vehicleid == taxi6 || vehicleid == taxi7 || vehicleid == taxi8)
	{
	    if(AccountInfo[playerid][pJob] == 1)
	    {
	        SetVehicleParamsForPlayer(vehicleid, playerid, 0, 0);
		}
		else if(ispassenger)
		{
      		SetVehicleParamsForPlayer(vehicleid, playerid, 0, 0);
		}
  		else
 		{
            SetVehicleParamsForPlayer(vehicleid, playerid, 0, 1);

		}

	}
//<=============================[Tow Trucks]===================================>
	if(vehicleid == tow1 || vehicleid == tow2 || vehicleid == tow3 || vehicleid == tow4)
	{
	    if(AccountInfo[playerid][pJob] == 9)
	    {
	        SetVehicleParamsForPlayer(vehicleid, playerid, 0, 0);
		}
		else if(ispassenger)
		{
      		SetVehicleParamsForPlayer(vehicleid, playerid, 0, 0);
		}
  		else
 		{
            SetVehicleParamsForPlayer(vehicleid, playerid, 0, 1);

		}

	}
//<=============================[Pizza boy bikes]===================================>
	if(vehicleid == pizza1 || vehicleid == pizza2 || vehicleid == pizza3 || vehicleid == pizza4 || vehicleid == pizza5 || vehicleid == pizza6)
	{
	    if(AccountInfo[playerid][pJob] == 2)
	    {
	        SetVehicleParamsForPlayer(vehicleid, playerid, 0, 0);
		}
		else if(ispassenger)
		{
      		SetVehicleParamsForPlayer(vehicleid, playerid, 0, 0);
		}
  		else
 		{
            SetVehicleParamsForPlayer(vehicleid, playerid, 0, 1);

		}

	}
//<=============================[Aeroplanes]===================================>
	if(vehicleid == pilot1 || vehicleid == pilot2 || vehicleid == pilot3 || vehicleid == pilot4 || vehicleid == pilot5 || vehicleid == pilot6 || vehicleid == pilot7 || vehicleid == pilot8)
	{
	    if(AccountInfo[playerid][pJob] == 3)
	    {
	        SetVehicleParamsForPlayer(vehicleid, playerid, 0, 0);
		}
		else if(ispassenger)
		{
      		SetVehicleParamsForPlayer(vehicleid, playerid, 0, 0);
	  	}
	  	else
 		{
            SetVehicleParamsForPlayer(vehicleid, playerid, 0, 1);

		}

	}
//<===============================[Church Cars]================================>
	if(vehicleid == church1 || vehicleid == church2 || vehicleid == church3 || vehicleid == church4 || vehicleid == church5 || vehicleid == church6 || vehicleid == church7)
	{
	    if(AccountInfo[playerid][pJob] == 5)
	    {
	        SetVehicleParamsForPlayer(vehicleid, playerid, 0, 0);
		}
		else if(ispassenger)
		{
      		SetVehicleParamsForPlayer(vehicleid, playerid, 0, 0);
		}
  		else
 		{
            SetVehicleParamsForPlayer(vehicleid, playerid, 0, 1);
		}
	}
//======================================[Vanjob]=================================
	if(vehicleid == Vanjob1 || vehicleid == Vanjob2 || vehicleid == Vanjob3 || vehicleid == Vanjob4)
	{
        SetVehicleParamsForPlayer(vehicleid, playerid, 0, 1);
	}
//=====================================[Bus]====================================
	if(vehicleid == Busjob1 || vehicleid == Busjob2 || vehicleid == Busjob3 || vehicleid == Busjob4 || vehicleid == Busjob5 || vehicleid == Busjob6)
	{
        SetVehicleParamsForPlayer(vehicleid, playerid, 0, 1);
	}
//===================================[Bus Car]==================================
	if(vehicleid == Buscar1 || vehicleid == Buscar2 || vehicleid == Buscar3)
	{
        SetVehicleParamsForPlayer(vehicleid, playerid, 0, 1);
	}
//===================================[Sweeper]==================================
	if(vehicleid == Cleanjob1 || vehicleid == Cleanjob2 || vehicleid == Cleanjob3 || vehicleid == Cleanjob4 || vehicleid == Cleanjob5 || vehicleid == Cleanjob6 || vehicleid == Cleanjob7 || vehicleid == Cleanjob8)
	{
        SetVehicleParamsForPlayer(vehicleid, playerid, 0, 1);
	}
//=====================================[News]===================================
	if(vehicleid == newsjob1 || vehicleid == newsjob2 || vehicleid == newsjob3 || vehicleid == newsjob4 || vehicleid == newsjob5)
	{
	    if(AccountInfo[playerid][pJob] == 6)
	    {
	        SetVehicleParamsForPlayer(vehicleid, playerid, 0, 0);
		}
		else if(ispassenger)
		{
      		SetVehicleParamsForPlayer(vehicleid, playerid, 0, 0);
		}
  		else
 		{
            SetVehicleParamsForPlayer(vehicleid, playerid, 0, 1);
		}
	}
//<============================[BMV Driving School]===================================>
	if(vehicleid == bmv1 || vehicleid == bmv2 || vehicleid == bmv3 || vehicleid == bmv4 || vehicleid == bmv5 || vehicleid == bmv6)
	{
        SetVehicleParamsForPlayer(vehicleid, playerid, 0, 1);
	}
//<=============================[Fire Trucks]===================================>
	if(vehicleid == fire1 || vehicleid == fire2)
	{
	    if(AccountInfo[playerid][pTeam] == 1  || AccountInfo[playerid][pJob] == 7)
	    {
	        SetVehicleParamsForPlayer(vehicleid, playerid, 0, 0);
		}
		else if(ispassenger)
		{
      		SetVehicleParamsForPlayer(vehicleid, playerid, 0, 0);
		}
  		else
 		{
            SetVehicleParamsForPlayer(vehicleid, playerid, 0, 1);
		}
	}
//<=============================[Ambulance]===================================>
	if(vehicleid == Ambul1 || vehicleid == Ambul2 || vehicleid == Ambul3 || vehicleid == Ambul4 || vehicleid == Ambul5 || vehicleid == Ambul6)
	{
	    if(AccountInfo[playerid][pTeam] == 1  || AccountInfo[playerid][pJob] == 8)
	    {
	        SetVehicleParamsForPlayer(vehicleid, playerid, 0, 0);
		}
		else if(ispassenger)
		{
      		SetVehicleParamsForPlayer(vehicleid, playerid, 0, 0);
		}
  		else
 		{
            SetVehicleParamsForPlayer(vehicleid, playerid, 0, 1);
		}
	}
//<===============================[Forelli Cars]================================>
	if(vehicleid == Forelli1|| vehicleid == Forelli2 || vehicleid == Forelli3 || vehicleid == Forelli4 || vehicleid == Forelli5 || vehicleid == Forelli6 || vehicleid == Forelli7 || vehicleid == Forelli8 || vehicleid == Forelli9 || vehicleid == Forelli10 || vehicleid == Forelli11)
	{
	    if(AccountInfo[playerid][pTeam] == 1  || AccountInfo[playerid][pTeam] == 2 || AccountInfo[playerid][pTeam] == 3 || AccountInfo[playerid][pTeam] == 4 || AccountInfo[playerid][pTeam] == 5)
	    {
	        SetVehicleParamsForPlayer(vehicleid, playerid, 0, 0);
		}
		else if(ispassenger)
		{
      		SetVehicleParamsForPlayer(vehicleid, playerid, 0, 0);
		}
		else
		{
		    SetVehicleParamsForPlayer(vehicleid, playerid, 0, 1);
		}
	}
//<==============================[Gecko Cars]================================>
	if(vehicleid == Gecko1|| vehicleid == Gecko2 || vehicleid == Gecko3 || vehicleid == Gecko4 || vehicleid == Gecko5 || vehicleid == Gecko6 || vehicleid == Gecko7 || vehicleid == Gecko8 || vehicleid == Gecko9 || vehicleid == Gecko10)
	{
	    if(AccountInfo[playerid][pTeam] == 1  || AccountInfo[playerid][pTeam] == 2 || AccountInfo[playerid][pTeam] == 3 || AccountInfo[playerid][pTeam] == 4 || AccountInfo[playerid][pTeam] == 5)
	    {
	        SetVehicleParamsForPlayer(vehicleid, playerid, 0, 0);
		}
		else if(ispassenger)
		{
      		SetVehicleParamsForPlayer(vehicleid, playerid, 0, 0);
		}
		else
		{
		    SetVehicleParamsForPlayer(vehicleid, playerid, 0, 1);
		}
	}
//<=========================[ Northside Cars]==================================>
	if(vehicleid == north1 || vehicleid == north2 || vehicleid == north3 || vehicleid == north4 || vehicleid == north5 || vehicleid == north6 || vehicleid == north7 || vehicleid == north8)
	{
	    if(AccountInfo[playerid][pTeam] == 1  || AccountInfo[playerid][pTeam] == 2 || AccountInfo[playerid][pTeam] == 3 || AccountInfo[playerid][pTeam] == 4 || AccountInfo[playerid][pTeam] == 5)
	    {
	        SetVehicleParamsForPlayer(vehicleid, playerid, 0, 0);
		}
		else if(ispassenger)
		{
      		SetVehicleParamsForPlayer(vehicleid, playerid, 0, 0);
		}
		else
		{
		    SetVehicleParamsForPlayer(vehicleid, playerid, 0, 1);
		}
	}
//<========================[ The Lost's Vehicles ]=============================>
	if(vehicleid == Biker1|| vehicleid == Biker2 || vehicleid == Biker3 || vehicleid == Biker4 || vehicleid == Biker5 || vehicleid == Biker6 || vehicleid == Biker7|| vehicleid == Biker8 || vehicleid == Biker9)
	{
	    if(AccountInfo[playerid][pTeam] == 1  || AccountInfo[playerid][pTeam] == 2 || AccountInfo[playerid][pTeam] == 3 || AccountInfo[playerid][pTeam] == 4 || AccountInfo[playerid][pTeam] == 5)
	    {
	        SetVehicleParamsForPlayer(vehicleid, playerid, 0, 0);
		}
		else if(ispassenger)
		{
      		SetVehicleParamsForPlayer(vehicleid, playerid, 0, 0);
		}
		else
		{
		    SetVehicleParamsForPlayer(vehicleid, playerid, 0, 1);
		}
	}
//<=============================[ Cop's Cars]==================================>
	if(vehicleid == cop24 || vehicleid == cop25 || vehicleid == cop26 || vehicleid == cop27)
	{
	    if(AccountInfo[playerid][pTeam] == 1)
	    {
	        SetVehicleParamsForPlayer(vehicleid, playerid, 0, 0);
		}
		else if(ispassenger)
		{
      		SetVehicleParamsForPlayer(vehicleid, playerid, 0, 0);
		}
		else
		{
		    SetVehicleParamsForPlayer(vehicleid, playerid, 0, 1);
		}
	}
//<=============================[ Cop's Cars]==================================>
	if(vehicleid == cop1 || vehicleid == cop2 || vehicleid ==cop3  || vehicleid == cop4 || vehicleid == cop5 || vehicleid == cop6 || vehicleid == cop7 || vehicleid == cop8 || vehicleid == cop9 || vehicleid == cop10 || vehicleid == cop11 || vehicleid == cop12 || vehicleid == cop13 || vehicleid == cop14 || vehicleid == cop15 || vehicleid == cop16 || vehicleid == cop17 || vehicleid == cop18 || vehicleid == cop19 || vehicleid == cop20 || vehicleid == cop21 || vehicleid == cop22 || vehicleid == cop23)
	{
	    if(AccountInfo[playerid][pTeam] == 1)
	    {
	        SetVehicleParamsForPlayer(vehicleid, playerid, 0, 0);
		}
		else if(ispassenger)
		{
      		SetVehicleParamsForPlayer(vehicleid, playerid, 0, 0);
		}
		else
		{
		    SetVehicleParamsForPlayer(vehicleid, playerid, 0, 1);
		}
	}
	if(AccountInfo[playerid][DLicense] == 0){GameTextForPlayer(playerid, "~r~You don't have a driving license!", 5000, 5);}
	new str[30];
	format(str,sizeof(str),"~b~%s",VehicleNames[GetVehicleModel(vehicleid) - 400]);
	GameTextForPlayer(playerid, str, 5000, 1);
	PetrolUpdate();
	return 0;
}
//<=================================[Player Death]=============================>
public OnPlayerDeath(playerid, killerid, reason)
{
	new send[256],File:hFile=fopen("/Server Logs/Death.ini", io_append);
	new pname[18], killer[18], Hours, Minutes, Seconds;
 	GetPlayerName(playerid, pname, sizeof(pname));
 	GetPlayerName(playerid, killer, sizeof(pname));
	gettime(Hours,Minutes,Seconds);
	format(send, sizeof(send), "[%d:%d] %s(%d) killed %s(%d)r\n", Hours, Minutes,killer, killerid, pname, playerid);
	fwrite(hFile,send);
	fclose(hFile);
	return 1;
}
//<=================================[Player Text]==============================>
public OnPlayerText(playerid, text[])
	{
    if (AccountInfo[playerid][Mute] == 1)
	{
	    SendClientMessage(playerid, COLOUR_RED, "You are muted! You cannot talk.");
	    return 0;
	}
	else if (AccountInfo[playerid][Mute] == 0)
	{
        new Seconds,Minutes,Hours;
		new string[128];
 		new pname[18];
 		new edit;
 		GetPlayerName(playerid, pname, sizeof(pname));
        if(strfind(pname, "_", true) != -1)
        {
			edit = strfind(pname, "_", true);
			strins(pname, " ", edit);
			format(string, sizeof(string),"[Local] %s: %s", pname, text);
			ProxDetector(30.0, playerid, string,COLOUR_LOCAL,COLOUR_LOCAL,COLOUR_LOCAL,COLOUR_LOCAL,COLOUR_LOCAL);
			gettime(Hours,Minutes,Seconds);
			new send[256],File:hFile=fopen("/Server Logs/Local Chat.ini", io_append);
			format(send, sizeof(send), "[%d:%d][Local] %s (%d): '%s'\r\n", Hours, Minutes,pname, playerid, string);
			fwrite(hFile,send);
			fclose(hFile);
			return 0;
		}
    	format(string, sizeof(string),"[Local] %s: %s", pname, text);
		ProxDetector(30.0, playerid, string,COLOUR_LOCAL,COLOUR_LOCAL,COLOUR_LOCAL,COLOUR_LOCAL,COLOUR_LOCAL);
		gettime(Hours,Minutes,Seconds);
		new send[256],File:hFile=fopen("/Server Logs/Local Chat.ini", io_append);
		format(send, sizeof(send), "[%d:%d][Local] %s (%d): '%s'\r\n", Hours, Minutes,pname, playerid, string);
		fwrite(hFile,send);
		fclose(hFile);
		return 0;
	}
	return 0;
}
//===========================[Pickups and Returns]=============================>
public OnPlayerPickUpPickup(playerid, pickupid)
{
	new moneybefore, moneyafter, newmoney;
	moneybefore = GetPlayerMoney(playerid);
	if (pickupid == PDMain )
    {
        SetPlayerInterior(playerid, 10);
		SetPlayerPos(playerid,246.3782,110.1007,1003.2257);
	}
	if (pickupid == PDMainExit )
    {
        SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid,-1605.6774,713.5526,13.4047);
	}
    if (pickupid == PDUnder )
    {
        SetPlayerInterior(playerid, 10);
		SetPlayerPos(playerid,215.7864,124.0821,1003.2188);
	}
    if (pickupid == PDUnderExit )
    {
        SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid,-1590.3430,716.1998,-5.2422);
    }
    if (pickupid == Townhall )
    {
        SetPlayerInterior(playerid, 3);
		SetPlayerPos(playerid,388.871979, 173.804993, 1008.389954);
	}
    if (pickupid == TownhallExit )
    {
        SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid,-2763.5215,375.8120,6.0707);
    }
    if (pickupid == CasinoEnter )
    {
        SetPlayerInterior(playerid, 1);
		SetPlayerPos(playerid,2233.8032 ,1711.8038,1011.6312);
    }
	if (pickupid == CasinoMeeting )
    {
		if(IsPlayerFourCorners(playerid) == 1)
		{
			SetPlayerInterior(playerid, 2);
			SetPlayerPos(playerid,2182.9836,1622.0292,1043.4723);
		}
		else
		{
		    SendClientMessage(playerid,COLOUR_HEADER,"You try to open the door but it is locked.");
		}
    }
	if (pickupid == CasinoMeetingExit )
    {
        SetPlayerInterior(playerid, 1);
		SetPlayerPos(playerid,2269.6392,1634.8390,1008.3594);
    }
	if (pickupid == CasinoCarparkExit )
    {
        SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid,-1704.6282,1017.3804,17.5859);
    }
	if (pickupid == CasinoCarpark )
    {
		if(IsPlayerFourCorners(playerid) == 1)
		{
	        SetPlayerInterior(playerid, 2);
			SetPlayerPos(playerid,2182.9836,1622.0292,1043.4723);
		}
		else
		{
		    SendClientMessage(playerid,COLOUR_HEADER,"You try to open the door but it is locked.");
		}
    }
    if (pickupid == CasinoExit )
    {
        SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid,-1754.2841,958.9117,24.8828);
		moneyafter = GetPlayerMoney(playerid);
		if(moneybefore != moneyafter)
		{
		    newmoney = moneyafter - moneybefore;
		    GivePlayerMoney(playerid, -newmoney);
		    SendClientMessage(playerid,COLOUR_ADMINRED,"[Server]: I've reset your money to when you entered the casino, don't use the mini games inside.");
		}
    }
	if (pickupid == ZIP )
	{
        GameTextForPlayer(playerid, "~g~Welcome to ZIP ~n~ ~r~Type /enterzip to buy a new Skin", 6000, 3);
	}
    if (pickupid == Shop )
    {
        SetPlayerInterior(playerid, 17);
		SetPlayerPos(playerid,-25.884499, -185.868988, 1003.549988);
    }
    if (pickupid == ShopExit )
    {
        SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid,-2442.1724,752.2322,35.1786);
    }
    if (pickupid == Jizzys )
    {
        SetPlayerInterior(playerid, 3);
		SetPlayerPos(playerid,-2638.8232,1407.3395,906.4609);
	}
    if (pickupid == JizzysExit )
    {
        SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid,-2625.0266,1409.4805,7.0938);
	}
	if (pickupid == JizzysRoof )
    {
        SetPlayerInterior(playerid, 3);
		SetPlayerPos(playerid,-2660.8088,1413.4370,922.1953);
	}
	if (pickupid == JizzysRoofExit )
    {
        SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid,-2661.4607,1424.6960,23.8984);
    }
    if (pickupid == Mistys )
    {
        SetPlayerInterior(playerid, 11);
		SetPlayerPos(playerid,501.6356,-71.1598,998.7578);
	}
	if (pickupid == MistysExit )
    {
        SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid,-2244.1355,-88.1426,35.3203);
    }
    if (pickupid == Forelli )
    {
        SetPlayerInterior(playerid, 2);
		SetPlayerPos(playerid,2528.1028,-1302.0492,1048.2891);
		SetPlayerFacingAngle(playerid, 76.8668);
    }
    if (pickupid == ForelliExit )
    {
        SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid,-2278.2888,2288.0947,4.9661);
	}
    if (pickupid == Gecko )
    {
        SetPlayerInterior(playerid, 1);
		SetPlayerPos(playerid,1416.7500,-45.4858,1000.9269);
		SetPlayerFacingAngle(playerid, 76.8668);
    }
    if (pickupid == GeckoExit)
    {
        SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid,-1972.1532,-2434.0574,30.6250);
	}
    if (pickupid == HospitalJob)
    {
		if(AccountInfo[playerid][pJob] == 8)
		{
				GameTextForPlayer(playerid, "~g~San Fierro Medical Center ~n~ ~r~ Hurry up, your late ~n~ ~g~Type /Duty", 6000, 3);
		}
		else
		{
				GameTextForPlayer(playerid, "~g~San Fierro Medical Center ~n~ ~r~Paramedics Needed! ~n~ ~g~Type /Getjob", 6000, 3);
		}
	}
 	if (pickupid == Hospital)
    {
		SetPlayerPos(playerid,-2674.9690,664.2777,13701.4980);
		SetPlayerFacingAngle( playerid, 91.0093);
	}
 	if (pickupid == HospitalExit)
    {
		SetPlayerPos(playerid,-2654.3420,636.9216,14.4531);
		SetPlayerFacingAngle( playerid, 183.5589);
	}
	if (pickupid == HospitalRoof )
    {
		if(AccountInfo[playerid][pJob] == 8)
		{
				GameTextForPlayer(playerid, "~g~San Fierro Medical Center Helipad~n~ ~r~ Be careful with the Trauma Chopper", 6000, 3);
                SetPlayerPos(playerid,-2686.7188,567.0162,51.2923);
		}
		else
		{
				GameTextForPlayer(playerid, "~r~Unauthorised Access, Staff Only!", 6000, 3);
		}
	}
	if (pickupid == HospitalRoofExit)
    {
    	SetPlayerPos(playerid,-2664.2051,636.5522,14.4531);
	}
    if (pickupid == Church)
    {
        SetPlayerInterior(playerid, 11);
		SetPlayerPos(playerid,1963.9240,-352.7893,1092.9454);
  		SetPlayerFacingAngle( playerid, 91.0093);
    }
    if (pickupid == ChurchExit)
    {
  		SetPlayerPos(playerid,-1985.5901,1118.0232,53.4715);
  		SetPlayerInterior(playerid, 0);
  		SetPlayerFacingAngle( playerid, 269.0422);
    }
	if (pickupid == TaxiEnter )
	{
        GameTextForPlayer(playerid, "~g~Roadrunner Taxi's ~n~ ~r~Job Vacancies Apply Within", 6000, 3);
        SetPlayerInterior(playerid, 3);
        SetPlayerPos(playerid,1494.5426,1305.4622,1093.2891);
	}
	if (pickupid == TaxiExit )
	{
        SetPlayerInterior(playerid, 0);
        SetPlayerPos(playerid,-1611.7838,1284.0569,7.1856);
	}
    if (pickupid == PizzaEnter )
	{
        GameTextForPlayer(playerid, "~g~Pizza Place ~n~ ~r~Job Vacancies Apply Within", 6000, 3);
        SetPlayerInterior(playerid, 5);
        SetPlayerPos(playerid,372.1754,-131.4264,1001.4922);
	}
 	if (pickupid == PizzaExit )
	{
        SetPlayerInterior(playerid, 0);
        SetPlayerPos(playerid,-1804.8585,940.8243,24.8906);
	}
 	if (pickupid == NewsIn )
    {
		SetPlayerPos(playerid, 245.2307, 304.7632, 999.1484);
		SetPlayerInterior(playerid,0);
    }
    if (pickupid == NewsExit )
    {
        SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid,-2521.2202,-620.8552,132.7225);
    }
	if (pickupid == PDDuty )
	{
		if(AccountInfo[playerid][pTeam] == 1)
		{
				GameTextForPlayer(playerid, "~r~ Hurry up, your late ~n~ ~g~Type /Duty", 6000, 3);
		}
		else
		{
		}
	}
    if (pickupid == Gaydar )
    {
        SetPlayerInterior(playerid, 17);
		SetPlayerPos(playerid,493.5519,-21.5690,1000.6797);
    }
    if (pickupid == GaydarExit )
    {
        SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid,-2554.1641,193.4018,6.1663);
	}
	if (pickupid == JobCenterIn )
    {
        SetPlayerInterior(playerid, 12);
		SetPlayerPos(playerid,2324.33,-1144.79,1050.71);
	}
    if (pickupid == JobCenterOut )
    {
        SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid,-2651.9260,376.4742,5.3505);
	}
	if (pickupid == BankIn )
    {
        SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid,2309.4832,-15.3408,26.7496);
	}
	if (pickupid == BankOut )
    {
        SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid,-1946.3613,561.6792,35.1726);
	}
	if (pickupid == BMEaster )
    {
        SendClientMessage(playerid, COLOUR_HEADER, "Sup' Doc hurry up man I don't wanna draw any attention.");
        GameTextForPlayer(playerid, "~g~To Import Drugs:~b~ /importdrugs ~n~ ~g~To Import Firearms:~b~ /importfirearms", 6000, 3);
	}
	if (pickupid == BMGarcia )
    {
        SendClientMessage(playerid, COLOUR_HEADER, "Sup' Man what you looking for?");
        GameTextForPlayer(playerid, "~g~To Import Drugs:~b~ /import drugs~n~ ~g~To Import Firearms:~b~ /import firearms", 6000, 3);
	}
	if (pickupid == SpawnInfo )
    {
	    GameTextForPlayer(playerid, "Type (/tutorial) for a guide to our server", 6000, 4);
	}
	if (pickupid == DrivingTest )
    {
	    GameTextForPlayer(playerid, "Welcome to DSA Driving Standard Agency ~n~ ~n~ If you would like to book your practical test type /booktest ~n~ A practical test currently costs ~r~ $500 ~n~ ~n~ DSA - All rights reserved", 6000, 4);
	}
	if (pickupid == BankInfo )
    {
		new Teller = random(sizeof(BankTill));
		SetPlayerPos(playerid, BankTill[Teller][0], BankTill[Teller][1], BankTill[Teller][2]);
	    ShowPlayerDialog(playerid, 24, DIALOG_STYLE_LIST,"San Andreas Federal Bank", "Make a Deposit\nMake a Withdrawal\nView your Balance", "Accept", "Cancel");
		TogglePlayerControllable(playerid,0);
	}
 	if (pickupid == FireJob )
	{
		if(AccountInfo[playerid][pJob] == 7)
		{
				GameTextForPlayer(playerid, "~g~San Fierro Fire Department ~n~ ~r~ It's your shift. ~n~ ~g~Type /Duty", 6000, 3);
		}
		else
		{
				GameTextForPlayer(playerid, "~g~San Fierro Fire Department ~n~ ~r~Firefighters Needed! ~n~ ~g~Type /Getjob", 6000, 3);
		}
	}
    if (pickupid == Jobi )
    {
	    SendClientMessage(playerid, COLOUR_OTHER, "You now have to decide what job you would like");
	    SendClientMessage(playerid, COLOUR_OTHER, "Type /jobsearch[selection]");
	    SendClientMessage(playerid, COLOUR_OTHER, "for example /jobsearch[taxi]or [pizzaboy] ");
	    SendClientMessage(playerid, COLOUR_OTHER, "And the search will return if there are any vacancies");
	}
 	if (pickupid == Mistysi)
    {
	    GameTextForPlayer(playerid, "~g~Welcome to Mistys ~n~ ~r~ To buy a drink  ~n~ ~g~Type /buydrink ~n~", 6000, 3);
	}
	if (pickupid == Mistysstaff )
    {
        SetPlayerInterior(playerid, 11);
		SetPlayerPos(playerid,497.5213,-79.7381,1007.0469);
	}
	if (pickupid == MistyStaffExit )
    {
        SetPlayerInterior(playerid, 11);
		SetPlayerPos(playerid,499.2210,-78.8303,998.7578);
	}
    if (pickupid == TaxiJob )
    {
    	GameTextForPlayer(playerid, "Type /getjob to work for Roadrunners Taxi Company.", 6000, 4);
	}
	if (pickupid == PizzaJob )
    {
    	GameTextForPlayer(playerid, "Type /getjob to work as a delivery driver for Pizza Place. ", 6000, 4);
	}
	if (pickupid == PilotJob)
    {
    	GameTextForPlayer(playerid, "Type /getjob to work as a for San Andreas Airways. ", 6000, 4);
	}
	if (pickupid == PilotEnter)
	{
	    SetPlayerPos(playerid, 228.5915,1822.7849,7.4141);
	}
	if (pickupid == PilotExit)
	{
	    SetPlayerPos(playerid, -1261.8082,38.5117,14.1390);
	}
	if (pickupid == ApartmentIn)
    {
		SetPlayerInterior(playerid, 18);
		SetPlayerPos(playerid,1726.6353,-1642.0940,20.2250);
		GameTextForPlayer(playerid, "~g~Atrium Apartment Complex. ", 6000, 6);
	}
	if (pickupid == ApartmentOut)
    {
		SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid,-2354.2227,493.7919,30.8833);
	}
	if (pickupid == Wang1p)
	{
		GameTextForPlayer(playerid, "  Moonbeam      $7,499    Level 7", 6000, 4);
	}
	if (pickupid == Wang2p)
	{
		GameTextForPlayer(playerid, "  Admiral   $6,999    Level 6", 6000, 4);
	}
	if (pickupid == Wang3p)
	{
		GameTextForPlayer(playerid, "  Oceanic  $8,499    Level 8", 6000, 4);
	}
	if (pickupid == Wang4p)
	{
		GameTextForPlayer(playerid, "  Sentinel   $7,999    Level 8", 6000, 4);
	}
	if (pickupid == Wang5p)
	{
		GameTextForPlayer(playerid, "  Huntley   $9,999    Level 10", 6000, 4);
	}
	if (pickupid == Wang6p)
	{
		GameTextForPlayer(playerid, "  Washington   $8,499    Level 9", 6000, 4);
	}
	if (pickupid == Wang7p)
	{
		GameTextForPlayer(playerid, "  Stallion    $14,999    Level 13", 6000, 4);
	}
	if (pickupid == Wang8p)
	{
		GameTextForPlayer(playerid, "  Patriot   $19,999    Level 15", 6000, 4);
	}
	if (pickupid == Wang9p)
	{
		GameTextForPlayer(playerid, "  Savannah   $12,499    Level 12", 6000, 4);
	}
	if (pickupid == Wang10p)
	{
		GameTextForPlayer(playerid, "  Hermes   $12,999    Level 12", 6000, 4);
	}
	if (pickupid == Wango1p)
	{
		GameTextForPlayer(playerid, "  Camper     $2,999    Level 2", 6000, 4);
	}
	if (pickupid == Wango2p)
	{
		GameTextForPlayer(playerid, "  Tampa   $6,499    Level 4", 6000, 4);
	}
	if (pickupid == Wango3p)
	{
		GameTextForPlayer(playerid, "  Landstalker  $3,999    Level 2", 6000, 4);
	}
	if (pickupid == Wango4p)
	{
		GameTextForPlayer(playerid, "  Picador   $6,250    Level 3", 6000, 4);
	}
	if (pickupid == Wango5p)
	{
		GameTextForPlayer(playerid, "  Clover   $6,999    Level 5", 6000, 4);
	}
	if (pickupid == Wango6p)
	{
		GameTextForPlayer(playerid, "  Journey   $4,999    Level 2", 6000, 4);
	}
	if (pickupid == Wangbuy)
	{
		GameTextForPlayer(playerid, "/buycar [carname] [colour1] [colour2]", 6000, 4);
	}
	if (pickupid == Ottobuy)
	{
		GameTextForPlayer(playerid, "/buycar [carname] [colour1] [colour2]", 6000, 4);
	}
    if (pickupid == otto1p)
	{
		GameTextForPlayer(playerid, "  Buffalo   $21,999    Level 19", 6000, 4);
	}
	if (pickupid == otto2p)
	{
		GameTextForPlayer(playerid, "  ZR-350   $29,999    Level 25", 6000, 4);
	}
	if (pickupid == otto3p)
	{
		GameTextForPlayer(playerid, "  Infernus     $24,999    Level 23", 6000, 4);
	}
	if (pickupid == otto4p)
	{
		GameTextForPlayer(playerid, "  Jester   $22,999    Level 20", 6000, 4);
	}
	if (pickupid == otto5p)
	{
		GameTextForPlayer(playerid, "  Sultan     $19,999    Level 17", 6000, 4);
	}
	if (pickupid == otto6p)
	{
		GameTextForPlayer(playerid, "  Stafford   $24,999    Level 18", 6000, 4);
	}
	if (pickupid == otto7p)
	{
		GameTextForPlayer(playerid, "  Sabre   $17,999    Level 16", 6000, 4);
	}
	if (pickupid == otto8p)
	{
		GameTextForPlayer(playerid, "  Flash   $9,999    Level 11", 6000, 4);
	}
}
//<=============================[Player Enter Checkpoint]======================>
public OnPlayerEnterCheckpoint(playerid)
{
    return 1;
}
public OnPlayerEnterDynamicCP(playerid, checkpointid)
{
	new Gang = AccountInfo[playerid][pTeam];
//<========================[Aeroplane Checkpoint]=============================>
	if (checkpointid == Aeroplane)
    {
        switch(Gang)
        {
			case 1:
			{
				GameTextForPlayer(playerid,"Get this contraband back to the station immediatley.",3000,5);
				PoliceDropOff = CreateDynamicCP(-1606.4156,677.8490,-5.1067, 3.0, -1,  -1,  -1,  100.0);
                DestroyDynamicCP(Aeroplane);
				return 1;
			}
			case 2:
            {
                new Cocaine1,Boodah1,Smack1,Ecstasy1,Firearms1,Vest1;
				GameTextForPlayer(playerid,"Right, everything is loaded essay.",3000,5);
		        TheLostDropOff = CreateDynamicCP(-2459.6917,-95.0156,26.1015, 3.0, -1,  -1,  -1,  100.0);
		        DestroyDynamicCP(Aeroplane);
		        Cocaine1  = dini_Int("/Import/Plane.ini","Cocaine");
		        Boodah1   = dini_Int("/Import/Plane.ini","Weed");
		        Smack1    = dini_Int("/Import/Plane.ini","Crack");
		        Ecstasy1  = dini_Int("/Import/Plane.ini","Ecstasy");
		        Firearms1 = dini_Int("/Import/Plane.ini","Firearms");
		        Vest1 	  = dini_Int("/Import/Plane.ini","Vest");
				dini_IntSet("/Gangs/TheLost.ini", "IWeed"     , Boodah1);
				dini_IntSet("/Gangs/TheLost.ini", "ICrack"    , Cocaine1);
				dini_IntSet("/Gangs/TheLost.ini", "ISniff"    , Smack1);
				dini_IntSet("/Gangs/TheLost.ini", "IPills"    , Ecstasy1);
				dini_IntSet("/Gangs/TheLost.ini", "IFirearms" , Firearms1);
				dini_IntSet("/Gangs/TheLost.ini", "IKevlar"   , Vest1);
		        return 1;
			}
			case 3:
			{
                new Cocaine2,Boodah2,Smack2,Ecstasy2,Firearms2,Vest2;
				GameTextForPlayer(playerid,"Right, everything is loaded move it kid.",3000,5);
		        DisablePlayerCheckpoint(playerid);
		        ForelliDropOff = CreateDynamicCP(-2211.0125,-115.2953,35.4035, 3.0, -1,  -1,  -1,  100.0);
		        DestroyDynamicCP(Aeroplane);
		        Cocaine2  = dini_Int("/Import/Plane.ini","Cocaine");
		        Boodah2   = dini_Int("/Import/Plane.ini","Weed");
		        Smack2    = dini_Int("/Import/Plane.ini","Crack");
		        Ecstasy2  = dini_Int("/Import/Plane.ini","Ecstasy");
		        Firearms2 = dini_Int("/Import/Plane.ini","Firearms");
		        Vest2 	  = dini_Int("/Import/Plane.ini","Vest");
				dini_IntSet("/Gangs/Forelli.ini", "IWeed"     , Boodah2);
				dini_IntSet("/Gangs/Forelli.ini", "ICrack"    , Cocaine2);
				dini_IntSet("/Gangs/Forelli.ini", "ISniff"    , Smack2);
				dini_IntSet("/Gangs/Forelli.ini", "IPills"    , Ecstasy2);
				dini_IntSet("/Gangs/Forelli.ini", "IFirearms" , Firearms2);
				dini_IntSet("/Gangs/Forelli.ini", "IKevlar"   , Vest2);
				return 1;
			}
			case 4:
			{
                new Cocaine3,Boodah3,Smack3,Ecstasy3,Firearms3,Vest3;
				GameTextForPlayer(playerid,"Right, everything is loaded move it comrade.",3000,5);
		        DisablePlayerCheckpoint(playerid);
		        GeckoDropOff = CreateDynamicCP(-2211.0125,-115.2953,35.4035, 3.0, -1,  -1,  -1,  100.0);
		        DestroyDynamicCP(Aeroplane);
		        Cocaine3  = dini_Int("/Import/Plane.ini","Cocaine");
		        Boodah3   = dini_Int("/Import/Plane.ini","Weed");
		        Smack3    = dini_Int("/Import/Plane.ini","Crack");
		        Ecstasy3  = dini_Int("/Import/Plane.ini","Ecstasy");
		        Firearms3 = dini_Int("/Import/Plane.ini","Firearms");
		        Vest3     = dini_Int("/Import/Plane.ini","Vest");
				dini_IntSet("/Gangs/Gecko.ini", "IWeed"     , Boodah3);
				dini_IntSet("/Gangs/Gecko.ini", "ICrack"    , Cocaine3);
				dini_IntSet("/Gangs/Gecko.ini", "ISniff"    , Smack3);
				dini_IntSet("/Gangs/Gecko.ini", "IPills"    , Ecstasy3);
				dini_IntSet("/Gangs/Gecko.ini", "IFirearms" , Firearms3);
				dini_IntSet("/Gangs/Gecko.ini", "IKevlar"   , Vest3);
				return 1;
			}
			case 5:
			{
                new Cocaine4,Boodah4,Smack4,Ecstasy4,Firearms4,Vest4;
				GameTextForPlayer(playerid,"Right, everything is loaded move it dawg.",3000,5);
		        DisablePlayerCheckpoint(playerid);
		        NorthsideDropOff = CreateDynamicCP(-2645.21,1377.83,7.24, 3.0, -1,  -1,  -1,  100.0);
		        DestroyDynamicCP(Aeroplane);
		        Cocaine4  = dini_Int("/Import/Plane.ini","Cocaine");
		        Boodah4   = dini_Int("/Import/Plane.ini","Weed");
		        Smack4    = dini_Int("/Import/Plane.ini","Crack");
		        Ecstasy4  = dini_Int("/Import/Plane.ini","Ecstasy");
		        Firearms4 = dini_Int("/Import/Plane.ini","Firearms");
		        Vest4 	 = dini_Int("/Import/Plane.ini","Vest");
				dini_IntSet("/Gangs/Northside.ini", "IWeed"     , Boodah4);
				dini_IntSet("/Gangs/Northside.ini", "ICrack"    , Cocaine4);
				dini_IntSet("/Gangs/Northside.ini", "ISniff"    , Smack4);
				dini_IntSet("/Gangs/Northside.ini", "IPills"    , Ecstasy4);
				dini_IntSet("/Gangs/Northside.ini", "IFirearms" , Firearms4);
				dini_IntSet("/Gangs/Northside.ini", "IKevlar"   , Vest4);
				return 1;
			}
		}
	}
//<===========================[Truck Checkpoint]===============================>
	else if (checkpointid == Truck)
    {
        switch(Gang)
        {
			case 1:
			{
				GameTextForPlayer(playerid,"Get this contraband back to the station immediatley.",3000,5);
				PoliceDropOff = CreateDynamicCP(-1606.4156,677.8490,-5.1067, 3.0, -1,  -1,  -1,  100.0);
                DestroyDynamicCP(Truck);
				return 1;
			}
			case 2:
            {
                new Cocaine5,Boodah5,Smack5,Ecstasy5,Firearms5,Vest5;
				GameTextForPlayer(playerid,"Right, everything is loaded essay.",3000,5);
		        DisablePlayerCheckpoint(playerid);
		        TheLostDropOff = CreateDynamicCP(-2459.6917,-95.0156,26.1015, 3.0, -1,  -1,  -1,  100.0);
		        DestroyDynamicCP(Truck);
		        Cocaine5  = dini_Int("/Import/Truck.ini","Cocaine");
		        Boodah5   = dini_Int("/Import/Truck.ini","Weed");
		        Smack5    = dini_Int("/Import/Truck.ini","Crack");
		        Ecstasy5  = dini_Int("/Import/Truck.ini","Ecstasy");
		        Firearms5 = dini_Int("/Import/Truck.ini","Firearms");
		        Vest5 	 = dini_Int("/Import/Truck.ini","Vest");
				dini_IntSet("/Gangs/TheLost.ini", "IWeed"     , Boodah5);
				dini_IntSet("/Gangs/TheLost.ini", "ICrack"    , Cocaine5);
				dini_IntSet("/Gangs/TheLost.ini", "ISniff"    , Smack5);
				dini_IntSet("/Gangs/TheLost.ini", "IPills"    , Ecstasy5);
				dini_IntSet("/Gangs/TheLost.ini", "IFirearms" , Firearms5);
				dini_IntSet("/Gangs/TheLost.ini", "IKevlar"   , Vest5);
		        return 1;
			}
			case 3:
			{
                new Cocaine6,Boodah6,Smack6,Ecstasy6,Firearms6,Vest6;
				GameTextForPlayer(playerid,"Right, everything is loaded move it kid.",3000,5);
		        DisablePlayerCheckpoint(playerid);
		        ForelliDropOff = CreateDynamicCP(-2211.0125,-115.2953,35.4035, 3.0, -1,  -1,  -1,  100.0);
		        DestroyDynamicCP(Truck);
		        Cocaine6  = dini_Int("/Import/Truck.ini","Cocaine");
		        Boodah6   = dini_Int("/Import/Truck.ini","Weed");
		        Smack6    = dini_Int("/Import/Truck.ini","Crack");
		        Ecstasy6  = dini_Int("/Import/Truck.ini","Ecstasy");
		        Firearms6 = dini_Int("/Import/Truck.ini","Firearms");
		        Vest6 	  = dini_Int("/Import/Truck.ini","Vest");
				dini_IntSet("/Gangs/Forelli.ini", "IWeed"     , Boodah6);
				dini_IntSet("/Gangs/Forelli.ini", "ICrack"    , Cocaine6);
				dini_IntSet("/Gangs/Forelli.ini", "ISniff"    , Smack6);
				dini_IntSet("/Gangs/Forelli.ini", "IPills"    , Ecstasy6);
				dini_IntSet("/Gangs/Forelli.ini", "IFirearms" , Firearms6);
				dini_IntSet("/Gangs/Forelli.ini", "IKevlar"   , Vest6);
				return 1;
			}
			case 4:
			{
                new Cocaine7,Boodah7,Smack7,Ecstasy7,Firearms7,Vest7;
				GameTextForPlayer(playerid,"Right, everything is loaded move it comrade.",3000,5);
		        DisablePlayerCheckpoint(playerid);
		        GeckoDropOff = CreateDynamicCP(-2211.0125,-115.2953,35.4035, 3.0, -1,  -1,  -1,  100.0);
		        DestroyDynamicCP(Truck);
		        Cocaine7  = dini_Int("/Import/Truck.ini","Cocaine");
		        Boodah7   = dini_Int("/Import/Truck.ini","Weed");
		        Smack7    = dini_Int("/Import/Truck.ini","Crack");
		        Ecstasy7  = dini_Int("/Import/Truck.ini","Ecstasy");
		        Firearms7 = dini_Int("/Import/Truck.ini","Firearms");
		        Vest7 	  = dini_Int("/Import/Truck.ini","Vest");
				dini_IntSet("/Gangs/Gecko.ini", "IWeed"     , Boodah7);
				dini_IntSet("/Gangs/Gecko.ini", "ICrack"    , Cocaine7);
				dini_IntSet("/Gangs/Gecko.ini", "ISniff"    , Smack7);
				dini_IntSet("/Gangs/Gecko.ini", "IPills"    , Ecstasy7);
				dini_IntSet("/Gangs/Gecko.ini", "IFirearms" , Firearms7);
				dini_IntSet("/Gangs/Gecko.ini", "IKevlar"   , Vest7);
				return 1;
			}
			case 5:
			{
                new Cocaine8,Boodah8,Smack8,Ecstasy8,Firearms8,Vest8;
				GameTextForPlayer(playerid,"Right, everything is loaded move it dawg.",3000,5);
		        DisablePlayerCheckpoint(playerid);
		        NorthsideDropOff = CreateDynamicCP(-2645.21,1377.83,7.24, 3.0, -1,  -1,  -1,  100.0);
		        DestroyDynamicCP(Truck);
		        Cocaine8  = dini_Int("/Import/Truck.ini","Cocaine");
		        Boodah8   = dini_Int("/Import/Truck.ini","Weed");
		        Smack8    = dini_Int("/Import/Truck.ini","Crack");
		        Ecstasy8  = dini_Int("/Import/Truck.ini","Ecstasy");
		        Firearms8 = dini_Int("/Import/Truck.ini","Firearms");
		        Vest8 	  = dini_Int("/Import/Truck.ini","Vest");
				dini_IntSet("/Gangs/Northside.ini", "IWeed"     , Boodah8);
				dini_IntSet("/Gangs/Northside.ini", "ICrack"    , Cocaine8);
				dini_IntSet("/Gangs/Northside.ini", "ISniff"    , Smack8);
				dini_IntSet("/Gangs/Northside.ini", "IPills"    , Ecstasy8);
				dini_IntSet("/Gangs/Northside.ini", "IFirearms" , Firearms8);
				dini_IntSet("/Gangs/Northside.ini", "IKevlar"   , Vest8);
				return 1;
			}
		}
	}
//<============================[Boat Checkpoint]===============================>
	else if (checkpointid == Boat)
    {
        switch(Gang)
        {
			case 1:
			{
				GameTextForPlayer(playerid,"Get this contraband back to the station immediatley.",3000,5);
				PoliceDropOff = CreateDynamicCP(-1606.4156,677.8490,-5.1067, 3.0, -1,  -1,  -1,  100.0);
                DestroyDynamicCP(Boat);
				return 1;
			}
			case 2:
            {
                new Cocaine9,Boodah9,Smack9,Ecstasy9,Firearms9,Vest9;
				GameTextForPlayer(playerid,"Right, everything is loaded essay.",3000,5);
		        DisablePlayerCheckpoint(playerid);
		        TheLostDropOff = CreateDynamicCP(-2459.6917,-95.0156,26.1015, 3.0, -1,  -1,  -1,  100.0);
		        DestroyDynamicCP(Boat);
		        Cocaine9  = dini_Int("/Import/Boat.ini","Cocaine");
		        Boodah9   = dini_Int("/Import/Boat.ini","Weed");
		        Smack9    = dini_Int("/Import/Boat.ini","Crack");
		        Ecstasy9  = dini_Int("/Import/Boat.ini","Ecstasy");
		        Firearms9 = dini_Int("/Import/Boat.ini","Firearms");
		        Vest9 	  = dini_Int("/Import/Boat.ini","Vest");
				dini_IntSet("/Gangs/TheLost.ini", "IWeed"     , Boodah9);
				dini_IntSet("/Gangs/TheLost.ini", "ICrack"    , Cocaine9);
				dini_IntSet("/Gangs/TheLost.ini", "ISniff"    , Smack9);
				dini_IntSet("/Gangs/TheLost.ini", "IPills"    , Ecstasy9);
				dini_IntSet("/Gangs/TheLost.ini", "IFirearms" , Firearms9);
				dini_IntSet("/Gangs/TheLost.ini", "IKevlar"   , Vest9);
		        return 1;
			}
			case 3:
			{
                new Cocaine0,Boodah0,Smack0,Ecstasy0,Firearms0,Vest0;
				GameTextForPlayer(playerid,"Right, everything is loaded move it kid.",3000,5);
		        DisablePlayerCheckpoint(playerid);
		        ForelliDropOff = CreateDynamicCP(-2211.0125,-115.2953,35.4035, 3.0, -1,  -1,  -1,  100.0);
		        DestroyDynamicCP(Boat);
		        Cocaine0  = dini_Int("/Import/Boat.ini","Cocaine");
		        Boodah0   = dini_Int("/Import/Boat.ini","Weed");
		        Smack0    = dini_Int("/Import/Boat.ini","Crack");
		        Ecstasy0  = dini_Int("/Import/Boat.ini","Ecstasy");
		        Firearms0 = dini_Int("/Import/Boat.ini","Firearms");
		        Vest0 	 = dini_Int("/Import/Boat.ini","Vest");
				dini_IntSet("/Gangs/Forelli.ini", "IWeed"     , Boodah0);
				dini_IntSet("/Gangs/Forelli.ini", "ICrack"    , Cocaine0);
				dini_IntSet("/Gangs/Forelli.ini", "ISniff"    , Smack0);
				dini_IntSet("/Gangs/Forelli.ini", "IPills"    , Ecstasy0);
				dini_IntSet("/Gangs/Forelli.ini", "IFirearms" , Firearms0);
	  			dini_IntSet("/Gangs/Forelli.ini", "IKevlar"   , Vest0);
				return 1;
			}
			case 4:
			{
                new CocaineA,BoodahA,SmackA,EcstasyA,FirearmsA,VestA;
				GameTextForPlayer(playerid,"Right, everything is loaded move it comrade.",3000,5);
		        DisablePlayerCheckpoint(playerid);
		        GeckoDropOff = CreateDynamicCP(-2211.0125,-115.2953,35.4035, 3.0, -1,  -1,  -1,  100.0);
		        DestroyDynamicCP(Boat);
		        CocaineA  = dini_Int("/Import/Boat.ini","Cocaine");
		        BoodahA   = dini_Int("/Import/Boat.ini","Weed");
		        SmackA    = dini_Int("/Import/Boat.ini","Crack");
		        EcstasyA  = dini_Int("/Import/Boat.ini","Ecstasy");
		        FirearmsA = dini_Int("/Import/Boat.ini","Firearms");
		        VestA 	  = dini_Int("/Import/Boat.ini","Vest");
				dini_IntSet("/Gangs/Gecko.ini", "IWeed"     , BoodahA);
				dini_IntSet("/Gangs/Gecko.ini", "ICrack"    , CocaineA);
				dini_IntSet("/Gangs/Gecko.ini", "ISniff"    , SmackA);
				dini_IntSet("/Gangs/Gecko.ini", "IPills"    , EcstasyA);
				dini_IntSet("/Gangs/Gecko.ini", "IFirearms" , FirearmsA);
				dini_IntSet("/Gangs/Gecko.ini", "IKevlar"   , VestA);
   				return 1;
			}
			case 5:
			{
                new CocaineB,BoodahB,SmackB,EcstasyB,FirearmsB,VestB;
				GameTextForPlayer(playerid,"Right, everything is loaded move it dawg.",3000,5);
		        DisablePlayerCheckpoint(playerid);
		        NorthsideDropOff = CreateDynamicCP(-2645.21,1377.83,7.24, 3.0, -1,  -1,  -1,  100.0);
		        DestroyDynamicCP(Boat);
		        CocaineB  = dini_Int("/Import/Boat.ini","Cocaine");
		        BoodahB   = dini_Int("/Import/Boat.ini","Weed");
		        SmackB    = dini_Int("/Import/Boat.ini","Crack");
		        EcstasyB  = dini_Int("/Import/Boat.ini","Ecstasy");
		        FirearmsB = dini_Int("/Import/Boat.ini","Firearms");
		        VestB 	 = dini_Int("/Import/Boat.ini","Vest");
				dini_IntSet("/Gangs/Northside.ini", "IWeed"     , BoodahB);
				dini_IntSet("/Gangs/Northside.ini", "ICrack"    , CocaineB);
				dini_IntSet("/Gangs/Northside.ini", "ISniff"    , SmackB);
				dini_IntSet("/Gangs/Northside.ini", "IPills"    , EcstasyB);
				dini_IntSet("/Gangs/Northside.ini", "IFirearms" , FirearmsB);
				dini_IntSet("/Gangs/Northside.ini", "IKevlar"   , VestB);
				return 1;
			}
		}
	}
//<=============================[Police DropOff]===============================>
	else if (checkpointid == PoliceDropOff)
    {
        switch(Gang)
        {
			case 1:
			{
                DestroyDynamicCP(PoliceDropOff);
				return 1;
			}
			case 2 .. 5:
			{
			    return 0;
			}
		}
	}
//<=============================[The Lost DropOff]=======================================================================================================>
	else if (checkpointid == TheLostDropOff)
    {
        switch(Gang)
        {
			case 1:
			{
			    return 0;
			}
			case 2:
			{
		        new CocaineH,BoodahH,SmackH,EcstasyH,FirearmsH,VestH,NewCocaine,NewBoodah,NewSmack,NewEcstasy,NewFirearms,NewVest;
				GameTextForPlayer(playerid,"Right, everything is off, good job kid.",3000,5);
				DestroyDynamicCP(TheLostDropOff);
		        CocaineH  = dini_Int("/Gangs/TheLost.ini","ISniff");
		        BoodahH   = dini_Int("/Gangs/TheLost.ini","IWeed");
		        SmackH    = dini_Int("/Gangs/TheLost.ini","ICrack");
		        EcstasyH  = dini_Int("/Gangs/TheLost.ini","IPills");
		        FirearmsH = dini_Int("/Gangs/TheLost.ini","IFirearms");
		        VestH     = dini_Int("/Gangs/TheLost.ini","IKevlar");
				NewCocaine  = CocaineH  + dini_Int("/Gangs/TheLost.ini","Cocaine" );
				NewBoodah   = BoodahH   + dini_Int("/Gangs/TheLost.ini","Cannabis");
				NewSmack    = SmackH    + dini_Int("/Gangs/TheLost.ini","Crack"   );
				NewEcstasy  = EcstasyH  + dini_Int("/Gangs/TheLost.ini","Ecstasy" );
				NewFirearms = FirearmsH + dini_Int("/Gangs/TheLost.ini","Firearms");
				NewVest     = VestH     + dini_Int("/Gangs/TheLost.ini","Kevlar"  );
				dini_IntSet("/Gangs/TheLost.ini", "Cannabis", NewBoodah);
				dini_IntSet("/Gangs/TheLost.ini", "Cocaine" , NewCocaine);
				dini_IntSet("/Gangs/TheLost.ini", "Crack"   , NewSmack);
				dini_IntSet("/Gangs/TheLost.ini", "Ecstasy" , NewEcstasy);
				dini_IntSet("/Gangs/TheLost.ini", "Firearms", NewFirearms);
				dini_IntSet("/Gangs/TheLost.ini", "Kevlar"  , NewVest);
				dini_IntSet("/Gangs/TheLost.ini", "IWeed"     , 0);
				dini_IntSet("/Gangs/TheLost.ini", "ICrack"    , 0);
				dini_IntSet("/Gangs/TheLost.ini", "ISniff"    , 0);
				dini_IntSet("/Gangs/TheLost.ini", "IPills"    , 0);
				dini_IntSet("/Gangs/TheLost.ini", "IFirearms" , 0);
				dini_IntSet("/Gangs/TheLost.ini", "IKevlar"   , 0);
				return 1;
			}
			case 3 .. 5:
			{
			    return 0;
			}
		}
	}
//<=============================[Forelli DropOff]========================================================================================================>
	else if (checkpointid == ForelliDropOff)
    {
        switch(Gang)
        {
			case 1, 2:
			{
			    return 0;
			}
			case 3:
			{
		        new CocaineM,BoodahM,SmackM,EcstasyM,FirearmsM,VestM,NewCocaine,NewBoodah,NewSmack,NewEcstasy,NewFirearms,NewVest;
				GameTextForPlayer(playerid,"Right, everything is off, good job kid.",3000,5);
				DestroyDynamicCP(ForelliDropOff);
		        CocaineM  = dini_Int("/Gangs/Forelli.ini","ISniff");
		        BoodahM   = dini_Int("/Gangs/Forelli.ini","IWeed");
		        SmackM    = dini_Int("/Gangs/Forelli.ini","ICrack");
		        EcstasyM  = dini_Int("/Gangs/Forelli.ini","IPills");
		        FirearmsM = dini_Int("/Gangs/Forelli.ini","IFirearms");
		        VestM     = dini_Int("/Gangs/Forelli.ini","IKevlar");
				NewCocaine  = CocaineM  + dini_Int("/Gangs/Forelli.ini","Cocaine" );
				NewBoodah   = BoodahM   + dini_Int("/Gangs/Forelli.ini","Cannabis");
				NewSmack    = SmackM    + dini_Int("/Gangs/Forelli.ini","Crack"   );
				NewEcstasy  = EcstasyM  + dini_Int("/Gangs/Forelli.ini","Ecstasy" );
				NewFirearms = FirearmsM + dini_Int("/Gangs/Forelli.ini","Firearms");
				NewVest     = VestM     + dini_Int("/Gangs/Forelli.ini","Kevlar"  );
				dini_IntSet("/Gangs/Forelli.ini", "Cannabis", NewBoodah);
				dini_IntSet("/Gangs/Forelli.ini", "Cocaine" , NewCocaine);
				dini_IntSet("/Gangs/Forelli.ini", "Crack"   , NewSmack);
				dini_IntSet("/Gangs/Forelli.ini", "Ecstasy" , NewEcstasy);
				dini_IntSet("/Gangs/Forelli.ini", "Firearms", NewFirearms);
				dini_IntSet("/Gangs/Forelli.ini", "Kevlar"  , NewVest);
				dini_IntSet("/Gangs/Forelli.ini", "IWeed"     , 0);
				dini_IntSet("/Gangs/Forelli.ini", "ICrack"    , 0);
				dini_IntSet("/Gangs/Forelli.ini", "ISniff"    , 0);
				dini_IntSet("/Gangs/Forelli.ini", "IPills"    , 0);
				dini_IntSet("/Gangs/Forelli.ini", "IFirearms" , 0);
				dini_IntSet("/Gangs/Forelli.ini", "IKevlar"   , 0);
				return 1;
			}
			case 4, 5:
			{
			    return 0;
			}
		}
	}
//<=============================[Gecko DropOff]===========================================================================================================>
	else if (checkpointid == GeckoDropOff)
    {
        switch(Gang)
        {
			case 1 .. 3:
			{
			    return 0;
			}
			case 4:
			{
		        new CocaineT,BoodahT,SmackT,EcstasyT,FirearmsT,VestT,NewCocaine,NewBoodah,NewSmack,NewEcstasy,NewFirearms,NewVest;
				GameTextForPlayer(playerid,"Right, everything is off, good job kid.",3000,5);
				DestroyDynamicCP(GeckoDropOff);
		        CocaineT  = dini_Int("/Gangs/Gecko.ini","ISniff");
		        BoodahT   = dini_Int("/Gangs/Gecko.ini","IWeed");
		        SmackT    = dini_Int("/Gangs/Gecko.ini","ICrack");
		        EcstasyT  = dini_Int("/Gangs/Gecko.ini","IPills");
		        FirearmsT = dini_Int("/Gangs/Gecko.ini","IFirearms");
		        VestT     = dini_Int("/Gangs/Gecko.ini","IKevlar");
				NewCocaine  = CocaineT  + dini_Int("/Gangs/Gecko.ini","Cocaine" );
				NewBoodah   = BoodahT   + dini_Int("/Gangs/Gecko.ini","Cannabis");
				NewSmack    = SmackT    + dini_Int("/Gangs/Gecko.ini","Crack"   );
				NewEcstasy  = EcstasyT  + dini_Int("/Gangs/Gecko.ini","Ecstasy" );
				NewFirearms = FirearmsT + dini_Int("/Gangs/Gecko.ini","Firearms");
				NewVest     = VestT     + dini_Int("/Gangs/Gecko.ini","Kevlar"  );
				dini_IntSet("/Gangs/Gecko.ini", "Cannabis", NewBoodah);
				dini_IntSet("/Gangs/Gecko.ini", "Cocaine" , NewCocaine);
				dini_IntSet("/Gangs/Gecko.ini", "Crack"   , NewSmack);
				dini_IntSet("/Gangs/Gecko.ini", "Ecstasy" , NewEcstasy);
				dini_IntSet("/Gangs/Gecko.ini", "Firearms", NewFirearms);
				dini_IntSet("/Gangs/Gecko.ini", "Kevlar"  , NewVest);
				dini_IntSet("/Gangs/Gecko.ini", "IWeed"     , 0);
				dini_IntSet("/Gangs/Gecko.ini", "ICrack"    , 0);
				dini_IntSet("/Gangs/Gecko.ini", "ISniff"    , 0);
				dini_IntSet("/Gangs/Gecko.ini", "IPills"    , 0);
				dini_IntSet("/Gangs/Gecko.ini", "IFirearms" , 0);
				dini_IntSet("/Gangs/Gecko.ini", "IKevlar"   , 0);
				return 1;
			}
			case 5:
			{
			    return 0;
			}
		}
	}
//<=============================[Northside DropOff]===========================================================================================================>
	else if (checkpointid == NorthsideDropOff)
    {
        switch(Gang)
        {
			case 1 .. 4:
			{
			    return 0;
			}
			case 5:
			{
		        new CocaineN,BoodahN,SmackN,EcstasyN,FirearmsN,VestN,NewCocaine,NewBoodah,NewSmack,NewEcstasy,NewFirearms,NewVest;
				GameTextForPlayer(playerid,"Right, everything is off, good job kid.",3000,5);
				DestroyDynamicCP(NorthsideDropOff);
		        CocaineN  = dini_Int("/Gangs/Northside.ini","ISniff");
		        BoodahN   = dini_Int("/Gangs/Northside.ini","IWeed");
		        SmackN    = dini_Int("/Gangs/Northside.ini","ICrack");
		        EcstasyN  = dini_Int("/Gangs/Northside.ini","IPills");
		        FirearmsN = dini_Int("/Gangs/Northside.ini","IFirearms");
		        VestN     = dini_Int("/Gangs/Northside.ini","IKevlar");
				NewCocaine  = CocaineN  + dini_Int("/Gangs/Northside.ini","Cocaine" );
				NewBoodah   = BoodahN   + dini_Int("/Gangs/Northside.ini","Cannabis");
				NewSmack    = SmackN    + dini_Int("/Gangs/Northside.ini","Crack"   );
				NewEcstasy  = EcstasyN  + dini_Int("/Gangs/Northside.ini","Ecstasy" );
				NewFirearms = FirearmsN + dini_Int("/Gangs/Northside.ini","Firearms");
				NewVest     = VestN     + dini_Int("/Gangs/Northside.ini","Kevlar"  );
				dini_IntSet("/Gangs/Northside.ini", "Cannabis", NewBoodah);
				dini_IntSet("/Gangs/Northside.ini", "Cocaine" , NewCocaine);
				dini_IntSet("/Gangs/Northside.ini", "Crack"   , NewSmack);
				dini_IntSet("/Gangs/Northside.ini", "Ecstasy" , NewEcstasy);
				dini_IntSet("/Gangs/Northside.ini", "Firearms", NewFirearms);
				dini_IntSet("/Gangs/Northside.ini", "Kevlar"  , NewVest);
				dini_IntSet("/Gangs/Northside.ini", "IWeed"     , 0);
				dini_IntSet("/Gangs/Northside.ini", "ICrack"    , 0);
				dini_IntSet("/Gangs/Northside.ini", "ISniff"    , 0);
				dini_IntSet("/Gangs/Northside.ini", "IPills"    , 0);
				dini_IntSet("/Gangs/Northside.ini", "IFirearms" , 0);
				dini_IntSet("/Gangs/Northside.ini", "IKevlar"   , 0);
				return 1;
			}
		}
	}
	else if(checkpointid == EBrefuel1)
	{
		new Float:olddistance = 999999;
		new Float:newdistance;
		new closest = -1;
		new Float:GasX,Float:GasY,Float:GasZ;
		TogglePlayerControllable(playerid,0);
		for (new i = 0; i < sizeof(gGasStationLocations); i++)
		{
			GasX = gGasStationLocations[i][0];
			GasY = gGasStationLocations[i][1];
			GasZ = gGasStationLocations[i][2];
			newdistance = GetDistanceBetweenPlayerToPoint(playerid,GasX,GasY,GasZ);
			if (newdistance < olddistance)
			{
			    olddistance = newdistance;
				closest = i;
			}
		}
   		GameTextForPlayer(playerid,"~w~~n~~n~~n~~n~~n~~n~~n~~n~~n~Refuel! Please wait....",2000,3);
		SetTimer("Fillup",RefuelWait,0);
		gGasBiz[playerid] = closest+12;
		Refueling[playerid] = 1;
		return 1;
	}
/*	else if(checkpointid == EBrefuel2)
	{
		new Float:olddistance = 999999;
		new Float:newdistance;
		new closest = -1;
		new Float:GasX,Float:GasY,Float:GasZ;
		TogglePlayerControllable(playerid,0);
		for (new i = 0; i < sizeof(gGasStationLocations); i++)
		{
			GasX = gGasStationLocations[i][0];
			GasY = gGasStationLocations[i][1];
			GasZ = gGasStationLocations[i][2];
			newdistance = GetDistanceBetweenPlayerToPoint(playerid,GasX,GasY,GasZ);
			if (newdistance < olddistance)
			{
			    olddistance = newdistance;
				closest = i;
			}
		}
   		GameTextForPlayer(playerid,"~w~~n~~n~~n~~n~~n~~n~~n~~n~~n~Refuel! Please wait....",2000,3);
		SetTimer("Fillup",RefuelWait,0);
		gGasBiz[playerid] = closest+12;
		Refueling[playerid] = 1;
		return 1;
	}*/
	else if(checkpointid == JHrefuel1)
	{
		new Float:olddistance = 999999;
		new Float:newdistance;
		new closest = -1;
		new Float:GasX,Float:GasY,Float:GasZ;
		TogglePlayerControllable(playerid,0);
		for (new i = 0; i < sizeof(gGasStationLocations); i++)
		{
			GasX = gGasStationLocations[i][0];
			GasY = gGasStationLocations[i][1];
			GasZ = gGasStationLocations[i][2];
			newdistance = GetDistanceBetweenPlayerToPoint(playerid,GasX,GasY,GasZ);
			if (newdistance < olddistance)
			{
			    olddistance = newdistance;
				closest = i;
			}
		}
   		GameTextForPlayer(playerid,"~w~~n~~n~~n~~n~~n~~n~~n~~n~~n~Refuel! Please wait....",2000,3);
		SetTimer("Fillup",RefuelWait,0);
		gGasBiz[playerid] = closest+12;
		Refueling[playerid] = 1;
		return 1;
	}
	else if(checkpointid == TSrefuel1)
	{
		new Float:olddistance = 999999;
		new Float:newdistance;
		new closest = -1;
		new Float:GasX,Float:GasY,Float:GasZ;
		TogglePlayerControllable(playerid,0);
		for (new i = 0; i < sizeof(gGasStationLocations); i++)
		{
			GasX = gGasStationLocations[i][0];
			GasY = gGasStationLocations[i][1];
			GasZ = gGasStationLocations[i][2];
			newdistance = GetDistanceBetweenPlayerToPoint(playerid,GasX,GasY,GasZ);
			if (newdistance < olddistance)
			{
			    olddistance = newdistance;
				closest = i;
			}
		}
   		GameTextForPlayer(playerid,"~w~~n~~n~~n~~n~~n~~n~~n~~n~~n~Refuel! Please wait....",2000,3);
		SetTimer("Fillup",RefuelWait,0);
		gGasBiz[playerid] = closest+12;
		Refueling[playerid] = 1;
		return 1;
	}
/*	else if(checkpointid == TSrefuel2)
	{
		new Float:olddistance = 999999;
		new Float:newdistance;
		new closest = -1;
		new Float:GasX,Float:GasY,Float:GasZ;
		TogglePlayerControllable(playerid,0);
		for (new i = 0; i < sizeof(gGasStationLocations); i++)
		{
			GasX = gGasStationLocations[i][0];
			GasY = gGasStationLocations[i][1];
			GasZ = gGasStationLocations[i][2];
			newdistance = GetDistanceBetweenPlayerToPoint(playerid,GasX,GasY,GasZ);
			if (newdistance < olddistance)
			{
			    olddistance = newdistance;
				closest = i;
			}
		}
   		GameTextForPlayer(playerid,"~w~~n~~n~~n~~n~~n~~n~~n~~n~~n~Refuel! Please wait....",2000,3);
		SetTimer("Fillup",RefuelWait,0);
		gGasBiz[playerid] = closest+12;
		Refueling[playerid] = 1;
		return 1;
	}*/
	else if(checkpointid == JHDrivethru)
	{
    	ShowPlayerDialog(playerid, 23, DIALOG_STYLE_LIST,"Burger Shot Drive-Thru", "Burger Shot Special Meal\nChicken Burger Meal\nFreedom Fries\nApple Pie\nFanta\nCoca-Cola\nSprunk", "Accept", "Cancel");
        TogglePlayerControllable(playerid,0);
	}
	else if(checkpointid == GDrivethru)
	{
    	ShowPlayerDialog(playerid, 23, DIALOG_STYLE_LIST,"Burger Shot Drive-Thru", "Burger Shot Special Meal\nChicken Burger Meal\nFreedom Fries\nApple Pie\nFanta\nCoca-Cola\nSprunk", "Accept", "Cancel");
        TogglePlayerControllable(playerid,0);
	}
	else if(checkpointid == Test1)
	{
	    TogglePlayerDynamicCP(playerid,  Test1, false);
     	TogglePlayerDynamicCP(playerid,  Test2, true);
	    TextDrawSetString(TestDirections,"Turn Left");
	}
	else if(checkpointid == Test2)
	{
	    TogglePlayerDynamicCP(playerid,  Test2, false);
     	TogglePlayerDynamicCP(playerid,  Test3, true);
	    TextDrawSetString(TestDirections,"Turn Right");
	}
	else if(checkpointid == Test3)
	{
	    TogglePlayerDynamicCP(playerid,  Test3, false);
     	TogglePlayerDynamicCP(playerid,  Test4, true);
	    TextDrawSetString(TestDirections,"Turn Right");
	}
	else if(checkpointid == Test4)
	{
	    TogglePlayerDynamicCP(playerid,  Test4, false);
     	TogglePlayerDynamicCP(playerid,  Test5, true);
	    TextDrawSetString(TestDirections,"Turn Left");
	}
	else if(checkpointid == Test5)
	{
	    TogglePlayerDynamicCP(playerid,  Test5, false);
     	TogglePlayerDynamicCP(playerid,  Test6, true);
	    TextDrawSetString(TestDirections,"Turn Left");
	}
	else if(checkpointid == Test6)
	{
	    TogglePlayerDynamicCP(playerid,  Test6, false);
     	TogglePlayerDynamicCP(playerid,  Test7, true);
	    TextDrawSetString(TestDirections,"Turn Left");
	}
	else if(checkpointid == Test7)
	{
	    TogglePlayerDynamicCP(playerid,  Test7, false);
     	TogglePlayerDynamicCP(playerid,  Test8, true);
	    TextDrawSetString(TestDirections,"Straight On");
	}
	else if(checkpointid == Test8)
	{
	    TogglePlayerDynamicCP(playerid,  Test8, false);
     	TogglePlayerDynamicCP(playerid,  Test9, true);
	    TextDrawSetString(TestDirections,"Turn Left");
	}
	else if(checkpointid == Test9)
	{
	    TogglePlayerDynamicCP(playerid,  Test9, false);
     	TogglePlayerDynamicCP(playerid,  Test10, true);
	    TextDrawSetString(TestDirections,"Turn Right");
	}
	else if(checkpointid == Test10)
	{
	    TogglePlayerDynamicCP(playerid,  Test10, false);
     	TogglePlayerDynamicCP(playerid,  Test11, true);
	    TextDrawSetString(TestDirections,"Park Up, And You've Passed!");
	}
	else if(checkpointid == Test11)
	{
	    TogglePlayerDynamicCP(playerid,  Test11, false);
	    AccountInfo[playerid][DLicense] = 1;
	    TextDrawHideForPlayer(playerid,Text:TestDirections);
	    RemovePlayerFromVehicle(playerid);
	    SetVehicleToRespawn(dsa1);
	}
	else
	{
	    return 1;
	}
	return 0;
}
//<============================================================================>
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(IsInShop[playerid] == 1)
	{
		if (newkeys & KEY_SPRINT)
		{
			if(GetPlayerMoney(playerid) < SkinPrices[countvalue[playerid]])
			{
			    GameTextForPlayer(playerid, "~r~Not Enough Money!", 9999999, 3);
			}
			else
			{
			    PlayerPlaySound(playerid, 1139, 181.7410,-87.4888,1002.023);
			    GivePlayerMoney(playerid, (0-SkinPrices[countvalue[playerid]]));
			    Skin[playerid] = AvailableSkins[countvalue[playerid]];
			    TextDrawHideForPlayer(playerid, TextDraw[playerid]);
			    TextdrawActive[playerid] = 0;
		   		TextDrawDestroy(TextDraw[playerid]);
			    HasBoughtNewSkin[playerid] = 1;
			    AccountInfo[playerid][Boughtskin] = 1;
			    OnPlayerCommandText(playerid, "/exitzip");
			}
		}
	}
	if ((newkeys==KEY_ACTION)&&(IsPlayerInAnyVehicle(playerid))&&(GetPlayerState(playerid)==PLAYER_STATE_DRIVER))
 	{
	    if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 525)
	    {
	        SendClientMessage(playerid,COLOUR_HEADER,"The winch lowers");
			new Float:pX,Float:pY,Float:pZ;
			GetPlayerPos(playerid,pX,pY,pZ);
			new Float:vX,Float:vY,Float:vZ;
			new Found=0;
			new vid=0;
			while((vid<MAX_VEHICLES)&&(!Found))
   			{
   				vid++;
   				GetVehiclePos(vid,vX,vY,vZ);
   				if  ((floatabs(pX-vX)<7.0)&&(floatabs(pY-vY)<7.0)&&(floatabs(pZ-vZ)<7.0)&&(vid!=GetPlayerVehicleID(playerid)))
   				    {
   				    Found=1;
   				    if	(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
   				        {
   				        DetachTrailerFromVehicle(GetPlayerVehicleID(playerid));
   				        }
   				    AttachTrailerToVehicle(vid,GetPlayerVehicleID(playerid));
   				    SendClientMessage(playerid,COLOUR_HEADER,"The car is slowly pulled up and locked into place");
   				    }
       			}
			if  (!Found)
			    {
			    SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: There isn't a car in range.");
			    }
		    }
	    }
}
public CheckKeyPress(playerid)
{
if(wait[playerid] == 0)
{
	new keys, updown, leftright;
    GetPlayerKeys(playerid, keys, updown, leftright);
    if(leftright == KEY_RIGHT)
    {
    	if(IsInShop[playerid] == 1)
        {
	       	countvalue[playerid]++;
	       	if(countvalue[playerid] > TotalSkins)
			{
			    countvalue[playerid] = 0;
			}
	       	SetPlayerSkin(playerid, AvailableSkins[countvalue[playerid]]);
	        wait[playerid] = 1;
	        SetTimerEx("ResetWait", 90, 0, "i", playerid);
	        format(TextDrawString[playerid], 128, "~y~Press ~r~~k~~PED_SPRINT~ ~y~to buy this skin~n~Price: ~r~$%d~n~~n~~y~(%d/%d)", SkinPrices[countvalue[playerid]], countvalue[playerid]+1, TotalSkins);
			TextDrawHideForPlayer(playerid, TextDraw[playerid]);
			TextdrawActive[playerid] = 0;
			TextDrawSetString(TextDraw[playerid], TextDrawString[playerid]);
			TextDrawShowForPlayer(playerid, TextDraw[playerid]);
			TextdrawActive[playerid] = 1;
			}
	 }
     if(leftright == KEY_LEFT)
     {
     	if(IsInShop[playerid] == 1)
        {
	        countvalue[playerid]--;
	        if(countvalue[playerid] == -1)
			{
			    countvalue[playerid] = TotalSkins;
			}
	        SetPlayerSkin(playerid, AvailableSkins[countvalue[playerid]]);
	        wait[playerid] = 1;
         	SetTimerEx("ResetWait", 90, 0, "i", playerid);
	        format(TextDrawString[playerid], 128, "~y~Press ~r~~k~~PED_SPRINT~ ~y~to buy this skin~n~Price: ~r~$%d~n~~n~~y~(%d/%d)", SkinPrices[countvalue[playerid]], countvalue[playerid]+1, TotalSkins);
			TextDrawHideForPlayer(playerid, TextDraw[playerid]);
			TextdrawActive[playerid] = 0;
			TextDrawSetString(TextDraw[playerid], TextDrawString[playerid]);
			TextDrawShowForPlayer(playerid, TextDraw[playerid]);
			TextdrawActive[playerid] = 1;
			}
		}
	}
}
public ResetWait(playerid)
{
	wait[playerid] = 0;
}
//<============================================================================>
//<===============================[IsAtCallbacks]==============================>
//<============================================================================>
public IsAtJizzys(playerid)
{
    if(IsPlayerConnected(playerid))
	{
        if(PlayerToPoint(25.0,playerid,207.5627,-103.7291,1005.2578) || PlayerToPoint(25.0,playerid,-2660.8088,1413.4370,922.1953))
		{
            return 1;
		}
		else
		{
		    return 0;
		}
	}
	return 0;
}
//<============================================================================>
public IsAtGaydar(playerid)
{
    if(IsPlayerConnected(playerid))
	{
        if(PlayerToPoint(25.0,playerid,499.7466,-20.4796,1000.6797))
		{
            return 1;
		}
		else
		{
		    return 0;
		}
	}
	return 0;
}
//<============================================================================>
public IsAtMistys(playerid)
{
    if(IsPlayerConnected(playerid))
	{
        if(PlayerToPoint(25.0,playerid,501.6356,-71.1598,998.7578))
		{
            return 1;
		}
		else
		{
		    return 0;
		}
	}
	return 0;
}
//<============================================================================>
public IsAtWarehouse(playerid)
{
    if(IsPlayerConnected(playerid))
	{
        if(PlayerToPoint(25.0,playerid,2528.1028,-1302.0492,1048.2891))
		{
            return 1;
		}
		else
		{
		    return 0;
		}
	}
	return 0;
}
//<============================================================================>
public IsAtGecko(playerid)
{
    if(IsPlayerConnected(playerid))
	{
        if(PlayerToPoint(60.0,playerid,1416.7500,-45.4858,1000.9269))
		{
            return 1;
		}
		else
		{
		    return 0;
		}
	}
	return 0;
}
//<============================================================================>
public IsAtBank(playerid)
{
    if(IsPlayerConnected(playerid))
	{
        if(PlayerToPoint(25.0,playerid,2316.6211,-7.5200,26.7422))
		{
            return 1;
		}
		else
		{
		    return 0;
		}
	}
	return 0;
}
//<============================================================================>
public IsAtZip(playerid)
{
    if(IsPlayerConnected(playerid))
	{
        if(PlayerToPoint(25.0,playerid,-1882.6204,866.1075,35.1719))
		{
            return 1;
		}
		else
		{
		    return 0;
		}
	}
	return 0;
}
//<============================================================================>
public IsAtSFFD(playerid)
{
    if(IsPlayerConnected(playerid))
	{
        if(PlayerToPoint(5.0,playerid,-2026.9402,67.1985,28.6916))
		{
            return 1;
		}
		else
		{
		    return 0;
		}
	}
	return 0;
}
//<============================================================================>
public IsAtSFHospital(playerid)
{
    if(IsPlayerConnected(playerid))
	{
        if(PlayerToPoint(5.0,playerid,-2655.0540,639.0829,14.4531))
		{
            return 1;
		}
		else
		{
		    return 0;
		}
	}
	return 0;
}
//<============================================================================>
public IsAtSFPD(playerid)
{
    if(IsPlayerConnected(playerid))
	{
        if(PlayerToPoint(5.0,playerid,228.1703,111.4585,1003.2188))
		{
            return 1;
		}
		else
		{
		    return 0;
		}
	}
	return 0;
}
public IsAtOiltruck(playerid)
{
    if(IsPlayerConnected(playerid))
	{
        if(PlayerToPoint(5.0,playerid,-1030.9763,-661.2069,32.0078))
		{
            return 1;
		}
		else
		{
		    return 0;
		}
	}
	return 0;
}
//<============================================================================>
public IsAtBlackMarket(playerid)
{
    if(IsPlayerConnected(playerid))
	{
        if(PlayerToPoint(5.0,playerid,-1719.5497,-17.5210,3.5547) || PlayerToPoint(5,playerid,-2206.7803,-16.9651,35.3203))
		{
            return 1;
		}
		else
		{
		    return 0;
		}
	}
	return 0;
}
//<============================================================================>
public IsAtRoadRunners(playerid)
{
    if(IsPlayerConnected(playerid))
	{
        if(PlayerToPoint(5.0,playerid,1491.1520,1307.6013,1093.289))
		{
            return 1;
		}
		else
		{
		    return 0;
		}
	}
	return 0;
}
//<============================================================================>
public IsAtPizzaPlace(playerid)
{
    if(IsPlayerConnected(playerid))
	{
        if(PlayerToPoint(5.0,playerid,369.2611,-119.0535,1001.4922))
		{
            return 1;
		}
		else
		{
		    return 0;
		}
	}
	return 0;
}
//<============================================================================>
public IsAtAirTraffic(playerid)
{
    if(IsPlayerConnected(playerid))
	{
        if(PlayerToPoint(5.0,playerid,213.8598,1816.5664,6.4141))
		{
            return 1;
		}
		else
		{
		    return 0;
		}
	}
	return 0;
}
//<============================================================================>
public IsAtChurch(playerid)
{
    if(IsPlayerConnected(playerid))
	{
        if(PlayerToPoint(25.0,playerid,-2023.6232,1099.2283,18.0524))
		{
            return 1;
		}
		else
		{
		    return 0;
		}
	}
	return 0;
}
//<============================================================================>
public VehicleLog(string[])
{
	new entry[128];
	format(entry, sizeof(entry), "%s\r\n",string);
	new File:hFile;
	hFile = fopen("vehiclespawn.log", io_append);
	if (hFile)
	{
		fwrite(hFile, entry);
		fclose(hFile);
	}
}
//<============================================================================>
public KickLog(string[])
{
	new entry[128];
	format(entry, sizeof(entry), "%s\r\n",string);
	new File:hFile;
	hFile = fopen("kick.log", io_append);
	if (hFile)
	{
		fwrite(hFile, entry);
		fclose(hFile);
	}
}
//<============================================================================>
public BanLog(string[])
{
	new entry[128];
	format(entry, sizeof(entry), "%s\r\n",string);
	new File:hFile;
	hFile = fopen("ban.log", io_append);
	if (hFile)
	{
		fwrite(hFile, entry);
		fclose(hFile);
	}
}
//<============================================================================>
public OnVehicleMod(playerid,vehicleid,componentid)
{
	new component0,component1,component2,component3,component4,component5,component6,component7;
	new component8,component9,component10,component11,component12,component13;
	new carid = AccountInfo[playerid][pVehicle];
	new PlayerCar[64];
	format(PlayerCar, sizeof(PlayerCar), "/PlayerCars/%d.dini.save", AccountInfo[playerid][pVehicle]);
	if(GetPlayerVehicleID(playerid) == CarInfo[carid][cCarID])
	{
		component0 = GetVehicleComponentInSlot(GetPlayerVehicleID(playerid), CARMODTYPE_SPOILER);
		component1 = GetVehicleComponentInSlot(GetPlayerVehicleID(playerid), CARMODTYPE_HOOD);
		component2 = GetVehicleComponentInSlot(GetPlayerVehicleID(playerid), CARMODTYPE_ROOF);
		component3 = GetVehicleComponentInSlot(GetPlayerVehicleID(playerid), CARMODTYPE_SIDESKIRT);
		component4 = GetVehicleComponentInSlot(GetPlayerVehicleID(playerid), CARMODTYPE_LAMPS);
		component5 = GetVehicleComponentInSlot(GetPlayerVehicleID(playerid), CARMODTYPE_NITRO);
		component6 = GetVehicleComponentInSlot(GetPlayerVehicleID(playerid), CARMODTYPE_EXHAUST);
		component7 = GetVehicleComponentInSlot(GetPlayerVehicleID(playerid), CARMODTYPE_WHEELS);
		component8 = GetVehicleComponentInSlot(GetPlayerVehicleID(playerid), CARMODTYPE_STEREO);
		component9 = GetVehicleComponentInSlot(GetPlayerVehicleID(playerid), CARMODTYPE_HYDRAULICS);
		component10 = GetVehicleComponentInSlot(GetPlayerVehicleID(playerid), CARMODTYPE_FRONT_BUMPER);
		component11 = GetVehicleComponentInSlot(GetPlayerVehicleID(playerid), CARMODTYPE_REAR_BUMPER);
		component12 = GetVehicleComponentInSlot(GetPlayerVehicleID(playerid), CARMODTYPE_VENT_RIGHT);
		component13 = GetVehicleComponentInSlot(GetPlayerVehicleID(playerid), CARMODTYPE_VENT_LEFT);
		printf("Spoiler Component ID: %d", component0);
		printf("Hood Component ID: %d", component1);
		printf("Roof Component ID: %d", component2);
		printf("Sideskirt Component ID: %d", component3);
		printf("Lamps Component ID: %d", component4);
		printf("Nitro Component ID: %d", component5);
		printf("Exhaust Component ID: %d", component6);
		printf("Wheels Component ID: %d", component7);
		printf("Stereo Component ID: %d", component8);
		printf("Hydraulics Component ID: %d", component9);
		printf("Front Bumper Component ID: %d", component10);
		printf("Rear Bumper Component ID: %d", component11);
		printf("Vent Right Component ID: %d", component12);
  		printf("Vent Left  Component ID: %d", component13);
		if(component0 >= 1000)
		{
			CarInfo[carid][Mod0] = component0;
			dini_IntSet(PlayerCar,"Car Mod 0", component0);
		}
	    if(component1 >= 1000)
		{
			CarInfo[carid][Mod1] = component1;
	        dini_IntSet(PlayerCar,"Car Mod 1", component1);
		}
	    if(component2 >= 1000)
		{
			CarInfo[carid][Mod2] = component2;
			dini_IntSet(PlayerCar,"Car Mod 2", component2);
		}
	    if(component3 >= 1000)
		{
			CarInfo[carid][Mod3] = component3;
			dini_IntSet(PlayerCar,"Car Mod 3", component3);
		}
	    if(component4 >= 1000)
		{
			CarInfo[carid][Mod4] = component4;
			dini_IntSet(PlayerCar,"Car Mod 4", component4);
		}
	    if(component5 >= 1000)
		{
			CarInfo[carid][Mod5] = component5;
			dini_IntSet(PlayerCar,"Car Mod 5", component5);
		}
	    if(component6 >= 1000)
		{
			CarInfo[carid][Mod6] = component6;
			dini_IntSet(PlayerCar,"Car Mod 6", component6);
		}
	    if(component7 >= 1000)
		{
			CarInfo[carid][Mod7] = component7;
			dini_IntSet(PlayerCar,"Car Mod 7", component7);
		}
	    if(component8 >= 1000)
		{
			CarInfo[carid][Mod8] = component8;
			dini_IntSet(PlayerCar,"Car Mod 8", component8);
		}
	    if(component9 >= 1000)
		{
			CarInfo[carid][Mod9] = component9;
			dini_IntSet(PlayerCar,"Car Mod 9", component9);
		}
	    if(component10 >= 1000)
		{
			CarInfo[carid][Mod10] = component10;
			dini_IntSet(PlayerCar,"Car Mod 10", component10);
		}
	    if(component11 >= 1000)
		{
			CarInfo[carid][Mod11] = component11;
			dini_IntSet(PlayerCar,"Car Mod 11", component11);
		}
	    if(component12 >= 1000)
		{
			CarInfo[carid][Mod12] = component12;
			dini_IntSet(PlayerCar,"Car Mod 12", component12);
		}
	    if(component13 >= 1000)
		{
			CarInfo[carid][Mod13] = component13;
			dini_IntSet(PlayerCar,"Car Mod 13", component13);
		}
		return 1;
	}
	return 1;
}
//<============================================================================>
public OnVehicleDeath(vehicleid, killerid)
{
	new Simport = dini_Int("/Gangs/Forelli.ini","Bigimported");
	new Nimport = dini_Int("/Gangs/Northside.ini","Bigimported");
	new Himport = dini_Int("/Gangs/TheLost.ini","Bigimported");
	if (vehicleid == north6 && Nimport == 1)
	{
			SendClientMessageToNorthside(COLOUR_NORTHSIDE, "The import has been lost.");
			dini_IntSet("/Gangs/Northside.ini", "BIWeed"     , 0);
			dini_IntSet("/Gangs/Northside.ini", "BICrack"    , 0);
			dini_IntSet("/Gangs/Northside.ini", "BISniff"    , 0);
			dini_IntSet("/Gangs/Northside.ini", "BIPills"    , 0);
			dini_IntSet("/Gangs/Northside.ini", "BIFirearms" , 0);
			dini_IntSet("/Gangs/Northside.ini", "BIKevlar"   , 0);
	}
	if (vehicleid == Biker7 && Himport == 1)
	{
			SendClientMessageToTheLost(COLOUR_THELOST, "The import has been lost.");
			dini_IntSet("/Gangs/TheLost.ini", "BIWeed"     , 0);
			dini_IntSet("/Gangs/TheLost.ini", "BICrack"    , 0);
			dini_IntSet("/Gangs/TheLost.ini", "BISniff"    , 0);
			dini_IntSet("/Gangs/TheLost.ini", "BIPills"    , 0);
			dini_IntSet("/Gangs/TheLost.ini", "BIFirearms" , 0);
			dini_IntSet("/Gangs/TheLost.ini", "BIKevlar"   , 0);
	}
	if (vehicleid == Forelli5 && Simport == 1)
	{
			SendClientMessageToForelli(COLOUR_FORELLI, "The import has been lost.");
			dini_IntSet("/Gangs/Forelli.ini", "BIWeed"     , 0);
			dini_IntSet("/Gangs/Forelli.ini", "BICrack"    , 0);
			dini_IntSet("/Gangs/Forelli.ini", "BISniff"    , 0);
			dini_IntSet("/Gangs/Forelli.ini", "BIPills"    , 0);
			dini_IntSet("/Gangs/Forelli.ini", "BIFirearms" , 0);
			dini_IntSet("/Gangs/Forelli.ini", "BIKevlar"   , 0);
	}
	return 1;
}
//<============================================================================>
public OnPlayerExitVehicle(playerid, vehicleid)
{
	TogglePlayerDynamicCP(playerid, EBrefuel1, false);
//	TogglePlayerDynamicCP(playerid, EBrefuel2, false);
	TogglePlayerDynamicCP(playerid, TSrefuel1, false);
//	TogglePlayerDynamicCP(playerid, TSrefuel2, false);
	return 1;
}
//<============================================================================>
public IsPlayerCop(playerid)
{
	if(IsPlayerConnected(playerid))
	{
	    new Police = AccountInfo[playerid][pTeam];
	    if(Police == 1)
		{
  		  return 1;
		}
		else 
		{
        return 0;
		}
	}
	return 0;
}
//<============================================================================>
public IsPlayerFourCorners(playerid)
{
	if(IsPlayerConnected(playerid))
	{
	    new Rank = AccountInfo[playerid][GangRank];
	    new Gang = AccountInfo[playerid][pTeam];
	    if(Gang > 1)
		{
			if(Rank < 4){return 0;}
			else
			{
			return 1;
			}
		}
		else
		{
        return 0;
		}
	}
	return 0;
}
//<============================================================================>
public IsPlayerPermitted(playerid)
{
	if(IsPlayerConnected(playerid))
	{
	    new Police = AccountInfo[playerid][pTeam];
	    new Tow = AccountInfo[playerid][pJob];
	    if(Police == 1)
		{
  		  return 1;
		}
	    else if(Tow == 9)
		{
  		  return 1;
		}
		else
		{
        return 0;
		}
	}
	return 0;
}
//<============================================================================>
public IsPlayerTow(playerid)
{
	if(IsPlayerConnected(playerid))
	{
	    new Tow = AccountInfo[playerid][pJob];
	    if(Tow == 9)
		{
  		  return 1;
		}
		else
		{
        return 0;
		}
	}
	return 0;
}
//<============================================================================>
public IsPlayerPilot(playerid)
{
	if(IsPlayerConnected(playerid))
	{
	    new Pilot = AccountInfo[playerid][pJob];
	    if(Pilot == 1)
		{
  		  return 1;
		}
		else
		{
        return 0;
		}
	}
	return 0;
}
//<============================================================================>
//<============================[OnPlayerCommandText]===========================>
//<============================================================================>
public OnPlayerCommandText(playerid, cmdtext[])
{
//    dcmd(login  		,  5, cmdtext);
//    dcmd(register       ,  8, cmdtext);
    dcmd(changepassword , 14, cmdtext);
	dcmd(admincommands  , 13, cmdtext);
	dcmd(makeadmin		,  9, cmdtext);
	dcmd(makezestie     , 10, cmdtext);
	dcmd(forcepayday    , 11, cmdtext);
	dcmd(rmakeadmin		, 10, cmdtext);
	dcmd(kickeveryone   , 12, cmdtext);
	dcmd(getplayerip    , 11, cmdtext);
	dcmd(kick           ,  4, cmdtext);
	dcmd(ban            ,  3, cmdtext);
	dcmd(mute           ,  4, cmdtext);
    dcmd(unmute         ,  6, cmdtext);
	dcmd(freeze         ,  6, cmdtext);
    dcmd(unfreeze       ,  8, cmdtext);
    dcmd(setname        ,  7, cmdtext);
    dcmd(givecash       ,  8, cmdtext);
    dcmd(slap           ,  4, cmdtext);
    dcmd(kill           ,  4, cmdtext);
    dcmd(goto           ,  4, cmdtext);
    dcmd(get            ,  3, cmdtext);
    dcmd(teleport       ,  8, cmdtext);
	dcmd(setplayerskin  , 13, cmdtext);
	dcmd(setvehiclepaint, 15,cmdtext);
	dcmd(veh   			,  3, cmdtext);
    dcmd(fuck           ,  4, cmdtext);
    dcmd(clearchat      ,  9, cmdtext);
    dcmd(spectate       ,  8, cmdtext);
    dcmd(setplayerteam  , 13, cmdtext);
    dcmd(setplayerjob   , 12, cmdtext);
    dcmd(promote        ,  7, cmdtext);
	dcmd(demote         ,  6, cmdtext);
	dcmd(invite         ,  6, cmdtext);
	dcmd(g              ,  1, cmdtext);
	dcmd(leavegang      ,  9, cmdtext);
	dcmd(remove         ,  6, cmdtext);
	dcmd(diplomacy      ,  9, cmdtext);
	dcmd(change         ,  6, cmdtext);
	dcmd(storage        ,  7, cmdtext);
	dcmd(store          ,  5, cmdtext);
    dcmd(take           ,  4, cmdtext);
    dcmd(getweapon      ,  9, cmdtext);
    dcmd(openjizzys     , 10, cmdtext);
    dcmd(getjob         ,  6, cmdtext);
    dcmd(leavejob       ,  8, cmdtext);
	dcmd(offerjob       ,  8, cmdtext);
	dcmd(fire           ,  4, cmdtext);
	dcmd(ordertaxi      ,  9, cmdtext);
	dcmd(onduty         ,  6, cmdtext);
	dcmd(orderpizza     , 10, cmdtext);
	dcmd(deliver        ,  7, cmdtext);
	dcmd(news           ,  4, cmdtext);
	dcmd(revive         ,  6, cmdtext);
    dcmd(heal           ,  4, cmdtext);
	dcmd(import         ,  6, cmdtext);
	dcmd(bigimport      ,  9, cmdtext);
	dcmd(commands       ,  8, cmdtext);
	dcmd(tutorial       ,  8, cmdtext);
	dcmd(locations      ,  9, cmdtext);
	dcmd(jobhelp        ,  7, cmdtext);
	dcmd(directions     , 10, cmdtext);
	dcmd(credits        ,  7, cmdtext);
	dcmd(jobsearch      ,  9, cmdtext);
	dcmd(suicide        ,  7, cmdtext);
	dcmd(mybmx          ,  5, cmdtext);
	dcmd(inventory      ,  9, cmdtext);
	dcmd(stats          ,  5, cmdtext);
	dcmd(help           ,  4, cmdtext);
	dcmd(gangs          ,  5, cmdtext);
	dcmd(jobs           ,  4, cmdtext);
	dcmd(admins         ,  6, cmdtext);
	dcmd(booktest		,  8, cmdtext);
	dcmd(setspawn       ,  8, cmdtext);
	dcmd(breakdown      ,  9, cmdtext);
	dcmd(tie            ,  3, cmdtext);
	dcmd(untie          ,  5, cmdtext);
	dcmd(kidnap         ,  6, cmdtext);
	dcmd(911            ,  3, cmdtext);
	dcmd(pay            ,  3, cmdtext);
	dcmd(sell           ,  4, cmdtext);
	dcmd(use            ,  3, cmdtext);
	dcmd(order	    	,  5, cmdtext);
	dcmd(report         ,  6, cmdtext);
	dcmd(enterzip    	,  8, cmdtext);
	dcmd(exitzip     	,  7, cmdtext);
	dcmd(pm             ,  2, cmdtext);
	dcmd(all     		,  3, cmdtext);
	dcmd(meg            ,  3, cmdtext);
	dcmd(me             ,  2, cmdtext);
	dcmd(s              ,  1, cmdtext);
	dcmd(po		        ,  2, cmdtext);
	dcmd(mp             ,  2, cmdtext);
	dcmd(w              ,  1, cmdtext);
	dcmd(achat          ,  5, cmdtext);
	dcmd(pr             ,  2, cmdtext);
	dcmd(eject          ,  5, cmdtext);
	dcmd(start          ,  5, cmdtext);
	dcmd(getvehicleidd  , 13, cmdtext);
	dcmd(getvehicleids  , 13, cmdtext);
	dcmd(stop           ,  4, cmdtext);
	dcmd(park   		, 12, cmdtext);
	dcmd(exit           ,  4, cmdtext);
	dcmd(lock           ,  4, cmdtext);
	dcmd(refuel         ,  6, cmdtext);
	dcmd(deposit        ,  7, cmdtext);
	dcmd(withdraw       ,  8, cmdtext);
	dcmd(balance        ,  7, cmdtext);
	dcmd(requesttow     , 10, cmdtext);
	dcmd(tazer          ,  5, cmdtext);
	dcmd(cuff           ,  4, cmdtext);
	dcmd(uncuff         ,  6, cmdtext);
	dcmd(jail           ,  4, cmdtext);
	dcmd(lead           ,  4, cmdtext);
	dcmd(restrain       ,  8, cmdtext);
	dcmd(roadblock      ,  9, cmdtext);
	dcmd(removeroadblock, 15, cmdtext);
	dcmd(spike          ,  5, cmdtext);
	dcmd(removespike    , 11, cmdtext);
	dcmd(fine           ,  4, cmdtext);
	dcmd(warrant        ,  7, cmdtext);
	dcmd(backup         ,  6, cmdtext);
	dcmd(search         ,  6, cmdtext);
	dcmd(duty           ,  4, cmdtext);
	dcmd(offduty        ,  7, cmdtext);
 	dcmd(househelp      ,  9, cmdtext);
    dcmd(houseinfo		,  9, cmdtext);
	dcmd(enter			,  5, cmdtext);
	dcmd(leave			,  5, cmdtext);
	dcmd(house			,  5, cmdtext);
	dcmd(lockhouse		,  9, cmdtext);
	dcmd(unlockhouse	, 11, cmdtext);
	dcmd(buyhouse		,  8, cmdtext);
	dcmd(buycar		    ,  6, cmdtext);
	dcmd(sellhouse		,  9, cmdtext);
	dcmd(unsellhouse	, 11, cmdtext);
	dcmd(createhouse	, 11, cmdtext);
	dcmd(destroyhouse	, 12, cmdtext);
	dcmd(respawn        ,  7, cmdtext);
	dcmd(destroycar     , 10, cmdtext);
	dcmd(orgtow         ,  6, cmdtext);
	dcmd(saveloc        ,  7, cmdtext);
	dcmd(saveveh        ,  7, cmdtext);
	dcmd(changeweather  , 13, cmdtext);
	dcmd(tankers        ,  7, cmdtext);

	return 0;
//<============================================================================>
//<=========================[Account Related Commands]=========================>
//<============================================================================>
}
dcmd_changepassword(playerid, params[])
{
		new oldpass[159], pass[159];
		if (sscanf(params, "ss", oldpass, pass)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /changepassword [Current Password] [New Password]");
		if(!strlen(oldpass)) return SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /changepassword [Current Password] [New Password]");
		if (strcmp(MD5_Hash(oldpass), AccountInfo[playerid][Password], true)) return SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: Invalid password.");
		if(!strlen(pass)) return SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /changepassword [Current Password] [New Password]");
		format(oldpass, 128, "[Server]: You've changed your password to '%s'.", pass);
	    SendClientMessage(playerid, COLOUR_ADMINRED, oldpass);
	    strmid(AccountInfo[playerid][Password], MD5_Hash(pass), 0, strlen(MD5_Hash(pass)), 128);
		return 1;
}
//<============================================================================>
//<==========================[Administrative Commands]=========================>
//<============================================================================>
dcmd_admincommands(playerid, params[])
{
    #pragma unused params
	new adminlevel = AccountInfo[playerid][AdminLevel];
	if (adminlevel < 1) SendClientMessage(playerid, COLOUR_RED, "You are not an admin!");
	else
	{
		    SendClientMessage(playerid, COLOUR_ADMINRED, "|===============[Server Admin Commands]===============|");
		    SendClientMessage(playerid, COLOUR_ADMINRED, "[Scripter]: /makeadmin /kickall /blockpm /ip");
		    SendClientMessage(playerid, COLOUR_ADMINRED, "[Lead]: /fuck /clearchat /teleport /setplayerteam");
		    SendClientMessage(playerid, COLOUR_ADMINRED, "[Lvl3]: /tban /ban /slap /spectate ");
		    SendClientMessage(playerid, COLOUR_ADMINRED, "[Lvl2]: /(un)mute /get /goto");
		    SendClientMessage(playerid, COLOUR_ADMINRED, "[Lvl1]: /{un)freeze /kick /setname /kill");
		    SendClientMessage(playerid, COLOUR_ADMINRED, "[Admin Chat]: /achat");
	}
	return 1;
}
dcmd_makeadmin(playerid, params[])
{
	new adminlevel = AccountInfo[playerid][AdminLevel], id, newlevel, giveplayername[MAX_PLAYER_NAME], sendername[MAX_PLAYER_NAME], string[128];
	if (sscanf(params, "ud", id, newlevel)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /makeadmin [playerid][adminlevel]");
	else if (id == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: Player not found");
	else if ((!IsPlayerAdmin(playerid))||(adminlevel < 5)) SendClientMessage(playerid, COLOUR_ADMINRED,"[Error]: You aren't a lead admin");
	else if (newlevel == 6) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You can't have an admin level above 6");
//	else if (!IsPlayerAdmin(playerid))SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You are not an admin");
	else if (IsPlayerAdmin(playerid))
	{
	    GetPlayerName(id, giveplayername, sizeof(giveplayername));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		printf("[Administrator]: %s made %s a level %d admin.", sendername, giveplayername, newlevel);
		format(string, sizeof(string), "[Server]: You are now a level %d administrator thanks to %s.", newlevel, sendername);
		SendClientMessage(id, COLOUR_LIGHTBLUE, string);
		AccountInfo[id][AdminLevel] = newlevel;
		format(string, sizeof(string), "[Server]: You have given %s level %d admin.", giveplayername,AccountInfo[id][AdminLevel]);
		SendClientMessage(playerid, COLOUR_LIGHTBLUE, string);
		OnPlayerUpdateAccount(playerid);
		return 1;
	}
	return 1;
}
dcmd_makezestie(playerid, params[])
{
	new adminlevel = AccountInfo[playerid][AdminLevel], id, giveplayername[MAX_PLAYER_NAME], sendername[MAX_PLAYER_NAME], string[128];
	if (sscanf(params, "u", id)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /makeadmin [playerid][adminlevel]");
	else if (id == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: Player not found");
	else if (adminlevel < 5) SendClientMessage(playerid, COLOUR_ADMINRED,"[Error]: You aren't a lead admin");
	else
	{
     GetPlayerName(id, giveplayername, sizeof(giveplayername));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		printf("[Server]: %s has now a member of .:Zest::.", giveplayername);
		format(string, sizeof(string), "[Server]: You are now a member of .:Zest:: thanks to %s.", sendername);
		SendClientMessage(id, COLOUR_LIGHTBLUE, string);
		format(string, sizeof(string), "[Server]: You have made %s a member of our clan.", giveplayername);
		SendClientMessage(playerid, COLOUR_LIGHTBLUE, string);
		AccountInfo[id][Clan] = 1;
		OnPlayerUpdateAccount(playerid);
		return 1;
	}
	return 1;
}
dcmd_forcepayday(playerid, params[])
{
    #pragma unused params
	if (AccountInfo[playerid][AdminLevel] < 5) SendClientMessage(playerid, COLOUR_ADMINRED,"[Error]: You arent a high enough Admin");
	else
	{
	    Payday();
	}
	return 1;
}
dcmd_rmakeadmin(playerid, params[])
{
	new id, newlevel, giveplayername[MAX_PLAYER_NAME], sendername[MAX_PLAYER_NAME], string[128];
	if (sscanf(params, "ud", id, newlevel)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /rmakeadmin [playerid][adminlevel]");
	else if (id == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: Player not found");
	else if (!IsPlayerAdmin(playerid)) SendClientMessage(playerid, COLOUR_ADMINRED,"[Error]: You aren't a lead admin");
	else if (newlevel == 6) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You can't have an admin level above 6");
	else if (IsPlayerAdmin(playerid))
	{
	    GetPlayerName(id, giveplayername, sizeof(giveplayername));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		printf("[Administrator]: %s made %s a level %d admin.", sendername, giveplayername, newlevel);
		format(string, sizeof(string), "[Server]: You are now a level %d administrator thanks to %s.", newlevel, sendername);
		SendClientMessage(id, COLOUR_LIGHTBLUE, string);
		AccountInfo[id][AdminLevel] = newlevel;
		format(string, sizeof(string), "[Server]: You have given %s level %d admin.", giveplayername,AccountInfo[id][AdminLevel]);
		SendClientMessage(playerid, COLOUR_LIGHTBLUE, string);
		OnPlayerUpdateAccount(playerid);
		return 1;
	}
	return 1;
}
dcmd_kickeveryone(playerid, params[])
{
	new reason[128], adminlevel = AccountInfo[playerid][AdminLevel], sendername[MAX_PLAYER_NAME], string[128];
	if (sscanf(params, "s", reason)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /kickeveryone [Reason for kick]");
	else if (adminlevel < 5) SendClientMessage(playerid, COLOUR_ADMINRED,"You aren't a lead admin");
	else
	{
            GetPlayerName(playerid, sendername, sizeof(sendername));
			printf("[Admin] : Administrator %s kicked everyone from the server.", sendername);
			printf("[Reason]: The reason being %s .", reason);
			format(string, sizeof(string), "[Server]: Administrator %s has kicked everyone because %s.", sendername,reason);
			SendClientMessageToAll(COLOUR_ADMINRED, string);
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
   			if (i != playerid)
		    {
				Kick(i);
				KickLog(string);
			}
		}
	}
	return 1;
}
dcmd_ban(playerid, params[])
{
	new id, reason[128], adminlevel = AccountInfo[playerid][AdminLevel], sendername[MAX_PLAYER_NAME], name[MAX_PLAYER_NAME], string[128];
	if (sscanf(params, "us", id, reason)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /ban [Reason for kick]");
	else if (adminlevel < 3) SendClientMessage(playerid, COLOUR_ADMINRED,"You aren't an admin of the required lvl");
	else
	{
		GetPlayerName(id,name,sizeof(name));
		GetPlayerName(playerid,sendername,sizeof(sendername));
		format(string,sizeof(string),"[Server]: %s has been banned by %s because %s",name,sendername,reason);
		SendClientMessageToAll(COLOUR_ADMINRED,string);
 		Ban(id);
 		return 1;
	}
	return 1;
}
dcmd_getplayerip(playerid, params[])
{
	new playerip[20], giveplayerid, giveplayername[MAX_PLAYER_NAME], ipmessage[128];
	if (sscanf(params, "i", giveplayerid)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /getplayerip [playerid]");
	else if (!IsPlayerConnected(giveplayerid)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: Player ID not connected.");
	else
	{
				GetPlayerIp(giveplayerid, playerip, sizeof playerip);
				GetPlayerName(giveplayerid, giveplayername, sizeof(giveplayername));
				format(ipmessage, sizeof(ipmessage), "[Server]: %s's IP address is %s", giveplayername,playerip);
				SendClientMessage(playerid,COLOUR_LIGHTBLUE, ipmessage);
	}
	return 1;
}
dcmd_kick(playerid, params[])
{
	new reason[128], string[128], giveplayerid, adminlevel = AccountInfo[playerid][AdminLevel], giveplayername[MAX_PLAYER_NAME], sendername[MAX_PLAYER_NAME];
	if (sscanf(params, "is", giveplayerid, reason)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /kick [playerid] [reason]");
    else if (!IsPlayerConnected(giveplayerid)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: Player ID not connected.");
	else if (adminlevel  < 1) SendClientMessage(playerid, COLOUR_ADMINRED,"[Error]: You aren't an admin");
	else
	{
 				GetPlayerName(giveplayerid, giveplayername, sizeof(giveplayername));
				GetPlayerName(playerid, sendername, sizeof(sendername));
				printf("[Admin]: Administrator %s kicked %s.", sendername, giveplayername);
				printf("[Reason]: The reason being %s", reason);
				format(string, sizeof(string), "[Server]: Administrator %s kicked %s. [Reason: %s ]", sendername, giveplayername, reason);
				SendClientMessageToAll(COLOUR_LIGHTBLUE, string);
				Kick(giveplayerid);
				KickLog(string);
	}
	return 1;
}
dcmd_mute(playerid, params[])
{
	new reason[128], string[128], giveplayerid, adminlevel = AccountInfo[playerid][AdminLevel], giveplayername[MAX_PLAYER_NAME], sendername[MAX_PLAYER_NAME];
	if (sscanf(params, "is", giveplayerid, reason)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /mute [playerid] [reason]");
    else if (!IsPlayerConnected(giveplayerid)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: Player ID not connected.");
	else if (adminlevel  < 1) SendClientMessage(playerid, COLOUR_ADMINRED,"[Error]: You aren't an admin");
	else if (AccountInfo[giveplayerid][Mute] == 1) SendClientMessage(playerid, COLOUR_RED, "[Error]: Player is already muted");
	else
	{
 					GetPlayerName(giveplayerid, giveplayername, sizeof(giveplayername));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					printf("[Admin] : Administrator %s muted %s.", sendername, giveplayername);
					printf("[Reason]: The reason being %s", reason);
					format(string, sizeof(string), "[Server]: Administrator %s has muted %s. [Reason: %s ]|-", sendername,giveplayername,reason);
					SendClientMessageToAll(COLOUR_LIGHTBLUE, string);
					AccountInfo[giveplayerid][Mute] = 1;
	}
	return 1;
}
dcmd_unmute(playerid, params[])
{
    new string[128], giveplayerid, adminlevel = AccountInfo[playerid][AdminLevel], giveplayername[MAX_PLAYER_NAME], sendername[MAX_PLAYER_NAME];
	if (sscanf(params, "i", giveplayerid)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /unmute [playerid]");
    else if (!IsPlayerConnected(giveplayerid)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: Player ID not connected.");
	else if (adminlevel  < 1) SendClientMessage(playerid, COLOUR_ADMINRED,"[Error]: You aren't an admin");
	else if (AccountInfo[giveplayerid][Mute] == 0) SendClientMessage(playerid, COLOUR_RED, "[Error]: Player isn't muted");
	else
	{
	                GetPlayerName(giveplayerid, giveplayername, sizeof(giveplayername));
					GetPlayerName(playerid, sendername, sizeof(sendername));
                    printf("[Admin] : Administrator %s has unmuted %s.", sendername, giveplayername);
					format(string, sizeof(string), "[Server]: Administrator %s has unmuted %s.", sendername,giveplayername);
					SendClientMessageToAll(COLOUR_LIGHTBLUE, string);
					AccountInfo[giveplayerid][Mute] = 0;
	}
	return 1;
}
dcmd_freeze(playerid, params[])
{
	new reason[128], string[128], giveplayerid, adminlevel = AccountInfo[playerid][AdminLevel], giveplayername[MAX_PLAYER_NAME], sendername[MAX_PLAYER_NAME];
	if (sscanf(params, "iz", giveplayerid, reason)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /freeze [playerid] [reason]");
    else if (!IsPlayerConnected(giveplayerid)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: Player ID not connected.");
	else if (adminlevel  < 1) SendClientMessage(playerid, COLOUR_ADMINRED,"[Error]: You aren't an admin");
	else
	{
 					GetPlayerName(giveplayerid, giveplayername, sizeof(giveplayername));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					printf("[Admin] : Administrator %s froze %s.", sendername, giveplayername);
					printf("[Reason]: The reason being %s", reason);
					format(string, sizeof(string), "[Server]: Administrator %s has frozen %s. [Reason: %s ]|-", sendername,giveplayername,reason);
					SendClientMessageToAll(COLOUR_LIGHTBLUE, string);
					TogglePlayerControllable(giveplayerid, false);
					
	}
	return 1;
}
dcmd_unfreeze(playerid, params[])
{
    new string[128], giveplayerid, adminlevel = AccountInfo[playerid][AdminLevel], giveplayername[MAX_PLAYER_NAME], sendername[MAX_PLAYER_NAME];
	if (sscanf(params, "i", giveplayerid)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /unfrozen [playerid]");
    else if (!IsPlayerConnected(giveplayerid)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: Player ID not connected.");
	else if (adminlevel  < 1) SendClientMessage(playerid, COLOUR_ADMINRED,"[Error]: You aren't an admin");
	else
	{
	                GetPlayerName(giveplayerid, giveplayername, sizeof(giveplayername));
					GetPlayerName(playerid, sendername, sizeof(sendername));
                    printf("[Admin] : Administrator %s has unfrozen %s.", sendername, giveplayername);
					format(string, sizeof(string), "[Server]: Administrator %s has unfrozen %s.", sendername,giveplayername);
					SendClientMessageToAll(COLOUR_LIGHTBLUE, string);
					TogglePlayerControllable(giveplayerid, true);
					
	}
	return 1;
}
dcmd_setname(playerid, params[])
{
	new string[128], giveplayerid, adminlevel = AccountInfo[playerid][AdminLevel], giveplayername[MAX_PLAYER_NAME], sendername[MAX_PLAYER_NAME], newname[MAX_PLAYER_NAME];
	if (sscanf(params, "is", giveplayerid, newname)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /setname [playerid] [newname]");
    else if (!IsPlayerConnected(giveplayerid)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: Player ID not connected.");
	else if (adminlevel  < 1) SendClientMessage(playerid, COLOUR_ADMINRED,"[Error]: You aren't an admin");
	else
	{
 					GetPlayerName(giveplayerid, giveplayername, sizeof(giveplayername));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					format(string, sizeof(string), "[Server]: Administrator %s has renamed %s to %s.", sendername, giveplayername, newname);
					SendClientMessageToAdmins(COLOUR_LIGHTBLUE, string, 1);
					SetPlayerName(giveplayerid, newname);
	}
	return 1;
}
dcmd_givecash(playerid, params[])
{
	new giveplayerid, amount, adminlevel = AccountInfo[playerid][AdminLevel];
	if (sscanf(params, "ud", giveplayerid, amount)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /givecash [playerid/partname] [amount]");
	else if (giveplayerid == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: Player ID not connected.");
    else if (adminlevel  < 5) SendClientMessage(playerid, COLOUR_ADMINRED,"[Error]: You aren't a high enough admin");
	else
	{
					GivePlayerMoney(giveplayerid, amount);
					SendClientMessage(playerid, COLOUR_LIGHTBLUE, "[Server]: Money sent");
					SendClientMessage(giveplayerid, COLOUR_LIGHTBLUE, "[Server]: Money received");
	}
	return 1;
}
dcmd_slap(playerid, params[])
{
	new Float:pX,Float:pY,Float:pZ, string[128], giveplayerid, adminlevel = AccountInfo[playerid][AdminLevel], giveplayername[MAX_PLAYER_NAME], sendername[MAX_PLAYER_NAME];
	if (sscanf(params, "i", giveplayerid)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /slap [playerid]");
    else if (!IsPlayerConnected(giveplayerid)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: Player ID not connected.");
	else if (adminlevel  < 1) SendClientMessage(playerid, COLOUR_ADMINRED,"[Error]: You aren't an admin");
	else
	{
	        GetPlayerName(giveplayerid, giveplayername, sizeof(giveplayername));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			GetPlayerPos(giveplayerid,pX,pY,pZ);
			SetPlayerPos(giveplayerid,pX,pY,pZ+5);
			format(string, sizeof(string), "[Server]: Administrator %s has slapped %s.",sendername, giveplayername);
			SendClientMessageToAdmins(COLOUR_ADMINRED, string, 1);
			format(string, sizeof(string), "[Server]: You were bitch slapped by Administrator %s",sendername);
			SendClientMessage(giveplayerid,COLOUR_LIGHTBLUE,string);
	}
	return 1;
}
dcmd_kill(playerid, params[])
{
	new string[128], giveplayerid, adminlevel = AccountInfo[playerid][AdminLevel], giveplayername[MAX_PLAYER_NAME], sendername[MAX_PLAYER_NAME];
	if (sscanf(params, "i", giveplayerid)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /kill [playerid]");
    else if (!IsPlayerConnected(giveplayerid)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: Player ID not connected.");
	else if (adminlevel  < 1) SendClientMessage(playerid, COLOUR_ADMINRED,"[Error]: You aren't an admin");
	else
	{
 			 GetPlayerName(giveplayerid, giveplayername, sizeof(giveplayername));
             GetPlayerName(playerid, sendername, sizeof(sendername));
			 format(string, sizeof(string), "[Server]: Administrator %s has struck down %s.",sendername, giveplayername);
			 SendClientMessageToAdmins(COLOUR_ADMINRED, string, 1);
			 format(string, sizeof(string), "[Server]: You were owned by Administrator %s",sendername);
			 SendClientMessage(playerid,COLOUR_LIGHTBLUE,string);
			 SetPlayerHealth(giveplayerid, 0.0);
	}
	return 1;
}
dcmd_goto(playerid, params[])
{
	new Float:pX,Float:pY,Float:pZ, string[128], giveplayerid, adminlevel = AccountInfo[playerid][AdminLevel], giveplayername[MAX_PLAYER_NAME];
    if (sscanf(params, "i", giveplayerid)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /goto [playerid]");
    else if (!IsPlayerConnected(giveplayerid)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: Player ID not connected.");
	else if (adminlevel  < 1) SendClientMessage(playerid, COLOUR_ADMINRED,"[Error]: You aren't an admin");
	else
	{
 			if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
			{
  	        	GetPlayerPos(giveplayerid,pX,pY,pZ);
			    SetVehiclePos(GetPlayerVehicleID(playerid),pX,pY,pZ+2);
        	}
		  	else
		  	{
			  	GetPlayerPos(giveplayerid,pX,pY,pZ);
			   	SetPlayerPos(playerid,pX,pY,pZ+2);
			}
			SetPlayerInterior(playerid,GetPlayerInterior(giveplayerid));
   			GetPlayerName(giveplayerid, giveplayername, sizeof(giveplayername));
			format(string,sizeof(string),"[Server]: You have been teleported to  %s.", giveplayername);
			SendClientMessage(playerid,COLOUR_LIGHTBLUE,string);
	}
	return 1;
}
dcmd_get(playerid, params[])
{
	new Float:pX,Float:pY,Float:pZ, string[128], giveplayerid, adminlevel = AccountInfo[playerid][AdminLevel], playername[MAX_PLAYER_NAME];
    if (sscanf(params, "i", giveplayerid)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /get [playerid]");
    else if (!IsPlayerConnected(giveplayerid)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: Player ID not connected.");
	else if (adminlevel  < 1) SendClientMessage(playerid, COLOUR_ADMINRED,"[Error]: You aren't an admin");
	else
	{
    		if (GetPlayerState(giveplayerid) == PLAYER_STATE_DRIVER)
 			{
		    	GetPlayerPos(playerid,pX,pY,pZ);
		    	SetVehiclePos(GetPlayerVehicleID(giveplayerid),pX,pY,pZ+2);
			}
			else
			{
		    	GetPlayerPos(playerid,pX,pY,pZ);
		    	SetPlayerPos(giveplayerid,pX,pY,pZ+2);
			}
   			SetPlayerInterior(giveplayerid,GetPlayerInterior(playerid));
    		GetPlayerName(playerid, playername, sizeof(playername));
			format(string,sizeof(string),"[Server]: You have been teleported to %s.", playername);
			SendClientMessage(giveplayerid,COLOUR_LIGHTBLUE,string);
	}
	return 1;
}
dcmd_teleport(playerid, params[])
{
    new Float:tX,Float:tY,Float:tZ, string[128], giveplayerid, targetplayerid, adminlevel = AccountInfo[playerid][AdminLevel], giveplayername[MAX_PLAYER_NAME];
    if (sscanf(params, "ii", giveplayerid, targetplayerid)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /teleport [playerid] [target player]");
    else if (!IsPlayerConnected(giveplayerid)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: Player ID not connected.");
	else if (adminlevel  < 1) SendClientMessage(playerid, COLOUR_ADMINRED,"[Error]: You aren't an admin");
	else
	{
			if (GetPlayerState(giveplayerid) == PLAYER_STATE_DRIVER)
			{
		    	GetPlayerPos(targetplayerid,tX,tY,tZ);
		    	SetVehiclePos(GetPlayerVehicleID(giveplayerid),tX,tY,tZ+2);
			}
			else
			{
		    	GetPlayerPos(targetplayerid,tX,tY,tZ);
		    	SetPlayerPos(giveplayerid,tX,tY,tZ+2);
			}
			SetPlayerInterior(giveplayerid,GetPlayerInterior(targetplayerid));
    		GetPlayerName(targetplayerid, giveplayername, sizeof(giveplayername));
			format(string,sizeof(string),"[Server]: You have been teleported to %s.", giveplayername);
			SendClientMessage(giveplayerid,COLOUR_LIGHTBLUE,string);
	}
	return 1;
}
dcmd_setplayerskin(playerid,params[])
{
	new newskin, targetid;
	if (sscanf(params,"id", targetid, newskin))  SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /setplayerskin [playerid][skinID]");
    else if (!IsPlayerConnected(targetid)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: Player ID not connected.");
	else if (AccountInfo[playerid][AdminLevel] < 4) SendClientMessage(playerid, COLOUR_ADMINRED,"[Error]: You aren't a Level 4+ admin.");
	else
	{
			SetPlayerSkin(targetid, newskin);
			SendClientMessage(playerid, COLOUR_ADMINRED,"[Server]: Your skin has sucessfully been changed.");
        	return 1;
	}
	return 1;
}
dcmd_setvehiclepaint(playerid,params[])
{
	new newpaint, veh = GetPlayerVehicleID(playerid);
	if (sscanf(params,"d", newpaint))  SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /setvehiclepaint [paintjobID]");
	else if (AccountInfo[playerid][AdminLevel] < 4) SendClientMessage(playerid, COLOUR_ADMINRED,"[Error]: You aren't a Level 4+ admin.");
	else
	{
			ChangeVehiclePaintjob(veh,newpaint);
			SendClientMessage(playerid, COLOUR_ADMINRED,"[Server]: Your paintjob has sucessfully been changed.");
        	return 1;
	}
	return 1;
}
dcmd_veh(playerid, params[])
{
	new Float:X, Float:Y, Float:Z, pName[24];
	GetPlayerName(playerid, pName, sizeof(pName));
	if(AccountInfo[playerid][AdminLevel] < 3) return false;
	if(!strlen(params)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /spawn [carname]");
	new vehicle = GetVehicleModelIDFromName(params);
    if(vehicle < 400 || vehicle > 611) return SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: Invalid vehicle name!");
	GetPlayerPos(playerid, X, Y, Z);
    new tempVeh = CreateVehicle(vehicle, X, Y, Z, 90,0,0,0);
    PutPlayerInVehicle(playerid, tempVeh, 0);
   	return 1;
}
dcmd_respawn(playerid, params[])
{
	#pragma unused params
	new vehicle;
	vehicle = GetPlayerVehicleID(playerid);
 	RemovePlayerFromVehicle(playerid);
	SetVehicleToRespawn(vehicle);
	SendClientMessage(playerid, COLOUR_ADMINRED, " You have Respawn your vehicle");
	return 1;
}
dcmd_destroycar(playerid, params[])
{
	#pragma unused params
	new vehicle;
	vehicle = GetPlayerVehicleID(playerid);
 	RemovePlayerFromVehicle(playerid);
	DestroyVehicle(vehicle);
	SendClientMessage(playerid, COLOUR_ADMINRED, " You have destroyed your vehicle");
	return 1;
}
dcmd_orgtow(playerid, params[])
{
	#pragma unused params
	if(AccountInfo[playerid][GangRank] >= 4)
	{
	    if(AccountInfo[playerid][pTeam] == 1)
	    {
	    	RemovePlayerFromVehicle(playerid);
        	SetVehicleToRespawn(cop1);
        	SetVehicleToRespawn(cop2);
        	SetVehicleToRespawn(cop3);
        	SetVehicleToRespawn(cop4);
        	SetVehicleToRespawn(cop5);
        	SetVehicleToRespawn(cop6);
        	SetVehicleToRespawn(cop7);
        	SetVehicleToRespawn(cop8);
        	SetVehicleToRespawn(cop9);
        	SetVehicleToRespawn(cop10);
        	SetVehicleToRespawn(cop11);
        	SetVehicleToRespawn(cop12);
        	SetVehicleToRespawn(cop13);
        	SetVehicleToRespawn(cop14);
        	SetVehicleToRespawn(cop15);
        	SetVehicleToRespawn(cop16);
            SetVehicleToRespawn(cop17);
            SetVehicleToRespawn(cop18);
            SetVehicleToRespawn(cop19);
            SetVehicleToRespawn(cop20);
            SetVehicleToRespawn(cop21);
            SetVehicleToRespawn(cop22);
            SetVehicleToRespawn(cop23);
            SendClientMessage(playerid, COLOUR_ADMINRED,"You have towed all your vehicles back to station");
		 }
		 if(AccountInfo[playerid][pTeam] == 2)
		 {
		 	RemovePlayerFromVehicle(playerid);
		 	SetVehicleToRespawn(Forelli1);
		 	SetVehicleToRespawn(Forelli2);
		 	SetVehicleToRespawn(Forelli3);
		 	SetVehicleToRespawn(Forelli4);
		 	SetVehicleToRespawn(Forelli5);
		 	SetVehicleToRespawn(Forelli6);
		 	SetVehicleToRespawn(Forelli7);
		 	SetVehicleToRespawn(Forelli8);
		 	SetVehicleToRespawn(Forelli9);
		 	SetVehicleToRespawn(Forelli10);
		 	SetVehicleToRespawn(Forelli11);
			SendClientMessage(playerid, COLOUR_ADMINRED,"You have towed all your gang car's back to HQ");
		}
        if(AccountInfo[playerid][pTeam] == 3)
		{
			RemovePlayerFromVehicle(playerid);
		 	SetVehicleToRespawn(Biker1);
		 	SetVehicleToRespawn(Biker2);
		 	SetVehicleToRespawn(Biker3);
		 	SetVehicleToRespawn(Biker4);
		 	SetVehicleToRespawn(Biker5);
		 	SetVehicleToRespawn(Biker6);
			SendClientMessage(playerid, COLOUR_ADMINRED,"You have towed all your gang car's back to HQ");
		}
		if(AccountInfo[playerid][pTeam] == 2)
		{
		 	RemovePlayerFromVehicle(playerid);
		 	SetVehicleToRespawn(Gecko1);
		 	SetVehicleToRespawn(Gecko2);
		 	SetVehicleToRespawn(Gecko3);
		 	SetVehicleToRespawn(Gecko4);
		 	SetVehicleToRespawn(Gecko5);
		 	SetVehicleToRespawn(Gecko6);
		 	SetVehicleToRespawn(Gecko7);
		 	SetVehicleToRespawn(Gecko8);
		 	SetVehicleToRespawn(Gecko9);
		 	SetVehicleToRespawn(Gecko10);
			SendClientMessage(playerid, COLOUR_ADMINRED,"You have towed all your gang car's back to HQ");
		}
		if(AccountInfo[playerid][pTeam] == 5)
		 {
		 	RemovePlayerFromVehicle(playerid);
		 	SetVehicleToRespawn(north1);
		 	SetVehicleToRespawn(north2);
		 	SetVehicleToRespawn(north3);
		 	SetVehicleToRespawn(north4);
		 	SetVehicleToRespawn(north5);
		 	SetVehicleToRespawn(north6);
			SendClientMessage(playerid, COLOUR_ADMINRED,"You have towed all your gang car's back to HQ");
		}
	}
	return 1;
}
dcmd_fuck(playerid, params[])
{
    new Float:pX,Float:pY,Float:pZ,Float:X,Float:Y,Float:Z, string[128], giveplayerid, adminlevel = AccountInfo[playerid][AdminLevel], giveplayername[MAX_PLAYER_NAME], sendername[MAX_PLAYER_NAME];
    if (sscanf(params, "i", giveplayerid)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /fuck [playerid]");
    else if (!IsPlayerConnected(giveplayerid)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: Player ID not connected.");
	else if (adminlevel  < 1) SendClientMessage(playerid, COLOUR_ADMINRED,"[Error]: You aren't an admin");
	else
	{
	        GetPlayerName(giveplayerid, giveplayername, sizeof(giveplayername));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			GetPlayerPos(giveplayerid,pX,pY,pZ);
			CreateExplosion(X,Y,Z+100,2,5.0);
			SetPlayerPos(giveplayerid,pX,pY,pZ+100);
			format(string, sizeof(string), "[Server]: Administrator %s has fucked %s up.",sendername, giveplayername);
			SendClientMessageToAdmins(COLOUR_ADMINRED,string,1);
            format(string, sizeof(string), "[Server]: Administrator %s has decided to fuck your shit up.",sendername);
			SendClientMessage(giveplayerid, COLOUR_RED, string);
	}
	return 1;
}
dcmd_clearchat(playerid, params[])
{
	new sendername[MAX_PLAYER_NAME], string[128];
	if (sscanf(params,"")) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /clearchat");
	else if(AccountInfo[playerid][AdminLevel] < 3)SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You aren't a level 3+ Administrator.");
	else
	{
	        for(new chat = 0; chat <= 50; chat++) SendClientMessageToAll(COLOUR_GREEN, " ");
			GetPlayerName(playerid, sendername, 20);
			format(string, 256, "[Server]: Administrator %s has cleared the chat area.", sendername);
			SendClientMessageToAll(COLOUR_LIGHTBLUE, string);
			return 1;
 	}
	return 1;
}
dcmd_spectate(playerid, params[])
{
	new string[128], adminlevel = AccountInfo[playerid][AdminLevel], giveplayername[MAX_PLAYER_NAME], targetid, tmp[5];
    if (sscanf(params, "iz", targetid, tmp)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /spectate [playerid]");
    else if (!IsPlayerConnected(targetid)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: Player ID not connected.");
	else if (adminlevel  < 3) SendClientMessage(playerid, COLOUR_ADMINRED,"[Error]: You aren't an admin");
	else if (!strcmp(tmp, "off", true))
	{
		    TogglePlayerSpectating(playerid, 0);
	     	SetPlayerVirtualWorld(playerid,0);
	     	return 1;
	}
	else
 	{
            GetPlayerName(targetid, giveplayername, sizeof(giveplayername));
			TogglePlayerSpectating(playerid, 1);
		    SetPlayerVirtualWorld(playerid,GetPlayerVirtualWorld(targetid));
		    SetPlayerInterior(playerid,GetPlayerInterior(targetid));
			if (IsPlayerInAnyVehicle(targetid)) PlayerSpectateVehicle(playerid, GetPlayerVehicleID(targetid));
			else PlayerSpectatePlayer(playerid, targetid);
			format(string, sizeof(string),"[Server]: Use /spectate off to stop spectating %s", giveplayername);
			SendClientMessage(playerid, COLOUR_LIGHTBLUE, string);
			return 1;
	}
	return 1;
//<============================================================================>
//<===============================[Gang Commands]==============================>
//<============================================================================>
}
dcmd_setplayerteam(playerid, params[])
{
	new adminlevel = AccountInfo[playerid][AdminLevel],rank, id, newteam, giveplayername[MAX_PLAYER_NAME], sendername[MAX_PLAYER_NAME], string[128];
	if (sscanf(params, "udi", id, newteam,rank)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /setplayerteam [playerid][team 1-5] [Rank 1-5]");
	else if (id == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: Player not found");
	else if (adminlevel < 4) SendClientMessage(playerid, COLOUR_ADMINRED,"[Error]: You aren't a lead admin");
	else if (newteam == 6) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: Team 6 doesn't exist, please choose between 0 & 5");
	else
    {
					GetPlayerName(id, giveplayername, sizeof(giveplayername));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					printf("[Admin]: Administrator %s put %s on team %d.", sendername, giveplayername, newteam);
					AccountInfo[id][pTeam] = newteam;
					AccountInfo[id][GangRank] = rank;
					if(newteam == 0){SetPlayerColor(id,COLOUR_WHITE);}
					if(newteam == 1){SetPlayerColor(id,COLOUR_LIGHTBLUE);}
					if(newteam == 2){SetPlayerColor(id,COLOUR_FORELLI);}
					if(newteam == 3){SetPlayerColor(id,COLOUR_THELOST);}
					if(newteam == 4){SetPlayerColor(id,COLOUR_GECKO);}
					if(newteam == 5){SetPlayerColor(id,COLOUR_NORTHSIDE);}
					format(string, sizeof(string), "[Server]: You have added %s to team %d.", giveplayername, newteam);
					SendClientMessage(playerid, COLOUR_LIGHTBLUE, string);
					format(string, sizeof(string), "[Server]: You are now on team %d and Rank %d thanks to %s.", newteam,rank, sendername);
					SendClientMessage(id, COLOUR_LIGHTBLUE, string);
					SetPlayerTeam(id,newteam);
					OnPlayerUpdateAccount(id);
    }
    return 1;
}
dcmd_setplayerjob(playerid, params[])
{
	new adminlevel = AccountInfo[playerid][AdminLevel],rank, id, newjob, giveplayername[MAX_PLAYER_NAME], sendername[MAX_PLAYER_NAME], string[128];
	if (sscanf(params, "udi", id, newjob,rank)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /setplayerjob [playerid][job 1-9] [Rank 1-5]");
	else if (id == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: Player not found");
	else if (adminlevel < 4) SendClientMessage(playerid, COLOUR_ADMINRED,"[Error]: You aren't a lead admin");
	else if (newjob > 9) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: Job 8 doesn't exist, please choose between 0 & 9");
	else
    {
					GetPlayerName(id, giveplayername, sizeof(giveplayername));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					printf("[Admin]: Administrator %s put %s on job %d.", sendername, giveplayername, newjob);
					AccountInfo[id][pJob] = newjob;
					AccountInfo[id][JobRank] = rank;
					format(string, sizeof(string), "[Server]: You have added %s to job %d.", giveplayername, newjob);
					SendClientMessage(playerid, COLOUR_LIGHTBLUE, string);
					format(string, sizeof(string), "[Server]: You are now on job %d and Rank %d thanks to %s.", newjob,rank, sendername);
					SendClientMessage(id, COLOUR_LIGHTBLUE, string);
					OnPlayerUpdateAccount(id);
    }
    return 1;
}
dcmd_promote(playerid, params[])
{
	new rank = AccountInfo[playerid][GangRank], id, giveplayername[MAX_PLAYER_NAME], sendername[MAX_PLAYER_NAME], string[128];
	if (sscanf(params, "u", id)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /promote [playerid]");
    else if (id == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You cannot promote Dave the Tram Driver.");
    else if (id == 0) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: Player not found.");
	else if (rank < 4) SendClientMessage(playerid, COLOUR_ADMINRED,"[Error]: You aren't a high enough rank.");
	else if (AccountInfo[id][pTeam] != AccountInfo[playerid][pTeam]) SendClientMessage(playerid, COLOUR_ADMINRED,"[Error]: That player is not on your team.");
	else if (AccountInfo[id][GangRank] == 5) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You can't be a higher rank than 6.");
	else
    {
 					GetPlayerName(id, giveplayername, sizeof(giveplayername));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					AccountInfo[id][GangRank]++;
					format(string, sizeof(string), "[Server] Administrator %s promoted %s to rank %d.", sendername,giveplayername, AccountInfo[id][GangRank]);
					SendClientMessageToAdmins(COLOUR_LIGHTBLUE, string, 1);
					format(string, sizeof(string), "[Server]: You have been promoted to rank %d by %s.", AccountInfo[id][GangRank], sendername);
					SendClientMessage(id, COLOUR_LIGHTBLUE, string);
					OnPlayerUpdateAccount(playerid);
	}
    return 1;
}
dcmd_demote(playerid, params[])
{
	new rank = AccountInfo[playerid][GangRank], id, giveplayername[MAX_PLAYER_NAME], sendername[MAX_PLAYER_NAME], string[128];
	if (sscanf(params,"u", id)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /demote [playerid]");
    else if (id == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You cannot demote Dave the Tram Driver.");
    else if (id == 0) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: Player not found.");
	else if (rank < 4) SendClientMessage(playerid, COLOUR_ADMINRED,"[Error]: You aren't a high enough rank.");
	else if (AccountInfo[id][pTeam] != AccountInfo[playerid][pTeam]) SendClientMessage(playerid, COLOUR_ADMINRED,"[Error]: That player is not on your team.");
	else if (rank == 0) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You can't be a lower rank than 0.");
	else
    {
 					GetPlayerName(id, giveplayername, sizeof(giveplayername));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					AccountInfo[id][GangRank]--;
				 	new newrank = AccountInfo[id][GangRank];
					format(string, sizeof(string), "[Server] Administrator %s demoted %s to rank %d.", sendername,giveplayername, newrank);
					SendClientMessageToAdmins(COLOUR_LIGHTBLUE, string, 1);
					format(string, sizeof(string), "[Server]: You have been demoted to rank %d by %s.", newrank, sendername);
					SendClientMessage(id, COLOUR_LIGHTBLUE, string);
					OnPlayerUpdateAccount(playerid);
	}
    return 1;
}
dcmd_invite(playerid, params[])
{
	new rank = AccountInfo[playerid][GangRank], giveplayerid, invitersteam = AccountInfo[playerid][pTeam];
	if (sscanf(params, "u", giveplayerid)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /invite [playerid]");
	else if (giveplayerid == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: Player not found");
	else if (rank < 4) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You can't invite people to your gang.");
	else if(invitersteam == 1)
	{
		ShowPlayerDialog(giveplayerid, 28, DIALOG_STYLE_MSGBOX, "San Fierro Police Department", "Dear Sir or Madam.\nYour application to join the San Fierro Police Department was successful\nAfter careful consideration you were seen as an ideal candidate for the position\nYou will start as soon as you accept this offer\nYours Faithully\n\nSigned\nCommisioner Dale Carroway", "Accept", "Decline");
		return 1;
	}
	else if(invitersteam == 2)
	{
		ShowPlayerDialog(giveplayerid, 29, DIALOG_STYLE_MSGBOX, "Invitation to join the Forelli Familia", "You have been deemed a suitable candidate to join our organisation, do you accept?", "Accept", "Decline");
		return 1;
	}
	else if(invitersteam == 3)
	{
		ShowPlayerDialog(giveplayerid, 30, DIALOG_STYLE_MSGBOX, "Invitation to join the Lost Motorcycle Club", "You have been deemed a suitable candidate to join our organisation, do you accept?", "Accept", "Decline");
		return 1;
	}
	else if(invitersteam == 4)
	{
		ShowPlayerDialog(giveplayerid, 31, DIALOG_STYLE_MSGBOX, "Invitation to join the Triads", "You have been deemed a suitable candidate to join our organisation, do you accept?", "Accept", "Decline");
		return 1;
	}
	else if(invitersteam == 5)
	{
		ShowPlayerDialog(giveplayerid, 32, DIALOG_STYLE_MSGBOX, "Invitation to join the Northside Hustlers", "You have been deemed a suitable candidate to join our organisation, do you accept?", "Accept", "Decline");
		return 1;
	}
	else
    {
  		SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: Your not in a criminal organisation.");
	}
	return 1;
}
dcmd_g(playerid,params[])
{
	new team = AccountInfo[playerid][pTeam], text[128], rank = AccountInfo[playerid][GangRank], sendername[MAX_PLAYER_NAME], string[128], rankname[255];
	if (sscanf(params,"s",text)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /g [text here]");
    else if (team == 2)
	{
            if(rank == 1) {rankname = "Estraneo";}
			if(rank == 2) {rankname = "Soldato ";}
			if(rank == 3) {rankname = "Capodecina";}
 			if(rank == 4) {rankname = "Consigliere";}
			if(rank == 5) {rankname = "Padrino";}
			GetPlayerName(playerid, sendername, sizeof(sendername));
		    format(string, sizeof(string), "[Gang Chat][%s][%s]: %s" ,rankname,sendername , text);
	  		SendClientMessageToForelli(COLOUR_FORELLI, string);
			return 1;
	}
	else if (team == 3)
	{
            if(rank == 1) {rankname = "Dwarf";}
			if(rank == 2) {rankname = "Hurricane";}
			if(rank == 3) {rankname = "Nelson";}
 			if(rank == 4) {rankname = "Centaur";}
			if(rank == 5) {rankname = "Bolts";}
			GetPlayerName(playerid, sendername, sizeof(sendername));
		    format(string, sizeof(string), "[Gang Chat][%s][%s]: %s" ,rankname,sendername , text);
	  		SendClientMessageToTheLost(COLOUR_THELOST, string);
			return 1;
	}
	else if (team == 4)
	{
   			if(rank == 1) {rankname = "Matros";}
			if(rank == 2) {rankname = "Naemnyj";}
			if(rank == 3) {rankname = "Polkovnik";}
 			if(rank == 4) {rankname = "Rukovoditel";}
			if(rank == 5) {rankname = "Labazanov";}
			GetPlayerName(playerid, sendername, sizeof(sendername));
		    format(string, sizeof(string), "[Gang Chat][%s][%s]: %s" ,rankname,sendername , text);
	  		SendClientMessageToGecko(COLOUR_GECKO, string);
			return 1;
	}
	else if (team == 5)
	{
            if(rank == 1) {rankname = "Homie";}
			if(rank == 2) {rankname = "Soulja";}
			if(rank == 3) {rankname = "Pimps";}
 			if(rank == 4) {rankname = "Little Daddy";}
			if(rank == 5) {rankname = "Big Daddy";}
			GetPlayerName(playerid, sendername, sizeof(sendername));
		    format(string, sizeof(string), "[Gang Chat][%s][%s]: %s" ,rankname,sendername , text);
	  		SendClientMessageToNorthside(COLOUR_NORTHSIDE, string);
			return 1;

    }
    else
	{
            SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You are not in a Gang");
	}
    return 1;
}
dcmd_leavegang(playerid,params[])
{
    #pragma unused params
	new team = AccountInfo[playerid][pTeam], text[128], sendername[MAX_PLAYER_NAME], string[128];
    if (team == 2)
	{
			GetPlayerName(playerid, sendername, sizeof(sendername));
		    format(string, sizeof(string), "[Gang]: %s has left our gang." ,sendername , text);
	  		SendClientMessageToForelli(COLOUR_FORELLI, string);
	  		AccountInfo[playerid][pTeam] = 0;
			return 1;
	}
	else if (team == 3)
	{
			GetPlayerName(playerid, sendername, sizeof(sendername));
		    format(string, sizeof(string), "[Gang]: %s has left our gang." ,sendername , text);
	  		SendClientMessageToTheLost(COLOUR_THELOST, string);
	  		AccountInfo[playerid][pTeam] = 0;
			return 1;
	}
	else if (team == 4)
	{
			GetPlayerName(playerid, sendername, sizeof(sendername));
		    format(string, sizeof(string), "[Gang]: %s has left our gang." ,sendername , text);
	  		SendClientMessageToGecko(COLOUR_GECKO, string);
	  		AccountInfo[playerid][pTeam] = 0;
			return 1;
	}
	else if (team == 5)
	{
			GetPlayerName(playerid, sendername, sizeof(sendername));
		    format(string, sizeof(string), "[Gang]: %s has left our gang." ,sendername , text);
	  		SendClientMessageToNorthside(COLOUR_NORTHSIDE, string);
	  		AccountInfo[playerid][pTeam] = 0;
			return 1;

    }
    else
	{
            SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You are not in a Gang");
	}
    return 1;
}
dcmd_remove(playerid,params[])
{
    #pragma unused params
	new targetid, team = AccountInfo[targetid][pTeam], text[128], sendername[MAX_PLAYER_NAME], string[128];
	if(sscanf(params,"u",targetid)) SendClientMessage(playerid,COLOUR_ADMINRED, "[Usage]: /remove [playerid]");
	else if (targetid == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: Player not found");
	else if(AccountInfo[playerid][pTeam] != AccountInfo[targetid][pTeam]) SendClientMessage(playerid,COLOUR_ADMINRED, "[Error]: That player is not in your gang.");
	else if(AccountInfo[playerid][GangRank] < 4) SendClientMessage(playerid,COLOUR_ADMINRED, "[Error]: You aren't a high enough rank.");
	if (team == 2)
	{
			GetPlayerName(targetid, sendername, sizeof(sendername));
		    format(string, sizeof(string), "[Gang]: %s has been kicked from our gang." ,sendername , text);
	  		SendClientMessageToForelli(COLOUR_FORELLI, string);
	  		AccountInfo[playerid][pTeam] = 0;
			return 1;
	}
	else if (team == 3)
	{
			GetPlayerName(targetid, sendername, sizeof(sendername));
		    format(string, sizeof(string), "[Gang]: %s has been kicked from our gang." ,sendername , text);
	  		SendClientMessageToTheLost(COLOUR_THELOST, string);
	  		AccountInfo[playerid][pTeam] = 0;
			return 1;
	}
	else if (team == 4)
	{
			GetPlayerName(targetid, sendername, sizeof(sendername));
		    format(string, sizeof(string), "[Gang]: %s has been kicked from our gang." ,sendername , text);
	  		SendClientMessageToGecko(COLOUR_GECKO, string);
	  		AccountInfo[playerid][pTeam] = 0;
			return 1;
	}
	else if (team == 5)
	{
			GetPlayerName(targetid, sendername, sizeof(sendername));
		    format(string, sizeof(string), "[Gang]: %s has been kicked from our gang." ,sendername , text);
	  		SendClientMessageToNorthside(COLOUR_NORTHSIDE, string);
	  		AccountInfo[playerid][pTeam] = 0;
			return 1;

    }
    else
	{
            SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You are not in a Gang");
	}
    return 1;
}
dcmd_diplomacy(playerid,params[])
{
    #pragma unused params
	new rank = AccountInfo[playerid][GangRank];
	new gang = AccountInfo[playerid][pTeam];
 	if (rank < 5) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: Only a rank 5 can change a gangs stance.");
	switch(gang)
	{
		case 2:
	    {
				ShowPlayerDialog(playerid, 11, DIALOG_STYLE_LIST,"Who would you like to change your stance towards?", "Northside Hustlers\nRed Gecko Tong\nForelli Family", "Accept", "Cancel");
				return 1;
		}
		case 3:
	    {
				ShowPlayerDialog(playerid, 10, DIALOG_STYLE_LIST,"Who would you like to change your stance towards?", "Northside Hustlers\nThe Lost\nRed Gecko Tong", "Accept", "Cancel");
				return 1;
		}
	    case 4:
	   	{
				ShowPlayerDialog(playerid, 9, DIALOG_STYLE_LIST,"Who would you like to change your stance towards?", "Northside Hustlers\nThe Lost\nForelli Family", "Accept", "Cancel");
				return 1;
		}
	    case 5:
	    {
				ShowPlayerDialog(playerid, 8, DIALOG_STYLE_LIST,"Who would you like to change your stance towards?", "The Lost\nRed Gecko Tong\nForelli Family", "Accept", "Cancel");
				return 1;
		}
		default:
		{
				SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You're not in a Gang.");
	    }
	}
	return 1;
}
dcmd_change(playerid,params[])
{
    #pragma unused params
	new team = AccountInfo[playerid][pTeam];
	if (team < 1) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You aren't in an organisation.");
	else if(IsAtJizzys(playerid) && AccountInfo[playerid][pTeam] == 5)
 	{
  			new playerskin, playerrank;
         	playerskin = GetPlayerSkin(playerid);
         	playerrank = AccountInfo[playerid][GangRank];
         	SetPlayerSkin(playerid, 102);

			if(playerskin == 102){SetPlayerSkin( playerid, 103 );}
			if(playerskin == 103){SetPlayerSkin( playerid, 104 );}
			if(playerskin == 104){SetPlayerSkin( playerid, 152 );}
			if(playerskin == 152){SetPlayerSkin( playerid, 265 );}
			if(playerskin == 256){SetPlayerSkin( playerid, 64  );}
			if(playerskin == 64 ){SetPlayerSkin( playerid, 102 );}
            if(playerrank == 3  ){SetPlayerSkin( playerid, 249 );}
    		if(playerrank == 4  ){SetPlayerSkin( playerid, 185 );}
			if(playerrank == 5  ){SetPlayerSkin( playerid, 296 );}
			
			AccountInfo[playerid][Playerskin] = playerskin;
	}
    else if(IsAtWarehouse(playerid) && AccountInfo[playerid][pTeam] == 2)
 	{
  			new playerskin, playerrank;
   		    playerskin = GetPlayerSkin(playerid);
        	playerrank = AccountInfo[playerid][GangRank];
        	SetPlayerSkin(playerid, 117 );
        	
			if(playerskin == 117 ){SetPlayerSkin( playerid, 118);}
			if(playerskin == 118 ){SetPlayerSkin( playerid, 121);}
			if(playerskin == 121 ){SetPlayerSkin( playerid, 117);}
			if(playerrank == 4  ){SetPlayerSkin( playerid, 120 );}
			if(playerrank == 5  ){SetPlayerSkin( playerid, 113 );}
			
			AccountInfo[playerid][Playerskin] = playerskin;
	}
    else if(IsAtGecko(playerid) && AccountInfo[playerid][pTeam] == 4)
 	{
  			new playerskin, playerrank;
   		    playerskin = GetPlayerSkin(playerid);
        	playerrank = AccountInfo[playerid][GangRank];
        	SetPlayerSkin(playerid, 299);

			if(playerskin == 299){SetPlayerSkin( playerid, 127 );}
			if(playerskin == 127){SetPlayerSkin( playerid, 125 );}
			if(playerskin == 125){SetPlayerSkin( playerid, 124 );}
			if(playerskin == 124){SetPlayerSkin( playerid, 299 );}
			if(playerrank == 3  ){SetPlayerSkin( playerid, 126 );}
			if(playerrank == 4  ){SetPlayerSkin( playerid, 187 );}
			if(playerrank == 5  ){SetPlayerSkin( playerid, 186 );}

			AccountInfo[playerid][Playerskin] = playerskin;
	}
    else if(IsAtMistys(playerid) && AccountInfo[playerid][pTeam] == 3)
	{
  			new playerskin, playerrank;
          	playerskin = GetPlayerSkin(playerid);
 			playerrank = AccountInfo[playerid][GangRank];
           	SetPlayerSkin(playerid, 247);
           	
			if(playerskin == 247){SetPlayerSkin( playerid, 248 );}
			if(playerskin == 248){SetPlayerSkin( playerid, 201 );}
			if(playerskin == 201){SetPlayerSkin( playerid, 247 );}
			if(playerrank == 4  ){SetPlayerSkin( playerid, 181 );}
			if(playerrank == 5  ){SetPlayerSkin( playerid, 100 );}
			
			AccountInfo[playerid][Playerskin] = playerskin;
    }
	else if(IsAtRoadRunners(playerid) && AccountInfo[playerid][pJob] == 1)
   	{
 	    	new playerskin;
       	   	playerskin = GetPlayerSkin(playerid);
           	SetPlayerSkin(playerid, 170);

			if(playerskin == 170){SetPlayerSkin( playerid, 220 );}
			if(playerskin == 220){SetPlayerSkin( playerid, 142 );}
			if(playerskin == 142){SetPlayerSkin( playerid, 112 );}
			if(playerskin == 112){SetPlayerSkin( playerid, 14  );}
			if(playerskin == 14 ){SetPlayerSkin( playerid, 156 );}
			if(playerskin == 156){SetPlayerSkin( playerid, 170 );}
			
			if(AccountInfo[playerid][Playerskin] == 0){AccountInfo[playerid][Playerskin] = playerskin;}
	}
	else if(IsAtPizzaPlace(playerid) && AccountInfo[playerid][pJob] == 2)
   	{
 	    	new playerskin;
       	   	playerskin = GetPlayerSkin(playerid);
           	SetPlayerSkin(playerid, 209);

			if(playerskin == 209){SetPlayerSkin( playerid,155 );}
			if(playerskin == 155){SetPlayerSkin( playerid ,209 );}
			
			if(AccountInfo[playerid][Playerskin] == 0){AccountInfo[playerid][Playerskin] = playerskin;}
	}
 	else if(IsAtAirTraffic(playerid) && AccountInfo[playerid][pJob] == 3)
   	{
 	    	new playerskin;
       	   	playerskin = GetPlayerSkin(playerid);
           	SetPlayerSkin(playerid, 61);

			if(playerskin == 61){SetPlayerSkin( playerid, 16   );}
			if(playerskin == 16){SetPlayerSkin( playerid, 253  );}
			if(playerskin == 253){SetPlayerSkin( playerid, 255 );}
			if(playerskin == 255){SetPlayerSkin( playerid, 76  );}
			if(playerskin == 76){SetPlayerSkin( playerid, 125  );}
			
			if(AccountInfo[playerid][Playerskin] == 0){AccountInfo[playerid][Playerskin] = playerskin;}
	}
	else if(IsAtChurch(playerid) && AccountInfo[playerid][pJob] == 5)
   	{
 	    	new playerskin;
       	   	playerskin = GetPlayerSkin(playerid);
           	SetPlayerSkin(playerid, 68);
			if(playerskin == 170){SetPlayerSkin( playerid, 227 );}
   			if(playerskin == 227){SetPlayerSkin( playerid, 228 );}
   			if(playerskin == 228){SetPlayerSkin( playerid, 255 );}
   			if(playerskin == 255){SetPlayerSkin( playerid, 68 );}
   			
   			if(AccountInfo[playerid][Playerskin] == 0){AccountInfo[playerid][Playerskin] = playerskin;}
	}
	else
	{
			SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You're not at your Head Quarters");
 	}
 	new Saveskin = GetPlayerSkin(playerid);
 	AccountInfo[playerid][Playerskin] = Saveskin;
 	OnPlayerUpdateAccount(playerid);
	return 1;
}
dcmd_storage(playerid,params[])
{
	new team = AccountInfo[playerid][pTeam], string[128];
	if (sscanf(params,"")) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /storage");
	else if (team < 2) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You aren't in a criminal organisation.");
	else if(IsAtJizzys(playerid) && AccountInfo[playerid][pTeam] == 5)
 	{
			new Money 	= dini_Int("/Gangs/Northside.ini" , "Cash"    );
   			new Weed  	= dini_Int("/Gangs/Northside.ini" , "Cannabis");
   			new Sniff 	= dini_Int("/Gangs/Northside.ini" , "Cocaine" );
      		new Crack1	= dini_Int("/Gangs/Northside.ini" , "Crack"	);
      		new Ecstasy1 = dini_Int("/Gangs/Northside.ini", "Ecstasy" );
        	new Guns  	= dini_Int("/Gangs/Northside.ini" , "Firearms");
         	new Kev   	= dini_Int("/Gangs/Northside.ini" , "Kevlar"  );
          	SendClientMessage(playerid,COLOUR_NORTHSIDE,"<=====[Hustler's Storage]=====>");
            format(string,sizeof(string),"[Money]:$%d dollars", Money);
			SendClientMessage(playerid,COLOUR_NORTHSIDE,string);
            format(string,sizeof(string),"[Weed]:%d grams",Weed);
			SendClientMessage(playerid,COLOUR_NORTHSIDE,string);
     		format(string,sizeof(string),"[Sniff]:%d grams",Sniff);
			SendClientMessage(playerid,COLOUR_NORTHSIDE,string);
			format(string,sizeof(string),"[Crack]:%d grams",Crack1);
			SendClientMessage(playerid,COLOUR_NORTHSIDE,string);
			format(string,sizeof(string),"[Pills]:%d pills",Ecstasy1);
			SendClientMessage(playerid,COLOUR_NORTHSIDE,string);
			format(string,sizeof(string),"[Firearms]: %d pieces",Guns);
			SendClientMessage(playerid,COLOUR_NORTHSIDE,string);
			format(string,sizeof(string),"[Kevlar]: %d Vests",Kev);
			SendClientMessage(playerid,COLOUR_NORTHSIDE,string);
	}
   	else if(IsAtMistys(playerid) && AccountInfo[playerid][pTeam] == 3)
	{
	 		new Money 	= dini_Int("/Gangs/TheLost.ini" , "Cash"    );
    		new Weed  	= dini_Int("/Gangs/TheLost.ini" , "Cannabis");
            new Sniff 	= dini_Int("/Gangs/TheLost.ini" , "Cocaine" );
            new Crack1	= dini_Int("/Gangs/TheLost.ini" , "Crack"	  );
            new Ecstasy1 = dini_Int("/Gangs/TheLost.ini", "Ecstasy" );
            new Guns  	= dini_Int("/Gangs/TheLost.ini" , "Firearms");
            new Kev  	= dini_Int("/Gangs/TheLost.ini" , "Kevlar"  );
            SendClientMessage(playerid,COLOUR_THELOST,"<=====[Lost's Storage]=====>");
            format(string,sizeof(string),"[Money]:$%d dollars", Money);
			SendClientMessage(playerid,COLOUR_THELOST,string);
            format(string,sizeof(string),"[Weed]:%d grams",Weed);
			SendClientMessage(playerid,COLOUR_THELOST,string);
     		format(string,sizeof(string),"[Sniff]:%d grams",Sniff);
			SendClientMessage(playerid,COLOUR_THELOST,string);
			format(string,sizeof(string),"[Crack]:%d grams",Crack1);
			SendClientMessage(playerid,COLOUR_THELOST,string);
			format(string,sizeof(string),"[Pills]:%d pills",Ecstasy1);
			SendClientMessage(playerid,COLOUR_THELOST,string);
			format(string,sizeof(string),"[Firearms]: %d pieces",Guns);
			SendClientMessage(playerid,COLOUR_THELOST,string);
			format(string,sizeof(string),"[Kevlar]: %d Vests",Kev);
			SendClientMessage(playerid,COLOUR_THELOST,string);
	}
	else if(IsAtWarehouse(playerid) && AccountInfo[playerid][pTeam] == 2)
 	{
			new Money 	= dini_Int("/Gangs/Forelli.ini" , "Cash"    );
   			new Weed  	= dini_Int("/Gangs/Forelli.ini" , "Cannabis");
   			new Sniff 	= dini_Int("/Gangs/Forelli.ini" , "Cocaine" );
      		new Crack1	= dini_Int("/Gangs/Forelli.ini" , "Crack"	);
      		new Ecstasy1 = dini_Int("/Gangs/Forelli.ini", "Ecstasy" );
        	new Guns  	= dini_Int("/Gangs/Forelli.ini" , "Firearms");
         	new Kev   	= dini_Int("/Gangs/Forelli.ini" , "Kevlar"  );
          	SendClientMessage(playerid,COLOUR_FORELLI,"<=====[Forelli's Storage]=====>");
            format(string,sizeof(string),"[Money]:$%d dollars", Money);
			SendClientMessage(playerid,COLOUR_FORELLI,string);
            format(string,sizeof(string),"[Weed]:%d grams",Weed);
			SendClientMessage(playerid,COLOUR_FORELLI,string);
     		format(string,sizeof(string),"[Sniff]:%d grams",Sniff);
			SendClientMessage(playerid,COLOUR_FORELLI,string);
			format(string,sizeof(string),"[Crack]:%d grams",Crack1);
			SendClientMessage(playerid,COLOUR_FORELLI,string);
			format(string,sizeof(string),"[Pills]:%d pills",Ecstasy1);
			SendClientMessage(playerid,COLOUR_FORELLI,string);
			format(string,sizeof(string),"[Firearms]: %d pieces",Guns);
			SendClientMessage(playerid,COLOUR_FORELLI,string);
			format(string,sizeof(string),"[Kevlar]: %d Vests",Kev);
			SendClientMessage(playerid,COLOUR_FORELLI,string);
	}
	else if(IsAtGecko(playerid) && AccountInfo[playerid][pTeam] == 4)
 	{
			new Money 	= dini_Int("/Gangs/Gecko.ini" , "Cash"    );
   			new Weed  	= dini_Int("/Gangs/Gecko.ini" , "Cannabis");
   			new Sniff 	= dini_Int("/Gangs/Gecko.ini" , "Cocaine" );
      		new Crack1	= dini_Int("/Gangs/Gecko.ini" , "Crack"	);
      		new Ecstasy1 = dini_Int("/Gangs/Gecko.ini", "Ecstasy" );
        	new Guns  	= dini_Int("/Gangs/Gecko.ini" , "Firearms");
         	new Kev   	= dini_Int("/Gangs/Gecko.ini" , "Kevlar"  );
          	SendClientMessage(playerid,COLOUR_GECKO,"<=====[Geckos's Storage]=====>");
            format(string,sizeof(string),"[Money]:$%d dollars", Money);
			SendClientMessage(playerid,COLOUR_GECKO,string);
            format(string,sizeof(string),"[Weed]:%d grams",Weed);
			SendClientMessage(playerid,COLOUR_GECKO,string);
     		format(string,sizeof(string),"[Sniff]:%d grams",Sniff);
			SendClientMessage(playerid,COLOUR_GECKO,string);
			format(string,sizeof(string),"[Crack]:%d grams",Crack1);
			SendClientMessage(playerid,COLOUR_GECKO,string);
			format(string,sizeof(string),"[Pills]:%d pills",Ecstasy1);
			SendClientMessage(playerid,COLOUR_GECKO,string);
			format(string,sizeof(string),"[Firearms]: %d pieces",Guns);
			SendClientMessage(playerid,COLOUR_GECKO,string);
			format(string,sizeof(string),"[Kevlar]: %d Vests",Kev);
			SendClientMessage(playerid,COLOUR_GECKO,string);
	}
	else
	{
			SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You're not at your Gang's HQ");

 	}
 	return 1;
}
dcmd_store(playerid,params[])
{
	new team = AccountInfo[playerid][pTeam], option[64], amount, string [128];
	if (sscanf(params,"sd", option, amount)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /store [Item] [Amount]");
	else if (team < 2) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You aren't in a criminal organisation.");
	else if(IsAtJizzys(playerid) && AccountInfo[playerid][pTeam] == 5)
    {
            new oldvalue = dini_Int("/Gangs/Northside.ini",option);
			new newvalue = amount + oldvalue;
			dini_IntSet("/Gangs/Northside.ini", option, newvalue);
            if(!strcmp(option, "Cash"    , true, 4)) AccountInfo[playerid][Cash]		= AccountInfo[playerid][Cash]  - amount;
            if(!strcmp(option, "Cannabis", true, 8)) AccountInfo[playerid][Cannabis] = AccountInfo[playerid][Cannabis] - amount;
            if(!strcmp(option, "Cocaine" , true, 7)) AccountInfo[playerid][Cocaine]  = AccountInfo[playerid][Cocaine]  - amount;
            if(!strcmp(option, "Crack"   , true, 5)) AccountInfo[playerid][Crack]    = AccountInfo[playerid][Crack]    - amount;
            if(!strcmp(option, "Ecstasy" , true, 7)) AccountInfo[playerid][Ecstasy]  = AccountInfo[playerid][Ecstasy]  - amount;
            if(!strcmp(option, "Firearms", true, 8)) AccountInfo[playerid][Firearms] = AccountInfo[playerid][Firearms] - amount;
 			format(string,sizeof(string),"You have stored %d of %s.",amount,option);
			SendClientMessage(playerid,COLOUR_NORTHSIDE,string);
	}
   	else if(IsAtMistys(playerid) && AccountInfo[playerid][pTeam] == 3)
	{
            new oldvalue = dini_Int("/Gangs/TheLost.ini",option);
			new newvalue = amount + oldvalue;
			dini_IntSet("/Gangs/TheLost.ini", option, newvalue);
            if(!strcmp(option, "Cash"    , true, 4)) AccountInfo[playerid][Cash]		= AccountInfo[playerid][Cash]     - amount;
            if(!strcmp(option, "Cannabis", true, 8)) AccountInfo[playerid][Cannabis] = AccountInfo[playerid][Cannabis] - amount;
            if(!strcmp(option, "Cocaine" , true, 7)) AccountInfo[playerid][Cocaine]  = AccountInfo[playerid][Cocaine]  - amount;
            if(!strcmp(option, "Crack"   , true, 5)) AccountInfo[playerid][Crack]    = AccountInfo[playerid][Crack]    - amount;
            if(!strcmp(option, "Ecstasy" , true, 7)) AccountInfo[playerid][Ecstasy]  = AccountInfo[playerid][Ecstasy]  - amount;
            if(!strcmp(option, "Firearms", true, 8)) AccountInfo[playerid][Firearms] = AccountInfo[playerid][Firearms] - amount;
 			format(string,sizeof(string),"You have stored %d of %s.",amount,option);
			SendClientMessage(playerid,COLOUR_THELOST,string);
	}
	else if(IsAtWarehouse(playerid) && AccountInfo[playerid][pTeam] == 2)
	{
            new oldvalue = dini_Int("/Gangs/Forelli.ini",option);
			new newvalue = amount + oldvalue;
			dini_IntSet("/Gangs/Forelli.ini", option, newvalue);
            if(!strcmp(option, "Cash"    , true, 4)) AccountInfo[playerid][Cash]		= AccountInfo[playerid][Cash]     - amount;
            if(!strcmp(option, "Cannabis", true, 8)) AccountInfo[playerid][Cannabis] = AccountInfo[playerid][Cannabis] - amount;
            if(!strcmp(option, "Cocaine" , true, 7)) AccountInfo[playerid][Cocaine]  = AccountInfo[playerid][Cocaine]  - amount;
            if(!strcmp(option, "Crack"   , true, 5)) AccountInfo[playerid][Crack]    = AccountInfo[playerid][Crack]    - amount;
            if(!strcmp(option, "Ecstasy" , true, 7)) AccountInfo[playerid][Ecstasy]  = AccountInfo[playerid][Ecstasy]  - amount;
            if(!strcmp(option, "Firearms", true, 8)) AccountInfo[playerid][Firearms] = AccountInfo[playerid][Firearms] - amount;
 			format(string,sizeof(string),"You have stored %d of %s.",amount,option);
			SendClientMessage(playerid,COLOUR_FORELLI,string);
	}
	else if(IsAtGecko(playerid) && AccountInfo[playerid][pTeam] == 4)
	{
            new oldvalue = dini_Int("/Gangs/Gecko.ini",option);
			new newvalue = amount + oldvalue;
			dini_IntSet("/Gangs/Gecko.ini", option, newvalue);
            if(!strcmp(option, "Cash"    , true, 4)) AccountInfo[playerid][Cash]		= AccountInfo[playerid][Cash]     - amount;
            if(!strcmp(option, "Cannabis", true, 8)) AccountInfo[playerid][Cannabis] = AccountInfo[playerid][Cannabis] - amount;
            if(!strcmp(option, "Cocaine" , true, 7)) AccountInfo[playerid][Cocaine]  = AccountInfo[playerid][Cocaine]  - amount;
            if(!strcmp(option, "Crack"   , true, 5)) AccountInfo[playerid][Crack]    = AccountInfo[playerid][Crack]    - amount;
            if(!strcmp(option, "Ecstasy" , true, 7)) AccountInfo[playerid][Ecstasy]  = AccountInfo[playerid][Ecstasy]  - amount;
            if(!strcmp(option, "Firearms", true, 8)) AccountInfo[playerid][Firearms] = AccountInfo[playerid][Firearms] - amount;
 			format(string,sizeof(string),"You have stored %d of %s.",amount,option);
			SendClientMessage(playerid,COLOUR_FORELLI,string);
	}
	else
	{
			SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You're not at your Gang's HQ");

    }
    return 1;
}
dcmd_take(playerid,params[])
{
	new team = AccountInfo[playerid][pTeam], option[64], amount, string [128];
	if (sscanf(params,"sd", option, amount)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /take [Cash/Cannabis/Cocaine/Crack/Ecstasy/Firearms] [Amount]");
	else if (team < 2) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You aren't in a criminal organisation.");
	else if(IsAtJizzys(playerid) && AccountInfo[playerid][pTeam] == 5)
    {
            new oldvalue = dini_Int("/Gangs/Northside.ini",option);
			new newvalue = amount - oldvalue;
			dini_IntSet("/Gangs/Northside.ini", option, newvalue);
            if(!strcmp(option, "Cash"    , true, 4)) AccountInfo[playerid][Cash]	 = AccountInfo[playerid][Cash]     + amount;
            if(!strcmp(option, "Cannabis", true, 8)) AccountInfo[playerid][Cannabis] = AccountInfo[playerid][Cannabis] + amount;
            if(!strcmp(option, "Cocaine" , true, 7)) AccountInfo[playerid][Cocaine]  = AccountInfo[playerid][Cocaine]  + amount;
            if(!strcmp(option, "Crack"   , true, 5)) AccountInfo[playerid][Crack]    = AccountInfo[playerid][Crack]    + amount;
            if(!strcmp(option, "Ecstasy" , true, 7)) AccountInfo[playerid][Ecstasy]  = AccountInfo[playerid][Ecstasy]  + amount;
            if(!strcmp(option, "Firearms", true, 8)) AccountInfo[playerid][Firearms] = AccountInfo[playerid][Firearms] + amount;
 			format(string,sizeof(string),"You have taken %d of %s.",amount,option);
			SendClientMessage(playerid,COLOUR_NORTHSIDE,string);
	}
	else if(IsAtWarehouse(playerid) && AccountInfo[playerid][pTeam] == 2)
    {
            new oldvalue = dini_Int("/Gangs/Forelli.ini",option);
			new newvalue = amount - oldvalue;
			dini_IntSet("/Gangs/Forelli.ini", option, newvalue);
            if(!strcmp(option, "Cash"    , true, 4)) AccountInfo[playerid][Cash]		= AccountInfo[playerid][Cash]     + amount;
            if(!strcmp(option, "Cannabis", true, 8)) AccountInfo[playerid][Cannabis] = AccountInfo[playerid][Cannabis] + amount;
            if(!strcmp(option, "Cocaine" , true, 7)) AccountInfo[playerid][Cocaine]  = AccountInfo[playerid][Cocaine]  + amount;
            if(!strcmp(option, "Crack"   , true, 5)) AccountInfo[playerid][Crack]    = AccountInfo[playerid][Crack]    + amount;
            if(!strcmp(option, "Ecstasy" , true, 7)) AccountInfo[playerid][Ecstasy]  = AccountInfo[playerid][Ecstasy]  + amount;
            if(!strcmp(option, "Firearms", true, 8)) AccountInfo[playerid][Firearms] = AccountInfo[playerid][Firearms] + amount;
 			format(string,sizeof(string),"You have taken %d of %s.",amount,option);
			SendClientMessage(playerid,COLOUR_FORELLI,string);
	}
	else if(IsAtGecko(playerid) && AccountInfo[playerid][pTeam] == 4)
    {
            new oldvalue = dini_Int("/Gangs/Gecko.ini",option);
			new newvalue = amount - oldvalue;
			dini_IntSet("/Gangs/Gecko.ini", option, newvalue);
            if(!strcmp(option, "Cash"    , true, 4)) AccountInfo[playerid][Cash]		= AccountInfo[playerid][Cash]     + amount;
            if(!strcmp(option, "Cannabis", true, 8)) AccountInfo[playerid][Cannabis] = AccountInfo[playerid][Cannabis] + amount;
            if(!strcmp(option, "Cocaine" , true, 7)) AccountInfo[playerid][Cocaine]  = AccountInfo[playerid][Cocaine]  + amount;
            if(!strcmp(option, "Crack"   , true, 5)) AccountInfo[playerid][Crack]    = AccountInfo[playerid][Crack]    + amount;
            if(!strcmp(option, "Ecstasy" , true, 7)) AccountInfo[playerid][Ecstasy]  = AccountInfo[playerid][Ecstasy]  + amount;
            if(!strcmp(option, "Firearms", true, 8)) AccountInfo[playerid][Firearms] = AccountInfo[playerid][Firearms] + amount;
 			format(string,sizeof(string),"You have taken %d of %s.",amount,option);
			SendClientMessage(playerid,COLOUR_GECKO,string);
	}
   	else if(IsAtMistys(playerid) && AccountInfo[playerid][pTeam] == 3)
	{
            new oldvalue = dini_Int("/Gangs/TheLost.ini",option);
			new newvalue = amount - oldvalue;
			dini_IntSet("/Gangs/TheLost.ini", option, newvalue);
            if(!strcmp(option, "Cash"    , true, 4)) AccountInfo[playerid][Cash]		= AccountInfo[playerid][Cash]     + amount;
            if(!strcmp(option, "Cannabis", true, 8)) AccountInfo[playerid][Cannabis] = AccountInfo[playerid][Cannabis] + amount;
            if(!strcmp(option, "Cocaine" , true, 7)) AccountInfo[playerid][Cocaine]  = AccountInfo[playerid][Cocaine]  + amount;
            if(!strcmp(option, "Crack"   , true, 5)) AccountInfo[playerid][Crack]    = AccountInfo[playerid][Crack]    + amount;
            if(!strcmp(option, "Ecstasy" , true, 7)) AccountInfo[playerid][Ecstasy]  = AccountInfo[playerid][Ecstasy]  + amount;
            if(!strcmp(option, "Firearms", true, 8)) AccountInfo[playerid][Firearms] = AccountInfo[playerid][Firearms] + amount;
 			format(string,sizeof(string),"You have stored %d of %s.",amount,option);
			SendClientMessage(playerid,COLOUR_THELOST,string);
	}
	else
	{
			SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You're not at your Gang's HQ");

    }
    return 1;
}
dcmd_getweapon(playerid,params[])
{
	#pragma unused params
	new team = AccountInfo[playerid][pTeam];
	if (team < 2) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You aren't in a criminal organisation.");
	else if(IsAtJizzys(playerid) && AccountInfo[playerid][pTeam] == 5)
    {
            ShowPlayerDialog(playerid, 1, DIALOG_STYLE_LIST, "What weapon you taking kid?", "Knife\nBaseball Bat\n9mm\nDesert Eagle\nShotgun\nMicro-SMG\nTec9\nAK47\nKevlar", "Take", "Cancel");
            return 1;
	}
	else if(IsAtWarehouse(playerid) && AccountInfo[playerid][pTeam] == 2)
    {
            ShowPlayerDialog(playerid, 1, DIALOG_STYLE_LIST, "What weapon would you like?", "Knife\nBaseball Bat\n9mm\nDesert Eagle\nShotgun\nMicro-SMG\nTec9\nAK47\nKevlar", "Take", "Cancel");
            return 1;
	}
   	else if(IsAtMistys(playerid) && AccountInfo[playerid][pTeam] == 3)
	{
   			ShowPlayerDialog(playerid, 1, DIALOG_STYLE_LIST, "What weapon you wanna' use?", "Knife\nBaseball Bat\n9mm\nDesert Eagle\nShotgun\nMicro-SMG\nTec9\nAK47\nKevlar", "Take", "Cancel");
            return 1;
	}
   	else if(IsAtGecko(playerid) && AccountInfo[playerid][pTeam] == 4)
	{
   			ShowPlayerDialog(playerid, 1, DIALOG_STYLE_LIST, "What weapon you would you like comrade?", "Knife\nBaseball Bat\n9mm\nDesert Eagle\nShotgun\nMicro-SMG\nTec9\nAK47\nKevlar", "Take", "Cancel");
            return 1;
	}
	else
	{
			SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You're not at your Gang's HQ");

    }
    return 1;
}
dcmd_openjizzys(playerid,params[])
{
    #pragma unused params
   	new team = AccountInfo[playerid][pTeam];
	if (team != 5) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You aren't in the Northside Hustlers.");
	else if(AccountInfo[playerid][GangRank] < 3) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You aren't a high enough rank to open Jizzys.");
	else if(IsAtJizzys(playerid))
    {
        SendClientMessageToAll(COLOUR_NORTHSIDE, "[Jizzys]: Jizzys Bar is now open, every pimp and hoe is welcome.");
        ConnectNPC("Chantelle","JizzysStripper1");
	}
	return 1;
//<============================================================================>
//<================================[Job Commands]==============================>
//<============================================================================>
}
dcmd_getjob(playerid,params[])
{
    #pragma unused params
	if(AccountInfo[playerid][pJob] > 0) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You already have a Job.");
    else
	{
	    if(IsAtRoadRunners(playerid))
	    {
         	SendClientMessage(playerid,COLOUR_YELLOW, "[Jaydeep]: Okay, I'll give you a job but one foot outta' line and your gone.");
     	    AccountInfo[playerid][pJob] = 1;
     	    return 1;
		}
		if(IsAtPizzaPlace(playerid))
		{
            SendClientMessage(playerid,COLOUR_ORANGE, "[Mario]: Fantasico, you can start right now, I'll call you when we get a call.");
            AccountInfo[playerid][pJob] = 2;
            return 1;
		}
		if(IsAtSFFD(playerid))
		{
            SendClientMessage(playerid,COLOUR_ORANGE, "[The Chief]: We are always looking for extra help, welcome aboard.");
            AccountInfo[playerid][pJob] = 7;
            return 1;
		}
		if(IsAtSFHospital(playerid))
		{
            SendClientMessage(playerid,COLOUR_ORANGE, "[Dr Falcode]: Your hired but... im sorry im urgently needed in the Wankbunker Ward.");
            AccountInfo[playerid][pJob] = 8;
            return 1;
		}
		else
		{
  			SendClientMessage(playerid,COLOUR_ADMINRED, "[Error]: You are not located at a Job icon.");
  			return 1;
		}
	}
	return 1;
}
dcmd_leavejob(playerid,params[])
{
    #pragma unused params
	if(AccountInfo[playerid][pJob] == 0) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You don't have a Job.");
    else
	{
	    if(AccountInfo[playerid][pJob] == 1)
	    {
         	SendClientMessage(playerid,COLOUR_YELLOW, "[Jaydeep]: You'll be back, you just wait.");
     	    AccountInfo[playerid][pJob] = 0;
		}
		if(AccountInfo[playerid][pJob] == 1)
		{
            SendClientMessage(playerid,COLOUR_ORANGE, "[Mario]: *italian curse words*, Ali vi' Derci!.");
            AccountInfo[playerid][pJob] = 0;
		}
		if(AccountInfo[playerid][pJob] == 3)
		{
            SendClientMessage(playerid,COLOUR_GREY, "[Captain Oveur]: It's a shame to lose you son, good luck out there.");
            AccountInfo[playerid][pJob] = 0;
		}
		AccountInfo[playerid][jLevel] = 0;
		AccountInfo[playerid][jExp] = 0;
	}
	return 1;
}
dcmd_offerjob(playerid, params[])
{
	new rank = AccountInfo[playerid][JobRank], giveplayerid, invitersjob = AccountInfo[playerid][pJob];
	if (sscanf(params, "u", giveplayerid)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /offerjob [playerid]");
	else if (giveplayerid == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: Player not found.");
	else if (rank < 4) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You can't offer people jobs.");
	else if(invitersjob == 3)
	{
		AccountInfo[giveplayerid][JobOffer] = 3;
		SendClientMessage(giveplayerid,COLOUR_WHITE,"[Job]: You have been invited to join Juank Airways. Type /join or /no.");
	}
	else if(invitersjob == 4)
	{
		AccountInfo[giveplayerid][JobOffer] = 4;
		SendClientMessage(giveplayerid,COLOUR_WHITE,"[Job]: You have been invited to join the San Fierro Church. Type /join or /no.");
	}
	else if(invitersjob == 5)
	{
		AccountInfo[giveplayerid][JobOffer] = 5;
		SendClientMessage(giveplayerid,COLOUR_WHITE,"[Job]: You have been invited to join Longs Haulage. Type /join or /no.");
	}
	else if(invitersjob == 6)
	{
		AccountInfo[giveplayerid][JobOffer] = 6;
		SendClientMessage(giveplayerid,COLOUR_WHITE,"[Job]: You have been invited to join the San Andreas News team. Type /join or /no.");
	}
	else
    {
  		SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You cant use this command.");
	}
    OnPlayerUpdateAccount(playerid);
	return 1;
}
dcmd_fire(playerid, params[])
{
	new rank = AccountInfo[playerid][JobRank], giveplayerid;
	if (sscanf(params, "u", giveplayerid)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /offerjob [playerid]");
	else if (giveplayerid == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: Player not found.");
	else if (rank < 4) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You can't offer people jobs.");
	else
    {
        SendClientMessage(playerid, COLOUR_ADMINRED, "[Job]: I'm sorry but we are going to have to let you go.");
		AccountInfo[giveplayerid][pJob] = 0;
		AccountInfo[playerid][JobRank] = 0;
	}
    OnPlayerUpdateAccount(playerid);
	return 1;
}
dcmd_ordertaxi(playerid,params[])
{
	new string[128],to[128],from[128],name[MAX_PLAYER_NAME];
	if (sscanf(params,"ss", from, to)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /ordertaxi [Pickup] [Destination]");
	else
	{
		GetPlayerName(playerid, name, sizeof(name));
		if(IsAtRoadRunners(playerid))
		{
         	format(string,sizeof(string),"[Jaydeep]: %s is at HQ and wants dropping off at %s.",name,to);
			SendClientMessageToRoadRunners(COLOUR_YELLOW,string);
			SendClientMessage(playerid, COLOUR_YELLOW, "[Jaydeep]: There will be a taxi with you shortly.");
		}
		else
		{
         	format(string,sizeof(string),"[Jaydeep]: %s wants picking up from %s and taking to %s.",name,from,to);
			SendClientMessageToRoadRunners(COLOUR_YELLOW,string);
			SendClientMessage(playerid, COLOUR_YELLOW, "[Jaydeep]: There will be a taxi with you shortly.");
		}
	}
	return 1;
}
dcmd_onduty(playerid,params[])
{
    #pragma unused params
    new name[MAX_PLAYER_NAME], string[128];
	if(AccountInfo[playerid][pJob] != 1) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You are not a Taxi Driver.");
    else
	{
 		GetPlayerName(playerid, name, sizeof(name));
  		format(string,sizeof(string),"[%s]: Roadrunner taxi driver is now onduty and available for fares.",name);
		SendClientMessageToAll(COLOUR_YELLOW,string);
	}
	return 1;
}
dcmd_orderpizza(playerid,params[])
{
	new string[128],to[128],pizza[128],name[MAX_PLAYER_NAME];
	if (sscanf(params,"sz", to)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /OrderPizza [Destination] [Pizzatype]");	else
	{
		GetPlayerName(playerid, name, sizeof(name));
		if(IsAtRoadRunners(playerid))
        format(string,sizeof(string),"[Mario]: %s wants a %s delivering to %s.",name,pizza,to);
		SendClientMessageToRoadRunners(COLOUR_ORANGE,string);
		SendClientMessage(playerid, COLOUR_ORANGE, "[Mario]: Your pizza will be with you shortly.");
		AccountInfo[playerid][OrderedPizza] = 1;
	}
	return 1;
}
dcmd_deliver(playerid,params[])
{
	new string[128],price,targetid,name[MAX_PLAYER_NAME];
	if (sscanf(params,"ud", targetid, price)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /deliver [playerid] [price]");
	else if (AccountInfo[playerid][pJob] != 2) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: You aren't a pizza boy.");
	else if (AccountInfo[targetid][OrderedPizza] != 1) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: This player has not ordered a pizza.");
	else
	{
		GetPlayerName(playerid, name, sizeof(name));
		SetPlayerHealth(playerid, 100);
		format(string,sizeof(string),"[%s]: Here's the Pizza you ordered that will be $%d dollars, please.",name,price);
		SendClientMessage(targetid,COLOUR_ORANGE,string);
		SendClientMessage(playerid, COLOUR_ORANGE, "[Mario]: Okay wait for another order.");
		GivePlayerMoney(playerid,-price);
		GivePlayerMoney(targetid,price);
		AccountInfo[playerid][OrderedPizza] = 0;
	}
	return 1;
}
dcmd_news(playerid,params[])
{
	new news[128],intro[128],name[MAX_PLAYER_NAME];
	if (sscanf(params,"s", news)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /news [message]");
	else if (AccountInfo[playerid][pJob] != 6) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: You aren't a member of S.A.N.");
	else
	{
        GetPlayerName(playerid, name, sizeof(name));
		format(intro, sizeof(intro), "[NewsFlash]: This is reporter %s with some breaking news!", intro );
		SendClientMessageToAll(COLOUR_ADMINRED, intro);
		format(news, sizeof(news), "[NewsFlash]: %s", news);
		SendClientMessageToAll(COLOUR_ADMINRED, news);
	}
	return 1;
}
dcmd_revive(playerid,params[])
{
    new name[MAX_PLAYER_NAME],string[128], giveplayerid, Float:X, Float:Y, Float:Z;
    GetPlayerPos(playerid,X,Y,Z);
	if (sscanf(params,"u", giveplayerid))SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /revive [playerid");
	else if(AccountInfo[playerid][pJob] != 8) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: You aren't a paramedic.");
	else if(!IsPlayerConnected(giveplayerid)) SendClientMessage(playerid,COLOUR_ADMINRED, "[Error]: That player is not connected");
	else if(giveplayerid == playerid)SendClientMessage(playerid,COLOUR_ADMINRED, "[Error]:You cannot revive yourself!");
	else if(!PlayerToPoint(3.0,giveplayerid,X,Y,Z)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You are not close enough to the patient.");
    else if(playerid == giveplayerid)
	{
        SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: Can't revive yourself.");
	}
	else
	{
		GetPlayerName(playerid, name, sizeof(name));
		format(string,sizeof(string),"%s takes out the crash kit.",name);
		SetPlayerHealth(giveplayerid, 25);
		GivePlayerMoney(playerid, 100);
		GivePlayerMoney(giveplayerid, -25);
		AccountInfo[playerid][jExp]++;
		AccountInfo[playerid][jExp]++;
	}
	return 1;
}
dcmd_heal(playerid,params[])
{
	new string[128],targetid,name[MAX_PLAYER_NAME];
 	new Float:health;
 	GetPlayerHealth(targetid,health);
	if (sscanf(params,"u", targetid)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /heal [playerid");
	else if(AccountInfo[playerid][pJob] != 8 || AccountInfo[playerid][pJob] != 8) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: You aren't a paramedic.");
    else if(playerid == targetid)
	{
		GetPlayerName(playerid, name, sizeof(name));
		format(string,sizeof(string),"%s takes out a first aid kit and heals himself.",name);
		SetPlayerHealth(targetid, 100);
	}
	else
	{
		GetPlayerName(playerid, name, sizeof(name));
		format(string,sizeof(string),"%s takes out a first aid kit.",name);
		SetPlayerHealth(targetid, 100);
		GivePlayerMoney(playerid, 100);
		GivePlayerMoney(targetid, -25);
		AccountInfo[playerid][jExp]++;
	}
	return 1;
//<============================================================================>
//<========================[Drug & Arms Related Commands]======================>
//<============================================================================>
}
dcmd_import(playerid, params[])
{//      Generates the Drug          Generates the Amount       Generates the Price
	new Randomdrug   = random(20), Randomamount = random(20), Randomprice  = random(50), typeofimport[10], string[128];
	if (sscanf(params,"s", typeofimport )) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /change");
	else if(!IsAtBlackMarket(playerid)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You aren't at a Black Market.");
    else if(AccountInfo[playerid][Imported] >= 2) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You can't import more than twice a Pay Day.");
	else if(!strcmp(typeofimport,"drugs", true, 5))
	{
	    			if(Randomdrug <= 1)
					{
						AccountInfo[playerid][Crack] = AccountInfo[playerid][Crack] + Randomamount;
						format(string, sizeof(string), "[Blackmarket]: You have imported %d grams of Crack costing you $%d .", Randomamount,Randomprice);
						SendClientMessage(playerid, COLOUR_HEADER, string);
					}
					else if(Randomdrug == 2)
					{
						AccountInfo[playerid][Cocaine] = AccountInfo[playerid][Cocaine] + Randomamount;
						format(string, sizeof(string), "[Blackmarket]: You have imported %d grams of Cocaine costing you $%d dollars.", Randomamount,Randomprice);
						SendClientMessage(playerid, COLOUR_HEADER, string);
					}
					else if(Randomdrug == 3)
					{
						AccountInfo[playerid][Cocaine] = AccountInfo[playerid][Cocaine] + Randomamount;
						format(string, sizeof(string), "[Blackmarket]: You have imported %d grams of Cocaine costing you $%d dollars.", Randomamount,Randomprice);
						SendClientMessage(playerid, COLOUR_HEADER, string);
					}
					else if(Randomdrug == 4)
					{
						AccountInfo[playerid][Cocaine] = AccountInfo[playerid][Cocaine] + Randomamount;
						format(string, sizeof(string), "[Blackmarket]: You have imported %d grams of Cocaine costing you $%d dollars.", Randomamount,Randomprice);
						SendClientMessage(playerid, COLOUR_HEADER, string);
					}
					else if(Randomdrug == 5)
					{
						AccountInfo[playerid][Ecstasy] = AccountInfo[playerid][Ecstasy] + Randomamount;
						format(string, sizeof(string), "[Blackmarket]: You have imported %d grams of Ecstasy costing you $%d dollars.", Randomamount,Randomprice);
						SendClientMessage(playerid, COLOUR_HEADER, string);
 					}
					else if(Randomdrug == 6)
					{
						AccountInfo[playerid][Ecstasy] = AccountInfo[playerid][Ecstasy] + Randomamount;
						format(string, sizeof(string), "[Blackmarket]: You have imported %d grams of Ecstasy costing you $%d dollars.", Randomamount,Randomprice);
						SendClientMessage(playerid, COLOUR_HEADER, string);
					}
					else if(Randomdrug == 7)
					{
						AccountInfo[playerid][Ecstasy] = AccountInfo[playerid][Ecstasy] + Randomamount;
						format(string, sizeof(string), "[Blackmarket]: You have imported %d grams of Ecstasy costing you $%d dollars.", Randomamount,Randomprice);
						SendClientMessage(playerid, COLOUR_HEADER, string);
					}
					else if(Randomdrug == 8)
					{
						AccountInfo[playerid][Ecstasy] = AccountInfo[playerid][Ecstasy] + Randomamount;
						format(string, sizeof(string), "[Blackmarket]: You have imported %d grams of Ecstasy costing you $%d dollars.", Randomamount,Randomprice);
						SendClientMessage(playerid, COLOUR_HEADER, string);
					}
					else if(Randomdrug == 9)
					{
						AccountInfo[playerid][Ecstasy] = AccountInfo[playerid][Ecstasy] + Randomamount;
						format(string, sizeof(string), "[Blackmarket]: You have imported %d grams of Ecstasy costing you $%d dollars.", Randomamount,Randomprice);
						SendClientMessage(playerid, COLOUR_HEADER, string);
					}
					else if(Randomdrug == 10)
					{
						AccountInfo[playerid][Ecstasy] = AccountInfo[playerid][Ecstasy] + Randomamount;
						format(string, sizeof(string), "[Blackmarket]: You have imported %d grams of Ecstasy costing you $%d dollars.", Randomamount,Randomprice);
						SendClientMessage(playerid, COLOUR_HEADER, string);
					}
					else if(Randomdrug >= 11)
					{
						AccountInfo[playerid][Cannabis] = AccountInfo[playerid][Cannabis]+ Randomamount ;
						format(string, sizeof(string), "[Blackmarket]: You have imported %d grams of Cannabis costing you $%d dollars.", Randomamount,Randomprice);
						SendClientMessage(playerid, COLOUR_HEADER, string);
     				}
 					GivePlayerMoney(playerid,-Randomprice);
					AccountInfo[playerid][Imported]++;
					OnPlayerUpdateAccount(playerid);
					return 1;
	}
 	else if (!strcmp(typeofimport,"firearms", true, 8))
	{

					new Randomamount1 = random(20); // Generates the Amount
					new Randomprice1  = random(50); // Generates the Price
					AccountInfo[playerid][Firearms] = AccountInfo[playerid][Firearms] + Randomamount1;
					GivePlayerMoney(playerid,-Randomprice1);
					AccountInfo[playerid][Imported]++;
					OnPlayerUpdateAccount(playerid);
					format(string, sizeof(string), "[Blackmarket]: You have imported %d Firearms costing you $%d dollars.", Randomamount1,Randomprice1);
					SendClientMessage(playerid, COLOUR_HEADER, string);
					return 1;
 	}
 	return 1;
}
dcmd_bigimport(playerid, params[])
{
	#pragma unused params
	new team = AccountInfo[playerid][pTeam], rank = AccountInfo[playerid][GangRank];
	if (team < 2) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You aren't in a criminal organisation.");
	else if(rank < 4) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You aren't a High enough rank to request an import.");
	else if(IsAtJizzys(playerid) && AccountInfo[playerid][pTeam] == 5)
    {
            new imports = dini_Int("/Gangs/Northside.ini","Bigimported");
            if (imports >= 1){return 0;}
		    ShowPlayerDialog(playerid, 2, DIALOG_STYLE_LIST,"How do you want to do this?", "Boat drop at Los Santos Harbour.\nAir Drop at the Abandoned Airfield.\nTruck Drop at the Warehouse in Los Santos.", "Accept", "Cancel");
            return 1;
	}
	else if(IsAtWarehouse(playerid) && AccountInfo[playerid][pTeam] == 2)
    {
    		new imports = dini_Int("/Gangs/Forelli.ini","Bigimported");
            if (imports >= 1){return 0;}
			ShowPlayerDialog(playerid, 2, DIALOG_STYLE_LIST, "How you wanna do this amigo?","Boat drop at Los Santos Harbour.\nAir Drop at the Abandoned Airfield.\nTruck Drop at the Warehouse in Los Santos.", "Accept", "Cancel");
            return 1;
	}
   	else if(IsAtMistys(playerid) && AccountInfo[playerid][pTeam] == 3)
	{
            new imports = dini_Int("/Gangs/TheLost.ini","Bigimported");
            if (imports >= 1){return 0;}
			ShowPlayerDialog(playerid, 2, DIALOG_STYLE_LIST, "How ya' want to do this man?","Boat drop at Los Santos Harbour.\nAir Drop at the Abandoned Airfield.\nTruck Drop at the Warehouse in Los Santos.", "Accept", "Cancel");
            return 1;
	}
	else if(IsAtGecko(playerid) && AccountInfo[playerid][pTeam] == 4)
	{
            new imports = dini_Int("/Gangs/Gecko.ini","Bigimported");
            if (imports >= 1){return 0;}
			ShowPlayerDialog(playerid, 2, DIALOG_STYLE_LIST, "How ya' want to do this man?","Boat drop at Los Santos Harbour.\nAir Drop at the Abandoned Airfield.\nTruck Drop at the Warehouse in Los Santos.", "Accept", "Cancel");
            return 1;
	}
	else
	{
			SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You're not at your Gang's HQ");

    }
    return 1;
//<============================================================================>
//<===============================[Normal Commands]============================>
//<============================================================================>
//<===============================[/Commands  Menu]============================>
}
dcmd_commands(playerid, params[])
{
        #pragma unused params
	    SendClientMessage(playerid, COLOUR_HEADER, "<===============[Commands]==============>");
	    SendClientMessage(playerid, COLOUR_OTHER,  "[Chat]: [/all][/(W)hisper][/(S)hout] ");
	    SendClientMessage(playerid, COLOUR_OTHER,  "[Chat]: [/meg][/me]");
	    SendClientMessage(playerid, COLOUR_OTHER,  "[Car]: [/start] [/park] [/exit]");
        SendClientMessage(playerid, COLOUR_OTHER,  "[Help]: [/Tutorial][/Location] ");
		SendClientMessage(playerid, COLOUR_OTHER,  "[Other]: [/suicide] [/credits]  ");
		return 1;
}
dcmd_tutorial(playerid, params[])
{
        #pragma unused params
        SendClientMessage(playerid, COLOUR_HEADER, "<=======[Welcome to the tutorial!]=======>");
        SendClientMessage(playerid, COLOUR_OTHER, "Please select what you would like help with");
        SendClientMessage(playerid, COLOUR_OTHER, "If you would like to know basics commands (/commands)");
        SendClientMessage(playerid, COLOUR_OTHER, "If you would like some directions (/Locations)");
        SendClientMessage(playerid, COLOUR_OTHER, "If you would like some help getting a job (/Jobhelp)");
        return true;
}
dcmd_locations(playerid, params[])
{
        #pragma unused params
        SendClientMessage(playerid, COLOUR_HEADER, "<=======[Important Locations]=======>");
        SendClientMessage(playerid, COLOUR_OTHER, "For directions to the Job Center");
        SendClientMessage(playerid, COLOUR_OTHER, "Type (/directions Jobcenter)");
        SendClientMessage(playerid, COLOUR_OTHER, "For directions to the Townhall");
        SendClientMessage(playerid, COLOUR_OTHER, "Type (/directions Townhall)");
        SendClientMessage(playerid, COLOUR_OTHER, "For directions to the Bank");
        SendClientMessage(playerid, COLOUR_OTHER, "Type (/directions Bank)");
        SendClientMessage(playerid, COLOUR_OTHER, "To return to the previous menu");
        SendClientMessage(playerid, COLOUR_OTHER, "Type (/tutorial)");
        return true;
}
dcmd_jobhelp(playerid, params[])
{
        #pragma unused params
        SendClientMessage(playerid, COLOUR_HEADER, "<===============[Getting a Job]===============>");
        SendClientMessage(playerid, COLOUR_OTHER, "You can get a job by visiting a company");
        SendClientMessage(playerid, COLOUR_OTHER, "If there are Job Vacancies the company will have");
        SendClientMessage(playerid, COLOUR_OTHER, "an information icon outside its door");
        SendClientMessage(playerid, COLOUR_OTHER, "Type (/getjob) on the information icon");
        SendClientMessage(playerid, COLOUR_OTHER, "To apply for the job position");
        SendClientMessage(playerid, COLOUR_OTHER, "You can also get a job by visiting the Jobcenter");
        SendClientMessage(playerid, COLOUR_OTHER, "And viewing the current Job Vacancies in San Fierro");
        SendClientMessage(playerid, COLOUR_OTHER, "To return to the previous menu");
        SendClientMessage(playerid, COLOUR_OTHER, "Type (/tutorial)");
        return true;
}
dcmd_directions(playerid, params[])
{
		new location[128];
		if (sscanf(params, "s", location)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: /directions [JobCenter/Townhall/Bank].");
		else if (!strcmp(location, "Jobcenter", true, 9))
  		{
    		SetPlayerCheckpoint(playerid, -2649.1084,376.0042,6.1593,2.0);
    		SendClientMessage(playerid, COLOUR_OTHER, "A red marker has been set on your mini-map");
    		SendClientMessage(playerid, COLOUR_OTHER, "This will take you to the Job Center");
    		return true;
    	}
    	else if (!strcmp(location, "Townhall", true, 9))
    	{
   			SetPlayerCheckpoint(playerid, -2765.5288,375.6807,6.3359,2.0);
    		SendClientMessage(playerid, COLOUR_OTHER, "A red marker has been set on your mini-map");
    		SendClientMessage(playerid, COLOUR_OTHER, "This will take you to the Town Hall");
    		return true;
		}
		else if (!strcmp(location, "Bank", true, 9))
		{
   			SetPlayerCheckpoint(playerid, -2765.5288,375.6807,6.3359,2.0);
    		SendClientMessage(playerid, COLOUR_OTHER, "A red marker has been set on your mini-map");
    		SendClientMessage(playerid, COLOUR_OTHER, "This will take you to the Town Hall");
    		return true;
    	}
    	return 1;
}
dcmd_credits(playerid, params[])
{
        #pragma unused params
	    SendClientMessage(playerid,COLOUR_HEADER,"<==========[Credits]===========>");
	    SendClientMessage(playerid,COLOUR_OTHER, "|     The Scripting Team       |");
	    SendClientMessage(playerid,COLOUR_OTHER, "|            Fisher            |");
	    SendClientMessage(playerid,COLOUR_OTHER, "|  I Hope You Enjoy The Script |");
	    SendClientMessage(playerid,COLOUR_OTHER, "<==============================>");
	    return 1;
}
dcmd_jobsearch(playerid, params[])
{
		new job[128];
		if (sscanf(params, "s", job)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: /jobsearch [Taxi/Pizzaboy].");
		else if (!strcmp(job, "Taxi", true, 9))
  		{
    		SetPlayerCheckpoint(playerid, -1608.7029,1284.0530,7.1778,2.0);
    		SendClientMessage(playerid, COLOUR_OTHER, "It would appear Roadrunner taxis have vacancies");
    		SendClientMessage(playerid, COLOUR_OTHER, "We have now set a checkpoint on your minimap");
    		SendClientMessage(playerid, COLOUR_OTHER, "This will take you to Roadrunner Taxis");
    		SendClientMessage(playerid, COLOUR_OTHER, "Remember to type (/getjob) on the information icon");
    		return true;
    	}
    	else if (!strcmp(job, "Pizzaboy", true, 9))
    	{
    		SetPlayerCheckpoint(playerid, -1808.7107,945.9189,24.8906,2.0);
    		SendClientMessage(playerid, COLOUR_OTHER, "It would appear Pizza Place have vacancies");
    		SendClientMessage(playerid, COLOUR_OTHER, "We have now set a checkpoint on your minimap");
    		SendClientMessage(playerid, COLOUR_OTHER, "This will take you to Pizza Place");
    		SendClientMessage(playerid, COLOUR_OTHER, "Remember to type (/getjob) on the information icon");
    		return true;
   		}
   		return 1;
}
dcmd_suicide(playerid, params[])
{
        #pragma unused params
		SetPlayerHealth(playerid,0.0);
     	SetPlayerScore(playerid,-1);
		return 1;
}
dcmd_mybmx(playerid, params[])
{
        #pragma unused params
		new name[MAX_PLAYER_NAME];
    	GetPlayerName(playerid, name, sizeof(name));
        if(!strcmp(name, "Dog_Soto", true, 8))
     	{
    	    new Float:X, Float:Y, Float:Z;
     	    GetPlayerPos(playerid, X, Y, Z);
     	    new tempVeh = CreateVehicle(481, X, Y, Z, 90,0,0,0);
    		PutPlayerInVehicle(playerid, tempVeh, 0);
    		SendClientMessage(playerid, COLOUR_LIGHTBLUE, "[Fisher]: There you go mate.");
		}
  		else if(!strcmp(name, "Amos_Soto", true, 9))
     	{
    	    new Float:X, Float:Y, Float:Z;
     	    GetPlayerPos(playerid, X, Y, Z);
     	    new tempVeh = CreateVehicle(481, X, Y, Z, 90,0,0,0);
    		PutPlayerInVehicle(playerid, tempVeh, 0);
    		SendClientMessage(playerid, COLOUR_LIGHTBLUE, "[Fisher]: There you go mate.");
		}
     	else
		{
		    SendClientMessage(playerid, COLOUR_LIGHTBLUE, "[Fisher]: Your not Dog or Amos.");
		}
		return 1;
}
dcmd_inventory(playerid, params[])
{
        #pragma unused params
		new Weed = AccountInfo[playerid][Cannabis];
  		new Sniff = AccountInfo[playerid][Cocaine];
  		new Crack1 = AccountInfo[playerid][Crack];
  		new Pills = AccountInfo[playerid][Ecstasy];
  		new Firearms1 = AccountInfo[playerid][Firearms];
  		new string[128];
        SendClientMessage(playerid, COLOUR_LIGHTBLUE, "<========================================>");
		SendClientMessage(playerid, COLOUR_LIGHTBLUE, "[Inventory]: You are currently carrying...");
		format(string, sizeof(string), "[Inventory]: (Weed:%d) (Pills:%d) (Cocaine:%d)", Weed, Pills, Sniff);
		SendClientMessage(playerid, COLOUR_LIGHTBLUE, string);
		format(string, sizeof(string), "[Inventory]: (Crack:%d) (Firearms:%d)", Crack1, Firearms1);
		SendClientMessage(playerid, COLOUR_LIGHTBLUE, string);
		SendClientMessage(playerid, COLOUR_LIGHTBLUE, "<========================================>");
		return 1;
}
dcmd_stats(playerid, params[])
{
        #pragma unused params
		new Experience[4];
		new jExperience[4];
		new PlayerJob[100];
		new Playerteam[100];
		new team  = AccountInfo[playerid][pTeam];
		new level = AccountInfo[playerid][pLevel];
		new jlevel = AccountInfo[playerid][jLevel];
  		new Rank  = AccountInfo[playerid][GangRank];
  		new Job   = AccountInfo[playerid][pJob];
  		new string[128];
  		if (team == 0) Playerteam = "Civilian";
  		if (team == 1) Playerteam = "part of the San Fierro Police Force";
  		if (team == 2) Playerteam = "Forelli Familia";
  		if (team == 3) Playerteam = "The Lost";
  		if (team == 4) Playerteam = "Triads";
  		if (team == 5) Playerteam = "Northside Hustler";
  		if (level == 1) Experience = "/2";
  		if (level == 2) Experience = "/3";
  		if (level == 3) Experience = "/4";
  		if (level == 4) Experience = "/5";
  		if (level == 5) Experience = "/6";
  		if (jlevel == 1) jExperience = "/1";
  		if (jlevel == 2) jExperience = "/2";
  		if (jlevel == 3) jExperience = "/3";
  		if (jlevel == 4) jExperience = "/4";
  		if (jlevel == 5) jExperience = "/5";
  		if (jlevel == 6) jExperience = "/6";
  		if (jlevel == 7) jExperience = "/7";
  		if (jlevel == 8) jExperience = "/8";
  		if (jlevel == 9) jExperience = "/9";
  		if (jlevel == 10) jExperience = "N/A";
  		if (Job == 0) PlayerJob = "Unemployed";
  		if (Job == 1) PlayerJob = "Taxi Driver";
  		if (Job == 2) PlayerJob = "Pizza Boy";
  		if (Job == 3) PlayerJob = "Pilot";
  		if (Job == 4) PlayerJob = "Trucker";
  		if (Job == 5) PlayerJob = "Church Employee";
  		if (Job == 6) PlayerJob = "San Andreas News Reporter";
  		if (Job == 7) PlayerJob = "Firefighter";
  		if (Job == 8) PlayerJob = "Paramedic";
  		if (Job == 9) PlayerJob = "Roadside Recoverer";
        SendClientMessage(playerid, COLOUR_LIGHTBLUE, "<========================================>");
		format(string, sizeof(string), "[Level]: You are level %d [%d%s]\n[Organisation]: You are a rank %d %s\n[Player Job]: You are a %s\n[Job Level]: You are level %d [%d%s]\n[Bank Account]: Your Account currently holds $%d dollars", level,AccountInfo[playerid][pExp],Experience,Rank,Playerteam,PlayerJob,jlevel,AccountInfo[playerid][jExp],jExperience,AccountInfo[playerid][Bank]);
		ShowPlayerDialog(playerid,1,DIALOG_STYLE_MSGBOX,"Your Stats",string,"Close","");
		return 1;
}
dcmd_help(playerid,params[])
{
	#pragma unused params
    ShowPlayerDialog(playerid, 16, DIALOG_STYLE_LIST,"Help Categories", "Bank Commands.\nCar Commands.\nChat Commands.\nGang Commands.\nGeneral Commands.\nHouse Commands.", "Accept", "Cancel");
	return 1;
}
dcmd_gangs(playerid,params[])
{
	#pragma unused params
    SendClientMessage(playerid,COLOUR_HEADER,"[Info]: Gang/PD Information");
   	SendClientMessage(playerid,COLOUR_HEADER,"[Info]: Team 1 = Police");
    SendClientMessage(playerid,COLOUR_HEADER,"[Info]: Team 2 = Forelli");
    SendClientMessage(playerid,COLOUR_HEADER,"[Info]: Team 3 = Bikers");
    SendClientMessage(playerid,COLOUR_HEADER,"[Info]: Team 5 = Northside Hustlers");
}
dcmd_jobs(playerid,params[])
{
	#pragma unused params
    SendClientMessage(playerid,COLOUR_HEADER,"[Info]: Job Information");
   	SendClientMessage(playerid,COLOUR_HEADER,"[Info]: Job 1 = Roadrunner Taxis");
    SendClientMessage(playerid,COLOUR_HEADER,"[Info]: Job 2 = Pizza Place Delivery");
    SendClientMessage(playerid,COLOUR_HEADER,"[Info]: Job 3 = Juank Airways");
    SendClientMessage(playerid,COLOUR_HEADER,"[Info]: Job 4 = Longs Haulage");
    SendClientMessage(playerid,COLOUR_HEADER,"[Info]: Job 5 = Church of San Fierro");
    SendClientMessage(playerid,COLOUR_HEADER,"[Info]: Job 6 = San Andreas News");
    SendClientMessage(playerid,COLOUR_HEADER,"[Info]: Job 7 = Firefighter");
    SendClientMessage(playerid,COLOUR_HEADER,"[Info]: Job 8 = Paramedics");
}
dcmd_admins(playerid, params[])
{
 	#pragma unused params
	new string[128], sendername[MAX_PLAYER_NAME];
	if(IsPlayerConnected(playerid))
	{
		SendClientMessage(playerid, COLOUR_HEADER, "<=======[Online Admins]=========>");
		for (new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i))
			{
				if(AccountInfo[i][AdminLevel] > 0)
				{
   					GetPlayerName(i , sendername, sizeof(sendername));
					format(string, sizeof(string),"Administrator: %s", sendername);
					SendClientMessage(playerid,COLOUR_HEADER, string);
				}
			}
		}
	}
	return 1;
}
dcmd_booktest(playerid, params[])
{
        #pragma unused params
        if(AccountInfo[playerid][DLicense] == 1)
        {
			SendClientMessage(playerid,COLOUR_ADMINRED,"[DSA]: You already have a license.");
		}
        else if(GetPlayerMoney(playerid) < 500)
		{
			SendClientMessage(playerid,COLOUR_ADMINRED,"[DSA]: You don't have enough money to pay for the test.");
		}
		else if(IsPlayerInRangeOfPoint(playerid, 7.0, -2024.7075,-101.1420,35.1641))
		{
			GivePlayerMoney(playerid, -500);
			SendClientMessage(playerid,COLOUR_ADMINRED,"[DSA]: Okay well lets get started. Follow the Checkpoints as simple as that.");
	        PutPlayerInVehicle(playerid, dsa1, 0);
			TogglePlayerDynamicCP(playerid,  Test1, true);
   			TextDrawShowForPlayer(playerid,Text:TestDirections);
		}
		else
		{
			SendClientMessage(playerid, COLOUR_HEADER,"[Error]: You are not at the driving school.");
		}
		return 1;
}
dcmd_setspawn(playerid, params[])
{
        #pragma unused params
		new Float:x, Float:y, Float:z, Interior;
	  	GetPlayerPos(playerid, x, y, z);
	  	Interior = GetPlayerInterior(playerid);
	  	AccountInfo[playerid][SpawnX] = x;
	  	AccountInfo[playerid][SpawnY] = y;
		AccountInfo[playerid][SpawnZ] = z;
	  	AccountInfo[playerid][SpawnInt] = Interior;
		SendClientMessage(playerid, COLOUR_LIGHTBLUE,"[Server]: You will now spawn at this position from now on.");
		AccountInfo[playerid][CustomSpawn] = 1;
	  	return 1;
}
dcmd_breakdown(playerid,params[])
{
	new string[128],from[128],name[MAX_PLAYER_NAME];
	if (sscanf(params,"s", from)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /breakdown [location]");
	else
	{
		GetPlayerName(playerid, name, sizeof(name));
        format(string,sizeof(string),"[Dispatch]: %s has broken down at %s can someone attend.",name,from);
		SendClientMessageToTow(COLOUR_ORANGE,string);
		SendClientMessage(playerid, COLOUR_ORANGE, "[Pro-Tow]: There will be an engineer with you shortly.");
	}
	return 1;
}
dcmd_tie(playerid, params[])
{
	new targetid;
	if (sscanf(params, "u", targetid)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /tie [playerid]");
	else if(targetid == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: Player not connected");
	else if(GetDistanceBetweenPlayers(playerid,targetid) > 3) SendClientMessage(playerid, COLOUR_ADMINRED,"[Error]: Player is too far away");
	else
	{
        new name[MAX_PLAYER_NAME], targetsname[MAX_PLAYER_NAME], string[128];
    	GetPlayerName(playerid, name, sizeof(name));
		format(string, sizeof(string), "%s ties your arms and legs with some rope.", name);
		SendClientMessage(targetid, COLOUR_HEADER, string);
		TogglePlayerControllable(targetid, 0);
		format(string, sizeof(string), "You have tied up %s.", targetsname);
		SendClientMessage(playerid, COLOUR_HEADER, string);
	}
	return 1;
}
dcmd_untie(playerid, params[])
{
	new targetid;
	if (sscanf(params, "u", targetid)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /untie [playerid]");
	else if(targetid == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: Player not connected");
	else if(GetDistanceBetweenPlayers(playerid,targetid) > 3) SendClientMessage(playerid, COLOUR_ADMINRED,"[Error]: Player is too far away");
	else
	{
        new name[MAX_PLAYER_NAME], targetsname[MAX_PLAYER_NAME], string[128];
    	GetPlayerName(playerid, name, sizeof(name));
		format(string, sizeof(string), "%s unties the rope around your arms and legs.", name);
		SendClientMessage(targetid, COLOUR_HEADER, string);
		TogglePlayerControllable(targetid, 1);
		format(string, sizeof(string), "You have untied %s.", targetsname);
		SendClientMessage(playerid, COLOUR_HEADER, string);
	}
	return 1;
}
dcmd_kidnap(playerid, params[])
{
	new targetid, kidnap[128];
	if (sscanf(params, "u", targetid)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /kidnap [playerid]");
	else if(targetid == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: Player not connected");
	else if(GetDistanceBetweenPlayers(playerid,targetid) > 5) SendClientMessage(playerid, COLOUR_ADMINRED,"[Error]: Player is too far away");
	else if(!IsPlayerInAnyVehicle(playerid)) SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You are not in a car");
	else if(IsPlayerInAnyVehicle(targetid)) SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: That player is already in a car.");
	else
	{
        new victim[MAX_PLAYER_NAME],kidnappersvehicle, seat;
    	GetPlayerName(targetid, victim, sizeof(victim));
		format(kidnap, sizeof(kidnap), "There are muffled shouts as %s has a bag placed over there head and they are bundled into the back of a vehicle.", victim);
		ProxDetector(20.0, playerid,kidnap,COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER);
		TogglePlayerControllable(targetid, 0);
		kidnappersvehicle = GetPlayerVehicleID(playerid);
		if (IsSeatTaken(kidnappersvehicle, 1)) seat = 1;
		if (IsSeatTaken(kidnappersvehicle, 2)) seat = 2;
		if (IsSeatTaken(kidnappersvehicle, 3)) seat = 3;
        PutPlayerInVehicle(targetid, kidnappersvehicle, seat);
	}
	return 1;
}
dcmd_911(playerid, params[])
{
        new location[128],problem[128], sendername[MAX_PLAYER_NAME], Hours, Minutes, Seconds, string[128];
		if (sscanf(params, "s", problem, location)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: /pr [text].");
		else
		{
				GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string, sizeof(string), "[Police Radio]: A 911 call has been recieved from %s could an Officer please respond." ,sendername, location);
	  			SendClientMessageToPolice(COLOUR_LIGHTBLUE, string);
				format(string, sizeof(string), "[Details]: %s." ,problem);
	  			SendClientMessageToPolice(COLOUR_LIGHTBLUE, string);
				format(string, sizeof(string), "[Location]: %s." ,location);
	  			SendClientMessageToPolice(COLOUR_LIGHTBLUE, string);
	  			SendClientMessage(playerid,COLOUR_LIGHTBLUE, "[Operator]: An Officer will be with you shortly, just stay calm.");
	  			gettime(Hours,Minutes,Seconds);
				new send[256],File:hFile=fopen("/Server Logs/Chat.ini", io_append);
				format(send, sizeof(send), "[%d:%d][Police]%s (%d): '%s'\r\n", Hours, Minutes,sendername, playerid, string);
				fwrite(hFile,send);
				fclose(hFile);
				return 1;
		}
		return 1;
}
dcmd_pay(playerid, params[])
{
		new cash, string[128], targetid;
		if (sscanf(params, "ud",targetid,cash)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: /pay [playerid] [amount].");
        else if (cash > GetPlayerMoney(playerid) || cash < 1) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You dont have that much.");
		else
		{
	 		new name[MAX_PLAYER_NAME],targetname[MAX_PLAYER_NAME];
			GivePlayerMoney(playerid,-cash);
			GivePlayerMoney(targetid,cash);
	   		GetPlayerName(playerid, name, sizeof(name));
	   		GetPlayerName(targetid, targetname, sizeof(targetname));
	    	format(string, sizeof(string), "[Server]: %s has paid you $%d dollars.", name, cash );
	    	SendClientMessage(targetid,COLOUR_LIGHTBLUE, string);
	    	format(string, sizeof(string), "[Server]: You have paid %s $%d dollars.", targetname, cash );
	    	SendClientMessage(playerid,COLOUR_LIGHTBLUE, string);
		}
		return 1;
}
dcmd_sell(playerid, params[])
{
		new item[128],Cost, message[128],title[128],offer[128], targetid, amount, name[MAX_PLAYER_NAME],targetname[MAX_PLAYER_NAME];
  		if (sscanf(params, "usdd",targetid, item, amount, Cost)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: /sell [playerid] [item] [amount] [cost].");
		else if (IsNumeric(item))
		{
		    SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You can't send them nothing.");
		    return 0;
  		}
		else if (amount == 0)
		{
			SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You can't send them nothing.");
			return 0;
		}
		else if(!strcmp(item," ", true, 1))
		{
			SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You can't send them nothing.");
			return 0;
		}
		else if(!strcmp(item,"Cannabis", true, 8))
		{
   			GetPlayerName(playerid, name, sizeof(name));
			GetPlayerName(targetid, targetname, sizeof(targetname));
			format(message, sizeof(message), "[Server]: %s has offered you %d grams of %s for $%d dollars.", name,amount,item,Cost);
			SendClientMessage(targetid,COLOUR_LIGHTBLUE, message);
    		format(message, sizeof(message), "[Server]: You have offered %s %d grams of %s for $%d dollars.", targetname,amount,item,Cost);
    		SendClientMessage(playerid,COLOUR_LIGHTBLUE, message);
            AccountInfo[targetid][OffererID] = playerid;
			AccountInfo[targetid][OfferedItem] = 1;
    		AccountInfo[targetid][OfferedAmount] = amount;
    		AccountInfo[targetid][OfferedPrice] = Cost;
		}
		else if(!strcmp(item,"Cocaine", true, 7))
		{
			GetPlayerName(playerid, name, sizeof(name));
   			GetPlayerName(targetid, targetname, sizeof(targetname));
    		format(message, sizeof(message), "[Server]: %s has offered you %d grams of %s for $%d dollars.", name,amount,item,Cost);
    		SendClientMessage(targetid,COLOUR_LIGHTBLUE, message);
    		format(message, sizeof(message), "[Server]: You have offered %s %d grams of %s for $%d dollars.", targetname,amount,item,Cost);
    		SendClientMessage(playerid,COLOUR_LIGHTBLUE, message);
            AccountInfo[targetid][OffererID] = playerid;
			AccountInfo[targetid][OfferedItem] = 2;
    		AccountInfo[targetid][OfferedAmount] = amount;
    		AccountInfo[targetid][OfferedPrice] = Cost;
   		}
		else if(!strcmp(item, "Crack"   , true, 5))
		{
   			GetPlayerName(playerid, name, sizeof(name));
   			GetPlayerName(targetid, targetname, sizeof(targetname));
    		format(message, sizeof(message), "[Server]: %s has offered you %d grams of %s for $%d dollars.", name,amount,item,Cost);
    		SendClientMessage(targetid,COLOUR_LIGHTBLUE, message);
    		format(message, sizeof(message), "[Server]: You have offered %s %d grams of %s for $%d dollars.", targetname,amount,item,Cost);
    		SendClientMessage(playerid,COLOUR_LIGHTBLUE, message);
    		AccountInfo[targetid][OfferedItem] = 3;
    		AccountInfo[targetid][OfferedAmount] = amount;
    		AccountInfo[targetid][OfferedPrice] = Cost;
		}
		else if(!strcmp(item, "Ecstasy" , true, 7))
		{
   			GetPlayerName(playerid, name, sizeof(name));
   			GetPlayerName(targetid, targetname, sizeof(targetname));
    		format(message, sizeof(message), "[Server]: %s has offered you %d %s pills for $%d dollars.", name,amount,item,Cost);
    		SendClientMessage(targetid,COLOUR_LIGHTBLUE, message);
    		format(message, sizeof(message), "[Server]: You have offered %s %d %s pills for $%d dollars.", targetname,amount,item,Cost);
    		SendClientMessage(playerid,COLOUR_LIGHTBLUE, message);
            AccountInfo[targetid][OffererID] = playerid;
			AccountInfo[targetid][OfferedItem] = 4;
    		AccountInfo[targetid][OfferedAmount] = amount;
    		AccountInfo[targetid][OfferedPrice] = Cost;
		}
		else if(!strcmp(item, "Firearms", true, 8))
		{
   			GetPlayerName(playerid, name, sizeof(name));
   			GetPlayerName(targetid, targetname, sizeof(targetname));
    		format(message, sizeof(message), "[Server]: %s has offered you %d pieces of %s for $%d dollars.", name,amount,item,Cost);
    		SendClientMessage(targetid,COLOUR_LIGHTBLUE, message);
    		format(message, sizeof(message), "[Server]: You have offered %s %d pieces of %s for $%d dollars.", targetname,amount,item,Cost);
    		SendClientMessage(playerid,COLOUR_LIGHTBLUE, message);
            AccountInfo[targetid][OffererID] = playerid;
    		AccountInfo[targetid][OfferedItem] = 5;
    		AccountInfo[targetid][OfferedAmount] = amount;
    		AccountInfo[targetid][OfferedPrice] = Cost;
		}
		format(title, sizeof(title), "Offer from %s", name);
        format(offer, sizeof(offer), "%s has offered you %d units of %s for $%d dollars",name,amount,item,Cost);
		ShowPlayerDialog(targetid,7,DIALOG_STYLE_MSGBOX , title,offer,"Accept","Decline");
		return 1;
}
dcmd_use(playerid, params[])
{
		new item[128],message[128], amount;
  		if (sscanf(params, "sd", item, amount)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: /use [Weed/Coke/Crack/E] [amount].");
		else if (amount < 1) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You can't take nothing.");
		else if(!strcmp(item,"Weed", true, 4))
		{
			if (AccountInfo[playerid][Cannabis] >= amount)
			{
				format(message, sizeof(message), "[Server]: You smoke %d joints.", amount);
				AccountInfo[playerid][Cannabis] = AccountInfo[playerid][Cannabis] - amount;
	    		SendClientMessage(playerid,COLOUR_HEADER, message);
	    		SetTimerEx("Drugeffect",60000,false,"i",playerid);
	    		return 1;
			}
			else
			{
			    SendClientMessage(playerid,COLOUR_HEADER, "[Error]: You don't have that much.");
			    return 1;
			}
		}
		else if(!strcmp(item,"Coke", true, 4))
		{
			if (AccountInfo[playerid][Cocaine] >= amount)
			{
				SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You don't have that much Coke.");
				format(message, sizeof(message), "[Server]: You sniff %d lines of Coke.", amount);
				AccountInfo[playerid][Cocaine] = AccountInfo[playerid][Cocaine] - amount;
	    		SendClientMessage(playerid,COLOUR_HEADER, message);
	    		SetTimerEx("Drugeffect",60000,false,"i",playerid);
	    		return 1;
			}
		}
		else if(!strcmp(item, "Crack"   , true, 5))
		{
			if (AccountInfo[playerid][Crack] > amount)
			{
				SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You don't have that much Crack.");
				format(message, sizeof(message), "[Server]: You smoke %d rocks.", amount);
				AccountInfo[playerid][Crack] = AccountInfo[playerid][Crack] - amount;
	    		SendClientMessage(playerid,COLOUR_HEADER, message);
	    		SetTimerEx("Drugeffect",60000,false,"i",playerid);
	    		return 1;
			}
			else
			{
			    SendClientMessage(playerid,COLOUR_HEADER, "[Error]: You don't have that much.");
			    return 1;
			}
		}
		else if(!strcmp(item, "E" , true, 1))
		{
			if (AccountInfo[playerid][Ecstasy] > amount)
			{
				SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You don't have that much E.");
				format(message, sizeof(message), "[Server]: You drop %d pills ", amount);
				AccountInfo[playerid][Ecstasy] = AccountInfo[playerid][Ecstasy] - amount;
	    		SendClientMessage(playerid,COLOUR_HEADER, message);
	    		SetTimerEx("Drugeffect",60000,false,"i",playerid);
	    		return 1;
			}
			else
			{
			    SendClientMessage(playerid,COLOUR_HEADER, "[Error]: You don't have that much.");
			    return 1;
			}
		}
		return 1;
}
dcmd_order(playerid, params[])
{
    #pragma unused params
	if(IsAtJizzys(playerid) == 1)
	{
 		ShowPlayerDialog(playerid, 6, DIALOG_STYLE_LIST, "Hi Handsome, Welcome to Jizzys can I help you?", "Budweiser : $2 dollars\n Captain Morgan's : $10 dollars\nJack Daniels : $25 dollars\nHennesey : $80 dollars\nCristal : $150 dollars\nVintage Cristal : $1000 dollars\nCuban Cigar : $120 dollars", "Buy", "Cancel");
	}
	else
	{
	    SendClientMessage(playerid, COLOUR_ADMINRED,"[Error]: You're not at a bar.");
	}
	return 1;
}
dcmd_report(playerid, params[])
{
		new reason, giveplayerid, giveplayername[MAX_PLAYER_NAME], sendername[MAX_PLAYER_NAME], string[128];
		if (sscanf(params, "is", giveplayerid, reason)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: /report [playername/id] [reason].");
		else if (!IsPlayerConnected(giveplayerid)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: Player ID not connected.");
		else
  		{
		   		GetPlayerName(giveplayerid, giveplayername, sizeof(giveplayername));
				GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string, sizeof(string), "[Server]: %s reported %s [Reason: %s ]", sendername,giveplayername);
				SendClientMessageToAdmins(COLOUR_ADMINRED, string,1);
				format(string, sizeof(string), "[Reason]: %s",reason);
				SendClientMessageToAdmins(COLOUR_ADMINRED, string,1);
				format(string, sizeof(string), "[Server]: Thank you for your report regarding %s. It has been sent to the current online admins.", giveplayername);
				SendClientMessage(playerid, COLOUR_LIGHTBLUE, string);
		}
		return 1;
}
dcmd_enterzip(playerid, params[])
{
    #pragma unused params
   	if(IsAtZip(playerid) == 1)
   	{
	    countvalue[playerid] = 0;
	    format(TextDrawString[playerid], 128, "~y~Press ~r~~k~~PED_SPRINT~ ~y~to buy this skin~n~Price: ~r~$%d~n~~n~~y~(%d/%d)", SkinPrices[countvalue[playerid]], countvalue[playerid]+1, TotalSkins);
		TextDraw[playerid] = TextDrawCreate(320, 390, TextDrawString[playerid]);
		TextDrawLetterSize(TextDraw[playerid],0.40,1.10);
		TextDrawAlignment(TextDraw[playerid], 2);
		TextDrawSetShadow(TextDraw[playerid], 0);
		TextDrawSetOutline(TextDraw[playerid], 1);
		TextDrawUseBox(TextDraw[playerid], 1);
		TextDrawBoxColor(TextDraw[playerid], 0x000000AA);
		TextDrawTextSize(TextDraw[playerid], 250, 220);
		TextDrawShowForPlayer(playerid, TextDraw[playerid]);
		TextdrawActive[playerid] = 1;
		//GameTextForPlayer(playerid, str, 99999999, 3);
		HasBoughtNewSkin[playerid] = 0;
	    LastSkin[playerid] = GetPlayerSkin(playerid);
	    SetPlayerVirtualWorld(playerid, playerid+1);
	    SetPlayerInterior(playerid, 18);
	    SetPlayerPos(playerid, 181.7410,-87.4888,1002.0234);
		SetPlayerFacingAngle(playerid, 128.0);
		SetPlayerCameraPos(playerid, 178.2804,-89.5319,1003.0234);
		SetPlayerCameraLookAt(playerid, 181.7410,-87.4888,1002.0234);
		TogglePlayerControllable(playerid, 0);
		IsInShop[playerid] = 1;
		SetPlayerSkin(playerid, AvailableSkins[0]);
		KeyTimer[playerid] = SetTimerEx("CheckKeyPress", 75, 1, "i", playerid);
		wait[playerid] = 0;
		SendClientMessage(playerid, COLOUR_HEADER, "[Clerk]: Hello and welcome to Zip, how may I help you. Use the arrowkeys to scroll through available skins");
		SendClientMessage(playerid, COLOUR_HEADER, "[Server]: Use /exitzip to exit without buying a new skin.");
		return 1;
	}
	else
	{
	    SendClientMessage(playerid, COLOUR_ADMINRED, "[Server]: You aren't at Zip!");
	    return 1;
	}
}
dcmd_exitzip(playerid, params[])
{
    #pragma unused params
    if(IsInShop[playerid] == 1)
    {
        GameTextForPlayer(playerid, " ", 10, 6);
	    TextDrawHideForPlayer(playerid, TextDraw[playerid]);
	    TextdrawActive[playerid] = 0;
	    TextDrawDestroy(TextDraw[playerid]);
		if(HasBoughtNewSkin[playerid] == 0)
		{
	    	SetPlayerSkin(playerid, LastSkin[playerid]);
		}
		if(HasBoughtNewSkin[playerid] == 1)
		{
	    	AccountInfo[playerid][Playerskin] = GetPlayerSkin(playerid);
	    	AccountInfo[playerid][Boughtskin] = 1;
		}
		TogglePlayerControllable(playerid, 1);
		SetCameraBehindPlayer(playerid);
		IsInShop[playerid] = 0;
		countvalue[playerid] = 0;
		wait[playerid] = 0;
		SetPlayerPos(playerid,-1886.2080,863.2061,35.1728);
		SetPlayerFacingAngle(playerid, 132.4349);
		SetPlayerInterior(playerid,0);
		SetPlayerVirtualWorld(playerid,0);
	}
	else
	{
	    SendClientMessage(playerid, COLOUR_ADMINRED, "[Server]: You aren't at Zip!");
	}
	return 1;
}
dcmd_pm(playerid, params[])
{
        new targetid, message[128], playername[MAX_PLAYER_NAME], reciever[MAX_PLAYER_NAME], string[128];
        if (sscanf(params, "is", targetid, message)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /pm [id] [message]");
		else if (!AccountInfo[playerid][Logged]) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You're not logged in.");
		else if (!IsPlayerConnected(targetid)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: Player ID not connected.");
		else
		{
            GetPlayerName(playerid, playername, sizeof(reciever));
			GetPlayerName(targetid, reciever, sizeof(reciever));
			format(string, sizeof(string), "[%s]: %s", playername,message);
			SendClientMessage(targetid, COLOUR_YELLOW, string);
			format(string, sizeof(string), "[%s]: %s", reciever,message);
			SendClientMessage(playerid, COLOUR_YELLOW, string);
		}
       	return 1;
}
//<============================================================================>
//<===============================[Chat Commands]==============================>
//<============================================================================>
dcmd_all(playerid, params[])
{
		new gtext[128], playersname[MAX_PLAYER_NAME], Hours, Minutes, Seconds;
		if (sscanf(params, "s", gtext)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: /all [Text Here].");
		else if (AccountInfo[playerid][Logged] == 0) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You are not Logged in. Please login first.");
		else
		{
						GetPlayerName(playerid, playersname, sizeof(playersname));
        				format(gtext, sizeof(gtext), "%s", gtext);
						SendPlayerMessageToAll(playerid, gtext);
						gettime(Hours,Minutes,Seconds);
						new send[256],File:hFile=fopen("/Server Logs/Global Chat.ini", io_append);
						format(send, sizeof(send), "[%d:%d][Global]%s (%d): '%s'\r\n", Hours, Minutes,playersname, playerid, gtext);
						fwrite(hFile,send);
						fclose(hFile);
                        return 1;
		}
		return 1;
}
dcmd_meg(playerid, params[])
{
		new megtext[128], playersname1[MAX_PLAYER_NAME], Hours, Minutes, Seconds;
		if (sscanf(params, "s", megtext)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: /meg [action/verb].");
		else if (AccountInfo[playerid][Logged] == 0) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You are not Logged in. Please login first.");
		else
		{
        				GetPlayerName(playerid, playersname1, sizeof(playersname1));
        				format(megtext, sizeof(megtext), "%s %s", playersname1, megtext);
						SendClientMessageToAll(COLOUR_GLOBAL, megtext);
						gettime(Hours,Minutes,Seconds);
						new send[256],File:hFile=fopen("/Server Logs/Global Chat.ini", io_append);
						format(send, sizeof(send), "[%d:%d][Global]%s (%d): '%s'\r\n", Hours, Minutes,playersname1, playerid, megtext);
						fwrite(hFile,send);
						fclose(hFile);
                        return 1;
		}
		return 1;
}
dcmd_me(playerid, params[])
{
		new metext[128], sendername[MAX_PLAYER_NAME], Hours, Minutes, Seconds;
		if (sscanf(params, "s", metext)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: /me [action/verb].");
		else if (AccountInfo[playerid][Logged] == 0) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You are not Logged in. Please login first.");
		else
		{
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(metext, sizeof(metext), "%s %s", sendername, metext);
			ProxDetector(30.0, playerid, metext,COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER);
			printf("%s", metext);
			gettime(Hours,Minutes,Seconds);
			new send[256],File:hFile=fopen("/Server Logs/Local Chat.ini", io_append);
			format(send, sizeof(send), "[%d:%d][Me]%s (%d): '%s'\r\n", Hours, Minutes,sendername, playerid, metext);
			fwrite(hFile,send);
			fclose(hFile);
		}
		return 1;
}
dcmd_s(playerid, params[])
{
		new stext[128], sendername[MAX_PLAYER_NAME], Hours, Minutes, Seconds;
		if (sscanf(params, "s", stext)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: /s [text].");
        else if (AccountInfo[playerid][Logged] == 0) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You are not Logged in. Please login first.");
		else
		{
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(stext, sizeof(stext), "[Local]: %s shouts %s!", sendername, stext);
			ProxDetector(50.0, playerid, stext,COLOUR_LOCAL,COLOUR_LOCAL,COLOUR_LOCAL,COLOUR_LOCAL,COLOUR_LOCAL);
			printf("%s", stext);
			gettime(Hours,Minutes,Seconds);
			new send[256],File:hFile=fopen("/Server Logs/Local Chat.ini", io_append);
			format(send, sizeof(send), "[%d:%d][Shout]%s (%d): '%s'\r\n", Hours, Minutes,sendername, playerid, stext);
			fwrite(hFile,send);
			fclose(hFile);
		}
		return 1;
}
dcmd_po(playerid, params[])
{
        #pragma unused params
        new stext[100];
        if (AccountInfo[playerid][Logged] == 0) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You are not Logged in. Please login first.");
		else if (AccountInfo[playerid][pTeam] != 1) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You are not a Police Officer.");
		else
		{
			format(stext, sizeof(stext), "[Police]: Pull your vehicle to the side of the road!", stext);
			ProxDetector(50.0, playerid, stext,COLOUR_LIGHTBLUE,COLOUR_LIGHTBLUE,COLOUR_LIGHTBLUE,COLOUR_LIGHTBLUE,COLOUR_LIGHTBLUE);
		}
		return 1;
}
dcmd_mp(playerid, params[])
{
        new mptext[100],sendername[MAX_PLAYER_NAME];
		if (sscanf(params, "s", mptext)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: /mp [text].");
		else if (AccountInfo[playerid][pTeam] != 1) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You are not a Police Officer.");
		else
		{
            GetPlayerName(playerid, sendername, sizeof(sendername));
			format(mptext, sizeof(mptext), "[Officer %s]: %s!", sendername, mptext);
			ProxDetector(50.0, playerid, mptext,COLOUR_LIGHTBLUE,COLOUR_LIGHTBLUE,COLOUR_LIGHTBLUE,COLOUR_LIGHTBLUE,COLOUR_LIGHTBLUE);
		}
		return 1;
}
dcmd_w(playerid, params[])
{
		new wtext[128], sendername[MAX_PLAYER_NAME], Hours, Minutes, Seconds;
		if (sscanf(params, "s", wtext)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: /w [text].");
        else if (AccountInfo[playerid][Logged] == 0) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You are not Logged in. Please login first.");
		else
		{
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(wtext, sizeof(wtext), "[Local]: %s whispers %s", sendername, wtext);
			ProxDetector(5.0, playerid, wtext,COLOUR_LOCAL,COLOUR_LOCAL,COLOUR_LOCAL,COLOUR_LOCAL,COLOUR_LOCAL);
			printf("%s", wtext);
			gettime(Hours,Minutes,Seconds);
			new send[256],File:hFile=fopen("/Server Logs/Local Chat.ini", io_append);
			format(send, sizeof(send), "[%d:%d][Whisper]%s (%d): '%s'\r\n", Hours, Minutes,sendername, playerid, wtext);
			fwrite(hFile,send);
			fclose(hFile);
		}
		return 1;
}
dcmd_achat(playerid, params[])
{
		new atext[128], sendername[MAX_PLAYER_NAME], adminlevel = AccountInfo[playerid][AdminLevel], Hours, Minutes, Seconds;
		if (sscanf(params, "s", atext)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: /achat [text].");
        else if (adminlevel <= 1) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You are not an Administrator.");
		else
		{
			GetPlayerName(playerid, sendername, sizeof(sendername));
		    format(atext, sizeof(atext), "[Admin][%d]%s: %s" ,adminlevel,sendername, atext);
	  		SendClientMessageToAdmins(COLOUR_DARKPINK, atext, 1);
	  		gettime(Hours,Minutes,Seconds);
			new send[256],File:hFile=fopen("/Server Logs/AdminChat.ini", io_append);
			format(send, sizeof(send), "[%d:%d][Admin]%s (%d): '%s'\r\n", Hours, Minutes,sendername, playerid, atext);
			fwrite(hFile,send);
			fclose(hFile);
			return 1;
		}
		return 1;
}
dcmd_pr(playerid, params[])
{
        new prtext[128], sendername[MAX_PLAYER_NAME], Hours, Minutes, Seconds;
		if (sscanf(params, "s", prtext)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: /pr [text].");
        else if (AccountInfo[playerid][pTeam] != 1) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You are not a Police Officer.");
        else
        {
				GetPlayerName(playerid, sendername, sizeof(sendername));
				format(prtext, sizeof(prtext), "[Police Radio][%i]%s:%s" ,playerid, sendername, prtext);
	  			SendClientMessageToPolice(COLOUR_LIGHTBLUE, prtext);
	  			gettime(Hours,Minutes,Seconds);
				new send[256],File:hFile=fopen("/Server Logs/Police Chat.ini", io_append);
				format(send, sizeof(send), "[%d:%d][Police]%s (%d): '%s'\r\n", Hours, Minutes,sendername, playerid, prtext);
				fwrite(hFile,send);
				fclose(hFile);
				return 1;
		}
		return 1;
}
//<============================================================================>
//<=================================[Car Commands]=============================>
//<============================================================================>
dcmd_eject(playerid, params[])
{
		new name[MAX_PLAYER_NAME], targetid, vehicle,string[128];
		new playerstate = GetPlayerState(playerid);
		vehicle = GetPlayerVehicleID(playerid);
		if (sscanf(params, "d", targetid)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: /eject [playerid].");
    	else if(!IsPlayerInVehicle(targetid,vehicle)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: That player isn't in your vehicle.");
		else if((playerstate == PLAYER_STATE_PASSENGER)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: Passengers can't use this command.");
		else
		{
            GetPlayerName(targetid, name, sizeof(name));
			format(string, sizeof(string), "%s was ejected from the car by the driver.", name );
			ProxDetector(5.0, playerid, string,COLOUR_LOCAL,COLOUR_LOCAL,COLOUR_LOCAL,COLOUR_LOCAL,COLOUR_LOCAL);
            RemovePlayerFromVehicle(targetid);
		}
    	return true;
}
dcmd_start(playerid, params[])
{
        #pragma unused params
		new name[MAX_PLAYER_NAME], start_str[128];
    	GetPlayerName(playerid, name, sizeof(name));
    	format(start_str, sizeof(start_str), "%s turns the ignition, and the engine roars into life.", name );
        ProxDetector(20.0, playerid, start_str,COLOUR_LOCAL,COLOUR_LOCAL,COLOUR_LOCAL,COLOUR_LOCAL,COLOUR_LOCAL);
		TogglePlayerControllable(playerid,1);
    	return true;
}
dcmd_getvehicleids(playerid, params[])
{
        #pragma unused params
		new start_str[128];
        ProxDetector(20.0, playerid, start_str,COLOUR_LOCAL,COLOUR_LOCAL,COLOUR_LOCAL,COLOUR_LOCAL,COLOUR_LOCAL);
		format(start_str, sizeof(start_str), "The vehicle id is %s.", GetPlayerVehicleID(playerid));
    	SendClientMessageToAll(COLOUR_LOCAL, start_str);
		TogglePlayerControllable(playerid,1);
    	return true;
}
dcmd_getvehicleidd(playerid, params[])
{
        #pragma unused params
		new start_str[128];
        ProxDetector(20.0, playerid, start_str,COLOUR_LOCAL,COLOUR_LOCAL,COLOUR_LOCAL,COLOUR_LOCAL,COLOUR_LOCAL);
		format(start_str, sizeof(start_str), "The vehicle id %d.", GetPlayerVehicleID(playerid));
    	SendClientMessageToAll(COLOUR_LOCAL, start_str);
		TogglePlayerControllable(playerid,1);
    	return true;
}
dcmd_stop(playerid, params[])
{
        #pragma unused params
		new name[MAX_PLAYER_NAME], start_str[128];
    	GetPlayerName(playerid, name, sizeof(name));
    	format(start_str, sizeof(start_str), "%s's vehicle falls silent.", name );
        ProxDetector(20.0, playerid, start_str,COLOUR_LOCAL,COLOUR_LOCAL,COLOUR_LOCAL,COLOUR_LOCAL,COLOUR_LOCAL);
		TogglePlayerControllable(playerid,1);
    	return true;
}
dcmd_park(playerid, params[])
{
        #pragma unused params
        new Float:X,Float:Y,Float:Z,Float:Angle,currentveh, PlayerCar[64], playercarid;
		playercarid = 178 + AccountInfo[playerid][pVehicle];
		currentveh = GetPlayerVehicleID(playerid);
        if(AccountInfo[playerid][pVehicle] < 0) SendClientMessage(playerid,COLOUR_ADMINRED, "[Error]: You do not own a vehicle.");
		else if(!IsPlayerInAnyVehicle(playerid)) SendClientMessage(playerid,COLOUR_ADMINRED, "[Error]: You are not in your vehicle.");
		else if(currentveh < 178) SendClientMessage(playerid,COLOUR_ADMINRED, "[Error]: You are not in your house car.");
		else if(currentveh != playercarid) SendClientMessage(playerid,COLOUR_ADMINRED, "[Error]: You are not in your house car.");
		else
		{
			new carid;
			carid = AccountInfo[playerid][pVehicle];
			format(PlayerCar, sizeof(PlayerCar), "/PlayerCars/%d.dini.save", AccountInfo[playerid][pVehicle]);
	        GetVehiclePos(currentveh, X, Y, Z);
	        GetVehicleZAngle(currentveh, Angle);
			dini_FloatSet(PlayerCar,"Spawn_Coord:X", X);
	  		dini_FloatSet(PlayerCar,"Spawn_Coord:Y", Y);
	    	dini_FloatSet(PlayerCar,"Spawn_Coord:Z", Z);
	    	dini_FloatSet(PlayerCar,"Spawn_Coord:A", Angle);
			CarInfo[carid][vposX]	=  dini_Float(PlayerCar, "Spawn_Coord:X");
	       	CarInfo[carid][vposY]	=  dini_Float(PlayerCar, "Spawn_Coord:Y");
	        CarInfo[carid][vposZ]	=  dini_Float(PlayerCar, "Spawn_Coord:Z");
	        CarInfo[carid][vposA]	=  dini_Float(PlayerCar, "Spawn_Coord:A");
        	CarInfo[carid][Mod0]	=  dini_Int(PlayerCar, "Car Mod 0");
	       	CarInfo[carid][Mod1]	=  dini_Int(PlayerCar, "Car Mod 1");
	        CarInfo[carid][Mod2]	=  dini_Int(PlayerCar, "Car Mod 2");
	        CarInfo[carid][Mod3]	=  dini_Int(PlayerCar, "Car Mod 3");
   			CarInfo[carid][Mod4]	=  dini_Int(PlayerCar, "Car Mod 4");
	       	CarInfo[carid][Mod5]	=  dini_Int(PlayerCar, "Car Mod 5");
	        CarInfo[carid][Mod6]	=  dini_Int(PlayerCar, "Car Mod 6");
	        CarInfo[carid][Mod7]	=  dini_Int(PlayerCar, "Car Mod 7");
        	CarInfo[carid][Mod8]	=  dini_Int(PlayerCar, "Car Mod 8");
	       	CarInfo[carid][Mod9]	=  dini_Int(PlayerCar, "Car Mod 9");
	        CarInfo[carid][Mod10]	=  dini_Int(PlayerCar, "Car Mod 10");
	        CarInfo[carid][Mod11]	=  dini_Int(PlayerCar, "Car Mod 11");
	        CarInfo[carid][Mod12]	=  dini_Int(PlayerCar, "Car Mod 12");
	        CarInfo[carid][Mod13]	=  dini_Int(PlayerCar, "Car Mod 13");
	    	SendClientMessage(playerid,COLOUR_LIGHTBLUE, "[Server]: Your car will be spawned here from now on.");
			DestroyVehicle(currentveh);
			CarInfo[carid][cCarID] =  CreateVehicle(CarInfo[carid][cModelid], CarInfo[carid][vposX], CarInfo[carid][vposY], CarInfo[carid][vposZ], CarInfo[carid][vposA], CarInfo[carid][cColour1], CarInfo[carid][cColour2], 10);
            if(CarInfo[carid][Mod0] >= 1000){AddVehicleComponent(CarInfo[carid][cCarID], CarInfo[carid][Mod0]);}
		    if(CarInfo[carid][Mod1] >= 1000){AddVehicleComponent(CarInfo[carid][cCarID], CarInfo[carid][Mod1]);}
		    if(CarInfo[carid][Mod2] >= 1000){AddVehicleComponent(CarInfo[carid][cCarID], CarInfo[carid][Mod2]);}
		    if(CarInfo[carid][Mod3] >= 1000){AddVehicleComponent(CarInfo[carid][cCarID], CarInfo[carid][Mod3]);}
		    if(CarInfo[carid][Mod4] >= 1000){AddVehicleComponent(CarInfo[carid][cCarID], CarInfo[carid][Mod4]);}
		    if(CarInfo[carid][Mod5] >= 1000){AddVehicleComponent(CarInfo[carid][cCarID], CarInfo[carid][Mod5]);}
		    if(CarInfo[carid][Mod6] >= 1000){AddVehicleComponent(CarInfo[carid][cCarID], CarInfo[carid][Mod6]);}
		    if(CarInfo[carid][Mod7] >= 1000){AddVehicleComponent(CarInfo[carid][cCarID], CarInfo[carid][Mod7]);}
		    if(CarInfo[carid][Mod8] >= 1000){AddVehicleComponent(CarInfo[carid][cCarID], CarInfo[carid][Mod8]);}
		    if(CarInfo[carid][Mod9] >= 1000){AddVehicleComponent(CarInfo[carid][cCarID], CarInfo[carid][Mod9]);}
		    if(CarInfo[carid][Mod10] >= 1000){AddVehicleComponent(CarInfo[carid][cCarID], CarInfo[carid][Mod10]);}
		    if(CarInfo[carid][Mod11] >= 1000){AddVehicleComponent(CarInfo[carid][cCarID], CarInfo[carid][Mod11]);}
		    if(CarInfo[carid][Mod12] >= 1000){AddVehicleComponent(CarInfo[carid][cCarID], CarInfo[carid][Mod12]);}
		    if(CarInfo[carid][Mod13] >= 1000){AddVehicleComponent(CarInfo[carid][cCarID], CarInfo[carid][Mod13]);}
		}
 		return true;
}
dcmd_exit(playerid, params[])
{
        #pragma unused params
		new name[MAX_PLAYER_NAME], exit_str[128];
		if(IsPlayerInAnyVehicle(playerid) == 1)
		{
	    	GetPlayerName(playerid, name, sizeof(name));
	    	ProxDetector(20.0, playerid, exit_str,COLOUR_LOCAL,COLOUR_LOCAL,COLOUR_LOCAL,COLOUR_LOCAL,COLOUR_LOCAL);
	    	format(exit_str, sizeof(exit_str), "%s exits the vehicle.", name );
			SendClientMessageToAll(COLOUR_LOCAL, exit_str);
			TogglePlayerControllable(playerid,1);
  			RemovePlayerFromVehicle(playerid);
	    	return 1;
		}
		SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: Your not in a Vehicle");
		return 1;
}
dcmd_lock(playerid, params[])
{
        #pragma unused params
 		new carid = AccountInfo[playerid][pVehicle];
		if(CarInfo[carid][cLocked] == 1)
		{
   			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if (i != playerid)
			    {
					SetVehicleParamsForPlayer(CarInfo[carid][cCarID], i, 0, 0);
					CarInfo[carid][cLocked] = 0;
				}
			}
			SendClientMessage(playerid,COLOUR_HEADER, "You have unlocked your vehicle.");
		}
		if(CarInfo[carid][cLocked] == 0)
		{
   			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if (i != playerid)
			    {
					SetVehicleParamsForPlayer(CarInfo[carid][cCarID], i, 0, 1);
					CarInfo[carid][cLocked] = 1;
				}
			}
			SendClientMessage(playerid,COLOUR_HEADER, "You have locked your vehicle.");
		}
		return 1;
}
dcmd_refuel(playerid, params[])
{
        #pragma unused params
		if(!IsPlayerInAnyVehicle(playerid)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You are not at a petrol station.");
 		else if(IsAtGasStation(playerid))
		{
			new Float:olddistance = 999999;
			new Float:newdistance;
			new closest = -1;
			new Float:GasX,Float:GasY,Float:GasZ;
			TogglePlayerControllable(playerid,0);
			for (new i = 0; i < sizeof(gGasStationLocations); i++)
			{
				GasX = gGasStationLocations[i][0];
				GasY = gGasStationLocations[i][1];
				GasZ = gGasStationLocations[i][2];
				newdistance = GetDistanceBetweenPlayerToPoint(playerid,GasX,GasY,GasZ);
				if (newdistance < olddistance)
				{
				    olddistance = newdistance;
					closest = i;
				}
			}
 	   		GameTextForPlayer(playerid,"~w~~n~~n~~n~~n~~n~~n~~n~~n~~n~Refuel! Please wait....",2000,3);
			SetTimer("Fillup",RefuelWait,0);
			gGasBiz[playerid] = closest+12;
			Refueling[playerid] = 1;
		}
		else
		{
			SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You are not at a Petrol Station.");
		}
		return 1;
}
//<============================================================================>
//<================================[Bank Commands]=============================>
//<============================================================================>
dcmd_deposit(playerid, params[])
{
		new cashdeposit, string[128];
		if (sscanf(params, "d", cashdeposit)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: /deposit [amount].");
        else if (!IsAtBank(playerid)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You are not at a Bank.");
        else if (cashdeposit > GetPlayerMoney(playerid) || cashdeposit < 1)
        {
			SendClientMessage(playerid, COLOUR_WHITE, "[Bank]: You dont have that much");
			return 1;
		}
		else
		{
			GivePlayerMoney(playerid,-cashdeposit);
			new curfunds = AccountInfo[playerid][Bank];
			AccountInfo[playerid][Bank]=cashdeposit+AccountInfo[playerid][Bank];
			SendClientMessage(playerid, COLOUR_WHITE, "<====[Bank Statement]====>");
			format(string, sizeof(string), "[Old Balance]: $%d dollars", curfunds);
			SendClientMessage(playerid, COLOUR_WHITE, string);
			format(string, sizeof(string), "[Deposited]	 : $%d dollars", cashdeposit);
			SendClientMessage(playerid, COLOUR_WHITE, string);
			format(string, sizeof(string), "[New Balance]: $%d dollars", AccountInfo[playerid][Bank]);
			SendClientMessage(playerid, COLOUR_WHITE, "<========================>");
			SendClientMessage(playerid, COLOUR_WHITE, string);
		}
		return 1;
}
dcmd_withdraw(playerid, params[])
{
		new cashwithdraw, curfunds = AccountInfo[playerid][Bank], string[128];
		if (sscanf(params, "d", cashwithdraw)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: /withdraw [amount].");
        else if (!IsAtBank(playerid)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You are not at a Bank.");
        else if (cashwithdraw > curfunds)
		{
  			SendClientMessage(playerid, COLOUR_WHITE, "[Bank]: I'm sorry sir, you do not have that amount of money");
		}
		else
		{
			GivePlayerMoney(playerid,cashwithdraw);
			AccountInfo[playerid][Bank]=AccountInfo[playerid][Bank]-cashwithdraw;
			format(string, sizeof(string), "  You Have Withdrawn $%d from your account Total: $%d ", cashwithdraw,AccountInfo[playerid][Bank]);
			SendClientMessage(playerid, COLOUR_YELLOW, string);
			SendClientMessage(playerid, COLOUR_WHITE, "<====[Bank Statement]====>");
			format(string, sizeof(string), "[Old Balance]: $%d dollars", curfunds);
			SendClientMessage(playerid, COLOUR_WHITE, string);
			format(string, sizeof(string), "[Withdrew]	 : $%d dollars", cashwithdraw);
			SendClientMessage(playerid, COLOUR_WHITE, string);
			format(string, sizeof(string), "[New Balance]: $%d dollars", AccountInfo[playerid][Bank]);
			SendClientMessage(playerid, COLOUR_WHITE, "<========================>");
			SendClientMessage(playerid, COLOUR_WHITE, string);
		}
		return 1;
}
dcmd_balance(playerid, params[])
{
        #pragma unused params
		new string[128];
		if (!IsAtBank(playerid)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You are not at a Bank.");
		else
		{
			format(string, sizeof(string), "[Bank]: You currently have $%d dollars, would you like anything else sir?.",AccountInfo[playerid][Bank]);
			SendClientMessage(playerid, COLOUR_YELLOW, string);
  		}
		return 1;
//<============================================================================>
//<================================[Bank Commands]=============================>
//<============================================================================>
}
dcmd_requesttow(playerid,params[])
{
	new string[128],from[128],name[MAX_PLAYER_NAME];
	if (sscanf(params,"s", from)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /requesttow [location]");
	else if (AccountInfo[playerid][pTeam] != 1) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You are not a Police Officer");
	else
	{
		GetPlayerName(playerid, name, sizeof(name));
        format(string,sizeof(string),"[Dispatch]: Officer %s has requested a tow located at %s.",name,from);
		SendClientMessageToTow(COLOUR_ORANGE,string);
		SendClientMessage(playerid, COLOUR_ORANGE, "[Pro-Tow]: Officer there will be an engineer with you shortly.");
	}
	return 1;
}
dcmd_tazer(playerid, params[])
{
	new targetid;
	if (sscanf(params, "u", targetid)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /tazer [playerid]");
	else if(targetid == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: Player not connected");
	else if(GetDistanceBetweenPlayers(playerid,targetid) > 6) SendClientMessage(playerid, COLOUR_ADMINRED,"[Error]: Player is too far away");
	else if(AccountInfo[targetid][pTeam] == 1) { SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You canot tazer another Police Officer"); }
	else if(AccountInfo[playerid][pTeam] != 1) { SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You are not a Police Officer"); }
	else
	{
		new tazer;
		tazer = random(10);
		if(tazer < 6)
		{
  			new name[MAX_PLAYER_NAME], targetsname[MAX_PLAYER_NAME], string[128];
    		GetPlayerName(playerid, name, sizeof(name));
    		GetPlayerName(targetid, targetsname, sizeof(targetsname));
   			TogglePlayerControllable(targetid,1);
			ApplyAnimation(targetid, "CRACK", "crckdeth2", 4.0, 1, 1, 0, 0, 60000);
			format(string, sizeof(string), "[Police]: You have been electrocuted by Officer %s.", name);
			SendClientMessage(targetid, COLOUR_LIGHTBLUE, string);
			format(string, sizeof(string), "[Police]: You have stunned %s.", targetsname);
			SendClientMessage(playerid, COLOUR_LIGHTBLUE, string);
			SetTimerEx("Tazer",60000,false,"i",targetid);
		}
   		else
		{
  			new name[MAX_PLAYER_NAME], targetsname[MAX_PLAYER_NAME], string[128];
    		GetPlayerName(playerid, name, sizeof(name));
    		GetPlayerName(targetid, targetsname, sizeof(targetsname));
			format(string, sizeof(string), "[Police]: Officer %s fires the tazer and misses you..", name);
			SendClientMessage(targetid, COLOUR_LIGHTBLUE, string);
			format(string, sizeof(string), "[Police]: You fire the tazer and miss %s.", targetsname);
			SendClientMessage(playerid, COLOUR_LIGHTBLUE, string);
		}
	}
	return 1;
}
dcmd_cuff(playerid, params[])
{
	new targetid;
	if (sscanf(params, "u", targetid)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /cuff [playerid]");
	else if(targetid == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: Player not connected");
	else if(GetDistanceBetweenPlayers(playerid,targetid) > 3) SendClientMessage(playerid, COLOUR_ADMINRED,"[Error]: Player is too far away");
	else if(AccountInfo[targetid][pTeam] == 1) { SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You canot cuff another Police Officer"); }
	else if(AccountInfo[playerid][pTeam] != 1) { SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You are not a Police Officer"); }
	else
	{
        new name[MAX_PLAYER_NAME], targetsname[MAX_PLAYER_NAME], string[128];
    	GetPlayerName(playerid, name, sizeof(name));
		format(string, sizeof(string), "[Police]: You have been handcuffed by Officer %s.", name);
		SendClientMessage(targetid, COLOUR_LIGHTBLUE, string);
		TogglePlayerControllable(targetid, 0);
		format(string, sizeof(string), "[Police]: You have handcuffed %s.", targetsname);
		SendClientMessage(playerid, COLOUR_LIGHTBLUE, string);
		AccountInfo[targetid][Custody] = 1;
	}
	return 1;
}
dcmd_uncuff(playerid, params[])
{
	new targetid;
	if (sscanf(params, "u", targetid)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /uncuff [playerid]");
	else if(targetid == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: Player not connected");
	else if(GetDistanceBetweenPlayers(playerid,targetid) > 3) SendClientMessage(playerid, COLOUR_ADMINRED,"[Error]: Player is too far away");
	else if(AccountInfo[playerid][pTeam] != 1) { SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You are not a Police Officer"); }
	else if(AccountInfo[targetid][Custody] != 1) { SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: That player isn't cuffed"); }
	else
	{
        new name[MAX_PLAYER_NAME], targetsname[MAX_PLAYER_NAME], string[128];
    	GetPlayerName(playerid, name, sizeof(name));
		format(string, sizeof(string), "[Police]: You have been released by Officer %s.", name);
		SendClientMessage(targetid, COLOUR_LIGHTBLUE, string);
		TogglePlayerControllable(targetid, 1);
		format(string, sizeof(string), "[Police]: You have uncuffed %s.", targetsname);
		SendClientMessage(playerid, COLOUR_LIGHTBLUE, string);
	}
	return 1;
}
dcmd_restrain(playerid, params[])
{
	new targetid;
	if (sscanf(params, "u", targetid)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /uncuff [playerid]");
	else if(targetid == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: Player not connected");
	else if(GetDistanceBetweenPlayers(playerid,targetid) > 3) SendClientMessage(playerid, COLOUR_ADMINRED,"[Error]: Player is too far away");
	else if(AccountInfo[playerid][pTeam] != 1) { SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You are not a Police Officer"); }
	else if(AccountInfo[targetid][Custody] != 1) { SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: That player isn't cuffed"); }
	else
	{
        new name[MAX_PLAYER_NAME], targetsname[MAX_PLAYER_NAME], string[128], vehicle;
    	GetPlayerName(playerid, name, sizeof(name));
		format(string, sizeof(string), "[Police]: You have been forced in the Police car by Officer %s.", name);
		SendClientMessage(targetid, COLOUR_LIGHTBLUE, string);
		TogglePlayerControllable(targetid, 0);
		format(string, sizeof(string), "[Police]: You have forced %s into the Police car.", targetsname);
		SendClientMessage(playerid, COLOUR_LIGHTBLUE, string);
		vehicle = GetPlayerVehicleID(playerid);
        PutPlayerInVehicle(playerid, vehicle, 2);
	}
	return 1;
}
dcmd_roadblock(playerid, params[])
{
    #pragma unused params
	if(AccountInfo[playerid][pTeam] != 1) { SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You are not a Police Officer"); }
	if(RoadBlockDeployed[playerid] == 0)
	{
        new string[60], name[30];
		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
		new Float:angle;
		GetPlayerFacingAngle(playerid, angle);
	    RoadBlockDeployed[playerid] = 1;
		format(string, sizeof(string), "Officer %s places a roadblock.", name);
		ProxDetector(30.0, playerid, string,COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER);
	    PlayerRB[playerid] = CreateObject(1422, x, y, z-1, 0, 0, angle);
		SetPlayerPos(playerid, x+1, y+1, z+1);
	}
	else
	{
	    SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You have already deployed a roadblock");
	}
	return 1;
}
dcmd_removeroadblock(playerid, params[])
{
    #pragma unused params
	if(AccountInfo[playerid][pTeam] != 1) { SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You are not a Police Officer"); }
	if(RoadBlockDeployed[playerid] == 1)
	{
        new string[60], name[30];
		RoadBlockDeployed[playerid] = 0;
        GetPlayerName(playerid, name, sizeof(name));
		format(string, sizeof(string), "Officer %s removes the roadblock.", name);
		ProxDetector(30.0, playerid, string,COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER);
		DestroyObject(PlayerRB[playerid]);
	}
	else
	{
	    SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: There isn't a valid roadblock to destroy");
	}
	return 1;
}
dcmd_spike(playerid,params[])
{
    #pragma unused params
	if(AccountInfo[playerid][pTeam] != 1) { SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You are not a Police Officer"); }
	else
	{
            new string[60], name[30];
			new Float:plocx,Float:plocy,Float:plocz,Float:ploca;
	        GetPlayerPos(playerid, plocx, plocy, plocz);
	        GetPlayerFacingAngle(playerid,ploca);
	        CreateStrip(plocx,plocy,plocz,ploca);
        	GetPlayerName(playerid, name, sizeof(name));
			format(string, sizeof(string), "Officer %s places a spikestrip on the ground.", name);
			ProxDetector(30.0, playerid, string,COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER);
		    return 1;
	}
	return 1;
}
dcmd_removespike(playerid,params[])
{
    #pragma unused params
	if(AccountInfo[playerid][pTeam] != 1) { SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You are not a Police Officer"); }
	else
	{
 			new string[60], name[30];
			DeleteClosestStrip(playerid);
        	GetPlayerName(playerid, name, sizeof(name));
			format(string, sizeof(string), "Officer %s removes the strip from the ground.", name);
			ProxDetector(30.0, playerid, string,COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER,COLOUR_HEADER);
		    return 1;
	}
	return 1;
}
dcmd_lead(playerid, params[])
{
	new Float:pX,Float:pY,Float:pZ,giveplayerid;
    if (sscanf(params, "i", giveplayerid)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /lead [playerid]");
	else if(GetDistanceBetweenPlayers(playerid,giveplayerid) > 3) SendClientMessage(playerid, COLOUR_ADMINRED,"[Error]: Player is too far away");
    else if (!IsPlayerConnected(giveplayerid)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: Player ID not connected.");
	else if(AccountInfo[playerid][pTeam] != 1) { SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You are not a Police Officer"); }
	else if(AccountInfo[giveplayerid][Custody] != 1) { SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: That player isn't cuffed"); }
	else
	{
			if (GetPlayerState(giveplayerid) == PLAYER_STATE_DRIVER)
 			{
		    	GetPlayerPos(playerid,pX,pY,pZ);
		    	SetVehiclePos(GetPlayerVehicleID(giveplayerid),pX,pY,pZ+2);
			}
			else
			{
		    	GetPlayerPos(playerid,pX,pY,pZ);
		    	SetPlayerPos(giveplayerid,pX,pY,pZ+2);
			}
   			SetPlayerInterior(giveplayerid,GetPlayerInterior(playerid));
	}
	return 1;
}
dcmd_jail(playerid,params[])
{
	new suspectid, cell = random(sizeof(ArrestJail));
	if(sscanf(params,"u",suspectid)) SendClientMessage(playerid,COLOUR_ADMINRED, "[Usage]: /jail [playerid]");
	else if(GetDistanceBetweenPlayers(playerid,suspectid) > 3) SendClientMessage(playerid, COLOUR_ADMINRED,"[Error]: Player is too far away");
	else if(suspectid == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: Player not connected.");
	else if(AccountInfo[playerid][pTeam] != 1) { SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You are not a Police Officer."); }
	else if(AccountInfo[suspectid][Custody] != 1) { SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: That player isn't cuffed"); }
	else
	{
		if(GetPlayerWantedLevel(suspectid) == 1)
		{
	        SetTimerEx("Release",60000,false,"i",suspectid);
			SetPlayerPos(suspectid, ArrestJail[cell][0], ArrestJail[cell][1], ArrestJail[cell][2]);
			SetPlayerInterior(suspectid,10);
			return 1;
		}
		if(GetPlayerWantedLevel(suspectid) == 2)
	 	{
			SetTimerEx("Release",120000,false,"i",suspectid);
			SetPlayerPos(suspectid, ArrestJail[cell][0], ArrestJail[cell][1], ArrestJail[cell][2]);
			SetPlayerInterior(suspectid,10);
			JailCountTimer = SetTimer("JailTimer", 1000, true);
			return 1;
		}
		if(GetPlayerWantedLevel(suspectid) == 3)
		{
		    SetTimerEx("Release",180000,false,"i",suspectid);
			SetPlayerPos(suspectid, ArrestJail[cell][0], ArrestJail[cell][1], ArrestJail[cell][2]);
			SetPlayerInterior(suspectid,10);
			JailCountTimer = SetTimer("JailTimer", 1000, true);
			return 1;
		}
		if(GetPlayerWantedLevel(suspectid) == 4)
		{
			SetTimerEx("Release",240000,false,"i",suspectid);
			SetPlayerPos(suspectid, ArrestJail[cell][0], ArrestJail[cell][1], ArrestJail[cell][2]);
			SetPlayerInterior(suspectid,10);
			JailCountTimer = SetTimer("JailTimer", 1000, true);
			return 1;
		}
		if(GetPlayerWantedLevel(suspectid) == 5)
		{
            counter = 300;
			SetTimerEx("Release",300000,false,"i",suspectid);
			SetPlayerPos(suspectid, ArrestJail[cell][0], ArrestJail[cell][1], ArrestJail[cell][2]);
			SetPlayerInterior(suspectid,10);
			JailCountTimer = SetTimer("JailTimer", 1000, true);
			return 1;
		}
		if(GetPlayerWantedLevel(suspectid) == 6)
		{
            counter = 360;
			SetTimerEx("Release",360000,false,"i",suspectid);
			SetPlayerPos(suspectid, ArrestJail[cell][0], ArrestJail[cell][1], ArrestJail[cell][2]);
			SetPlayerInterior(suspectid,10);
			JailCountTimer = SetTimer("JailTimer", 1000, true);
			return 1;
		}
		if(GetPlayerWantedLevel(suspectid) == 7)
		{
            counter = 420;
			SetTimerEx("Release",420000,false,"i",suspectid);
			SetPlayerPos(suspectid, ArrestJail[cell][0], ArrestJail[cell][1], ArrestJail[cell][2]);
			SetPlayerInterior(suspectid,10);
			JailCountTimer = SetTimer("JailTimer", 1000, true);
			return 1;
		}
		if(GetPlayerWantedLevel(suspectid) == 8)
	    {
			counter = 480;
			SetTimerEx("Release",480000,false,"i",suspectid);
			SetPlayerPos(suspectid, ArrestJail[cell][0], ArrestJail[cell][1], ArrestJail[cell][2]);
			SetPlayerInterior(suspectid,10);
			JailCountTimer = SetTimer("JailTimer", 1000, true);
			return 1;
		}
		if(GetPlayerWantedLevel(suspectid) == 9)
		{
            counter = 540;
			SetTimerEx("Release",540000,false,"i",suspectid);
			SetPlayerPos(suspectid, ArrestJail[cell][0], ArrestJail[cell][1], ArrestJail[cell][2]);
			SetPlayerInterior(suspectid,10);
			JailCountTimer = SetTimer("JailTimer", 1000, true);
			return 1;
		}
		if(GetPlayerWantedLevel(suspectid) == 10)
		{
            counter = 600;
			SetTimerEx("Release",600000,false,"i",suspectid);
			SetPlayerPos(suspectid, ArrestJail[cell][0], ArrestJail[cell][1], ArrestJail[cell][2]);
			SetPlayerInterior(suspectid,10);
			JailCountTimer = SetTimer("JailTimer", 1000, true);
			return 1;
		}
	}
	return 1;
}
dcmd_fine(playerid,params[])
{
	new suspectid, cost, suspectname[MAX_PLAYER_NAME], string[128];
	if(sscanf(params,"ud",suspectid, cost)) SendClientMessage(playerid,COLOUR_ADMINRED, "[Usage]: /fine [playerid][amount]");
	else if(GetDistanceBetweenPlayers(playerid,suspectid) > 3) SendClientMessage(playerid, COLOUR_ADMINRED,"[Error]: Player is too far away");
	else if(suspectid == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: Player not connected.");
	else if(AccountInfo[playerid][pTeam] != 1) { SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You are not a Police Officer."); }
	else if(AccountInfo[playerid][pTeam] != 1) { SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You are not a Police Officer."); }
	else
	{
		if(GetPlayerWantedLevel(suspectid) > 2)
		{
            SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: That person's crimes are to serious for just a ticket.");
			return 1;
		}
		else
	 	{
   			GivePlayerMoney(suspectid, -cost);
			SetPlayerWantedLevel(suspectid, 0);
			GetPlayerName(suspectid, suspectname, sizeof(suspectname));
			format(string, sizeof(string), "[Police]: %s has been fined $%d.", suspectname, cost);
			SendClientMessageToPolice(COLOUR_LIGHTBLUE, string);
			format(string, sizeof(string), "[Police]: You have been fined $%d.", cost);
			SendClientMessage(playerid, COLOUR_LIGHTBLUE, string);
			return 1;
		}
	}
	return 1;
}
dcmd_warrant(playerid,params[])
{
	new suspectid, wantedlevel, oldwantedlevel = GetPlayerWantedLevel(suspectid), crime[128], string[128];
	if(sscanf(params,"uis",suspectid,wantedlevel,crime)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /warrant [playerid] [wantedlevel] [crime]");
	else if(suspectid == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: Player not connected.");
	else if(AccountInfo[playerid][pTeam] != 1) { SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You are not a Police Officer."); }
	else if(wantedlevel >= 10) {SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: The Highest Wanted level is 10."); }
	else
	{
		new newwantedlevel = wantedlevel + oldwantedlevel;
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i))
			{
				if (AccountInfo[i][pTeam] == 1)
				{
				new suspectname[MAX_PLAYER_NAME];
				PlayCrimeReportForPlayer((i),suspectid,5);
				SetPlayerWantedLevel(suspectid, newwantedlevel);
				GetPlayerName(suspectid, suspectname, sizeof(suspectname));
				format(string, sizeof(string), "[Police]: A warrant has been issued for %s.", suspectname);
				SendClientMessageToPolice(COLOUR_LIGHTBLUE, string);
				format(string, sizeof(string), "[Crime]: Wanted for %s.", crime);
				SendClientMessageToPolice(COLOUR_LIGHTBLUE, string);
				}
			}
		}
	}
	return 1;
}
dcmd_backup(playerid, params[])
{
        new location[128], sendername[MAX_PLAYER_NAME], Hours, Minutes, Seconds, string[128];
		if (sscanf(params, "s", location)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: /backup [location].");
        else if (AccountInfo[playerid][pTeam] != 1) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You are not a Police Officer.");
        else
        {
				GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string, sizeof(string), "[Police Radio]: Officer %s requests assistance at %s" ,sendername, location);
	  			SendClientMessageToPolice(COLOUR_LIGHTBLUE, string);
	  			gettime(Hours,Minutes,Seconds);
				new send[256],File:hFile=fopen("/Server Logs/Chat.ini", io_append);
				format(send, sizeof(send), "[%d:%d][Police]%s (%d): '%s'\r\n", Hours, Minutes,sendername, playerid, string);
				fwrite(hFile,send);
				fclose(hFile);
				return 1;
		}
		return 1;
}
dcmd_search(playerid,params[])
{
	new suspectid, string[128];
	if(sscanf(params,"u",suspectid)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /search [playerid]");
	else if(GetDistanceBetweenPlayers(playerid,suspectid) > 3) SendClientMessage(playerid, COLOUR_ADMINRED,"[Error]: Player is too far away");
	else if(suspectid == INVALID_PLAYER_ID) SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: Player not connected.");
	else if(AccountInfo[playerid][pTeam] != 1) { SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You are not a Police Officer."); }
	else if(AccountInfo[suspectid][Cannabis] != 0)
	{
	    format(string, sizeof(string), "[Search]: Found %d bags of Cannabis.", AccountInfo[suspectid][Cannabis]);
		SendClientMessage(playerid, COLOUR_LIGHTBLUE, string);
		SendClientMessage(suspectid, COLOUR_LIGHTBLUE, string);
	}
	else if(AccountInfo[suspectid][Crack] != 0)
	{
 		format(string, sizeof(string), "[Search]: Found %d grams of Crack.", AccountInfo[suspectid][Crack]);
		SendClientMessage(playerid, COLOUR_LIGHTBLUE, string);
		SendClientMessage(suspectid, COLOUR_LIGHTBLUE, string);
	}
	else if(AccountInfo[suspectid][Cocaine]	!= 0)
	{
 		format(string, sizeof(string), "[Search]: Found %d grams of Cocaine.", AccountInfo[suspectid][Cocaine]);
		SendClientMessage(playerid, COLOUR_LIGHTBLUE, string);
		SendClientMessage(suspectid, COLOUR_LIGHTBLUE, string);
	}
	else if(AccountInfo[suspectid][Ecstasy] != 0)
	{
 		format(string, sizeof(string), "[Search]: Found %d Ecstasy tablets.", AccountInfo[suspectid][Ecstasy]);
		SendClientMessage(playerid, COLOUR_LIGHTBLUE, string);
		SendClientMessage(suspectid, COLOUR_LIGHTBLUE, string);
	}
	else if(AccountInfo[suspectid][Firearms] != 0)
	{
 		format(string, sizeof(string), "[Search]: Found %d pieces of Firearms.", AccountInfo[suspectid][Firearms]);
		SendClientMessage(playerid, COLOUR_LIGHTBLUE, string);
		SendClientMessage(suspectid, COLOUR_LIGHTBLUE, string);
	}
	else
	{
 		format(string, sizeof(string), "[Search]: Found no illegal substances or parafonelia.");
		SendClientMessage(playerid, COLOUR_LIGHTBLUE, string);
		SendClientMessage(suspectid, COLOUR_LIGHTBLUE, string);
	}
	return 1;
}
dcmd_duty(playerid, params[])
{
    #pragma unused params
    new savedskin;
    savedskin = GetPlayerSkin(playerid);
    AccountInfo[playerid][Playerskin] = savedskin;
	if(IsAtSFPD(playerid) && AccountInfo[playerid][pTeam] == 1)
	{
			new officer[MAX_PLAYER_NAME], string[128];
			GivePlayerWeapon(playerid, 3, 1);
			GivePlayerWeapon(playerid, 41, 500);
			GivePlayerWeapon(playerid, 24, 100);
			SetPlayerArmour(playerid, 100);
			GetPlayerName(playerid, officer, sizeof(officer));
			format(string, sizeof(string), "[Duty]: Officer %s puts on his uniform and his badge.", officer);
			ProxDetector(10.0, playerid, string,COLOUR_LOCAL,COLOUR_LOCAL,COLOUR_LOCAL,COLOUR_LOCAL,COLOUR_LOCAL);
			printf("%s", string);
			new playerskin, playerrank;
			gTeam[playerid] = TEAM_COP;
			SetPlayerColor(playerid, COLOUR_LIGHTBLUE);
 	      	playerskin = GetPlayerSkin(playerid);
        	playerrank = AccountInfo[playerid][GangRank];
      	    SetPlayerSkin(playerid, 266);
			if(playerskin == 266){SetPlayerSkin( playerid, 265 );}
			if(playerskin == 265){SetPlayerSkin( playerid, 267 );}
			if(playerskin == 267){SetPlayerSkin( playerid, 284 );}
			if(playerskin == 284){SetPlayerSkin( playerid, 285 );}
			if(playerskin == 285){SetPlayerSkin( playerid, 280 );}
			if(playerskin == 280){SetPlayerSkin( playerid, 281 );}
			if(playerskin == 281){SetPlayerSkin( playerid, 266 );}
			if(playerrank == 4  ){SetPlayerSkin( playerid, 283 );}
			if(playerrank == 5  ){SetPlayerSkin( playerid, 286 );}
	}
	else if(IsAtSFFD(playerid) && AccountInfo[playerid][pJob] == 7)
	{
			new firefighter[MAX_PLAYER_NAME], string[128];
			GivePlayerWeapon(playerid, 9, 1);
			GivePlayerWeapon(playerid, 42, 500);
			GetPlayerName(playerid, firefighter, sizeof(firefighter));
			format(string, sizeof(string), "[Duty]: Firefighter %s puts on his uniform and his helmet.", firefighter);
			ProxDetector(10.0, playerid, string,COLOUR_LOCAL,COLOUR_LOCAL,COLOUR_LOCAL,COLOUR_LOCAL,COLOUR_LOCAL);
			printf("%s", string);
      	    SetPlayerSkin(playerid, 279);
      	    SetPlayerColor(playerid, COLOUR_ORANGE);
	}
 	else if(IsAtSFHospital(playerid) && AccountInfo[playerid][pJob] == 8)
	{
			new paramedic[MAX_PLAYER_NAME], string[128];
			GetPlayerName(playerid, paramedic, sizeof(paramedic));
			format(string, sizeof(string), "[Duty]: Paramedic %s puts on his uniform and grabs the Ambulance keys.", paramedic);
			ProxDetector(10.0, playerid, string,COLOUR_LOCAL,COLOUR_LOCAL,COLOUR_LOCAL,COLOUR_LOCAL,COLOUR_LOCAL);
			printf("%s", string);
			new playerskin;
 	      	playerskin = GetPlayerSkin(playerid);
      	    SetPlayerSkin(playerid, 275);
			if(playerskin == 275){SetPlayerSkin( playerid, 274 );}
			if(playerskin == 274){SetPlayerSkin( playerid, 276 );}
			if(playerskin == 276){SetPlayerSkin( playerid, 275 );}
			SetPlayerColor(playerid, COLOUR_ORANGE);
	}
	else
	{
	    SendClientMessage(playerid, COLOUR_ADMINRED, "You arent at your HQ");
	}
	return 1;
}
dcmd_offduty(playerid, params[])
{
    #pragma unused params
	if(IsAtSFPD(playerid) && AccountInfo[playerid][pTeam] == 1)
	{
			new officer[MAX_PLAYER_NAME], string[128];
			SetPlayerArmour(playerid, 0);
			GetPlayerName(playerid, officer, sizeof(officer));
			format(string, sizeof(string), "[Duty]: Officer %s takes off his uniform and his badge.", officer);
			ProxDetector(10.0, playerid, string,COLOUR_LOCAL,COLOUR_LOCAL,COLOUR_LOCAL,COLOUR_LOCAL,COLOUR_LOCAL);
			printf("%s", string);
			SetPlayerColor(playerid, COLOUR_WHITE);
      	    SetPlayerSkin(playerid, AccountInfo[playerid][Playerskin]);
	}
	else if(IsAtSFFD(playerid) && AccountInfo[playerid][pJob] == 7)
	{
			new firefighter[MAX_PLAYER_NAME], string[128];
			GetPlayerName(playerid, firefighter, sizeof(firefighter));
			format(string, sizeof(string), "[Duty]: Firefighter %s takes off his uniform and his helmet.", firefighter);
			ProxDetector(10.0, playerid, string,COLOUR_LOCAL,COLOUR_LOCAL,COLOUR_LOCAL,COLOUR_LOCAL,COLOUR_LOCAL);
			printf("%s", string);
			if (AccountInfo[playerid][pTeam] == 2 && GetPlayerTeam(playerid) == 2)
			{
				SetPlayerSkin(playerid, AccountInfo[playerid][Playerskin]);
				SetPlayerColor(playerid, COLOUR_FORELLI);
			}
			if (AccountInfo[playerid][pTeam] == 3 && GetPlayerTeam(playerid) == 3)
			{
				SetPlayerSkin(playerid, AccountInfo[playerid][Playerskin]);
				SetPlayerColor(playerid, COLOUR_THELOST);
			}
			if (AccountInfo[playerid][pTeam] == 5 && GetPlayerTeam(playerid) == 5)
			{
				SetPlayerSkin(playerid, AccountInfo[playerid][Playerskin]);
				SetPlayerColor(playerid, COLOUR_NORTHSIDE);
			}
			if (AccountInfo[playerid][pTeam] == 0 && GetPlayerTeam(playerid) == 0)
			{
                SetPlayerSkin(playerid, AccountInfo[playerid][Playerskin]);
				SetPlayerColor(playerid, COLOUR_WHITE);
			}
	}
 	else if(IsAtSFHospital(playerid) && AccountInfo[playerid][pJob] == 8)
	{
			new paramedic[MAX_PLAYER_NAME], string[128];
			GetPlayerName(playerid, paramedic, sizeof(paramedic));
			format(string, sizeof(string), "[Duty]: Paramedic %s takes off his uniform and returns the Ambulance keys.", paramedic);
			ProxDetector(10.0, playerid, string,COLOUR_LOCAL,COLOUR_LOCAL,COLOUR_LOCAL,COLOUR_LOCAL,COLOUR_LOCAL);
			printf("%s", string);
			if (AccountInfo[playerid][pTeam] == 2 && GetPlayerTeam(playerid) == 2)
			{
				SetPlayerSkin(playerid, AccountInfo[playerid][Playerskin]);
				SetPlayerColor(playerid, COLOUR_FORELLI);
			}
			if (AccountInfo[playerid][pTeam] == 3 && GetPlayerTeam(playerid) == 3)
			{
				SetPlayerSkin(playerid, AccountInfo[playerid][Playerskin]);
				SetPlayerColor(playerid, COLOUR_THELOST);
			}
			if (AccountInfo[playerid][pTeam] == 5 && GetPlayerTeam(playerid) == 5)
			{
				SetPlayerSkin(playerid, AccountInfo[playerid][Playerskin]);
				SetPlayerColor(playerid, COLOUR_NORTHSIDE);
			}
			if (AccountInfo[playerid][pTeam] == 0 && GetPlayerTeam(playerid) == 0)
			{
                SetPlayerSkin(playerid, AccountInfo[playerid][Playerskin]);
				SetPlayerColor(playerid, COLOUR_WHITE);
			}
	}
	else
	{
	    SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You arent at your HQ");
	}
	return 1;
}
//<====================================[House Commands]=================================================================================================>
dcmd_househelp(playerid,params[])
{
	#pragma unused params
	if(IsPlayerConnected(playerid))
	{
		SendClientMessage(playerid, COLOUR_WHITE,"[House Owner]: /(un)sellhouse, /(un)lockhouse, /house (upgrade/downgrade)");
		SendClientMessage(playerid, COLOUR_WHITE,"[Civilians]: /houseinfo, /buyhouse, /enter, /leave");
	}
	return 1;
}
dcmd_houseinfo(playerid,params[])
{
	#pragma unused params
	if(IsPlayerConnected(playerid))
	{
		for(new h = 0; h <= MAX_HOUSES; h++)
		{
		    if(PlayerToPoint(PTP_RADIUS, playerid, HouseInfo[h][hExitX], HouseInfo[h][hExitY], HouseInfo[h][hExitZ]))
			{
			    new IsLocked[24];
			    if(HouseInfo[h][hLocked] == 1) { IsLocked = "True"; } else { IsLocked = "False"; }
			    SendClientMessage(playerid, COLOUR_GREEN,"<======================[House Stats]====================>");
			    SendFormattedMessage(playerid, COLOUR_WHITE, "[Owner: %s] - [Level[%d]] - [SellPrice[$%d]]", HouseInfo[h][hName], HouseInfo[h][hLevel], HouseInfo[h][hSell]);
			    SendFormattedMessage(playerid, COLOUR_WHITE, "[IsLocked[%s]] - HouseID[%d] - ExitCoords[X:%.4f, Y:%.4f, Z:%.4f]", IsLocked, h, HouseInfo[h][hExitX], HouseInfo[h][hExitY], HouseInfo[h][hExitZ]);
			    SendClientMessage(playerid, COLOUR_GREEN,"<=======================================================>");
	  		}
	  		return 1;
		}
	}
	return 1;
}
dcmd_enter(playerid,params[])
{
	#pragma unused params
	if(IsPlayerConnected(playerid))
	{
		for(new h = 0; h <= MAX_HOUSES; h++)
		{
		    if(PlayerToPoint(PTP_RADIUS, playerid, HouseInfo[h][hExitX], HouseInfo[h][hExitY], HouseInfo[h][hExitZ]))
			{
		    	new Level = HouseInfo[h][hLevel];
		    	if(HouseInfo[h][hLocked] == 1 && strcmp(HouseInfo[h][hName],GetName(playerid), false ) != 0) return SendClientMessage(playerid, COLOUR_WHITE,  ".:: [HOUSE]: This house has been locked by the owner.");
	    		SetPlayerPos(playerid, HousesCoords[Level][0], HousesCoords[Level][1], HousesCoords[Level][2]);
	   			SetPlayerInterior(playerid, HousesLevels[Level][0]); SetPlayerVirtualWorld(playerid, HouseInfo[h][hVirtualWorld]);
	 		}
	 		return 1;
		}
	}
	return 1;
}
dcmd_leave(playerid,params[])
{
	#pragma unused params
	if(IsPlayerConnected(playerid))
	{
		for(new h = 0; h <= MAX_HOUSES; h++)
		{
		    if(PlayerToPoint(PTP_RADIUS, playerid, HousesCoords[HouseInfo[h][hLevel]][0], HousesCoords[HouseInfo[h][hLevel]][1], HousesCoords[HouseInfo[h][hLevel]][2]))
			{
	       		SetPlayerPos(playerid, HouseInfo[h][hExitX], HouseInfo[h][hExitY], HouseInfo[h][hExitZ]);
		   		SetPlayerInterior(playerid, 0); SetPlayerVirtualWorld(playerid, 0);
 	 		}
 	 		return 1;
		}
	}
	return 1;
}
dcmd_buyhouse(playerid,params[])
{
	#pragma unused params
	if(IsPlayerConnected(playerid))
	{
	    for(new h = 0; h <= MAX_HOUSES; h++)
		{
		    if(PlayerToPoint(PTP_RADIUS, playerid, HouseInfo[h][hExitX], HouseInfo[h][hExitY], HouseInfo[h][hExitZ]))
			{
		        if(strcmp(HouseInfo[h][hName],GetName(playerid), false ) != 0)
				{
		        	if(HouseInfo[h][hSellable] == 1)
					{
			            if(GetPlayerMoney(playerid) < HouseInfo[h][hSell]) return SendClientMessage(playerid, COLOUR_WHITE, "[Estate Agent]: You do not have enough money to buy this property.");
			        	DestroyPickup(HouseInfo[h][hPickup]);
			        	HouseInfo[h][hPickup] = CreatePickup(1272,23, HouseInfo[h][hExitX], HouseInfo[h][hExitY], HouseInfo[h][hExitZ]); // bought
						HouseInfo[h][hSellable] = 0; GivePlayerMoney(playerid, -HouseInfo[h][hSell]);
			        	format(HouseInfo[h][hName], 24, "%s", GetName(playerid)); SavePlayerHouse(h);
          			}
				  	else return SendClientMessage(playerid, COLOUR_WHITE, "[Estate Agent]: I'm sorry but this house is not for sale.");
				}
			   	else return SendClientMessage(playerid, COLOUR_WHITE, "[Estate Agent]:You cannot buy a house you are selling.");
		    } } }
	return 1;
}
dcmd_buycar(playerid,params[])
{
	new car[24], colour1, colour2, level = AccountInfo[playerid][pLevel], money = GetPlayerMoney(playerid), string[128];
	if (sscanf(params, "sdd", car, colour1, colour2)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /buycar [carname] [colour 1] [colour 2]");
	else if(PlayerToPoint(10.0, playerid, -1954.3831,299.7207,35.4688))
	{
			if(!strcmp(car, "Camper",true, 6))
			{
		 		if(level < 2){SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You do not have a high enough level."); return 1;}
				else if (money < 3499){SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You do not have enough money."); return 1;}
				else
				{
					CreatePlayerCar(playerid, 483, colour1, colour2); GivePlayerMoney(playerid, -3499);
		     		format(string,sizeof(string), "[Mr.Wang]: Okay your brand new %s is around the back, please drive carefully and have a nice day.", car);
					SendClientMessage(playerid,COLOUR_HEADER,string);
				}
			}
   			if(!strcmp(car, "Tampa", true, 5))
			{
		 		if(level < 4){SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You do not have a high enough level."); return 1;}
				else if (money < 6499){SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You do not have enough money."); return 0; }
				else
				{
					DestroyPlayerCar(playerid, AccountInfo[playerid][pVehicle]);
					CreatePlayerCar(playerid, 549, colour1, colour2); GivePlayerMoney(playerid, -6499);
		     		format(string,sizeof(string), "[Mr.Wang]: Okay your brand new %s is around the back, please drive carefully and have a nice day.", car);
					SendClientMessage(playerid,COLOUR_HEADER,string);
	   			}
			}
 			if(!strcmp(car, "Landstalker", true,11))
 			{
		 		if(level < 2){SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You do not have a high enough level."); return 1;}
				else if (money < 3999){SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You do not have enough money."); return 1;}
				else
				{
					DestroyPlayerCar(playerid, AccountInfo[playerid][pVehicle]);
					CreatePlayerCar(playerid, 400, colour1, colour2); GivePlayerMoney(playerid, -3999);
		     		format(string,sizeof(string), "[Mr.Wang]: Okay your brand new %s is around the back, please drive carefully and have a nice day.", car);
					SendClientMessage(playerid,COLOUR_HEADER,string);
				}
			}
		    if(!strcmp(car, "Picador" , true,7))
		    {
			 	if(level < 3){SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You You do not have a high enough level."); return 1;}
				else if(money < 6499){SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You do not have enough money."); return 1;}
				else
				{
					DestroyPlayerCar(playerid, AccountInfo[playerid][pVehicle]);
					CreatePlayerCar(playerid, 600, colour1, colour2); GivePlayerMoney(playerid, -6499);
		     		format(string,sizeof(string), "[Mr.Wang]: Okay your brand new %s is around the back, please drive carefully and have a nice day.", car);
					SendClientMessage(playerid,COLOUR_HEADER,string);
				}
			}
 			if(!strcmp(car, "Clover"  , true,6))
			{
			 	if(level < 5){SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You do not have a high enough level."); return 1;}
				else if (money < 6999){SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You do not have enough money."); return 1;}
				else
				{
					DestroyPlayerCar(playerid, AccountInfo[playerid][pVehicle]);
				 	CreatePlayerCar(playerid, 542, colour1, colour2); GivePlayerMoney(playerid, -6999);
		     		format(string,sizeof(string), "[Mr.Wang]: Okay your brand new %s is around the back, please drive carefully and have a nice day.", car);
					SendClientMessage(playerid,COLOUR_HEADER,string);
				}
			}
 			if(!strcmp(car, "Journey" , true,7))
			{
			 	if(level < 2){SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You do not have a high enough level."); return 1;}
				else if (money < 4999){SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You do not have enough money."); return 1;}
				else
				{
					DestroyPlayerCar(playerid, AccountInfo[playerid][pVehicle]);
					CreatePlayerCar(playerid, 508, colour1, colour2); GivePlayerMoney(playerid, -4999);
		     		format(string,sizeof(string), "[Mr.Wang]: Okay your brand new %s is around the back, please drive carefully and have a nice day.", car);
					SendClientMessage(playerid,COLOUR_HEADER,string);
				}
			}
 			if(!strcmp(car, "Moonbeam", true,8))
			{
			 	if(level < 7){SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: [Error]: You You do not have a high enough level."); return 1;}
				else if (money < 7499){SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You do not have enough money."); return 1;}
				else
				{
					DestroyPlayerCar(playerid, AccountInfo[playerid][pVehicle]);
					CreatePlayerCar(playerid, 418, colour1, colour2); GivePlayerMoney(playerid, -7499);
		     		format(string,sizeof(string), "[Mr.Wang]: Okay your brand new %s is around the back, please drive carefully and have a nice day.", car);
					SendClientMessage(playerid,COLOUR_HEADER,string);
				}
			}
			if(!strcmp(car, "Admiral" , true,7))
			{
			 	if(level < 6){SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You do not have a high enough level."); return 1;}
				else if (money < 6999){SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You do not have enough money."); return 1;}
				else
				{
					DestroyPlayerCar(playerid, AccountInfo[playerid][pVehicle]);
					CreatePlayerCar(playerid, 458, colour1, colour2); GivePlayerMoney(playerid, -6999);
		     		format(string,sizeof(string), "[Mr.Wang]: Okay your brand new %s is around the back, please drive carefully and have a nice day.", car);
					SendClientMessage(playerid,COLOUR_HEADER,string);
				}
			}
 			if(!strcmp(car, "Oceanic" , true,7))
			{
			 	if(level < 8){SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You do not have a high enough level."); return 1;}
				else if (money < 8499){SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You do not have enough money."); return 1;}
				else
				{
					DestroyPlayerCar(playerid, AccountInfo[playerid][pVehicle]);
					CreatePlayerCar(playerid, 467, colour1, colour2); GivePlayerMoney(playerid, -8499);
		     		format(string,sizeof(string), "[Mr.Wang]: Okay your brand new %s is around the back, please drive carefully and have a nice day.", car);
					SendClientMessage(playerid,COLOUR_HEADER,string);
				}
			}
 			if(!strcmp(car, "Sentinel", true,8))
			{
			 	if(level < 8){SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You do not have a high enough level."); return 1;}
				else if (money < 7999){SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You do not have enough money."); return 1;}
				else
				{
					DestroyPlayerCar(playerid, AccountInfo[playerid][pVehicle]);
					CreatePlayerCar(playerid, 405, colour1, colour2); GivePlayerMoney(playerid, -7999);
		     		format(string,sizeof(string), "[Mr.Wang]: Okay your brand new %s is around the back, please drive carefully and have a nice day.", car);
					SendClientMessage(playerid,COLOUR_HEADER,string);
				}
			}
 			if(!strcmp(car, "Huntley", true,7))
			{
			 	if(level < 10){SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You do not have a high enough level."); return 1;}
				else if (money < 9999){SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You do not have enough money."); return 1;}
				else
				{
					DestroyPlayerCar(playerid, AccountInfo[playerid][pVehicle]);
					CreatePlayerCar(playerid, 579, colour1, colour2); GivePlayerMoney(playerid, -9999);
		     		format(string,sizeof(string), "[Mr.Wang]: Okay your brand new %s is around the back, please drive carefully and have a nice day.", car);
					SendClientMessage(playerid,COLOUR_HEADER,string);
				}
			}
 			if(!strcmp(car, "Washington", true,10))
			{
			 	if(level < 9){SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You do not have a high enough level."); return 1;}
				else if (money < 8499){SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You do not have enough money."); return 1;}
				else
				{
					DestroyPlayerCar(playerid, AccountInfo[playerid][pVehicle]);
					CreatePlayerCar(playerid, 421, colour1, colour2); GivePlayerMoney(playerid, -8499);
		     		format(string,sizeof(string), "[Mr.Wang]: Okay your brand new %s is around the back, please drive carefully and have a nice day.", car);
					SendClientMessage(playerid,COLOUR_HEADER,string);
				}
			}
 			if(!strcmp(car, "Stallion", true,8))
			{
			 	if(level < 13){SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You do not have a high enough level."); return 1;}
				else if (money < 14499){SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You do not have enough money."); return 1;}
				else
				{
					DestroyPlayerCar(playerid, AccountInfo[playerid][pVehicle]);
					CreatePlayerCar(playerid, 439, colour1, colour2); GivePlayerMoney(playerid, -14499);
		     		format(string,sizeof(string), "[Mr.Wang]: Okay your brand new %s is around the back, please drive carefully and have a nice day.", car);
					SendClientMessage(playerid,COLOUR_HEADER,string);
				}
			}
 			if(!strcmp(car, "Patriot", true,7))
			{
			 	if(level < 15){SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You do not have a high enough level."); return 1;}
				else if (money < 19999){SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You do not have enough money."); return 1;}
				else
				{
					DestroyPlayerCar(playerid, AccountInfo[playerid][pVehicle]);
					CreatePlayerCar(playerid, 508, colour1, colour2); GivePlayerMoney(playerid, -19999);
		     		format(string,sizeof(string), "[Mr.Wang]: Okay your brand new %s is around the back, please drive carefully and have a nice day.", car);
					SendClientMessage(playerid,COLOUR_HEADER,string);
				}
			}
 			if(!strcmp(car, "Hermes", true,6))
			{
			 	if(level < 12){SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You do not have a high enough level."); return 1;}
				else if (money < 12999){SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You do not have enough money."); return 1;}
				else
				{
					DestroyPlayerCar(playerid, AccountInfo[playerid][pVehicle]);
					CreatePlayerCar(playerid, 474, colour1, colour2); GivePlayerMoney(playerid, -12999);
		     		format(string,sizeof(string), "[Mr.Wang]: Okay your brand new %s is around the back, please drive carefully and have a nice day.", car);
					SendClientMessage(playerid,COLOUR_HEADER,string);
				}
  			}
 			if(!strcmp(car, "Savannah", true,8))
			{
			 	if(level < 12){SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You do not have a high enough level."); return 1;}
				else if (money < 12499){SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You do not have enough money."); return 1;}
				else
				{
					DestroyPlayerCar(playerid, AccountInfo[playerid][pVehicle]);
					CreatePlayerCar(playerid, 567, colour1, colour2); GivePlayerMoney(playerid, -12499);
		     		format(string,sizeof(string), "[Mr.Wang]: Okay your brand new %s is around the back, please drive carefully and have a nice day.", car);
					SendClientMessage(playerid,COLOUR_HEADER,string);
				}
  			}
	}
	else if(PlayerToPoint(10.0, playerid, -1656.6205,1209.9940,7.2500))
	{
			if(!strcmp(car, "Flash",true, 5))
			{
		 		if(level < 11){SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You do not have a high enough level."); return 1;}
				else if (money < 9999){SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You do not have enough money."); return 1;}
				else
				{
					CreatePlayerCar(playerid, 565, colour1, colour2); GivePlayerMoney(playerid, -9999);
		     		format(string,sizeof(string), "[Otto]: Okay your brand new %s is around the back, please drive carefully and have a nice day.", car);
					SendClientMessage(playerid,COLOUR_HEADER,string);
				}
			}
   			if(!strcmp(car, "Stafford", true, 8))
			{
		 		if(level < 18){SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You do not have a high enough level."); return 1;}
				else if (money < 24999){SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You do not have enough money."); return 1; }
				else
				{
					DestroyPlayerCar(playerid, AccountInfo[playerid][pVehicle]);
					CreatePlayerCar(playerid, 580, colour1, colour2); GivePlayerMoney(playerid, -24999);
		     		format(string,sizeof(string), "[Otto]: Okay your brand new %s is around the back, please drive carefully and have a nice day.", car);
					SendClientMessage(playerid,COLOUR_HEADER,string);
	   			}
			}
 			if(!strcmp(car, "Sultan", true,6))
 			{
		 		if(level < 17){SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You do not have a high enough level."); return 1;}
				else if (money < 19999){SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You do not have enough money."); return 1;}
				else
				{
					DestroyPlayerCar(playerid, AccountInfo[playerid][pVehicle]);
					CreatePlayerCar(playerid, 560, colour1, colour2); GivePlayerMoney(playerid, -19999);
		     		format(string,sizeof(string), "[Otto]: Okay your brand new %s is around the back, please drive carefully and have a nice day.", car);
					SendClientMessage(playerid,COLOUR_HEADER,string);
				}
			}
		    if(!strcmp(car, "Sabre" , true,5))
		    {
			 	if(level < 16){SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You do not have a high enough level."); return 1;}
				else if(money < 17999){SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You do not have enough money."); return 1;}
				else
				{
					DestroyPlayerCar(playerid, AccountInfo[playerid][pVehicle]);
					CreatePlayerCar(playerid, 475, colour1, colour2); GivePlayerMoney(playerid, -17999);
		     		format(string,sizeof(string), "[Otto]: Okay your brand new %s is around the back, please drive carefully and have a nice day.", car);
					SendClientMessage(playerid,COLOUR_HEADER,string);
				}
			}
 			if(!strcmp(car, "Jester"  , true,6))
			{
			 	if(level < 20){SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You do not have a high enough level."); return 1;}
				else if (money < 22999){SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You do not have enough money."); return 1;}
				else
				{
					DestroyPlayerCar(playerid, AccountInfo[playerid][pVehicle]);
				 	CreatePlayerCar(playerid, 559, colour1, colour2); GivePlayerMoney(playerid, -22999);
		     		format(string,sizeof(string), "[Otto]: Okay your brand new %s is around the back, please drive carefully and have a nice day.", car);
					SendClientMessage(playerid,COLOUR_HEADER,string);
				}
			}
 			if(!strcmp(car, "Buffalo" , true,7))
			{
			 	if(level < 19){SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You do not have a high enough level."); return 1;}
				else if (money < 21999){SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You do not have enough money."); return 1;}
				else
				{
					DestroyPlayerCar(playerid, AccountInfo[playerid][pVehicle]);
					CreatePlayerCar(playerid, 402, colour1, colour2); GivePlayerMoney(playerid, -21999);
		     		format(string,sizeof(string), "[Otto]: Okay your brand new %s is around the back, please drive carefully and have a nice day.", car);
					SendClientMessage(playerid,COLOUR_HEADER,string);
				}
			}
 			if(!strcmp(car, "Infernus", true,8))
			{
			 	if(level < 23){SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: [Error]: You You do not have a high enough level."); return 1;}
				else if (money < 24999){SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You do not have enough money."); return 1;}
				else
				{
					DestroyPlayerCar(playerid, AccountInfo[playerid][pVehicle]);
					CreatePlayerCar(playerid, 411, colour1, colour2); GivePlayerMoney(playerid, -24999);
		     		format(string,sizeof(string), "[Otto]: Okay your brand new %s is around the back, please drive carefully and have a nice day.", car);
					SendClientMessage(playerid,COLOUR_HEADER,string);
				}
			}
			if(!strcmp(car, "ZR-350" , true,7))
			{
			 	if(level < 25){SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You do not have a high enough level."); return 1;}
				else if (money < 29999){SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You do not have enough money."); return 1;}
				else
				{
					DestroyPlayerCar(playerid, AccountInfo[playerid][pVehicle]);
					CreatePlayerCar(playerid, 458, colour1, colour2); GivePlayerMoney(playerid, -29999);
		     		format(string,sizeof(string), "[Otto]: Okay your brand new %s is around the back, please drive carefully and have a nice day.", car);
					SendClientMessage(playerid,COLOUR_HEADER,string);
				}
  			}
	}
	else
	{
	    SendClientMessage(playerid,COLOUR_ADMINRED,"[Error]: You arent a car dealership,");
	}
	return 1;
}
dcmd_house(playerid,params[])
{
	#pragma unused params
	if(IsPlayerConnected(playerid))
	{
		new tmp[64];
		if(sscanf(params, "s", tmp)) return SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /house (upgrade/downgrade)");
		else if(AccountInfo[playerid][AdminLevel] < 5) return SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You arent a high enough admin level.");
		SendFormattedMessage(playerid, COLOUR_WHITE, "Houses: 0[%d], 1[%d], 2[%d], 3[%d], 4[%d], 5[%d], 6[%d]", HousesLevels[0][1], HousesLevels[1][1], HousesLevels[2][1], HousesLevels[3][1], HousesLevels[4][1], HousesLevels[5][1], HousesLevels[6][1]);
		SendFormattedMessage(playerid, COLOUR_WHITE, "7[%d], 8[%d], 9[%d], 10[%d], 11[%d], 12[%d]", HousesLevels[7][1], HousesLevels[8][1], HousesLevels[9][1], HousesLevels[10][1], HousesLevels[11][1], HousesLevels[12][1]);
		if(strlen(tmp) == strlen("upgrade")){
			for(new h = 0; h <= MAX_HOUSES; h++){
			    if(PlayerToPoint(PTP_RADIUS, playerid, HouseInfo[h][hExitX], HouseInfo[h][hExitY], HouseInfo[h][hExitZ])){
					if(strcmp(HouseInfo[h][hName],GetName(playerid), false ) == 0){
					    if(HouseInfo[h][hLevel]+1 > 12) return SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You cannot set your house level above 12");
					    new Level = HousesLevels[HouseInfo[h][hLevel]+1][1];
					    SendFormattedMessage(playerid, COLOUR_WHITE, "[Builder]: It will cost you around $%d dollars for this upgrade.", Level);
					    HouseInfo[h][hLevel] = (HouseInfo[h][hLevel]+1); GivePlayerMoney(playerid, -Level);
						SavePlayerHouse(h);
	          		} else return SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You are not the owner of this house."); } }
		}
	    if(strlen(tmp) == strlen("downgrade")){
		    for(new h = 0; h <= MAX_HOUSES; h++){
			    if(PlayerToPoint(PTP_RADIUS, playerid, HouseInfo[h][hExitX], HouseInfo[h][hExitY], HouseInfo[h][hExitZ])){
					if(strcmp(HouseInfo[h][hName],GetName(playerid), false ) == 0){
					    if(HouseInfo[h][hLevel]-1 < 0) return SendClientMessage(playerid, COLOUR_WHITE, "You cannot set your house lvl below 0");
					    new Level = HousesLevels[HouseInfo[h][hLevel]-1][1];
					    SendFormattedMessage(playerid, COLOUR_WHITE, "[Scrap Man]: I'll give you $%d dollars for the materials.", Level);
					    HouseInfo[h][hLevel] = (HouseInfo[h][hLevel]-1); GivePlayerMoney(playerid, Level);
						SavePlayerHouse(h);
	          		} else return SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You are not the owner of this house."); } }
		}
	}
	return 1;
}
dcmd_lockhouse(playerid,params[])
{
	#pragma unused params
	if(IsPlayerConnected(playerid))
	{
		for(new h = 0; h <= MAX_HOUSES; h++)
		{
		    if(PlayerToPoint(PTP_RADIUS, playerid, HouseInfo[h][hExitX], HouseInfo[h][hExitY], HouseInfo[h][hExitZ]))
			{
     			 if(strcmp(HouseInfo[h][hName],GetName(playerid), false ) == 0)
				 {
     				if(HouseInfo[h][hLocked] == 1) return SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: Your door is already locked.");
				    HouseInfo[h][hLocked] = 1; SavePlayerHouse(h);
				    SendClientMessage(playerid, COLOUR_HEADER, "You lock your front door and put the keys in your pocket.");
                    return 1;
				 }
			  	 else return SendClientMessage(playerid, COLOUR_ADMINRED, "[House]: You are not the owner of this house.");
		    } } }
	return 1;
}
dcmd_unlockhouse(playerid,params[])
{
	#pragma unused params
	if(IsPlayerConnected(playerid))
	{
		for(new h = 0; h <= MAX_HOUSES; h++)
		{
		    if(PlayerToPoint(PTP_RADIUS, playerid, HouseInfo[h][hExitX], HouseInfo[h][hExitY], HouseInfo[h][hExitZ]))
			{
     			 if(strcmp(HouseInfo[h][hName],GetName(playerid), false ) == 0)
				 {
     			    if(HouseInfo[h][hLocked] == 0) return SendClientMessage(playerid, COLOUR_WHITE, "[Error]: Your door is already unlocked.");
				    HouseInfo[h][hLocked] = 0; SavePlayerHouse(h);
				    SendClientMessage(playerid, COLOUR_HEADER, "You take out your keys and unlock the front door.");
          		 }
			  	 else return SendClientMessage(playerid, COLOUR_ADMINRED, "[House]: You are not the owner of this house.");
		    } } }
	return 1;
}
dcmd_sellhouse(playerid,params[])
{
	#pragma unused params
	if(IsPlayerConnected(playerid))
	{
		new Sell;
		if(sscanf(params, "i", Sell)) return SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /sellhouse [sellprice]");
		if(Sell < 0 || Sell > 5000000) return SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You cannot sell a house for more than $5 million or less than $0 dollars.");
		for(new h = 0; h <= MAX_HOUSES; h++){
		    if(PlayerToPoint(PTP_RADIUS, playerid, HouseInfo[h][hExitX], HouseInfo[h][hExitY], HouseInfo[h][hExitZ])){
     			if(strcmp(HouseInfo[h][hName],GetName(playerid), false ) == 0){
	        		DestroyPickup(HouseInfo[h][hPickup]);
	   				HouseInfo[h][hPickup] = CreatePickup(1273, 23, HouseInfo[h][hExitX], HouseInfo[h][hExitY], HouseInfo[h][hExitZ]); // not bought
				    HouseInfo[h][hSellable] = 1; HouseInfo[h][hSell] = Sell; SavePlayerHouse(h);
          		} else return SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You do not own this house.");
		    } } }
	return 1;
}
dcmd_unsellhouse(playerid,params[])
{
	#pragma unused params
	if(IsPlayerConnected(playerid))
	{
		for(new h = 0; h <= MAX_HOUSES; h++){
		    if(PlayerToPoint(PTP_RADIUS, playerid, HouseInfo[h][hExitX], HouseInfo[h][hExitY], HouseInfo[h][hExitZ])){
     			if(strcmp(HouseInfo[h][hName],GetName(playerid), false ) == 0){
	        		DestroyPickup(HouseInfo[h][hPickup]);
		        	HouseInfo[h][hPickup] = CreatePickup(1272,23, HouseInfo[h][hExitX], HouseInfo[h][hExitY], HouseInfo[h][hExitZ]); // bought
				    HouseInfo[h][hSellable] = 0; SavePlayerHouse(h);
          		} else return SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You do not own this house.");
			} } }
	return true;
}
dcmd_createhouse(playerid,params[])
{
	#pragma unused params
	if(IsPlayerConnected(playerid))
	{
		//if(AccountInfo[playerid][pAdmin] < 10) return SendClientMessage(playerid,COLOUR_WHITE,"SERVER: Unknown command.");
		if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, COLOUR_ADMINRED, "[Fisher]: GTFO you arent an admin!");
		new Sell, lvl;
		if(sscanf(params, "ii", Sell, lvl)) return SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /createhouse [sellprice] [HouseLvl]");
		if(Sell < 0 || Sell > 5000000) return SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You cannot set the price for more than $5 million or less than $0 dollars.");
		if(lvl < 0 || lvl > 12) return SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You cannot create a house with a level that is below 0 or above 12.");
        new Float:x, Float:y, Float:z;
   		GetPlayerPos(playerid, x, y, z);
		new send[256],File:hFile=fopen("/Server Logs/HousePos.ini", io_append);
		format(send, sizeof(send), "%d %d %d\r\n", x, y, z);
		fwrite(hFile,send);
		fclose(hFile);
		CreatePlayerHouse(playerid, Sell, lvl); }
	return true;
}
dcmd_destroyhouse(playerid,params[])
{
	#pragma unused params
	if(IsPlayerConnected(playerid))
	{
		//if(AccountInfo[playerid][pAdmin] < 10) return SendClientMessage(playerid,COLOUR_WHITE,"SERVER: Unknown command.");
		if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, COLOUR_ADMINRED, "[Fisher]: GTFO Admin Command!");
	  	new houseid;
		if(sscanf(params, "i", houseid)) return SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /destroyhouse [houseid]");
		DestroyPlayerHouse(playerid, houseid);}
	return true;
}
dcmd_saveloc(playerid,params[])
{
    new sendername[MAX_PLAYER_NAME], string[256], vehicleid;
	if(sscanf(params, "s", string)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /saveloc [text here]");
	else if(IsPlayerInVehicle(playerid,vehicleid))
	{ SendClientMessage(playerid,COLOUR_ADMINRED, "You are in a vehicle get out and retype /saveloc [text here]");
	  RemovePlayerFromVehicle(playerid);
	}
	else
	{
	new Float:X,Float:Y,Float:Z;
	new playersname, Hours,Minutes, Seconds;
	GetPlayerName(playerid, sendername, sizeof(sendername));
	gettime(Hours,Minutes,Seconds);
	new send[256],File:hFile=fopen("/SaveLoc/saved.ini", io_append);
    GetPlayerPos(playerid,X,Y,Z);
	format(send, sizeof(send), "[%d:%d][Saved player]%s (%d): '%f,%f,%f' Info= %s\r\n", Hours, Minutes,playersname, playerid, X, Y, Z, string);
	fwrite(hFile,send);
	fclose(hFile);
	SendClientMessage(playerid, COLOUR_ADMINRED, "You Have Saved Location");
	}
	return 1;
 }
 dcmd_saveveh(playerid,params[])
 {
    new sendername[MAX_PLAYER_NAME], string[256], vehicleid;
	if (sscanf(params, "s", string)) SendClientMessage(playerid, COLOUR_ADMINRED, "[Usage]: /saveveh [text here]");
	//else if(!IsPlayerInVehicle(playerid,vehicleid)) SendClientMessage(playerid,COLOUR_ADMINRED, "You are not in a vehicle");
	else
 	{
	new Float:X,Float:Y,Float:Z;
	new playersname, Hours,Minutes, Seconds, vehicle;
	GetPlayerName(playerid, sendername, sizeof(sendername));
	gettime(Hours,Minutes,Seconds);
	new send[256],File:hFile=fopen("/SaveLoc/saved.ini", io_append);
	GetVehiclePos(vehicleid,X,Y,Z);
	vehicle = GetVehicleModel(vehicleid);
	format(send, sizeof(send), "[%d:%d][Saved Vehicle]%s (%d): '%f,%f,%f' Vehid= %i Info=%s\r\n", Hours, Minutes,playersname, playerid, X, Y, Z,vehicle,string);
	fwrite(hFile,send);
	fclose(hFile);
	SendClientMessage(playerid, COLOUR_ADMINRED, "You Have Saved Vehicle Location.");
	}
	return 1;
}
dcmd_changeweather(playerid,params[])
{
    #pragma unused params
    if(AccountInfo[playerid][AdminLevel] < 3)SendClientMessage(playerid, COLOUR_ADMINRED, "[Error]: You aren't a level 3+ Administrator.");
	else
	{
    	weatherchange();
        SendClientMessage(playerid, COLOUR_ADMINRED, "[Server]: You have changed weather");
	}
	return 1;
}
dcmd_tankers(playerid,params[])
{
    #pragma unused params
	SetPlayerPos(playerid,-1030.9763,-661.2069,32.0078);
	return 1;
}
//<============================================================================>
//<==============================[CHAT SYSTEMS]================================>
//<============================================================================>
public SendClientMessageToAdmins(color,string[],alevel)
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if (AccountInfo[i][AdminLevel] >= alevel)
			{
				SendClientMessage(i, color, string);
				printf("%s", string);
			}
		}
	}
	return 1;
}
//<==============================[Northside Chat]==============================>
public SendClientMessageToNorthside(color,string[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if (AccountInfo[i][pTeam] == 5)
			{
				SendClientMessage(i, color, string);
				printf("%s", string);
			}
		}
	}
	return 1;
}
//<==============================[The Lost Chat]===========================>
public SendClientMessageToTheLost(color,string[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if (AccountInfo[i][pTeam] == 3)
			{
				SendClientMessage(i, color, string);
				printf("%s", string);
			}
		}
	}
	return 1;
}
//<==============================[Forelli Chat]==================================>
public SendClientMessageToForelli(color,string[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if (AccountInfo[i][pTeam] == 2)
			{
				SendClientMessage(i, color, string);
				printf("%s", string);
			}
		}
	}
	return 1;
}
//<==============================[Gecko Chat]==================================>
public SendClientMessageToGecko(color,string[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if (AccountInfo[i][pTeam] == 4)
			{
				SendClientMessage(i, color, string);
				printf("%s", string);
			}
		}
	}
	return 1;
}
//<==============================[Police Radio]================================>
public SendClientMessageToPolice(color,string[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if (AccountInfo[i][pTeam] == 1)
			{
				SendClientMessage(i, color, string);
				printf("%s", string);
			}
		}
	}
	return 1;
}
//<==============================[Roadrunners Chat]============================>
public SendClientMessageToRoadRunners(color,string[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if (AccountInfo[i][pJob] == 1)
			{
				SendClientMessage(i, color, string);
				printf("%s", string);
			}
		}
	}
	return 1;
}
//<==============================[Pizza Place Chat]============================>
public SendClientMessageToPizzaPlace(color,string[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if (AccountInfo[i][pJob] == 2)
			{
				SendClientMessage(i, color, string);
				printf("%s", string);
			}
		}
	}
	return 1;
}
//<===============================[Pilots Chat]================================>
public SendClientMessageToPilots(color,string[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if (AccountInfo[i][pJob] == 3)
			{
				SendClientMessage(i, color, string);
				printf("%s", string);
			}
		}
	}
	return 1;
}
//<===============================[Pilots Chat]================================>
public SendClientMessageToTow(color,string[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if (AccountInfo[i][pJob] == 9)
			{
				SendClientMessage(i, color, string);
				printf("%s", string);
			}
		}
	}
	return 1;
}
//=============================================================================>
public SavePlayerHouse(houseid)
{
    new house[64]; format(house, sizeof(house), "/Houses/%d.dini.save", houseid);
    if(dini_Exists(house)){
        dini_Set(house, "Name", HouseInfo[houseid][hName]);
        dini_IntSet(house, "For_Sell", HouseInfo[houseid][hSellable]);
		dini_IntSet(house, "Sell_Price", HouseInfo[houseid][hSell]);
	 	dini_IntSet(house, "House_Level", HouseInfo[houseid][hLevel]);
       	dini_FloatSet(house, "Exit_Coord:X", HouseInfo[houseid][hExitX]);
       	dini_FloatSet(house, "Exit_Coord:Y", HouseInfo[houseid][hExitY]);
        dini_FloatSet(house, "Exit_Coord:Z", HouseInfo[houseid][hExitZ]);
       	dini_IntSet(house, "VirtualWorld", HouseInfo[houseid][hVirtualWorld]);
	  	dini_IntSet(house, "Status", HouseInfo[houseid][hLocked]);
	}
	return true;
}
//<============================================================================>
public ReadPlayerHouseData(playerid)
{
	new string[256], house[64];
	for(new h = 0; h <= MAX_HOUSES; h++){
		format(house, sizeof(house), "/Houses/%d.dini.save", h);
	    if(dini_Exists(house)){
			if(HouseInfo[h][hSellable] == 1){
	  			if(PlayerToPoint(PTP_RADIUS, playerid, HouseInfo[h][hExitX], HouseInfo[h][hExitY], HouseInfo[h][hExitZ])) {
					format(string, sizeof(string), "~g~] House for Sale ]~n~~w~Owner:~y~ %s~n~~w~Level:~r~ %d~n~~w~Sell Price:~r~ %d", HouseInfo[h][hName], HouseInfo[h][hLevel], HouseInfo[h][hSell]);
					GameTextForPlayer(playerid,string, 1500, 3);
				}
			} else if(HouseInfo[h][hSellable] == 0){
				if(PlayerToPoint(PTP_RADIUS, playerid, HouseInfo[h][hExitX], HouseInfo[h][hExitY], HouseInfo[h][hExitZ])) {
					format(string, sizeof(string), "~w~Owner:~y~ %s~n~~w~Level:~r~ %d", HouseInfo[h][hName], HouseInfo[h][hLevel]);
					GameTextForPlayer(playerid,string, 1500, 3);
				} } } }
}
//<============================================================================>
//<=========================[Junkbuster Admin Check]===========================>
//<============================================================================>
public IsPlayerAdminCall(playerid)
{
	if(AccountInfo[playerid][AdminLevel] >= 1)
	return 1;
	else
	return 0;
}
//<============================================================================>
//<================================[Gamemode Exit]=============================>
//<============================================================================>
public OnGameModeExit()
{
	for(new tempgate=0; tempgate<GateNum; tempgate++)
	{
	DestroyObject(GateObject[tempgate]);
	}
    for(new tempgate=0; tempgate<MiscObjNum; tempgate++)
	{
	DestroyObject(MiscObject[tempgate]);
	}
	KillTimer(Timer);
    KillTimer(HouseTimer[0]);
    KillTimer(PetrolUpdatetimer);
    KillTimer(stoppedvehtimer);
    KillTimer(checkgastimer);
	{
	print("\n---------------------------------------");
	print("   The Script Has Sucessfully Unloaded   ");
	print("        Feel free to adapt and use   	");
	print("           Just give me credit   	    ");
	print("            Fisher the Pious             ");
	print("------------------------------------------\n");
	}
	return 1;
}
//<============================================================================>
//<============================================================================>
