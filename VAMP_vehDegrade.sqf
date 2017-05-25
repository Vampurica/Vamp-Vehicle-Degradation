/*  Script written by Vampire (vampuricgaming.net)
    Idea by KPABATOK & Moist_Pretzels on EpochMod.com */

if !(isDedicated) then {
  /* is a Client */
  VAMP_degradePlayer = player;
  publicVariableServer "VAMP_degradePlayer";
} else {
  /* is a Server */
  "VAMP_degradePlayer" addPublicVariableEventHandler {
    _player = param [1,objNull];

    if (_player isEqualTo objNull) exitWith {};

    [_player] spawn {
      private ["_player","_blackList","_damPnts"];

      _player = param [0,objNull];

      if (_player isEqualTo objNull) exitWith {};

      /*	Add Classnames to Blacklist, Adjust Hit Locations in Damage Points	*/
      _blackList = [];
      _damPnts = [
        "HitHull","HitGear","HitEngine","HitTransmission","HitLTrack","HitRTrack","HitLFWheel","HitLF2Wheel",
        "HitRFWheel","HitRF2Wheel","HitLMWheel","HitRMWheel","HitLAileron","HitRAileron","HitLCRudder",
        "HitLCElevator","HitRElevator","HitHRotor","HitVRotor"
      ];

      while {alive _player} do {
        uiSleep 60; /* How often we check that they got into a vehicle in seconds */

        /* Check Player in Vehicle and is Vehicle Running and not blacklisted */
        if ((vehicle _player != _player) && (isEngineOn (vehicle _player)) && !(typeOf _veh in _blackList)) then {
          /* Player in Vehicle */

          _veh = (vehicle _player);
          uiSleep 600; /* Time to wait before checking they are still in the same veh - 600 = 10 Minutes */

          /*	If Still in Same Vehicle and Engine is On We are gonna presume they've been driving for 10mins */
          if ((vehicle _player == _veh) && (isEngineOn _veh)) then {
            /* Slight Damage */
            switch (true) do {
              case (_veh isKindOf "Tank"): {
                {
                  _dam = _veh getHitPointDamage _x;
                  if !(isNil "_dam") then {
                    _hit = _dam;
                    if (_dam < 1) then {
                      _hit = ((random 0.02) + _dam);
                    };
                    if (_x in ["HitHull","HitGear","HitEngine","HitTransmission","HitEngine2","HitEngine3"]) then {
                      /* Engine, Hull, etc should degrade slower */
                      _hit = (0.005 + _dam);
                    };
                    _veh setHitPointDamage [_x, _hit, false];
                  };
                } forEach _damPnts;
              };
              case (_veh isKindOf "Land"): {
                {
                  _dam = _veh getHitPointDamage _x;
                  if !(isNil "_dam") then {
                    _hit = _dam;
                    if (_dam < 1) then {
                      _hit = ((random 0.02) + _dam);
                    };
                    if (_x in ["HitHull","HitGear","HitEngine","HitTransmission","HitEngine2","HitEngine3"]) then {
                      /* Engine, Hull, etc should degrade slower */
                      _hit = (0.005 + _dam);
                    };
                    _veh setHitPointDamage [_x, _hit, false];
                  };
                } forEach _damPnts;
              };
              case (_veh isKindOf "Air"): {
                {
                  _dam = _veh getHitPointDamage _x;
                  if !(isNil "_dam") then {
                    _hit = _dam;
                    if (_dam < 1) then {
                      _hit = ((random 0.02) + _dam);
                    };
                    if (_x in ["HitHull","HitGear","HitEngine","HitTransmission","HitEngine2","HitEngine3"]) then {
                      /* Engine, Hull, etc should degrade slower */
                      _hit = (0.005 + _dam);
                    };
                    _veh setHitPointDamage [_x, _hit, false];
                  };
                } forEach _damPnts;
              };
              case (_veh isKindOf "Sea"): {
                {
                  _dam = _veh getHitPointDamage _x;
                  if !(isNil "_dam") then {
                    _hit = _dam;
                    if (_dam < 1) then {
                      _hit = ((random 0.02) + _dam);
                    };
                    if (_x in ["HitHull","HitGear","HitEngine","HitTransmission","HitEngine2","HitEngine3"]) then {
                      /* Engine, Hull, etc should degrade slower */
                      _hit = (0.005 + _dam);
                    };
                    _veh setHitPointDamage [_x, _hit, false];
                  };
                } forEach _damPnts;
              };
            };
          };
        };
      };
    };

    VAMP_degradePlayer = nil;
  };
};
