# Example Conditional Flow with IF


if [ condition ]; then 
  # Execute code if true
else 
  # Execute code if false;
fi 

FILE=~/basic.sh

if [ -e "$FILE" ]; then
	
	if [ -f "$FILE" ]; then
		echo "$FILE is a regular file."
	fi

	if [ -d "$FILE" ]; then
		echo "$FILE is a directory."
	fi
	
	if [ -r "$FILE" ]; then
		echo "$FILE is a readable."
	fi

	if [ -w "$FILE" ]; then
		echo "$FILE is a writable."
	fi

	if [ -x "$FILE" ]; then
		echo "$FILE is a executable."
	fi	

else
	echo "$FILE does not exist!"
	exit 1
fi

ANSWER="maybe"

if [ -z "$ANSWER" ]; then
	echo "There is no answer." >&2
	exit 1
fi

if [ "$ANSWER" = "yes" ]; then
	echo "The answer is yes!"
elif [ "$ANSWER" = "no" ]; then
	echo "The answer is no!"
elif [ "$ANSWER" = "maybe" ]; then
	echo "The answer is maybe!"
else
	echo "The answer is UNKNOWN"
fi

