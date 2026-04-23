; ModuleID = 'module'
source_filename = "module"

@count = global i32 0
@n = global i32 3

define void @hanoi(i32 %n, i32 %source, i32 %target, i32 %auxiliary) {
entry:
  %cmp = icmp eq i32 %n, 1
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %0 = load i32, i32* @count
  %add = add i32 %0, 1
  store i32 %add, i32* @count
  br label %return

if.end:                                           ; preds = %entry
  %sub = add i32 %n, -1
  call void @hanoi(i32 %sub, i32 %source, i32 %auxiliary, i32 %target)
  %1 = load i32, i32* @count
  %add1 = add i32 %1, 1
  store i32 %add1, i32* @count
  call void @hanoi(i32 %sub, i32 %auxiliary, i32 %target, i32 %source)
  br label %return

return:                                           ; preds = %if.end, %if.then
  ret void
}

define i32 @main() {
entry:
  %0 = load i32, i32* @n
  call void @hanoi(i32 %0, i32 1, i32 3, i32 2)
  %1 = load i32, i32* @count
  ret i32 %1
}

