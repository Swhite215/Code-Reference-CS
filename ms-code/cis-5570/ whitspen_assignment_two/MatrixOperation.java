import java.io.IOException;
import java.util.StringTokenizer;
import java.util.HashMap;
import java.util.Map;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.inaput.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

public class MatrixOperation {

    public static class MatrixMapper
            extends Mapper<Object, Text, Text, Text> {

        private Text Key = new Text();
        private Text Value = new Text();
        private int nCols;
        private int mRows;

        @Override
        protected void setup(Context context) throws IOException, InterruptedException {
            Configuration conf = context.getConfiguration();
            nCols = conf.getInt("nCols", 0);
            mRows = conf.getInt("mRows", 0);
        }

        @Override
        public void map(Object key, Text value, Context con) throws IOException, InterruptedException {
            StringTokenizer itr = new StringTokenizer(value.toString());
            String x = itr.nextToken();
            int row = Integer.parseInt(itr.nextToken());
            int col = Integer.parseInt(itr.nextToken());
            int val = Integer.parseInt(itr.nextToken());
            if (x.equals("M")) {
                for (int k = 0; k < nCols; k++) {
                    Key.set(row + " " + k);
                    Value.set("M " + col + " " + val);
                    con.write(Key, Value);
                }
            } else if (x.equals("N")) {
                for (int k = 0; k < mRows; k++) {
                    Key.set(k + " " + col);
                    Value.set("N " + row + " " + val);
                    con.write(Key, Value);
                }
            }
        }
    }

    public static class MatrixReducer
            extends Reducer<Text, Text, Text, IntWritable> {

        private IntWritable result = new IntWritable();

        @Override
        public void reduce(Text key, Iterable<Text> values, Context con) throws IOException, InterruptedException {
            Map<Integer, Integer> M = new HashMap<>();
            Map<Integer, Integer> N = new HashMap<>();
            for (Text val : values) {
                String[] parts = val.toString().split(" ");
                if (parts[0].equals("M")) {
                    int col = Integer.parseInt(parts[1]);
                    int value = Integer.parseInt(parts[2]);
                    M.put(col, value);
                } else if (parts[0].equals("N")) {
                    int row = Integer.parseInt(parts[1]);
                    int value = Integer.parseInt(parts[2]);
                    N.put(row, value);
                }
            }

            int sum = 0;
            for (Map.Entry<Integer, Integer> x : M.entrySet()) {
                int col = x.getKey();
                if (N.containsKey(col)) {
                    sum += x.getValue() * N.get(col);
                }
            }
            result.set(sum);
            con.write(key, result);
        }

        public static void main(String[] args) throws Exception {
            Configuration conf = new Configuration();
            conf.setInt("mRows", Integer.parseInt("2"));
            conf.setInt("nCols", Integer.parseInt("2"));
            Job job = Job.getInstance(conf, "ary mult");
            job.setJarByClass(MatrixOperation.class);
            job.setMapperClass(MatrixMapper.class);
            job.setReducerClass(MatrixReducer.class);
            job.setOutputKeyClass(Text.class);
            job.setOutputValueClass(Text.class);
            FileInputFormat.addInputPath(job, new Path("input"));
            FileOutputFormat.setOutputPath(job, new Path("output"));
            System.exit(job.waitForCompletion(true) ? 0 : 1);
        }
    }
}