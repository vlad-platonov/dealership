#include <YSI_Coding\y_hooks>
hook OnGameModeInit() {
    //init static data vehicle
    dealership_vehicles[0][model] = 411;
    strcat(dealership_vehicles[0][vehicle_name], "Infernus");
    dealership_vehicles[0][price] = 5000;

    dealership_vehicles[1][model] = 522;
    strcat(dealership_vehicles[1][vehicle_name], "NRG-500");
    dealership_vehicles[1][price] = 3000;

    dealership_vehicles[2][model] = 560;
    strcat(dealership_vehicles[2][vehicle_name], "Sultan");
    dealership_vehicles[2][price] = 1000;

    return 1;
}


DialogCreate:BuyVehicle(playerid) {
    new str[64];
    new strline[192];
    for (new i = 0; i < COUNT_DEALERSHIP_VEHICLES; i++) {
        format(str, sizeof(str), "%s\t{33AA33}$%d\n", dealership_vehicles[i][vehicle_name], dealership_vehicles[i][price]);
        strcat(strline, str);
    }

    Dialog_Open(playerid, Dialog:BuyVehicle, DIALOG_STYLE_TABLIST, "{FF0000}Dealership",
                strline,
                "Select", "Close");
}

DialogResponse:BuyVehicle(playerid, response, listitem, inputtext[]) {
    if (!response) {
        SendClientMessage(playerid, -1, "This club only for OK guys!");
        return 1;
    }

    SendClientMessage(playerid, -1, sprintf("Your car is %s", dealership_vehicles[listitem][vehicle_name]));
    CreateVehicleForPlayer(playerid, listitem);
    return 1;
}

CreateVehicleForPlayer(playerid, listitem) {
    new vehicleid = GetVehicleID();
    new Float:pos_x, Float:pos_y, Float:pos_z;
    GetPlayerPos(playerid, pos_x, pos_y, pos_z);

    GetPlayerName(playerid, vehicle_info[vehicleid][owner_name]);
    vehicle_info[vehicleid][model] = dealership_vehicles[listitem][model];
    vehicle_info[vehicleid][x] = pos_x + 5.0;
    vehicle_info[vehicleid][y] = pos_y + 5.0;
    vehicle_info[vehicleid][z] = pos_z + 5.0;
    vehicle_info[vehicleid][fa] = 0.0;
    vehicle_info[vehicleid][interior] = 0;
    vehicle_info[vehicleid][world] = 0;

    vehicle_info[vehicleid][vehicle] = CreateVehicle(vehicle_info[vehicleid][model],
                                       vehicle_info[vehicleid][x], vehicle_info[vehicleid][y],
                                       vehicle_info[vehicleid][z], vehicle_info[vehicleid][fa],
                                       vehicle_info[vehicleid][color][0], vehicle_info[vehicleid][color][1], 600);
    CreateVehiclePlayer(playerid, vehicleid);
}