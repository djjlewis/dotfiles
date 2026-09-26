# Security

`security-check` reviews the Mac and changes nothing. It lives in `mac-bin/.local/bin`, so it is on the PATH once the
package is stowed.

```bash
security-check              # every check, about ten seconds
security-check --quick      # skip Homebrew and app signature checks
security-check --checklist  # the settings the script cannot read
```

Each line is one check. `FAIL` is something to fix. `WARN` is something to look at and decide about. `info` is a
fact worth knowing, such as the list of launch agents. `skip` means the check could not run. The exit status is 1 when
any check fails, so the command works in a script.

The checks cover disk encryption, boot policy, Gatekeeper, the firewall, every sharing service, open ports, accounts
and screen lock, SSH keys and config, launch agents and login items, app signatures, privacy grants, Homebrew, files
that hold credentials, passwords saved in browsers, Time Machine, DNS and proxies.

## Full Disk Access

The privacy grant and browser password checks read files macOS protects. Without Full Disk Access for the terminal
they print `skip`. To include them, add the terminal app in System Settings, Privacy & Security, Full Disk Access.
Remove it again afterwards if you would rather not leave it standing.

## Manual checklist

`security-check --checklist` prints the settings that only System Settings or a browser can show. Work through it
every few months, after running the script. It is the only copy of that list, so edit it in the script.

## Remote access over Tailscale

Inbound SSH to a Mac goes through macOS Remote Login, which runs Apple's sshd. The Tailscale app from Homebrew's
cask does not run an SSH server of its own. Tailscale SSH, which would replace Remote Login, only works with the
open-source `tailscaled` build, and switching to that build loses the menu bar app. So to SSH into this Mac over the
tailnet, Remote Login stays on and sshd is told to accept only keys, and only from tailnet addresses.

Outbound SSH from this Mac to another machine never needs Remote Login. The `ssh` command, VS Code Remote and
JetBrains Gateway all connect out.

launchd owns port 22. It accepts each connection and starts sshd for it, so `ListenAddress` in the sshd config has
no effect. launchd also advertises the service over Bonjour on every network the Mac joins. The application
firewall does not filter by source address either. `AllowUsers` with an address range is what does the job: sshd
rejects any connection whose source is outside the range before it looks at a key. Tailscale addresses all sit in
100.64.0.0/10 and fd7a:115c:a1e0::/48.

Set it up in this order.

1. In System Settings, General, Sharing, open the Remote Login info panel. Untick "Allow full disk access for remote
   users" and set access to only your user.
2. Put the public key of each machine that will connect in `~/.ssh/authorized_keys` on this Mac, one per line, and
   make the file mode 600.
3. Add the sshd config. sshd reads it on every connection, so nothing needs restarting:

```bash
sudo tee /etc/ssh/sshd_config.d/010-tailnet.conf <<'EOF'
AllowUsers dan@100.64.0.0/10 dan@fd7a:115c:a1e0::/48
PasswordAuthentication no
KbdInteractiveAuthentication no
PermitRootLogin no
EOF
```

4. Turn the firewall on with stealth mode. Remote Login already has a firewall rule, so SSH keeps working.

Then test both directions before closing the session that made the change. From this Mac, a connection to its own
LAN address must be refused, and a connection to its own Tailscale address must succeed with the key:

```bash
ssh -o BatchMode=yes dan@$(ipconfig getifaddr en0) true; echo "LAN: exit $?"
```

```bash
ssh -o BatchMode=yes dan@$(/Applications/Tailscale.app/Contents/MacOS/Tailscale ip -4) true; echo "tailnet: exit $?"
```

The first prints a non-zero exit with "Permission denied". The second prints exit 0. `security-check` reports
`Remote Login on, keys only, tailnet addresses only` once the config is in place, and warns while `authorized_keys`
is missing.

The same recipe works on the other Macs you SSH into, with their own user name in `AllowUsers`. Tailscale's access
controls can also limit port 22 to your own devices, which matters more once other people's devices share the
tailnet.

## Common fixes

The firewall, with stealth mode, and without the rules that let the system interpreters accept connections:

```bash
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on --setstealthmode on
```

```bash
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --remove /usr/bin/python3 --remove /usr/bin/ruby
```

Touch ID for sudo. The template ships with macOS and survives updates once copied:

```bash
sudo cp /etc/pam.d/sudo_local.template /etc/pam.d/sudo_local && sudo sed -i '' 's/^#auth/auth/' /etc/pam.d/sudo_local
```

AirPlay Receiver listens on ports 5000 and 7000 on every interface while it is set to "Everyone" or "Anyone on the
same network". Set it to "Current User" in System Settings, General, AirDrop & Handoff.

A stale privacy grant is one whose app is gone. Remove it in System Settings, Privacy & Security, under the service
the script names. The grant comes back on its own if you reinstall the app and it asks again.
