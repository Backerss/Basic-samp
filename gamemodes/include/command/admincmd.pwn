///ADMIN CMD LEVEL:1
CMD:spawncar(playerid, params[])
{
    if(!CheckAdmin(playerid))
        return SendErrorMessage(playerid, "คุณไม่ใช่ผู้ดูแลระบบ");

    new modelid, vehicleid = INVALID_VEHICLE_ID;
    new Float:x, Float:y, Float:z, Float:rotation;


    if(sscanf(params, "i", modelid))
        return SendUsageMessage(playerid, "/spawncar [โมเดล-ไอดี]");

    if(modelid < 400 || modelid > 611)
        return SendErrorMessage(playerid, "คุณใส่ไอดีรถผิดพลาด");

    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, rotation);

    vehicleid = CreateVehicle(modelid, x, y, z, rotation, random(255), random(255), -1);

    if(vehicleid != INVALID_VEHICLE_ID)
    {
        VehicleData[vehicleid][VehicleAdminSpawn] = true;
    }

    new str[128];
    format(str, sizeof(str), "%s เสกรถ %s ออกมา", ReturnName(playerid), ReturnVehicleName(vehicleid));
    SendAdminMessage(2, str);
    PutPlayerInVehicle(playerid, vehicleid, 0);
    ToggleVehicleEngine(vehicleid, true);
    return 1;
}

CMD:setskin(playerid, params[])
{
    if(!CheckAdmin(playerid))
        return SendErrorMessage(playerid, "คุณไม่ใช่ผู้ดูแลระบบ");
    
    new playerb, skinid;

    if(sscanf(params, "ui", playerb, skinid))
        return SendUsageMessage(playerid, "/setskin [ชื่อบางส่วน/ไอดี] [ไอดี-ตัวละคร]");

    if(!IsPlayerConnected(playerb))
        return SendErrorMessage(playerid, "ผู้เล่นไม่ได้อยู่ภายในเซืฟเวอร์");

    if(PlayerLogin[playerb] == false)
        return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ");

    SetPlayerSkin(playerb, skinid);
    PlayerData[playerb][pSkin] = skinid;
    saveplayer(playerb);

    return 1;
}

CMD:despawncar(playerid, params[])
{
    new vehicleid;

    if(sscanf(params,"d(-1)",vehicleid))
    {
        new getvehid = GetPlayerVehicleID(playerid);

        if(getvehid == 0)
            return SendUsageMessage(playerid,"/despawncar [ไอดี-รถ]");

        
        if(VehicleData[getvehid][VehicleAdminSpawn] != true)
            return SendErrorMessage(playerid, "รถคันนี้ไม่ใช้รถที่เป็นรถ เสกของผู้ดูแลระบบ");

        
        ResetVehicle(getvehid);
        DestroyVehicle(getvehid);
        return 1;
    }
    else
    {
        if(!IsValidVehicle(vehicleid))
           return SendErrorMessage(playerid, "ไม่มีไอดีรถที่ต้องการ");

        if(VehicleData[vehicleid][VehicleAdminSpawn] != true)
            return SendErrorMessage(playerid, "รถคันนี้ไม่ใช้รถที่เป็นรถ เสกของผู้ดูแลระบบ");
        
        ResetVehicle(vehicleid);
        DestroyVehicle(vehicleid);
    }
    return 1;
}
///ADMIN CMD LEVEL:1