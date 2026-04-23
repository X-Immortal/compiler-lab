; ModuleID = 'module'
source_filename = "module"

@counter = global i32 0

define i32 @increment() {
entry:
  %0 = load i32, i32* @counter
  %add = add i32 %0, 1
  store i32 %add, i32* @counter
  %1 = load i32, i32* @counter
  ret i32 %1
}

define i32 @main() {
entry:
  %retval = alloca i32
  %a = alloca i32
  %b = alloca i32
  store i32 0, i32* %retval
  store i32 1, i32* %a
  store i32 3, i32* %b
  %0 = load i32, i32* %a
  %1 = load i32, i32* %b
  %cmp = icmp sgt i32 %0, %1
  br i1 %cmp, label %if.then, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %entry
  %call = call i32 @increment()
  %tobool = icmp ne i32 %call, 0
  br i1 %tobool, label %if.end, label %if.then

if.then:                                          ; preds = %lor.lhs.false, %entry
  %call1 = call i32 @increment()
  store i32 %call1, i32* %retval
  br label %return

if.end:                                           ; preds = %lor.lhs.false
  store i32 3, i32* @counter
  %2 = load i32, i32* %a
  %3 = load i32, i32* %b
  %cmp2 = icmp sgt i32 %2, %3
  br i1 %cmp2, label %land.lhs.true, label %if.end7

land.lhs.true:                                    ; preds = %if.end
  %call3 = call i32 @increment()
  %tobool4 = icmp ne i32 %call3, 0
  br i1 %tobool4, label %if.then5, label %if.end7

if.then5:                                         ; preds = %land.lhs.true
  %call6 = call i32 @increment()
  store i32 %call6, i32* %retval
  br label %return

if.end7:                                          ; preds = %land.lhs.true, %if.end
  store i32 6, i32* @counter
  %4 = load i32, i32* %a
  %5 = load i32, i32* %b
  %cmp8 = icmp slt i32 %4, %5
  br i1 %cmp8, label %land.lhs.true9, label %if.end14

land.lhs.true9:                                   ; preds = %if.end7
  %call10 = call i32 @increment()
  %tobool11 = icmp ne i32 %call10, 0
  br i1 %tobool11, label %if.end14, label %if.then12

if.then12:                                        ; preds = %land.lhs.true9
  %call13 = call i32 @increment()
  store i32 %call13, i32* %retval
  br label %return

if.end14:                                         ; preds = %land.lhs.true9, %if.end7
  store i32 9, i32* @counter
  %6 = load i32, i32* %a
  %7 = load i32, i32* %b
  %cmp15 = icmp sgt i32 %6, %7
  br i1 %cmp15, label %if.then19, label %lor.lhs.false16

lor.lhs.false16:                                  ; preds = %if.end14
  %call17 = call i32 @increment()
  %tobool18 = icmp ne i32 %call17, 0
  br i1 %tobool18, label %if.then19, label %if.end21

if.then19:                                        ; preds = %lor.lhs.false16, %if.end14
  %call20 = call i32 @increment()
  store i32 %call20, i32* %retval
  br label %return

if.end21:                                         ; preds = %lor.lhs.false16
  store i32 0, i32* %retval
  br label %return

return:                                           ; preds = %if.end21, %if.then19, %if.then12, %if.then5, %if.then
  %8 = load i32, i32* %retval
  ret i32 %8
}

