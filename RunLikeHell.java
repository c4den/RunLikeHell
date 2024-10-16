// Caden Peterson
// ca281025
// COP3503, Fall Semester 2021

import java.util.*;

public class RunLikeHell
{
    public static int totalKnowledge = 0;

    public static int maxGainRecur(int [] blocks)
    {
        // this constructor lets me simply edit the array that's put in hee hee
        int [] arr = new int [blocks.length];
        return maxGainRecur(arr, true, 0);
    }

    public static int maxGainRecur(int [] blocks, boolean canTake, int totalKnowledge)
    {
        
        // if the array is of length one and we can take a block, then why wouldn't we take the final one?
        if (blocks.length == 1 && canTake == true)
        {
            totalKnowledge += blocks[blocks.length - 1];
            return totalKnowledge;
        }

        // if we can't take, and we don't go out of bounds, try the next value.
        if (canTake == false && blocks.length >= 1)
        {
            maxGainRecur(Arrays.copyOf(blocks, blocks.length - 1), true, totalKnowledge);
        }

        // if we can take and we won't go out of bounds
        if (canTake == true && blocks.length > 1)
        {
            // if the current index is greater than the next, we take this current one, and set our 'canTake' flag to false, because we can't
            if (blocks[blocks.length - 1] > blocks[blocks.length - 2])
            {
                maxGainRecur(Arrays.copyOf(blocks, blocks.length - 1), false, totalKnowledge);
            }
        }

        return totalKnowledge;
    }

    // this is the dynamic programming solution? I don't know if this is actually DP
    // I doubt it's this easy.
    public static int maxGain(int [] blocks)
    {
        int totalKnowledge = 0;
        boolean canTake = true;

        // for the length of blocks given - we're 'looking' forward by moving backwards through arr
        for (int i = blocks.length; i >= 0; i--)
        {
            
            // if i is greater than 0 (out of bounds check) and we can take a piece, we take it.
            if (i > 0 && canTake)
            {
                // adding it to the total knowledge we've gained, and we toggle canTake
                if (blocks[i] > blocks[i-1])
                {
                    totalKnowledge += blocks[i];
                    canTake = !canTake;
                    continue;
                }
            }

            // if we hit this check, then we're at index 0, and we can take it. so take it.
            if (canTake)
            {
                totalKnowledge += blocks[i];
            }
        }
        
        // after we've exhausted everything. return. O(1) space complexity, O(n) runtime. hm.
        return totalKnowledge;
    }

    public static double difficultyRating()
    {
        return 2.5;
    }

    public static double hoursSpent()
    {
        return 2.0;
    }
}