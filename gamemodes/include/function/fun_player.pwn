stock ReturnName(playerid) {
  new name[255];
  GetPlayerName(playerid, name, 255);
  return name;
}

stock KickEx(playerid)
{
	return SetTimerEx("KickTimer", 100, false, "i", playerid);
}

forward KickTimer(playerid);
public KickTimer(playerid)
{
  Kick(playerid);
  return 1;
}


stock ResetPlayer(playerid)
{
  PlayerData[playerid][pDBID] = 0;
	PlayerData[playerid][pName] = 0;
	PlayerData[playerid][pCash] = 0;
	PlayerData[playerid][pLevel] = 0;
	PlayerData[playerid][pPassword] = 0;

  PlayerData[playerid][pAdmin] = 0;
  PlayerData[playerid][pSpawnPoint] = 0;
  PlayerData[playerid][pFaction] = 0;
  PlayerData[playerid][pRanks] = 0;
  PlayerData[playerid][pSkin] = 0;

  return 1;
}

stock CheckAdmin(playerid)
{
  if(!PlayerData[playerid][pAdmin])
    return 0;

  else return 1;

}

stock CheckAdminLEVEL2(playerid)
{
  if(PlayerData[playerid][pAdmin] < 2)
    return 0;

  else return 1;
  
}

stock CheckAdminDev(playerid)
{
  if(PlayerData[playerid][pAdmin] < 3)
    return 0;

  else return 1;
  
}

stock GiveMoney(playerid, amount)
{
	PlayerData[playerid][pCash] += amount;
	GivePlayerMoney(playerid, amount);
	return 1;
}