#include <sourcemod>

public Plugin:myinfo =
{
  name = "Doublemix Assistant",
  author = "Underyx",
  description = "A plugin for overseeing doublemixes",
  version = "0",
  url = "https://github.com/Underyx/doublemix-assistant/"
};

public OnPluginStart()
{
  RegConsoleCmd("join", Show_JoinMenu);
}

public JoinMenu(Handle:menu, MenuAction:action, param1, param2)
{
  if (action == MenuAction_Select)
  {
    new String:info[32];
    new bool:found = GetMenuItem(menu, param2, info, sizeof(info));
    PrintToConsole(param1, "You selected item: %d (found? %d info: %s)", param2, found, info);
  }

  else if (action == MenuAction_Cancel)
  {
    PrintToServer("Client %d's menu was cancelled.  Reason: %d", param1, param2);
  }

  else if (action == MenuAction_End)
  {
    CloseHandle(menu);
  }
}

public Action:Show_JoinMenu(client, args)
{
  for (new i=1;i<=g_iArenaCount;i++)
  new Handle:menu = CreateMenu(JoinMenu);
  SetMenuTitle(menu, "What class do you want to play as?");
  AddMenuItem(menu, "scout", "Scout");
  AddMenuItem(menu, "soldier", "Soldier");
  AddMenuItem(menu, "demoman", "Demoman");
  AddMenuItem(menu, "medic", "Medic");
  SetMenuExitButton(menu, false);
  DisplayMenu(menu, client, 20);

  return Plugin_Handled;
}
