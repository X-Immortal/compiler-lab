; ModuleID = 'module'
source_filename = "module"

define i32 @factorial(i32 %n) {
entry:
  %n.addr = alloca i32
  %result = alloca i32
  %i = alloca i32
  store i32 %n, i32* %n.addr
  store i32 1, i32* %result
  store i32 1, i32* %i
  br label %while.cond

while.cond:                                       ; preds = %if.end, %entry
  %0 = load i32, i32* %i
  %1 = load i32, i32* %n.addr
  %cmp = icmp sle i32 %0, %1
  br i1 %cmp, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %2 = load i32, i32* %result
  %3 = load i32, i32* %i
  %mul = mul i32 %2, %3
  store i32 %mul, i32* %result
  %4 = load i32, i32* %i
  %add = add i32 %4, 1
  store i32 %add, i32* %i
  %5 = load i32, i32* %i
  %cmp1 = icmp sgt i32 %5, 10
  br i1 %cmp1, label %if.then, label %if.end

if.then:                                          ; preds = %while.body
  br label %while.end

if.end:                                           ; preds = %while.body
  br label %while.cond

while.end:                                        ; preds = %if.then, %while.cond
  %6 = load i32, i32* %result
  ret i32 %6
}

define i32 @main() {
entry:
  %retval = alloca i32
  %limit = alloca i32
  %sum = alloca i32
  %j = alloca i32
  store i32 0, i32* %retval
  store i32 5, i32* %limit
  store i32 0, i32* %sum
  store i32 0, i32* %j
  br label %while.cond

while.cond:                                       ; preds = %while.body, %entry
  %0 = load i32, i32* %j
  %cmp = icmp slt i32 %0, 5
  br i1 %cmp, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %1 = load i32, i32* %sum
  %2 = load i32, i32* %j
  %call = call i32 @factorial(i32 %2)
  %add = add i32 %1, %call
  store i32 %add, i32* %sum
  %3 = load i32, i32* %j
  %add1 = add i32 %3, 1
  store i32 %add1, i32* %j
  br label %while.cond

while.end:                                        ; preds = %while.cond
  %4 = load i32, i32* %sum
  ret i32 %4
}

