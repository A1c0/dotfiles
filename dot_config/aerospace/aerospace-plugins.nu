# Ensure pueue deamon started
try { pueue | ignore } catch { pueued -d }

pueue group add aerospace --parallel 2 | ignore;
pueue kill --group aerospace;
pueue start --group aerospace;

pueue add --group aerospace --label sketchybar -- sketchybar
pueue add --group aerospace --label border -- "borders active_color=\"glow\(0xffc6a0f6\)\" inactive_color=0x00000000 width=3.0 hidpi=on order=above"
