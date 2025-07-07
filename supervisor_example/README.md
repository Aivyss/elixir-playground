# setting
```zsh
mix new supervisor_example --sup
```

# test
```
iex -S mix

iex(1)> SimpleQueue.queue
[1, 2, 3]
iex(2)> SimpleQueue.dequeue
1
iex(3)> SimpleQueue.queue
[2, 3]
iex(4)> SimpleQueue.enqueue 25
:ok
iex(5)> SimpleQueue.queue
[2, 3, 25]
```