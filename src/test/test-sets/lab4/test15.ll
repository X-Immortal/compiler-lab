; ModuleID = 'module'
source_filename = "module"

@mark = global i32 0

define void @probe(i32 %x) {
entry:
  %x.addr = alloca i32
  store i32 %x, i32* %x.addr
  %0 = load i32, i32* %x.addr
  %tobool = icmp ne i32 %0, 0
  br i1 %tobool, label %if.then, label %if.else4

if.then:                                          ; preds = %entry
  %1 = load i32, i32* %x.addr
  %sub = sub i32 %1, 1
  %tobool1 = icmp ne i32 %sub, 0
  br i1 %tobool1, label %if.then2, label %if.else

if.then2:                                         ; preds = %if.then
  %2 = load i32, i32* @mark
  %add = add i32 %2, 10
  store i32 %add, i32* @mark
  br label %if.end

if.else:                                          ; preds = %if.then
  %3 = load i32, i32* @mark
  %add3 = add i32 %3, 1
  store i32 %add3, i32* @mark
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then2
  br label %if.end5

if.else4:                                         ; preds = %entry
  br label %if.end5

if.end5:                                          ; preds = %if.else4, %if.end
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
  %cmp = icmp slt i32 %0, 3
  br i1 %cmp, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %1 = load i32, i32* %i
  call void @probe(i32 %1)
  %2 = load i32, i32* %i
  %cmp1 = icmp eq i32 %2, 0
  br i1 %cmp1, label %if.then, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %while.body
  %3 = load i32, i32* %i
  %cmp2 = icmp eq i32 %3, 2
  br i1 %cmp2, label %land.lhs.true, label %if.else

land.lhs.true:                                    ; preds = %lor.lhs.false
  %4 = load i32, i32* @mark
  %cmp3 = icmp sgt i32 %4, 0
  br i1 %cmp3, label %if.then, label %if.else

if.then:                                          ; preds = %land.lhs.true, %while.body
  %5 = load i32, i32* @mark
  %6 = load i32, i32* %i
  %add = add i32 %5, %6
  store i32 %add, i32* @mark
  br label %if.end

if.else:                                          ; preds = %land.lhs.true, %lor.lhs.false
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %7 = load i32, i32* %i
  %add4 = add i32 %7, 1
  store i32 %add4, i32* %i
  br label %while.cond

while.end:                                        ; preds = %while.cond
  %8 = load i32, i32* @mark
  ret i32 %8
}
