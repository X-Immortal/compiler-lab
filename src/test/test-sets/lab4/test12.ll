; ModuleID = 'module'
source_filename = "module"

@state = global i32 0

define i32 @tick() {
entry:
  %0 = load i32, i32* @state
  %add = add i32 %0, 1
  store i32 %add, i32* @state
  %1 = load i32, i32* @state
  ret i32 %1
}

define i32 @main() {
entry:
  %retval = alloca i32
  %i = alloca i32
  %sum = alloca i32
  %j = alloca i32
  store i32 0, i32* %retval
  store i32 0, i32* %i
  store i32 0, i32* %sum
  br label %while.cond

while.cond:                                       ; preds = %while.end, %entry
  %0 = load i32, i32* %i
  %cmp = icmp slt i32 %0, 3
  br i1 %cmp, label %land.rhs, label %land.end

land.rhs:                                         ; preds = %while.cond
  %call = call i32 @tick()
  %tobool = icmp ne i32 %call, 0
  br label %land.end

land.end:                                         ; preds = %land.rhs, %while.cond
  %1 = phi i1 [ false, %while.cond ], [ %tobool, %land.rhs ]
  br i1 %1, label %while.body, label %while.end25

while.body:                                       ; preds = %land.end
  store i32 0, i32* %j
  br label %while.cond1

while.cond1:                                      ; preds = %if.end23, %if.then, %while.body
  %2 = load i32, i32* %j
  %cmp2 = icmp slt i32 %2, 3
  br i1 %cmp2, label %while.body3, label %while.end

while.body3:                                      ; preds = %while.cond1
  %3 = load i32, i32* %j
  %add = add i32 %3, 1
  store i32 %add, i32* %j
  %4 = load i32, i32* %j
  %cmp4 = icmp eq i32 %4, 2
  br i1 %cmp4, label %land.lhs.true, label %lor.lhs.false

land.lhs.true:                                    ; preds = %while.body3
  %5 = load i32, i32* %i
  %cmp5 = icmp eq i32 %5, 1
  br i1 %cmp5, label %if.then, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %land.lhs.true, %while.body3
  %6 = load i32, i32* %j
  %cmp6 = icmp eq i32 %6, 2
  br i1 %cmp6, label %land.lhs.true7, label %if.end

land.lhs.true7:                                   ; preds = %lor.lhs.false
  %call8 = call i32 @tick()
  %tobool9 = icmp ne i32 %call8, 0
  br i1 %tobool9, label %if.then, label %if.end

if.then:                                          ; preds = %land.lhs.true7, %land.lhs.true
  br label %while.cond1

if.end:                                           ; preds = %land.lhs.true7, %lor.lhs.false
  %7 = load i32, i32* %sum
  %8 = load i32, i32* %j
  %add10 = add i32 %7, %8
  store i32 %add10, i32* %sum
  %9 = load i32, i32* %j
  %cmp11 = icmp eq i32 %9, 3
  br i1 %cmp11, label %if.then17, label %lor.lhs.false12

lor.lhs.false12:                                  ; preds = %if.end
  %10 = load i32, i32* %i
  %cmp13 = icmp eq i32 %10, 4
  br i1 %cmp13, label %land.lhs.true14, label %if.end23

land.lhs.true14:                                  ; preds = %lor.lhs.false12
  %call15 = call i32 @tick()
  %tobool16 = icmp ne i32 %call15, 0
  br i1 %tobool16, label %if.then17, label %if.end23

if.then17:                                        ; preds = %land.lhs.true14, %if.end
  %11 = load i32, i32* %i
  %cmp18 = icmp eq i32 %11, 2
  br i1 %cmp18, label %land.lhs.true19, label %if.end22

land.lhs.true19:                                  ; preds = %if.then17
  %12 = load i32, i32* %j
  %cmp20 = icmp eq i32 %12, 3
  br i1 %cmp20, label %if.then21, label %if.end22

if.then21:                                        ; preds = %land.lhs.true19
  br label %while.end

if.end22:                                         ; preds = %land.lhs.true19, %if.then17
  br label %if.end23

if.end23:                                         ; preds = %if.end22, %land.lhs.true14, %lor.lhs.false12
  br label %while.cond1

while.end:                                        ; preds = %if.then21, %while.cond1
  %13 = load i32, i32* %i
  %add24 = add i32 %13, 1
  store i32 %add24, i32* %i
  br label %while.cond

while.end25:                                      ; preds = %land.end
  %14 = load i32, i32* %sum
  %15 = load i32, i32* @state
  %add26 = add i32 %14, %15
  ret i32 %add26
}
