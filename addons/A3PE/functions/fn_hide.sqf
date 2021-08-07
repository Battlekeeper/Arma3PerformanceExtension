params ["_player"];
_ViewDistance = _player getVariable ["A3PE_ViewDistance", 3000];
_ZeusCameraPos = _player getVariable ["A3PE_ZeusCameraPos", [0,0,0]];
_IsConnectedUav = _player getVariable ["A3PE_IsConnectedUav", [objNull, ""]];
_ShownUAVFeed = _player getVariable ["A3PE_ShownUAVFeed", false];
_ForceRenderDistance = _player getVariable ["A3PE_ForceRenderDistance", 10];
_ForceRenderDistanceZeus = _player getVariable ["A3PE_ForceRenderDistanceZeus", 10];
_UAV = getConnectedUAV _player;


_allObjsHide = [];
_allObjsShow = [];
{
  _CheckedUnit = _x;
  _vis = 0;
  _selections = ["rightleg","leftleg","rightarm","leftarm","head"];

  if (!isPlayer _CheckedUnit) then {
    if (_ViewDistance > _player distance2D _CheckedUnit) then {
      if (_player distance2D _CheckedUnit > _ForceRenderDistance) then {
              {
                if (_vis == 0) then {
                  _pos = _CheckedUnit selectionPosition _x;
                  _pos2 = _CheckedUnit modelToWorld _pos;
                    if (isNull objectParent _player) then {
                      _visnum = [_player, "VIEW", _CheckedUnit] checkVisibility [eyePos _player, AGLToASL _pos2];
                      _vis = _vis + _visnum;
                    } else {
                      _visnum = [(vehicle _player), "VIEW", _CheckedUnit] checkVisibility [eyePos _player, AGLToASL _pos2];
                      _vis = _vis + _visnum;
                    };
                    if !(_ZeusCameraPos isEqualTo [0,0,0]) then {
                      _visnum = [objNull, "VIEW", _CheckedUnit] checkVisibility [_ZeusCameraPos, AGLToASL _pos2];
                      _vis = _vis + _visnum;
                    };
                    if (_IsConnectedUav select 1 != "" || _ShownUAVFeed) then {
                      _visnum = [_UAV, "VIEW", _CheckedUnit] checkVisibility [getPosASL _UAV, AGLToASL _pos2];
                      _vis = _vis + _visnum;
                    };
                };
              } forEach _selections;

              if (_vis == 0) then {
              _allObjsHide pushBack _CheckedUnit;
              } else {
              _allObjsShow pushBack _CheckedUnit;
              };
          } else {_allObjsShow pushBack _CheckedUnit;};
      } else {_allObjsHide pushBack _CheckedUnit;};
  }; //isPlayer
} forEach allUnits;

{
  _CheckedUnit = _x;
  _vis = 0;
  _selections = ["rightleg","leftleg","rightarm","leftarm","head"];

if (!isPlayer _CheckedUnit) then {
  if (_ViewDistance > _player distance2D _CheckedUnit) then {
    if (_player distance2D _CheckedUnit > _ForceRenderDistance) then {
          _visnum = [_player, "VIEW", _CheckedUnit] checkVisibility [eyePos _player, AGLToASL (_CheckedUnit modelToWorld [0,0,0.5])];
            {
              if (_vis == 0) then {
                _pos = _CheckedUnit selectionPosition _x;
                _pos2 = _CheckedUnit modelToWorld _pos;
                  if (isNull objectParent _player) then {
                    _visnum = [_player, "VIEW", _CheckedUnit] checkVisibility [eyePos _player, AGLToASL _pos2];
                    _vis = _vis + _visnum;
                  } else {
                    _visnum = [(vehicle _player), "VIEW", _CheckedUnit] checkVisibility [eyePos _player, AGLToASL _pos2];
                    _vis = _vis + _visnum;
                  };
                  if !(_ZeusCameraPos isEqualTo [0,0,0]) then {
                    _visnum = [objNull, "VIEW", _CheckedUnit] checkVisibility [_ZeusCameraPos, AGLToASL _pos2];
                    _vis = _vis + _visnum;
                  };
                  if (_IsConnectedUav select 1 != "" || _ShownUAVFeed) then {
                    _visnum = [_UAV, "VIEW", _CheckedUnit] checkVisibility [getPosASL _UAV, AGLToASL _pos2];
                    _vis = _vis + _visnum;
                  };
              };
            } forEach _selections;

            if (_vis == 0) then {
            _allObjsHide pushBack _CheckedUnit;
            } else {
            _allObjsShow pushBack _CheckedUnit;
            };
        } else {_allObjsShow pushBack _CheckedUnit;};
    } else {_allObjsHide pushBack _CheckedUnit;};
}; //isPlayer
} forEach allDeadMen;


[_allObjsHide,_allObjsShow] remoteExecCall ["A3PE_fnc_loop", _player];
