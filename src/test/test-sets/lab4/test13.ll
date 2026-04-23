; ModuleID = 'module'
source_filename = "module"

@value = global i32 7
@bonus = global i32 1

define i32 @mix(i32 %value) {
entry:
  %value.addr = alloca i32
  %result = alloca i32
  %bonus1 = alloca i32
  %value2 = alloca i32
  store i32 %value, i32* %value.addr
  %0 = load i32, i32* %value.addr
  %1 = load i32, i32* @bonus
  %add = add i32 %0, %1
  store i32 %add, i32* %result
  %2 = load i32, i32* %result
  %add1 = add i32 %2, 1
  store i32 %add1, i32* %bonus1
  %3 = load i32, i32* %bonus1
  %add3 = add i32 %3, 2
  store i32 %add3, i32* %value2
  %4 = load i32, i32* %value2
  %5 = load i32, i32* %bonus1
  %add4 = add i32 %4, %5
  store i32 %add4, i32* %result
  %6 = load i32, i32* %result
  %7 = load i32, i32* %bonus1
  %add5 = add i32 %6, %7
  store i32 %add5, i32* %result
  %8 = load i32, i32* %result
  %9 = load i32, i32* %value.addr
  %add6 = add i32 %8, %9
  store i32 %add6, i32* %result
  %10 = load i32, i32* %result
  %11 = load i32, i32* @bonus
  %add7 = add i32 %10, %11
  ret i32 %add7
}

define void @mutate() {
entry:
  %value = alloca i32
  %bonus1 = alloca i32
  store i32 3, i32* %value
  %0 = load i32, i32* %value
  %add = add i32 %0, 4
  store i32 %add, i32* %bonus1
  %1 = load i32, i32* %bonus1
  %add1 = add i32 %1, 1
  store i32 %add1, i32* %value
  %2 = load i32, i32* @bonus
  %3 = load i32, i32* %value
  %add2 = add i32 %2, %3
  store i32 %add2, i32* @bonus
  ret void
}

define i32 @main() {
entry:
  %retval = alloca i32
  %value1 = alloca i32
  store i32 0, i32* %retval
  store i32 2, i32* %value1
  call void @mutate()
  %0 = load i32, i32* %value1
  %call = call i32 @mix(i32 %0)
  %1 = load i32, i32* %value1
  %add = add i32 %call, %1
  %2 = load i32, i32* @bonus
  %add1 = add i32 %add, %2
  ret i32 %add1
}
