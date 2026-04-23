; ModuleID = 'module'
source_filename = "module"

@globalVar = global i32 100
@GLOBAL_CONST = constant i32 1024

define i32 @complexFunction(i32 %param1, i32 %param2) {
entry:
  %param1.addr = alloca i32
  %param2.addr = alloca i32
  %localResult = alloca i32
  store i32 %param1, i32* %param1.addr
  store i32 %param2, i32* %param2.addr
  store i32 0, i32* %localResult
  %0 = load i32, i32* %param1.addr
  %1 = load i32, i32* %param2.addr
  %cmp = icmp sgt i32 %0, %1
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %2 = load i32, i32* %param1.addr
  %3 = load i32, i32* %param2.addr
  %sub = sub i32 %2, %3
  store i32 %sub, i32* %localResult
  br label %if.end10

if.else:                                          ; preds = %entry
  %4 = load i32, i32* %param1.addr
  %5 = load i32, i32* %param2.addr
  %cmp1 = icmp slt i32 %4, %5
  br i1 %cmp1, label %if.then2, label %if.else7

if.then2:                                         ; preds = %if.else
  %6 = load i32, i32* %param2.addr
  %7 = load i32, i32* %param1.addr
  %sub3 = sub i32 %6, %7
  store i32 %sub3, i32* %localResult
  br label %while.cond

while.cond:                                       ; preds = %if.end, %if.then2
  %8 = load i32, i32* %localResult
  %cmp4 = icmp slt i32 %8, 1024
  br i1 %cmp4, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %9 = load i32, i32* %localResult
  %mul = mul i32 %9, 2
  store i32 %mul, i32* %localResult
  %10 = load i32, i32* %localResult
  %11 = load i32, i32* @globalVar
  %cmp5 = icmp sgt i32 %10, %11
  br i1 %cmp5, label %if.then6, label %if.end

if.then6:                                         ; preds = %while.body
  br label %while.end

if.end:                                           ; preds = %while.body
  br label %while.cond

while.end:                                        ; preds = %if.then6, %while.cond
  br label %if.end9

if.else7:                                         ; preds = %if.else
  %12 = load i32, i32* %param1.addr
  %13 = load i32, i32* %param2.addr
  %mul8 = mul i32 %12, %13
  store i32 %mul8, i32* %localResult
  br label %if.end9

if.end9:                                          ; preds = %if.else7, %while.end
  br label %if.end10

if.end10:                                         ; preds = %if.end9, %if.then
  %14 = load i32, i32* %localResult
  ret i32 %14
}

define void @nestedBlocks() {
entry:
  %x = alloca i32
  %y = alloca i32
  %z = alloca i32
  store i32 5, i32* %x
  %0 = load i32, i32* %x
  %add = add i32 %0, 3
  store i32 %add, i32* %y
  %1 = load i32, i32* %y
  %mul = mul i32 %1, 2
  store i32 %mul, i32* %z
  %2 = load i32, i32* %z
  %cmp = icmp sgt i32 %2, 10
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %3 = load i32, i32* %z
  %sub = sub i32 %3, 1
  store i32 %sub, i32* %z
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret void
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

define i32 @mixedOperations(i32 %a, i32 %b) {
entry:
  %a.addr = alloca i32
  %b.addr = alloca i32
  %temp = alloca i32
  store i32 %a, i32* %a.addr
  store i32 %b, i32* %b.addr
  %0 = load i32, i32* %a.addr
  %1 = load i32, i32* %b.addr
  %add = add i32 %0, %1
  %2 = load i32, i32* %a.addr
  %3 = load i32, i32* %b.addr
  %sub = sub i32 %2, %3
  %mul = mul i32 %add, %sub
  store i32 %mul, i32* %temp
  %4 = load i32, i32* %temp
  %rem = srem i32 %4, 1024
  store i32 %rem, i32* %temp
  %5 = load i32, i32* %temp
  %6 = load i32, i32* %b.addr
  %add1 = add i32 %6, 1
  %div = sdiv i32 %5, %add1
  store i32 %div, i32* %temp
  %7 = load i32, i32* %temp
  ret i32 %7
}

define i32 @main() {
entry:
  %retval = alloca i32
  %localConst = alloca i32
  %result1 = alloca i32
  %result2 = alloca i32
  %counter = alloca i32
  %finalResult = alloca i32
  store i32 0, i32* %retval
  store i32 42, i32* %localConst
  store i32 0, i32* %result1
  store i32 0, i32* %result2
  store i32 0, i32* %counter
  %0 = load i32, i32* @globalVar
  %call = call i32 @complexFunction(i32 %0, i32 42)
  store i32 %call, i32* %result1
  br label %while.cond

while.cond:                                       ; preds = %if.end6, %if.then, %entry
  %1 = load i32, i32* %counter
  %cmp = icmp slt i32 %1, 5
  br i1 %cmp, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %2 = load i32, i32* %result2
  %3 = load i32, i32* %result1
  %4 = load i32, i32* %counter
  %call1 = call i32 @mixedOperations(i32 %3, i32 %4)
  %add = add i32 %2, %call1
  store i32 %add, i32* %result2
  %5 = load i32, i32* %counter
  %add2 = add i32 %5, 1
  store i32 %add2, i32* %counter
  %6 = load i32, i32* %counter
  %cmp3 = icmp eq i32 %6, 3
  br i1 %cmp3, label %if.then, label %if.end

if.then:                                          ; preds = %while.body
  br label %while.cond

if.end:                                           ; preds = %while.body
  %7 = load i32, i32* %result2
  %cmp4 = icmp sgt i32 %7, 1000
  br i1 %cmp4, label %if.then5, label %if.end6

if.then5:                                         ; preds = %if.end
  br label %while.end

if.end6:                                          ; preds = %if.end
  br label %while.cond

while.end:                                        ; preds = %if.then5, %while.cond
  call void @nestedBlocks()
  %8 = load i32, i32* %result2
  %rem = srem i32 %8, 6
  %call7 = call i32 @factorial(i32 %rem)
  store i32 %call7, i32* %finalResult
  %9 = load i32, i32* %finalResult
  %cmp8 = icmp sgt i32 %9, 10
  br i1 %cmp8, label %land.lhs.true, label %lor.lhs.false

land.lhs.true:                                    ; preds = %while.end
  %10 = load i32, i32* %result1
  %cmp9 = icmp slt i32 %10, 200
  br i1 %cmp9, label %if.then11, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %land.lhs.true, %while.end
  %11 = load i32, i32* %result2
  %cmp10 = icmp eq i32 %11, 0
  br i1 %cmp10, label %if.then11, label %if.else

if.then11:                                        ; preds = %lor.lhs.false, %land.lhs.true
  %12 = load i32, i32* %finalResult
  %13 = load i32, i32* @globalVar
  %add12 = add i32 %12, %13
  store i32 %add12, i32* %finalResult
  br label %if.end13

if.else:                                          ; preds = %lor.lhs.false
  %14 = load i32, i32* %finalResult
  %sub = sub i32 %14, 1024
  store i32 %sub, i32* %finalResult
  br label %if.end13

if.end13:                                         ; preds = %if.else, %if.then11
  %15 = load i32, i32* %finalResult
  ret i32 %15
}

