Sample init scripts and service configuration for Krond
==========================================================

Sample scripts and configuration files for systemd, Upstart and OpenRC
can be found in the contrib/init folder.

    contrib/init/Krond.service:    systemd service unit configuration
    contrib/init/Krond.openrc:     OpenRC compatible SysV style init script
    contrib/init/Krond.openrcconf: OpenRC conf.d file
    contrib/init/Krond.conf:       Upstart service configuration file
    contrib/init/Krond.init:       CentOS compatible SysV style init script

Service User
---------------------------------

All three Linux startup configurations assume the existence of a "Kron" user
and group.  They must be created before attempting to use these scripts.
The OS X configuration assumes Krond will be set up for the current user.

Configuration
---------------------------------

At a bare minimum, Krond requires that the rpcpassword setting be set
when running as a daemon.  If the configuration file does not exist or this
setting is not set, Krond will shutdown promptly after startup.

This password does not have to be remembered or typed as it is mostly used
as a fixed token that Krond and client programs read from the configuration
file, however it is recommended that a strong and secure password be used
as this password is security critical to securing the wallet should the
wallet be enabled.

If Krond is run with the "-server" flag (set by default), and no rpcpassword is set,
it will use a special cookie file for authentication. The cookie is generated with random
content when the daemon starts, and deleted when it exits. Read access to this file
controls who can access it through RPC.

By default the cookie is stored in the data directory, but it's location can be overridden
with the option '-rpccookiefile'.

This allows for running Krond without having to do any manual configuration.

`conf`, `pid`, and `wallet` accept relative paths which are interpreted as
relative to the data directory. `wallet` *only* supports relative paths.

For an example configuration file that describes the configuration settings,
see `contrib/debian/examples/Kron.conf`.

Paths
---------------------------------

### Linux

All three configurations assume several paths that might need to be adjusted.

Binary:              `/usr/bin/Krond`  
Configuration file:  `/etc/Kron/Kron.conf`  
Data directory:      `/var/lib/Krond`  
PID file:            `/var/run/Krond/Krond.pid` (OpenRC and Upstart) or `/var/lib/Krond/Krond.pid` (systemd)  
Lock file:           `/var/lock/subsys/Krond` (CentOS)  

The configuration file, PID directory (if applicable) and data directory
should all be owned by the Kron user and group.  It is advised for security
reasons to make the configuration file and data directory only readable by the
Kron user and group.  Access to Kron-cli and other Krond rpc clients
can then be controlled by group membership.

### Mac OS X

Binary:              `/usr/local/bin/Krond`  
Configuration file:  `~/Library/Application Support/Kron/Kron.conf`  
Data directory:      `~/Library/Application Support/Kron`  
Lock file:           `~/Library/Application Support/Kron/.lock`  

Installing Service Configuration
-----------------------------------

### systemd

Installing this .service file consists of just copying it to
/usr/lib/systemd/system directory, followed by the command
`systemctl daemon-reload` in order to update running systemd configuration.

To test, run `systemctl start Krond` and to enable for system startup run
`systemctl enable Krond`

### OpenRC

Rename Krond.openrc to Krond and drop it in /etc/init.d.  Double
check ownership and permissions and make it executable.  Test it with
`/etc/init.d/Krond start` and configure it to run on startup with
`rc-update add Krond`

### Upstart (for Debian/Ubuntu based distributions)

Drop Krond.conf in /etc/init.  Test by running `service Krond start`
it will automatically start on reboot.

NOTE: This script is incompatible with CentOS 5 and Amazon Linux 2014 as they
use old versions of Upstart and do not supply the start-stop-daemon utility.

### CentOS

Copy Krond.init to /etc/init.d/Krond. Test by running `service Krond start`.

Using this script, you can adjust the path and flags to the Krond program by
setting the KronD and FLAGS environment variables in the file
/etc/sysconfig/Krond. You can also use the DAEMONOPTS environment variable here.

### Mac OS X

Copy org.Kron.Krond.plist into ~/Library/LaunchAgents. Load the launch agent by
running `launchctl load ~/Library/LaunchAgents/org.Kron.Krond.plist`.

This Launch Agent will cause Krond to start whenever the user logs in.

NOTE: This approach is intended for those wanting to run Krond as the current user.
You will need to modify org.Kron.Krond.plist if you intend to use it as a
Launch Daemon with a dedicated Kron user.

Auto-respawn
-----------------------------------

Auto respawning is currently only configured for Upstart and systemd.
Reasonable defaults have been chosen but YMMV.
