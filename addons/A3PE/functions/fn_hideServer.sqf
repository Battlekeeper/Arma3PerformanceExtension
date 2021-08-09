params ["_player","_allUnits","_allDeadMen","_allPlayers"];
_ViewDistance = _player getVariable ["A3PE_ViewDistance", 3000];
_ZeusCameraPos = _player getVariable ["A3PE_ZeusCameraPos", [0,0,0]];
_IsConnectedUav = _player getVariable ["A3PE_IsConnectedUav", [objNull, ""]];
_ShownUAVFeed = _player getVariable ["A3PE_ShownUAVFeed", false];
_ForceRenderDistance = _player getVariable ["A3PE_ForceRenderDistance", 10];
_ForceRenderDistanceZeus = _player getVariable ["A3PE_ForceRenderDistanceZeus", 10];
_HigherQualityAI = _player getVariable ["A3PE_HigherQualityAI", false];
_HigherQualityDead = _player getVariable ["A3PE_HigherQualityDead", false];
_EnablePlayerHide = _player getVariable ["A3PE_EnablePlayerHide", false];
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
        if (isNull objectParent _CheckedUnit) then {
              {
                if (_vis == 0) then { // Skips if unit was already calculated to be seen
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
                    if (_HigherQualityAI) then {
                      _visnumFront = [_player, "VIEW", _CheckedUnit] checkVisibility [AGLToASL (_player modelToWorld [0,5,1]), AGLToASL _pos2];  // front
                      _visnumLeft = [_player, "VIEW", _CheckedUnit] checkVisibility [AGLToASL (_player modelToWorld [-5,0,1]), AGLToASL _pos2];  // left
                      _visnumRight = [_player, "VIEW", _CheckedUnit] checkVisibility [AGLToASL (_player modelToWorld [5,0,1]), AGLToASL _pos2];  // right
                      _vis = _vis + _visnumFront + _visnumLeft + _visnumRight;
                    };
                };
              } forEach _selections;

              if (_vis == 0) then {
              _allObjsHide pushBack _CheckedUnit;
              } else {
              _allObjsShow pushBack _CheckedUnit;
              };
          } else {_allObjsShow pushBack _CheckedUnit;};
        } else {_allObjsShow pushBack _CheckedUnit;};
      } else {_allObjsHide pushBack _CheckedUnit;};
  }; //isPlayer
} forEach _allUnits;

{
  _CheckedUnit = _x;
  _vis = 0;
  _selections = ["rightleg","leftleg","rightarm","leftarm","head"];

if (!isPlayer _CheckedUnit) then {
  if (_ViewDistance > _player distance2D _CheckedUnit) then {
    if (_player distance2D _CheckedUnit > _ForceRenderDistance) then {
      if (isNull objectParent _CheckedUnit) then {
          _visnum = [_player, "VIEW", _CheckedUnit] checkVisibility [eyePos _player, AGLToASL (_CheckedUnit modelToWorld [0,0,0.5])];
            {
              if (_vis == 0) then { // Skips if unit was already calculated to be seen
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
                  if (_HigherQualityDead) then {
                    _visnumFront = [_player, "VIEW", _CheckedUnit] checkVisibility [AGLToASL (_player modelToWorld [0,5,1]), AGLToASL _pos2];  // front
                    _visnumLeft = [_player, "VIEW", _CheckedUnit] checkVisibility [AGLToASL (_player modelToWorld [-5,0,1]), AGLToASL _pos2];  // left
                    _visnumRight = [_player, "VIEW", _CheckedUnit] checkVisibility [AGLToASL (_player modelToWorld [5,0,1]), AGLToASL _pos2];  // right
                    _vis = _vis + _visnumFront + _visnumLeft + _visnumRight;
                  };
              };
            } forEach _selections;

            if (_vis == 0) then {
            _allObjsHide pushBack _CheckedUnit;
            } else {
            _allObjsShow pushBack _CheckedUnit;
            };
        } else {_allObjsShow pushBack _CheckedUnit;};
      } else {_allObjsShow pushBack _CheckedUnit;};
    } else {_allObjsHide pushBack _CheckedUnit;};
  }; //isPlayer
} forEach _allDeadMen;

if (_EnablePlayerHide) then {
{
  _CheckedUnit = _x;
  _vis = 0;
  _selections = ["rightleg","leftleg","rightarm","leftarm","head"];

    if (_ViewDistance > _player distance2D _CheckedUnit) then {
      if (_player distance2D _CheckedUnit > _ForceRenderDistance) then {
        if (isNull objectParent _CheckedUnit) then {
              {
                if (_vis == 0) then { // Skips if unit was already calculated to be seen
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
                    if (_HigherQualityAI) then {
                      _visnumFront = [_player, "VIEW", _CheckedUnit] checkVisibility [AGLToASL (_player modelToWorld [0,5,1]), AGLToASL _pos2];  // front
                      _visnumLeft = [_player, "VIEW", _CheckedUnit] checkVisibility [AGLToASL (_player modelToWorld [-5,0,1]), AGLToASL _pos2];  // left
                      _visnumRight = [_player, "VIEW", _CheckedUnit] checkVisibility [AGLToASL (_player modelToWorld [5,0,1]), AGLToASL _pos2];  // right
                      _vis = _vis + _visnumFront + _visnumLeft + _visnumRight;
                    };
                };
              } forEach _selections;

              if (_vis == 0) then {
              _allObjsHide pushBack _CheckedUnit;
              } else {
              _allObjsShow pushBack _CheckedUnit;
              };
          } else {_allObjsShow pushBack _CheckedUnit;};
        } else {_allObjsShow pushBack _CheckedUnit;};
      } else {_allObjsHide pushBack _CheckedUnit;};
} forEach _allPlayers;
};

[_allObjsHide,_allObjsShow] remoteExecCall ["A3PE_fnc_hideClient", _player];
