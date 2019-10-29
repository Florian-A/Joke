# Test ou installation de xcalib.
pkgs='xcalib'
if ! dpkg -s $pkgs >/dev/null 2>&1; then
    sudo apt-get install $pkgs
fi

# Test ou installation de xrandr.
pkgs='x11-xserver-utils'
if ! dpkg -s $pkgs >/dev/null 2>&1; then
    sudo apt-get install $pkgs
fi

# Compteur qui permet d'executer deux commandes par alternance,
counter=0;
setCounter() {
    if [ $counter -lt 20 ]
    then
        counter=$(($counter+1));
    else
        counter=0
    fi
}

# Rotation de l'ecran.
rotateScreen () {
    screenRotation="left";
    
    if [ $counter -eq 20 ]
    then
        case $i in
            0)
                i=1;
                screenRotation="left";
            ;;
            1)
                i=2;
                screenRotation="inverted";
            ;;
            2)
                i=3;
                screenRotation="right";
            ;;
            *)
                i=0;
                screenRotation="normal";
            ;;
        esac
        xrandr -o $screenRotation;
    fi
    
}

# Inversion des couleurs.
invertColors() {
    xcalib -invert -alter;
}

# Execution de la boucle generale.
while true
do
    sleep 0.1;
    setCounter;
    invertColors;
    rotateScreen;
done