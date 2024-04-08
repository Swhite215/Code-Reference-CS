// React
import React from "react";

// Components
import { Button, TouchableOpacity, View, Text } from "react-native";
import CustomNavButton from "../components/CustomNavButton/CustomNavButton";

export const SensorSelectionScreen = ({ navigation }) => {
  return (
    <View className="flex-1 flex-col w-full h-full bg-black">
      <Text className="text-white text-xl self-center">
        CIS 535 Sensor Project by WHITSPEN
      </Text>
      <Text className="text-white self-center text-lg">UMID: 93474753</Text>
      <CustomNavButton navigation={navigation} title="Accelerometer" />
      <CustomNavButton navigation={navigation} title="Gyroscope" />
    </View>
  );
};
