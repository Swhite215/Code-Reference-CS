import React from "react";
import { TouchableOpacity, Text, View } from "react-native";

export default function CustomNavButton({ navigation, title }) {
  return (
    <TouchableOpacity
      className="flex w-11/12 h-20 border-2 border-white rounded-lg bg-black items-center self-center justify-center mt-2"
      onPress={() => navigation.navigate(title)}
    >
      <Text className="text-white text-2xl">{title}</Text>
      <View className="w-full flex-row pl-2 justify-around">
        <View className="flex-row">
          <Text className="text-white">Status: </Text>
          <Text className="text-green-500">ENABLED</Text>
        </View>
        <View className="flex-row">
          <Text className="text-white">Update Rate: </Text>
          <Text className="text-green-500">
            {title === "Gyroscope" ? "300ms" : "200ms"}
          </Text>
        </View>
      </View>
    </TouchableOpacity>
  );
}
