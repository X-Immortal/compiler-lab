; ModuleID = 'module'
source_filename = "module"

@count = global i32 0
@n = global i32 3

define void @hanoi(i32 %n, i32 %source, i32 %target, i32 %auxiliary) {
entry:
  %n.addr = alloca i32
  %source.addr = alloca i32
  %target.addr = alloca i32
  %auxiliary.addr = alloca i32
  store i32 %n, i32* %n.addr
  store i32 %source, i32* %source.addr
  store i32 %target, i32* %target.addr
  store i32 %auxiliary, i32* %auxiliary.addr
  %0 = load i32, i32* %n.addr
  %cmp = icmp eq i32 %0, 1
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %1 = load i32, i32* @count
  %add = add i32 %1, 1
  store i32 %add, i32* @count
  br label %return

if.end:                                           ; preds = %entry
  %2 = load i32, i32* %n.addr
  %sub = sub i32 %2, 1
  %3 = load i32, i32* %source.addr
  %4 = load i32, i32* %auxiliary.addr
  %5 = load i32, i32* %target.addr
  call void @hanoi(i32 %sub, i32 %3, i32 %4, i32 %5)
  %6 = load i32, i32* @count
  %add1 = add i32 %6, 1
  store i32 %add1, i32* @count
  %7 = load i32, i32* %n.addr
  %sub2 = sub i32 %7, 1
  %8 = load i32, i32* %auxiliary.addr
  %9 = load i32, i32* %target.addr
  %10 = load i32, i32* %source.addr
  call void @hanoi(i32 %sub2, i32 %8, i32 %9, i32 %10)
  br label %return

return:                                           ; preds = %if.end, %if.then
  ret void
}

define i32 @main() {
entry:
  %retval = alloca i32
  store i32 0, i32* %retval
  %0 = load i32, i32* @n
  call void @hanoi(i32 %0, i32 1, i32 3, i32 2)
  %1 = load i32, i32* @count
  ret i32 %1
}

