; ModuleID = 'module'
source_filename = "module"

@counter = global i32 0

define i32 @increment() {
entry:
  %0 = load i32, i32* @counter
  %add = add i32 %0, 1
  store i32 %add, i32* @counter
  ret i32 %add
}

define i32 @main() {
entry:
  %0 = load i32, i32* @counter
  %tobool.not = icmp eq i32 %0, -1
  %storemerge = select i1 %tobool.not, i32 1, i32 11
  store i32 %storemerge, i32* @counter
  ret i32 %storemerge
}

