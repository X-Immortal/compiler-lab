; ModuleID = 'test5.c'
source_filename = "test5.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@BASE = dso_local local_unnamed_addr constant i32 10, align 4
@globalCounter = dso_local local_unnamed_addr global i32 0, align 4

; Function Attrs: nofree norecurse nosync nounwind readnone uwtable
define dso_local i32 @power(i32 noundef %base, i32 noundef %exponent) local_unnamed_addr #0 {
entry:
  %smax = call i32 @llvm.smax.i32(i32 %exponent, i32 0)
  br label %while.cond

while.cond:                                       ; preds = %while.body, %entry
  %result.0 = phi i32 [ 1, %entry ], [ %mul, %while.body ]
  %i.0 = phi i32 [ 0, %entry ], [ %add, %while.body ]
  %exitcond.not = icmp eq i32 %i.0, %smax
  br i1 %exitcond.not, label %cleanup, label %while.body

while.body:                                       ; preds = %while.cond
  %mul = mul nsw i32 %result.0, %base
  %add = add nuw i32 %i.0, 1
  %cmp1 = icmp sgt i32 %mul, 1000
  br i1 %cmp1, label %cleanup, label %while.cond, !llvm.loop !5

cleanup:                                          ; preds = %while.cond, %while.body
  %retval.0 = phi i32 [ %mul, %while.body ], [ %result.0, %while.cond ]
  ret i32 %retval.0
}

; Function Attrs: nofree nosync nounwind readnone uwtable
define dso_local i32 @factorial(i32 noundef %n) local_unnamed_addr #1 {
entry:
  %cmp = icmp slt i32 %n, 2
  br i1 %cmp, label %return, label %if.end

if.end:                                           ; preds = %entry
  %sub = add nsw i32 %n, -1
  %call = call i32 @factorial(i32 noundef %sub)
  %mul = mul nsw i32 %call, %n
  br label %return

return:                                           ; preds = %entry, %if.end
  %retval.0 = phi i32 [ %mul, %if.end ], [ 1, %entry ]
  ret i32 %retval.0
}

; Function Attrs: nofree nosync nounwind uwtable
define dso_local i32 @fibonacci(i32 noundef %n) local_unnamed_addr #2 {
entry:
  %0 = load i32, i32* @globalCounter, align 4, !tbaa !8
  %add = add nsw i32 %0, 1
  store i32 %add, i32* @globalCounter, align 4, !tbaa !8
  %cmp = icmp slt i32 %n, 2
  br i1 %cmp, label %return, label %if.end

if.end:                                           ; preds = %entry
  %sub = add nsw i32 %n, -1
  %call = call i32 @fibonacci(i32 noundef %sub)
  %sub1 = add nsw i32 %n, -2
  %call2 = call i32 @fibonacci(i32 noundef %sub1)
  %add3 = add nsw i32 %call2, %call
  br label %return

return:                                           ; preds = %entry, %if.end
  %retval.0 = phi i32 [ %add3, %if.end ], [ %n, %entry ]
  ret i32 %retval.0
}

; Function Attrs: nofree nosync nounwind readnone uwtable
define dso_local i32 @complexCalculation(i32 noundef %x, i32 noundef %y) local_unnamed_addr #1 {
entry:
  %cmp = icmp slt i32 %y, %x
  br i1 %cmp, label %while.cond.i, label %if.else

while.cond.i:                                     ; preds = %entry, %while.body.i
  %result.0.i = phi i32 [ %mul.i, %while.body.i ], [ 1, %entry ]
  %i.0.i = phi i32 [ %add.i, %while.body.i ], [ 0, %entry ]
  %exitcond.not.i = icmp eq i32 %i.0.i, 2
  br i1 %exitcond.not.i, label %power.exit, label %while.body.i

while.body.i:                                     ; preds = %while.cond.i
  %mul.i = mul nsw i32 %result.0.i, %x
  %add.i = add nuw nsw i32 %i.0.i, 1
  %cmp1.i = icmp sgt i32 %mul.i, 1000
  br i1 %cmp1.i, label %power.exit, label %while.cond.i, !llvm.loop !5

power.exit:                                       ; preds = %while.cond.i, %while.body.i
  %retval.0.i = phi i32 [ %mul.i, %while.body.i ], [ %result.0.i, %while.cond.i ]
  br label %while.cond.i29

while.cond.i29:                                   ; preds = %while.body.i33, %power.exit
  %result.0.i26 = phi i32 [ 1, %power.exit ], [ %mul.i30, %while.body.i33 ]
  %i.0.i27 = phi i32 [ 0, %power.exit ], [ %add.i31, %while.body.i33 ]
  %exitcond.not.i28 = icmp eq i32 %i.0.i27, 2
  br i1 %exitcond.not.i28, label %power.exit35, label %while.body.i33

