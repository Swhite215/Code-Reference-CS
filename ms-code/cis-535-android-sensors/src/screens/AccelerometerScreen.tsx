// React
import React from "react";

// Components
import { View } from "react-native";
import ASensor from "../components/Accelerometer/Accelerometer";

export const AccelerometerScreen = () => {
  return (
    <View className="flex-1 bg-black">
      <ASensor />
    </View>
  );
};
