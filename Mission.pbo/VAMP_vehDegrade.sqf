/*  Script written by Vampire (vampuricgaming.net)
    Idea by KPABATOK & Moist_Pretzels on EpochMod.com */

/* -------------------------------------------------------------------------------- */
if!(isDedicated)then{ // Clients Only - DO NOT EDIT - Configure Below
/* -------------------------------------------------------------------------------- */

	// Master On Switch - set to false to disable script
	VAMP_degradeOn = true;

	// How long to wait before degrading a driven vehicle
	// The higher the time the less likely the player will have driven it long enough
	// Too low and the vehicle falls apart too quickly
	// Time in seconds - Increase if you are seeing fps loss
	VAMP_degradeWait = 60; // Default 1 Minute
	// How long to wait to check if a player entered a vehicle
	VAMP_degradeVehEnt = 5; // Default 5 seconds

	// How far in meters to consider the vehicle has moved?
	VAMP_moveDist = 10;

	// Damage is 1 = DEAD / 0 = PERFECT CONDITION
	// Max Random Damage to give per "tick" - how long a "tick" depends on timer
	// If you set this too high people will get angry unless you adjust the time to counter it
	VEMF_degradeMaxDam = 0.003;
	// Fixed amount of small damage for non direct-use parts
	VEMF_degradeFixDam = 0.0005;

	// Here's some math to figure out the ticks
	// Damage Max is 1 so a "tick" is 1/MaxDam (Ex. 1/0.003 = 333.33~)
	// Straight driven time before potential failure is "ticks" times WaitTime
	// (Ex. 333.33~*1min = 333.33~Min or 5.55~ Hours Till Potential Failure)
	// Make sure your Hours Till Failure time is high enough.

	// Array of Classnames not to degrade
	VAMP_degradeBlacklist = []; // Ex. "CSJ_GyroC"
	// Array of HitPoints not to damage
	VAMP_degradeNonDamPnts = [
		"HitFuel","HitTurret","HitGun","HitAvionics","HitFuel_Lead_Left",
		"HitFuel_Lead_Right","HitFuel_Left","HitFuel_Right","HitFuel2","HitMissiles"
	];
	// Array of HitPoints to damage less - Idea being that Tires take
	//          random damage but Engine takes fixed damage over time
	VAMP_degradeDamLess = [
		"HitHull","HitGear","HitEngine","HitTransmission","HitEngine2","HitEngine3"
	];

/* -------------------------------------------------------------------------------- */
/* -------- DO NOT EDIT BELOW THIS LINE UNLESS YOU KNOW WHAT YOU ARE DOING -------- */
/* -------------------------------------------------------------------------------- */

	waitUntil {!isNull(uiNameSpace getVariable ["EPOCH_loadingScreen",displayNull])};
	waitUntil {isNull(uiNameSpace getVariable ["EPOCH_loadingScreen",displayNull])};
	waitUntil {!isNull player};
	waitUntil {!(isNull (findDisplay 46))};

	VAMP_vehDegradeRun = false;

	[] spawn {

		//diag_log format ["[Vamps Degrade]: Spawned."];

		while {alive player} do {

			//diag_log format ["[Vamps Degrade]: Waiting."];

			waitUntil{uiSleep VAMP_degradeVehEnt;(VAMP_vehDegradeRun && vehicle player != player)};

			//diag_log format ["[Vamps Degrade]: Waiting Passed."];

			if ((vehicle player != player) && (isEngineOn (vehicle player)) && !((typeOf (vehicle player)) in VAMP_degradeBlacklist)) then {
				/* Player in Vehicle */

				_veh = (vehicle player);
				_pos = getPos _veh;

				//diag_log format ["[Vamps Degrade]: Player in Vehicle."];

				uiSleep VAMP_degradeWait;

				if (VAMP_vehDegradeRun && (vehicle player == _veh) && (isEngineOn _veh) && (_veh distance _pos > VAMP_moveDist)) then {
					/* A little damage */

					//diag_log format ["[Vamps Degrade]: Damaging."];

					switch (true) do {
						case (_veh isKindOf "Tank"): {
							{
								_dam = _veh getHitPointDamage _x;
								if !(isNil "_dam" || (_x in VAMP_degradeNonDamPnts)) then {
									_hit = ((random VEMF_degradeMaxDam) + _dam);
									if (_x in VAMP_degradeDamLess) then {
										_hit = (VEMF_degradeFixDam + _dam);
									};
									_veh setHitPointDamage [_x, _hit, false];
								};
                                uiSleep 1;
							} forEach ((getAllHitPointsDamage _veh) select 0);
						};
						case (_veh isKindOf "Land"): {
							{
								_dam = _veh getHitPointDamage _x;
								if !(isNil "_dam" || (_x in VAMP_degradeNonDamPnts)) then {
									_hit = ((random VEMF_degradeMaxDam) + _dam);
									if (_x in VAMP_degradeDamLess) then {
										_hit = (VEMF_degradeFixDam + _dam);
									};
									_veh setHitPointDamage [_x, _hit, false];
								};
                                uiSleep 1;
							} forEach ((getAllHitPointsDamage _veh) select 0);
						};
						case (_veh isKindOf "Air"): {
							{
								_dam = _veh getHitPointDamage _x;
								if !(isNil "_dam" || (_x in VAMP_degradeNonDamPnts)) then {
									_hit = ((random VEMF_degradeMaxDam) + _dam);
									if (_x in VAMP_degradeDamLess) then {
										_hit = (VEMF_degradeFixDam + _dam);
									};
									_veh setHitPointDamage [_x, _hit, false];
								};
                                uiSleep 1;
							} forEach ((getAllHitPointsDamage _veh) select 0);
						};
						case (_veh isKindOf "Sea"): {
							{
								_dam = _veh getHitPointDamage _x;
								if !(isNil "_dam" || (_x in VAMP_degradeNonDamPnts)) then {
									_hit = ((random VEMF_degradeMaxDam) + _dam);
									if (_x in VAMP_degradeDamLess) then {
										_hit = (VEMF_degradeFixDam + _dam);
									};
									_veh setHitPointDamage [_x, _hit, false];
								};
                                uiSleep 1;
							} forEach ((getAllHitPointsDamage _veh) select 0);
						};
						default {
							//diag_log format ["[Vamps Degrade]: Unknown vehicle type! %1", (typeOf _veh)];
						};
					};
					//diag_log format ["[Vamps Degrade]: Damaging %1 now %2",(typeOf _veh),((getAllHitPointsDamage _veh) select 2)];
				};
			} else {
				//diag_log format ["[Vamps Degrade]: If Skipped: %1 - %2 - %3 - %4",player,(vehicle player != player),(isEngineOn (vehicle player)),!((typeOf (vehicle player)) in VAMP_degradeBlacklist)];
			};
		};
	};

  diag_log format ["[Vamps Degrade]: Client Loaded."];

} else {
  diag_log format ["[Vamps Degrade]: Loaded and Running on Clients."];
};
