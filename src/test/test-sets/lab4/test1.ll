; ModuleID = 'module'
source_filename = "module"

@a = constant i32 10
@b = constant i32 20
@x = global i32 5
@y = global i32 10

define void @do_nothing() {
entry:
  ret void
}

define i32 @main() {
entry:
  %retval = alloca i32
  %i = alloca i32
  store i32 0, i32* %retval
  store i32 0, i32* %i
  br label %while.cond

while.cond:                                       ; preds = %if.end, %entry
  %0 = load i32, i32* %i
  %cmp = icmp slt i32 %0, 10
  br i1 %cmp, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %1 = load i32, i32* %i
  %rem = srem i32 %1, 2
  %cmp1 = icmp eq i32 %rem, 0
  br i1 %cmp1, label %if.then, label %if.else

if.then:                                          ; preds = %while.body
  %2 = load i32, i32* @x
  %3 = load i32, i32* %i
  %add = add i32 %2, %3
  store i32 %add, i32* @x
  br label %if.end

if.else:                                          ; preds = %while.body
  %4 = load i32, i32* @x
  %5 = load i32, i32* %i
  %mul = mul i32 %4, %5
  store i32 %mul, i32* @y
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %6 = load i32, i32* %i
  %add2 = add i32 %6, 1
  store i32 %add2, i32* %i
  br label %while.cond

while.end:                                        ; preds = %while.cond
  call void @do_nothing()
  %7 = load i32, i32* %i
  %tobool = icmp ne i32 %7, 0
  %lnot = xor i1 %tobool, true
  %lnot.ext = zext i1 %lnot to i32
  ret i32 %lnot.ext
}

define i32 @sum(i32 %x, i32 %y) {
entry:
  %x.addr = alloca i32
  %y.addr = alloca i32
  store i32 %x, i32* %x.addr
  store i32 %y, i32* %y.addr
  store i32 10, i32* %x.addr
  store i32 20, i32* %y.addr
  %0 = load i32, i32* %x.addr
  %1 = load i32, i32* %y.addr
  %add = add i32 %0, %1
  ret i32 %add
}

define void @test() {
entry:
  %result = alloca i32
  %call = call i32 @sum(i32 10, i32 20)
  store i32 %call, i32* %result
  %0 = load i32, i32* %result
  %cmp = icmp sgt i32 %0, 10
  br i1 %cmp, label %land.lhs.true, label %if.else

land.lhs.true:                                    ; preds = %entry
  %1 = load i32, i32* %result
  %cmp1 = icmp slt i32 %1, 15
  br i1 %cmp1, label %if.then, label %if.else

if.then:                                          ; preds = %land.lhs.true
  %2 = load i32, i32* %result
  %sub = sub i32 %2, 10
  store i32 %sub, i32* %result
  br label %if.end4

if.else:                                          ; preds = %land.lhs.true, %entry
  %3 = load i32, i32* %result
  %cmp2 = icmp slt i32 %3, 20
  br i1 %cmp2, label %if.then3, label %if.end

if.then3:                                         ; preds = %if.else
  %4 = load i32, i32* %result
  %add = add i32 %4, 10
  store i32 %add, i32* %result
  br label %if.end

if.end:                                           ; preds = %if.then3, %if.else
  br label %if.end4

if.end4:                                          ; preds = %if.end, %if.then
  ret void
}

define i32 @factorial(i32 %n) {
entry:
  %retval = alloca i32
  %n.addr = alloca i32
  store i32 %n, i32* %n.addr
  %0 = load i32, i32* %n.addr
  %cmp = icmp sle i32 %0, 1
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  store i32 1, i32* %retval
  br label %return

if.else:                                          ; preds = %entry
  %1 = load i32, i32* %n.addr
  %2 = load i32, i32* %n.addr
  %sub = sub i32 %2, 1
  %call = call i32 @factorial(i32 %sub)
  %mul = mul i32 %1, %call
  store i32 %mul, i32* %retval
  br label %return

return:                                           ; preds = %if.else, %if.then
  %3 = load i32, i32* %retval
  ret i32 %3
}

define void @calculate() {
entry:
  %num = alloca i32
  %fact = alloca i32
  %count = alloca i32
  %max = alloca i32
  store i32 5, i32* %num
  %0 = load i32, i32* %num
  %call = call i32 @factorial(i32 %0)
  store i32 %call, i32* %fact
  store i32 0, i32* %count
  store i32 10, i32* %max
  br label %while.cond

while.cond:                                       ; preds = %while.body, %entry
  %1 = load i32, i32* %count
  %2 = load i32, i32* %max
  %cmp = icmp slt i32 %1, %2
  br i1 %cmp, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %3 = load i32, i32* %count
  %add = add i32 %3, 1
  store i32 %add, i32* %count
  br label %while.cond

while.end:                                        ; preds = %while.cond
  ret void
}

