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
  %x.promoted = load i32, i32* @x
  br label %while.body

while.body:                                       ; preds = %entry, %if.end
  %i.09 = phi i32 [ 0, %entry ], [ %add2, %if.end ]
  %0 = phi i32 [ %x.promoted, %entry ], [ %1, %if.end ]
  %rem = and i32 %i.09, 1
  %cmp1 = icmp eq i32 %rem, 0
  br i1 %cmp1, label %if.then, label %if.else

if.then:                                          ; preds = %while.body
  %add = add i32 %0, %i.09
  store i32 %add, i32* @x
  br label %if.end

if.else:                                          ; preds = %while.body
  %mul = mul i32 %0, %i.09
  store i32 %mul, i32* @y
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %1 = phi i32 [ %0, %if.else ], [ %add, %if.then ]
  %add2 = add i32 %i.09, 1
  %exitcond.not = icmp eq i32 %add2, 10
  br i1 %exitcond.not, label %while.end, label %while.body

while.end:                                        ; preds = %if.end
  ret i32 0
}

define i32 @sum(i32 %x, i32 %y) {
entry:
  ret i32 30
}

define void @test() {
entry:
  ret void
}

define i32 @factorial(i32 %n) {
entry:
  %cmp = icmp slt i32 %n, 2
  br i1 %cmp, label %return, label %if.else

if.else:                                          ; preds = %entry
  %sub = add i32 %n, -1
  %call = call i32 @factorial(i32 %sub)
  %mul = mul i32 %call, %n
  br label %return

return:                                           ; preds = %entry, %if.else
  %retval.0 = phi i32 [ %mul, %if.else ], [ 1, %entry ]
  ret i32 %retval.0
}

define void @calculate() {
entry:
  %call = call i32 @factorial(i32 5)
  ret void
}