#!/bin/bash

# Sean Szumlanski
# COP 3503, Fall 2021

# ========================
# RunLikeHell: test-all.sh
# ========================
# You can run this script at the command line like so:
#
#   bash test-all.sh
#
# For more details, see the assignment PDF.


################################################################################
# Shell check.
################################################################################

# Running this script with sh instead of bash can lead to false positives on the
# test cases. Yikes! These checks ensure the script is not being run through the
# Bourne shell (or any shell other than bash).

if [ "$BASH" != "/bin/bash" ] && [ "$BASH" != "/usr/bin/bash" ]; then
  echo ""
  echo " Bloop! Please use bash to run this script, like so: bash test-all.sh"
  echo ""
  exit
fi

if [ -z "$BASH_VERSION" ]; then
  echo ""
  echo " Bloop! Please use bash to run this script, like so: bash test-all.sh"
  echo ""
  exit
fi


################################################################################
# Initialization.
################################################################################

PASS_CNT=0
NUM_TEST_CASES=10

# +1 for the indentation check below.
TOTAL_TEST_CNT=`expr $NUM_TEST_CASES + 1`


################################################################################
# Check for commands that are required by this test script.
################################################################################

# This command is necessary in order to run all the test cases in sequence.
if ! [ -x "$(command -v seq)" ]; then
	echo ""
	echo " Error: seq command not found. You might see this message if you're"
	echo "        running this script on an old Mac system. Please be sure to"
	echo "        test your final code on Eustis. Aborting test script."
	echo ""
	exit
fi

# This command is necessary for various warning checks.
if ! [ -x "$(command -v grep)" ]; then
	echo ""
	echo " Error: grep command not found. You might see this message if you're"
	echo "        running this script on an old Mac system. Please be sure to"
	echo "        test your final code on Eustis. Aborting test script."
	echo ""
	exit
fi


################################################################################
# Check that all required files are present.
################################################################################

if [ ! -f RunLikeHell.java ]; then
	echo ""
	echo " Error: You must place RunLikeHell.java in this directory"
	echo "        before we can proceed. Aborting test script."
	echo ""
	exit
fi

if [ ! -d sample_output ]; then
	echo ""
	echo " Error: You must place the sample_output folder in this directory"
	echo "        before we can proceed. Aborting test script."
	echo ""
	exit
fi

for i in `seq -f "%02g" 1 $NUM_TEST_CASES`;
do
	if [ ! -f TestCase$i.java ]; then
		echo ""
		echo " Error: You must place TestCase$i.java in this directory before we"
		echo "        can proceed. Aborting test script."
		echo ""
		exit
	fi
done

for i in `seq -f "%02g" 1 $NUM_TEST_CASES`;
do
	if [ ! -f sample_output/TestCase$i-output.txt ]; then
		echo ""
		echo " Error: You must place TestCase$i-output.txt in the sample_output directory"
		echo "        before we can proceed. Aborting test script."
		echo ""
		exit
	fi
done


################################################################################
# Compile and run test cases.
################################################################################

echo ""
echo "================================================================"
echo "Running test cases..."
echo "================================================================"
echo ""

for i in `seq -f "%02g" 1 $NUM_TEST_CASES`;
do
	echo -n "  [Test Case] Checking TestCase$i... "

	# Make sure any pre-compiled classes get re-compiled.
    rm -rf *.class

	# Attempt to compile, and check for compilation failure.
	javac RunLikeHell.java TestCase$i.java 2> /dev/null
	compile_val=$?
	if [[ $compile_val != 0 ]]; then
		echo "** fail ** (failed to compile)"
		continue
	fi

	# Run program. Capture return value to check whether it crashes.
	java TestCase$i > myoutput.txt 2> /dev/null
	execution_val=$?
	if [[ $execution_val != 0 ]]; then
		echo "** fail ** (program crashed)"
		continue
	fi

	# Run diff and capture its return value.
	diff myoutput.txt sample_output/TestCase$i-output.txt > /dev/null
	diff_val=$?
	
	# Output results based on diff's return value.
	if  [[ $diff_val != 0 ]]; then
		echo "** fail ** (output does not match)"
	else
		echo "PASS!"
		PASS_CNT=`expr $PASS_CNT + 1`
	fi
done


############################################################################
# Check for tabs vs. spaces.
############################################################################

echo ""
echo "================================================================"
echo "Checking for tabs vs. spaces..."
echo "================================================================"
echo ""

if ! [ -x "$(command -v grep)" ]; then
	echo "  Skipping tabs vs. spaces check; grep not installed. You"
	echo "  might see this message if you're running this script on a"
	echo "  Mac. Please be sure to test your final code on Eustis."
elif ! [ -x "$(command -v awk)" ]; then
	echo "  Skipping tabs vs. spaces check; awk not installed. You"
	echo "  might see this message if you're running this script on a"
	echo "  Mac. Please be sure to test your final code on Eustis."
