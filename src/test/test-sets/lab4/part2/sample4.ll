; ModuleID = 'module'
source_filename = "module"

@base = global i32 3
@offset = global i32 0

define i32 @main() {
mainEntry:
  %scale = alloca i32, align 4
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  store i32 5, i32* %scale, align 4
  store i32 2, i32* %x, align 4
  %base1 = load i32, i32* @base, align 4
  %scale1 = load i32, i32* %scale, align 4
  %sum1 = add i32 %base1, %scale1
  store i32 %sum1, i32* %y, align 4
  %y1 = load i32, i32* %y, align 4
  %x1 = load i32, i32* %x, align 4
  %diff = sub i32 %y1, %x1
  store i32 %diff, i32* @offset, align 4
  %offset1 = load i32, i32* @offset, align 4
  %scale2 = load i32, i32* %scale, align 4
  %sum2 = add i32 %offset1, %scale2
  store i32 %sum2, i32* %x, align 4
  %x2 = load i32, i32* %x, align 4
  %y2 = load i32, i32* %y, align 4
  %ret = add i32 %x2, %y2
  ret i32 %ret
}
