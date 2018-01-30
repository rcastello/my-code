EmptyQueue = 3

### My attempt

class PriorityQueue():

    def __init__(self):
        # self._dict={0:[], 1:[], 2:[], ...} 
        self._list=[[],[],[],[],[],[]]
        
    def __len__(self):
        pass
        #return len(self._list)
        
    def add(self, item, priority=2):
        
        self._list[priority].append(item)
        
        #self._list.append()
        #if priority ==1:
        #self._list.insert(0,item)
            
    def pop(self):
        return self._list.pop(0)
    
    
#### PPOR MAN solution

class PriorityQueue_very_slow():

    def __init__(self):
        self._q =[]
        
    def add(self, item, priority=2):
        if type(priority) is not int:
            raise TypeError
        if not(0<=priority<5):
            raise ValueError
        self._q.append((item, priority))

    def pop(self):
        if not self._q:
            raise EmptyQueue
        self._q.sort(lambda a,b:cmp(a[1],b[1]))
        return self._q.pop(0)[0]

    def __len__(self):
        return len(self._q)


#### OPTIMAL model solution

class PriorityQueue:
    
    def __init__(self):
        self._queues = [[],[],[],[],[]]

    def pop(self):
        for queue in self._queues:
            if queue:
                return queue.pop()
        raise EmptyQueue("pop from empty queue")

    def add(self, item, priority=2):
        if not 0 <= priority < 5: 
            raise ValueError("priority must be in range 0-4")
        self._queues[priority].insert(0,item)

    def __len__(self):
        return sum(map(len,self._queues))
