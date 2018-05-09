bool contain(string a, string b) {
    import std.conv : to;
    immutable ulong B = 10^^9 + 7;
    int al = a.length.to!int;
    int bl = b.length.to!int;
    if (al > bl) return false;

    immutable ulong t = B ^^ al;

    ulong ah, bh;
    foreach (i; 0..al) {
        ah = ah * B + a[i];
        bh = bh * B + b[i];
    }
    if (ah == bh) return true;

    foreach (i; 0..bl - al) {
        bh = bh * B + b[i + al] - t * b[i];
        if (ah == bh) return true;
    }
    return false;
}

unittest {
    string[][] ok = [
        ["", ""],
        ["aaa", "aaaaa"],
        ["a","ababababab"],
        ["ab","ababababab"],
        ["aba","ababababab"],
        ["abab","ababababab"],
        ["ababa","ababababab"]
    ];
    foreach (s; ok) {
        assert(contain(s[0], s[1]));
    }
}
