// React
import React from "react";

// Components
import { View } from "react-native";
import GSensor from "../components/Gyroscope/Gyroscope";

export const GyroscopeScreen = () => {
  return (
    <View className="flex-1 bg-black">
      <GSensor />
    </View>
  );
};
