**Vampire's Vehicle Degradation**
================
A script for Arma 3: Epoch that causes driven vehicles to degrade over time.

Current Version is v1.1

Idea by KPABATOK & Moist_Pretzels on EpochMod.com

--------------------------
Installation
--------------------------
1. Add this line to your init.sqf outside of any brackets:

   ```[] ExecVM "VAMP_vehDegrade.sqf";```

2. Add the file "VAMP_vehDegrade.sqf" to your mission.pbo root.

3. Add the following in your mission.pbo >> epoch_code >> customs >> EPOCH_custom_EH_GetInMan.sqf at the bottom.

   ```VAMP_vehDegradeRun = true;```

4. Add the following in your mission.pbo >> epoch_code >> customs >> EPOCH_custom_EH_GetOutMan.sqf at the bottom.

   ```VAMP_vehDegradeRun = false;```

5. (Optionally) Configure the inside of "VAMP_vehDegrade.sqf".

--------------------------
Current Developers
--------------------------
* Vampire - Developer - http://epochmod.com/forum/index.php?/user/11819-thevampire/

--------------------------
License
--------------------------
All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

http://creativecommons.org/licenses/by-nc-sa/4.0/
