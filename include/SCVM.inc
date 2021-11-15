/********************************************
*************** Include *********************
****** Simple Check Vehicle Model ***********
*************** by Schwan ********************
*********************************************/
#include <a_samp>
#if defined SCVM_loaded
#endinput
#endif

#define SCVM_loaded

/*
 IsPlayerInAirplane(playerid);
 IsPlayerInHelicopter(playerid);
 IsPlayerInBike(playerid);
 IsPlayerInVelo(playerid);
 IsPlayerInBoat(playerid);
 IsPlayerInCar(playerid);
 IsPlayerInRCCar(playerid);
 IsPlayerInTaxiCar(playerid);
 IsPlayerInCopCar(playerid);
 IsPlayerInAmbulCar(playerid);
 IsPlayerInFireTruck(playerid);
 IsPlayerInBusCar(playerid);
 */


stock IsPlayerInAirplanes(playerid)                    // Самолёты
{
    #define MAX_AIRPLANES 11
    new Airplanes[MAX_AIRPLANES] =
    {
        592,577,511,512,593,520,553,476,519,460,
        513
    };
    new vehicleid = GetPlayerVehicleID(playerid);
    if(IsPlayerInVehicle(playerid,vehicleid))
    {
                for(new i = 0; i < MAX_AIRPLANES; i++)
                {
                    if(GetVehicleModel(vehicleid) == Airplanes[i])
                    {
                        return true;
                    }
                }
    }
    return false;
}

stock IsPlayerInHelicopter(playerid)                // Вертолёты
{
    #define MAX_HELICOPT 9
    new Helicopt[MAX_HELICOPT] =
    {
        548,425,417,487,488,497,563,447,469
    };
    new vehicleid = GetPlayerVehicleID(playerid);
    if(IsPlayerInVehicle(playerid,vehicleid))
    {
                for(new i = 0; i < MAX_HELICOPT; i++)
                {
                    if(GetVehicleModel(vehicleid) == Helicopt[i])
                    {
                        return true;
                    }
                }
    }
    return false;
}

stock IsPlayerInBike(playerid)                // Мото+Велики 
{
    #define MAX_BIKES 10
    new Bike[MAX_BIKES] =
    {
        581,462,521,463,522,461,448,471,468,586
    };
    new vehicleid = GetPlayerVehicleID(playerid);
    if(IsPlayerInVehicle(playerid,vehicleid))
    {
                for(new i = 0; i < MAX_BIKES; i++)
                {
                    if(GetVehicleModel(vehicleid) == Bike[i])
                    {
                        return true;
                    }
                }
    }
    return false;
}

stock IsPlayerInCar(playerid)                // Машины Convertibles  Industrial Lowriders Off Road Saloons Sport Vehicles Station Wagons
{
    #define MAX_CARS 125
    new Cars[MAX_CARS] =
    {
        480,533,439,555,499,422,482,498,609,524,578,455,403,414,582,443,514,413,515,440,
		543,605,459,531,408,552,478,456,554,/* Lowriders: */536,575,534,567,535,566,576,412,
		/* Off road: */568,424,573,579,400,500,444,556,557,470,489,505,495,/* Saloons */445,504,401, 
		518,527,542,507,562,585,419,526,604,466,492,474,546,517,410,551,516,467,600,426,436,547,405,580, 
		560,550,549,540,491,529,421, /*Sport Vehicles: */602,429,496,402,541,415,589,587,585,594,502,503,411, 
		559,603,475,506,451,558,477,/*Station Wagons: */418,404,479,458,561,/* uniq veh: */409,525,583,539,442,423,
		572,571,598,545,434,508,483,457,485,433
    };
    new vehicleid = GetPlayerVehicleID(playerid);
    if(IsPlayerInVehicle(playerid,vehicleid))
    {
                for(new i = 0; i < MAX_CARS; i++)
                {
                    if(GetVehicleModel(vehicleid) == Cars[i])
                    {
                        return true;
                    }
                }
    }
    return false;
}

