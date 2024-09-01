startvnc(){ # Start vnc server
        vncserver $1 -localhost -geometry 1280x720 -depth 16
}
