; ModuleID = 'module'
source_filename = "module"

@hits = global i32 0

define i32 @scan(i32 %limit) {
entry:
  %retval = alloca i32
  %limit.addr = alloca i32
  %i = alloca i32
  %total = alloca i32
  %j = alloca i32
  store i32 %limit, i32* %limit.addr
  store i32 0, i32* %i
  store i32 0, i32* %total
  br label %while.cond

while.cond:                                       ; preds = %if.end16, %entry
  %0 = load i32, i32* %i
  %1 = load i32, i32* %limit.addr
  %cmp = icmp slt i32 %0, %1
  br i1 %cmp, label %while.body, label %while.end18

while.body:                                       ; preds = %while.cond
  store i32 0, i32* %j
  br label %while.cond1

while.cond1:                                      ; preds = %if.end9, %if.then, %while.body
  %2 = load i32, i32* %j
  %3 = load i32, i32* %limit.addr
  %cmp2 = icmp slt i32 %2, %3
  br i1 %cmp2, label %while.body3, label %while.end

while.body3:                                      ; preds = %while.cond1
  %4 = load i32, i32* %j
  %add = add i32 %4, 1
  store i32 %add, i32* %j
  %5 = load i32, i32* %i
  %6 = load i32, i32* %j
  %add4 = add i32 %5, %6
  %rem = srem i32 %add4, 2
  %cmp5 = icmp eq i32 %rem, 0
  br i1 %cmp5, label %if.then, label %if.end

if.then:                                          ; preds = %while.body3
  %7 = load i32, i32* @hits
  %add6 = add i32 %7, 1
  store i32 %add6, i32* @hits
  br label %while.cond1

if.end:                                           ; preds = %while.body3
  %8 = load i32, i32* %j
  %9 = load i32, i32* %limit.addr
  %cmp7 = icmp eq i32 %8, %9
  br i1 %cmp7, label %if.then8, label %if.end9

if.then8:                                         ; preds = %if.end
  br label %while.end

if.end9:                                          ; preds = %if.end
  %10 = load i32, i32* %total
  %11 = load i32, i32* %i
  %add10 = add i32 %10, %11
  %12 = load i32, i32* %j
  %add11 = add i32 %add10, %12
  store i32 %add11, i32* %total
  br label %while.cond1

while.end:                                        ; preds = %if.then8, %while.cond1
  %13 = load i32, i32* %i
  %14 = load i32, i32* %limit.addr
  %sub = sub i32 %14, 1
  %cmp12 = icmp eq i32 %13, %sub
  br i1 %cmp12, label %land.lhs.true, label %if.end16

land.lhs.true:                                    ; preds = %while.end
  %15 = load i32, i32* %total
  %cmp13 = icmp sgt i32 %15, 5
  br i1 %cmp13, label %if.then14, label %if.end16

if.then14:                                        ; preds = %land.lhs.true
  %16 = load i32, i32* %total
  %17 = load i32, i32* @hits
  %add15 = add i32 %16, %17
  store i32 %add15, i32* %retval
  br label %return

if.end16:                                         ; preds = %land.lhs.true, %while.end
  %18 = load i32, i32* %i
  %add17 = add i32 %18, 1
  store i32 %add17, i32* %i
  br label %while.cond

while.end18:                                      ; preds = %while.cond
  %19 = load i32, i32* %total
  store i32 %19, i32* %retval
  br label %return

return:                                           ; preds = %while.end18, %if.then14
  %20 = load i32, i32* %retval
  ret i32 %20
}

define i32 @main() {
entry:
  %retval = alloca i32
  store i32 0, i32* %retval
  %call = call i32 @scan(i32 4)
  ret i32 %call
}
