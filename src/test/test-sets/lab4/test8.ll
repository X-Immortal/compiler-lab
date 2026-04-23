; ModuleID = 'module'
source_filename = "module"

define i32 @factorial(i32 %n) {
entry:
  %smax.cmp = icmp sgt i32 %n, 0
  %smax = select i1 %smax.cmp, i32 %n, i32 0
  %0 = add i32 %smax, 1
  br label %while.cond

while.cond:                                       ; preds = %while.body, %entry
  %result.0 = phi i32 [ 1, %entry ], [ %mul, %while.body ]
  %i.0 = phi i32 [ 1, %entry ], [ %add, %while.body ]
  %exitcond = icmp eq i32 %i.0, %0
  br i1 %exitcond, label %while.end, label %while.body

while.body:                                       ; preds = %while.cond
  %mul = mul i32 %i.0, %result.0
  %add = add i32 %i.0, 1
  %exitcond8 = icmp eq i32 %add, 11
  br i1 %exitcond8, label %while.end, label %while.cond

while.end:                                        ; preds = %while.body, %while.cond
  %result.1 = phi i32 [ %mul, %while.body ], [ %result.0, %while.cond ]
  ret i32 %result.1
}

define i32 @main() {
entry:
  br label %while.body

while.body:                                       ; preds = %entry, %factorial.exit
  %j.09 = phi i32 [ 0, %entry ], [ %0, %factorial.exit ]
  %sum.08 = phi i32 [ 0, %entry ], [ %add, %factorial.exit ]
  %0 = add i32 %j.09, 1
  %exitcond.i10 = icmp eq i32 %j.09, 0
  br i1 %exitcond.i10, label %factorial.exit, label %while.body.i

while.body.i:                                     ; preds = %while.body, %while.body.i
  %i.0.i12 = phi i32 [ %add.i, %while.body.i ], [ 1, %while.body ]
  %result.0.i11 = phi i32 [ %mul.i, %while.body.i ], [ 1, %while.body ]
  %mul.i = mul i32 %i.0.i12, %result.0.i11
  %add.i = add i32 %i.0.i12, 1
  %exitcond.i = icmp eq i32 %i.0.i12, %j.09
  br i1 %exitcond.i, label %factorial.exit, label %while.body.i

factorial.exit:                                   ; preds = %while.body.i, %while.body
  %result.0.i.lcssa = phi i32 [ 1, %while.body ], [ %mul.i, %while.body.i ]
  %add = add i32 %result.0.i.lcssa, %sum.08
  %exitcond.not = icmp eq i32 %0, 5
  br i1 %exitcond.not, label %while.end, label %while.body

while.end:                                        ; preds = %factorial.exit
  ret i32 %add
}
