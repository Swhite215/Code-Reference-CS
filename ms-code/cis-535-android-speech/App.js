// React native
import { useEffect, useState } from "react";
import {
  StyleSheet,
  Text,
  View,
  TouchableHighlight,
  TextInput,
  ActivityIndicator,
} from "react-native";

// Voice API
import Voice from "@pedrol2b/react-native-voice";

// Chart
import { LineChart } from "react-native-chart-kit";
import { Dimensions } from "react-native";
const screenWidth = Dimensions.get("window").width;

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

export default function App() {
  const [state, setState] = useState({
    recognized: "",
    pitch: "",
    error: "",
    end: "",
    started: "",
    results: [],
    partialResults: [],
  });
  const [active, setActive] = useState(false);
  const [loading, setLoading] = useState(false);

  const [keyValues, setKeyValues] = useState({
    leftIndex: 0,
    xAxis: [0, 1, 2, 3, 4],
    dataPoints: [0, 0, 0, 0, 0],
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
    legend: ["Volume"],
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
      keyValues.xAxis[4] + 1,
    ];

    let chart = {
      labels: [],
      datasets: [],
      legend: ["Volume"],
    };

    // Determine New Values DataSet
    let valueDataSet = {
      data: [
        keyValues.dataPoints[keyValues.leftIndex],
        keyValues.dataPoints[keyValues.leftIndex + 1],
        keyValues.dataPoints[keyValues.leftIndex + 2],
        keyValues.dataPoints[keyValues.leftIndex + 3],
        keyValues.dataPoints[keyValues.leftIndex + 4],
      ],
      color: (opacity = 1) => `rgba(0, 255, 0, ${opacity})`, // optional
      strokeWidth: 2, // optional
    };

    // Update Left Index
    keyValues.leftIndex += 1;

    chart.labels = newXAxis;
    chart.datasets = [valueDataSet];
    keyValues.xAxis = newXAxis;

    setKeyValues(keyValues);
    setChartData(chart);
  };

  onSpeechStart = (e) => {
    console.log("onSpeechStart: ", e);
    setState({
      recognized: "",
      pitch: "",
      error: "",
      started: true,
      results: [],
      partialResults: [],
      end: "",
    });
    setActive(true);
  };

  onSpeechRecognized = (e) => {
    console.log("onSpeechRecognized: ", e);
    setState({ ...state, recognized: "√" });
  };

  onSpeechEnd = (e) => {
    console.log("onSpeechEnd: ", e);
    setState({ ...state, end: true });
  };

  onSpeechError = (e) => {
    console.log("onSpeechError: ", e);
    setState({ ...state, error: JSON.stringify(e.error) });
  };

  onSpeechResults = (e) => {
    setLoading(false);
    console.log("onSpeechResults: ", e);
    setState({ ...state, results: e.value });
  };

  onSpeechPartialResults = (e) => {
    console.log("onSpeechPartialResults: ", e);
    setState({ ...state, partialResults: e.value });
  };

  onSpeechVolumeChanged = (e) => {
    console.log("onSpeechVolumeChanged: ", e);
    deriveChartData(e.value);
  };

  useEffect(() => {
    async function init() {
      try {
        let services = await Voice.getSpeechRecognitionServices();
        Voice.onSpeechStart = onSpeechStart;
        Voice.onSpeechRecognized = onSpeechRecognized;
        Voice.onSpeechEnd = onSpeechEnd;
        Voice.onSpeechError = onSpeechError;
        Voice.onSpeechResults = onSpeechResults;
        Voice.onSpeechPartialResults = onSpeechPartialResults;
        Voice.onSpeechVolumeChanged = onSpeechVolumeChanged;
      } catch (e) {
        console.log(e);
        console.log("Init Error");
      }
    }

    init();

    return async () => {
      Voice.destroy().then(Voice.removeAllListeners());
    };
  }, []);

  _startRecognizing = async () => {
    setState({
      recognized: "",
      pitch: "",
      error: "",
      started: "",
      results: [],
      partialResults: [],
      end: "",
    });

    try {
      const result = await Voice.start("en-US");
      console.log(result);
      console.log("WORKING");
    } catch (e) {
      console.log("Start Error");
      console.log(e);
    }
  };

  _stopAndDestroy = async () => {
    try {
      setLoading(true);
      await Voice.cancel();
      await Voice.stop();
      await Voice.destroy();
    } catch (e) {
      console.error(e);
    }
  };

  _stopRecognizing = async () => {
    try {
      await Voice.stop();
    } catch (e) {
      console.error(e);
    }
  };

  _cancelRecognizing = async () => {
    try {
      await Voice.cancel();
    } catch (e) {
      console.error(e);
    }
  };

  _destroyRecognizer = async () => {
    try {
      await Voice.destroy();
    } catch (e) {
      console.error(e);
    }
    setState({
      recognized: "",
      pitch: "",
      error: "",
      started: "",
      results: [],
      partialResults: [],
      end: "",
    });
  };

  return (
    <View style={styles.container}>
      <Text style={styles.welcome}>CIS 535 Speech Project by WHITSPEN</Text>
      <Text style={styles.welcome}>UMID: 93474753</Text>
      <Text style={styles.header}>Volume:</Text>
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
      <Text style={styles.stat}>Detected Speech:</Text>
      {state.started ? (
        <ActivityIndicator />
      ) : state.results.length > 0 ? (
        <TextInput
          style={styles.results}
          multiline
          numberOfLines={1}
          value={state.results[0]}
        />
      ) : null}
      <Text style={styles.status}>
        Speech Sensor Status:{" "}
        <Text style={state.started ? styles.active : styles.inactive}>
          {active ? "__ACTIVE" : "INACTIVE"}
        </Text>
      </Text>
      <View style={styles.row}>
        <TouchableHighlight
          onPress={() => {
            _startRecognizing();
          }}
        >
          <Text style={styles.start}>Start</Text>
        </TouchableHighlight>
        <TouchableHighlight onPress={() => _stopAndDestroy()}>
          <Text style={styles.stop}>Stop</Text>
        </TouchableHighlight>
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  active: {
    color: "green",
  },
  inactive: {
    color: "grey",
  },
  start: {
    padding: 10,
    width: 140,
    borderWidth: 1,
    borderStyle: "solid",
    borderColor: "green",
    textAlign: "center",
    justifyContent: "center",
    color: "#FFFFFF",
    fontSize: 22,
    borderRadius: 5,
  },
  stop: {
    padding: 10,
    width: 140,
    borderWidth: 1,
    borderStyle: "solid",
    borderColor: "red",
    textAlign: "center",
    justifyContent: "center",
    color: "#FFFFFF",
    fontSize: 22,
    borderRadius: 5,
  },
  container: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
    backgroundColor: "#000000",
    color: "#FFFFFF",
  },
  welcome: {
    fontSize: 24,
    textAlign: "center",
    color: "#FFFFFF",
  },
  action: {
    textAlign: "center",
    marginVertical: 5,
    fontWeight: "bold",
    color: "#FFFFFF",
  },
  instructions: {
    textAlign: "center",
    marginBottom: 5,
    color: "#FFFFFF",
  },
  stat: {
    textAlign: "center",
    color: "#FFFFFF",
    fontSize: 20,
  },
  statusView: {
    flexDirection: "row",
    borderWidth: 1,
    borderStyle: "solid",
    borderColor: "red",
  },
  status: {
    fontSize: 18,
    color: "#FFFFFF",
    borderWidth: 1,
    borderStyle: "solid",
    borderColor: "blue",
    padding: 10,
    borderRadius: 5,
    marginBottom: 5,
  },
  text: {
    color: "#FFFFFF",
  },
  row: {
    display: "flex",
    flexDirection: "row",
    gap: 5,
  },
  results: {
    color: "#FFFFFF",
    fontStyle: "italic",
    borderWidth: 1,
    borderStyle: "solid",
    borderColor: "white",
    textAlign: "center",
    width: 280,
    padding: 20,
    borderRadius: 5,
    marginBottom: 5,
  },
});
