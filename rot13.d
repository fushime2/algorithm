string rot13(string s) {
    import std.ascii : isAlpha, isUpper;
    string r;
    foreach (c; s) {
        r ~= !c.isAlpha ? c
            : c.isUpper ? 'A' + (c - 'A' + 13) % 26
            : 'a' + (c - 'a' + 13) % 26;
    }
    return r;
}

unittest {
    assert(rot13("a") == "n");
    assert(rot13("n") == "a");
    assert(rot13("abcde") == "nopqr");
    assert(rot13("nopqr") == "abcde");
    assert(rot13("A") == "N");
    assert(rot13("N") == "A");
    assert(rot13("ABCDE") == "NOPQR");
    assert(rot13("NOPQR") == "ABCDE");
    assert(rot13("0") == "0");
}
