import React from "react";

// Components
import { View, SafeAreaView, Platform, StatusBar, Text } from "react-native";
import { Footer } from "./src/components/Footer/Footer";
import { Header } from "./src/components/Header/Header";
import ASensor from "./src/components/Accelerometer/Accelerometer";
import GSensor from "./src/components/Gyroscope/Gyroscope";
import BSensor from "./src/components/Barometer/Barometer";

export default App = () => {
  return (
    <SafeAreaView style={styles.safe}>
      <Header></Header>
      <View className="flex-1">
        <ASensor />
        <GSensor />
        <BSensor />
      </View>
      <Footer></Footer>
    </SafeAreaView>
  );
};

const styles = {
  safe: {
    paddingTop: Platform.OS === "android" ? StatusBar.currentHeight : 0,
    flex: 1,
    backgroundColor: "black",
  },
};
