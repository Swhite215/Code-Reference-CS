hadoop fs -mkdir -p user/cloudera/input
hadoop fs -put /home/cloudera/Desktop/TestWC.txt /user/cloudera/input

hadoop jar /home/cloudera/workspace/myproject.jar WordCount /user/cloudera/input /user/cloudera/output
hadoop jar /home/cloudera/Desktop/myproject.jar WordCount /user/cloudera/input /user/cloudera/output

hadoop fs -get /user/cloudera/output

hadoop fs -rm hdfs://quickstart.cloudera:8020/user/cloudera/input/*

hadoop fs -rmdir hdfs://quickstart.cloudera:8020/user/cloudera/input

hadoop fs -rm hdfs://quickstart.cloudera:8020/user/cloudera/output/*

hadoop fs -rmdir hdfs://quickstart.cloudera:8020/user/cloudera/output

http://localhost:8088  (to visualize your cluster jobs)