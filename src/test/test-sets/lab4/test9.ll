; ModuleID = 'module'
source_filename = "module"

define i32 @main() {
entry:
  %retval = alloca i32
  store i32 0, i32* %retval
  ret i32 -1
}

