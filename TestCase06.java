// Sean Szumlanski
// COP 3503, Fall 2021

// ============================
// RunLikeHell: TestCase06.java
// ============================
// A small test case for RunLikeHell.maxGain(). Keep in mind that these test
// cases are by no means comprehensive! You need to create some of your own.


import java.io.*;
import java.util.*;

public class TestCase06
{
	private static void failwhale()
	{
		System.out.println("fail whale :(");
		System.exit(0);
	}

	public static void main(String [] args)
	{
		int [] blocks = new int[] {1, 15, 3, 6, 17, 2, 1, 20};
		int ans = 52;

		if (RunLikeHell.maxGain(blocks) != ans) failwhale();

		System.out.println("Hooray!");
	}
}
