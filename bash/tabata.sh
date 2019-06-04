# Script for my Tabata workout

for VARIABLE in 1 2 3 4 5 6 7 8
do
    for VAR in 1 2 3 4 5 6 7 8
    do
        say Workout $VARIABLE Round $VAR
        sleep 20
        say Break - Ten Second Rest
        sleep 10
    done

    say Break - One Minute Rest
    sleep 60
done
