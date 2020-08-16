///ADMIN CMD LEVEL:1
CMD:spawncar(playerid, params[])
{
    if(!CheckAdmin(playerid))
        return SendErrorMessage(playerid, "�س�����������к�");

    new modelid, vehicleid = INVALID_VEHICLE_ID;
    new Float:x, Float:y, Float:z, Float:rotation;


    if(sscanf(params, "i", modelid))
        return SendUsageMessage(playerid, "/spawncar [����-�ʹ�]");

    if(modelid < 400 || modelid > 611)
        return SendErrorMessage(playerid, "�س����ʹ�ö�Դ��Ҵ");

    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, rotation);

    vehicleid = CreateVehicle(modelid, x, y, z, rotation, random(255), random(255), -1);

    if(vehicleid != INVALID_VEHICLE_ID)
    {
        VehicleData[vehicleid][VehicleAdminSpawn] = true;
    }

    new str[128];
    format(str, sizeof(str), "%s �ʡö %s �͡��", ReturnName(playerid), ReturnVehicleName(vehicleid));
    SendAdminMessage(2, str);
    PutPlayerInVehicle(playerid, vehicleid, 0);
    ToggleVehicleEngine(vehicleid, true);
    return 1;
}

CMD:setskin(playerid, params[])
{
    if(!CheckAdmin(playerid))
        return SendErrorMessage(playerid, "�س�����������к�");
    
    new playerb, skinid;

    if(sscanf(params, "ui", playerb, skinid))
        return SendUsageMessage(playerid, "/setskin [���ͺҧ��ǹ/�ʹ�] [�ʹ�-����Ф�]");

    if(!IsPlayerConnected(playerb))
        return SendErrorMessage(playerid, "��������������������׿�����");

    if(PlayerLogin[playerb] == false)
        return SendErrorMessage(playerid, "�����蹡��ѧ�������к�");

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
            return SendUsageMessage(playerid,"/despawncar [�ʹ�-ö]");

        
        if(VehicleData[getvehid][VehicleAdminSpawn] != true)
            return SendErrorMessage(playerid, "ö�ѹ��������ö�����ö �ʡ�ͧ�������к�");

        
        ResetVehicle(getvehid);
        DestroyVehicle(getvehid);
        return 1;
    }
    else
    {
        if(!IsValidVehicle(vehicleid))
           return SendErrorMessage(playerid, "������ʹ�ö����ͧ���");

        if(VehicleData[vehicleid][VehicleAdminSpawn] != true)
            return SendErrorMessage(playerid, "ö�ѹ��������ö�����ö �ʡ�ͧ�������к�");
        
        ResetVehicle(vehicleid);
        DestroyVehicle(vehicleid);
    }
    return 1;
}
///ADMIN CMD LEVEL:1