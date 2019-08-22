# Example GREP Commands, a tool for searching files

grep pattern file

grep -i pattern file # ignores case
grep -c pattern file # count of lines where pattern occurs in file
grep -v pattern file # shows lines where pattern does not exist
grep -n pattern file # shows line numbers

grep -i '^....$' /usr/share/dict/words # neat trick to search dictionary for similar words

