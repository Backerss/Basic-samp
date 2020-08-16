#include <YSI_Coding\y_hooks>


forward CheckLogin(playerid);
public CheckLogin(playerid)
{
    new rows;
	cache_get_value_index_int(0, 0, rows);
	SetupPlayerForClassSelection(playerid);

    if(rows)
        return Dialog_Show(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Login Now!", "Enter you password:", "??????", "??????");
    else
        return Dialog_Show(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "Register Now!", "Enter you password:", "??????", "??????");
}

Dialog:DIALOG_REGISTER(playerid, response, listitem, inputtext[])
{
	if(!response)
		return KickEx(playerid);

    if(strlen(inputtext) < 8 || strlen(inputtext) > 20)
		return Dialog_Show(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "Register Now!", "Enter New Password More than 3 characters:", "??????", "??????");

	SendClientMessageEx(playerid, -1, "{33FFCC}??????????? {F4511E}%s {33FFCC}?????????????????????????",ReturnName(playerid));
	SetupPlayerForClassSelection(playerid);
	new insert[500];
	mysql_format(SQLDB, insert, sizeof(insert), "INSERT INTO `account` (`pName`,`pSkin`,`pCash`,`pLevel`,`pPassword`) VALUES ('%e',%d,%d,%d,sha1('%e'))",ReturnName(playerid),random(300),5000,1,inputtext);
	mysql_tquery(SQLDB, insert, "CheckAccount", "i",playerid);
	return 1;
}

forward CheckAccount(playerid);
public CheckAccount(playerid)
{
	new check[128];
	mysql_format(SQLDB, check, sizeof(check), "SELECT * FROM `account` WHERE pName = '%s'",ReturnName(playerid));
	mysql_tquery(SQLDB,check,"CheckLogin","i",playerid);
	return 1;
}

Dialog:DIALOG_LOGIN(playerid, response, listitem, inputtext[])
{
	if(!response)
		return KickEx(playerid);
	new check_pass[6000];
	
	mysql_format(SQLDB, check_pass, sizeof(check_pass), "SELECT * FROM `account` WHERE `pName` = '%s' AND `pPassword` = sha1('%e')",ReturnName(playerid),inputtext);
	mysql_tquery(SQLDB, check_pass, "CheckPlayer", "i", playerid);
	return 1;
}

forward CheckPlayer(playerid);
public CheckPlayer(playerid)
{
	if(!cache_num_rows())
	{
		SetupPlayerForClassSelection(playerid);
		Dialog_Show(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Error Login!!", "Enter you password:", "??????", "??????");
		return 1;
	}
	else
	{
		cache_get_value_name_int(0, "ID", PlayerData[playerid][pDBID]);
		cache_get_value_name(0,"pName",PlayerData[playerid][pName],90);
		cache_get_value_name_int(0,"pSkin",PlayerData[playerid][pSkin]);

		cache_get_value_name_int(0,"pCash",PlayerData[playerid][pCash]);
		cache_get_value_name_int(0,"pLevel",PlayerData[playerid][pLevel]);

		cache_get_value_name_int(0,"pAdmin",PlayerData[playerid][pAdmin]);
		cache_get_value_name_int(0,"pSpawnPoint",PlayerData[playerid][pSpawnPoint]);
		cache_get_value_name_int(0,"pSpawnPointHouse",PlayerData[playerid][pSpawnPointHouse]);

		cache_get_value_name_int(0,"pFaction",PlayerData[playerid][pFaction]);
		cache_get_value_name_int(0,"pRanks",PlayerData[playerid][pRanks]);

		return LoadPlayer(playerid);
	}
}


stock LoadPlayer(playerid)
{
	/*???????????????????????*/
	SendClientMessageToAllEx(-1, "{D35400}??????????? {27AE60}%s {D35400}??????????????????? ??????", ReturnName(playerid));
	/*???????????????????????*/

	PlayerLogin[playerid] = true;
	SetSpawnInfo(playerid, NO_TEAM, 1, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 0, 0);
	TogglePlayerSpectating(playerid, false);


	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid, PlayerData[playerid][pCash]);
	SetPlayerScore(playerid, PlayerData[playerid][pLevel]);
	if(PlayerData[playerid][pAdmin])
	{
		SendClientMessageEx(playerid, -1, "{FF0000}ADMIN{FAFAFA}: {43A047}??????????????????????????????????? ????? {FFEB3B}%d", PlayerData[playerid][pAdmin]);
	}

	SpawnPlayer(playerid);
	//SetPlayerTeam(playerid, 1);
	return 1;
}