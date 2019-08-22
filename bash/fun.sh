# A Fun Start to Tranquility's Genesis

while [[ -n "$1" ]]; do
    case "$1" in
        -j | -joxos)    echo "Joxos, a true Titan, joins you."
                        shift
                        ;;
        -v | -vi)       echo "Vi, of the Citadel, lends you her magic."
                        shift
                        ;;
        -r | -rokh)     echo "Rokh and Aegis, the Cores, are by your side."
                        shift
                        ;;
        -i | -inferno)  echo "Inferno, the Blazing Sword of the Last Line, stands firm with you."
                        shift
                        ;;
        -b | -beatrix)  echo "Beatrix and Emory, of Mundi, bring the forest to your aid."
                        shift
                        ;;
        -a | -armadias) echo "Armadias von Elgin, the Shield, comes to your defense."
                        shift
                        ;;
        -f | -flare)    echo "Flare, the Dragon, flys to your rescue with tooth, talon, and flame."
                        shift
                        ;;
        -t | -tranquility) echo "Tranquility, the hero of the story, is here."
                        shift
                        ;;
        *)  echo "I know not a hero by that code." >&2
            shift
            ;;
    esac
done
