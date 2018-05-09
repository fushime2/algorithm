//
// $ dmd margesort.d -main -unittest
//
import std.stdio;

T[] margesort(T)(T[] a) {
    int n = a.length;
    if (n <= 1) return a;

    T[] left = a[0..n/2].margesort;
    T[] right = a[n/2..$].margesort;

    T[] marge(T[] left, T[] right) {
        T[] ret;
        int li, ri;
        foreach (i; 0..n) {
            if (ri == right.length)
                ret ~= left[li++];
            else if (li == left.length)
                ret ~= right[ri++];
            else if (left[li] < right[ri])
                ret ~= left[li++];
            else
                ret ~= right[ri++];
        }
        return ret;
    }

    return marge(left, right);
}

unittest {
    import std.algorithm: isSorted;
    int[] emptyList;
    int[][] intLists = [
        emptyList,
        [0],
        [3,2,1],
        [1,1,4,5,1,4],
        [1,2,3,4,5,6],
        [3,1,4,1,5,9,2,6,5,3,5,8,9]
    ];
    foreach (intList; intLists) {
        assert(intList.margesort.isSorted);
    }
    assert(['d','b','c','a'].margesort.isSorted);
    writeln("Unittests succeeded.");
}
