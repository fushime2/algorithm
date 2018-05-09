import std.stdio;

T[] quicksort(T)(T[] a) {
    int n = a.length;
    if (n <= 1) return a;

    int piv = n / 2;
    T[] small, big;
    foreach (i, v; a) {
        if (i == piv) continue;
        if (v < a[piv])
            small ~= v;
        else
            big ~= v;
    }
    return quicksort(small) ~ a[piv] ~ quicksort(big);
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
        assert(intList.quicksort.isSorted);
    }
    assert(['d','b','c','a'].quicksort.isSorted);
    writeln("Unittests succeeded.");
}
