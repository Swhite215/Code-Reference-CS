// React
import React from "react";

// Components
import { View } from "react-native";
import BSensor from "../components/Barometer/Barometer";

export const BarometerScreen = () => {
  return (
    <View className="flex-1 bg-black">
      <BSensor />
    </View>
  );
};
