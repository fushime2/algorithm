// 二部マッチング
// http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_7_A
// https://beta.atcoder.jp/contests/abc091/tasks/arc092_a

import std.stdio, std.algorithm, std.string, std.conv, std.array, std.range, std.math;

void main() {
    auto bm = new BipartiteMatching();
    int X, Y, E;
    readf("%d %d %d\n", &X, &Y, &E);
    foreach (_; 0..E) {
        int x, y; readf("%d %d\n", &x, &y);
        bm.add_edge(x, X + y, 1);
    }
    int s = X + Y, t = s + 1;
    foreach (to; 0..X)
        bm.add_edge(s, to, 1);
    foreach (from; X..X + Y)
        bm.add_edge(from, t, 1);

    writeln(bm.max_flow(s, t));
}

class BipartiteMatching {
    import std.algorithm : fill, min;
    import std.conv : to;
    immutable int INF = 114514810;
    immutable int VMAX = 300;

    struct Edge { int to, cap, rev; }
    Edge[][] G;
    bool[] used; // dfs したか

    this() {
        used.length = G.length = VMAX;
    }

    void add_edge(int from, int to, int cap) {
        G[from] ~= Edge(to, cap, G[to].length.to!int);
        G[to]   ~= Edge(from, 0, G[from].length.to!int - 1);
    }
    // 増加パスを探す
    int dfs(int v, int t, int f) {
        if (v == t) return f;
        used[v] = true;
        foreach (ref e; G[v]) if (!used[e.to] && e.cap > 0) {
            int d = dfs(e.to, t, min(f, e.cap));
            if (d > 0) {
                e.cap -= d;
                G[e.to][e.rev].cap += d;
                return d;
            }
        }
        return 0;
    }
    int max_flow(int s, int t) {
        int flow;
        while (1) {
            fill(used, false);
            int f = dfs(s, t, INF);
            if (f == 0) return flow;
            flow += f;
        }
        assert(false);
    }
}
