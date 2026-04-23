; ModuleID = 'module'
source_filename = "module"

@BASE = constant i32 10
@globalCounter = global i32 0

define i32 @power(i32 %base, i32 %exponent) {
entry:
  %retval = alloca i32
  %base.addr = alloca i32
  %exponent.addr = alloca i32
  %result = alloca i32
  %i = alloca i32
  store i32 %base, i32* %base.addr
  store i32 %exponent, i32* %exponent.addr
  store i32 1, i32* %result
  store i32 0, i32* %i
  br label %while.cond

while.cond:                                       ; preds = %if.end, %entry
  %0 = load i32, i32* %i
  %1 = load i32, i32* %exponent.addr
  %cmp = icmp slt i32 %0, %1
  br i1 %cmp, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %2 = load i32, i32* %result
  %3 = load i32, i32* %base.addr
  %mul = mul i32 %2, %3
  store i32 %mul, i32* %result
  %4 = load i32, i32* %i
  %add = add i32 %4, 1
  store i32 %add, i32* %i
  %5 = load i32, i32* %result
  %cmp1 = icmp sgt i32 %5, 1000
  br i1 %cmp1, label %if.then, label %if.end

if.then:                                          ; preds = %while.body
  %6 = load i32, i32* %result
  store i32 %6, i32* %retval
  br label %return

if.end:                                           ; preds = %while.body
  br label %while.cond

while.end:                                        ; preds = %while.cond
  %7 = load i32, i32* %result
  store i32 %7, i32* %retval
  br label %return

return:                                           ; preds = %while.end, %if.then
  %8 = load i32, i32* %retval
  ret i32 %8
}

define i32 @factorial(i32 %n) {
entry:
  %retval = alloca i32
  %n.addr = alloca i32
  store i32 %n, i32* %n.addr
  %0 = load i32, i32* %n.addr
  %cmp = icmp sle i32 %0, 1
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  store i32 1, i32* %retval
  br label %return

if.end:                                           ; preds = %entry
  %1 = load i32, i32* %n.addr
  %2 = load i32, i32* %n.addr
  %sub = sub i32 %2, 1
  %call = call i32 @factorial(i32 %sub)
  %mul = mul i32 %1, %call
  store i32 %mul, i32* %retval
  br label %return

return:                                           ; preds = %if.end, %if.then
  %3 = load i32, i32* %retval
  ret i32 %3
}

define i32 @fibonacci(i32 %n) {
entry:
  %retval = alloca i32
  %n.addr = alloca i32
  store i32 %n, i32* %n.addr
  %0 = load i32, i32* @globalCounter
  %add = add i32 %0, 1
  store i32 %add, i32* @globalCounter
  %1 = load i32, i32* %n.addr
  %cmp = icmp sle i32 %1, 1
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %2 = load i32, i32* %n.addr
  store i32 %2, i32* %retval
  br label %return

if.end:                                           ; preds = %entry
  %3 = load i32, i32* %n.addr
  %sub = sub i32 %3, 1
  %call = call i32 @fibonacci(i32 %sub)
  %4 = load i32, i32* %n.addr
  %sub1 = sub i32 %4, 2
  %call2 = call i32 @fibonacci(i32 %sub1)
  %add3 = add i32 %call, %call2
  store i32 %add3, i32* %retval
  br label %return

return:                                           ; preds = %if.end, %if.then
  %5 = load i32, i32* %retval
  ret i32 %5
}

