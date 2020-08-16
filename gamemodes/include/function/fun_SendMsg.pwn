#define SendUsageMessage(%0,%1) \
	SendClientMessageEx(%0, COLOR_WHITE, "USAGE:{FFFFFF} "%1) 
	
#define SendErrorMessage(%0,%1) \
	SendClientMessageEx(%0, COLOR_RED, "ERROR:{FFFFFF} "%1)

#define SendServerMessage(%0,%1) \
	SendClientMessageEx(%0, COLOR_ACTION, "SERVER:{FFFFFF} "%1) 

stock SendClientMessageEx(playerid, colour, const fmat[],  va_args<>)
{
	new
		str[145];
	va_format(str, sizeof (str), fmat, va_start<3>);
	return SendClientMessage(playerid, colour, str);
}

stock SendClientMessageToAllEx(colour, const fmat[], va_args<>)
{
	new
		str[145];
	va_format(str, sizeof (str), fmat, va_start<2>);
	return SendClientMessageToAll(colour, str);
}

stock SendAdminMessage(level, const str[])
{
	new 
		newString[128]
	;
	
	format(newString, sizeof(newString), "{F44336}Admin System(%i): {FFFF33}%s", level, str);
	
	foreach(new i : Player)
	{
		if(PlayerData[i][pAdmin])
		{
			SendClientMessage(i, -1, newString);
		}
	}
	return 1;
}