stock IsPlayerInBusCar(playerid)   // Автобусы
{
    new BusCar[] ={431,437};
    new vehicleid = GetPlayerVehicleID(playerid);
    if(IsPlayerInVehicle(playerid,vehicleid))
    {
                for(new i = 0; i < sizeof(BusCar); i++)
                {
                    if(GetVehicleModel(vehicleid) == BusCar[i])
                    {
                        return true;
                    }
                }
    }
    return false;
}

stock IsPlayerInFireTruck(playerid)   // пожарная машина
{
    new FireTruck[] ={407,544};
    new vehicleid = GetPlayerVehicleID(playerid);
    if(IsPlayerInVehicle(playerid,vehicleid))
    {
                for(new i = 0; i < sizeof(FireTruck); i++)
                {
                    if(GetVehicleModel(vehicleid) == FireTruck[i])
                    {
                        return true;
                    }
                }
    }
    return false;
}

stock IsPlayerInAmbulCar(playerid)                // Машина скорой помощи
{

    new Ambulance[] ={416};
    new vehicleid = GetPlayerVehicleID(playerid);
    if(IsPlayerInVehicle(playerid,vehicleid))
    {
                for(new i = 0; i < sizeof(Ambulance) ; i++)
                {
                    if(GetVehicleModel(vehicleid) == Ambulance[i])
                    {
                        return true;
                    }
                }
    }
    return false;
}

stock IsPlayerInTaxiCar(playerid)                // Такси
{
    new TaxiCar[TAXICAR] = {420,438};
    new vehicleid = GetPlayerVehicleID(playerid);
    if(IsPlayerInVehicle(playerid,vehicleid))
    {
                for(new i = 0; i < sizeof(TaxiCar); i++)
                {
                    if(GetVehicleModel(vehicleid) == TaxiCar[i])
                    {
                        return true;
                    }
                }
    }
    return false;
}

stock IsPlayerInCopCar(playerid)                // Коп. машины
{
    #define MAX_COPCAR 10
    new CopCar[] ={601,432,599,597,598,596,528,490,427,523};
    new vehicleid = GetPlayerVehicleID(playerid);
    if(IsPlayerInVehicle(playerid,vehicleid))
    {
                for(new i = 0; i < sizeof(CopCar); i++)
                {
                    if(GetVehicleModel(vehicleid) == CopCar[i])
                    {
                        return true;
                    }
                }
    }
    return false;
}

stock IsPlayerInBoat(playerid)                // Лодки Катера Яхты.
{
    #define MAX_BOATS 10
    new Boats[MAX_BOATS ] =
    {
        472,473,493,595,484,430,453,452,446,454
    };
    new vehicleid = GetPlayerVehicleID(playerid);
    if(IsPlayerInVehicle(playerid,vehicleid))
    {
                for(new i = 0; i < MAX_BOATS ; i++)
                {
                    if(GetVehicleModel(vehicleid) == Boats[i])
                    {
                        return true;
                    }
                }
    }
    return false;
}

stock IsPlayerInRCCar(playerid)                // RC CAR.
{

    new RC[] = {441,464,456,501,564,594};
    new vehicleid = GetPlayerVehicleID(playerid);
    if(IsPlayerInVehicle(playerid,vehicleid))
    {
                for(new i = 0; i < sizeof(RC); i++)
                {
                    if(GetVehicleModel(vehicleid) == RC[i])
                    {
                        return true;
                    }
                }
    }
    return false;
}

stock IsPlayerInVelo(playerid)                // Велосипеды
{
    new Velo[] ={509,481,510};
    new vehicleid = GetPlayerVehicleID(playerid);
    if(IsPlayerInVehicle(playerid,vehicleid))
    {
                for(new i = 0; i < sizeof(Velo) ; i++)
                {
                    if(GetVehicleModel(vehicleid) == Velo[i])
                    {
                        return true;
                    }
                }
    }
    return false;
}
// Америкосы мудланы.