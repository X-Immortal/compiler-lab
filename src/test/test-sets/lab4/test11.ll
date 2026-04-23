; ModuleID = 'module'
source_filename = "module"

@A = constant i32 2

define i32 @evaluate(i32 %seed) {
entry:
  %seed.addr = alloca i32
  %score = alloca i32
  store i32 %seed, i32* %seed.addr
  store i32 0, i32* %score
  %0 = load i32, i32* %score
  %add = add i32 %0, 1
  store i32 %add, i32* %score
  %1 = load i32, i32* %score
  %add1 = add i32 %1, 1
  store i32 %add1, i32* %score
  %2 = load i32, i32* %score
  %add2 = add i32 %2, 1
  store i32 %add2, i32* %score
  %3 = load i32, i32* %seed.addr
  %tobool = icmp ne i32 %3, 0
  %lnot = xor i1 %tobool, true
  %lnot.ext = zext i1 %lnot to i32
  %cmp = icmp slt i32 %lnot.ext, 2
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %4 = load i32, i32* %score
  %add3 = add i32 %4, 1
  store i32 %add3, i32* %score
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  %5 = load i32, i32* %seed.addr
  %sub = sub i32 %5, 9
  %tobool4 = icmp ne i32 %sub, 0
  br i1 %tobool4, label %if.then7, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %if.end
  %6 = load i32, i32* @A
  %tobool5 = icmp ne i32 %6, 0
  br i1 %tobool5, label %land.rhs, label %if.end8

land.rhs:                                         ; preds = %lor.lhs.false
  br i1 true, label %if.then7, label %if.end8

if.then7:                                         ; preds = %land.rhs, %if.end
  %7 = load i32, i32* %score
  %add6 = add i32 %7, 10
  store i32 %add6, i32* %score
  br label %if.end8

if.end8:                                          ; preds = %if.then7, %lor.lhs.false
  %8 = load i32, i32* %score
  ret i32 %8
}

define i32 @main() {
entry:
  %retval = alloca i32
  %seed = alloca i32
  store i32 0, i32* %retval
  store i32 9, i32* %seed
  %0 = load i32, i32* %seed
  %call = call i32 @evaluate(i32 %0)
  %1 = load i32, i32* %seed
  %add = add i32 %call, %1
  ret i32 %add
}
