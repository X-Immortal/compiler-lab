; ModuleID = 'module'
source_filename = "module"

@globalVar = global i32 100
@GLOBAL_CONST = constant i32 1024

define i32 @complexFunction(i32 %param1, i32 %param2) {
entry:
  %cmp = icmp sgt i32 %param1, %param2
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %sub = sub i32 %param1, %param2
  br label %if.end10

if.else:                                          ; preds = %entry
  %cmp1 = icmp slt i32 %param1, %param2
  br i1 %cmp1, label %if.then2, label %if.else7

if.then2:                                         ; preds = %if.else
  %sub3 = sub i32 %param2, %param1
  %cmp4.old = icmp slt i32 %sub3, 1024
  br i1 %cmp4.old, label %while.body.preheader, label %if.end10

while.body.preheader:                             ; preds = %if.then2
  %0 = load i32, i32* @globalVar
  br label %while.body

while.body:                                       ; preds = %while.body.preheader, %while.body
  %localResult.0 = phi i32 [ %mul, %while.body ], [ %sub3, %while.body.preheader ]
  %mul = shl i32 %localResult.0, 1
  %cmp5 = icmp sle i32 %mul, %0
  %cmp4 = icmp slt i32 %localResult.0, 512
  %or.cond = and i1 %cmp4, %cmp5
  br i1 %or.cond, label %while.body, label %if.end10

if.else7:                                         ; preds = %if.else
  %mul8 = mul i32 %param2, %param1
  br label %if.end10

if.end10:                                         ; preds = %while.body, %if.else7, %if.then2, %if.then
  %localResult.1 = phi i32 [ %sub, %if.then ], [ %sub3, %if.then2 ], [ %mul8, %if.else7 ], [ %mul, %while.body ]
  ret i32 %localResult.1
}

define void @nestedBlocks() {
entry:
  ret void
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

define i32 @mixedOperations(i32 %a, i32 %b) {
entry:
  %add = add i32 %b, %a
  %sub = sub i32 %a, %b
  %mul = mul i32 %add, %sub
  %rem = srem i32 %mul, 1024
  %add1 = add i32 %b, 1
  %div = sdiv i32 %rem, %add1
  ret i32 %div
}

define i32 @main() {
entry:
  %0 = load i32, i32* @globalVar
  %cmp.i = icmp sgt i32 %0, 42
  br i1 %cmp.i, label %if.then.i, label %if.else.i

if.then.i:                                        ; preds = %entry
  %sub.i = add i32 %0, -42
  br label %complexFunction.exit

if.else.i:                                        ; preds = %entry
  %cmp1.i.not = icmp eq i32 %0, 42
  br i1 %cmp1.i.not, label %if.else7.i, label %if.then2.i

if.then2.i:                                       ; preds = %if.else.i
  %sub3.i = sub i32 42, %0
  %cmp4.old.i = icmp sgt i32 %0, -982
  br i1 %cmp4.old.i, label %while.body.i, label %complexFunction.exit

while.body.i:                                     ; preds = %if.then2.i, %while.body.i
  %localResult.0.i = phi i32 [ %mul.i, %while.body.i ], [ %sub3.i, %if.then2.i ]
  %mul.i = shl i32 %localResult.0.i, 1
  %cmp5.i = icmp sle i32 %mul.i, %0
  %cmp4.i = icmp slt i32 %localResult.0.i, 512
  %or.cond.i = and i1 %cmp4.i, %cmp5.i
  br i1 %or.cond.i, label %while.body.i, label %complexFunction.exit

if.else7.i:                                       ; preds = %if.else.i
  %mul8.i = mul i32 %0, 42
  br label %complexFunction.exit

complexFunction.exit:                             ; preds = %while.body.i, %if.then.i, %if.then2.i, %if.else7.i
  %localResult.1.i = phi i32 [ %sub.i, %if.then.i ], [ %sub3.i, %if.then2.i ], [ %mul8.i, %if.else7.i ], [ %mul.i, %while.body.i ]
  br label %while.body

while.body:                                       ; preds = %while.body.backedge, %complexFunction.exit
  %result2.1 = phi i32 [ 0, %complexFunction.exit ], [ %add, %while.body.backedge ]
  %counter.1 = phi i32 [ 0, %complexFunction.exit ], [ %counter.1.be, %while.body.backedge ]
  %add.i = add i32 %counter.1, %localResult.1.i
  %sub.i32 = sub i32 %localResult.1.i, %counter.1
  %mul.i33 = mul i32 %add.i, %sub.i32
  %rem.i = srem i32 %mul.i33, 1024
  %add1.i = add i32 %counter.1, 1
  %div.i = sdiv i32 %rem.i, %add1.i
  %add = add i32 %div.i, %result2.1
  %cmp3 = icmp eq i32 %add1.i, 3
  br i1 %cmp3, label %while.body.backedge, label %if.end

if.end:                                           ; preds = %while.body
  %cmp4 = icmp slt i32 %add, 1001
  %cmp = icmp ult i32 %counter.1, 4
  %or.cond15 = and i1 %cmp, %cmp4
  br i1 %or.cond15, label %while.body.backedge, label %while.end

while.body.backedge:                              ; preds = %if.end, %while.body
  %counter.1.be = phi i32 [ %add1.i, %if.end ], [ 3, %while.body ]
  br label %while.body

while.end:                                        ; preds = %if.end
  %rem = srem i32 %add, 6
  %call7 = call i32 @factorial(i32 %rem)
  %cmp8 = icmp sgt i32 %call7, 10
  %cmp9 = icmp slt i32 %localResult.1.i, 200
  %or.cond = select i1 %cmp8, i1 %cmp9, i1 false
  %cmp10 = icmp eq i32 %add, 0
  %or.cond14 = select i1 %or.cond, i1 true, i1 %cmp10
  %.pn = select i1 %or.cond14, i32 %0, i32 -1024
  %finalResult.0 = add i32 %.pn, %call7
  ret i32 %finalResult.0
}

