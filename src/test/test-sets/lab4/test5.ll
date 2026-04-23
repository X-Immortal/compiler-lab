; ModuleID = 'module'
source_filename = "module"

@BASE = constant i32 10
@globalCounter = global i32 0

define i32 @power(i32 %base, i32 %exponent) {
entry:
  %smax.cmp = icmp sgt i32 %exponent, 0
  %smax = select i1 %smax.cmp, i32 %exponent, i32 0
  br label %while.cond

while.cond:                                       ; preds = %while.body, %entry
  %result.0 = phi i32 [ 1, %entry ], [ %mul, %while.body ]
  %i.0 = phi i32 [ 0, %entry ], [ %add, %while.body ]
  %exitcond.not = icmp eq i32 %i.0, %smax
  br i1 %exitcond.not, label %cleanup, label %while.body

while.body:                                       ; preds = %while.cond
  %mul = mul i32 %result.0, %base
  %add = add i32 %i.0, 1
  %cmp1 = icmp sgt i32 %mul, 1000
  br i1 %cmp1, label %cleanup, label %while.cond

cleanup:                                          ; preds = %while.cond, %while.body
  %retval.0 = phi i32 [ %mul, %while.body ], [ %result.0, %while.cond ]
  ret i32 %retval.0
}

define i32 @factorial(i32 %n) {
entry:
  %cmp = icmp slt i32 %n, 2
  br i1 %cmp, label %return, label %if.end

if.end:                                           ; preds = %entry
  %sub = add i32 %n, -1
  %call = call i32 @factorial(i32 %sub)
  %mul = mul i32 %call, %n
  br label %return

return:                                           ; preds = %entry, %if.end
  %retval.0 = phi i32 [ %mul, %if.end ], [ 1, %entry ]
  ret i32 %retval.0
}

define i32 @fibonacci(i32 %n) {
entry:
  %0 = load i32, i32* @globalCounter
  %add = add i32 %0, 1
  store i32 %add, i32* @globalCounter
  %cmp = icmp slt i32 %n, 2
  br i1 %cmp, label %return, label %if.end

if.end:                                           ; preds = %entry
  %sub = add i32 %n, -1
  %call = call i32 @fibonacci(i32 %sub)
  %sub1 = add i32 %n, -2
  %call2 = call i32 @fibonacci(i32 %sub1)
  %add3 = add i32 %call2, %call
  br label %return

return:                                           ; preds = %entry, %if.end
  %retval.0 = phi i32 [ %add3, %if.end ], [ %n, %entry ]
  ret i32 %retval.0
}

