; ModuleID = 'module'
source_filename = "module"

define i32 @max(i32 %x, i32 %y) {
entry:
  %retval = alloca i32
  %x.addr = alloca i32
  %y.addr = alloca i32
  store i32 %x, i32* %x.addr
  store i32 %y, i32* %y.addr
  %0 = load i32, i32* %x.addr
  %1 = load i32, i32* %y.addr
  %cmp = icmp sgt i32 %0, %1
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %2 = load i32, i32* %x.addr
  store i32 %2, i32* %retval
  br label %return

if.else:                                          ; preds = %entry
  %3 = load i32, i32* %y.addr
  store i32 %3, i32* %retval
  br label %return

return:                                           ; preds = %if.else, %if.then
  %4 = load i32, i32* %retval
  ret i32 %4
}

define i32 @gcd(i32 %a, i32 %b) {
entry:
  %a.addr = alloca i32
  %b.addr = alloca i32
  %r = alloca i32
  store i32 %a, i32* %a.addr
  store i32 %b, i32* %b.addr
  br label %while.cond

while.cond:                                       ; preds = %while.body, %entry
  %0 = load i32, i32* %b.addr
  %tobool = icmp ne i32 %0, 0
  br i1 %tobool, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %1 = load i32, i32* %a.addr
  %2 = load i32, i32* %b.addr
  %rem = srem i32 %1, %2
  store i32 %rem, i32* %r
  %3 = load i32, i32* %b.addr
  store i32 %3, i32* %a.addr
  %4 = load i32, i32* %r
  store i32 %4, i32* %b.addr
  br label %while.cond

while.end:                                        ; preds = %while.cond
  %5 = load i32, i32* %a.addr
  ret i32 %5
}

define i32 @main() {
entry:
  %retval = alloca i32
  store i32 0, i32* %retval
  %call = call i32 @gcd(i32 7, i32 2)
  %call1 = call i32 @gcd(i32 18, i32 12)
  %call2 = call i32 @max(i32 %call, i32 %call1)
  ret i32 %call2
}

