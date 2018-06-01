#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

#define N 6

struct Node {
    Node *head = NULL;
    int data = 0;
    Node *next = NULL;
};

typedef Node *List;

Node* makeNode(void) {
    return (Node*)malloc(sizeof(Node));
}

// return length of list without head;
int len(List list) {
    int cnt = 0;
    for (; list != NULL; list = list->next) {
        cnt++;
    }
    return cnt - 1;
}

void printList(List list) {
    for (; list != NULL; list = list->next) {
        // ignore head
        if (list->head == NULL) continue;
        printf("%d", list->data);
        printf(list->next != NULL ? ", " : "\n");
    }
}

int find(List list, int x) {
    for (; list != NULL; list = list->next) {
        if (list->head == NULL) continue;
        if (list->data == x) return 1;
    }
    return 0;
}

void insert(List list, int i, int x) {
    int cnt = 0;
    Node *cur = list;
    for (; cur != NULL; cur = cur->next, cnt++) {
        if (cnt == i) break;
    }
    Node* node = NULL; node = makeNode();
    node->data = x;
    node->next = cur->next;
    node->head = cur;
    cur->next = node;
}

void append(List list, int x) {
    insert(list, len(list), x);
}

void deleteElement(List list, int i) {
    int cnt = 0;
    Node *cur = list;
    for (; cur->next != NULL; cur = cur->next, cnt++) {
        if (cnt - 1 == i) break;
    }
    assert(cur != NULL);
    if (i == len(list)) {
        cur->head->next = NULL;
    }
    else {
        cur->head->next = cur->next;
        cur->next->head = cur->head;
    }
    free(cur);
}

void pop(List list) {
    deleteElement(list, len(list));
}

// return empty list
List makeList() {
    // initialize head-node
    Node* node = NULL;
    node = makeNode();
    node->head = node->next = NULL;
    node->data = 0;
    return node;
}

void test() {
    List list = makeList();
    assert(len(list) == 0);

    int a[N] = {0,1,2,3,4,5};
    for (int i = 0; i < N; i++) {
        append(list, a[i]);
    }
    assert(len(list) == N);
    for (int i = 0; i < N; i++) {
        assert(find(list, a[i]));
    }
    printList(list);

    insert(list, 2, 114514);
    printList(list);
    assert(len(list) == N + 1);

    deleteElement(list, 2);
    assert(len(list) == N);
    while (len(list) > 0)
        pop(list);
    assert(len(list) == 0);
}

int main() {
    test();
    puts("All tests passed.");
    return 0;
}
