/*  Script written by Vampire (vampuricgaming.net)
    Idea by KPABATOK & Moist_Pretzels on EpochMod.com */

/* -------------------------------------------------------------------------------- */

// Master On Switch - set to false to disable script
VAMP_degradeOn = true;

// How long to wait before degrading a driven vehicle
// The higher the time the less likely the player will have driven it long enough
// Too low and the vehicle falls apart too quickly
// Time in seconds - Increase if you are seeing server fps loss
VAMP_degradeWait = 600; // Default 10 Mins
// How long to wait to check if a player entered a vehicle
VAMP_degradeVehEnt = 30; // Default 30sec

// How far in meters to consider the vehicle has moved?
VAMP_moveDist = 15;

// Damage is 1 = DEAD / 0 = PERFECT CONDITION
// Max Random Damage to give per "tick" - how long a "tick" depends on timer
// If you set this too high people will get angry unless you adjust the time to counter it
VEMF_degradeMaxDam = 0.03;
// Fixed amount of small damage for non direct-use parts
VEMF_degradeFixDam = 0.005;

// Here's some math to figure out the ticks
// Damage Max is 1 so a "tick" is 1/MaxDam (Ex. 1/0.03 = 33.33~)
// Straight driven time before potential failure is "ticks" times WaitTime
// (Ex. 33.33~*10min = 333.33~Min or 5.55~ Hours Till Potential Failure)
// Make sure your Hours Till Failure time is high enough.

// Array of Classnames not to degrade
VAMP_degradeBlacklist = [];
// Array of HitPoints to damage random amounts (with a Max)
VAMP_degradeDamPnts = [
  "HitHull","HitGear","HitEngine","HitTransmission","HitLTrack","HitRTrack","HitLFWheel","HitLF2Wheel",
  "HitRFWheel","HitRF2Wheel","HitLMWheel","HitRMWheel","HitLAileron","HitRAileron","HitLCRudder",
  "HitLCElevator","HitRElevator","HitHRotor","HitVRotor"
];
// Array of HitPoints to damage less - Idea being that Tires take-
// random damage but Engine takes fixed damage over time
// Must also be in the array above to work
VAMP_degradeDamLess = [
  "HitHull","HitGear","HitEngine","HitTransmission","HitEngine2","HitEngine3"
];

/* -------------------------------------------------------------------------------- */
/* -------- DO NOT EDIT BELOW THIS LINE UNLESS YOU KNOW WHAT YOU ARE DOING -------- */
/* -------------------------------------------------------------------------------- */

if !(VAMP_degradeOn) exitWith {
  diag_log format ["[Vamps Degrade]: Script is Disabled."];
};

if (!isDedicated) then {
  /* is a Client */
  waitUntil {!isNuLL(uiNameSpace getVariable ["EPOCH_loadingScreen",displayNull])};
  waitUntil {isNuLL(uiNameSpace getVariable ["EPOCH_loadingScreen",displayNull])};
  waitUntil {!isNull player};
  waitUntil {!(isNull (findDisplay 46))};

  VAMP_degradePlayer = player;
  publicVariableServer "VAMP_degradePlayer";
  diag_log format ["[Vamps Degrade]: Client Loaded."];

} else {
  /* is a Server */
  diag_log format ["[Vamps Degrade]: Server Loaded."];

  "VAMP_degradePlayer" addPublicVariableEventHandler {

    _player = param [1,objNull];

    VAMP_degradePlayer = nil;

    if (isNull _player) exitWith {};

    [_player] spawn {

      _player = param [0,objNull];

      if (isNull _player) exitWith {};

      while {alive _player} do {

        uiSleep VAMP_degradeVehEnt; /* How often we check that they got into a vehicle in seconds */

        /* Check Player in Vehicle and is Vehicle Running and not blacklisted */
        if ((vehicle _player != _player) && (isEngineOn (vehicle _player)) && !((typeOf (vehicle _player)) in VAMP_degradeBlacklist)) then {
          /* Player in Vehicle */

          _veh = (vehicle _player);
          _pos = getPos _veh;

          uiSleep VAMP_degradeWait;

          /*	If Still in Same Vehicle and Engine is On We are gonna presume they've been driving the whole time */
          if ((vehicle _player == _veh) && (isEngineOn _veh) && (_veh distance _pos > VAMP_moveDist)) then {
            /* Slight Damage */
            /* Seperate Cases by type for advanced users to config */
            switch (true) do {
              case (_veh isKindOf "Tank"): {
                {
                  _dam = _veh getHitPointDamage _x;
                  if !(isNil "_dam") then {
                    _hit = _dam;
                    if (_dam < 1) then {
                      _hit = ((random VEMF_degradeMaxDam) + _dam);
                    };
                    if (_x in VAMP_degradeDamLess) then {
                      _hit = (VEMF_degradeFixDam + _dam);
                    };
                    _veh setHitPointDamage [_x, _hit, false];
                    uiSleep 1;
                  };
                } forEach VAMP_degradeDamPnts;
              };
              case (_veh isKindOf "Land"): {
                {
                  _dam = _veh getHitPointDamage _x;
                  if !(isNil "_dam") then {
                    _hit = _dam;
                    if (_dam < 1) then {
                      _hit = ((random VEMF_degradeMaxDam) + _dam);
                    };
                    if (_x in VAMP_degradeDamLess) then {
                      _hit = (VEMF_degradeFixDam + _dam);
                    };
                    _veh setHitPointDamage [_x, _hit, false];
                    uiSleep 1;
                  };
                } forEach VAMP_degradeDamPnts;
              };
              case (_veh isKindOf "Air"): {
                {
                  _dam = _veh getHitPointDamage _x;
                  if !(isNil "_dam") then {
                    _hit = _dam;
                    if (_dam < 1) then {
                      _hit = ((random VEMF_degradeMaxDam) + _dam);
                    };
                    if (_x in VAMP_degradeDamLess) then {
                      _hit = (VEMF_degradeFixDam + _dam);
                    };
                    _veh setHitPointDamage [_x, _hit, false];
                    uiSleep 1;
                  };
                } forEach VAMP_degradeDamPnts;
              };
              case (_veh isKindOf "Sea"): {
                {
                  _dam = _veh getHitPointDamage _x;
                  if !(isNil "_dam") then {
                    _hit = _dam;
                    if (_dam < 1) then {
                      _hit = ((random VEMF_degradeMaxDam) + _dam);
                    };
                    if (_x in VAMP_degradeDamLess) then {
                      _hit = (VEMF_degradeFixDam + _dam);
                    };
                    _veh setHitPointDamage [_x, _hit, false];
                    uiSleep 1;
                  };
                } forEach VAMP_degradeDamPnts;
              };
            };
          };
        };
      };
    };
  };
};
