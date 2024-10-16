// Sean Szumlanski
// COP 3503, Fall 2021

// ============================
// RunLikeHell: TestCase02.java
// ============================
// A brief test case to help ensure you've implemented the hoursSpent() method
// correctly.


import java.io.*;
import java.util.*;

public class TestCase02
{
	private static void failwhale()
	{
		System.out.println("fail whale :(");
		System.exit(0);
	}

	public static void main(String [] args)
	{
		double hours = RunLikeHell.hoursSpent();
		if (hours <= 0.0) failwhale();

		System.out.println("Hooray!");
	}
}
