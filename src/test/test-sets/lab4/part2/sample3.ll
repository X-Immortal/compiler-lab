; ModuleID = 'module'
source_filename = "module"

@g = global i32 4
@c = constant i32 6

define i32 @main() {
mainEntry:
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %g1 = load i32, i32* @g, align 4
  store i32 %g1, i32* %a, align 4
  %a1 = load i32, i32* %a, align 4
  %c1 = load i32, i32* @c, align 4
  %mul = mul i32 %a1, %c1
  %add = add i32 %mul, 8
  store i32 %add, i32* %b, align 4
  %b1 = load i32, i32* %b, align 4
  %g2 = load i32, i32* @g, align 4
  %sub = sub i32 %b1, %g2
  ret i32 %sub
}