else
	num_spc_lines=`grep "^ " RunLikeHell.java | wc -l | awk '{$1=$1};1'`
	num_tab_lines=`grep "$(printf '^\t')" RunLikeHell.java | wc -l | awk '{$1=$1};1'`
	num_und_lines=`grep "$(printf '^[^\t ]')" RunLikeHell.java | wc -l | awk '{$1=$1};1'`

	echo "  Number of lines beginning with spaces: $num_spc_lines"
	echo "  Number of lines beginning with tabs: $num_tab_lines"
	echo "  Number of lines with no indentation: $num_und_lines"

	if [ "$num_spc_lines" -gt 0 ] && [ "$num_tab_lines" -gt 0 ]; then
		echo ""
		echo "  Whoa, buddy! It looks like you're starting some lines of code with"
		echo "  tabs, and other lines of code with spaces. You'll need to choose"
		echo "  one or the other."
		echo ""
		echo "  Try running the following commands to see which of your lines begin"
		echo "  with spaces (the first command below) and which ones begin with tabs"
		echo "  (the second command below):"
		echo ""
		echo "     grep \"^ \" RunLikeHell.java -n"
		echo "     grep \"\$(printf '^\t')\" RunLikeHell.java -n"
	elif [ "$num_spc_lines" -gt 0 ]; then
		echo ""
		echo "  Looks like you're using spaces for all your indentation! (Yay!)"
		PASS_CNT=`expr $PASS_CNT + 1`
	elif [ "$num_tab_lines" -gt 0 ]; then
		echo ""
		echo "  Looks like you're using tabs for all your indentation! (Yay!)"
		PASS_CNT=`expr $PASS_CNT + 1`
	else
		echo ""
		echo "  Whoa, buddy! It looks like none of your lines of code are indented!"
	fi
fi


################################################################################
# Cleanup phase.
################################################################################

rm -f *.class
rm -f myoutput.txt


################################################################################
# Final thoughts.
################################################################################

echo ""
echo "================================================================"
echo "Final Report"
echo "================================================================"

if [ $PASS_CNT -eq $TOTAL_TEST_CNT ]; then
	echo ""
	echo "              ,)))))))),,,"
	echo "            ,(((((((((((((((,"
	echo "            )\\\`\\)))))))))))))),"
	echo "     *--===///\`_    \`\`\`((((((((("
	echo "           \\\\\\ b\\  \\    \`\`)))))))"
	echo "            ))\\    |     ((((((((               ,,,,"
	echo "           (   \\   |\`.    ))))))))       ____ ,)))))),"
	echo "                \\, /  )  ((((((((-.___.-\"    \`\"((((((("
	echo "                 \`\"  /    )))))))               \\\`)))))"
	echo "                    /    ((((\`\`                  \\((((("
	echo "              _____|      \`))         /          |)))))"
	echo "             /     \\                 |          / ((((("
	echo "            /  --.__)      /        _\\         /   )))))"
	echo "           /  /    /     /'\`\"~----~\`  \`.       \\   (((("
	echo "          /  /    /     /\`              \`-._    \`-. \`)))"
	echo "         /_ (    /    /\`                    \`-._   \\ (("
	echo "        /__|\`   /   /\`                        \`\\\`-. \\ ')"
	echo "               /  /\`                            \`\\ \\ \\"
	echo "              /  /                                \\ \\ \\"
	echo "             /_ (                                 /_()_("
	echo "            /__|\`                                /__/__|"
	echo ""
	echo "                             Legendary."
	echo ""
	echo "                10/10 would run this program again."
	echo ""
	echo "  CONGRATULATIONS! You appear to be passing all the test cases!"
	echo "  (Now, don't forget to create some extra test cases of your own."
	echo "  These test cases are not necessarily comprehensive.)"
	echo ""
else
	echo "                           ."
	echo "                          \":\""
	echo "                        ___:____     |\"\\/\"|"
	echo "                      ,'        \`.    \\  /"
	echo "                      |  o        \\___/  |"
	echo "                    ~^~^~^~^~^~^~^~^~^~^~^~^~"
	echo ""
	echo "                           (fail whale)"
	echo ""
	echo "  The fail whale is friendly and adorable! He is not here to"
	echo "  demoralize you, but rather, to bring you comfort and joy"
	echo "  in your time of need. \"Keep plugging away,\" he says! \"You"
	echo "  can do this!\""
	echo ""
	echo "  For instructions on how to run these test cases individually"
	echo "  and inspect how your output differs from the expected output,"
	echo "  be sure to consult the assignment PDF."
	echo ""
	echo "  You must also pass the indentation check in order to part"
	echo "  ways with the fail whale."
	echo ""
fi
