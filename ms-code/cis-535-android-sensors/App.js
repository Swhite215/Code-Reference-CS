import React from "react";

// Components
import { SafeAreaView, Platform, StatusBar } from "react-native";
import { Footer } from "./src/components/Footer/Footer";
import { Header } from "./src/components/Header/Header";
import { SensorSelectionScreen } from "./src/screens/SensorSelectionScreen";
import { GyroscopeScreen } from "./src/screens/GyroscopeScreen";
import { BarometerScreen } from "./src/screens/BarometerScreen";
import { AccelerometerScreen } from "./src/screens/AccelerometerScreen";

// Navigation
import { NavigationContainer } from "@react-navigation/native";
import { createNativeStackNavigator } from "@react-navigation/native-stack";
const Stack = createNativeStackNavigator();

const screens = [
  {
    name: "Sensor Selection",
    component: SensorSelectionScreen,
  },
  {
    name: "Accelerometer",
    component: AccelerometerScreen,
  },
  {
    name: "Gyroscope",
    component: GyroscopeScreen,
  },
  {
    name: "Barometer",
    component: BarometerScreen,
  },
];

export default App = () => {
  return (
    <SafeAreaView style={styles.safe}>
      <Header />
      <NavigationContainer>
        <Stack.Navigator>
          {screens.map((screen) => (
            <Stack.Screen
              key={screen.name}
              name={screen.name}
              component={screen.component}
              screenOptions={{ headerShown: false }}
            />
          ))}
        </Stack.Navigator>
      </NavigationContainer>
      <Footer />
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
