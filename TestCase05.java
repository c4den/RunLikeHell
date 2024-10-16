// Sean Szumlanski
// COP 3503, Fall 2021

// ============================
// RunLikeHell: TestCase05.java
// ============================
// A small test case for RunLikeHell.maxGain(). Keep in mind that these test
// cases are by no means comprehensive! You need to create some of your own.


import java.io.*;
import java.util.*;

public class TestCase05
{
	private static void failwhale()
	{
		System.out.println("fail whale :(");
		System.exit(0);
	}

	public static void main(String [] args)
	{
		int [] blocks = new int[] {9, 20, 13, 16, 9, 6, 9};
		int ans = 45;

		if (RunLikeHell.maxGain(blocks) != ans) failwhale();

		System.out.println("Hooray!");
	}
}
