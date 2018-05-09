// int の queue
class Queue(T) {
    T[] queue;
    this() { }
    T front(){
        return queue[0];
    }
    void pop(){
        queue = queue[1..$];
    }
    void push(T x){
        queue ~= x;
    }
    int size(){
        return queue.length;
    }
}