define i32 @complexCalculation(i32 %x, i32 %y) {
entry:
  %x.addr = alloca i32
  %y.addr = alloca i32
  %result = alloca i32
  store i32 %x, i32* %x.addr
  store i32 %y, i32* %y.addr
  store i32 0, i32* %result
  %0 = load i32, i32* %x.addr
  %1 = load i32, i32* %y.addr
  %cmp = icmp sgt i32 %0, %1
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %2 = load i32, i32* %x.addr
  %call = call i32 @power(i32 %2, i32 2)
  %3 = load i32, i32* %y.addr
  %call1 = call i32 @power(i32 %3, i32 2)
  %sub = sub i32 %call, %call1
  store i32 %sub, i32* %result
  br label %if.end7

if.else:                                          ; preds = %entry
  %4 = load i32, i32* %x.addr
  %5 = load i32, i32* %y.addr
  %cmp2 = icmp slt i32 %4, %5
  br i1 %cmp2, label %if.then3, label %if.else6

if.then3:                                         ; preds = %if.else
  %6 = load i32, i32* %y.addr
  %7 = load i32, i32* %x.addr
  %sub4 = sub i32 %6, %7
  %call5 = call i32 @factorial(i32 %sub4)
  store i32 %call5, i32* %result
  br label %if.end

if.else6:                                         ; preds = %if.else
  %8 = load i32, i32* %x.addr
  %9 = load i32, i32* %y.addr
  %mul = mul i32 %8, %9
  %add = add i32 %mul, 10
  store i32 %add, i32* %result
  br label %if.end

if.end:                                           ; preds = %if.else6, %if.then3
  br label %if.end7

if.end7:                                          ; preds = %if.end, %if.then
  br label %while.cond

while.cond:                                       ; preds = %if.end12, %if.end7
  %10 = load i32, i32* %result
  %cmp8 = icmp sgt i32 %10, 10
  br i1 %cmp8, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %11 = load i32, i32* %result
  %sub9 = sub i32 %11, 10
  store i32 %sub9, i32* %result
  %12 = load i32, i32* %result
  %cmp10 = icmp slt i32 %12, 5
  br i1 %cmp10, label %if.then11, label %if.end12

if.then11:                                        ; preds = %while.body
  br label %while.end

if.end12:                                         ; preds = %while.body
  br label %while.cond

while.end:                                        ; preds = %if.then11, %while.cond
  %13 = load i32, i32* %result
  ret i32 %13
}

define void @nestedScopesTest() {
entry:
  %a = alloca i32
  %b = alloca i32
  %a1 = alloca i32
  store i32 5, i32* %a
  %0 = load i32, i32* %a
  %add = add i32 %0, 3
  store i32 %add, i32* %b
  %1 = load i32, i32* %b
  %mul = mul i32 %1, 2
  store i32 %mul, i32* %a1
  %2 = load i32, i32* %a1
  %3 = load i32, i32* %b
  %cmp = icmp sgt i32 %2, %3
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %4 = load i32, i32* %a1
  %5 = load i32, i32* %b
  %sub = sub i32 %4, %5
  store i32 %sub, i32* %b
  br label %if.end

if.else:                                          ; preds = %entry
  %6 = load i32, i32* %b
  %7 = load i32, i32* %a1
  %sub2 = sub i32 %6, %7
  store i32 %sub2, i32* %b
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %8 = load i32, i32* %b
  %add3 = add i32 %8, 1
  store i32 %add3, i32* %a
  %9 = load i32, i32* @globalCounter
  %10 = load i32, i32* %a
  %add4 = add i32 %9, %10
  store i32 %add4, i32* @globalCounter
  ret void
}

define i32 @main() {
entry:
  %retval = alloca i32
  %TEST_CASE = alloca i32
  %testResults = alloca i32
  %fib = alloca i32
  %calc = alloca i32
  %pow = alloca i32
  %fact = alloca i32
  store i32 0, i32* %retval
  store i32 5, i32* %TEST_CASE
  store i32 0, i32* %testResults
  %call = call i32 @fibonacci(i32 5)
  store i32 %call, i32* %fib
  %0 = load i32, i32* %testResults
  %1 = load i32, i32* %fib
  %add = add i32 %0, %1
  store i32 %add, i32* %testResults
  %call1 = call i32 @complexCalculation(i32 3, i32 5)
  store i32 %call1, i32* %calc
  %2 = load i32, i32* %testResults
  %3 = load i32, i32* %calc
  %add2 = add i32 %2, %3
  store i32 %add2, i32* %testResults
  call void @nestedScopesTest()
  %4 = load i32, i32* %testResults
  %5 = load i32, i32* @globalCounter
  %add3 = add i32 %4, %5
  store i32 %add3, i32* %testResults
  %call4 = call i32 @power(i32 2, i32 5)
  store i32 %call4, i32* %pow
  %6 = load i32, i32* %testResults
  %7 = load i32, i32* %pow
  %add5 = add i32 %6, %7
  store i32 %add5, i32* %testResults
  %call6 = call i32 @factorial(i32 5)
  store i32 %call6, i32* %fact
  %8 = load i32, i32* %testResults
  %9 = load i32, i32* %fact
  %add7 = add i32 %8, %9
  store i32 %add7, i32* %testResults
  %10 = load i32, i32* %testResults
  ret i32 %10
}

