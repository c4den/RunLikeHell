// Sean Szumlanski
// COP 3503, Fall 2021

// ============================
// RunLikeHell: TestCase10.java
// ============================
// A larger test case for RunLikeHell.maxGain(). This will be very slow with the
// recursive approach.


import java.io.*;
import java.util.*;

public class TestCase10
{
	private static void failwhale()
	{
		System.out.println("fail whale :(");
		System.exit(0);
	}

	private static void failbunny()
	{
		System.out.println("fail bunny :(");  // your program is too slow
		System.exit(0);
	}

	public static void main(String [] args)
	{
		int [] blocks = new int[] {573, 216, 451, 236, 42, 243, 743, 162, 317, 323, 4,
		                           407, 230, 380, 177, 89, 596, 421, 643, 655, 735, 441,
		                           408, 716, 449, 781, 28, 346, 241, 229, 697, 354, 685,
		                           628, 535, 463, 578, 275, 786, 362, 488, 372, 68, 434,
		                           687};
		int ans = 11260;

		long start, end;

		start = System.nanoTime();
		int result = RunLikeHell.maxGain(blocks);
		end = System.nanoTime();

		if (result != ans) failwhale();
		if (end - start > 5000000) failbunny();

		System.out.println("Hooray!");
	}
}
