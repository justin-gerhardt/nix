To prevent excessive rebuilding from source modifed and new packages use locked dependnecies. T
he version of nixpkgs to use is specified in machine/base/lockedpkgs.nix. 

As the dependnecies get out of date they will be dropped from the nix binary cache. As a result attempting to deploy to a new system will rebuild the world.

As a result the lock version should be updated before any new deploys


Bluetooth

bluetoothctl pair <mac>

bluetoothctl trust <mac>

Bose 
4C:87:5D:A1:07:80
Move
74:5C:4B:F8:E4:49