while.body.i33:                                   ; preds = %while.cond.i29
  %mul.i30 = mul nsw i32 %result.0.i26, %y
  %add.i31 = add nuw nsw i32 %i.0.i27, 1
  %cmp1.i32 = icmp sgt i32 %mul.i30, 1000
  br i1 %cmp1.i32, label %power.exit35, label %while.cond.i29, !llvm.loop !5

power.exit35:                                     ; preds = %while.cond.i29, %while.body.i33
  %retval.0.i34 = phi i32 [ %mul.i30, %while.body.i33 ], [ %result.0.i26, %while.cond.i29 ]
  %sub = sub nsw i32 %retval.0.i, %retval.0.i34
  br label %if.end7

if.else:                                          ; preds = %entry
  %cmp2 = icmp sgt i32 %y, %x
  br i1 %cmp2, label %if.then3, label %if.else6

if.then3:                                         ; preds = %if.else
  %sub4 = sub nsw i32 %y, %x
  %call5 = call i32 @factorial(i32 noundef %sub4)
  br label %if.end7

if.else6:                                         ; preds = %if.else
  %mul = mul nsw i32 %y, %x
  %add = add nsw i32 %mul, 10
  br label %if.end7

if.end7:                                          ; preds = %if.then3, %if.else6, %power.exit35
  %result.0 = phi i32 [ %sub, %power.exit35 ], [ %call5, %if.then3 ], [ %add, %if.else6 ]
  %cmp8.old = icmp sgt i32 %result.0, 10
  br i1 %cmp8.old, label %while.body.preheader, label %while.end

while.body.preheader:                             ; preds = %if.end7
  %0 = add i32 %result.0, 9
  %smin = call i32 @llvm.smin.i32(i32 %result.0, i32 20)
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

; Function Attrs: mustprogress nofree norecurse nosync nounwind uwtable willreturn
define dso_local void @nestedScopesTest() local_unnamed_addr #3 {
entry:
  %0 = load i32, i32* @globalCounter, align 4, !tbaa !8
  %add4 = add nsw i32 %0, 9
  store i32 %add4, i32* @globalCounter, align 4, !tbaa !8
  ret void
}

; Function Attrs: nofree nosync nounwind uwtable
define dso_local i32 @main() local_unnamed_addr #2 {
entry:
  %call = call i32 @fibonacci(i32 noundef 5)
  %call5.i = call i32 @factorial(i32 noundef 2) #5
  %cmp8.old.i = icmp sgt i32 %call5.i, 10
  br i1 %cmp8.old.i, label %while.body.preheader.i, label %complexCalculation.exit

while.body.preheader.i:                           ; preds = %entry
  %0 = add i32 %call5.i, 9
  %smin.i = call i32 @llvm.smin.i32(i32 %call5.i, i32 20) #5
  %1 = sub i32 %0, %smin.i
  %2 = urem i32 %1, 10
  %.neg.i = add i32 %call5.i, -10
  %3 = sub i32 %.neg.i, %1
  %4 = add i32 %3, %2
  br label %complexCalculation.exit

complexCalculation.exit:                          ; preds = %entry, %while.body.preheader.i
  %result.2.i = phi i32 [ %call5.i, %entry ], [ %4, %while.body.preheader.i ]
  %5 = load i32, i32* @globalCounter, align 4, !tbaa !8
  %add4.i = add nsw i32 %5, 9
  store i32 %add4.i, i32* @globalCounter, align 4, !tbaa !8
  %add2 = add nsw i32 %result.2.i, %call
  %add3 = add nsw i32 %add2, %add4.i
  %add5 = add nsw i32 %add3, 32
  %call6 = call i32 @factorial(i32 noundef 5)
  %add7 = add nsw i32 %add5, %call6
  ret i32 %add7
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare i32 @llvm.smax.i32(i32, i32) #4

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare i32 @llvm.smin.i32(i32, i32) #4

attributes #0 = { nofree norecurse nosync nounwind readnone uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nofree nosync nounwind uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { mustprogress nofree norecurse nosync nounwind uwtable willreturn "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #5 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{!"Ubuntu clang version 14.0.0-1ubuntu1.1"}
!5 = distinct !{!5, !6, !7}
!6 = !{!"llvm.loop.mustprogress"}
!7 = !{!"llvm.loop.unroll.disable"}
!8 = !{!9, !9, i64 0}
!9 = !{!"int", !10, i64 0}
!10 = !{!"omnipotent char", !11, i64 0}
!11 = !{!"Simple C/C++ TBAA"}
