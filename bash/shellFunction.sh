function printHello {
        local name="Spencer"
        echo "Hello $name"
        return
}

printGoodbye() {
        local moniker="Friend"
        echo "Goodbye $moniker"
        return
}


printHello
printGoodbye
