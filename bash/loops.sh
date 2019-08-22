# Declare Array Variable
my_array=($(ls site/*.fileExtension))

# Loop Through Array
for i in "${my_array[@]}"
do
   # Perform Code Here
done

count=1

# While Loop
while [ "$count" -le 5 ]; do
	echo $count
	count=$((count + 1))
done
echo "Finished"
