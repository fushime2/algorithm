import std.stdio;
import core.stdc.stdio;

class UnionFind {
    import std.algorithm.mutation;
    int[] p;
    this(int n) {
        p.length = n;
        p[0..$] = -1;
    }
    bool unite(int u, int v){
        u = root(u); v = root(v);
        if (u == v) return false;
        if (p[u] > p[v]) swap(u, v);
        p[u] += p[v]; p[v] = u;
        return true;
    }
    bool same(int u, int v){ return root(u) == root(v); }
    int root(int u){ return p[u] < 0 ? u : (p[u] = root(p[u])); }
    int size(int u){ return -p[u]; }
}

void main() {
    int N, Q;
    scanf("%d%d", &N, &Q);
    auto uf = new UnionFind(N);
    foreach(_; 0..Q) {
        int P, A, B;
        scanf("%d%d%d", &P, &A, &B);
        if (!P)
            uf.unite(A, B);
        else
            writeln(uf.same(A, B) ? "Yes" : "No");
    }
}
