import React, { useState, useEffect } from "react";
import { StyleSheet, Text, View } from "react-native";
import { Accelerometer } from "expo-sensors";

// Chart
import { Dimensions } from "react-native";
const screenWidth = Dimensions.get("window").width;
import { LineChart } from "react-native-chart-kit";

const chartConfig = {
  backgroundGradientFrom: "#1E2923",
  backgroundGradientFromOpacity: 0,
  backgroundGradientTo: "#08130D",
  backgroundGradientToOpacity: 0.5,
  color: (opacity = 1) => `rgba(26, 255, 146, ${opacity})`,
  strokeWidth: 2, // optional, default 3
  barPercentage: 0.5,
  useShadowColorFromDataset: false, // optional
};

const calculateAccelerometer = (sensorData: {
  x: number;
  y: number;
  z: number;
}): number => {
  return Math.sqrt(
    sensorData.x * sensorData.x +
      (sensorData.y ^ sensorData.y) +
      (sensorData.z ^ sensorData.z)
  );
};

const calculateMean = (
  sensorData: {
    x: number;
    y: number;
    z: number;
  }[]
): number => {
  let sum: number = 0.0;
  let count = sensorData.length;

  for (const data of sensorData) {
    sum += Math.sqrt(
      Math.pow(data.x, 2) + Math.pow(data.y, 2) + Math.pow(data.z, 2)
    );
  }

  return sum / count;
};

const calculateSTD = (
  sensorData: {
    x: number;
    y: number;
    z: number;
  }[]
): number => {
  let sum: number = 0.0;
  let count = sensorData.length;
  let mean = calculateMean(sensorData);

  for (const data of sensorData) {
    sum += Math.pow(
      Math.sqrt(
        Math.pow(data.x, 2) + Math.pow(data.y, 2) + Math.pow(data.z, 2)
      ) - mean,
      2
    );
  }

  return Math.sqrt(sum / (count - 1));
};

export default function ASensor() {
  const [{ x, y, z }, setData] = useState({
    x: 0,
    y: 0,
    z: 0,
  });

  const [chartData, setChartData] = useState({
    labels: [0],
    datasets: [
      {
        data: [0],
        color: (opacity = 1) => `rgba(255, 255, 255, ${opacity})`, // optional
        strokeWidth: 2, // optional
      },
    ],
    legend: ["Loading"],
  });

  const [keyValues, setKeyValues] = useState({
    leftIndex: 0,
    mean: [0, 0, 0, 0, 0],
    std: [0, 0, 0, 0, 0],
    xAxis: [0, 200, 400, 600, 800],
    dataPoints: [
      { x: 0, y: 0, z: 0 },
      { x: 0, y: 0, z: 0 },
      { x: 0, y: 0, z: 0 },
      { x: 0, y: 0, z: 0 },
      { x: 0, y: 0, z: 0 },
    ],
  });

  const deriveChartData = (sensorData) => {
    // Store Sensor Data
    keyValues.dataPoints.push(sensorData);

    // Determine Axis
    let newXAxis = [
      keyValues.xAxis[1],
      keyValues.xAxis[2],
      keyValues.xAxis[3],
      keyValues.xAxis[4],
      keyValues.xAxis[4] + 200,
    ];

    let chart = {
      labels: [],
      datasets: [],
      legend: ["Value", "Mean", "STD"],
    };

    // Determine New Values DataSet
    let valueDataSet = {
      data: [
        calculateAccelerometer(keyValues.dataPoints[keyValues.leftIndex]),
        calculateAccelerometer(keyValues.dataPoints[keyValues.leftIndex + 1]),
        calculateAccelerometer(keyValues.dataPoints[keyValues.leftIndex + 2]),
        calculateAccelerometer(keyValues.dataPoints[keyValues.leftIndex + 3]),
        calculateAccelerometer(keyValues.dataPoints[keyValues.leftIndex + 4]),
      ],
      color: (opacity = 1) => `rgba(0, 255, 0, ${opacity})`, // optional
      strokeWidth: 2, // optional
    };

    // Update Left Index
    keyValues.leftIndex += 1;

    // Determine Mean
    const currentMean = calculateMean(keyValues.dataPoints);
    keyValues.mean.push(currentMean);

    let meanDataSet = {
      data: [
        keyValues.mean[keyValues.leftIndex],
        keyValues.mean[keyValues.leftIndex + 1],
        keyValues.mean[keyValues.leftIndex + 2],
        keyValues.mean[keyValues.leftIndex + 3],
        keyValues.mean[keyValues.leftIndex + 4],
      ],
      color: (opacity = 1) => `rgba(0, 0, 255, ${opacity})`, // optional
      strokeWidth: 2, // optional
    };

    const currentSTD = calculateSTD(keyValues.dataPoints);
    keyValues.std.push(currentSTD);
    let stdDataSet = {
      data: [
        keyValues.std[keyValues.leftIndex],
        keyValues.std[keyValues.leftIndex + 1],
        keyValues.std[keyValues.leftIndex + 2],
        keyValues.std[keyValues.leftIndex + 3],
        keyValues.std[keyValues.leftIndex + 4],
      ],
      color: (opacity = 1) => `rgba(255, 255, 0, ${opacity})`, // optional
      strokeWidth: 2, // optional
    };

    chart.labels = newXAxis;
    chart.datasets = [valueDataSet, meanDataSet, stdDataSet];
    keyValues.xAxis = newXAxis;

    setKeyValues(keyValues);
    setChartData(chart);
  };

  const [subscription, setSubscription] = useState(null);

  const _slow = () => Accelerometer.setUpdateInterval(200);
  const _fast = () => Accelerometer.setUpdateInterval(200);

  const _subscribe = () => {
    setSubscription(Accelerometer.addListener(deriveChartData));
  };

  const _unsubscribe = () => {
    subscription && subscription.remove();
    setSubscription(null);
  };

  useEffect(() => {
    _subscribe();
    return () => _unsubscribe();
  }, []);

  return (
    <View style={styles.container}>
      <Text style={styles.header}>Accelerometer:</Text>
      <View className="flex-row">
        <LineChart
          data={chartData}
          width={screenWidth}
          height={220}
          chartConfig={chartConfig}
          formatYLabel={(yValue) => {
            return yValue;
          }}
        />
      </View>
      <Text className="text-white self-center">Time (x300 ms)</Text>
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
