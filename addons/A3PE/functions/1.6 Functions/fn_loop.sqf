params ["_unitarray","_player"];
_onoff = (missionNamespace getVariable [("A3PE"+(str (getPlayerUID _player))), false]) select 0;
_ViewDistance = (missionNamespace getVariable [("A3PE"+(str (getPlayerUID _player))), false]) select 1;
_ZeusCam = (missionNamespace getVariable [("A3PE"+(str (getPlayerUID _player))), false]) select 2;
_IsInUAV = (missionNamespace getVariable [("A3PE"+(str (getPlayerUID _player))), false]) select 3;
_ShownUAV = (missionNamespace getVariable [("A3PE"+(str (getPlayerUID _player))), false]) select 4;
_UAV = getConnectedUAV _player;
_ForceRenderDistance = (missionNamespace getVariable [("A3PE"+(str (getPlayerUID _player))), false]) select 5;
_ForceRenderDistanceZeus = (missionNamespace getVariable [("A3PE"+(str (getPlayerUID _player))), false]) select 9;


_allObjsHide = [];
_allObjsShow = [];
{
if (!isPlayer _x) then {
if (_ViewDistance > _player distance2D _x) then {
if (_player distance2D _x > _ForceRenderDistance) then {
_obj = _x;
_vis = 0;
_selections = ["rightleg","leftleg","rightarm","leftarm","head"];
{
if (_vis == 0) then {
_pos = _obj selectionPosition _x;
_pos2 = _obj modelToWorld _pos;
if (isNull objectParent _player) then {
_visnum = [_player, "VIEW", _obj] checkVisibility [eyePos _player, AGLToASL _pos2];
_vis = _vis + _visnum;
} else {
_visnum = [(vehicle _player), "VIEW", _obj] checkVisibility [eyePos _player, AGLToASL _pos2];
_vis = _vis + _visnum;
};
};
} forEach _selections;

if (_vis == 0) then {
_allObjsHide pushBack _obj;
} else {
_allObjsShow pushBack _obj;
};
} else {_allObjsShow pushBack _x;};
} else {_allObjsHide pushBack _x;};
}; //isPlayer
} forEach _unitarray;


if !(_ZeusCam isEqualTo [0,0,0]) then {
{
if (!isPlayer _x) then {
if (_ViewDistance > (ASLToAGL _ZeusCam) distance2D _x) then {
if ((ASLToAGL _ZeusCam) distance2D _x > _ForceRenderDistanceZeus) then {
_obj = _x;
_vis = 0;
_selections = ["rightleg","leftleg","rightarm","leftarm","head"];
{
if (_vis == 0) then {
_pos = _obj selectionPosition _x;
_pos2 = _obj modelToWorld _pos;
_visnum = [objNull, "VIEW", _obj] checkVisibility [_ZeusCam, AGLToASL _pos2];
_vis = _vis + _visnum;
};
} forEach _selections;

if (_vis == 0) then {
if !(_obj in _allObjsShow) then {
  _allObjsHide pushBackUnique _obj;
  };
} else {
  _allObjsHide deleteAt (_allObjsHide find _obj);
  _allObjsShow pushBackUnique _obj;
};
} else {
  _allObjsHide deleteAt (_allObjsHide find _x);
  _allObjsShow pushBackUnique _x;
};
} else {
if !(_x in _allObjsShow) then {
  _allObjsHide pushBackUnique _x;
};
};
}; //isPlayer
} forEach _unitarray;
};


if (_IsInUAV select 1 != "" || _ShownUAV) then {
{
if (!isPlayer _x) then {
if (_ViewDistance > _UAV distance2D _x) then {
_obj = _x;
_vis = 0;
_selections = ["rightleg","leftleg","rightarm","leftarm","head"];
{
if (_vis == 0) then {
_pos = _obj selectionPosition _x;
_pos2 = _obj modelToWorld _pos;
_visnum = [_UAV, "VIEW", _obj] checkVisibility [getPosASL _UAV, AGLToASL _pos2];
_vis = _vis + _visnum;
};
} forEach _selections;

if (_vis == 0) then {
if !(_obj in _allObjsShow) then {
_allObjsHide pushBackUnique _obj;
};
} else {
_allObjsHide deleteAt (_allObjsHide find _obj);
_allObjsShow pushBackUnique _obj;
};
} else {
if !(_x in _allObjsShow) then {
_allObjsHide pushBackUnique _x;
};
};
}; //isPlayer
} forEach _unitarray;
};

[{_x hideObject true;}, _allObjsHide] remoteExecCall ["forEach", _player];
[{_x hideObject false;}, _allObjsShow] remoteExecCall ["forEach", _player];
