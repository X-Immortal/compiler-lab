; ModuleID = 'module'
source_filename = "module"

define i32 @main() {
entry:
  %retval = alloca i32
  %max = alloca i32
  %min = alloca i32
  store i32 0, i32* %retval
  store i32 2147483647, i32* %max
  store i32 -2147483648, i32* %min
  ret i32 -1
}

