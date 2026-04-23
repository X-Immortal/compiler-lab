; ModuleID = 'module'
source_filename = "module"

define i32 @main() {
entry:
  br label %while.cond1.preheader

while.cond1.preheader:                            ; preds = %entry, %while.end
  %result.043 = phi i32 [ 0, %entry ], [ %result.1.ph.lcssa, %while.end ]
  %i.040 = phi i32 [ 0, %entry ], [ %add10, %while.end ]
  %0 = icmp ugt i32 %i.040, 4
  br i1 %0, label %while.end, label %if.end.lr.ph

if.end.lr.ph:                                     ; preds = %while.cond1.preheader, %if.end7
  %result.1.ph38 = phi i32 [ %add8, %if.end7 ], [ %result.043, %while.cond1.preheader ]
  %j.0.ph37 = phi i32 [ %add9, %if.end7 ], [ %i.040, %while.cond1.preheader ]
  %smax.cmp = icmp sgt i32 %j.0.ph37, 4
  %smax = select i1 %smax.cmp, i32 %j.0.ph37, i32 4
  br label %if.end

if.end:                                           ; preds = %if.end.lr.ph, %if.then6
  %j.035 = phi i32 [ %j.0.ph37, %if.end.lr.ph ], [ %add, %if.then6 ]
  %1 = and i32 %j.035, 1
  %cmp5 = icmp eq i32 %1, 0
  br i1 %cmp5, label %if.then6, label %if.end7

if.then6:                                         ; preds = %if.end
  %add = add i32 %j.035, 1
  %exitcond = icmp eq i32 %j.035, %smax
  br i1 %exitcond, label %while.end, label %if.end

if.end7:                                          ; preds = %if.end
  %add8 = add i32 %result.1.ph38, 1
  %add9 = add i32 %j.035, 1
  %2 = icmp sgt i32 %j.035, 3
  br i1 %2, label %while.end, label %if.end.lr.ph

while.end:                                        ; preds = %if.end7, %if.then6, %while.cond1.preheader
  %result.1.ph.lcssa = phi i32 [ %result.043, %while.cond1.preheader ], [ %result.1.ph38, %if.then6 ], [ %add8, %if.end7 ]
  %add10 = add i32 %i.040, 1
  %exitcond47.not = icmp eq i32 %add10, 6
  br i1 %exitcond47.not, label %cleanup, label %while.cond1.preheader

cleanup:                                          ; preds = %while.end
  ret i32 %result.1.ph.lcssa
}
