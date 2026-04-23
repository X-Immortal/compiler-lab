; ModuleID = 'module'
source_filename = "module"

define i32 @main() {
entry:
  %retval = alloca i32
  %kMax = alloca i32
  %result = alloca i32
  %i = alloca i32
  %j = alloca i32
  %a = alloca i32
  %b = alloca i32
  store i32 0, i32* %retval
  store i32 6, i32* %kMax
  store i32 0, i32* %result
  store i32 0, i32* %i
  br label %while.cond

while.cond:                                       ; preds = %while.end, %entry
  %0 = load i32, i32* %i
  %cmp = icmp slt i32 %0, 6
  br i1 %cmp, label %while.body, label %while.end11

while.body:                                       ; preds = %while.cond
  %1 = load i32, i32* %i
  store i32 %1, i32* %j
  br label %while.cond1

while.cond1:                                      ; preds = %if.end7, %if.then6, %while.body
  %2 = load i32, i32* %j
  %cmp2 = icmp slt i32 %2, 6
  br i1 %cmp2, label %while.body3, label %while.end

while.body3:                                      ; preds = %while.cond1
  %3 = load i32, i32* %j
  %cmp4 = icmp eq i32 %3, 5
  br i1 %cmp4, label %if.then, label %if.end

if.then:                                          ; preds = %while.body3
  br label %while.end

if.end:                                           ; preds = %while.body3
  %4 = load i32, i32* %j
  %rem = srem i32 %4, 2
  %cmp5 = icmp eq i32 %rem, 0
  br i1 %cmp5, label %if.then6, label %if.end7

if.then6:                                         ; preds = %if.end
  %5 = load i32, i32* %j
  %add = add i32 %5, 1
  store i32 %add, i32* %j
  br label %while.cond1

if.end7:                                          ; preds = %if.end
  %6 = load i32, i32* %result
  %add8 = add i32 %6, 1
  store i32 %add8, i32* %result
  %7 = load i32, i32* %j
  %add9 = add i32 %7, 1
  store i32 %add9, i32* %j
  br label %while.cond1

while.end:                                        ; preds = %if.then, %while.cond1
  %8 = load i32, i32* %i
  %add10 = add i32 %8, 1
  store i32 %add10, i32* %i
  br label %while.cond

while.end11:                                      ; preds = %while.cond
  store i32 0, i32* %a
  store i32 1, i32* %b
  %9 = load i32, i32* %a
  %cmp12 = icmp ne i32 %9, 0
  br i1 %cmp12, label %land.lhs.true, label %if.end15

land.lhs.true:                                    ; preds = %while.end11
  %10 = load i32, i32* %b
  %cmp13 = icmp ne i32 %10, 0
  br i1 %cmp13, label %if.then14, label %if.end15

if.then14:                                        ; preds = %land.lhs.true
  store i32 -65535, i32* %retval
  br label %return

if.end15:                                         ; preds = %land.lhs.true, %while.end11
  %11 = load i32, i32* %result
  store i32 %11, i32* %retval
  br label %return

return:                                           ; preds = %if.end15, %if.then14
  %12 = load i32, i32* %retval
  ret i32 %12
}

