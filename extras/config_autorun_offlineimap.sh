#!/bin/bash
sudo cp /usr/share/doc/offlineimap/examples/systemd/offlineimap.service /etc/systemd/user
systemctl --user enable offlineimap
systemctl --user start offlineimap
