# build
```zsh
mix escript.build
```

# test
## command
```zsh
./executable_example --upcase --trim --after add test_string test_string2
```

## result
```
options: [upcase: true, trim: true, after: "add"]
arguments: ["test_string", "test_string2"]
TEST_STRING_add
TEST_STRING2_add
```