#include "\a3\ui_f\hpp\definedikcodes.inc"


if (!isDedicated) then {
["Toggle Performance Enhance", "Toggle_Performance", "Toggle Performance Enhance", {_this call A3PE_fnc_toggle}, {}, [DIK_U, [false, false, false]],false,0,true] call cba_fnc_addKeybind;
["ForceRenderDistance","SLIDER",["Force Render Range in Meters","Range at which units are force rendered, units in this range will be rendered even if you cannot see them."],"Arma 3 Performance Settings",[0, 100, 10, 0],nil,{},false] call CBA_fnc_addSetting;

_version = 1.7;
player setVariable ["A3PE_Enabled", false, [2,clientOwner]];
player setVariable ["A3PE_ViewDistance", viewDistance, [2,clientOwner]];
player setVariable ["A3PE_ZeusCameraPos", (getPosASL curatorCamera), [2,clientOwner]];
player setVariable ["A3PE_IsConnectedUav", UAVControl (getConnectedUAV player), [2,clientOwner]];
player setVariable ["A3PE_ShownUAVFeed", shownUAVFeed, [2,clientOwner]];
player setVariable ["A3PE_ForceRenderDistance", ForceRenderDistance, [2,clientOwner]];
player setVariable ["A3PE_PlayerVersion", _version, [2,clientOwner]];
};

//change to is dedicated later
if (isDedicated) then {
[] spawn {
ServerVersion = 1.7;
while {true} do {
{
_PlayerVersion = _x getVariable ["A3PE_PlayerVersion", 1];
_PlayerEnabled = _x getVariable ["A3PE_Enabled", false];
if (_PlayerEnabled == true && {_PlayerVersion == ServerVersion}) then {
[_x] call A3PE_fnc_hide;
};
} forEach allPlayers;
}; // onEachFrame
};
}; // isServer


/*  THIS CODE IS 2x SLOWER
//change to is dedicated later
if (isServer) then {
ServerVersion = 1.7;
onEachFrame {
{
_PlayerVersion = _x getVariable ["A3PE_PlayerVersion", 1];
_PlayerEnabled = _x getVariable ["A3PE_Enabled", false];
if (_PlayerEnabled == true && {_PlayerVersion == ServerVersion}) then {
[_x] call A3PE_fnc_hide;
};
} forEach allPlayers;
}; // onEachFrame
}; // isServer
