#include <a_samp>
#include <a_players>
#include <Streamer>
#define cec_auto
#include <cec>
#include <zcmd>
#include <easyDialog>
#include <a_mysql>
#include <sscanf2>


#define YSI_YES_HEAP_MALLOC
#define YSI_NO_OPTIMISATION_MESSAGE
#define YSI_NO_MODE_CACHE
#define YSI_NO_VERSION_CHECK
#include <YSI_Coding\y_timers>
#include <YSI_Coding\y_hooks>
#include <YSI_Coding\y_va>

/*-----------------------DEFINE-----------------*/
#include "include/define/define.pwn"
#include "include/define/color.pwn"
/*-----------------------DEFINE-----------------*/

/*-----------------------ENTITY-----------------*/
#include "include/entity/Player.pwn"
#include "include/entity/Vehicle.pwn"
/*-----------------------ENTITY-----------------*/


/*-----------------------SQL-----------------*/
#include "include/SQL/database.pwn"
#include "include/SQL/saveplayer.pwn"
/*-----------------------SQL-----------------*/

/*-----------------------FUNCTION-----------------*/
#include "include/function/fun_player.pwn"
#include "include/function/fun_SendMsg.pwn"
#include "include/function/fun_vehicle.pwn"
/*-----------------------FUNCTION-----------------*/

/*-----------------------CHARACTER-----------------*/
#include "include/character/character.pwn"
/*-----------------------CHARACTER-----------------*/

/*-----------------------COMMAND-----------------*/
#include "include/command/playercmd.pwn"
#include "include/command/admincmd.pwn"
/*-----------------------COMMAND-----------------*/





main()
{
	print("\n----------------------------------");
	print("  SAMP OF TRY\n");
	print("  สคลิปต์นี้เป็นลิขสิทธิ์ของ Backerss\n");
	print("  หากท่านจะนำสคลิปต์นี้ไปศึกษาใส่ระบบเพื่มเติมต่อ");
	print("  ท่านจำเป็นต้องรับข้อเสนอของเรา หากท่านไม่ยอมรับ");
	print("  กรุณาอย่าใช้สคลิปต์นี้ต่อ หากใช้อาจมีความผิดได้");
	print("  1.ห้ามลบลายน้ำนี้โดยเด็ดขาด");
	print("  2.ห้ามนำไปจำหารายได้ทุกวิถีทาง");
	print("    ยกเว้นในกรณีที่ท่านสร้างระบบเอง");
	print("  3.หากมีข้อสงสัยด้านสคลิปสามารถสอบถามได้ที่ Backerss โดยตรง");
	print("----------------------------------\n");
}


public OnPlayerConnect(playerid)
{	
	SendClientMessageEx(playerid, -1, "ยินดีตอนรับ: %s",ReturnName(playerid));

	PlayerLogin[playerid] = false;
	SetupPlayerForClassSelection(playerid);

	new check[128];
	mysql_format(SQLDB, check, sizeof(check), "SELECT * FROM `account` WHERE pName = '%s'",ReturnName(playerid));
	mysql_tquery(SQLDB,check,"CheckLogin","i",playerid);

	return 1;
}

public OnPlayerSpawn(playerid)
{
	if(PlayerLogin[playerid] == false)
	{
		new str[128];
		format(str, sizeof(str), "[%d] %s ไม่ได้ทำการเข้าสู่ระบบ!! (ถูกเตะออกจากเซืฟเวอร์เรียบร้อยแล้ว)", playerid,ReturnName(playerid));
		SendAdminMessage(99,str);
		SendClientMessage(playerid, COLOR_RED, "เตือน!!: คุณยังไม่ได้ทำการเข้าสู่ระบบ");
		return KickEx(playerid);
	}

	SetPlayerSkin(playerid, PlayerData[playerid][pSkin]);


	switch(PlayerData[playerid][pSpawnPoint])
	{
		case DEFAULT_PLAYER_SPAWN:
		{
			SetPlayerInterior(playerid,0);
			SetPlayerPos(playerid, -2027.7334,-42.4531,38.8047);
			SetPlayerFacingAngle(playerid, 194.3053);
			SetPlayerColor(playerid, 0x0D7304FF);
		}
		case HOUSE_PLAYER_SPAWN:
		{
			return 1;
		}
		case FACTION_PLAYER_SPAWN:
		{
			return 1;
		}
	}
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	if(PlayerLogin[playerid] == false)
		return 1;

	saveplayer(playerid);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
   	return 1;
}

stock SetupPlayerForClassSelection(playerid)
{
	TogglePlayerSpectating(playerid, 1);
	SetPlayerPos(playerid,1965.1812,-39.5780,63.8755);
	SetPlayerFacingAngle(playerid, 125.0002);
	SetPlayerCameraPos(playerid,1965.1812,-39.5780,63.8755);
	SetPlayerCameraLookAt(playerid,1965.1812,-39.5780,63.8755);
}

public OnGameModeInit()
{
	//AddPlayerClass(265,1958.3783,1343.1572,15.3746,270.1425,0,0,0,0,-1,-1)

	return 1;
}