define i32 @complexCalculation(i32 %x, i32 %y) {
entry:
  %cmp = icmp slt i32 %y, %x
  br i1 %cmp, label %while.cond.i, label %if.else

while.cond.i:                                     ; preds = %entry, %while.body.i
  %result.0.i = phi i32 [ %mul.i, %while.body.i ], [ 1, %entry ]
  %i.0.i = phi i32 [ %add.i, %while.body.i ], [ 0, %entry ]
  %exitcond.not.i = icmp eq i32 %i.0.i, 2
  br i1 %exitcond.not.i, label %power.exit, label %while.body.i

while.body.i:                                     ; preds = %while.cond.i
  %mul.i = mul i32 %result.0.i, %x
  %add.i = add i32 %i.0.i, 1
  %cmp1.i = icmp sgt i32 %mul.i, 1000
  br i1 %cmp1.i, label %power.exit, label %while.cond.i

power.exit:                                       ; preds = %while.cond.i, %while.body.i
  %retval.0.i = phi i32 [ %mul.i, %while.body.i ], [ %result.0.i, %while.cond.i ]
  br label %while.cond.i29

while.cond.i29:                                   ; preds = %while.body.i33, %power.exit
  %result.0.i26 = phi i32 [ 1, %power.exit ], [ %mul.i30, %while.body.i33 ]
  %i.0.i27 = phi i32 [ 0, %power.exit ], [ %add.i31, %while.body.i33 ]
  %exitcond.not.i28 = icmp eq i32 %i.0.i27, 2
  br i1 %exitcond.not.i28, label %power.exit35, label %while.body.i33

while.body.i33:                                   ; preds = %while.cond.i29
  %mul.i30 = mul i32 %result.0.i26, %y
  %add.i31 = add i32 %i.0.i27, 1
  %cmp1.i32 = icmp sgt i32 %mul.i30, 1000
  br i1 %cmp1.i32, label %power.exit35, label %while.cond.i29

power.exit35:                                     ; preds = %while.cond.i29, %while.body.i33
  %retval.0.i34 = phi i32 [ %mul.i30, %while.body.i33 ], [ %result.0.i26, %while.cond.i29 ]
  %sub = sub i32 %retval.0.i, %retval.0.i34
  br label %if.end7

if.else:                                          ; preds = %entry
  %cmp2 = icmp sgt i32 %y, %x
  br i1 %cmp2, label %if.then3, label %if.else6

if.then3:                                         ; preds = %if.else
  %sub4 = sub i32 %y, %x
  %call5 = call i32 @factorial(i32 %sub4)
  br label %if.end7

if.else6:                                         ; preds = %if.else
  %mul = mul i32 %y, %x
  %add = add i32 %mul, 10
  br label %if.end7

if.end7:                                          ; preds = %if.then3, %if.else6, %power.exit35
  %result.0 = phi i32 [ %sub, %power.exit35 ], [ %call5, %if.then3 ], [ %add, %if.else6 ]
  %cmp8.old = icmp sgt i32 %result.0, 10
  br i1 %cmp8.old, label %while.body.preheader, label %while.end

while.body.preheader:                             ; preds = %if.end7
  %0 = add i32 %result.0, 9
  %smin.cmp = icmp slt i32 %result.0, 20
  %smin = select i1 %smin.cmp, i32 %result.0, i32 20
  %1 = sub i32 %0, %smin
  %2 = urem i32 %1, 10
  %.neg = sub i32 %2, %1
  %3 = add i32 %result.0, -10
  %4 = add i32 %.neg, %3
  br label %while.end

while.end:                                        ; preds = %while.body.preheader, %if.end7
  %result.2 = phi i32 [ %result.0, %if.end7 ], [ %4, %while.body.preheader ]
  ret i32 %result.2
}

define void @nestedScopesTest() {
entry:
  %0 = load i32, i32* @globalCounter
  %add4 = add i32 %0, 9
  store i32 %add4, i32* @globalCounter
  ret void
}

define i32 @main() {
entry:
  %call = call i32 @fibonacci(i32 5)
  %call5.i = call i32 @factorial(i32 2)
  %cmp8.old.i = icmp sgt i32 %call5.i, 10
  br i1 %cmp8.old.i, label %while.body.preheader.i, label %complexCalculation.exit

while.body.preheader.i:                           ; preds = %entry
  %0 = add i32 %call5.i, 9
  %smin.cmp.i = icmp slt i32 %call5.i, 20
  %smin.i = select i1 %smin.cmp.i, i32 %call5.i, i32 20
  %1 = sub i32 %0, %smin.i
  %2 = urem i32 %1, 10
  %.neg.i = add i32 %call5.i, -10
  %3 = sub i32 %.neg.i, %1
  %4 = add i32 %3, %2
  br label %complexCalculation.exit

complexCalculation.exit:                          ; preds = %entry, %while.body.preheader.i
  %result.2.i = phi i32 [ %call5.i, %entry ], [ %4, %while.body.preheader.i ]
  %5 = load i32, i32* @globalCounter
  %add4.i = add i32 %5, 9
  store i32 %add4.i, i32* @globalCounter
  %add2 = add i32 %result.2.i, %call
  %add3 = add i32 %add2, %add4.i
  %add5 = add i32 %add3, 32
  %call6 = call i32 @factorial(i32 5)
  %add7 = add i32 %add5, %call6
  ret i32 %add7
}
