import React, { useState } from "react";
import {
  StyleSheet,
  Text,
  TouchableOpacity,
  View,
  Platform,
} from "react-native";
import { Barometer } from "expo-sensors";

export default function App() {
  const [{ pressure, relativeAltitude }, setData] = useState({
    pressure: 0,
    relativeAltitude: 0,
  });
  const [subscription, setSubscription] = useState(null);

  const toggleListener = () => {
    subscription ? unsubscribe() : subscribe();
  };

  const subscribe = () => {
    setSubscription(Barometer.addListener(setData));
  };

  const unsubscribe = () => {
    subscription && subscription.remove();
    setSubscription(null);
  };

  return (
    <View style={styles.wrapper}>
      <Text>Barometer: Listener {subscription ? "ACTIVE" : "INACTIVE"}</Text>
      <Text>Pressure: {pressure} hPa</Text>
      <Text>
        Relative Altitude:{" "}
        {Platform.OS === "ios"
          ? `${relativeAltitude} m`
          : `Only available on iOS`}
      </Text>
      <TouchableOpacity onPress={toggleListener} style={styles.button}>
        <Text>Toggle listener</Text>
      </TouchableOpacity>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    paddingHorizontal: 20,
    justifyContent: "center",
  },
  text: {
    textAlign: "center",
    color: "white",
  },
  header: {
    textAlign: "center",
    color: "white",
    fontSize: 32,
  },
  buttonContainer: {
    flexDirection: "row",
    alignItems: "stretch",
    marginTop: 15,
  },
  button: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
    backgroundColor: "#eee",
    padding: 10,
  },
  middleButton: {
    borderLeftWidth: 1,
    borderRightWidth: 1,
    borderColor: "#ccc",
  },
});
