; ModuleID = 'module'
source_filename = "module"

@seed = constant i32 10
@total = global i32 1

define i32 @main() {
mainEntry:
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %seed1 = load i32, i32* @seed, align 4
  %total1 = load i32, i32* @total, align 4
  %sum1 = add i32 %seed1, %total1
  store i32 %sum1, i32* %a, align 4
  %a1 = load i32, i32* %a, align 4
  store i32 %a1, i32* %b, align 4
  %b1 = load i32, i32* %b, align 4
  %rem = srem i32 %b1, 4
  %sum2 = add i32 %rem, 7
  store i32 %sum2, i32* %b, align 4
  %b2 = load i32, i32* %b, align 4
  %mul = mul i32 %b2, 2
  store i32 %mul, i32* @total, align 4
  %total2 = load i32, i32* @total, align 4
  %a2 = load i32, i32* %a, align 4
  %ret = add i32 %total2, %a2
  ret i32 %ret
}
