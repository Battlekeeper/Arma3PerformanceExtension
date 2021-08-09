#include "\a3\ui_f\hpp\definedikcodes.inc"

["ForceRenderDistance","SLIDER",["Force Render Range in Meters","Range at which units are force rendered, units in this range will be rendered even if you cannot see them."],["Arma 3 Performance Settings","Arma 3 Performance Settings"],[0, 500, 10, 0],0,{},false] call CBA_fnc_addSetting;
["EnablePlayerHide","CHECKBOX",["Enable the Hiding of players","Enable the Hiding of players"],["Arma 3 Performance Settings","Arma 3 Performance Settings"],false,0,{},false] call CBA_fnc_addSetting;


["HigherQualityAI","CHECKBOX",["Enable Lower Latency For AI","Enables extra calculations to decrease latency when turning a corner, can decrease server FPS"],["Arma 3 Performance Settings","Quality Settings - May Affect Server FPS"],false,1,{},false] call CBA_fnc_addSetting;
["HigherQualityDead","CHECKBOX",["Enable Lower Latency For Dead Bodies","Enables extra calculations to decrease latency when turning a corner, can decrease server FPS"],["Arma 3 Performance Settings","Quality Settings - May Affect Server FPS"],false,1,{},false] call CBA_fnc_addSetting;

if (!isDedicated) then {

  ["Toggle Performance Enhance", "Toggle_Performance", "Toggle Performance Enhance", {_this call A3PE_fnc_toggle}, {}, [DIK_U, [false, false, false]],false,0,true] call cba_fnc_addKeybind;
  player setVariable ["A3PE_Enabled", false, [2,clientOwner]];
  player setVariable ["A3PE_ViewDistance", viewDistance, [2,clientOwner]];
  player setVariable ["A3PE_ZeusCameraPos", (getPosASL curatorCamera), [2,clientOwner]];
  player setVariable ["A3PE_IsConnectedUav", UAVControl (getConnectedUAV player), [2,clientOwner]];
  player setVariable ["A3PE_ShownUAVFeed", shownUAVFeed, [2,clientOwner]];
  player setVariable ["A3PE_ForceRenderDistance", ForceRenderDistance, [2,clientOwner]];
  player setVariable ["A3PE_HigherQualityAI", HigherQualityAI, [2,clientOwner]];
  player setVariable ["A3PE_HigherQualityDead", HigherQualityDead, [2,clientOwner]];
  player setVariable ["A3PE_EnablePlayerHide", EnablePlayerHide, [2,clientOwner]];
};


if (isServer) then {
  [] spawn {
    while {true} do {
      _allUnits = allUnits;
      _allDeadMen = allDeadMen;
      _allPlayers = allPlayers;
      {
        _PlayerEnabled = _x getVariable ["A3PE_Enabled", false];
        if (_PlayerEnabled == true) then {
          [_x,_allUnits,_allDeadMen,_allPlayers] call A3PE_fnc_hideServer;
        };
      } forEach allPlayers;
    }; // While Loop
  }; // Spawn
}; // isServer
