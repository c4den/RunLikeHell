// Sean Szumlanski
// COP 3503, Fall 2021

// ============================
// RunLikeHell: TestCase01.java
// ============================
// A brief test case to help ensure you've implemented the difficultyRating()
// method correctly.


import java.io.*;
import java.util.*;

public class TestCase01
{
	private static void failwhale()
	{
		System.out.println("fail whale :(");
		System.exit(0);
	}

	public static void main(String [] args)
	{
		double difficulty = RunLikeHell.difficultyRating();
		if (difficulty < 1.0 || difficulty > 5.0) failwhale();

		System.out.println("Hooray!");
	}
}
